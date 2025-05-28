using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Security;

namespace OnlineShoppingSite
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    string query = "SELECT UserId, Password FROM Users WHERE Email = @Email";
                    var parameters = new SqlParameter[] {
                        new SqlParameter("@Email", txtEmail.Text.Trim())
                    };

                    DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);

                    if (dt.Rows.Count > 0)
                    {
                        string storedPassword = dt.Rows[0]["Password"].ToString();
                        string hashedInputPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(txtPassword.Text, "SHA1");

                        if (storedPassword == hashedInputPassword)
                        {
                            FormsAuthentication.SetAuthCookie(txtEmail.Text.Trim(), chkRememberMe.Checked);
                            
                            string returnUrl = Request.QueryString["ReturnUrl"];
                            if (!string.IsNullOrEmpty(returnUrl))
                            {
                                Response.Redirect(returnUrl);
                            }
                            else
                            {
                                Response.Redirect("~/Default.aspx");
                            }
                        }
                        else
                        {
                            lblMessage.Text = "Invalid email or password.";
                        }
                    }
                    else
                    {
                        lblMessage.Text = "Invalid email or password.";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "An error occurred during login. Please try again.";
                    // Log the error
                }
            }
        }
    }
} 