using System;
using System.Data;
using System.Web.UI;
using AfterSchoolAdmission.DAL;

namespace AfterSchoolAdmission
{
    public partial class StudentProfile : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int studentId = Convert.ToInt32(Request.QueryString["id"]);
                    LoadProfile(studentId);
                }
                else
                {
                    Response.Redirect("StudentList.aspx");
                }
            }
        }

        private void LoadProfile(int studentId)
        {
            StudentDAL dal = new StudentDAL();
            DataTable dt = dal.GetStudentDetails(studentId);

            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];

                imgStudentPhoto.ImageUrl = dr["PhotoPath"].ToString();
                litFullName.Text = dr["FullName"].ToString();
                litAdmissionNo.Text = dr["AdmissionNo"].ToString();
                litStandard.Text = dr["Standard"].ToString();
                litProgramType.Text = dr["ProgramType"].ToString();
                litAcademicYear.Text = dr["AcademicYear"].ToString();
                litSchoolName.Text = dr["SchoolName"].ToString();
                litDOB.Text = Convert.ToDateTime(dr["DateOfBirth"]).ToString("yyyy-MM-dd");
                litBloodGroup.Text = dr["BloodGroup"].ToString();
                litAddress.Text = dr["Address"].ToString();

                // Father
                litFatherName.Text = dr["FatherName"].ToString();
                litFatherMobile.Text = dr["FatherMobile"].ToString();
                litFatherWhatsApp.Text = dr["FatherWhatsApp"].ToString();
                litFatherEmail.Text = dr["FatherEmail"].ToString();
                litFatherOccupation.Text = dr["FatherOccupation"].ToString();

                // Mother
                litMotherName.Text = dr["MotherName"].ToString();
                litMotherMobile.Text = dr["MotherMobile"].ToString();
                litMotherWhatsApp.Text = dr["MotherWhatsApp"].ToString();
                litMotherEmail.Text = dr["MotherEmail"].ToString();
                litMotherOccupation.Text = dr["MotherOccupation"].ToString();

                // Guardian & Emergency
                litGuardianName.Text = dr["GuardianName"].ToString();
                litGuardianRel.Text = dr["GuardianRel"].ToString();
                litGuardianMobile.Text = dr["GuardianMobile"].ToString();

                litDoctorName.Text = dr["DoctorName"].ToString();
                litDoctorPhone.Text = dr["DoctorPhone"].ToString();
                litAllergies.Text = string.IsNullOrEmpty(dr["Allergies"].ToString()) ? "None" : dr["Allergies"].ToString();
                litHealthIssues.Text = string.IsNullOrEmpty(dr["HealthIssues"].ToString()) ? "None" : dr["HealthIssues"].ToString();

                // Pickup
                litPickupPerson.Text = dr["PickupPerson"].ToString();
                litPickupTime.Text = dr["PickupTime"].ToString();
                litIDProof.Text = dr["IDProofNumber"].ToString();

                // Fee
                litTotalFee.Text = Convert.ToDecimal(dr["TotalAmount"]).ToString("N2");
                string status = dr["PaymentStatus"].ToString();
                string badgeClass = status == "Paid" ? "bg-success" : (status == "Partial" ? "bg-warning text-dark" : "bg-danger");
                litPaymentBadge.Text = "<span class='badge " + badgeClass + " px-3 py-2 fs-6'>" + status + "</span>";
            }
        }
    }
}
