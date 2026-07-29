using System;
using System.Data;
using System.Web.UI;
using AfterSchoolAdmission.DAL;

namespace AfterSchoolAdmission
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlAlert.Visible = false;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                ShowError("Please enter both username and password.");
                return;
            }

            AdminDAL dal = new AdminDAL();
            DataTable dt = dal.ValidateAdmin(username, password);

            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                Session["AdminID"] = dr["AdminID"];
                Session["Username"] = dr["Username"];
                Session["FullName"] = dr["FullName"];
                Session["Email"] = dr["Email"];

                Response.Redirect("Dashboard.aspx");
            }
            else
            {
                ShowError("Invalid username or password. Please try again.");
            }
        }

        private void ShowError(string message)
        {
            litAlertMsg.Text = message;
            pnlAlert.Visible = true;
        }
    }
}
