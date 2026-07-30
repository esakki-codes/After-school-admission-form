<%@ Page Title="Application Submitted" Language="C#" MasterPageFile="~/PublicSite.Master" AutoEventWireup="true" CodeBehind="PublicReceipt.aspx.cs" Inherits="AfterSchoolAdmission.PublicReceipt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-3">
        <!-- Success Banner -->
        <div class="text-center mb-4">
            <div class="d-inline-flex align-items-center justify-content-center bg-primary text-white rounded-circle mb-3" style="width: 75px; height: 75px; background: #2563eb !important; box-shadow: 0 0 20px rgba(56,189,248,0.5);">
                <i class="fa-solid fa-check fa-3x"></i>
            </div>
            <h2 class="fw-bold text-white mb-1">Admission Application Submitted!</h2>
            <p class="text-muted">TN Happy Kids School - Official Admission Confirmation Summary</p>
            <div class="d-flex flex-wrap justify-content-center gap-2 mt-3 no-print">
                <button type="button" id="btnDownloadPDF" class="btn btn-success btn-lg fw-bold px-4 rounded-pill" onclick="downloadReceiptPDF();">
                    <i class="fa-solid fa-file-pdf me-2"></i> Download PDF Receipt
                </button>
                <button type="button" class="btn btn-primary-blue btn-lg fw-bold px-4 rounded-pill" onclick="window.print();">
                    <i class="fa-solid fa-print me-2"></i> Print Admission Receipt
                </button>
            </div>
        </div>

        <!-- Printable Key Summary Dossier Card -->
        <div class="card border-0 shadow-lg rounded-4 overflow-hidden printable-area" style="background: #1c2541; border: 2px solid #2563eb !important; color: #ffffff;">
            <div class="card-body p-4 p-md-5">

                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center border-bottom border-secondary pb-4 mb-4">
                    <div class="d-flex align-items-center gap-3">
                        <img src="Images/logo.png" alt="Logo" height="68" style="object-fit: contain; background: #ffffff; padding: 4px; border-radius: 50%;" />
                        <div>
                            <h3 class="fw-bold text-white mb-0">TN Happy Kids</h3>
                            <small class="text-info fw-bold">(An Unit of MAAS Group of Companies) • After School Admission</small>
                        </div>
                    </div>
                    <div class="text-end">
                        <span class="badge bg-success px-3 py-2 fs-6 fw-bold mb-1" style="background-color: #059669 !important;">CONFIRMED</span>
                        <div class="fw-bold text-info fs-5"><asp:Literal ID="litAdmissionNo" runat="server">-</asp:Literal></div>
                        <small class="text-muted">Date: <asp:Literal ID="litDate" runat="server">-</asp:Literal></small>
                    </div>
                </div>

                <!-- 1. STUDENT ESSENTIAL SUMMARY -->
                <div class="guardian-card-box border-primary mb-4" style="background: #0f172a;">
                    <h5 class="fw-bold text-info mb-3 border-bottom border-secondary pb-2">
                        <i class="fa-solid fa-user-graduate me-2"></i>Student Key Summary
                    </h5>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <span class="text-muted small d-block">Student Full Name</span>
                            <span class="fw-bold fs-5 text-white"><asp:Literal ID="litStudentName" runat="server">-</asp:Literal></span>
                        </div>
                        <div class="col-md-3">
                            <span class="text-muted small d-block">Gender</span>
                            <span class="fw-bold text-white"><asp:Literal ID="litGender" runat="server">-</asp:Literal></span>
                        </div>
                        <div class="col-md-3">
                            <span class="text-muted small d-block">Class / Standard</span>
                            <span class="fw-bold text-white"><asp:Literal ID="litStandard" runat="server">-</asp:Literal></span>
                        </div>
                        <div class="col-md-6">
                            <span class="text-muted small d-block">Current School Name</span>
                            <span class="fw-bold text-white"><asp:Literal ID="litSchoolName" runat="server">-</asp:Literal></span>
                        </div>
                        <div class="col-md-6">
                            <span class="text-muted small d-block">Which Route Coming From?</span>
                            <span class="fw-bold text-info"><asp:Literal ID="litRouteComingFrom" runat="server">-</asp:Literal></span>
                        </div>
                    </div>
                </div>

                <!-- 2. FATHER & MOTHER ESSENTIAL SUMMARY -->
                <div class="row g-4 mb-4">
                    <!-- Father -->
                    <div class="col-md-6">
                        <div class="guardian-card-box border-primary h-100" style="background: #0f172a;">
                            <h6 class="fw-bold text-primary mb-3 border-bottom border-secondary pb-2">
                                <i class="fa-solid fa-user me-2"></i>Father Details
                            </h6>
                            <div class="mb-2"><span class="text-muted small d-block">Father Name</span><span class="fw-bold text-white"><asp:Literal ID="litFatherName" runat="server">-</asp:Literal></span></div>
                            <div class="mb-2"><span class="text-muted small d-block">Aadhaar Number</span><span class="fw-bold text-info"><asp:Literal ID="litFatherAadhaar" runat="server">-</asp:Literal></span></div>
                            <div><span class="text-muted small d-block">Mobile Number</span><span class="fw-bold text-white"><asp:Literal ID="litFatherMobile" runat="server">-</asp:Literal></span></div>
                        </div>
                    </div>

                    <!-- Mother -->
                    <div class="col-md-6">
                        <div class="guardian-card-box border-primary h-100" style="background: #0f172a;">
                            <h6 class="fw-bold text-primary mb-3 border-bottom border-secondary pb-2">
                                <i class="fa-solid fa-user-nurse me-2"></i>Mother Details
                            </h6>
                            <div class="mb-2"><span class="text-muted small d-block">Mother Name</span><span class="fw-bold text-white"><asp:Literal ID="litMotherName" runat="server">-</asp:Literal></span></div>
                            <div class="mb-2"><span class="text-muted small d-block">Aadhaar Number</span><span class="fw-bold text-info"><asp:Literal ID="litMotherAadhaar" runat="server">-</asp:Literal></span></div>
                            <div><span class="text-muted small d-block">Mobile Number</span><span class="fw-bold text-white"><asp:Literal ID="litMotherMobile" runat="server">-</asp:Literal></span></div>
                        </div>
                    </div>
                </div>

                <!-- 3. GUARDIAN 1 & GUARDIAN 2 ESSENTIAL SUMMARY -->
                <div class="row g-4 mb-4">
                    <!-- Guardian 1 -->
                    <div class="col-md-6">
                        <div class="guardian-card-box border-info h-100" style="background: #0f172a;">
                            <h6 class="fw-bold text-info mb-3 border-bottom border-secondary pb-2">
                                <i class="fa-solid fa-shield-halved me-2"></i>Guardian 1 Details
                            </h6>
                            <div class="mb-2"><span class="text-muted small d-block">Guardian 1 Name</span><span class="fw-bold text-white"><asp:Literal ID="litGuardian1Name" runat="server">-</asp:Literal></span></div>
                            <div class="mb-2"><span class="text-muted small d-block">Relationship</span><span class="fw-bold text-white"><asp:Literal ID="litGuardian1Rel" runat="server">-</asp:Literal></span></div>
                            <div><span class="text-muted small d-block">Mobile Number</span><span class="fw-bold text-white"><asp:Literal ID="litGuardian1Mobile" runat="server">-</asp:Literal></span></div>
                        </div>
                    </div>

                    <!-- Guardian 2 -->
                    <div class="col-md-6">
                        <div class="guardian-card-box border-info h-100" style="background: #0f172a;">
                            <h6 class="fw-bold text-info mb-3 border-bottom border-secondary pb-2">
                                <i class="fa-solid fa-shield-halved me-2"></i>Guardian 2 Details
                            </h6>
                            <div class="mb-2"><span class="text-muted small d-block">Guardian 2 Name</span><span class="fw-bold text-white"><asp:Literal ID="litGuardian2Name" runat="server">-</asp:Literal></span></div>
                            <div class="mb-2"><span class="text-muted small d-block">Relationship</span><span class="fw-bold text-white"><asp:Literal ID="litGuardian2Rel" runat="server">-</asp:Literal></span></div>
                            <div><span class="text-muted small d-block">Mobile Number</span><span class="fw-bold text-white"><asp:Literal ID="litGuardian2Mobile" runat="server">-</asp:Literal></span></div>
                        </div>
                    </div>
                </div>

                <!-- 4. OFFICIAL PARENT & GUARDIAN RFID SMART PICKUP PASSES (AADHAAR CARD STYLE) -->
                <div class="border-top border-secondary pt-4 mt-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div>
                            <h5 class="fw-bold text-info mb-1">
                                <i class="fa-solid fa-id-card-clip me-2"></i>Official Parent & Guardian RFID Smart Cards (Aadhaar Format)
                            </h5>
                            <small class="text-muted">Generated Aadhaar-Style RFID Smart Pickup Cards for Authorized Pickups</small>
                        </div>
                        <button type="button" class="btn btn-sm btn-outline-info rounded-pill no-print" onclick="downloadAllRFIDCardsPDF();">
                            <i class="fa-solid fa-download me-1"></i> Download All 4 RFID Cards (PDF)
                        </button>
                    </div>

                    <div class="row g-4">
                        <!-- CARD 1: FATHER RFID CARD (ROYAL BLUE THEME) -->
                        <div class="col-md-6">
                            <div class="rfid-card rfid-card-father printable-rfid shadow-lg" id="rfidCardFather" style="border: 2px solid #2563eb !important; border-radius: 16px; overflow: hidden; background: #ffffff;">
                                <div class="rfid-header rfid-header-father d-flex justify-content-between align-items-center p-2 px-3" style="background: linear-gradient(135deg, #1e40af 0%, #1e3a8a 100%); border-bottom: 3px solid #3b82f6;">
                                    <div class="d-flex align-items-center gap-2">
                                        <img src="Images/logo.png" class="rfid-logo-img" alt="Logo" style="width: 32px; height: 32px; max-width: 32px; max-height: 32px; object-fit: contain; border-radius: 50%; background: #ffffff; padding: 2px;" />
                                        <div>
                                            <div class="fw-bold text-white small" style="font-size: 0.8rem; line-height: 1;">TN HAPPY KIDS SCHOOL</div>
                                            <div class="text-warning fw-bold" style="font-size: 0.62rem; letter-spacing: 0.05em;">AUTHORISED PICKUP PASS</div>
                                        </div>
                                    </div>
                                    <div class="rfid-chip-icon" style="width: 32px; height: 24px; background: linear-gradient(135deg, #fbbf24 0%, #d97706 100%); border-radius: 4px; border: 1px solid #f59e0b; display: flex; align-items: center; justify-content: center;">
                                        <i class="fa-solid fa-microchip text-dark" style="font-size: 0.75rem;"></i>
                                    </div>
                                </div>
                                <div class="rfid-body p-3 bg-white text-dark d-flex gap-3 align-items-center">
                                    <div class="rfid-photo-frame rfid-photo-father" style="width: 85px; height: 105px; border-radius: 8px; border: 2px solid #2563eb; overflow: hidden; background: #f8fafc; flex-shrink: 0;">
                                        <img id="imgRfidFatherPhoto" src="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 24 24' fill='%2338bdf8'><path d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 4c1.93 0 3.5 1.57 3.5 3.5S13.93 13 12 13s-3.5-1.57-3.5-3.5S10.07 6 12 6zm0 14c-2.03 0-3.8-1.04-4.83-2.61.03-1.6 3.22-2.47 4.83-2.47s4.8 0.87 4.83 2.47C15.8 18.96 14.03 20 12 20z'/></svg>" alt="Father Photo" style="width: 100%; height: 100%; object-fit: cover;" />
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold text-dark fs-5 mb-0" id="lblRfidFatherName"><asp:Literal ID="litRfidFatherName" runat="server">-</asp:Literal></div>
                                        <span class="badge bg-primary text-white text-uppercase px-2 py-1 mb-1" style="background-color: #2563eb !important;">Father</span>
                                        <div class="small text-secondary mb-1">Student: <strong class="text-dark" id="lblRfidStudentName1"><asp:Literal ID="litRfidStudentName1" runat="server">-</asp:Literal></strong></div>
                                        <div class="small text-primary fw-bold mb-1" style="font-size: 0.72rem;">STUDENT REG: <span id="lblRfidStudentReg1"><asp:Literal ID="litRfidStudentReg1" runat="server">ADM-2026-000</asp:Literal></span></div>
                                        <div class="fw-bold text-danger font-monospace fs-6" id="lblRfidFatherNo"><asp:Literal ID="litRfidFatherNo" runat="server">4821 9842 1041</asp:Literal></div>
                                    </div>
                                    <div class="text-end flex-shrink-0" style="width: 70px;">
                                        <img id="imgQrFather" src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=482198421041" alt="QR Code" style="width: 65px; height: 65px; border: 1px solid #cbd5e1; border-radius: 6px; padding: 2px; background: #ffffff;" />
                                        <div style="font-size: 0.55rem; color: #64748b; margin-top: 2px; text-align: center;">VERIFY</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- CARD 2: MOTHER RFID CARD (ROSE PINK THEME) -->
                        <div class="col-md-6">
                            <div class="rfid-card rfid-card-mother printable-rfid shadow-lg" id="rfidCardMother" style="border: 2px solid #db2777 !important; border-radius: 16px; overflow: hidden; background: #ffffff;">
                                <div class="rfid-header rfid-header-mother d-flex justify-content-between align-items-center p-2 px-3" style="background: linear-gradient(135deg, #be185d 0%, #831843 100%); border-bottom: 3px solid #ec4899;">
                                    <div class="d-flex align-items-center gap-2">
                                        <img src="Images/logo.png" class="rfid-logo-img" alt="Logo" style="width: 32px; height: 32px; max-width: 32px; max-height: 32px; object-fit: contain; border-radius: 50%; background: #ffffff; padding: 2px;" />
                                        <div>
                                            <div class="fw-bold text-white small" style="font-size: 0.8rem; line-height: 1;">TN HAPPY KIDS SCHOOL</div>
                                            <div class="text-warning fw-bold" style="font-size: 0.62rem; letter-spacing: 0.05em;">AUTHORISED PICKUP PASS</div>
                                        </div>
                                    </div>
                                    <div class="rfid-chip-icon" style="width: 32px; height: 24px; background: linear-gradient(135deg, #fbbf24 0%, #d97706 100%); border-radius: 4px; border: 1px solid #f59e0b; display: flex; align-items: center; justify-content: center;">
                                        <i class="fa-solid fa-microchip text-dark" style="font-size: 0.75rem;"></i>
                                    </div>
                                </div>
                                <div class="rfid-body p-3 bg-white text-dark d-flex gap-3 align-items-center">
                                    <div class="rfid-photo-frame rfid-photo-mother" style="width: 85px; height: 105px; border-radius: 8px; border: 2px solid #db2777; overflow: hidden; background: #f8fafc; flex-shrink: 0;">
                                        <img id="imgRfidMotherPhoto" src="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 24 24' fill='%2338bdf8'><path d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 4c1.93 0 3.5 1.57 3.5 3.5S13.93 13 12 13s-3.5-1.57-3.5-3.5S10.07 6 12 6zm0 14c-2.03 0-3.8-1.04-4.83-2.61.03-1.6 3.22-2.47 4.83-2.47s4.8 0.87 4.83 2.47C15.8 18.96 14.03 20 12 20z'/></svg>" alt="Mother Photo" style="width: 100%; height: 100%; object-fit: cover;" />
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold text-dark fs-5 mb-0" id="lblRfidMotherName"><asp:Literal ID="litRfidMotherName" runat="server">-</asp:Literal></div>
                                        <span class="badge text-white text-uppercase px-2 py-1 mb-1" style="background-color: #db2777 !important;">Mother</span>
                                        <div class="small text-secondary mb-1">Student: <strong class="text-dark" id="lblRfidStudentName2"><asp:Literal ID="litRfidStudentName2" runat="server">-</asp:Literal></strong></div>
                                        <div class="small text-primary fw-bold mb-1" style="font-size: 0.72rem;">STUDENT REG: <span id="lblRfidStudentReg2"><asp:Literal ID="litRfidStudentReg2" runat="server">ADM-2026-000</asp:Literal></span></div>
                                        <div class="fw-bold text-danger font-monospace fs-6" id="lblRfidMotherNo"><asp:Literal ID="litRfidMotherNo" runat="server">4821 9842 1042</asp:Literal></div>
                                    </div>
                                    <div class="text-end flex-shrink-0" style="width: 70px;">
                                        <img id="imgQrMother" src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=482198421042" alt="QR Code" style="width: 65px; height: 65px; border: 1px solid #cbd5e1; border-radius: 6px; padding: 2px; background: #ffffff;" />
                                        <div style="font-size: 0.55rem; color: #64748b; margin-top: 2px; text-align: center;">VERIFY</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- CARD 3: GUARDIAN 1 RFID CARD (EMERALD GREEN THEME) -->
                        <div class="col-md-6">
                            <div class="rfid-card rfid-card-g1 printable-rfid shadow-lg" id="rfidCardG1" style="border: 2px solid #059669 !important; border-radius: 16px; overflow: hidden; background: #ffffff;">
                                <div class="rfid-header rfid-header-g1 d-flex justify-content-between align-items-center p-2 px-3" style="background: linear-gradient(135deg, #047857 0%, #064e3b 100%); border-bottom: 3px solid #10b981;">
                                    <div class="d-flex align-items-center gap-2">
                                        <img src="Images/logo.png" class="rfid-logo-img" alt="Logo" style="width: 32px; height: 32px; max-width: 32px; max-height: 32px; object-fit: contain; border-radius: 50%; background: #ffffff; padding: 2px;" />
                                        <div>
                                            <div class="fw-bold text-white small" style="font-size: 0.8rem; line-height: 1;">TN HAPPY KIDS SCHOOL</div>
                                            <div class="text-warning fw-bold" style="font-size: 0.62rem; letter-spacing: 0.05em;">AUTHORISED PICKUP PASS</div>
                                        </div>
                                    </div>
                                    <div class="rfid-chip-icon" style="width: 32px; height: 24px; background: linear-gradient(135deg, #fbbf24 0%, #d97706 100%); border-radius: 4px; border: 1px solid #f59e0b; display: flex; align-items: center; justify-content: center;">
                                        <i class="fa-solid fa-microchip text-dark" style="font-size: 0.75rem;"></i>
                                    </div>
                                </div>
                                <div class="rfid-body p-3 bg-white text-dark d-flex gap-3 align-items-center">
                                    <div class="rfid-photo-frame rfid-photo-g1" style="width: 85px; height: 105px; border-radius: 8px; border: 2px solid #059669; overflow: hidden; background: #f8fafc; flex-shrink: 0;">
                                        <img id="imgRfidG1Photo" src="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 24 24' fill='%2338bdf8'><path d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 4c1.93 0 3.5 1.57 3.5 3.5S13.93 13 12 13s-3.5-1.57-3.5-3.5S10.07 6 12 6zm0 14c-2.03 0-3.8-1.04-4.83-2.61.03-1.6 3.22-2.47 4.83-2.47s4.8 0.87 4.83 2.47C15.8 18.96 14.03 20 12 20z'/></svg>" alt="Guardian 1 Photo" style="width: 100%; height: 100%; object-fit: cover;" />
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold text-dark fs-5 mb-0" id="lblRfidG1Name"><asp:Literal ID="litRfidG1Name" runat="server">-</asp:Literal></div>
                                        <span class="badge text-white text-uppercase px-2 py-1 mb-1" style="background-color: #059669 !important;" id="lblRfidG1RelTag"><asp:Literal ID="litRfidG1RelTag" runat="server">Guardian 1</asp:Literal></span>
                                        <div class="small text-secondary mb-1">Student: <strong class="text-dark" id="lblRfidStudentName3"><asp:Literal ID="litRfidStudentName3" runat="server">-</asp:Literal></strong></div>
                                        <div class="small text-primary fw-bold mb-1" style="font-size: 0.72rem;">STUDENT REG: <span id="lblRfidStudentReg3"><asp:Literal ID="litRfidStudentReg3" runat="server">ADM-2026-000</asp:Literal></span></div>
                                        <div class="fw-bold text-danger font-monospace fs-6" id="lblRfidG1No"><asp:Literal ID="litRfidG1No" runat="server">4821 9842 1043</asp:Literal></div>
                                    </div>
                                    <div class="text-end flex-shrink-0" style="width: 70px;">
                                        <img id="imgQrG1" src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=482198421043" alt="QR Code" style="width: 65px; height: 65px; border: 1px solid #cbd5e1; border-radius: 6px; padding: 2px; background: #ffffff;" />
                                        <div style="font-size: 0.55rem; color: #64748b; margin-top: 2px; text-align: center;">VERIFY</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- CARD 4: GUARDIAN 2 RFID CARD (AMETHYST PURPLE THEME) -->
                        <div class="col-md-6">
                            <div class="rfid-card rfid-card-g2 printable-rfid shadow-lg" id="rfidCardG2" style="border: 2px solid #7c3aed !important; border-radius: 16px; overflow: hidden; background: #ffffff;">
                                <div class="rfid-header rfid-header-g2 d-flex justify-content-between align-items-center p-2 px-3" style="background: linear-gradient(135deg, #6d28d9 0%, #4c1d95 100%); border-bottom: 3px solid #8b5cf6;">
                                    <div class="d-flex align-items-center gap-2">
                                        <img src="Images/logo.png" class="rfid-logo-img" alt="Logo" style="width: 32px; height: 32px; max-width: 32px; max-height: 32px; object-fit: contain; border-radius: 50%; background: #ffffff; padding: 2px;" />
                                        <div>
                                            <div class="fw-bold text-white small" style="font-size: 0.8rem; line-height: 1;">TN HAPPY KIDS SCHOOL</div>
                                            <div class="text-warning fw-bold" style="font-size: 0.62rem; letter-spacing: 0.05em;">AUTHORISED PICKUP PASS</div>
                                        </div>
                                    </div>
                                    <div class="rfid-chip-icon" style="width: 32px; height: 24px; background: linear-gradient(135deg, #fbbf24 0%, #d97706 100%); border-radius: 4px; border: 1px solid #f59e0b; display: flex; align-items: center; justify-content: center;">
                                        <i class="fa-solid fa-microchip text-dark" style="font-size: 0.75rem;"></i>
                                    </div>
                                </div>
                                <div class="rfid-body p-3 bg-white text-dark d-flex gap-3 align-items-center">
                                    <div class="rfid-photo-frame rfid-photo-g2" style="width: 85px; height: 105px; border-radius: 8px; border: 2px solid #7c3aed; overflow: hidden; background: #f8fafc; flex-shrink: 0;">
                                        <img id="imgRfidG2Photo" src="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 24 24' fill='%2338bdf8'><path d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 4c1.93 0 3.5 1.57 3.5 3.5S13.93 13 12 13s-3.5-1.57-3.5-3.5S10.07 6 12 6zm0 14c-2.03 0-3.8-1.04-4.83-2.61.03-1.6 3.22-2.47 4.83-2.47s4.8 0.87 4.83 2.47C15.8 18.96 14.03 20 12 20z'/></svg>" alt="Guardian 2 Photo" style="width: 100%; height: 100%; object-fit: cover;" />
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold text-dark fs-5 mb-0" id="lblRfidG2Name"><asp:Literal ID="litRfidG2Name" runat="server">-</asp:Literal></div>
                                        <span class="badge text-white text-uppercase px-2 py-1 mb-1" style="background-color: #7c3aed !important;" id="lblRfidG2RelTag"><asp:Literal ID="litRfidG2RelTag" runat="server">Guardian 2</asp:Literal></span>
                                        <div class="small text-secondary mb-1">Student: <strong class="text-dark" id="lblRfidStudentName4"><asp:Literal ID="litRfidStudentName4" runat="server">-</asp:Literal></strong></div>
                                        <div class="small text-primary fw-bold mb-1" style="font-size: 0.72rem;">STUDENT REG: <span id="lblRfidStudentReg4"><asp:Literal ID="litRfidStudentReg4" runat="server">ADM-2026-000</asp:Literal></span></div>
                                        <div class="fw-bold text-danger font-monospace fs-6" id="lblRfidG2No"><asp:Literal ID="litRfidG2No" runat="server">4821 9842 1044</asp:Literal></div>
                                    </div>
                                    <div class="text-end flex-shrink-0" style="width: 70px;">
                                        <img id="imgQrG2" src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=482198421044" alt="QR Code" style="width: 65px; height: 65px; border: 1px solid #cbd5e1; border-radius: 6px; padding: 2px; background: #ffffff;" />
                                        <div style="font-size: 0.55rem; color: #64748b; margin-top: 2px; text-align: center;">VERIFY</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="text-center border-top border-secondary pt-4 mt-4">
                    <a href="Admission.aspx" class="btn btn-outline-info fw-semibold no-print">Submit Another Admission Application</a>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
