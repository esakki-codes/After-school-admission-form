using System;
using System.Data;
using System.Web.UI;
using AfterSchoolAdmission.DAL;

namespace AfterSchoolAdmission
{
    public partial class PendingFees : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPending();
            }
        }

        private void LoadPending()
        {
            try
            {
                FeeDAL dal = new FeeDAL();
                DataTable dt = dal.GetPendingFees();

                gvPending.DataSource = dt;
                gvPending.DataBind();
            }
            catch (Exception)
            {
            }
        }
    }
}
