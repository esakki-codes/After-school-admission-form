using System;
using System.Data;
using System.Web.UI;
using AfterSchoolAdmission.DAL;

namespace AfterSchoolAdmission
{
    public partial class FeeHistory : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadHistory();
            }
        }

        private void LoadHistory()
        {
            try
            {
                string search = txtSearch.Text.Trim();
                string status = ddlStatus.SelectedValue;
                string method = ddlMethod.SelectedValue;

                FeeDAL dal = new FeeDAL();
                DataTable dt = dal.GetFeeHistory(search, status, method);

                gvHistory.DataSource = dt;
                gvHistory.DataBind();
            }
            catch (Exception)
            {
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadHistory();
        }
    }
}
