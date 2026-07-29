<%@ Page Title="Fee History" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FeeHistory.aspx.cs" Inherits="AfterSchoolAdmission.FeeHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold text-dark mb-1">Fee Payment Transactions History</h3>
                <p class="text-muted small mb-0">Searchable log of all fee receipts, payment methods, and statuses</p>
            </div>
            <a href="FeePayment.aspx" class="btn btn-success fw-semibold">
                <i class="fa-solid fa-credit-card me-1"></i> Collect Fee
            </a>
        </div>

        <!-- Filter Card -->
        <div class="card border-0 shadow-sm rounded-4 mb-4">
            <div class="card-body p-4">
                <div class="row g-3 align-items-end">
                    <div class="col-md-4">
                        <label for="txtSearch" class="form-label small fw-semibold">Search Receipt / Student Name / Admission No</label>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search..."></asp:TextBox>
                    </div>
                    <div class="col-md-3">
                        <label for="ddlStatus" class="form-label small fw-semibold">Payment Status</label>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                            <asp:ListItem Value="">All Statuses</asp:ListItem>
                            <asp:ListItem Value="Paid">Paid</asp:ListItem>
                            <asp:ListItem Value="Partial">Partial</asp:ListItem>
                            <asp:ListItem Value="Pending">Pending</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <label for="ddlMethod" class="form-label small fw-semibold">Payment Method</label>
                        <asp:DropDownList ID="ddlMethod" runat="server" CssClass="form-select">
                            <asp:ListItem Value="">All Methods</asp:ListItem>
                            <asp:ListItem Value="Cash">Cash</asp:ListItem>
                            <asp:ListItem Value="UPI">UPI</asp:ListItem>
                            <asp:ListItem Value="NetBanking">Net Banking</asp:ListItem>
                            <asp:ListItem Value="Cheque">Cheque</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnSearch" runat="server" Text="Apply Filter" OnClick="btnSearch_Click" CssClass="btn btn-primary fw-semibold w-100" />
                    </div>
                </div>
            </div>
        </div>

        <!-- History Grid -->
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-header bg-white py-3 border-bottom">
                <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-receipt text-primary me-2"></i>Receipt Transactions</h5>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvHistory" runat="server" AutoGenerateColumns="False" 
                        CssClass="table table-hover align-middle mb-0" EmptyDataText="No fee payment records found.">
                        <Columns>
                            <asp:BoundField DataField="ReceiptNumber" HeaderText="Receipt No" HeaderStyle-CssClass="fw-bold text-primary" />
                            <asp:BoundField DataField="PaymentDate" HeaderText="Date & Time" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                            <asp:BoundField DataField="AdmissionNo" HeaderText="Admission No" />
                            <asp:BoundField DataField="StudentName" HeaderText="Student Name" HeaderStyle-CssClass="fw-bold" />
                            <asp:BoundField DataField="FeeForMonth" HeaderText="Fee Period" />
                            <asp:BoundField DataField="TotalAmount" HeaderText="Total (₹)" DataFormatString="{0:N2}" />
                            <asp:BoundField DataField="AmountPaid" HeaderText="Paid (₹)" DataFormatString="{0:N2}" ItemStyle-CssClass="text-success fw-bold" />
                            <asp:BoundField DataField="BalanceAmount" HeaderText="Balance (₹)" DataFormatString="{0:N2}" ItemStyle-CssClass="text-danger fw-bold" />
                            <asp:BoundField DataField="PaymentMethod" HeaderText="Method" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class="badge <%# Eval("PaymentStatus").ToString() == "Paid" ? "bg-success" : (Eval("PaymentStatus").ToString() == "Partial" ? "bg-warning text-dark" : "bg-danger") %>">
                                        <%# Eval("PaymentStatus") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <a href='<%# "FeeReceipt.aspx?rec=" + Eval("ReceiptNumber") %>' class="btn btn-sm btn-light border text-primary" title="View / Print Receipt">
                                        <i class="fa-solid fa-print"></i> Receipt
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
