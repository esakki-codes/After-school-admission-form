using System;
using System.Web.UI;

namespace AfterSchoolAdmission
{
    public partial class PublicSiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Public page does not require session checks
        }
    }
}
