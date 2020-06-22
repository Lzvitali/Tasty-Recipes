using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TastyRecipes.DBConnection;

namespace TastyRecipes.pages
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ShowLogin(true);
            Page.Title = "Login";
        }

        protected void register_click(object sender, EventArgs e)
        {
            ShowLogin(false);
        }

        protected void login_click(object sender, EventArgs e)
        {
            using (var db = new DBConnection.TastyRecipesEntities())
            {
                var user = db.tbUsers.Where(u => u.UserEmail == txtBoxMailLogin.Text && u.UserPassword == txtBoxPasswordLogin.Text).FirstOrDefault();
                if(null == user)
                {
                    lblErrorLogin.Text = "email or password is incorrect";
                }
                else
                {
                    enterUserToSession(user.UserName, user.UserEmail);
                }

            }
        }

        private void ShowLogin(bool show)
        {
            pnlLogin.Visible = show;
            pnlRegistration.Visible = !show;
        }


        private void enterUserToSession(string UserName, string UserEmail)
        {
            Session["userName"] = UserName;
            Session["UserEmail"] = UserEmail;

            Session["currentPage"] = "Home";
            //Server.Transfer("Index.aspx");

            Response.Redirect("Index.aspx");
        }



        /* ------------------------ Registration ------------------------ */

        protected void submit_registration_click(object sender, EventArgs e)
        {
            using (var db = new DBConnection.TastyRecipesEntities())
            {
                var user = db.tbUsers.Where(u => u.UserEmail == txtBoxMailRegister.Text).FirstOrDefault();
                if (null == user)
                {
                    //tbUser t = new
                    db.tbUsers.Add(new tbUser { UserName = txtBoxUserNameRegister.Text, UserEmail = txtBoxMailRegister.Text, UserPassword = txtBoxPasswordRegister.Text });
                    db.SaveChanges();

                    enterUserToSession(txtBoxUserNameRegister.Text, txtBoxMailRegister.Text);
                    
                }
                else
                {
                    lblErrorRegister.Text = "User with that email is already exist";
                    ShowLogin(false);
                }

            }
        }

        protected void loginLink_click(object sender, EventArgs e)
        {
            ShowLogin(true);
        }

    }
}