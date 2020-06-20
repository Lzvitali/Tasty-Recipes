<%@ Page Title="" Language="C#" MasterPageFile="~/pages/MainTemplate.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="TastyRecipes.pages.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="divAbout" class="container" runat="server" visible="false" style="margin-top: 20px;">
        <div class="jumbotron" style="padding: 1rem 2rem; margin-bottom: 1rem;">
            <h2 class="font-weight-bold">
            <span>About Tasty Recipes
            </span>
        </h2>
            <em class="text-secondary lead">Tasty Recipes is website for viewing and sharing wonderful food recipes.</em>
        </div>
        
        <p class="text-secondary lead" style="padding: 0rem 2rem;"><em>
                Our website includes recipes at all levels of difficulty and all the variety of ingredients.<br>
                Anyone can view the recipes on the website. You can also sign up and then share your own recipes.<br>
            </em>
        </p>
    </div>

    <div id="divContact" class="container" runat="server" visible="false" style="margin-top: 20px;">
        <div class="jumbotron" style="padding: 1rem 2rem; margin-bottom: 1rem;">
            <h2 class="font-weight-bold">
            <span>Contact us
            </span>
        </h2 >
            <em class="text-secondary lead">For any technical support or enquiries, please email
                <a href="mailto:tastyRecipes@gmail.com">tastyRecipes@gmail.com</a></em>
        </div>
        
        <p class="text-secondary lead" style="padding: 0rem 2rem;"><em>
               ORT Braude College of Engineering.<br>
               Software Departmant.<br>
               51 Snunit st. Carmiel.<br>
            </em>
        </p>
    </div>


    <div id="divHome" class="container" runat="server">
    </div>

</asp:Content>
