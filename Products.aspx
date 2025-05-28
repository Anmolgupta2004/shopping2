<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="OnlineShoppingSite.Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-3">
            <h3>Categories</h3>
            <div class="list-group mb-4">
                <asp:Repeater ID="rptCategories" runat="server">
                    <ItemTemplate>
                        <asp:HyperLink runat="server" 
                            NavigateUrl='<%# "~/Products.aspx?category=" + Eval("CategoryId") %>'
                            CssClass='<%# "list-group-item list-group-item-action" + (Request.QueryString["category"] == Eval("CategoryId").ToString() ? " active" : "") %>'
                            Text='<%# Eval("CategoryName") %>' />
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <div class="col-md-9">
            <asp:Panel ID="pnlProductList" runat="server">
                <h2>
                    <asp:Literal ID="litCategoryName" runat="server" />
                    Products
                </h2>

                <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                    <ItemTemplate>
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-8">
                                        <h5 class="card-title"><%# Eval("ProductName") %></h5>
                                        <p class="card-text"><%# Eval("Description") %></p>
                                        <p class="card-text">
                                            <strong>Price: </strong>
                                            <span class="text-primary">$<%# Eval("Price", "{0:F2}") %></span>
                                        </p>
                                    </div>
                                    <div class="col-md-4 text-end">
                                        <asp:Button runat="server" 
                                            CommandName="AddToCart" 
                                            CommandArgument='<%# Eval("ProductId") %>'
                                            CssClass="btn btn-outline-primary mb-2 w-100"
                                            Text="Add to Cart" />
                                        <asp:Button runat="server" 
                                            CommandName="BuyNow" 
                                            CommandArgument='<%# Eval("ProductId") %>'
                                            CssClass="btn btn-primary w-100"
                                            Text="Buy Now" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Panel ID="pnlNoProducts" runat="server" CssClass="alert alert-info" Visible="false">
                    No products found in this category.
                </asp:Panel>
            </asp:Panel>

            <asp:Panel ID="pnlProductDetail" runat="server" Visible="false">
                <div class="card">
                    <div class="card-body">
                        <h3 class="card-title">
                            <asp:Literal ID="litProductName" runat="server" />
                        </h3>
                        <p class="card-text">
                            <asp:Literal ID="litDescription" runat="server" />
                        </p>
                        <p class="card-text">
                            <strong>Price: </strong>
                            $<asp:Literal ID="litPrice" runat="server" />
                        </p>
                        <div class="mt-3">
                            <asp:Button ID="btnAddToCart" runat="server" 
                                CssClass="btn btn-outline-primary me-2"
                                Text="Add to Cart"
                                OnClick="btnAddToCart_Click" />
                            <asp:Button ID="btnBuyNow" runat="server" 
                                CssClass="btn btn-primary"
                                Text="Buy Now"
                                OnClick="btnBuyNow_Click" />
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content> 