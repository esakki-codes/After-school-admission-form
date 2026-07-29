<%@ Page Title="Attendance Reports" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AttendanceReport.aspx.cs" Inherits="AfterSchoolAdmission.AttendanceReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4 no-print">
            <div>
                <h3 class="fw-bold text-dark mb-1">Attendance Analytics & Reports</h3>
                <p class="text-muted small mb-0">Daily registers, monthly attendance aggregates, and student participation ratios</p>
            </div>
            <div class="d-flex gap-2">
                <button type="button" class="btn btn-outline-primary fw-semibold btn-print" onclick="printReport()">
                    <i class="fa-solid fa-print me-1"></i> Print Report
                </button>
                <a href="MarkAttendance.aspx" class="btn btn-primary fw-semibold">
                    <i class="fa-solid fa-clipboard-user me-1"></i> Mark Attendance
                </a>
            </div>
        </div>

        <!-- Filter Card -->
        <div class="card border-0 shadow-sm rounded-4 mb-4 no-print">
            <div class="card-body p-4">
                <div class="row g-3 align-items-end">
                    <div class="col-md-3">
                        <label for="ddlMonth" class="form-label small fw-semibold">Select Month</label>
                        <asp:DropDownList ID="ddlMonth" runat="server" CssClass="form-select">
                            <asp:ListItem Value="1">January</asp:ListItem>
                            <asp:ListItem Value="2">February</asp:ListItem>
                            <asp:ListItem Value="3">March</asp:ListItem>
                            <asp:ListItem Value="4">April</asp:ListItem>
                            <asp:ListItem Value="5">May</asp:ListItem>
                            <asp:ListItem Value="6">June</asp:ListItem>
                            <asp:ListItem Value="7" Selected="True">July</asp:ListItem>
                            <asp:ListItem Value="8">August</asp:ListItem>
                            <asp:ListItem Value="9">September</asp:ListItem>
                            <asp:ListItem Value="10">October</asp:ListItem>
                            <asp:ListItem Value="11">November</asp:ListItem>
                            <asp:ListItem Value="12">December</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <label for="ddlYear" class="form-label small fw-semibold">Select Year</label>
                        <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-select">
                            <asp:ListItem Value="2025">2025</asp:ListItem>
                            <asp:ListItem Value="2026" Selected="True">2026</asp:ListItem>
                            <asp:ListItem Value="2027">2027</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label for="ddlProgram" class="form-label small fw-semibold">Filter Program</label>
                        <asp:DropDownList ID="ddlProgram" runat="server" CssClass="form-select">
                            <asp:ListItem Value="">All Programs</asp:ListItem>
                            <asp:ListItem Value="Play School">Play School</asp:ListItem>
                            <asp:ListItem Value="Evening Tuition">Evening Tuition</asp:ListItem>
                            <asp:ListItem Value="Both">Both Programs</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnGenerate" runat="server" Text="Generate Report" OnClick="btnGenerate_Click" CssClass="btn btn-primary fw-semibold w-100" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Printable Report View -->
        <div class="printable-area">
            <div class="card border-0 shadow-sm rounded-4">
                <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                    <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-calendar-check text-primary me-2"></i>Monthly Attendance Summary Sheet</h5>
                    <span class="badge bg-light text-dark border px-3 py-2 fw-semibold">
                        Period: <asp:Literal ID="litPeriod" runat="server">July 2026</asp:Literal>
                    </span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <asp:GridView ID="gvAttendanceReport" runat="server" AutoGenerateColumns="False" 
                            CssClass="table table-bordered align-middle mb-0" EmptyDataText="No attendance logs found for selected month and year.">
                            <Columns>
                                <asp:BoundField DataField="AdmissionNo" HeaderText="Admission No" />
                                <asp:BoundField DataField="FullName" HeaderText="Student Name" HeaderStyle-CssClass="fw-bold" />
                                <asp:BoundField DataField="Standard" HeaderText="Class" />
                                <asp:BoundField DataField="ProgramType" HeaderText="Program" />
                                <asp:BoundField DataField="TotalPresent" HeaderText="Present Days" ItemStyle-CssClass="text-success fw-bold text-center" />
                                <asp:BoundField DataField="TotalAbsent" HeaderText="Absent Days" ItemStyle-CssClass="text-danger fw-bold text-center" />
                                <asp:BoundField DataField="TotalLate" HeaderText="Late Days" ItemStyle-CssClass="text-warning text-dark fw-bold text-center" />
                                <asp:BoundField DataField="TotalDaysRecorded" HeaderText="Total Recorded Days" ItemStyle-CssClass="fw-bold text-center" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
