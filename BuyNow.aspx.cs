using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;

namespace OnlineShoppingSite
{
    public partial class BuyNow : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Login.aspx?ReturnUrl=" + Request.RawUrl);
                return;
            }

            Dictionary<int, int> cart = Session["Cart"] as Dictionary<int, int>;
            if (cart == null || cart.Count == 0)
            {
                Response.Redirect("~/Cart.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadOrderSummary();
            }
        }

        private void LoadOrderSummary()
        {
            Dictionary<int, int> cart = Session["Cart"] as Dictionary<int, int>;
            string productIds = string.Join(",", cart.Keys);
            string query = $@"SELECT ProductId, ProductName, Price 
                            FROM Products 
                            WHERE ProductId IN ({productIds})";

            DataTable dt = DatabaseHelper.ExecuteQuery(query);
            
            var orderItems = from row in dt.AsEnumerable()
                           let productId = Convert.ToInt32(row["ProductId"])
                           select new
                           {
                               ProductId = productId,
                               ProductName = row["ProductName"],
                               Price = Convert.ToDecimal(row["Price"]),
                               Quantity = cart[productId]
                           };

            rptOrderSummary.DataSource = orderItems;
            rptOrderSummary.DataBind();

            decimal total = orderItems.Sum(item => item.Price * item.Quantity);
            litTotal.Text = total.ToString("F2");
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                Dictionary<int, int> cart = Session["Cart"] as Dictionary<int, int>;
                if (cart == null || cart.Count == 0)
                {
                    lblMessage.Text = "Your cart is empty.";
                    return;
                }

                // Get user ID
                string userQuery = "SELECT UserId FROM Users WHERE Email = @Email";
                var userParams = new SqlParameter[] {
                    new SqlParameter("@Email", User.Identity.Name)
                };
                object userId = DatabaseHelper.ExecuteScalar(userQuery, userParams);

                if (userId == null)
                {
                    lblMessage.Text = "User not found.";
                    return;
                }

                // Begin transaction to insert orders
                using (SqlConnection conn = DatabaseHelper.GetConnection())
                {
                    conn.Open();
                    using (SqlTransaction transaction = conn.BeginTransaction())
                    {
                        try
                        {
                            foreach (var item in cart)
                            {
                                string insertQuery = @"INSERT INTO Orders (UserId, ProductId, Quantity, OrderDate) 
                                                     VALUES (@UserId, @ProductId, @Quantity, GETDATE())";

                                using (SqlCommand cmd = new SqlCommand(insertQuery, conn, transaction))
                                {
                                    cmd.Parameters.AddWithValue("@UserId", userId);
                                    cmd.Parameters.AddWithValue("@ProductId", item.Key);
                                    cmd.Parameters.AddWithValue("@Quantity", item.Value);
                                    cmd.ExecuteNonQuery();
                                }
                            }

                            transaction.Commit();
                            Session.Remove("Cart");
                            Response.Redirect("~/OrderConfirmation.aspx");
                        }
                        catch
                        {
                            transaction.Rollback();
                            throw;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "An error occurred while processing your order. Please try again.";
                // Log the error
            }
        }
    }
} 