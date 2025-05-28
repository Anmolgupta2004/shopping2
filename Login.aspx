<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OnlineShoppingSite.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <h2 class="text-center mb-4">Login</h2>
            <div class="card">
                <div class="card-body">
                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="form-label">Email</asp:Label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                            CssClass="text-danger" ErrorMessage="Email is required." />
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="txtPassword" CssClass="form-label">Password</asp:Label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword"
                            CssClass="text-danger" ErrorMessage="Password is required." />
                    </div>

                    <div class="mb-3">
                        <asp:CheckBox ID="chkRememberMe" runat="server" Text="Remember me" CssClass="form-check-input" />
                    </div>

                    <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn btn-primary w-100" />
                    
                    <div class="mt-3 text-center">
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
                    </div>

                    <div class="mt-3 text-center">
                        Don't have an account? <a href="Register.aspx">Register here</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content> 