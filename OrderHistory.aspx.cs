using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace OnlineShoppingSite
{
    public partial class OrderHistory : System.Web.UI.Page
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
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            string query = @"SELECT DISTINCT o.OrderId, o.OrderDate,
                           SUM(p.Price * o.Quantity) OVER (PARTITION BY o.OrderId) as TotalAmount
                           FROM Orders o
                           INNER JOIN Products p ON o.ProductId = p.ProductId
                           INNER JOIN Users u ON o.UserId = u.UserId
                           WHERE u.Email = @Email
                           ORDER BY o.OrderDate DESC";

            var parameters = new SqlParameter[] {
                new SqlParameter("@Email", User.Identity.Name)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
            rptOrders.DataSource = dt;
            rptOrders.DataBind();

            pnlNoOrders.Visible = dt.Rows.Count == 0;
        }

        protected void rptOrders_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView row = e.Item.DataItem as DataRowView;
                int orderId = Convert.ToInt32(row["OrderId"]);
                Repeater rptOrderItems = e.Item.FindControl("rptOrderItems") as Repeater;

                string query = @"SELECT o.OrderId, o.Quantity, p.ProductId, p.ProductName, p.Price
                               FROM Orders o
                               INNER JOIN Products p ON o.ProductId = p.ProductId
                               WHERE o.OrderId = @OrderId";

                var parameters = new SqlParameter[] {
                    new SqlParameter("@OrderId", orderId)
                };

                DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
                rptOrderItems.DataSource = dt;
                rptOrderItems.DataBind();
            }
        }

        protected void BuyAgain_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            if (btn != null)
            {
                int productId = Convert.ToInt32(btn.CommandArgument);
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
            }
        }
    }
} 