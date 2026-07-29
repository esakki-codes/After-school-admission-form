-- ============================================================================
-- AFTER SCHOOL ADMISSION MANAGEMENT SYSTEM
-- Database Creation & Schema Definition Script
-- Database Engine: SQL Server 2016+ / SQL Server 2022
-- ============================================================================

CREATE DATABASE [AfterSchoolDB];
GO

USE [AfterSchoolDB];
GO

-- ----------------------------------------------------------------------------
-- 1. Admin Table
-- ----------------------------------------------------------------------------
CREATE TABLE [dbo].[Admin] (
    [AdminID]          INT IDENTITY(1,1) NOT NULL,
    [Username]         NVARCHAR(50) NOT NULL UNIQUE,
    [PasswordHash]     NVARCHAR(256) NOT NULL,
    [FullName]         NVARCHAR(100) NOT NULL,
    [Email]            NVARCHAR(100) NOT NULL UNIQUE,
    [Mobile]           NVARCHAR(15) NULL,
    [SecurityQuestion] NVARCHAR(255) NULL,
    [SecurityAnswer]   NVARCHAR(255) NULL,
    [LastLoginDate]    DATETIME NULL,
    [CreatedAt]        DATETIME DEFAULT GETDATE(),
    CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED ([AdminID] ASC)
);
GO

-- ----------------------------------------------------------------------------
-- 2. Course / Program Master Table
-- ----------------------------------------------------------------------------
CREATE TABLE [dbo].[Course] (
    [CourseID]      INT IDENTITY(1,1) NOT NULL,
    [CourseName]    NVARCHAR(100) NOT NULL UNIQUE, -- 'Play School', 'Evening Tuition', 'Both'
    [Description]   NVARCHAR(255) NULL,
    [StartTime]     NVARCHAR(20) NOT NULL,        -- e.g. '1:30 PM'
    [EndTime]       NVARCHAR(20) NOT NULL,        -- e.g. '4:30 PM'
    [AdmissionFee]  DECIMAL(18,2) DEFAULT 0.00 NOT NULL,
    [MonthlyFee]    DECIMAL(18,2) DEFAULT 0.00 NOT NULL,
    [IsActive]      BIT DEFAULT 1 NOT NULL,
    CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED ([CourseID] ASC)
);
GO

-- ----------------------------------------------------------------------------
-- 3. Student Table
-- ----------------------------------------------------------------------------
CREATE TABLE [dbo].[Student] (
    [StudentID]     INT IDENTITY(1,1) NOT NULL,
    [AdmissionNo]   NVARCHAR(50) NOT NULL UNIQUE,
    [FullName]      NVARCHAR(150) NOT NULL,
    [Gender]        NVARCHAR(10) NOT NULL, -- 'Male', 'Female', 'Other'
    [DateOfBirth]   DATE NOT NULL,
    [BloodGroup]    NVARCHAR(10) NULL,
    [SchoolName]    NVARCHAR(150) NULL,
    [Standard]      NVARCHAR(50) NOT NULL, -- e.g. 'LKG', 'Class 5'
    [Address]       NVARCHAR(500) NOT NULL,
    [PhotoPath]     NVARCHAR(255) DEFAULT '/Images/Students/default-avatar.png',
    [CreatedAt]     DATETIME DEFAULT GETDATE(),
    CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED ([StudentID] ASC)
);
GO

