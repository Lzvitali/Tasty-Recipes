using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.UI.HtmlControls;

namespace TastyRecipes.pages
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentPage"] != null)
            {
                if ((string)Session["currentPage"] == "Home")
                {
                    setVisibility(false, false, true);
                }
                if ((string)Session["currentPage"] == "About")
                {
                    setVisibility(true, false, false);
                }
                if ((string)Session["currentPage"] == "Contact")
                {
                    setVisibility(false, true, false);
                }
            }

        }

        private void setVisibility(bool isAbout, bool isContact, bool isHome)
        {
            divAbout.Visible = isAbout;
            divContact.Visible = isContact;
            divHome.Visible = isHome;
        }

        protected void btnSearch_click(object sender, EventArgs e)
        {
            // references:
            // how to get multiple values from selected - asp.net
            // https://stackoverflow.com/questions/16510821/how-to-get-multiple-values-from-selected-asp-net
            // https://www.google.com/search?safe=active&sxsrf=ALeKk01Ww9zKS36R7SRVcBFrpB8pXTfilA%3A1592837272427&ei=mMTwXqHAGc_2kwX10rHQBg&q=asp.net+get+selected+value+from+multiple+asp%3AListBox&oq=asp.net+get+selected+value+from+multiple+asp%3AListBox&gs_lcp=CgZwc3ktYWIQAzoHCCMQrgIQJ1DkuCRY7N8kYMLkJGgBcAB4AIABkgGIAd0CkgEDMS4ymAEAoAECoAEBqgEHZ3dzLXdpeg&sclient=psy-ab&ved=0ahUKEwih7Lqe1ZXqAhVP-6QKHXVpDGoQ4dUDCAw&uact=5

            // read the input of the time:
            // String str = inputTime.Text;
            
        }

        protected void myPosts_click(object sender, EventArgs e)
        {

        }
    }
}