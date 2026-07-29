using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using AfterSchoolAdmission.DAL;

namespace AfterSchoolAdmission
{
    public partial class MarkAttendance : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtAttendanceDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                LoadRoster();
            }
        }

        private void LoadRoster()
        {
            try
            {
                DateTime attDate = Convert.ToDateTime(txtAttendanceDate.Text);
                string program = ddlProgramFilter.SelectedValue;

                AttendanceDAL dal = new AttendanceDAL();
                DataTable dt = dal.GetDailyAttendanceSheet(attDate, program);

                gvAttendance.DataSource = dt;
                gvAttendance.DataBind();
            }
            catch (Exception ex)
            {
                litAlertMsg.Text = "Error loading roster: " + ex.Message;
                pnlAlert.CssClass = "alert alert-danger";
                pnlAlert.Visible = true;
            }
        }

        protected void txtAttendanceDate_TextChanged(object sender, EventArgs e)
        {
            LoadRoster();
        }

        protected void ddlProgramFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadRoster();
        }

        protected void btnSaveAttendance_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime attDate = Convert.ToDateTime(txtAttendanceDate.Text);
                AttendanceDAL dal = new AttendanceDAL();
                int updatedCount = 0;

                foreach (GridViewRow row in gvAttendance.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        int studentId = Convert.ToInt32(gvAttendance.DataKeys[row.RowIndex].Value);

                        RadioButton rbAbsent = (RadioButton)row.FindControl("rbAbsent");
                        RadioButton rbLate = (RadioButton)row.FindControl("rbLate");
                        TextBox txtRemarks = (TextBox)row.FindControl("txtRemarks");

                        string status = "Present";
                        if (rbAbsent != null && rbAbsent.Checked) status = "Absent";
                        else if (rbLate != null && rbLate.Checked) status = "Late";

                        string remarks = txtRemarks != null ? txtRemarks.Text.Trim() : "";

                        bool saved = dal.MarkAttendance(studentId, attDate, status, remarks);
                        if (saved) updatedCount++;
                    }
                }

                pnlAlert.CssClass = "alert alert-success";
                litAlertMsg.Text = "Attendance saved successfully for <strong>" + updatedCount + "</strong> students on " + attDate.ToString("yyyy-MM-dd") + "!";
                pnlAlert.Visible = true;

                LoadRoster();
            }
            catch (Exception ex)
            {
                pnlAlert.CssClass = "alert alert-danger";
                litAlertMsg.Text = "Error saving attendance: " + ex.Message;
                pnlAlert.Visible = true;
            }
        }
    }
}
