<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OnlineShoppingSite.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <h2 class="text-center mb-4">Register</h2>
            <div class="card">
                <div class="card-body">
                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="txtName" CssClass="form-label">Name</asp:Label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName"
                            CssClass="text-danger" ErrorMessage="Name is required." />
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="form-label">Email</asp:Label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                            CssClass="text-danger" ErrorMessage="Email is required." />
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail"
                            CssClass="text-danger" ErrorMessage="Invalid email format."
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="txtPassword" CssClass="form-label">Password</asp:Label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword"
                            CssClass="text-danger" ErrorMessage="Password is required." />
                    </div>

                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="txtConfirmPassword" CssClass="form-label">Confirm Password</asp:Label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConfirmPassword"
                            CssClass="text-danger" ErrorMessage="Confirm password is required." />
                        <asp:CompareValidator runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword"
                            CssClass="text-danger" ErrorMessage="Passwords do not match." />
                    </div>

                    <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="btn btn-primary w-100" />
                    
                    <div class="mt-3 text-center">
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
                    </div>

                    <div class="mt-3 text-center">
                        Already have an account? <a href="Login.aspx">Login here</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content> 