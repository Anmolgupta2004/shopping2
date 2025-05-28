using System;
using System.Data.SqlClient;
using System.Web.Security;

namespace OnlineShoppingSite
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // Check if email already exists
                    string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                    var checkParams = new SqlParameter[] {
                        new SqlParameter("@Email", txtEmail.Text.Trim())
                    };

                    int existingCount = Convert.ToInt32(DatabaseHelper.ExecuteScalar(checkQuery, checkParams));

                    if (existingCount > 0)
                    {
                        lblMessage.Text = "Email already registered. Please use a different email.";
                        return;
                    }

                    // Insert new user
                    string insertQuery = @"INSERT INTO Users (Name, Email, Password) 
                                        VALUES (@Name, @Email, @Password)";

                    var parameters = new SqlParameter[] {
                        new SqlParameter("@Name", txtName.Text.Trim()),
                        new SqlParameter("@Email", txtEmail.Text.Trim()),
                        new SqlParameter("@Password", FormsAuthentication.HashPasswordForStoringInConfigFile(txtPassword.Text, "SHA1"))
                    };

                    int result = DatabaseHelper.ExecuteNonQuery(insertQuery, parameters);

                    if (result > 0)
                    {
                        FormsAuthentication.SetAuthCookie(txtEmail.Text.Trim(), false);
                        Response.Redirect("~/Default.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Registration failed. Please try again.";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "An error occurred during registration. Please try again.";
                    // Log the error
                }
            }
        }
    }
} 