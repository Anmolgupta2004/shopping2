<%@ Page Title="My Wishlist" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Wishlist.aspx.cs" Inherits="OnlineShoppingSite.Wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <h2>My Wishlist</h2>
            
            <asp:Repeater ID="rptWishlist" runat="server" OnItemCommand="rptWishlist_ItemCommand">
                <ItemTemplate>
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-8">
                                    <h5 class="card-title"><%# Eval("ProductName") %></h5>
                                    <p class="card-text"><%# Eval("Description") %></p>
                                    <p class="card-text">
                                        <small class="text-muted">Category: <%# Eval("CategoryName") %></small>
                                    </p>
                                    <p class="card-text">
                                        <strong>Price: </strong>
                                        <span class="text-primary">$<%# Eval("Price", "{0:F2}") %></span>
                                    </p>
                                    <small class="text-muted">Added on <%# Eval("DateAdded", "{0:MMM dd, yyyy}") %></small>
                                </div>
                                <div class="col-md-4 text-end">
                                    <asp:Button runat="server" 
                                        CommandName="AddToCart" 
                                        CommandArgument='<%# Eval("ProductId") %>'
                                        CssClass="btn btn-primary mb-2 w-100"
                                        Text="Add to Cart" />
                                    <asp:Button runat="server" 
                                        CommandName="RemoveFromWishlist" 
                                        CommandArgument='<%# Eval("ProductId") %>'
                                        CssClass="btn btn-outline-danger w-100"
                                        Text="Remove from Wishlist" />
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:Panel ID="pnlNoItems" runat="server" CssClass="alert alert-info" Visible="false">
                <p class="mb-0">Your wishlist is empty. <asp:HyperLink runat="server" NavigateUrl="~/Products.aspx" Text="Browse products" /> to add items to your wishlist!</p>
            </asp:Panel>
        </div>
    </div>
</asp:Content> 