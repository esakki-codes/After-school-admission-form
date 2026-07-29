using System;
using System.Web.UI;
using AfterSchoolAdmission.DAL;

namespace AfterSchoolAdmission
{
    public partial class ForgotPassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string answer = txtSecurityAnswer.Text.Trim();
            string newPassword = txtNewPassword.Text.Trim();

            AdminDAL dal = new AdminDAL();
            bool result = dal.ResetPassword(username, answer, newPassword);

            if (result)
            {
                pnlAlert.Visible = false;
                litSuccessMsg.Text = "Password reset successfully! Redirecting to login...";
                pnlSuccess.Visible = true;
                Response.AddHeader("REFRESH", "2;URL=Login.aspx");
            }
            else
            {
                pnlSuccess.Visible = false;
                litAlertMsg.Text = "Incorrect security answer or username.";
                pnlAlert.Visible = true;
            }
        }
    }
}
