-- ============================================================================
-- AFTER SCHOOL ADMISSION MANAGEMENT SYSTEM
-- Stored Procedures Script
-- Database Engine: SQL Server 2016+ / 2022
-- ============================================================================

USE [AfterSchoolDB];
GO

-- ----------------------------------------------------------------------------
-- 1. Admin Authentication & Password Procedures
-- ----------------------------------------------------------------------------
IF OBJECT_ID('sp_AdminLogin', 'P') IS NOT NULL DROP PROCEDURE sp_AdminLogin;
GO
CREATE PROCEDURE sp_AdminLogin
    @Username NVARCHAR(50),
    @Password NVARCHAR(256)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT AdminID, Username, FullName, Email, SecurityQuestion
    FROM [dbo].[Admin]
    WHERE Username = @Username AND PasswordHash = @Password;
END;
GO

IF OBJECT_ID('sp_ResetPassword', 'P') IS NOT NULL DROP PROCEDURE sp_ResetPassword;
GO
CREATE PROCEDURE sp_ResetPassword
    @Username NVARCHAR(50),
    @SecurityAnswer NVARCHAR(255),
    @NewPassword NVARCHAR(256)
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM [dbo].[Admin] WHERE Username = @Username AND SecurityAnswer = @SecurityAnswer)
    BEGIN
        UPDATE [dbo].[Admin]
        SET PasswordHash = @NewPassword
        WHERE Username = @Username;
        SELECT 1 AS [Success], 'Password reset successfully' AS [Message];
    END
    ELSE
    BEGIN
        SELECT 0 AS [Success], 'Invalid security answer' AS [Message];
    END
END;
GO

-- ----------------------------------------------------------------------------
-- 2. Dashboard Statistics Stored Procedure
-- ----------------------------------------------------------------------------
IF OBJECT_ID('sp_GetDashboardStats', 'P') IS NOT NULL DROP PROCEDURE sp_GetDashboardStats;
GO
CREATE PROCEDURE sp_GetDashboardStats
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @TotalStudents INT = (SELECT COUNT(*) FROM [dbo].[Student]);
    DECLARE @PlaySchoolCount INT = (SELECT COUNT(*) FROM [dbo].[Admission] WHERE ProgramType = 'Play School' AND Status = 'Active');
    DECLARE @TuitionCount INT = (SELECT COUNT(*) FROM [dbo].[Admission] WHERE ProgramType = 'Evening Tuition' AND Status = 'Active');
    DECLARE @BothCount INT = (SELECT COUNT(*) FROM [dbo].[Admission] WHERE ProgramType = 'Both' AND Status = 'Active');
    DECLARE @TodayAdmissions INT = (SELECT COUNT(*) FROM [dbo].[Admission] WHERE CAST(AdmissionDate AS DATE) = CAST(GETDATE() AS DATE));
    DECLARE @PendingFees DECIMAL(18,2) = (ISNULL((SELECT SUM(BalanceAmount) FROM [dbo].[Fee] WHERE PaymentStatus IN ('Pending', 'Partial')), 0.00));
    DECLARE @TodayPresent INT = (SELECT COUNT(*) FROM [dbo].[Attendance] WHERE CAST(AttendanceDate AS DATE) = CAST(GETDATE() AS DATE) AND Status = 'Present');

    SELECT 
        @TotalStudents AS TotalStudents,
        @PlaySchoolCount AS PlaySchoolStudents,
        @TuitionCount AS TuitionStudents,
        @BothCount AS BothStudents,
        @TodayAdmissions AS TodayAdmissions,
        @PendingFees AS PendingFees,
        @TodayPresent AS TodayPresent;
END;
GO

-- ----------------------------------------------------------------------------
-- 3. Auto Generate Admission Number Procedure
-- ----------------------------------------------------------------------------
IF OBJECT_ID('sp_GenerateAdmissionNo', 'P') IS NOT NULL DROP PROCEDURE sp_GenerateAdmissionNo;
GO
CREATE PROCEDURE sp_GenerateAdmissionNo
    @AdmissionNo NVARCHAR(50) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @Year NVARCHAR(4) = CAST(YEAR(GETDATE()) AS NVARCHAR(4));
    DECLARE @NextSeq INT;
    
    SELECT @NextSeq = ISNULL(MAX(StudentID), 0) + 1 FROM [dbo].[Student];
    SET @AdmissionNo = 'ADM-' + @Year + '-' + RIGHT('0000' + CAST(@NextSeq AS NVARCHAR(10)), 4);
END;
GO

