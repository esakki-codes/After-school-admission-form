using System;
using System.Web.UI;

namespace AfterSchoolAdmission
{
    public partial class PublicReceipt : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                litDate.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm");
                LoadReceiptData();
            }
        }

        private void LoadReceiptData()
        {
            // Extract exact submitted user form values
            litStudentName.Text = GetQueryValue("txtFullName", "sName", "-");
            litAdmissionNo.Text = GetQueryValue("admNo", "rec", "ADM-" + DateTime.Now.Year + "-" + new Random().Next(1000, 9999));

            litGender.Text = GetQueryValue("ddlGender", "gender", "-");
            litStandard.Text = GetQueryValue("txtStandard", "std", "-");
            litSchoolName.Text = GetQueryValue("txtSchoolName", "school", "-");
            litRouteComingFrom.Text = GetQueryValue("txtComingFrom", "route", "-");

            litFatherName.Text = GetQueryValue("txtFatherName", "fName", "-");
            litFatherAadhaar.Text = GetQueryValue("txtFatherAadhaar", "fAadhaar", "-");
            litFatherMobile.Text = GetQueryValue("txtFatherMobile", "fMobile", "-");

            litMotherName.Text = GetQueryValue("txtMotherName", "mName", "-");
            litMotherAadhaar.Text = GetQueryValue("txtMotherAadhaar", "mAadhaar", "-");
            litMotherMobile.Text = GetQueryValue("txtMotherMobile", "mMobile", "-");

            litGuardian1Name.Text = GetQueryValue("txtGuardian1Name", "g1Name", "-");
            litGuardian1Rel.Text = GetQueryValue("txtGuardian1Rel", "g1Rel", "-");
            litGuardian1Mobile.Text = GetQueryValue("txtGuardian1Mobile", "g1Mobile", "-");

            litGuardian2Name.Text = GetQueryValue("txtGuardian2Name", "g2Name", "-");
            litGuardian2Rel.Text = GetQueryValue("txtGuardian2Rel", "g2Rel", "-");
            litGuardian2Mobile.Text = GetQueryValue("txtGuardian2Mobile", "g2Mobile", "-");
        }

        private string GetQueryValue(string primaryKey, string secondaryKey, string fallback)
        {
            string val = Request.QueryString[primaryKey];
            if (string.IsNullOrEmpty(val))
            {
                val = Request.QueryString[secondaryKey];
            }

            if (!string.IsNullOrEmpty(val) && val.Trim() != "")
            {
                return val.Trim();
            }

            return fallback;
        }
    }
}
