<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="AfterSchoolAdmission.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold text-dark mb-1">Center Dashboard</h3>
                <p class="text-muted small mb-0">Overview of admissions, enrollment metrics, and pending fees</p>
            </div>
            <div class="d-flex gap-2">
                <a href="Admission.aspx" class="btn btn-primary fw-semibold shadow-sm">
                    <i class="fa-solid fa-user-plus me-1"></i> New Admission
                </a>
                <a href="FeePayment.aspx" class="btn btn-success fw-semibold shadow-sm">
                    <i class="fa-solid fa-credit-card me-1"></i> Collect Fee
                </a>
            </div>
        </div>

        <!-- Dashboard Stat Cards Row -->
        <div class="row g-3 mb-4">
            <!-- 1. Total Students -->
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="stat-card">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="stat-label">Total Active Students</div>
                            <div class="stat-value"><asp:Literal ID="litTotalStudents" runat="server">0</asp:Literal></div>
                        </div>
                        <div class="stat-icon primary">
                            <i class="fa-solid fa-children"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 2. Play School Students -->
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="stat-card">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="stat-label">Play School (1:30-4:30)</div>
                            <div class="stat-value"><asp:Literal ID="litPlaySchoolStudents" runat="server">0</asp:Literal></div>
                        </div>
                        <div class="stat-icon success">
                            <i class="fa-solid fa-shapes"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 3. Evening Tuition Students -->
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="stat-card">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="stat-label">Evening Tuition (5:00-7:30)</div>
                            <div class="stat-value"><asp:Literal ID="litTuitionStudents" runat="server">0</asp:Literal></div>
                        </div>
                        <div class="stat-icon info">
                            <i class="fa-solid fa-book-open-reader"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 4. Both Programs -->
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="stat-card">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="stat-label">Both Programs</div>
                            <div class="stat-value"><asp:Literal ID="litBothStudents" runat="server">0</asp:Literal></div>
                        </div>
                        <div class="stat-icon warning">
                            <i class="fa-solid fa-star"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 5. Today's Admissions -->
            <div class="col-12 col-sm-6 col-xl-4">
                <div class="stat-card border-start border-4 border-primary">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="stat-label">Today's Admissions</div>
                            <div class="stat-value text-primary"><asp:Literal ID="litTodayAdmissions" runat="server">0</asp:Literal></div>
                        </div>
                        <div class="stat-icon primary">
                            <i class="fa-solid fa-user-check"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 6. Pending Fees -->
            <div class="col-12 col-sm-6 col-xl-4">
                <div class="stat-card border-start border-4 border-danger">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="stat-label">Total Pending Dues</div>
                            <div class="stat-value text-danger">₹<asp:Literal ID="litPendingFees" runat="server">0.00</asp:Literal></div>
                        </div>
                        <div class="stat-icon warning text-danger">
                            <i class="fa-solid fa-indian-rupee-sign"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 7. Today's Attendance Present -->
            <div class="col-12 col-sm-6 col-xl-4">
                <div class="stat-card border-start border-4 border-success">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="stat-label">Today's Attendance Present</div>
                            <div class="stat-value text-success"><asp:Literal ID="litTodayPresent" runat="server">0</asp:Literal></div>
                        </div>
                        <div class="stat-icon success">
                            <i class="fa-solid fa-clipboard-check"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Admissions Table -->
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-bottom">
                <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-clock-rotate-left me-2 text-primary"></i>Recent Admissions</h5>
                <a href="StudentList.aspx" class="btn btn-sm btn-outline-primary fw-semibold">View All Students</a>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvRecentAdmissions" runat="server" AutoGenerateColumns="False" CssClass="table table-hover align-middle mb-0" EmptyDataText="No recent admissions found.">
                        <Columns>
                            <asp:BoundField DataField="AdmissionNo" HeaderText="Admission No" />
                            <asp:TemplateField HeaderText="Student Name">
                                <ItemTemplate>
                                    <div class="d-flex align-items-center gap-2">
                                        <img src='<%# Eval("PhotoPath") %>' class="rounded-circle" width="36" height="36" style="object-fit: cover;" alt="Photo" />
                                        <span class="fw-semibold"><%# Eval("FullName") %></span>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Standard" HeaderText="Class/Standard" />
                            <asp:TemplateField HeaderText="Program">
                                <ItemTemplate>
                                    <span class="badge <%# Eval("ProgramType").ToString() == "Play School" ? "bg-info" : (Eval("ProgramType").ToString() == "Evening Tuition" ? "bg-primary" : "bg-warning text-dark") %>">
                                        <%# Eval("ProgramType") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="FatherName" HeaderText="Father Name" />
                            <asp:BoundField DataField="FatherMobile" HeaderText="Contact No" />
                            <asp:BoundField DataField="AdmissionDate" HeaderText="Admission Date" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <a href='<%# "StudentProfile.aspx?id=" + Eval("StudentID") %>' class="btn btn-sm btn-light border text-primary" title="View Dossier">
                                        <i class="fa-solid fa-eye"></i>
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
