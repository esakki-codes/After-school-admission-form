<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="AfterSchoolAdmission.ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold text-dark mb-1">Change Password</h3>
                <p class="text-muted small">Update your admin account password</p>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-4 p-md-5">
                        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-danger" role="alert">
                            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
                        </asp:Panel>

                        <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success" role="alert">
                            <asp:Literal ID="litSuccessMsg" runat="server"></asp:Literal>
                        </asp:Panel>

                        <div class="mb-3">
                            <label for="txtOldPassword" class="form-label fw-medium">Current Password</label>
                            <asp:TextBox ID="txtOldPassword" runat="server" TextMode="Password" CssClass="form-control form-control-lg fs-6" required="true"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label for="txtNewPassword" class="form-label fw-medium">New Password</label>
                            <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control form-control-lg fs-6" required="true"></asp:TextBox>
                        </div>

                        <div class="mb-4">
                            <label for="txtConfirmPassword" class="form-label fw-medium">Confirm New Password</label>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control form-control-lg fs-6" required="true"></asp:TextBox>
                        </div>

                        <asp:Button ID="btnChangePassword" runat="server" Text="Update Password" OnClick="btnChangePassword_Click" CssClass="btn btn-primary btn-lg w-100 fw-bold shadow-sm" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
