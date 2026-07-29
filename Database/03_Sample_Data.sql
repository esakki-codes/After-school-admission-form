-- ============================================================================
-- AFTER SCHOOL ADMISSION MANAGEMENT SYSTEM
-- Seed Sample Data Script
-- Database Engine: SQL Server 2016+ / 2022
-- ============================================================================

USE [AfterSchoolDB];
GO

-- 1. Insert Master Admin
IF NOT EXISTS (SELECT 1 FROM [dbo].[Admin] WHERE Username = 'admin')
BEGIN
    INSERT INTO [dbo].[Admin] (Username, PasswordHash, FullName, Email, Mobile, SecurityQuestion, SecurityAnswer)
    VALUES (
        'admin',
        '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', -- SHA256 for 'admin123'
        'System Administrator',
        'admin@afterschool.com',
        '9876543210',
        'What is the name of your center?',
        'Bright Minds Center'
    );
END;
GO

-- 2. Insert Course Master Data
IF NOT EXISTS (SELECT 1 FROM [dbo].[Course] WHERE CourseName = 'Play School')
BEGIN
    INSERT INTO [dbo].[Course] (CourseName, Description, StartTime, EndTime, AdmissionFee, MonthlyFee)
    VALUES 
    ('Play School', 'After Lunch Play & Creative Activity Group', '1:30 PM', '4:30 PM', 1500.00, 2500.00),
    ('Evening Tuition', 'Academic Coaching & Homework Help', '5:00 PM', '7:30 PM', 1000.00, 2000.00),
    ('Both', 'Full Package: Play School + Evening Tuition Combo', '1:30 PM', '7:30 PM', 2000.00, 4000.00);
END;
GO

-- 3. Insert Sample Students & Admissions
-- Student 1: Play School
IF NOT EXISTS (SELECT 1 FROM [dbo].[Student] WHERE AdmissionNo = 'ADM-2026-0001')
BEGIN
    INSERT INTO [dbo].[Student] (AdmissionNo, FullName, Gender, DateOfBirth, BloodGroup, SchoolName, Standard, Address, PhotoPath)
    VALUES ('ADM-2026-0001', 'Aarav Sharma', 'Male', '2021-05-14', 'O+', 'St. Xavier School', 'LKG', '102 Rosewood Heights, MG Road', '/Images/Students/student1.jpg');
    
    DECLARE @S1 INT = SCOPE_IDENTITY();
    
    INSERT INTO [dbo].[Parent] (StudentID, FatherName, FatherMobile, FatherWhatsApp, FatherEmail, FatherOccupation, FatherOfficeAddress, MotherName, MotherMobile, MotherWhatsApp, MotherEmail, MotherOccupation, MotherOfficeAddress)
    VALUES (@S1, 'Rajesh Sharma', '9811223344', '9811223344', 'rajesh@example.com', 'Software Engineer', 'Tech Park Sec 5', 'Priya Sharma', '9811223345', '9811223345', 'priya@example.com', 'Architect', 'Design Studio Sec 2');

    INSERT INTO [dbo].[Guardian] (StudentID, GuardianName, Relationship, MobileNumber, Address)
    VALUES (@S1, 'Ramesh Sharma', 'Grandfather', '9811223399', '102 Rosewood Heights, MG Road');

    INSERT INTO [dbo].[EmergencyContact] (StudentID, ContactName, Relationship, PhoneNumber, DoctorName, DoctorPhone, Allergies, HealthIssues)
    VALUES (@S1, 'Priya Sharma', 'Mother', '9811223345', 'Dr. Mehta', '9988776655', 'Mild Peanut Allergy', 'None');

    INSERT INTO [dbo].[PickupAuthorization] (StudentID, PickupPerson, PickupTime, AuthorizedPerson, IDProofNumber)
    VALUES (@S1, 'Ramesh Sharma', '4:30 PM', 'Rajesh Sharma', 'AABB123456');

    INSERT INTO [dbo].[Admission] (AdmissionNo, StudentID, CourseID, AdmissionDate, AcademicYear, ProgramType, ParentSignature, StaffSignature)
    VALUES ('ADM-2026-0001', @S1, 1, '2026-06-01', '2026-2027', 'Play School', 'Rajesh Sharma', 'Staff Admin');

    DECLARE @A1 INT = SCOPE_IDENTITY();

    INSERT INTO [dbo].[Fee] (AdmissionID, StudentID, AdmissionFee, MonthlyFee, Discount, TotalAmount, AmountPaid, BalanceAmount, PaymentMethod, ReceiptNumber, PaymentStatus, FeeForMonth)
    VALUES (@A1, @S1, 1500.00, 2500.00, 200.00, 3800.00, 3800.00, 0.00, 'UPI', 'REC-2026-00001', 'Paid', 'July 2026');

    -- Attendance for Student 1
    INSERT INTO [dbo].[Attendance] (StudentID, AttendanceDate, Status, Remarks)
    VALUES (@S1, '2026-07-28', 'Present', 'Active in class'), (@S1, '2026-07-29', 'Present', 'On time');
