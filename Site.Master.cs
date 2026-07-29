using System;
using System.Web.UI;

namespace AfterSchoolAdmission
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["AdminID"] == null)
                {
                    // Redirect unauthenticated requests to Login
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    string fullName = Session["FullName"] != null ? Session["FullName"].ToString() : "Admin";
                    litAdminName.Text = fullName;
                    litUserInitial.Text = !string.IsNullOrEmpty(fullName) ? fullName.Substring(0, 1).ToUpper() : "A";
                }
            }
        }
    }
}
