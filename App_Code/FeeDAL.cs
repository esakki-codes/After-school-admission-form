using System;
using System.Data;
using System.Data.SqlClient;

namespace AfterSchoolAdmission.DAL
{
    public class FeeDAL
    {
        public bool RecordPayment(int studentId, decimal amountPaid, string paymentMethod, string feeForMonth, out string receiptNumber)
        {
            receiptNumber = string.Empty;
            using (SqlConnection conn = DbConnection.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand("sp_AddFeePayment", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@StudentID", studentId);
                    cmd.Parameters.AddWithValue("@AmountPaid", amountPaid);
                    cmd.Parameters.AddWithValue("@PaymentMethod", paymentMethod);
                    cmd.Parameters.AddWithValue("@FeeForMonth", feeForMonth);

                    SqlParameter outReceipt = new SqlParameter("@ReceiptNumber", SqlDbType.NVarChar, 50)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(outReceipt);

                    cmd.ExecuteNonQuery();
                    receiptNumber = outReceipt.Value.ToString();
                    return true;
                }
            }
        }

        public DataTable GetReceiptDetails(string receiptNumber)
        {
            string sql = @"
                SELECT 
                    f.FeeID, f.ReceiptNumber, f.PaymentDate, f.PaymentMethod, f.FeeForMonth,
                    f.AdmissionFee, f.MonthlyFee, f.Discount, f.TotalAmount, f.AmountPaid, f.BalanceAmount, f.PaymentStatus,
                    s.StudentID, s.AdmissionNo, s.FullName AS StudentName, s.Standard, s.Address,
                    p.FatherName, p.FatherMobile, p.FatherEmail,
                    a.ProgramType, a.AcademicYear
                FROM [Fee] f
                INNER JOIN [Student] s ON f.StudentID = s.StudentID
                INNER JOIN [Parent] p ON s.StudentID = p.StudentID
                INNER JOIN [Admission] a ON f.AdmissionID = a.AdmissionID
                WHERE f.ReceiptNumber = @ReceiptNumber";

            SqlParameter[] p = new SqlParameter[]
            {
                new SqlParameter("@ReceiptNumber", receiptNumber)
            };

            return DbConnection.ExecuteDataTable(sql, CommandType.Text, p);
        }

        public DataTable GetPendingFees()
        {
            string sql = @"
                SELECT 
                    s.StudentID, s.AdmissionNo, s.FullName, s.Standard,
                    p.FatherName, p.FatherMobile,
                    a.ProgramType,
                    f.ReceiptNumber, f.TotalAmount, f.AmountPaid, f.BalanceAmount, f.PaymentStatus, f.PaymentDate, f.FeeForMonth
                FROM [Fee] f
                INNER JOIN [Student] s ON f.StudentID = s.StudentID
                INNER JOIN [Parent] p ON s.StudentID = p.StudentID
                INNER JOIN [Admission] a ON f.AdmissionID = a.AdmissionID
                WHERE f.BalanceAmount > 0 OR f.PaymentStatus IN ('Pending', 'Partial')
                ORDER BY f.PaymentDate DESC";

            return DbConnection.ExecuteDataTable(sql, CommandType.Text);
        }

        public DataTable GetFeeHistory(string searchTerm = null, string status = null, string paymentMethod = null)
        {
            string sql = @"
                SELECT 
                    f.FeeID, f.ReceiptNumber, f.PaymentDate, f.FeeForMonth,
                    s.AdmissionNo, s.FullName AS StudentName, s.Standard,
                    a.ProgramType,
                    f.TotalAmount, f.AmountPaid, f.BalanceAmount, f.PaymentMethod, f.PaymentStatus
                FROM [Fee] f
                INNER JOIN [Student] s ON f.StudentID = s.StudentID
                INNER JOIN [Admission] a ON f.AdmissionID = a.AdmissionID
                WHERE (@SearchTerm IS NULL OR s.FullName LIKE '%' + @SearchTerm + '%' OR f.ReceiptNumber LIKE '%' + @SearchTerm + '%' OR s.AdmissionNo LIKE '%' + @SearchTerm + '%')
                  AND (@Status IS NULL OR @Status = '' OR f.PaymentStatus = @Status)
                  AND (@PaymentMethod IS NULL OR @PaymentMethod = '' OR f.PaymentMethod = @PaymentMethod)
                ORDER BY f.FeeID DESC";

            SqlParameter[] p = new SqlParameter[]
            {
                new SqlParameter("@SearchTerm", (object)searchTerm ?? DBNull.Value),
                new SqlParameter("@Status", (object)status ?? DBNull.Value),
                new SqlParameter("@PaymentMethod", (object)paymentMethod ?? DBNull.Value)
            };

            return DbConnection.ExecuteDataTable(sql, CommandType.Text, p);
        }
    }
}
