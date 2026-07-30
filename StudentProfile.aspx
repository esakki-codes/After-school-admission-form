<%@ Page Title="Student Profile Dossier" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StudentProfile.aspx.cs" Inherits="AfterSchoolAdmission.StudentProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <!-- Page Action Buttons -->
        <div class="d-flex justify-content-between align-items-center mb-4 no-print">
            <div>
                <h3 class="fw-bold text-dark mb-1">Student Profile Dossier</h3>
                <p class="text-muted small mb-0">Detailed student record, parent details, emergency contact & pickup info</p>
            </div>
            <div class="d-flex gap-2">
                <button type="button" class="btn btn-outline-primary fw-semibold btn-print" onclick="printReport()">
                    <i class="fa-solid fa-print me-1"></i> Print Profile
                </button>
                <a href="StudentList.aspx" class="btn btn-outline-secondary fw-semibold">
                    <i class="fa-solid fa-arrow-left me-1"></i> Back to Student List
                </a>
            </div>
        </div>

        <div class="printable-area">
            <!-- Header Card / ID Header -->
            <div class="card border-0 shadow-sm rounded-4 mb-4">
                <div class="card-body p-4">
                    <div class="row align-items-center">
                        <div class="col-md-3 text-center mb-3 mb-md-0">
                            <asp:Image ID="imgStudentPhoto" runat="server" CssClass="rounded-4 border shadow-sm" Width="140" Height="160" Style="object-fit: cover;" />
                        </div>
                        <div class="col-md-6">
                            <span class="badge bg-primary px-3 py-2 rounded-pill mb-2"><asp:Literal ID="litProgramType" runat="server"></asp:Literal></span>
                            <h2 class="fw-bold text-dark mb-1"><asp:Literal ID="litFullName" runat="server"></asp:Literal></h2>
                            <p class="text-muted mb-2"><i class="fa-solid fa-id-card me-1"></i> Admission No: <strong class="text-dark"><asp:Literal ID="litAdmissionNo" runat="server"></asp:Literal></strong></p>
                            <div class="d-flex flex-wrap gap-3 text-secondary fs-6">
                                <span><i class="fa-solid fa-graduation-cap me-1"></i> Class: <strong><asp:Literal ID="litStandard" runat="server"></asp:Literal></strong></span>
                                <span><i class="fa-solid fa-calendar me-1"></i> DOB: <strong><asp:Literal ID="litDOB" runat="server"></asp:Literal></strong></span>
                                <span><i class="fa-solid fa-droplet me-1 text-danger"></i> Blood Group: <strong><asp:Literal ID="litBloodGroup" runat="server"></asp:Literal></strong></span>
                            </div>
                        </div>
                        <div class="col-md-3 border-start text-center text-md-start ps-md-4">
                            <div class="small text-muted mb-1">Academic Year:</div>
                            <h5 class="fw-bold text-dark"><asp:Literal ID="litAcademicYear" runat="server"></asp:Literal></h5>
                            <div class="small text-muted mt-2 mb-1">School Name:</div>
                            <div class="fw-semibold text-dark"><asp:Literal ID="litSchoolName" runat="server"></asp:Literal></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Grid of Details -->
            <div class="row g-4 mb-4">
                <!-- Parent Information -->
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm rounded-4 h-100">
                        <div class="card-header bg-white py-3 border-bottom">
                            <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-users text-primary me-2"></i>Parent Information</h5>
                        </div>
                        <div class="card-body">
                            <!-- Father -->
                            <h6 class="fw-bold text-primary mb-2">Father Details</h6>
                            <table class="table table-sm table-borderless mb-3">
                                <tr><td class="text-muted" style="width: 35%;">Name:</td><td class="fw-bold"><asp:Literal ID="litFatherName" runat="server"></asp:Literal></td></tr>
                                <tr><td class="text-muted">Mobile:</td><td class="fw-semibold"><asp:Literal ID="litFatherMobile" runat="server"></asp:Literal></td></tr>
                                <tr><td class="text-muted">WhatsApp:</td><td><asp:Literal ID="litFatherWhatsApp" runat="server"></asp:Literal></td></tr>
                                <tr><td class="text-muted">Email:</td><td><asp:Literal ID="litFatherEmail" runat="server"></asp:Literal></td></tr>
                                <tr><td class="text-muted">Occupation:</td><td><asp:Literal ID="litFatherOccupation" runat="server"></asp:Literal></td></tr>
                            </table>
                            <hr />
                            <!-- Mother -->
                            <h6 class="fw-bold text-primary mb-2">Mother Details</h6>
                            <table class="table table-sm table-borderless mb-0">
                                <tr><td class="text-muted" style="width: 35%;">Name:</td><td class="fw-bold"><asp:Literal ID="litMotherName" runat="server"></asp:Literal></td></tr>
                                <tr><td class="text-muted">Mobile:</td><td class="fw-semibold"><asp:Literal ID="litMotherMobile" runat="server"></asp:Literal></td></tr>
                                <tr><td class="text-muted">WhatsApp:</td><td><asp:Literal ID="litMotherWhatsApp" runat="server"></asp:Literal></td></tr>
                                <tr><td class="text-muted">Email:</td><td><asp:Literal ID="litMotherEmail" runat="server"></asp:Literal></td></tr>
                                <tr><td class="text-muted">Occupation:</td><td><asp:Literal ID="litMotherOccupation" runat="server"></asp:Literal></td></tr>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Emergency, Guardian & Pickup Info -->
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm rounded-4 h-100">
                        <div class="card-header bg-white py-3 border-bottom">
                            <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-shield-halved text-success me-2"></i>Guardian, Emergency & Pickup Details</h5>
                        </div>
                        <div class="card-body">
                            <!-- Guardian -->
                            <h6 class="fw-bold text-success mb-2">Guardian Contact</h6>
                            <p class="mb-1"><strong><asp:Literal ID="litGuardianName" runat="server"></asp:Literal></strong> (<asp:Literal ID="litGuardianRel" runat="server"></asp:Literal>)</p>
                            <p class="text-muted small mb-3"><i class="fa-solid fa-phone me-1"></i> <asp:Literal ID="litGuardianMobile" runat="server"></asp:Literal></p>
                            <hr />

                            <!-- Emergency & Medical -->
                            <h6 class="fw-bold text-danger mb-2">Medical & Emergency</h6>
                            <table class="table table-sm table-borderless mb-3">
                                <tr><td class="text-muted" style="width: 35%;">Doctor Name:</td><td><asp:Literal ID="litDoctorName" runat="server"></asp:Literal></td></tr>
                                <tr><td class="text-muted">Doctor Phone:</td><td><asp:Literal ID="litDoctorPhone" runat="server"></asp:Literal></td></tr>
                                <tr><td class="text-muted">Allergies:</td><td class="text-danger fw-semibold"><asp:Literal ID="litAllergies" runat="server"></asp:Literal></td></tr>
                                <tr><td class="text-muted">Health Issues:</td><td><asp:Literal ID="litHealthIssues" runat="server"></asp:Literal></td></tr>
                            </table>
                            <hr />

                            <!-- Pickup -->
                            <h6 class="fw-bold text-warning text-dark mb-2">Authorized Pickup</h6>
                            <table class="table table-sm table-borderless mb-0">
                                <tr><td class="text-muted" style="width: 35%;">Pickup Person:</td><td class="fw-bold"><asp:Literal ID="litPickupPerson" runat="server"></asp:Literal></td></tr>
                                <tr><td class="text-muted">Pickup Time:</td><td><asp:Literal ID="litPickupTime" runat="server"></asp:Literal></td></tr>
                                <tr><td class="text-muted">ID Proof No:</td><td><asp:Literal ID="litIDProof" runat="server"></asp:Literal></td></tr>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Address & Fee Summary Card -->
                <div class="col-md-12">
                    <div class="card border-0 shadow-sm rounded-4">
                        <div class="card-body p-4">
                            <div class="row align-items-center">
                                <div class="col-md-6 mb-3 mb-md-0 border-end pe-md-4">
                                    <h6 class="fw-bold text-dark"><i class="fa-solid fa-location-dot me-2 text-danger"></i>Residential Address</h6>
                                    <p class="text-muted mb-0"><asp:Literal ID="litAddress" runat="server"></asp:Literal></p>
                                </div>
                                <div class="col-md-6 ps-md-4">
                                    <h6 class="fw-bold text-dark"><i class="fa-solid fa-receipt me-2 text-primary"></i>Fee & Payment Status</h6>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <span class="text-muted small">Total Fee Amount:</span>
                                            <div class="fw-bold fs-5">₹<asp:Literal ID="litTotalFee" runat="server"></asp:Literal></div>
                                        </div>
                                        <div>
                                            <span class="text-muted small">Payment Status:</span>
                                            <div><asp:Literal ID="litPaymentBadge" runat="server"></asp:Literal></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- RFID SMART CARDS SECTION -->
                <div class="col-md-12">
                    <div class="card border-0 shadow-sm rounded-4">
                        <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                            <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-id-card-clip text-primary me-2"></i>Official Parent & Guardian RFID Smart Cards</h5>
                            <button type="button" class="btn btn-sm btn-outline-primary rounded-pill no-print" onclick="downloadAllRFIDCardsPDF();">
                                <i class="fa-solid fa-download me-1"></i> Export RFID Cards PDF
                            </button>
                        </div>
                        <div class="card-body p-4">
                            <div class="row g-4">
                                <!-- CARD 1: FATHER -->
                                <div class="col-md-6">
                                    <div class="rfid-card printable-rfid">
                                        <div class="rfid-header">
                                            <div class="rfid-logo-box">
                                                <img src="Images/logo.png" class="rfid-logo-img" alt="Logo" />
                                                <div>
                                                    <div class="fw-bold text-white small">TN HAPPY KIDS</div>
                                                    <small class="text-info" style="font-size: 0.7rem;">SMART PICKUP PASS</small>
                                                </div>
                                            </div>
                                            <div class="rfid-chip-icon"><i class="fa-solid fa-microchip text-dark" style="font-size: 0.8rem;"></i></div>
                                        </div>
                                        <div class="rfid-body">
                                            <div class="rfid-photo-container">
                                                <img src="Images/Students/default-avatar.png" alt="Father Photo" />
                                            </div>
                                            <div class="rfid-details">
                                                <div class="rfid-person-name"><asp:Literal ID="litRfidFatherName" runat="server">-</asp:Literal></div>
                                                <span class="rfid-rel-badge rfid-rel-father">Father</span>
                                                <div class="rfid-student-info mt-2">Student: <strong><asp:Literal ID="litRfidStudentName1" runat="server">-</asp:Literal></strong></div>
                                            </div>
                                        </div>
                                        <div class="rfid-footer">
                                            <div class="rfid-number-tag"><asp:Literal ID="litRfidFatherNo" runat="server">RFID-FAT-00000</asp:Literal></div>
                                            <div class="rfid-qr-box">
                                                <img id="imgAdminQrFather" src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=RFID-FAT-00000" alt="QR" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- CARD 2: MOTHER -->
                                <div class="col-md-6">
                                    <div class="rfid-card printable-rfid">
                                        <div class="rfid-header">
                                            <div class="rfid-logo-box">
                                                <img src="Images/logo.png" class="rfid-logo-img" alt="Logo" />
                                                <div>
                                                    <div class="fw-bold text-white small">TN HAPPY KIDS</div>
                                                    <small class="text-info" style="font-size: 0.7rem;">SMART PICKUP PASS</small>
                                                </div>
                                            </div>
                                            <div class="rfid-chip-icon"><i class="fa-solid fa-microchip text-dark" style="font-size: 0.8rem;"></i></div>
                                        </div>
                                        <div class="rfid-body">
                                            <div class="rfid-photo-container">
                                                <img src="Images/Students/default-avatar.png" alt="Mother Photo" />
                                            </div>
                                            <div class="rfid-details">
                                                <div class="rfid-person-name"><asp:Literal ID="litRfidMotherName" runat="server">-</asp:Literal></div>
                                                <span class="rfid-rel-badge rfid-rel-mother">Mother</span>
                                                <div class="rfid-student-info mt-2">Student: <strong><asp:Literal ID="litRfidStudentName2" runat="server">-</asp:Literal></strong></div>
                                            </div>
                                        </div>
                                        <div class="rfid-footer">
                                            <div class="rfid-number-tag"><asp:Literal ID="litRfidMotherNo" runat="server">RFID-MTH-00000</asp:Literal></div>
                                            <div class="rfid-qr-box">
                                                <img id="imgAdminQrMother" src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=RFID-MTH-00000" alt="QR" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- CARD 3: GUARDIAN 1 -->
                                <div class="col-md-6">
                                    <div class="rfid-card printable-rfid">
                                        <div class="rfid-header">
                                            <div class="rfid-logo-box">
                                                <img src="Images/logo.png" class="rfid-logo-img" alt="Logo" />
                                                <div>
                                                    <div class="fw-bold text-white small">TN HAPPY KIDS</div>
                                                    <small class="text-info" style="font-size: 0.7rem;">SMART PICKUP PASS</small>
                                                </div>
                                            </div>
                                            <div class="rfid-chip-icon"><i class="fa-solid fa-microchip text-dark" style="font-size: 0.8rem;"></i></div>
                                        </div>
                                        <div class="rfid-body">
                                            <div class="rfid-photo-container">
                                                <img src="Images/Students/default-avatar.png" alt="Guardian 1 Photo" />
                                            </div>
                                            <div class="rfid-details">
                                                <div class="rfid-person-name"><asp:Literal ID="litRfidG1Name" runat="server">-</asp:Literal></div>
                                                <span class="rfid-rel-badge rfid-rel-g1"><asp:Literal ID="litRfidG1Rel" runat="server">Guardian 1</asp:Literal></span>
                                                <div class="rfid-student-info mt-2">Student: <strong><asp:Literal ID="litRfidStudentName3" runat="server">-</asp:Literal></strong></div>
                                            </div>
                                        </div>
                                        <div class="rfid-footer">
                                            <div class="rfid-number-tag"><asp:Literal ID="litRfidG1No" runat="server">RFID-G1-00000</asp:Literal></div>
                                            <div class="rfid-qr-box">
                                                <img id="imgAdminQrG1" src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=RFID-G1-00000" alt="QR" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- CARD 4: GUARDIAN 2 -->
                                <div class="col-md-6">
                                    <div class="rfid-card printable-rfid">
                                        <div class="rfid-header">
                                            <div class="rfid-logo-box">
                                                <img src="Images/logo.png" class="rfid-logo-img" alt="Logo" />
                                                <div>
                                                    <div class="fw-bold text-white small">TN HAPPY KIDS</div>
                                                    <small class="text-info" style="font-size: 0.7rem;">SMART PICKUP PASS</small>
                                                </div>
                                            </div>
                                            <div class="rfid-chip-icon"><i class="fa-solid fa-microchip text-dark" style="font-size: 0.8rem;"></i></div>
                                        </div>
                                        <div class="rfid-body">
                                            <div class="rfid-photo-container">
                                                <img src="Images/Students/default-avatar.png" alt="Guardian 2 Photo" />
                                            </div>
                                            <div class="rfid-details">
                                                <div class="rfid-person-name"><asp:Literal ID="litRfidG2Name" runat="server">-</asp:Literal></div>
                                                <span class="rfid-rel-badge rfid-rel-g2"><asp:Literal ID="litRfidG2Rel" runat="server">Guardian 2</asp:Literal></span>
                                                <div class="rfid-student-info mt-2">Student: <strong><asp:Literal ID="litRfidStudentName4" runat="server">-</asp:Literal></strong></div>
                                            </div>
                                        </div>
                                        <div class="rfid-footer">
                                            <div class="rfid-number-tag"><asp:Literal ID="litRfidG2No" runat="server">RFID-G2-00000</asp:Literal></div>
                                            <div class="rfid-qr-box">
                                                <img id="imgAdminQrG2" src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=RFID-G2-00000" alt="QR" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
