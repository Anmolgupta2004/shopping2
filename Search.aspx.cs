using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace OnlineShoppingSite
{
    public partial class Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                
                // If there's a search query in URL, perform search
                string searchQuery = Request.QueryString["q"];
                string categoryId = Request.QueryString["category"];
                
                if (!string.IsNullOrEmpty(searchQuery))
                {
                    txtSearch.Text = searchQuery;
                    if (!string.IsNullOrEmpty(categoryId))
                    {
                        ddlCategory.SelectedValue = categoryId;
                    }
                    PerformSearch();
                }
            }
        }

        private void LoadCategories()
        {
            string query = "SELECT CategoryId, CategoryName FROM Categories ORDER BY CategoryName";
            DataTable dt = DatabaseHelper.ExecuteQuery(query);
            
            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "CategoryId";
            ddlCategory.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            PerformSearch();
        }

        private void PerformSearch()
        {
            string searchTerm = txtSearch.Text.Trim();
            string categoryId = ddlCategory.SelectedValue;

            string query = @"SELECT p.*, c.CategoryName 
                           FROM Products p 
                           INNER JOIN Categories c ON p.CategoryId = c.CategoryId 
                           WHERE (@CategoryId = '' OR p.CategoryId = @CategoryId)
                           AND (
                               p.ProductName LIKE @SearchTerm 
                               OR p.Description LIKE @SearchTerm 
                               OR c.CategoryName LIKE @SearchTerm
                           )";

            var parameters = new SqlParameter[] {
                new SqlParameter("@CategoryId", categoryId),
                new SqlParameter("@SearchTerm", "%" + searchTerm + "%")
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
            rptSearchResults.DataSource = dt;
            rptSearchResults.DataBind();

            pnlNoResults.Visible = dt.Rows.Count == 0;
        }

        protected void rptSearchResults_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int productId = Convert.ToInt32(e.CommandArgument);

            switch (e.CommandName)
            {
                case "AddToCart":
                    if (!User.Identity.IsAuthenticated)
                    {
                        Response.Redirect("~/Login.aspx?ReturnUrl=" + Request.RawUrl);
                        return;
                    }

                    Dictionary<int, int> cart = Session["Cart"] as Dictionary<int, int>;
                    if (cart == null)
                    {
                        cart = new Dictionary<int, int>();
                        Session["Cart"] = cart;
                    }

                    if (cart.ContainsKey(productId))
                    {
                        cart[productId]++;
                    }
                    else
                    {
                        cart.Add(productId, 1);
                    }

                    Response.Redirect("~/Cart.aspx");
                    break;

                case "ViewDetails":
                    Response.Redirect($"~/Products.aspx?id={productId}");
                    break;
            }
        }
    }
} 