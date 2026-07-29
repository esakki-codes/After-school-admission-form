# Entity Relationship (ER) Diagram
## After School Admission Management System

The following ER Diagram describes the relational structure, entities, attributes, primary keys, foreign keys, and cardinalities of the database.

```mermaid
erDiagram
    ADMIN {
        int AdminID PK
        string Username
        string PasswordHash
        string FullName
        string Email
        string Mobile
        string SecurityQuestion
        string SecurityAnswer
        datetime LastLoginDate
    }

    COURSE {
        int CourseID PK
        string CourseName
        string Description
        string StartTime
        string EndTime
        decimal AdmissionFee
        decimal MonthlyFee
    }

    STUDENT {
        int StudentID PK
        string AdmissionNo UK
        string FullName
        string Gender
        date DateOfBirth
        string BloodGroup
        string SchoolName
        string Standard
        string Address
        string PhotoPath
    }

    PARENT {
        int ParentID PK
        int StudentID FK
        string FatherName
        string FatherMobile
        string FatherWhatsApp
        string FatherEmail
        string FatherOccupation
        string FatherOfficeAddress
        string MotherName
        string MotherMobile
        string MotherWhatsApp
        string MotherEmail
        string MotherOccupation
        string MotherOfficeAddress
    }

    GUARDIAN {
        int GuardianID PK
        int StudentID FK
        string GuardianName
        string Relationship
        string MobileNumber
        string Address
    }

    EMERGENCY_CONTACT {
        int EmergencyID PK
        int StudentID FK
        string ContactName
        string Relationship
        string PhoneNumber
        string DoctorName
        string DoctorPhone
        string Allergies
        string HealthIssues
    }

    PICKUP_AUTHORIZATION {
        int PickupID PK
        int StudentID FK
        string PickupPerson
        string PickupTime
        string AuthorizedPerson
        string IDProofNumber
    }

    ADMISSION {
        int AdmissionID PK
        string AdmissionNo UK
        int StudentID FK
        int CourseID FK
        date AdmissionDate
        string AcademicYear
        string ProgramType
        string ParentSignature
        string StaffSignature
        string Status
    }

    FEE {
        int FeeID PK
        int AdmissionID FK
        int StudentID FK
        decimal AdmissionFee
        decimal MonthlyFee
        decimal Discount
        decimal TotalAmount
        decimal AmountPaid
        decimal BalanceAmount
        string PaymentMethod
        string ReceiptNumber UK
        string PaymentStatus
        datetime PaymentDate
    }

    ATTENDANCE {
        int AttendanceID PK
        int StudentID FK
        date AttendanceDate
        string Status
        string Remarks
    }

    STUDENT ||--|| PARENT : "has 1:1"
    STUDENT ||--o| GUARDIAN : "has 1:N"
    STUDENT ||--o| EMERGENCY_CONTACT : "has 1:N"
    STUDENT ||--o| PICKUP_AUTHORIZATION : "has 1:N"
    STUDENT ||--|| ADMISSION : "enrolls in"
    COURSE ||--o{ ADMISSION : "defines"
    ADMISSION ||--o{ FEE : "generates"
    STUDENT ||--o{ ATTENDANCE : "records daily"
```

### Table Relationships Summary

1. **Student - Parent**: 1 to 1 Relationship. Each student must have parent records (Father & Mother details).
2. **Student - Guardian**: 1 to 1 (or 1 to Many) Relationship for guardian details.
3. **Student - EmergencyContact**: 1 to 1 (or 1 to Many) for emergency contact and medical details.
4. **Student - PickupAuthorization**: 1 to 1 for authorized pickup personnel and ID proofs.
5. **Student - Admission**: 1 to 1 (or 1 to Many historical admissions).
6. **Course - Admission**: 1 to Many. A course (Play School, Evening Tuition, Both) can have multiple student admissions.
7. **Admission - Fee**: 1 to Many. Each admission creates an initial fee record and ongoing monthly payment receipts.
8. **Student - Attendance**: 1 to Many. A student has one attendance record per day.