-- ----------------------------------------------------------------------------
-- 4. Complete Multi-Section Admission Procedure (Atomic Transaction)
-- ----------------------------------------------------------------------------
IF OBJECT_ID('sp_InsertCompleteAdmission', 'P') IS NOT NULL DROP PROCEDURE sp_InsertCompleteAdmission;
GO
CREATE PROCEDURE sp_InsertCompleteAdmission
    -- Student Details
    @AdmissionNo       NVARCHAR(50),
    @FullName          NVARCHAR(150),
    @Gender            NVARCHAR(10),
    @DateOfBirth       DATE,
    @BloodGroup        NVARCHAR(10),
    @SchoolName        NVARCHAR(150),
    @Standard          NVARCHAR(50),
    @Address           NVARCHAR(500),
    @PhotoPath         NVARCHAR(255),
    
    -- Father Details
    @FatherName        NVARCHAR(150),
    @FatherMobile      NVARCHAR(15),
    @FatherWhatsApp    NVARCHAR(15),
    @FatherEmail       NVARCHAR(100),
    @FatherOccupation NVARCHAR(100),
    @FatherOfficeAddress NVARCHAR(300),
    
    -- Mother Details
    @MotherName        NVARCHAR(150),
    @MotherMobile      NVARCHAR(15),
    @MotherWhatsApp    NVARCHAR(15),
    @MotherEmail       NVARCHAR(100),
    @MotherOccupation NVARCHAR(100),
    @MotherOfficeAddress NVARCHAR(300),
    
    -- Guardian Details
    @GuardianName      NVARCHAR(150),
    @GuardianRel       NVARCHAR(50),
    @GuardianMobile    NVARCHAR(15),
    @GuardianAddress   NVARCHAR(300),
    
    -- Emergency Contact Details
    @EmergencyName     NVARCHAR(150),
    @EmergencyRel      NVARCHAR(50),
    @EmergencyPhone    NVARCHAR(15),
    @DoctorName        NVARCHAR(150),
    @DoctorPhone       NVARCHAR(15),
    @Allergies         NVARCHAR(500),
    @HealthIssues      NVARCHAR(500),
    
    -- Pickup Information
    @PickupPerson      NVARCHAR(150),
    @PickupTime        NVARCHAR(50),
    @AuthorizedPerson  NVARCHAR(150),
    @IDProofNumber     NVARCHAR(100),
    
    -- Program & Admission Info
    @AcademicYear      NVARCHAR(20),
    @ProgramType       NVARCHAR(50),
    @ParentSignature   NVARCHAR(100),
    @StaffSignature    NVARCHAR(100),
    
    -- Fee Details
    @AdmissionFee      DECIMAL(18,2),
    @MonthlyFee        DECIMAL(18,2),
    @Discount          DECIMAL(18,2),
    @TotalAmount       DECIMAL(18,2),
    @AmountPaid        DECIMAL(18,2),
    @PaymentMethod     NVARCHAR(50),
    @ReceiptNumber     NVARCHAR(50),
    
    @NewStudentID      INT OUTPUT,
    @NewAdmissionID    INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        -- 1. Insert Student
        INSERT INTO [dbo].[Student] (AdmissionNo, FullName, Gender, DateOfBirth, BloodGroup, SchoolName, Standard, Address, PhotoPath)
        VALUES (@AdmissionNo, @FullName, @Gender, @DateOfBirth, @BloodGroup, @SchoolName, @Standard, @Address, @PhotoPath);
        
        SET @NewStudentID = SCOPE_IDENTITY();
        
        -- 2. Insert Parent
        INSERT INTO [dbo].[Parent] (StudentID, FatherName, FatherMobile, FatherWhatsApp, FatherEmail, FatherOccupation, FatherOfficeAddress, MotherName, MotherMobile, MotherWhatsApp, MotherEmail, MotherOccupation, MotherOfficeAddress)
        VALUES (@NewStudentID, @FatherName, @FatherMobile, @FatherWhatsApp, @FatherEmail, @FatherOccupation, @FatherOfficeAddress, @MotherName, @MotherMobile, @MotherWhatsApp, @MotherEmail, @MotherOccupation, @MotherOfficeAddress);
        
        -- 3. Insert Guardian
        INSERT INTO [dbo].[Guardian] (StudentID, GuardianName, Relationship, MobileNumber, Address)
        VALUES (@NewStudentID, @GuardianName, @GuardianRel, @GuardianMobile, @GuardianAddress);
        
        -- 4. Insert Emergency Contact
        INSERT INTO [dbo].[EmergencyContact] (StudentID, ContactName, Relationship, PhoneNumber, DoctorName, DoctorPhone, Allergies, HealthIssues)
        VALUES (@NewStudentID, @EmergencyName, @EmergencyRel, @EmergencyPhone, @DoctorName, @DoctorPhone, @Allergies, @HealthIssues);
        
        -- 5. Insert Pickup Authorization
        INSERT INTO [dbo].[PickupAuthorization] (StudentID, PickupPerson, PickupTime, AuthorizedPerson, IDProofNumber)
        VALUES (@NewStudentID, @PickupPerson, @PickupTime, @AuthorizedPerson, @IDProofNumber);
        
        -- 6. Get Course ID
        DECLARE @CourseID INT = (SELECT TOP 1 CourseID FROM [dbo].[Course] WHERE CourseName = @ProgramType);
        IF @CourseID IS NULL SET @CourseID = 1;
        
        -- 7. Insert Admission
        INSERT INTO [dbo].[Admission] (AdmissionNo, StudentID, CourseID, AdmissionDate, AcademicYear, ProgramType, ParentSignature, StaffSignature)
        VALUES (@AdmissionNo, @NewStudentID, @CourseID, GETDATE(), @AcademicYear, @ProgramType, @ParentSignature, @StaffSignature);
        
        SET @NewAdmissionID = SCOPE_IDENTITY();
        
        -- 8. Insert Fee Record
        DECLARE @Balance DECIMAL(18,2) = @TotalAmount - @AmountPaid;
        DECLARE @Status NVARCHAR(20) = CASE WHEN @Balance <= 0 THEN 'Paid' WHEN @AmountPaid > 0 THEN 'Partial' ELSE 'Pending' END;
        
        INSERT INTO [dbo].[Fee] (AdmissionID, StudentID, AdmissionFee, MonthlyFee, Discount, TotalAmount, AmountPaid, BalanceAmount, PaymentMethod, ReceiptNumber, PaymentStatus, FeeForMonth)
        VALUES (@NewAdmissionID, @NewStudentID, @AdmissionFee, @MonthlyFee, @Discount, @TotalAmount, @AmountPaid, @Balance, @PaymentMethod, @ReceiptNumber, @Status, DATENAME(MONTH, GETDATE()) + ' ' + CAST(YEAR(GETDATE()) AS NVARCHAR(4)));
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- ----------------------------------------------------------------------------
-- 5. View Complete Student Profile Procedure
-- ----------------------------------------------------------------------------
IF OBJECT_ID('sp_GetStudentDetails', 'P') IS NOT NULL DROP PROCEDURE sp_GetStudentDetails;
GO
CREATE PROCEDURE sp_GetStudentDetails
    @StudentID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        s.StudentID, s.AdmissionNo, s.FullName, s.Gender, s.DateOfBirth, s.BloodGroup, s.SchoolName, s.Standard, s.Address, s.PhotoPath, s.CreatedAt,
        p.FatherName, p.FatherMobile, p.FatherWhatsApp, p.FatherEmail, p.FatherOccupation, p.FatherOfficeAddress,
        p.MotherName, p.MotherMobile, p.MotherWhatsApp, p.MotherEmail, p.MotherOccupation, p.MotherOfficeAddress,
        g.GuardianName, g.Relationship AS GuardianRel, g.MobileNumber AS GuardianMobile, g.Address AS GuardianAddress,
        ec.ContactName AS EmergencyName, ec.Relationship AS EmergencyRel, ec.PhoneNumber AS EmergencyPhone, ec.DoctorName, ec.DoctorPhone, ec.Allergies, ec.HealthIssues,
        pa.PickupPerson, pa.PickupTime, pa.AuthorizedPerson, pa.IDProofNumber,
        a.AdmissionID, a.AcademicYear, a.ProgramType, a.AdmissionDate, a.Status AS AdmissionStatus,
        f.FeeID, f.AdmissionFee, f.MonthlyFee, f.Discount, f.TotalAmount, f.AmountPaid, f.BalanceAmount, f.PaymentStatus, f.ReceiptNumber, f.PaymentMethod
    FROM [dbo].[Student] s
    LEFT JOIN [dbo].[Parent] p ON s.StudentID = p.StudentID
    LEFT JOIN [dbo].[Guardian] g ON s.StudentID = g.StudentID
    LEFT JOIN [dbo].[EmergencyContact] ec ON s.StudentID = ec.StudentID
    LEFT JOIN [dbo].[PickupAuthorization] pa ON s.StudentID = pa.StudentID
    LEFT JOIN [dbo].[Admission] a ON s.StudentID = a.StudentID
    LEFT JOIN [dbo].[Fee] f ON a.AdmissionID = f.AdmissionID
    WHERE s.StudentID = @StudentID;
