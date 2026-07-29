using System;
using System.Web.UI;
using AfterSchoolAdmission.DAL;

namespace AfterSchoolAdmission
{
    public partial class ChangePassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (Session["AdminID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int adminId = Convert.ToInt32(Session["AdminID"]);
            string oldPass = txtOldPassword.Text.Trim();
            string newPass = txtNewPassword.Text.Trim();
            string confirmPass = txtConfirmPassword.Text.Trim();

            if (newPass != confirmPass)
            {
                pnlSuccess.Visible = false;
                litAlertMsg.Text = "New password and confirmation password do not match.";
                pnlAlert.Visible = true;
                return;
            }

            AdminDAL dal = new AdminDAL();
            bool result = dal.ChangePassword(adminId, oldPass, newPass);

            if (result)
            {
                pnlAlert.Visible = false;
                litSuccessMsg.Text = "Your password has been changed successfully!";
                pnlSuccess.Visible = true;
            }
            else
            {
                pnlSuccess.Visible = false;
                litAlertMsg.Text = "Current password is incorrect.";
                pnlAlert.Visible = true;
            }
        }
    }
}
