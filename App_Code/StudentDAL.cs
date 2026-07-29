using System;
using System.Data;
using System.Data.SqlClient;

namespace AfterSchoolAdmission.DAL
{
    public class StudentDAL
    {
        public string GenerateAdmissionNumber()
        {
            using (SqlConnection conn = DbConnection.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand("sp_GenerateAdmissionNo", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter outParam = new SqlParameter("@AdmissionNo", SqlDbType.NVarChar, 50)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(outParam);
                    cmd.ExecuteNonQuery();
                    return outParam.Value.ToString();
                }
            }
        }

        public bool SaveAdmission(
            string admissionNo, string fullName, string gender, DateTime dob, string bloodGroup,
            string schoolName, string standard, string address, string photoPath,
            string fatherName, string fatherMobile, string fatherWhatsApp, string fatherEmail, string fatherOcc, string fatherOffice,
            string motherName, string motherMobile, string motherWhatsApp, string motherEmail, string motherOcc, string motherOffice,
            string guardianName, string guardianRel, string guardianMobile, string guardianAddress,
            string emergencyName, string emergencyRel, string emergencyPhone, string doctorName, string doctorPhone, string allergies, string healthIssues,
            string pickupPerson, string pickupTime, string authorizedPerson, string idProofNumber,
            string academicYear, string programType, string parentSig, string staffSig,
            decimal admissionFee, decimal monthlyFee, decimal discount, decimal totalAmount, decimal amountPaid, string paymentMethod, string receiptNo,
            out int newStudentId, out int newAdmissionId)
        {
            newStudentId = 0;
            newAdmissionId = 0;

            using (SqlConnection conn = DbConnection.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand("sp_InsertCompleteAdmission", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Student
                    cmd.Parameters.AddWithValue("@AdmissionNo", admissionNo);
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Gender", gender);
                    cmd.Parameters.AddWithValue("@DateOfBirth", dob);
                    cmd.Parameters.AddWithValue("@BloodGroup", (object)bloodGroup ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@SchoolName", (object)schoolName ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Standard", standard);
                    cmd.Parameters.AddWithValue("@Address", address);
                    cmd.Parameters.AddWithValue("@PhotoPath", string.IsNullOrEmpty(photoPath) ? "/Images/Students/default-avatar.png" : photoPath);

                    // Father & Mother
                    cmd.Parameters.AddWithValue("@FatherName", fatherName);
                    cmd.Parameters.AddWithValue("@FatherMobile", fatherMobile);
                    cmd.Parameters.AddWithValue("@FatherWhatsApp", (object)fatherWhatsApp ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@FatherEmail", (object)fatherEmail ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@FatherOccupation", (object)fatherOcc ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@FatherOfficeAddress", (object)fatherOffice ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@MotherName", motherName);
                    cmd.Parameters.AddWithValue("@MotherMobile", motherMobile);
                    cmd.Parameters.AddWithValue("@MotherWhatsApp", (object)motherWhatsApp ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@MotherEmail", (object)motherEmail ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@MotherOccupation", (object)motherOcc ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@MotherOfficeAddress", (object)motherOffice ?? DBNull.Value);

                    // Guardian
                    cmd.Parameters.AddWithValue("@GuardianName", guardianName);
                    cmd.Parameters.AddWithValue("@GuardianRel", guardianRel);
                    cmd.Parameters.AddWithValue("@GuardianMobile", guardianMobile);
                    cmd.Parameters.AddWithValue("@GuardianAddress", (object)guardianAddress ?? DBNull.Value);

                    // Emergency & Medical
                    cmd.Parameters.AddWithValue("@EmergencyName", emergencyName);
                    cmd.Parameters.AddWithValue("@EmergencyRel", emergencyRel);
                    cmd.Parameters.AddWithValue("@EmergencyPhone", emergencyPhone);
                    cmd.Parameters.AddWithValue("@DoctorName", (object)doctorName ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@DoctorPhone", (object)doctorPhone ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Allergies", (object)allergies ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@HealthIssues", (object)healthIssues ?? DBNull.Value);

                    // Pickup
                    cmd.Parameters.AddWithValue("@PickupPerson", pickupPerson);
                    cmd.Parameters.AddWithValue("@PickupTime", pickupTime);
                    cmd.Parameters.AddWithValue("@AuthorizedPerson", authorizedPerson);
                    cmd.Parameters.AddWithValue("@IDProofNumber", idProofNumber);

                    // Program
                    cmd.Parameters.AddWithValue("@AcademicYear", academicYear);
                    cmd.Parameters.AddWithValue("@ProgramType", programType);
                    cmd.Parameters.AddWithValue("@ParentSignature", (object)parentSig ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@StaffSignature", (object)staffSig ?? DBNull.Value);

                    // Fee
                    cmd.Parameters.AddWithValue("@AdmissionFee", admissionFee);
                    cmd.Parameters.AddWithValue("@MonthlyFee", monthlyFee);
                    cmd.Parameters.AddWithValue("@Discount", discount);
                    cmd.Parameters.AddWithValue("@TotalAmount", totalAmount);
                    cmd.Parameters.AddWithValue("@AmountPaid", amountPaid);
                    cmd.Parameters.AddWithValue("@PaymentMethod", paymentMethod);
                    cmd.Parameters.AddWithValue("@ReceiptNumber", receiptNo);

                    // Outputs
                    SqlParameter outStudentId = new SqlParameter("@NewStudentID", SqlDbType.Int) { Direction = ParameterDirection.Output };
                    SqlParameter outAdmissionId = new SqlParameter("@NewAdmissionID", SqlDbType.Int) { Direction = ParameterDirection.Output };
                    cmd.Parameters.Add(outStudentId);
                    cmd.Parameters.Add(outAdmissionId);

                    cmd.ExecuteNonQuery();

                    if (outStudentId.Value != DBNull.Value) newStudentId = Convert.ToInt32(outStudentId.Value);
                    if (outAdmissionId.Value != DBNull.Value) newAdmissionId = Convert.ToInt32(outAdmissionId.Value);

                    return true;
                }
            }
        }

        public DataTable GetStudentDetails(int studentId)
        {
            SqlParameter[] p = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentId)
            };
            return DbConnection.ExecuteDataTable("sp_GetStudentDetails", CommandType.StoredProcedure, p);
        }

        public DataTable SearchStudents(string searchTerm = null, string programType = null, string standard = null, DateTime? fromDate = null, DateTime? toDate = null)
        {
            SqlParameter[] p = new SqlParameter[]
            {
                new SqlParameter("@SearchTerm", (object)searchTerm ?? DBNull.Value),
                new SqlParameter("@ProgramType", (object)programType ?? DBNull.Value),
                new SqlParameter("@Standard", (object)standard ?? DBNull.Value),
                new SqlParameter("@FromDate", (object)fromDate ?? DBNull.Value),
                new SqlParameter("@ToDate", (object)toDate ?? DBNull.Value)
            };
            return DbConnection.ExecuteDataTable("sp_SearchStudents", CommandType.StoredProcedure, p);
        }

        public bool DeleteStudent(int studentId)
        {
            SqlParameter[] p = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentId)
            };
            DataTable dt = DbConnection.ExecuteDataTable("sp_DeleteStudent", CommandType.StoredProcedure, p);
            return dt.Rows.Count > 0;
        }

        public bool UpdateStudent(int studentId, string fullName, string gender, DateTime dob, string bloodGroup, string schoolName, string standard, string address, string photoPath)
        {
            string sql = @"UPDATE [Student] 
                           SET FullName=@FullName, Gender=@Gender, DateOfBirth=@DateOfBirth, 
                               BloodGroup=@BloodGroup, SchoolName=@SchoolName, Standard=@Standard, Address=@Address, 
                               PhotoPath=ISNULL(NULLIF(@PhotoPath,''), PhotoPath) 
                           WHERE StudentID=@StudentID";

            SqlParameter[] p = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentId),
                new SqlParameter("@FullName", fullName),
                new SqlParameter("@Gender", gender),
                new SqlParameter("@DateOfBirth", dob),
                new SqlParameter("@BloodGroup", (object)bloodGroup ?? DBNull.Value),
                new SqlParameter("@SchoolName", (object)schoolName ?? DBNull.Value),
                new SqlParameter("@Standard", standard),
                new SqlParameter("@Address", address),
                new SqlParameter("@PhotoPath", (object)photoPath ?? DBNull.Value)
            };

            return DbConnection.ExecuteNonQuery(sql, CommandType.Text, p) > 0;
        }
    }
}