END;
GO

-- ----------------------------------------------------------------------------
-- 6. Search & Filter Students Procedure
-- ----------------------------------------------------------------------------
IF OBJECT_ID('sp_SearchStudents', 'P') IS NOT NULL DROP PROCEDURE sp_SearchStudents;
GO
CREATE PROCEDURE sp_SearchStudents
    @SearchTerm NVARCHAR(100) = NULL,
    @ProgramType NVARCHAR(50) = NULL,
    @Standard NVARCHAR(50) = NULL,
    @FromDate DATE = NULL,
    @ToDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        s.StudentID, s.AdmissionNo, s.FullName, s.Gender, s.Standard, s.SchoolName, s.PhotoPath,
        p.FatherName, p.FatherMobile,
        a.ProgramType, a.AdmissionDate, a.AcademicYear, a.Status AS AdmissionStatus,
        f.PaymentStatus, f.BalanceAmount
    FROM [dbo].[Student] s
    INNER JOIN [dbo].[Parent] p ON s.StudentID = p.StudentID
    INNER JOIN [dbo].[Admission] a ON s.StudentID = a.StudentID
    INNER JOIN [dbo].[Fee] f ON a.AdmissionID = f.AdmissionID
    WHERE (@SearchTerm IS NULL OR s.FullName LIKE '%' + @SearchTerm + '%' OR s.AdmissionNo LIKE '%' + @SearchTerm + '%' OR p.FatherName LIKE '%' + @SearchTerm + '%' OR p.FatherMobile LIKE '%' + @SearchTerm + '%')
      AND (@ProgramType IS NULL OR @ProgramType = '' OR a.ProgramType = @ProgramType)
      AND (@Standard IS NULL OR @Standard = '' OR s.Standard = @Standard)
      AND (@FromDate IS NULL OR a.AdmissionDate >= @FromDate)
      AND (@ToDate IS NULL OR a.AdmissionDate <= @ToDate)
    ORDER BY s.StudentID DESC;
