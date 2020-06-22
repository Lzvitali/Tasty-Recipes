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

        }
    }
}