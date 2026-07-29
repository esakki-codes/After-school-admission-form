using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using AfterSchoolAdmission.DAL;

namespace AfterSchoolAdmission
{
    public partial class FeePayment : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtFeeMonth.Text = DateTime.Now.ToString("MMMM yyyy");
                txtReceiptNo.Text = "REC-" + DateTime.Now.Year + "-" + new Random().Next(10000, 99999);
                LoadStudentDropdown();

                if (Request.QueryString["studentId"] != null)
                {
                    string sId = Request.QueryString["studentId"];
                    if (ddlStudent.Items.FindByValue(sId) != null)
                    {
                        ddlStudent.SelectedValue = sId;
                    }
                }
            }
        }

        private void LoadStudentDropdown()
        {
            try
            {
                StudentDAL dal = new StudentDAL();
                DataTable dt = dal.SearchStudents();

                ddlStudent.DataSource = dt;
                ddlStudent.DataTextField = "FullName";
                ddlStudent.DataValueField = "StudentID";
                ddlStudent.DataBind();

                ddlStudent.Items.Insert(0, new ListItem("-- Select Active Student --", ""));
            }
            catch (Exception)
            {
            }
        }

        protected void ddlStudent_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void btnSubmitPayment_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(ddlStudent.SelectedValue))
                {
                    litAlertMsg.Text = "Please select a student.";
                    pnlAlert.Visible = true;
                    return;
                }

                int studentId = Convert.ToInt32(ddlStudent.SelectedValue);
                decimal amountPaid = Convert.ToDecimal(txtAmountPaid.Text.Trim());
                string method = ddlPaymentMethod.SelectedValue;
                string month = txtFeeMonth.Text.Trim();

                FeeDAL dal = new FeeDAL();
                string generatedReceipt;
                bool success = dal.RecordPayment(studentId, amountPaid, method, month, out generatedReceipt);

                if (success || !string.IsNullOrEmpty(generatedReceipt))
                {
                    Response.Redirect("FeeReceipt.aspx?rec=" + (string.IsNullOrEmpty(generatedReceipt) ? txtReceiptNo.Text : generatedReceipt));
                }
            }
            catch (Exception ex)
            {
                litAlertMsg.Text = "Error recording payment: " + ex.Message;
                pnlAlert.Visible = true;
            }
        }
    }
}
