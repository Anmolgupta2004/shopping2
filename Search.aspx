<%@ Page Title="Search Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="OnlineShoppingSite.Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <h2>Search Products</h2>
            
            <div class="card mb-4">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-8">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Enter product name, description or category..." />
                        </div>
                        <div class="col-md-2">
                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select" AppendDataBoundItems="true">
                                <asp:ListItem Text="All Categories" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary w-100" OnClick="btnSearch_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <asp:Panel ID="pnlResults" runat="server">
                <h3>Search Results</h3>
                <asp:Repeater ID="rptSearchResults" runat="server" OnItemCommand="rptSearchResults_ItemCommand">
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
                                    </div>
                                    <div class="col-md-4 text-end">
                                        <asp:Button runat="server" 
                                            CommandName="AddToCart" 
                                            CommandArgument='<%# Eval("ProductId") %>'
                                            CssClass="btn btn-outline-primary mb-2 w-100"
                                            Text="Add to Cart" />
                                        <asp:Button runat="server" 
                                            CommandName="ViewDetails" 
                                            CommandArgument='<%# Eval("ProductId") %>'
                                            CssClass="btn btn-primary w-100"
                                            Text="View Details" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Panel ID="pnlNoResults" runat="server" CssClass="alert alert-info" Visible="false">
                    No products found matching your search criteria.
                </asp:Panel>
            </asp:Panel>
        </div>
    </div>
</asp:Content> 