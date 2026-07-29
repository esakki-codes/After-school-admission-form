using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace AfterSchoolAdmission.DAL
{
    public class AdminDAL
    {
        public static string ComputeSha256Hash(string rawData)
        {
            if (string.IsNullOrEmpty(rawData)) return string.Empty;
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(rawData));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

        public DataTable ValidateAdmin(string username, string password)
        {
            string passwordHash = ComputeSha256Hash(password);
            SqlParameter[] p = new SqlParameter[]
            {
                new SqlParameter("@Username", username),
                new SqlParameter("@Password", passwordHash)
            };

            return DbConnection.ExecuteDataTable("sp_AdminLogin", CommandType.StoredProcedure, p);
        }

        public bool ResetPassword(string username, string securityAnswer, string newPassword)
        {
            string passwordHash = ComputeSha256Hash(newPassword);
            SqlParameter[] p = new SqlParameter[]
            {
                new SqlParameter("@Username", username),
                new SqlParameter("@SecurityAnswer", securityAnswer),
                new SqlParameter("@NewPassword", passwordHash)
            };

            DataTable dt = DbConnection.ExecuteDataTable("sp_ResetPassword", CommandType.StoredProcedure, p);
            if (dt.Rows.Count > 0 && Convert.ToInt32(dt.Rows[0]["Success"]) == 1)
            {
                return true;
            }
            return false;
        }

        public bool ChangePassword(int adminId, string oldPassword, string newPassword)
        {
            string oldHash = ComputeSha256Hash(oldPassword);
            string newHash = ComputeSha256Hash(newPassword);

            string checkSql = "SELECT COUNT(*) FROM [Admin] WHERE AdminID = @AdminID AND PasswordHash = @OldHash";
            int count = Convert.ToInt32(DbConnection.ExecuteScalar(checkSql, CommandType.Text, 
                new SqlParameter("@AdminID", adminId), 
                new SqlParameter("@OldHash", oldHash)));

            if (count > 0)
            {
                string updateSql = "UPDATE [Admin] SET PasswordHash = @NewHash WHERE AdminID = @AdminID";
                DbConnection.ExecuteNonQuery(updateSql, CommandType.Text, 
                    new SqlParameter("@AdminID", adminId), 
                    new SqlParameter("@NewHash", newHash));
                return true;
            }
            return false;
        }

        public DataTable GetDashboardStats()
        {
            return DbConnection.ExecuteDataTable("sp_GetDashboardStats", CommandType.StoredProcedure);
        }
    }
}
