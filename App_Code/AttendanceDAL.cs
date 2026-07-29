using System;
using System.Data;
using System.Data.SqlClient;

namespace AfterSchoolAdmission.DAL
{
    public class AttendanceDAL
    {
        public bool MarkAttendance(int studentId, DateTime attendanceDate, string status, string remarks)
        {
            string sql = @"
                IF EXISTS (SELECT 1 FROM [Attendance] WHERE StudentID = @StudentID AND AttendanceDate = @AttendanceDate)
                BEGIN
                    UPDATE [Attendance] 
                    SET Status = @Status, Remarks = @Remarks, RecordedAt = GETDATE() 
                    WHERE StudentID = @StudentID AND AttendanceDate = @AttendanceDate;
                END
                ELSE
                BEGIN
                    INSERT INTO [Attendance] (StudentID, AttendanceDate, Status, Remarks) 
                    VALUES (@StudentID, @AttendanceDate, @Status, @Remarks);
                END";

            SqlParameter[] p = new SqlParameter[]
            {
                new SqlParameter("@StudentID", studentId),
                new SqlParameter("@AttendanceDate", attendanceDate),
                new SqlParameter("@Status", status),
                new SqlParameter("@Remarks", (object)remarks ?? DBNull.Value)
            };

            return DbConnection.ExecuteNonQuery(sql, CommandType.Text, p) > 0;
        }

        public DataTable GetDailyAttendanceSheet(DateTime attendanceDate, string programType = null)
        {
            string sql = @"
                SELECT 
                    s.StudentID, s.AdmissionNo, s.FullName, s.Standard, a.ProgramType,
                    ISNULL(att.Status, 'Absent') AS CurrentStatus, att.Remarks
                FROM [Student] s
                INNER JOIN [Admission] a ON s.StudentID = a.StudentID
                LEFT JOIN [Attendance] att ON s.StudentID = att.StudentID AND att.AttendanceDate = @AttendanceDate
                WHERE a.Status = 'Active'
                  AND (@ProgramType IS NULL OR @ProgramType = '' OR a.ProgramType = @ProgramType)
                ORDER BY s.FullName ASC";

            SqlParameter[] p = new SqlParameter[]
            {
                new SqlParameter("@AttendanceDate", attendanceDate),
                new SqlParameter("@ProgramType", (object)programType ?? DBNull.Value)
            };

            return DbConnection.ExecuteDataTable(sql, CommandType.Text, p);
        }

        public DataTable GetMonthlyAttendanceReport(int month, int year, string programType = null)
        {
            string sql = @"
                SELECT 
                    s.StudentID, s.AdmissionNo, s.FullName, s.Standard, a.ProgramType,
                    SUM(CASE WHEN att.Status = 'Present' THEN 1 ELSE 0 END) AS TotalPresent,
                    SUM(CASE WHEN att.Status = 'Absent' THEN 1 ELSE 0 END) AS TotalAbsent,
                    SUM(CASE WHEN att.Status = 'Late' THEN 1 ELSE 0 END) AS TotalLate,
                    COUNT(att.AttendanceID) AS TotalDaysRecorded
                FROM [Student] s
                INNER JOIN [Admission] a ON s.StudentID = a.StudentID
                LEFT JOIN [Attendance] att ON s.StudentID = att.StudentID 
                    AND MONTH(att.AttendanceDate) = @Month 
                    AND YEAR(att.AttendanceDate) = @Year
                WHERE a.Status = 'Active'
                  AND (@ProgramType IS NULL OR @ProgramType = '' OR a.ProgramType = @ProgramType)
                GROUP BY s.StudentID, s.AdmissionNo, s.FullName, s.Standard, a.ProgramType
                ORDER BY s.FullName ASC";

            SqlParameter[] p = new SqlParameter[]
            {
                new SqlParameter("@Month", month),
                new SqlParameter("@Year", year),
                new SqlParameter("@ProgramType", (object)programType ?? DBNull.Value)
            };

            return DbConnection.ExecuteDataTable(sql, CommandType.Text, p);
        }
    }
}
