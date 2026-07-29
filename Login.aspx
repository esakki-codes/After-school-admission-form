<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AfterSchoolAdmission.Login" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Login - Bright Minds After School Management</title>
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
            max-width: 440px;
            border-radius: 1.25rem;
            background: rgba(255, 255, 255, 0.96);
            backdrop-filter: blur(10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.25);
        }
    </style>
</head>
<body>
    <form id="formLogin" runat="server">
        <div class="login-card p-4 p-md-5">
            <div class="text-center mb-4">
                <div class="d-inline-flex align-items-center justify-content-center bg-primary text-white rounded-circle mb-3" style="width: 64px; height: 64px;">
                    <i class="fa-solid fa-graduation-cap fa-2x"></i>
                </div>
                <h4 class="fw-bold text-dark mb-1">Bright Minds Center</h4>
                <p class="text-muted small">After School Admission Management System</p>
            </div>

            <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fa-solid fa-triangle-exclamation me-2"></i>
                <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </asp:Panel>

            <div class="mb-3">
                <label for="txtUsername" class="form-label fw-medium">Username</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="fa-solid fa-user text-muted"></i></span>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control form-control-lg fs-6" placeholder="Enter username" required="true"></asp:TextBox>
                </div>
            </div>

            <div class="mb-3">
                <div class="d-flex justify-content-between align-items-center mb-1">
                    <label for="txtPassword" class="form-label fw-medium mb-0">Password</label>
                    <a href="ForgotPassword.aspx" class="text-decoration-none small text-primary">Forgot Password?</a>
                </div>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="fa-solid fa-lock text-muted"></i></span>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control form-control-lg fs-6" placeholder="Enter password" required="true"></asp:TextBox>
                </div>
            </div>

            <div class="mb-4 form-check">
                <asp:CheckBox ID="chkRemember" runat="server" CssClass="form-check-input" />
                <label class="form-check-label small text-muted" for="chkRemember">Remember me on this device</label>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Sign In to Dashboard" OnClick="btnLogin_Click" CssClass="btn btn-primary btn-lg w-100 fw-bold shadow-sm" />

            <div class="text-center mt-4 border-top pt-3 text-muted small">
                <i class="fa-solid fa-shield-halved me-1"></i> MCA Final Year Project Demo Edition
            </div>
        </div>
    </form>
</body>
</html>
