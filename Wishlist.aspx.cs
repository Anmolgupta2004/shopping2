using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace OnlineShoppingSite
{
    public partial class Wishlist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadWishlist();
            }
        }

        private void LoadWishlist()
        {
            string query = @"SELECT w.ProductId, p.ProductName, p.Description, p.Price,
                           c.CategoryName, w.DateAdded
                           FROM Wishlist w
                           INNER JOIN Products p ON w.ProductId = p.ProductId
                           INNER JOIN Categories c ON p.CategoryId = c.CategoryId
                           INNER JOIN Users u ON w.UserId = u.UserId
                           WHERE u.Email = @Email
                           ORDER BY w.DateAdded DESC";

            var parameters = new SqlParameter[] {
                new SqlParameter("@Email", User.Identity.Name)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
            rptWishlist.DataSource = dt;
            rptWishlist.DataBind();

            pnlNoItems.Visible = dt.Rows.Count == 0;
        }

        protected void rptWishlist_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int productId = Convert.ToInt32(e.CommandArgument);

            switch (e.CommandName)
            {
                case "AddToCart":
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

                case "RemoveFromWishlist":
                    string query = @"DELETE FROM Wishlist 
                                   WHERE ProductId = @ProductId 
                                   AND UserId = (SELECT UserId FROM Users WHERE Email = @Email)";

                    var parameters = new SqlParameter[] {
                        new SqlParameter("@ProductId", productId),
                        new SqlParameter("@Email", User.Identity.Name)
                    };

                    DatabaseHelper.ExecuteNonQuery(query, parameters);
                    LoadWishlist();
                    break;
            }
        }
    }
} 