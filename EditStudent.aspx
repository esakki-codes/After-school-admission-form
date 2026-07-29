<%@ Page Title="Edit Student" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditStudent.aspx.cs" Inherits="AfterSchoolAdmission.EditStudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold text-dark mb-1">Update Student Information</h3>
                <p class="text-muted small mb-0">Modify demographic, standard, or photo details</p>
            </div>
            <a href="StudentList.aspx" class="btn btn-outline-secondary fw-semibold">
                <i class="fa-solid fa-arrow-left me-1"></i> Back to Student List
            </a>
        </div>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-danger" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
        </asp:Panel>

        <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success" role="alert">
            <asp:Literal ID="litSuccessMsg" runat="server"></asp:Literal>
        </asp:Panel>

        <div class="card border-0 shadow-sm rounded-4 mb-4">
            <div class="card-body p-4 p-md-5">
                <asp:HiddenField ID="hfStudentID" runat="server" />

                <div class="row g-4">
                    <div class="col-md-3 text-center">
                        <label class="form-label fw-semibold d-block">Current Photo</label>
                        <asp:Image ID="imgStudentPhoto" runat="server" CssClass="rounded-4 border mb-3" Width="140" Height="160" Style="object-fit: cover;" />
                        <asp:FileUpload ID="filePhoto" runat="server" CssClass="form-control form-control-sm" accept="image/*" />
                        <small class="text-muted d-block mt-1">Upload new image to update</small>
                    </div>

                    <div class="col-md-9">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label for="txtAdmissionNo" class="form-label fw-semibold">Admission No</label>
                                <asp:TextBox ID="txtAdmissionNo" runat="server" CssClass="form-control bg-light" ReadOnly="true"></asp:TextBox>
                            </div>
                            <div class="col-md-8">
                                <label for="txtFullName" class="form-label fw-semibold">Full Name *</label>
                                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                            </div>

                            <div class="col-md-4">
                                <label for="ddlGender" class="form-label fw-semibold">Gender *</label>
                                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select" required="true">
                                    <asp:ListItem Value="Male">Male</asp:ListItem>
                                    <asp:ListItem Value="Female">Female</asp:ListItem>
                                    <asp:ListItem Value="Other">Other</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-4">
                                <label for="txtDOB" class="form-label fw-semibold">Date of Birth *</label>
                                <asp:TextBox ID="txtDOB" runat="server" TextMode="Date" CssClass="form-control" required="true"></asp:TextBox>
                            </div>
                            <div class="col-md-4">
                                <label for="ddlBloodGroup" class="form-label fw-semibold">Blood Group</label>
                                <asp:DropDownList ID="ddlBloodGroup" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="A+">A+</asp:ListItem>
                                    <asp:ListItem Value="A-">A-</asp:ListItem>
                                    <asp:ListItem Value="B+">B+</asp:ListItem>
                                    <asp:ListItem Value="B-">B-</asp:ListItem>
                                    <asp:ListItem Value="O+">O+</asp:ListItem>
                                    <asp:ListItem Value="O-">O-</asp:ListItem>
                                    <asp:ListItem Value="AB+">AB+</asp:ListItem>
                                    <asp:ListItem Value="AB-">AB-</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="col-md-6">
                                <label for="txtSchoolName" class="form-label fw-semibold">School Name</label>
                                <asp:TextBox ID="txtSchoolName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label for="txtStandard" class="form-label fw-semibold">Class / Standard *</label>
                                <asp:TextBox ID="txtStandard" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                            </div>

                            <div class="col-md-12">
                                <label for="txtAddress" class="form-label fw-semibold">Residential Address *</label>
                                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" required="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-3 border-top pt-4 mt-4">
                    <asp:Button ID="btnUpdate" runat="server" Text="Save Changes" OnClick="btnUpdate_Click" CssClass="btn btn-primary btn-lg px-5 fw-bold shadow-sm" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