-- ----------------------------------------------------------------------------
-- 4. Parent Table
-- ----------------------------------------------------------------------------
CREATE TABLE [dbo].[Parent] (
    [ParentID]            INT IDENTITY(1,1) NOT NULL,
    [StudentID]           INT NOT NULL UNIQUE,
    [FatherName]          NVARCHAR(150) NOT NULL,
    [FatherMobile]        NVARCHAR(15) NOT NULL,
    [FatherWhatsApp]      NVARCHAR(15) NULL,
    [FatherEmail]         NVARCHAR(100) NULL,
    [FatherOccupation]    NVARCHAR(100) NULL,
    [FatherOfficeAddress] NVARCHAR(300) NULL,
    [MotherName]          NVARCHAR(150) NOT NULL,
    [MotherMobile]        NVARCHAR(15) NOT NULL,
    [MotherWhatsApp]      NVARCHAR(15) NULL,
    [MotherEmail]         NVARCHAR(100) NULL,
    [MotherOccupation]    NVARCHAR(100) NULL,
    [MotherOfficeAddress] NVARCHAR(300) NULL,
    CONSTRAINT [PK_Parent] PRIMARY KEY CLUSTERED ([ParentID] ASC),
    CONSTRAINT [FK_Parent_Student] FOREIGN KEY ([StudentID]) REFERENCES [dbo].[Student] ([StudentID]) ON DELETE CASCADE
);
GO

-- ----------------------------------------------------------------------------
-- 5. Guardian Table
-- ----------------------------------------------------------------------------
CREATE TABLE [dbo].[Guardian] (
    [GuardianID]    INT IDENTITY(1,1) NOT NULL,
    [StudentID]     INT NOT NULL,
    [GuardianName]  NVARCHAR(150) NOT NULL,
    [Relationship]  NVARCHAR(50) NOT NULL,
    [MobileNumber]  NVARCHAR(15) NOT NULL,
    [Address]       NVARCHAR(300) NULL,
    CONSTRAINT [PK_Guardian] PRIMARY KEY CLUSTERED ([GuardianID] ASC),
    CONSTRAINT [FK_Guardian_Student] FOREIGN KEY ([StudentID]) REFERENCES [dbo].[Student] ([StudentID]) ON DELETE CASCADE
);
GO

-- ----------------------------------------------------------------------------
-- 6. Emergency Contact Table
-- ----------------------------------------------------------------------------
CREATE TABLE [dbo].[EmergencyContact] (
    [EmergencyID]   INT IDENTITY(1,1) NOT NULL,
    [StudentID]     INT NOT NULL,
    [ContactName]   NVARCHAR(150) NOT NULL,
    [Relationship]  NVARCHAR(50) NOT NULL,
    [PhoneNumber]   NVARCHAR(15) NOT NULL,
    [DoctorName]    NVARCHAR(150) NULL,
    [DoctorPhone]   NVARCHAR(15) NULL,
    [Allergies]     NVARCHAR(500) NULL,
    [HealthIssues]  NVARCHAR(500) NULL,
    CONSTRAINT [PK_EmergencyContact] PRIMARY KEY CLUSTERED ([EmergencyID] ASC),
    CONSTRAINT [FK_EmergencyContact_Student] FOREIGN KEY ([StudentID]) REFERENCES [dbo].[Student] ([StudentID]) ON DELETE CASCADE
);
GO

-- ----------------------------------------------------------------------------
-- 7. Pickup Authorization Table
-- ----------------------------------------------------------------------------
CREATE TABLE [dbo].[PickupAuthorization] (
    [PickupID]          INT IDENTITY(1,1) NOT NULL,
    [StudentID]         INT NOT NULL,
    [PickupPerson]      NVARCHAR(150) NOT NULL,
    [PickupTime]        NVARCHAR(50) NOT NULL,
    [AuthorizedPerson]  NVARCHAR(150) NOT NULL,
    [IDProofNumber]     NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_PickupAuthorization] PRIMARY KEY CLUSTERED ([PickupID] ASC),
    CONSTRAINT [FK_PickupAuthorization_Student] FOREIGN KEY ([StudentID]) REFERENCES [dbo].[Student] ([StudentID]) ON DELETE CASCADE
);
GO

