<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BuyNow.aspx.cs" Inherits="OnlineShoppingSite.BuyNow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-8">
            <h2>Checkout</h2>
            
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Order Summary</h5>
                    <asp:Repeater ID="rptOrderSummary" runat="server">
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

                    <div class="d-flex justify-content-between mt-3">
                        <span>Total Amount:</span>
                        <strong class="text-primary">$<asp:Literal ID="litTotal" runat="server" /></strong>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Shipping Information</h5>
                    
                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="txtAddress" CssClass="form-label">Delivery Address</asp:Label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtAddress"
                            CssClass="text-danger" ErrorMessage="Address is required." />
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="txtPhone" CssClass="form-label">Phone Number</asp:Label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPhone"
                            CssClass="text-danger" ErrorMessage="Phone number is required." />
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="ddlPaymentMethod" CssClass="form-label">Payment Method</asp:Label>
                        <asp:DropDownList ID="ddlPaymentMethod" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Cash on Delivery" Value="COD" />
                            <asp:ListItem Text="Credit Card" Value="CC" />
                            <asp:ListItem Text="PayPal" Value="PP" />
                        </asp:DropDownList>
                    </div>

                    <div class="mt-4">
                        <asp:Button ID="btnPlaceOrder" runat="server" 
                            Text="Place Order" 
                            CssClass="btn btn-primary btn-lg w-100"
                            OnClick="btnPlaceOrder_Click" />
                    </div>

                    <div class="mt-3 text-center">
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content> 