END;
GO

-- Student 2: Evening Tuition
IF NOT EXISTS (SELECT 1 FROM [dbo].[Student] WHERE AdmissionNo = 'ADM-2026-0002')
BEGIN
    INSERT INTO [dbo].[Student] (AdmissionNo, FullName, Gender, DateOfBirth, BloodGroup, SchoolName, Standard, Address, PhotoPath)
    VALUES ('ADM-2026-0002', 'Ananya Patel', 'Female', '2017-09-20', 'B+', 'Green Valley Public School', 'Class 4', '45 Orchid Villas, Ring Road', '/Images/Students/student2.jpg');
    
    DECLARE @S2 INT = SCOPE_IDENTITY();
    
    INSERT INTO [dbo].[Parent] (StudentID, FatherName, FatherMobile, FatherWhatsApp, FatherEmail, FatherOccupation, FatherOfficeAddress, MotherName, MotherMobile, MotherWhatsApp, MotherEmail, MotherOccupation, MotherOfficeAddress)
    VALUES (@S2, 'Suresh Patel', '9822334455', '9822334455', 'suresh@example.com', 'Bank Manager', 'SBI Main Branch', 'Anita Patel', '9822334456', '9822334456', 'anita@example.com', 'Teacher', 'Green Valley School');

    INSERT INTO [dbo].[Guardian] (StudentID, GuardianName, Relationship, MobileNumber, Address)
    VALUES (@S2, 'Suresh Patel', 'Father', '9822334455', '45 Orchid Villas, Ring Road');

    INSERT INTO [dbo].[EmergencyContact] (StudentID, ContactName, Relationship, PhoneNumber, DoctorName, DoctorPhone, Allergies, HealthIssues)
    VALUES (@S2, 'Suresh Patel', 'Father', '9822334455', 'Dr. Kapoor', '9977665544', 'None', 'Asthma (uses inhaler)');

    INSERT INTO [dbo].[PickupAuthorization] (StudentID, PickupPerson, PickupTime, AuthorizedPerson, IDProofNumber)
    VALUES (@S2, 'Anita Patel', '7:30 PM', 'Anita Patel', 'CCDD987654');

    INSERT INTO [dbo].[Admission] (AdmissionNo, StudentID, CourseID, AdmissionDate, AcademicYear, ProgramType, ParentSignature, StaffSignature)
    VALUES ('ADM-2026-0002', @S2, 2, '2026-06-15', '2026-2027', 'Evening Tuition', 'Suresh Patel', 'Staff Admin');

    DECLARE @A2 INT = SCOPE_IDENTITY();

    INSERT INTO [dbo].[Fee] (AdmissionID, StudentID, AdmissionFee, MonthlyFee, Discount, TotalAmount, AmountPaid, BalanceAmount, PaymentMethod, ReceiptNumber, PaymentStatus, FeeForMonth)
    VALUES (@A2, @S2, 1000.00, 2000.00, 0.00, 3000.00, 1500.00, 1500.00, 'Cash', 'REC-2026-00002', 'Partial', 'July 2026');

    -- Attendance for Student 2
    INSERT INTO [dbo].[Attendance] (StudentID, AttendanceDate, Status, Remarks)
    VALUES (@S2, '2026-07-28', 'Late', 'Arrived 15 mins late'), (@S2, '2026-07-29', 'Present', 'Good participation');
