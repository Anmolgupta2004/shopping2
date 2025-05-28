<%@ Page Title="Order History" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="OnlineShoppingSite.OrderHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <h2>Order History</h2>
            
            <asp:Repeater ID="rptOrders" runat="server" OnItemDataBound="rptOrders_ItemDataBound">
                <ItemTemplate>
                    <div class="card mb-4">
                        <div class="card-header">
                            <div class="row align-items-center">
                                <div class="col">
                                    <h5 class="mb-0">Order #<%# Eval("OrderId") %></h5>
                                </div>
                                <div class="col text-end">
                                    <small class="text-muted"><%# Eval("OrderDate", "{0:MMM dd, yyyy hh:mm tt}") %></small>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <asp:Repeater ID="rptOrderItems" runat="server">
                                <HeaderTemplate>
                                    <div class="table-responsive">
                                        <table class="table">
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
                                        <td><%# Eval("Quantity") %></td>
                                        <td>$<%# ((decimal)Eval("Price") * (int)Eval("Quantity")).ToString("F2") %></td>
                                        <td>
                                            <asp:HyperLink runat="server" 
                                                NavigateUrl='<%# "~/Products.aspx?id=" + Eval("ProductId") %>'
                                                CssClass="btn btn-sm btn-outline-primary"
                                                Text="View Product" />
                                            <asp:Button runat="server" 
                                                CommandName="BuyAgain" 
                                                CommandArgument='<%# Eval("ProductId") %>'
                                                CssClass="btn btn-sm btn-primary"
                                                Text="Buy Again"
                                                OnClick="BuyAgain_Click" />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                            </tbody>
                                        </table>
                                    </div>
                                </FooterTemplate>
                            </asp:Repeater>
                            <div class="text-end mt-3">
                                <strong>Order Total: $<%# Eval("TotalAmount", "{0:F2}") %></strong>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:Panel ID="pnlNoOrders" runat="server" CssClass="alert alert-info" Visible="false">
                <p class="mb-0">You haven't placed any orders yet. <asp:HyperLink runat="server" NavigateUrl="~/Products.aspx" Text="Start shopping now!" /></p>
            </asp:Panel>
        </div>
    </div>
</asp:Content> 