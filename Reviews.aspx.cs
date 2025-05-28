using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace OnlineShoppingSite
{
    public partial class Reviews : System.Web.UI.Page
    {
        private int ProductId
        {
            get
            {
                if (Request.QueryString["id"] != null && int.TryParse(Request.QueryString["id"], out int id))
                    return id;
                return -1;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (ProductId == -1)
            {
                Response.Redirect("~/Products.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProductDetails();
                LoadReviews();
            }

            pnlAddReview.Visible = User.Identity.IsAuthenticated;
        }

        private void LoadProductDetails()
        {
            string query = "SELECT ProductName FROM Products WHERE ProductId = @ProductId";
            var parameters = new SqlParameter[] {
                new SqlParameter("@ProductId", ProductId)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
            if (dt.Rows.Count > 0)
            {
                litProductName.Text = dt.Rows[0]["ProductName"].ToString();
            }
        }

        private void LoadReviews()
        {
            string query = @"SELECT r.Rating, r.ReviewText, r.ReviewDate, u.Email as UserEmail
                           FROM Reviews r
                           INNER JOIN Users u ON r.UserId = u.UserId
                           WHERE r.ProductId = @ProductId
                           ORDER BY r.ReviewDate DESC";

            var parameters = new SqlParameter[] {
                new SqlParameter("@ProductId", ProductId)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);
            rptReviews.DataSource = dt;
            rptReviews.DataBind();

            pnlNoReviews.Visible = dt.Rows.Count == 0;
        }

        protected void btnSubmitReview_Click(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            string query = @"INSERT INTO Reviews (ProductId, UserId, Rating, ReviewText, ReviewDate)
                           SELECT @ProductId, UserId, @Rating, @ReviewText, GETDATE()
                           FROM Users WHERE Email = @Email";

            var parameters = new SqlParameter[] {
                new SqlParameter("@ProductId", ProductId),
                new SqlParameter("@Rating", Convert.ToInt32(ddlRating.SelectedValue)),
                new SqlParameter("@ReviewText", txtReview.Text.Trim()),
                new SqlParameter("@Email", User.Identity.Name)
            };

            DatabaseHelper.ExecuteNonQuery(query, parameters);

            txtReview.Text = string.Empty;
            ddlRating.SelectedValue = "5";
            LoadReviews();
        }

        protected string GetStarRating(int rating)
        {
            StringBuilder stars = new StringBuilder();
            for (int i = 0; i < rating; i++)
            {
                stars.Append("★");
            }
            for (int i = rating; i < 5; i++)
            {
                stars.Append("☆");
            }
            return stars.ToString();
        }
    }
} 