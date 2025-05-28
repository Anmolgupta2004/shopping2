using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace OnlineShoppingSite
{
    public partial class OrderConfirmation : System.Web.UI.Page
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
                LoadRecentOrder();
            }
        }

        private void LoadRecentOrder()
        {
            try
            {
                string query = @"SELECT p.ProductName, p.Price, o.Quantity, o.OrderDate
                               FROM Orders o
                               INNER JOIN Products p ON o.ProductId = p.ProductId
                               INNER JOIN Users u ON o.UserId = u.UserId
                               WHERE u.Email = @Email
                               AND o.OrderDate = (
                                   SELECT MAX(OrderDate)
                                   FROM Orders o2
                                   INNER JOIN Users u2 ON o2.UserId = u2.UserId
                                   WHERE u2.Email = @Email
                               )";

                var parameters = new SqlParameter[] {
                    new SqlParameter("@Email", User.Identity.Name)
                };

                DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
                
                if (dt.Rows.Count > 0)
                {
                    rptOrderDetails.DataSource = dt;
                    rptOrderDetails.DataBind();

                    decimal total = dt.AsEnumerable()
                        .Sum(row => Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]));
                    litTotal.Text = total.ToString("F2");
                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }
            catch (Exception ex)
            {
                // Log the error
                Response.Redirect("~/Default.aspx");
            }
        }

        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Products.aspx");
        }
    }
} 