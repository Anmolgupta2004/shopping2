<%@ Page Title="Order Confirmation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderConfirmation.aspx.cs" Inherits="OnlineShoppingSite.OrderConfirmation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-body text-center">
                    <h1 class="card-title text-success">
                        <i class="bi bi-check-circle-fill"></i> Thank You!
                    </h1>
                    <h4 class="mb-4">Your order has been placed successfully!</h4>
                    
                    <div class="alert alert-success">
                        <p class="mb-0">We'll process your order soon.</p>
                        <p class="mb-0">A confirmation email has been sent to your registered email address.</p>
                    </div>

                    <div class="mt-4">
                        <h5>Recent Order Details</h5>
                        <asp:Repeater ID="rptOrderDetails" runat="server">
                            <HeaderTemplate>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Product</th>
                                                <th>Price</th>
                                                <th>Quantity</th>
                                                <th>Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("ProductName") %></td>
                                    <td>$<%# Eval("Price", "{0:F2}") %></td>
                                    <td><%# Eval("Quantity") %></td>
                                    <td>$<%# ((decimal)Eval("Price") * (int)Eval("Quantity")).ToString("F2") %></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                        </tbody>
                                    </table>
                                </div>
                            </FooterTemplate>
                        </asp:Repeater>

                        <div class="text-end mb-4">
                            <strong>Total Amount: $<asp:Literal ID="litTotal" runat="server" /></strong>
                        </div>
                    </div>

                    <div class="mt-4">
                        <asp:Button ID="btnContinueShopping" runat="server" 
                            Text="Continue Shopping" 
                            CssClass="btn btn-primary btn-lg"
                            OnClick="btnContinueShopping_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content> 