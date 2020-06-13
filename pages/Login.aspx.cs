using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TastyRecipes.pages
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ShowLogin(true);
        }

        protected void register_click(object sender, EventArgs e)
        {
            ShowLogin(false);
        }

        protected void login_click(object sender, EventArgs e)
        {
            ShowLogin(true);
        }

        private void ShowLogin(bool show)
        {
            pnlLogin.Visible = show;
            pnlRegistration.Visible = !show;
        }

        protected void submit_registration_click(object sender, EventArgs e)
        {
            
        }

        protected void loginLink_click(object sender, EventArgs e)
        {

        }

    }
}