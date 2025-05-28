<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="OnlineShoppingSite._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron bg-light p-5 mb-4 rounded">
        <h1 class="display-4">Welcome to Online Shopping</h1>
        <p class="lead">Discover amazing products at great prices!</p>
        <hr class="my-4">
        <p>Browse our categories below or search for specific products.</p>
    </div>

    <div class="row mb-4">
        <div class="col">
            <h2>Categories</h2>
            <asp:Repeater ID="rptCategories" runat="server">
                <ItemTemplate>
                    <div class="card mb-3">
                        <div class="card-body">
                            <h5 class="card-title">
                                <asp:HyperLink runat="server" 
                                    NavigateUrl='<%# "~/Products.aspx?category=" + Eval("CategoryId") %>'
                                    Text='<%# Eval("CategoryName") %>' />
                            </h5>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <div class="row">
        <div class="col">
            <h2>Featured Products</h2>
            <asp:Repeater ID="rptFeaturedProducts" runat="server">
                <ItemTemplate>
                    <div class="card mb-3">
                        <div class="card-body">
                            <h5 class="card-title"><%# Eval("ProductName") %></h5>
                            <p class="card-text"><%# Eval("Description") %></p>
                            <p class="card-text"><small class="text-muted">Price: $<%# Eval("Price", "{0:F2}") %></small></p>
                            <asp:HyperLink runat="server" 
                                NavigateUrl='<%# "~/Products.aspx?id=" + Eval("ProductId") %>'
                                CssClass="btn btn-primary"
                                Text="View Details" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content> 