-- ----------------------------------------------------------------------------
-- 8. Admission Table
-- ----------------------------------------------------------------------------
CREATE TABLE [dbo].[Admission] (
    [AdmissionID]      INT IDENTITY(1,1) NOT NULL,
    [AdmissionNo]       NVARCHAR(50) NOT NULL UNIQUE,
    [StudentID]         INT NOT NULL,
    [CourseID]          INT NOT NULL,
    [AdmissionDate]     DATE NOT NULL,
    [AcademicYear]      NVARCHAR(20) NOT NULL, -- e.g., '2026-2027'
    [ProgramType]       NVARCHAR(50) NOT NULL, -- 'Play School', 'Evening Tuition', 'Both'
    [ParentSignature]   NVARCHAR(100) NULL,
    [StaffSignature]    NVARCHAR(100) NULL,
    [DeclarationDate]   DATE DEFAULT GETDATE(),
    [Status]            NVARCHAR(20) DEFAULT 'Active' NOT NULL, -- 'Active', 'Completed', 'Cancelled'
    [CreatedAt]         DATETIME DEFAULT GETDATE(),
    CONSTRAINT [PK_Admission] PRIMARY KEY CLUSTERED ([AdmissionID] ASC),
    CONSTRAINT [FK_Admission_Student] FOREIGN KEY ([StudentID]) REFERENCES [dbo].[Student] ([StudentID]),
    CONSTRAINT [FK_Admission_Course] FOREIGN KEY ([CourseID]) REFERENCES [dbo].[Course] ([CourseID])
);
GO

-- ----------------------------------------------------------------------------
-- 9. Fee Table
-- ----------------------------------------------------------------------------
CREATE TABLE [dbo].[Fee] (
    [FeeID]             INT IDENTITY(1,1) NOT NULL,
    [AdmissionID]       INT NOT NULL,
    [StudentID]         INT NOT NULL,
    [AdmissionFee]      DECIMAL(18,2) DEFAULT 0.00 NOT NULL,
    [MonthlyFee]        DECIMAL(18,2) DEFAULT 0.00 NOT NULL,
    [Discount]          DECIMAL(18,2) DEFAULT 0.00 NOT NULL,
    [TotalAmount]       DECIMAL(18,2) DEFAULT 0.00 NOT NULL,
    [AmountPaid]        DECIMAL(18,2) DEFAULT 0.00 NOT NULL,
    [BalanceAmount]     DECIMAL(18,2) DEFAULT 0.00 NOT NULL,
    [PaymentMethod]     NVARCHAR(50) NOT NULL, -- 'Cash', 'UPI', 'NetBanking', 'Cheque'
    [ReceiptNumber]     NVARCHAR(50) NOT NULL UNIQUE,
    [PaymentStatus]     NVARCHAR(20) NOT NULL, -- 'Paid', 'Partial', 'Pending'
    [PaymentDate]       DATETIME DEFAULT GETDATE(),
    [FeeForMonth]       NVARCHAR(30) NULL, -- e.g. 'July 2026'
    CONSTRAINT [PK_Fee] PRIMARY KEY CLUSTERED ([FeeID] ASC),
    CONSTRAINT [FK_Fee_Admission] FOREIGN KEY ([AdmissionID]) REFERENCES [dbo].[Admission] ([AdmissionID]),
    CONSTRAINT [FK_Fee_Student] FOREIGN KEY ([StudentID]) REFERENCES [dbo].[Student] ([StudentID])
);
GO

-- ----------------------------------------------------------------------------
-- 10. Attendance Table
-- ----------------------------------------------------------------------------
CREATE TABLE [dbo].[Attendance] (
    [AttendanceID]      INT IDENTITY(1,1) NOT NULL,
    [StudentID]         INT NOT NULL,
    [AttendanceDate]    DATE NOT NULL,
    [Status]            NVARCHAR(15) NOT NULL, -- 'Present', 'Absent', 'Late'
    [Remarks]           NVARCHAR(255) NULL,
    [RecordedAt]        DATETIME DEFAULT GETDATE(),
    CONSTRAINT [PK_Attendance] PRIMARY KEY CLUSTERED ([AttendanceID] ASC),
    CONSTRAINT [FK_Attendance_Student] FOREIGN KEY ([StudentID]) REFERENCES [dbo].[Student] ([StudentID]),
    CONSTRAINT [UQ_Attendance_Student_Date] UNIQUE ([StudentID], [AttendanceDate])
);
GO
