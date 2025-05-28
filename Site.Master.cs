using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineShoppingSite
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnQuickSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtQuickSearch.Value.Trim();
            if (!string.IsNullOrEmpty(searchTerm))
            {
                Response.Redirect(string.Format("~/Search.aspx?q={0}", Server.UrlEncode(searchTerm)));
            }
        }
    }
} 