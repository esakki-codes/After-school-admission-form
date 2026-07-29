using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using AfterSchoolAdmission.DAL;

namespace AfterSchoolAdmission
{
    public partial class StudentList : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindStudentGrid();
            }
        }

        private void BindStudentGrid()
        {
            try
            {
                string search = txtSearch.Text.Trim();
                string program = ddlProgramFilter.SelectedValue;
                string standard = txtStandardFilter.Text.Trim();
                DateTime? fromDate = string.IsNullOrEmpty(txtFromDate.Text) ? (DateTime?)null : Convert.ToDateTime(txtFromDate.Text);
                DateTime? toDate = string.IsNullOrEmpty(txtToDate.Text) ? (DateTime?)null : Convert.ToDateTime(txtToDate.Text);

                StudentDAL dal = new StudentDAL();
                DataTable dt = dal.SearchStudents(search, program, standard, fromDate, toDate);

                gvStudents.DataSource = dt;
                gvStudents.DataBind();
            }
            catch (Exception ex)
            {
                litAlertMsg.Text = "Error loading students: " + ex.Message;
                pnlAlert.Visible = true;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvStudents.PageIndex = 0;
            BindStudentGrid();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlProgramFilter.SelectedIndex = 0;
            txtStandardFilter.Text = "";
            txtFromDate.Text = "";
            txtToDate.Text = "";
            gvStudents.PageIndex = 0;
            BindStudentGrid();
        }

        protected void gvStudents_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvStudents.PageIndex = e.NewPageIndex;
            BindStudentGrid();
        }

        protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteStudent")
            {
                int studentId = Convert.ToInt32(e.CommandArgument);
                StudentDAL dal = new StudentDAL();
                bool deleted = dal.DeleteStudent(studentId);

                if (deleted)
                {
                    litAlertMsg.Text = "Student record deleted successfully.";
                    pnlAlert.Visible = true;
                    BindStudentGrid();
                }
            }
        }
    }
}
