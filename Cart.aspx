<%@ Page Title="Shopping Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="OnlineShoppingSite.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Shopping Cart</h2>

    <asp:Panel ID="pnlCart" runat="server">
        <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
            <HeaderTemplate>
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("ProductName") %></td>
                    <td>$<%# Eval("Price", "{0:F2}") %></td>
                    <td>
                        <div class="input-group" style="max-width: 150px;">
                            <asp:Button runat="server" 
                                CommandName="DecreaseQuantity" 
                                CommandArgument='<%# Eval("ProductId") %>'
                                CssClass="btn btn-outline-secondary"
                                Text="-" />
                            <asp:TextBox runat="server" 
                                Text='<%# Eval("Quantity") %>' 
                                CssClass="form-control text-center"
                                ReadOnly="true" />
                            <asp:Button runat="server" 
                                CommandName="IncreaseQuantity" 
                                CommandArgument='<%# Eval("ProductId") %>'
                                CssClass="btn btn-outline-secondary"
                                Text="+" />
                        </div>
                    </td>
                    <td>$<%# ((decimal)Eval("Price") * (int)Eval("Quantity")).ToString("F2") %></td>
                    <td>
                        <asp:Button runat="server" 
                            CommandName="Remove" 
                            CommandArgument='<%# Eval("ProductId") %>'
                            CssClass="btn btn-danger btn-sm"
                            Text="Remove" />
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                        </tbody>
                    </table>
                </div>
            </FooterTemplate>
        </asp:Repeater>

        <div class="row mt-4">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Order Summary</h5>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Subtotal:</span>
                            <strong>$<asp:Literal ID="litSubtotal" runat="server" /></strong>
                        </div>
                        <hr />
                        <div class="d-flex justify-content-between">
                            <span>Total:</span>
                            <strong class="text-primary">$<asp:Literal ID="litTotal" runat="server" /></strong>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <asp:Button ID="btnContinueShopping" runat="server" 
                    Text="Continue Shopping" 
                    CssClass="btn btn-outline-primary me-2"
                    OnClick="btnContinueShopping_Click" />
                <asp:Button ID="btnCheckout" runat="server" 
                    Text="Proceed to Checkout" 
                    CssClass="btn btn-primary"
                    OnClick="btnCheckout_Click" />
            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlEmptyCart" runat="server" CssClass="text-center py-5" Visible="false">
        <h3>Your cart is empty</h3>
        <p>Add some products to your cart and come back!</p>
        <asp:Button ID="btnStartShopping" runat="server" 
            Text="Start Shopping" 
            CssClass="btn btn-primary"
            OnClick="btnStartShopping_Click" />
    </asp:Panel>
</asp:Content> 