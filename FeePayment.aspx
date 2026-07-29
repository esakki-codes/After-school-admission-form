<%@ Page Title="Collect Fee" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FeePayment.aspx.cs" Inherits="AfterSchoolAdmission.FeePayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold text-dark mb-1">Fee Collection & Payment Entry</h3>
                <p class="text-muted small mb-0">Record monthly fees, generate receipt invoices, or clear dues</p>
            </div>
            <a href="PendingFees.aspx" class="btn btn-outline-danger fw-semibold">
                <i class="fa-solid fa-triangle-exclamation me-1"></i> View Pending Dues
            </a>
        </div>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-danger" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
        </asp:Panel>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-4 mb-4">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-credit-card text-success me-2"></i>New Fee Payment Entry</h5>
                    </div>
                    <div class="card-body p-4 p-md-5">

                        <div class="mb-4">
                            <label for="ddlStudent" class="form-label fw-bold">Select Enrolled Student *</label>
                            <asp:DropDownList ID="ddlStudent" runat="server" CssClass="form-select form-select-lg border-primary" required="true" AutoPostBack="true" OnSelectedIndexChanged="ddlStudent_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label for="txtFeeMonth" class="form-label fw-semibold">Fee for Month / Period *</label>
                                <asp:TextBox ID="txtFeeMonth" runat="server" CssClass="form-control" placeholder="e.g. July 2026" required="true"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label for="txtAmountPaid" class="form-label fw-semibold">Amount Being Paid (₹) *</label>
                                <asp:TextBox ID="txtAmountPaid" runat="server" CssClass="form-control form-control-lg border-success fw-bold text-success" placeholder="0.00" required="true"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label for="ddlPaymentMethod" class="form-label fw-semibold">Payment Method *</label>
                                <asp:DropDownList ID="ddlPaymentMethod" runat="server" CssClass="form-select" required="true">
                                    <asp:ListItem Value="Cash">Cash</asp:ListItem>
                                    <asp:ListItem Value="UPI">UPI / GPay / PhonePe</asp:ListItem>
                                    <asp:ListItem Value="NetBanking">Net Banking</asp:ListItem>
                                    <asp:ListItem Value="Cheque">Cheque</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-6">
                                <label for="txtReceiptNo" class="form-label fw-semibold">Auto Receipt Number</label>
                                <asp:TextBox ID="txtReceiptNo" runat="server" CssClass="form-control bg-light fw-bold" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end gap-3 border-top pt-4">
                            <asp:Button ID="btnSubmitPayment" runat="server" Text="Record Payment & Issue Receipt" OnClick="btnSubmitPayment_Click" CssClass="btn btn-success btn-lg px-5 fw-bold shadow-sm" />
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
