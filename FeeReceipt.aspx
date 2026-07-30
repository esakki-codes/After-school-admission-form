<%@ Page Title="Fee Receipt" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FeeReceipt.aspx.cs" Inherits="AfterSchoolAdmission.FeeReceipt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <!-- Actions Topbar -->
        <div class="d-flex justify-content-between align-items-center mb-4 no-print">
            <div>
                <h3 class="fw-bold text-dark mb-1">Official Payment Receipt</h3>
                <p class="text-muted small mb-0">Printable payment invoice for student fee transaction</p>
            </div>
            <div class="d-flex gap-2">
                <button type="button" id="btnDownloadPDF" class="btn btn-success fw-semibold" onclick="downloadReceiptPDF();">
                    <i class="fa-solid fa-file-pdf me-1"></i> Download PDF
                </button>
                <button type="button" class="btn btn-primary fw-semibold btn-print" onclick="printReport()">
                    <i class="fa-solid fa-print me-1"></i> Print Receipt
                </button>
                <a href="FeeHistory.aspx" class="btn btn-outline-secondary fw-semibold">
                    <i class="fa-solid fa-list me-1"></i> Fee History
                </a>
            </div>
        </div>

        <!-- Printable Invoice Container -->
        <div class="row justify-content-center printable-area">
            <div class="col-lg-8">
                <div class="card border-0 shadow-lg rounded-4 overflow-hidden">
                    <div class="card-body p-4 p-md-5">

                        <!-- Receipt Header -->
                        <div class="d-flex justify-content-between align-items-start border-bottom pb-4 mb-4">
                            <div class="d-flex align-items-center gap-3">
                                <img src="Images/logo.png" alt="Center Logo" height="60" style="object-fit: contain;" />
                                <div>
                                    <h4 class="fw-bold text-dark mb-0">Bright Minds Center</h4>
                                    <small class="text-muted">After School Admission Management</small><br />
                                    <small class="text-muted"><i class="fa-solid fa-location-dot me-1"></i> Main Campus Road, Sector 5</small>
                                </div>
                            </div>
                            <div class="text-end">
                                <span class="badge bg-success-subtle text-success border border-success px-3 py-2 fs-6 fw-bold mb-2">OFFICIAL RECEIPT</span>
                                <div class="fw-bold fs-6 text-primary"><asp:Literal ID="litReceiptNo" runat="server">REC-2026-00001</asp:Literal></div>
                                <small class="text-muted">Date: <asp:Literal ID="litPaymentDate" runat="server"></asp:Literal></small>
                            </div>
                        </div>

                        <!-- Student & Parent Information -->
                        <div class="row mb-4">
                            <div class="col-md-6 border-end pe-md-4">
                                <h6 class="fw-bold text-uppercase text-muted small mb-2">Student Information</h6>
                                <div class="fw-bold fs-5 text-dark mb-1"><asp:Literal ID="litStudentName" runat="server"></asp:Literal></div>
                                <div class="text-muted mb-1"><i class="fa-solid fa-id-card me-1"></i> Admission No: <strong><asp:Literal ID="litAdmissionNo" runat="server"></asp:Literal></strong></div>
                                <div class="text-muted mb-1"><i class="fa-solid fa-graduation-cap me-1"></i> Class: <strong><asp:Literal ID="litStandard" runat="server"></asp:Literal></strong></div>
                                <div class="text-muted"><i class="fa-solid fa-shapes me-1"></i> Program: <strong><asp:Literal ID="litProgram" runat="server"></asp:Literal></strong></div>
                            </div>
                            <div class="col-md-6 ps-md-4 mt-3 mt-md-0">
                                <h6 class="fw-bold text-uppercase text-muted small mb-2">Payer / Parent Information</h6>
                                <div class="fw-bold fs-6 text-dark mb-1"><asp:Literal ID="litFatherName" runat="server"></asp:Literal></div>
                                <div class="text-muted mb-1"><i class="fa-solid fa-phone me-1"></i> <asp:Literal ID="litFatherMobile" runat="server"></asp:Literal></div>
                                <div class="text-muted mb-1"><i class="fa-solid fa-calendar-day me-1"></i> Fee Period: <strong><asp:Literal ID="litFeeForMonth" runat="server"></asp:Literal></strong></div>
                                <div class="text-muted"><i class="fa-solid fa-credit-card me-1"></i> Method: <strong><asp:Literal ID="litPaymentMethod" runat="server"></asp:Literal></strong></div>
                            </div>
                        </div>

                        <!-- Breakdown Table -->
                        <div class="table-responsive mb-4">
                            <table class="table table-bordered align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Description</th>
                                        <th class="text-end" style="width: 25%;">Amount (₹)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Admission Fee</td>
                                        <td class="text-end">₹<asp:Literal ID="litAdmissionFee" runat="server">0.00</asp:Literal></td>
                                    </tr>
                                    <tr>
                                        <td>Monthly Program Fee (<asp:Literal ID="litMonthName" runat="server"></asp:Literal>)</td>
                                        <td class="text-end">₹<asp:Literal ID="litMonthlyFee" runat="server">0.00</asp:Literal></td>
                                    </tr>
                                    <tr>
                                        <td>Concession / Discount</td>
                                        <td class="text-end text-danger">- ₹<asp:Literal ID="litDiscount" runat="server">0.00</asp:Literal></td>
                                    </tr>
                                    <tr class="table-secondary fw-bold">
                                        <td>Total Amount Payable</td>
                                        <td class="text-end fs-6">₹<asp:Literal ID="litTotalAmount" runat="server">0.00</asp:Literal></td>
                                    </tr>
                                    <tr class="table-success fw-bold text-success">
                                        <td>Amount Received</td>
                                        <td class="text-end fs-5">₹<asp:Literal ID="litAmountPaid" runat="server">0.00</asp:Literal></td>
                                    </tr>
                                    <tr>
                                        <td>Balance Dues</td>
                                        <td class="text-end fw-bold text-danger">₹<asp:Literal ID="litBalance" runat="server">0.00</asp:Literal></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!-- Footer Signatures -->
                        <div class="d-flex justify-content-between align-items-end pt-4 border-top mt-5">
                            <div class="text-center">
                                <small class="text-muted d-block mb-4">Payer Signature</small>
                                <div class="border-top pt-1 text-muted small" style="width: 160px;">Parent / Guardian</div>
                            </div>
                            <div class="text-center">
                                <span class="badge bg-success px-4 py-2 mb-3 shadow-sm">PAID & VERIFIED</span>
                                <div class="border-top pt-1 text-dark fw-bold small" style="width: 180px;">Authorized Signature</div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
