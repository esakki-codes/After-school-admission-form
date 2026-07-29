<%@ Page Title="Student Directory" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StudentList.aspx.cs" Inherits="AfterSchoolAdmission.StudentList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold text-dark mb-1">Student Directory & Management</h3>
                <p class="text-muted small mb-0">Search, filter, edit, view profile dossier, or manage student records</p>
            </div>
            <a href="Admission.aspx" class="btn btn-primary fw-semibold shadow-sm">
                <i class="fa-solid fa-user-plus me-1"></i> New Admission
            </a>
        </div>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-info alert-dismissible fade show" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </asp:Panel>

        <!-- Search & Filter Card -->
        <div class="card border-0 shadow-sm rounded-4 mb-4">
            <div class="card-body p-3 p-md-4">
                <div class="row g-3 align-items-end">
                    <div class="col-md-3">
                        <label for="txtSearch" class="form-label small fw-semibold">Search Student / Parent / Admission No</label>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by name, ID, mobile..."></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <label for="ddlProgramFilter" class="form-label small fw-semibold">Filter Program</label>
                        <asp:DropDownList ID="ddlProgramFilter" runat="server" CssClass="form-select">
                            <asp:ListItem Value="">All Programs</asp:ListItem>
                            <asp:ListItem Value="Play School">Play School</asp:ListItem>
                            <asp:ListItem Value="Evening Tuition">Evening Tuition</asp:ListItem>
                            <asp:ListItem Value="Both">Both Programs</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <label for="txtStandardFilter" class="form-label small fw-semibold">Filter Class / Standard</label>
                        <asp:TextBox ID="txtStandardFilter" runat="server" CssClass="form-control" placeholder="e.g. LKG, Class 4"></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold">Filter Admission Date</label>
                        <div class="input-group">
                            <asp:TextBox ID="txtFromDate" runat="server" TextMode="Date" CssClass="form-control" placeholder="From"></asp:TextBox>
                            <asp:TextBox ID="txtToDate" runat="server" TextMode="Date" CssClass="form-control" placeholder="To"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-2 d-flex gap-2">
                        <asp:Button ID="btnSearch" runat="server" Text="Apply Filter" OnClick="btnSearch_Click" CssClass="btn btn-primary fw-semibold w-100" />
                        <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" CssClass="btn btn-light border fw-semibold" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Student Datatable Card -->
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-header bg-white py-3 border-bottom">
                <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-users text-primary me-2"></i>Enrolled Students List</h5>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False" 
                        CssClass="table table-hover align-middle mb-0" DataKeyNames="StudentID" 
                        OnRowCommand="gvStudents_RowCommand" AllowPaging="True" PageSize="10" 
                        OnPageIndexChanging="gvStudents_PageIndexChanging" EmptyDataText="No student records found matching the filter criteria.">
                        <Columns>
                            <asp:BoundField DataField="AdmissionNo" HeaderText="Admission No" />
                            <asp:TemplateField HeaderText="Photo & Student Name">
                                <ItemTemplate>
                                    <div class="d-flex align-items-center gap-3">
                                        <img src='<%# Eval("PhotoPath") %>' class="rounded-circle border" width="42" height="42" style="object-fit: cover;" alt="Student Photo" />
                                        <div>
                                            <div class="fw-bold text-dark"><%# Eval("FullName") %></div>
                                            <small class="text-muted"><%# Eval("Gender") %></small>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Standard" HeaderText="Class" />
                            <asp:TemplateField HeaderText="Program Enrolled">
                                <ItemTemplate>
                                    <span class="badge <%# Eval("ProgramType").ToString() == "Play School" ? "bg-info" : (Eval("ProgramType").ToString() == "Evening Tuition" ? "bg-primary" : "bg-warning text-dark") %>">
                                        <%# Eval("ProgramType") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Father Name & Contact">
                                <ItemTemplate>
                                    <div class="fw-semibold"><%# Eval("FatherName") %></div>
                                    <small class="text-muted"><i class="fa-solid fa-phone me-1"></i><%# Eval("FatherMobile") %></small>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="AdmissionDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:TemplateField HeaderText="Fee Status">
                                <ItemTemplate>
                                    <span class="badge <%# Eval("PaymentStatus").ToString() == "Paid" ? "bg-success" : (Eval("PaymentStatus").ToString() == "Partial" ? "bg-warning text-dark" : "bg-danger") %>">
                                        <%# Eval("PaymentStatus") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <div class="btn-group btn-group-sm" role="group">
                                        <a href='<%# "StudentProfile.aspx?id=" + Eval("StudentID") %>' class="btn btn-light border text-primary" title="View Profile Dossier">
                                            <i class="fa-solid fa-eye"></i> View
                                        </a>
                                        <a href='<%# "EditStudent.aspx?id=" + Eval("StudentID") %>' class="btn btn-light border text-secondary" title="Edit Student">
                                            <i class="fa-solid fa-pen"></i> Edit
                                        </a>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteStudent" CommandArgument='<%# Eval("StudentID") %>' CssClass="btn btn-light border text-danger" OnClientClick="return confirm('Are you sure you want to delete this student record?');" title="Delete Student">
                                            <i class="fa-solid fa-trash"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="p-3 pagination-container" HorizontalAlign="Center" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
