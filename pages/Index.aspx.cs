using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TastyRecipes.pages
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(null != Session["UserEmail"])
            {
                lbl1.Text = string.Format("<p>Welcome {0} !</p>", Session["UserName"]);
            }
            else  // TODO: change this
            {
                Response.Redirect("Login.aspx");
            }
            
        }
    }
}