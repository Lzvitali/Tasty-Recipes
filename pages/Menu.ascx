<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Menu.ascx.cs" Inherits="TastyRecipes.pages.Menu" %>

<div class="collapse navbar-collapse" id="navbarColor01">
        <ul class="navbar-nav mr-auto" runat="server">
            <li class="nav-item <%if (Page.Title == "Home")
                {%>active<%}%>" id="btnHome">
                <a href="Home.aspx" class="nav-link">Home</a>
            </li>
            <li class="nav-item <%if (Page.Title == "About")
                {%>active<%}%>">
                <a href="#" class="nav-link">About</a>
            </li>
            <li class="nav-item <%if (Page.Title == "Contact")
                {%>active<%}%>">
                <a href="#" class="nav-link">Contact</a>
            </li>
        </ul>

    <asp:LinkButton runat="server" ID="loginBtn" CssClass="btn btn-secondary my-2 my-sm-0" Text="Login" OnClick="btnLogin_click"
        CausesValidation="false" Style="font-family: cursive;"></asp:LinkButton>

</div>
