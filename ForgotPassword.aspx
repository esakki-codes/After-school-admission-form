<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="AfterSchoolAdmission.ForgotPassword" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Forgot Password - Bright Minds Management System</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- FontAwesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />
    <!-- Custom CSS -->
    <link href="CSS/custom.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #1e1b4b 0%, #312e81 50%, #4f46e5 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            width: 100%;
            max-width: 450px;
            border-radius: 1.25rem;
            background: rgba(255, 255, 255, 0.96);
            backdrop-filter: blur(10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.25);
        }
    </style>
</head>
<body>
    <form id="formForgot" runat="server">
        <div class="login-card p-4 p-md-5">
            <div class="text-center mb-4">
                <div class="d-inline-flex align-items-center justify-content-center bg-warning text-dark rounded-circle mb-3" style="width: 60px; height: 60px;">
                    <i class="fa-solid fa-key fa-2x"></i>
                </div>
                <h4 class="fw-bold text-dark mb-1">Reset Password</h4>
                <p class="text-muted small">Answer security question to recover account</p>
            </div>

            <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-danger" role="alert">
                <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            </asp:Panel>

            <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success" role="alert">
                <asp:Literal ID="litSuccessMsg" runat="server"></asp:Literal>
            </asp:Panel>

            <div class="mb-3">
                <label for="txtUsername" class="form-label fw-medium">Username</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter your admin username" required="true"></asp:TextBox>
            </div>

            <div class="mb-3">
                <label for="txtSecurityAnswer" class="form-label fw-medium">Security Question Answer</label>
                <small class="d-block text-muted mb-1">Q: What is the name of your center?</small>
                <asp:TextBox ID="txtSecurityAnswer" runat="server" CssClass="form-control" placeholder="Enter security answer" required="true"></asp:TextBox>
            </div>

            <div class="mb-4">
                <label for="txtNewPassword" class="form-label fw-medium">New Password</label>
                <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter new password" required="true"></asp:TextBox>
            </div>

            <asp:Button ID="btnReset" runat="server" Text="Reset Password" OnClick="btnReset_Click" CssClass="btn btn-primary btn-lg w-100 fw-bold shadow-sm" />

            <div class="text-center mt-4">
                <a href="Login.aspx" class="text-decoration-none text-muted small"><i class="fa-solid fa-arrow-left me-1"></i> Back to Login</a>
            </div>
        </div>
    </form>
</body>
</html>
