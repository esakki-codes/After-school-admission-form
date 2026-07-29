<%@ Page Title="Mark Attendance" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MarkAttendance.aspx.cs" Inherits="AfterSchoolAdmission.MarkAttendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold text-dark mb-1">Daily Attendance Register</h3>
                <p class="text-muted small mb-0">Record daily student attendance (Present, Absent, Late)</p>
            </div>
            <a href="AttendanceReport.aspx" class="btn btn-outline-primary fw-semibold">
                <i class="fa-solid fa-chart-column me-1"></i> Attendance Reports
            </a>
        </div>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </asp:Panel>

        <!-- Date & Program Selector Card -->
        <div class="card border-0 shadow-sm rounded-4 mb-4">
            <div class="card-body p-4">
                <div class="row g-3 align-items-end">
                    <div class="col-md-4">
                        <label for="txtAttendanceDate" class="form-label fw-semibold">Attendance Date</label>
                        <asp:TextBox ID="txtAttendanceDate" runat="server" TextMode="Date" CssClass="form-control form-control-lg fs-6" AutoPostBack="true" OnTextChanged="txtAttendanceDate_TextChanged"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="ddlProgramFilter" class="form-label fw-semibold">Filter Program</label>
                        <asp:DropDownList ID="ddlProgramFilter" runat="server" CssClass="form-select form-select-lg fs-6" AutoPostBack="true" OnSelectedIndexChanged="ddlProgramFilter_SelectedIndexChanged">
                            <asp:ListItem Value="">All Programs</asp:ListItem>
                            <asp:ListItem Value="Play School">Play School (1:30 PM - 4:30 PM)</asp:ListItem>
                            <asp:ListItem Value="Evening Tuition">Evening Tuition (5:00 PM - 7:30 PM)</asp:ListItem>
                            <asp:ListItem Value="Both">Both Programs</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4 text-end">
                        <asp:Button ID="btnSaveAttendance" runat="server" Text="Save All Attendance Records" OnClick="btnSaveAttendance_Click" CssClass="btn btn-primary btn-lg fw-bold shadow-sm w-100" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Attendance Marking Table Card -->
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-header bg-white py-3 border-bottom">
                <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-list-check text-primary me-2"></i>Students Roster</h5>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False" 
                        CssClass="table table-hover align-middle mb-0" DataKeyNames="StudentID" 
                        EmptyDataText="No active students found for selected date and program filter.">
                        <Columns>
                            <asp:BoundField DataField="AdmissionNo" HeaderText="Admission No" />
                            <asp:BoundField DataField="FullName" HeaderText="Student Name" HeaderStyle-CssClass="fw-bold" />
                            <asp:BoundField DataField="Standard" HeaderText="Class" />
                            <asp:BoundField DataField="ProgramType" HeaderText="Program" />
                            <asp:TemplateField HeaderText="Attendance Status">
                                <ItemTemplate>
                                    <div class="btn-group" role="group" aria-label="Status selection">
                                        <asp:RadioButton ID="rbPresent" runat="server" GroupName='<%# "att_" + Eval("StudentID") %>' Text=" Present" Checked='<%# Eval("CurrentStatus").ToString() == "Present" %>' CssClass="form-check-inline text-success fw-bold me-3" />
                                        <asp:RadioButton ID="rbAbsent" runat="server" GroupName='<%# "att_" + Eval("StudentID") %>' Text=" Absent" Checked='<%# Eval("CurrentStatus").ToString() == "Absent" %>' CssClass="form-check-inline text-danger fw-bold me-3" />
                                        <asp:RadioButton ID="rbLate" runat="server" GroupName='<%# "att_" + Eval("StudentID") %>' Text=" Late" Checked='<%# Eval("CurrentStatus").ToString() == "Late" %>' CssClass="form-check-inline text-warning text-dark fw-bold" />
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remarks">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtRemarks" runat="server" Text='<%# Eval("Remarks") %>' CssClass="form-control form-control-sm" placeholder="Optional remark (e.g. Informed leave)"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
