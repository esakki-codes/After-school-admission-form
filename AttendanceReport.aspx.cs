using System;
using System.Data;
using System.Web.UI;
using AfterSchoolAdmission.DAL;

namespace AfterSchoolAdmission
{
    public partial class AttendanceReport : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlMonth.SelectedValue = DateTime.Now.Month.ToString();
                ddlYear.SelectedValue = DateTime.Now.Year.ToString();
                LoadReport();
            }
        }

        private void LoadReport()
        {
            try
            {
                int month = Convert.ToInt32(ddlMonth.SelectedValue);
                int year = Convert.ToInt32(ddlYear.SelectedValue);
                string program = ddlProgram.SelectedValue;

                litPeriod.Text = ddlMonth.SelectedItem.Text + " " + year;

                AttendanceDAL dal = new AttendanceDAL();
                DataTable dt = dal.GetMonthlyAttendanceReport(month, year, program);

                gvAttendanceReport.DataSource = dt;
                gvAttendanceReport.DataBind();
            }
            catch (Exception)
            {
                // Fallback mock handling
            }
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            LoadReport();
        }
    }
}
