using System;
using System.Data;
using System.Data.SqlClient;

namespace AfterSchoolAdmission.DAL
{
    public class ReportDAL
    {
        public DataTable GetStudentListReport(string programType = null, string standard = null)
        {
            string sql = @"
                SELECT 
                    s.AdmissionNo, s.FullName, s.Gender, s.DateOfBirth, s.Standard, s.SchoolName, s.BloodGroup,
                    p.FatherName, p.FatherMobile, p.MotherName, p.MotherMobile,
                    a.ProgramType, a.AdmissionDate, a.AcademicYear
                FROM [Student] s
                INNER JOIN [Parent] p ON s.StudentID = p.StudentID
                INNER JOIN [Admission] a ON s.StudentID = a.StudentID
                WHERE (@ProgramType IS NULL OR @ProgramType = '' OR a.ProgramType = @ProgramType)
                  AND (@Standard IS NULL OR @Standard = '' OR s.Standard = @Standard)
                ORDER BY s.FullName ASC";

            SqlParameter[] p = new SqlParameter[]
            {
                new SqlParameter("@ProgramType", (object)programType ?? DBNull.Value),
                new SqlParameter("@Standard", (object)standard ?? DBNull.Value)
            };

            return DbConnection.ExecuteDataTable(sql, CommandType.Text, p);
        }

        public DataTable GetAdmissionReport(DateTime? fromDate = null, DateTime? toDate = null, string programType = null)
        {
            string sql = @"
                SELECT 
                    a.AdmissionNo, a.AdmissionDate, a.AcademicYear, a.ProgramType,
                    s.FullName AS StudentName, s.Standard, s.SchoolName,
                    p.FatherName, p.FatherMobile,
                    f.TotalAmount, f.AmountPaid, f.BalanceAmount, f.PaymentStatus
                FROM [Admission] a
                INNER JOIN [Student] s ON a.StudentID = s.StudentID
                INNER JOIN [Parent] p ON s.StudentID = p.StudentID
                LEFT JOIN [Fee] f ON a.AdmissionID = f.AdmissionID
                WHERE (@FromDate IS NULL OR a.AdmissionDate >= @FromDate)
                  AND (@ToDate IS NULL OR a.AdmissionDate <= @ToDate)
                  AND (@ProgramType IS NULL OR @ProgramType = '' OR a.ProgramType = @ProgramType)
                ORDER BY a.AdmissionDate DESC";

            SqlParameter[] p = new SqlParameter[]
            {
                new SqlParameter("@FromDate", (object)fromDate ?? DBNull.Value),
                new SqlParameter("@ToDate", (object)toDate ?? DBNull.Value),
                new SqlParameter("@ProgramType", (object)programType ?? DBNull.Value)
            };

            return DbConnection.ExecuteDataTable(sql, CommandType.Text, p);
        }

        public DataTable GetFeeCollectionReport(DateTime? fromDate = null, DateTime? toDate = null, string paymentMethod = null)
        {
            string sql = @"
                SELECT 
                    f.ReceiptNumber, f.PaymentDate, f.FeeForMonth,
                    s.AdmissionNo, s.FullName AS StudentName, s.Standard,
                    a.ProgramType,
                    f.TotalAmount, f.AmountPaid, f.BalanceAmount, f.PaymentMethod, f.PaymentStatus
                FROM [Fee] f
                INNER JOIN [Student] s ON f.StudentID = s.StudentID
                INNER JOIN [Admission] a ON f.AdmissionID = a.AdmissionID
                WHERE (@FromDate IS NULL OR CAST(f.PaymentDate AS DATE) >= @FromDate)
                  AND (@ToDate IS NULL OR CAST(f.PaymentDate AS DATE) <= @ToDate)
                  AND (@PaymentMethod IS NULL OR @PaymentMethod = '' OR f.PaymentMethod = @PaymentMethod)
                ORDER BY f.PaymentDate DESC";

            SqlParameter[] p = new SqlParameter[]
            {
                new SqlParameter("@FromDate", (object)fromDate ?? DBNull.Value),
                new SqlParameter("@ToDate", (object)toDate ?? DBNull.Value),
                new SqlParameter("@PaymentMethod", (object)paymentMethod ?? DBNull.Value)
            };

            return DbConnection.ExecuteDataTable(sql, CommandType.Text, p);
        }

        public DataTable GetParentContactReport()
        {
            string sql = @"
                SELECT 
                    s.AdmissionNo, s.FullName AS StudentName, s.Standard, a.ProgramType,
                    p.FatherName, p.FatherMobile, p.FatherWhatsApp, p.FatherEmail, p.FatherOccupation,
                    p.MotherName, p.MotherMobile, p.MotherWhatsApp, p.MotherEmail, p.MotherOccupation,
                    g.GuardianName, g.MobileNumber AS GuardianMobile, g.Relationship AS GuardianRel,
                    ec.ContactName AS EmergencyContact, ec.PhoneNumber AS EmergencyPhone
                FROM [Student] s
                INNER JOIN [Parent] p ON s.StudentID = p.StudentID
                INNER JOIN [Admission] a ON s.StudentID = a.StudentID
                LEFT JOIN [Guardian] g ON s.StudentID = g.StudentID
                LEFT JOIN [EmergencyContact] ec ON s.StudentID = ec.StudentID
                ORDER BY s.FullName ASC";

            return DbConnection.ExecuteDataTable(sql, CommandType.Text);
        }
    }
}
