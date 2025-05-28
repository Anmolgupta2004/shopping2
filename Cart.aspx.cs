using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Linq;

namespace OnlineShoppingSite
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Login.aspx?ReturnUrl=" + Request.RawUrl);
                return;
            }

            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        private void LoadCart()
        {
            Dictionary<int, int> cart = Session["Cart"] as Dictionary<int, int>;
            if (cart == null || cart.Count == 0)
            {
                pnlCart.Visible = false;
                pnlEmptyCart.Visible = true;
                return;
            }

            string productIds = string.Join(",", cart.Keys);
            string query = $@"SELECT ProductId, ProductName, Price 
                            FROM Products 
                            WHERE ProductId IN ({productIds})";

            DataTable dt = DatabaseHelper.ExecuteQuery(query);
            
            var cartItems = from row in dt.AsEnumerable()
                          let productId = Convert.ToInt32(row["ProductId"])
                          select new
                          {
                              ProductId = productId,
                              ProductName = row["ProductName"],
                              Price = Convert.ToDecimal(row["Price"]),
                              Quantity = cart[productId]
                          };

            rptCart.DataSource = cartItems;
            rptCart.DataBind();

            decimal subtotal = cartItems.Sum(item => item.Price * item.Quantity);
            litSubtotal.Text = subtotal.ToString("F2");
            litTotal.Text = subtotal.ToString("F2"); // Add tax/shipping calculation here if needed

            pnlCart.Visible = true;
            pnlEmptyCart.Visible = false;
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Dictionary<int, int> cart = Session["Cart"] as Dictionary<int, int>;
            if (cart == null) return;

            int productId = Convert.ToInt32(e.CommandArgument);

            switch (e.CommandName)
            {
                case "IncreaseQuantity":
                    if (cart.ContainsKey(productId))
                    {
                        cart[productId]++;
                    }
                    break;

                case "DecreaseQuantity":
                    if (cart.ContainsKey(productId))
                    {
                        if (cart[productId] > 1)
                            cart[productId]--;
                        else
                            cart.Remove(productId);
                    }
                    break;

                case "Remove":
                    cart.Remove(productId);
                    break;
            }

            Session["Cart"] = cart;
            LoadCart();
        }

        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Products.aspx");
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/BuyNow.aspx");
        }

        protected void btnStartShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Products.aspx");
        }
    }
} 