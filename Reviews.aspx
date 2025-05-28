<%@ Page Title="Product Reviews" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reviews.aspx.cs" Inherits="OnlineShoppingSite.Reviews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .star-rating {
            color: #ffc107;
            font-size: 1.2em;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <h2>Reviews for <asp:Literal ID="litProductName" runat="server" /></h2>
            
            <asp:Panel ID="pnlAddReview" runat="server" CssClass="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">Write a Review</h5>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label for="ddlRating" class="form-label">Rating</label>
                        <asp:DropDownList ID="ddlRating" runat="server" CssClass="form-select">
                            <asp:ListItem Text="5 Stars" Value="5" />
                            <asp:ListItem Text="4 Stars" Value="4" />
                            <asp:ListItem Text="3 Stars" Value="3" />
                            <asp:ListItem Text="2 Stars" Value="2" />
                            <asp:ListItem Text="1 Star" Value="1" />
                        </asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <label for="txtReview" class="form-label">Your Review</label>
                        <asp:TextBox ID="txtReview" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtReview"
                            CssClass="text-danger" ErrorMessage="Please enter your review." />
                    </div>
                    <asp:Button ID="btnSubmitReview" runat="server" Text="Submit Review" 
                        CssClass="btn btn-primary" OnClick="btnSubmitReview_Click" />
                </div>
            </asp:Panel>

            <asp:Repeater ID="rptReviews" runat="server">
                <ItemTemplate>
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <div>
                                    <span class="star-rating">
                                        <%# GetStarRating(Convert.ToInt32(Eval("Rating"))) %>
                                    </span>
                                    <small class="text-muted ms-2">by <%# Eval("UserEmail") %></small>
                                </div>
                                <small class="text-muted"><%# Eval("ReviewDate", "{0:MMM dd, yyyy}") %></small>
                            </div>
                            <p class="card-text"><%# Eval("ReviewText") %></p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:Panel ID="pnlNoReviews" runat="server" CssClass="alert alert-info" Visible="false">
                <p class="mb-0">No reviews yet. Be the first to review this product!</p>
            </asp:Panel>
        </div>
    </div>
</asp:Content> 