END;
GO

-- Student 3: Both Programs
IF NOT EXISTS (SELECT 1 FROM [dbo].[Student] WHERE AdmissionNo = 'ADM-2026-0003')
BEGIN
    INSERT INTO [dbo].[Student] (AdmissionNo, FullName, Gender, DateOfBirth, BloodGroup, SchoolName, Standard, Address, PhotoPath)
    VALUES ('ADM-2026-0003', 'Vivaan Verma', 'Male', '2019-11-05', 'A+', 'Delhi Public School', 'UKG', '78 Sunflower Enclave', '/Images/Students/student3.jpg');
    
    DECLARE @S3 INT = SCOPE_IDENTITY();
    
    INSERT INTO [dbo].[Parent] (StudentID, FatherName, FatherMobile, FatherWhatsApp, FatherEmail, FatherOccupation, FatherOfficeAddress, MotherName, MotherMobile, MotherWhatsApp, MotherEmail, MotherOccupation, MotherOfficeAddress)
    VALUES (@S3, 'Amit Verma', '9833445566', '9833445566', 'amit@example.com', 'Business Owner', 'Market Complex Sec 11', 'Sunita Verma', '9833445567', '9833445567', 'sunita@example.com', 'Doctor', 'City Hospital');

    INSERT INTO [dbo].[Guardian] (StudentID, GuardianName, Relationship, MobileNumber, Address)
    VALUES (@S3, 'Amit Verma', 'Father', '9833445566', '78 Sunflower Enclave');

    INSERT INTO [dbo].[EmergencyContact] (StudentID, ContactName, Relationship, PhoneNumber, DoctorName, DoctorPhone, Allergies, HealthIssues)
    VALUES (@S3, 'Sunita Verma', 'Mother', '9833445567', 'Dr. Sunita Verma', '9833445567', 'Lactose Intolerant', 'None');

    INSERT INTO [dbo].[PickupAuthorization] (StudentID, PickupPerson, PickupTime, AuthorizedPerson, IDProofNumber)
    VALUES (@S3, 'Driver Ramesh', '7:30 PM', 'Amit Verma', 'EEFF456789');

    INSERT INTO [dbo].[Admission] (AdmissionNo, StudentID, CourseID, AdmissionDate, AcademicYear, ProgramType, ParentSignature, StaffSignature)
    VALUES ('ADM-2026-0003', @S3, 3, '2026-07-01', '2026-2027', 'Both', 'Amit Verma', 'Staff Admin');

    DECLARE @A3 INT = SCOPE_IDENTITY();

    INSERT INTO [dbo].[Fee] (AdmissionID, StudentID, AdmissionFee, MonthlyFee, Discount, TotalAmount, AmountPaid, BalanceAmount, PaymentMethod, ReceiptNumber, PaymentStatus, FeeForMonth)
    VALUES (@A3, @S3, 2000.00, 4000.00, 500.00, 5500.00, 5500.00, 0.00, 'NetBanking', 'REC-2026-00003', 'Paid', 'July 2026');

    -- Attendance for Student 3
    INSERT INTO [dbo].[Attendance] (StudentID, AttendanceDate, Status, Remarks)
    VALUES (@S3, '2026-07-28', 'Present', 'Completed all activities'), (@S3, '2026-07-29', 'Present', 'Excellent');
END;
GO
