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
            <button type="button" class="btn btn-primary-blue btn-lg fw-bold px-4 rounded-pill mt-2" onclick="window.print();">
                <i class="fa-solid fa-print me-2"></i> Print Admission Receipt
            </button>
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

                <div class="text-center border-top border-secondary pt-4 mt-4">
                    <a href="Admission.aspx" class="btn btn-outline-info fw-semibold no-print">Submit Another Admission Application</a>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
