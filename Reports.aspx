<%@ Page Title="Reports Hub" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="AfterSchoolAdmission.Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4 no-print">
            <div>
                <h3 class="fw-bold text-dark mb-1">Reports & Analytics Hub</h3>
                <p class="text-muted small mb-0">Generate, view, and print administrative reports & parent directories</p>
            </div>
            <button type="button" class="btn btn-primary fw-semibold btn-print" onclick="printReport()">
                <i class="fa-solid fa-print me-1"></i> Print Current Report
            </button>
        </div>

        <!-- Report Selector Tabs Card -->
        <div class="card border-0 shadow-sm rounded-4 mb-4 no-print">
            <div class="card-body p-4">
                <label class="form-label fw-bold mb-3"><i class="fa-solid fa-filter me-1 text-primary"></i> Select Report Type</label>
                <div class="row g-3">
                    <div class="col-md-4 col-lg-2">
                        <asp:Button ID="btnRptStudentList" runat="server" Text="Student List" OnClick="btnRptStudentList_Click" CssClass="btn btn-outline-primary fw-semibold w-100 py-3" />
                    </div>
                    <div class="col-md-4 col-lg-2">
                        <asp:Button ID="btnRptAdmission" runat="server" Text="Admission Log" OnClick="btnRptAdmission_Click" CssClass="btn btn-outline-primary fw-semibold w-100 py-3" />
                    </div>
                    <div class="col-md-4 col-lg-2">
                        <asp:Button ID="btnRptFee" runat="server" Text="Fee Collection" OnClick="btnRptFee_Click" CssClass="btn btn-outline-primary fw-semibold w-100 py-3" />
                    </div>
                    <div class="col-md-4 col-lg-2">
                        <asp:Button ID="btnRptParent" runat="server" Text="Parent Directory" OnClick="btnRptParent_Click" CssClass="btn btn-outline-primary fw-semibold w-100 py-3" />
                    </div>
                    <div class="col-md-4 col-lg-2">
                        <asp:Button ID="btnRptAttendance" runat="server" Text="Attendance Matrix" OnClick="btnRptAttendance_Click" CssClass="btn btn-outline-primary fw-semibold w-100 py-3" />
                    </div>
                    <div class="col-md-4 col-lg-2">
                        <asp:Button ID="btnRptDaily" runat="server" Text="Today's Admissions" OnClick="btnRptDaily_Click" CssClass="btn btn-outline-primary fw-semibold w-100 py-3" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Report Content Output Card -->
        <div class="printable-area">
            <div class="card border-0 shadow-sm rounded-4">
                <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                    <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-file-invoice text-primary me-2"></i><asp:Literal ID="litReportTitle" runat="server">Master Student List Report</asp:Literal></h5>
                    <span class="badge bg-light text-dark border px-3 py-2 fw-semibold">Generated: <%: DateTime.Now.ToString("yyyy-MM-dd HH:mm") %></span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <asp:GridView ID="gvReportData" runat="server" AutoGenerateColumns="True" CssClass="table table-bordered table-striped align-middle mb-0" EmptyDataText="No report data generated for this category.">
                            <HeaderStyle CssClass="table-light fw-bold" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
