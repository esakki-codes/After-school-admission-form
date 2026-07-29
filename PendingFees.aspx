<%@ Page Title="Pending Fees" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PendingFees.aspx.cs" Inherits="AfterSchoolAdmission.PendingFees" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold text-dark mb-1">Outstanding Fee Dues</h3>
                <p class="text-muted small mb-0">List of students with pending or partial fee balances</p>
            </div>
            <a href="FeePayment.aspx" class="btn btn-success fw-semibold">
                <i class="fa-solid fa-credit-card me-1"></i> Collect Fee
            </a>
        </div>

        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-header bg-white py-3 border-bottom">
                <h5 class="fw-bold text-dark mb-0"><i class="fa-solid fa-triangle-exclamation text-danger me-2"></i>Pending Fee Accounts</h5>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvPending" runat="server" AutoGenerateColumns="False" 
                        CssClass="table table-hover align-middle mb-0" EmptyDataText="No pending fee dues! All student accounts are fully paid.">
                        <Columns>
                            <asp:BoundField DataField="AdmissionNo" HeaderText="Admission No" />
                            <asp:BoundField DataField="FullName" HeaderText="Student Name" HeaderStyle-CssClass="fw-bold" />
                            <asp:BoundField DataField="Standard" HeaderText="Class" />
                            <asp:BoundField DataField="ProgramType" HeaderText="Program" />
                            <asp:TemplateField HeaderText="Parent Contact">
                                <ItemTemplate>
                                    <div class="fw-semibold"><%# Eval("FatherName") %></div>
                                    <small class="text-muted"><i class="fa-solid fa-phone me-1"></i><%# Eval("FatherMobile") %></small>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="FeeForMonth" HeaderText="Fee Period" />
                            <asp:BoundField DataField="TotalAmount" HeaderText="Total (₹)" DataFormatString="{0:N2}" />
                            <asp:BoundField DataField="AmountPaid" HeaderText="Paid (₹)" DataFormatString="{0:N2}" ItemStyle-CssClass="text-success fw-bold" />
                            <asp:BoundField DataField="BalanceAmount" HeaderText="Balance Dues (₹)" DataFormatString="{0:N2}" ItemStyle-CssClass="text-danger fw-bold fs-6" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <a href='<%# "FeePayment.aspx?studentId=" + Eval("StudentID") %>' class="btn btn-sm btn-success fw-bold shadow-sm">
                                        <i class="fa-solid fa-hand-holding-dollar me-1"></i> Clear Dues
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
