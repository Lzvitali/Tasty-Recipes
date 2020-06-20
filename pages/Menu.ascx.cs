using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TastyRecipes.pages
{
    public partial class Menu : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["currentPage"] != null)
            {
                if((string)Session["currentPage"] == "Home")
                {
                    btnHome.Attributes.Add("class", "nav-item active");
                    Page.Title = "Tasty Recipes";

                }
                if ((string)Session["currentPage"] == "About")
                {
                    btnAbout.Attributes.Add("class", "nav-item active");
                    Page.Title = "About";
                }
                if ((string)Session["currentPage"] == "Contact")
                {
                    btnContact.Attributes.Add("class", "nav-item active");
                    Page.Title = "Contact";
                }
            }
            else  // for the first time
            {
                Session["currentPage"] = "Home";
                btnHome.Attributes.Add("class", "nav-item active");
                Page.Title = "Home";
               
            }

            // change the 'login' btn to 'logout' (if it after login)
            if (null != Session["UserEmail"])
            {
                btnLogin.Text = "Logout";

                lableUserGreeting.Text = "Hello " + Session["UserName"];
            }

        }

        protected void btnLogin_click(object sender, EventArgs e)
        {
            // if the user is was connected and pressed that button - change the text to "login"
            // because now he will be loged-out
            if (null != Session["UserEmail"])
            {
                btnLogin.Text = "Login";
                Session["UserEmail"] = null;

                lableUserGreeting.Text = "";
            }
            else
            {
                Session["currentPage"] = "Login";
                Response.Redirect("Login.aspx");
            }
            
        }

        protected void clickHome(object sender, EventArgs e)
        {
            Session["currentPage"] = "Home";

            Response.Redirect("Index.aspx");
        }

        protected void clickAbout(object sender, EventArgs e)
        {
            Session["currentPage"] = "About";

            Response.Redirect("Index.aspx");
        }

        protected void clickContact(object sender, EventArgs e)
        {
            Session["currentPage"] = "Contact";

            Response.Redirect("Index.aspx");
        }
    }
}