END;
GO

-- ----------------------------------------------------------------------------
-- 7. Delete Student Procedure
-- ----------------------------------------------------------------------------
IF OBJECT_ID('sp_DeleteStudent', 'P') IS NOT NULL DROP PROCEDURE sp_DeleteStudent;
GO
CREATE PROCEDURE sp_DeleteStudent
    @StudentID INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        DELETE FROM [dbo].[Attendance] WHERE StudentID = @StudentID;
        DELETE FROM [dbo].[Fee] WHERE StudentID = @StudentID;
        DELETE FROM [dbo].[Admission] WHERE StudentID = @StudentID;
        DELETE FROM [dbo].[PickupAuthorization] WHERE StudentID = @StudentID;
        DELETE FROM [dbo].[EmergencyContact] WHERE StudentID = @StudentID;
        DELETE FROM [dbo].[Guardian] WHERE StudentID = @StudentID;
        DELETE FROM [dbo].[Parent] WHERE StudentID = @StudentID;
        DELETE FROM [dbo].[Student] WHERE StudentID = @StudentID;
        COMMIT TRANSACTION;
        SELECT 1 AS Success;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- ----------------------------------------------------------------------------
-- 8. Fee Payment & Receipt Stored Procedures
-- ----------------------------------------------------------------------------
IF OBJECT_ID('sp_AddFeePayment', 'P') IS NOT NULL DROP PROCEDURE sp_AddFeePayment;
GO
CREATE PROCEDURE sp_AddFeePayment
    @StudentID INT,
    @AmountPaid DECIMAL(18,2),
    @PaymentMethod NVARCHAR(50),
    @FeeForMonth NVARCHAR(30),
    @ReceiptNumber NVARCHAR(50) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @AdmissionID INT = (SELECT TOP 1 AdmissionID FROM [dbo].[Admission] WHERE StudentID = @StudentID ORDER BY AdmissionID DESC);
    DECLARE @MonthlyFee DECIMAL(18,2) = (SELECT ISNULL(MonthlyFee, 0) FROM [dbo].[Course] c INNER JOIN [dbo].[Admission] a ON c.CourseID = a.CourseID WHERE a.AdmissionID = @AdmissionID);
    
    SET @ReceiptNumber = 'REC-' + CAST(YEAR(GETDATE()) AS NVARCHAR(4)) + '-' + RIGHT('00000' + CAST(ISNULL((SELECT MAX(FeeID) FROM [dbo].[Fee]), 0) + 1 AS NVARCHAR(10)), 5);
    
    DECLARE @Balance DECIMAL(18,2) = @MonthlyFee - @AmountPaid;
    IF @Balance < 0 SET @Balance = 0;
    
    DECLARE @Status NVARCHAR(20) = CASE WHEN @Balance <= 0 THEN 'Paid' WHEN @AmountPaid > 0 THEN 'Partial' ELSE 'Pending' END;
    
    INSERT INTO [dbo].[Fee] (AdmissionID, StudentID, AdmissionFee, MonthlyFee, Discount, TotalAmount, AmountPaid, BalanceAmount, PaymentMethod, ReceiptNumber, PaymentStatus, FeeForMonth)
    VALUES (@AdmissionID, @StudentID, 0.00, @MonthlyFee, 0.00, @MonthlyFee, @AmountPaid, @Balance, @PaymentMethod, @ReceiptNumber, @Status, @FeeForMonth);
END;
GO
