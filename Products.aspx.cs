using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace OnlineShoppingSite
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();

                string productId = Request.QueryString["id"];
                string categoryId = Request.QueryString["category"];

                if (!string.IsNullOrEmpty(productId))
                {
                    LoadProductDetail(Convert.ToInt32(productId));
                }
                else
                {
                    LoadProducts(categoryId);
                }
            }
        }

        private void LoadCategories()
        {
            string query = "SELECT CategoryId, CategoryName FROM Categories ORDER BY CategoryName";
            DataTable dt = DatabaseHelper.ExecuteQuery(query);
            rptCategories.DataSource = dt;
            rptCategories.DataBind();
        }

        private void LoadProducts(string categoryId)
        {
            string query;
            SqlParameter[] parameters = null;

            if (!string.IsNullOrEmpty(categoryId))
            {
                query = @"SELECT p.*, c.CategoryName 
                         FROM Products p 
                         INNER JOIN Categories c ON p.CategoryId = c.CategoryId 
                         WHERE p.CategoryId = @CategoryId";
                parameters = new SqlParameter[] {
                    new SqlParameter("@CategoryId", categoryId)
                };

                // Set category name in title
                DataTable catDt = DatabaseHelper.ExecuteQuery(
                    "SELECT CategoryName FROM Categories WHERE CategoryId = @CategoryId",
                    parameters
                );
                if (catDt.Rows.Count > 0)
                {
                    litCategoryName.Text = catDt.Rows[0]["CategoryName"].ToString() + " ";
                }
            }
            else
            {
                query = @"SELECT p.*, c.CategoryName 
                         FROM Products p 
                         INNER JOIN Categories c ON p.CategoryId = c.CategoryId";
            }

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
            rptProducts.DataSource = dt;
            rptProducts.DataBind();

            pnlProductList.Visible = true;
            pnlProductDetail.Visible = false;
            pnlNoProducts.Visible = dt.Rows.Count == 0;
        }

        private void LoadProductDetail(int productId)
        {
            string query = @"SELECT p.*, c.CategoryName 
                           FROM Products p 
                           INNER JOIN Categories c ON p.CategoryId = c.CategoryId 
                           WHERE ProductId = @ProductId";
            var parameters = new SqlParameter[] {
                new SqlParameter("@ProductId", productId)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                litProductName.Text = row["ProductName"].ToString();
                litDescription.Text = row["Description"].ToString();
                litPrice.Text = Convert.ToDecimal(row["Price"]).ToString("F2");

                ViewState["CurrentProductId"] = productId;
                pnlProductList.Visible = false;
                pnlProductDetail.Visible = true;
            }
            else
            {
                Response.Redirect("~/Products.aspx");
            }
        }

        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int productId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "AddToCart")
            {
                AddProductToCart(productId);
                Response.Redirect("~/Cart.aspx");
            }
            else if (e.CommandName == "BuyNow")
            {
                AddProductToCart(productId);
                Response.Redirect("~/BuyNow.aspx");
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (ViewState["CurrentProductId"] != null)
            {
                int productId = Convert.ToInt32(ViewState["CurrentProductId"]);
                AddProductToCart(productId);
                Response.Redirect("~/Cart.aspx");
            }
        }

        protected void btnBuyNow_Click(object sender, EventArgs e)
        {
            if (ViewState["CurrentProductId"] != null)
            {
                int productId = Convert.ToInt32(ViewState["CurrentProductId"]);
                AddProductToCart(productId);
                Response.Redirect("~/BuyNow.aspx");
            }
        }

        private void AddProductToCart(int productId)
        {
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
        }
    }
} 