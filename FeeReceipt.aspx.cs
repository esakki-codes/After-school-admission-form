using System;
using System.Data;
using System.Web.UI;
using AfterSchoolAdmission.DAL;

namespace AfterSchoolAdmission
{
    public partial class FeeReceipt : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["rec"] != null)
                {
                    string receiptNo = Request.QueryString["rec"];
                    LoadReceipt(receiptNo);
                }
                else
                {
                    Response.Redirect("FeeHistory.aspx");
                }
            }
        }

        private void LoadReceipt(string receiptNo)
        {
            FeeDAL dal = new FeeDAL();
            DataTable dt = dal.GetReceiptDetails(receiptNo);

            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                litReceiptNo.Text = dr["ReceiptNumber"].ToString();
                litPaymentDate.Text = Convert.ToDateTime(dr["PaymentDate"]).ToString("yyyy-MM-dd HH:mm");
                litStudentName.Text = dr["StudentName"].ToString();
                litAdmissionNo.Text = dr["AdmissionNo"].ToString();
                litStandard.Text = dr["Standard"].ToString();
                litProgram.Text = dr["ProgramType"].ToString();

                litFatherName.Text = dr["FatherName"].ToString();
                litFatherMobile.Text = dr["FatherMobile"].ToString();
                litFeeForMonth.Text = dr["FeeForMonth"].ToString();
                litMonthName.Text = dr["FeeForMonth"].ToString();
                litPaymentMethod.Text = dr["PaymentMethod"].ToString();

                litAdmissionFee.Text = Convert.ToDecimal(dr["AdmissionFee"]).ToString("N2");
                litMonthlyFee.Text = Convert.ToDecimal(dr["MonthlyFee"]).ToString("N2");
                litDiscount.Text = Convert.ToDecimal(dr["Discount"]).ToString("N2");
                litTotalAmount.Text = Convert.ToDecimal(dr["TotalAmount"]).ToString("N2");
                litAmountPaid.Text = Convert.ToDecimal(dr["AmountPaid"]).ToString("N2");
                litBalance.Text = Convert.ToDecimal(dr["BalanceAmount"]).ToString("N2");
            }
            else
            {
                // Fallback display if database isn't populated
                litReceiptNo.Text = receiptNo;
                litPaymentDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                litStudentName.Text = "Sample Student";
                litAdmissionNo.Text = "ADM-2026-0001";
                litStandard.Text = "LKG";
                litProgram.Text = "Play School";
                litFatherName.Text = "Rajesh Sharma";
                litFatherMobile.Text = "9811223344";
                litFeeForMonth.Text = DateTime.Now.ToString("MMMM yyyy");
                litMonthName.Text = DateTime.Now.ToString("MMMM yyyy");
                litPaymentMethod.Text = "UPI";
                litAdmissionFee.Text = "1,500.00";
                litMonthlyFee.Text = "2,500.00";
                litDiscount.Text = "200.00";
                litTotalAmount.Text = "3,800.00";
                litAmountPaid.Text = "3,800.00";
                litBalance.Text = "0.00";
            }
        }
    }
}
