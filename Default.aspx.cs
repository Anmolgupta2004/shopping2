using System;
using System.Data;

namespace OnlineShoppingSite
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadFeaturedProducts();
            }
        }

        private void LoadCategories()
        {
            string query = "SELECT CategoryId, CategoryName FROM Categories ORDER BY CategoryName";
            DataTable dt = DatabaseHelper.ExecuteQuery(query);
            rptCategories.DataSource = dt;
            rptCategories.DataBind();
        }

        private void LoadFeaturedProducts()
        {
            // For this example, we'll just load the latest 5 products
            string query = @"SELECT TOP 5 ProductId, ProductName, Description, Price 
                           FROM Products 
                           ORDER BY ProductId DESC";
            DataTable dt = DatabaseHelper.ExecuteQuery(query);
            rptFeaturedProducts.DataSource = dt;
            rptFeaturedProducts.DataBind();
        }
    }
} 