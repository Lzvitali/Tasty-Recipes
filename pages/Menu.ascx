<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Menu.ascx.cs" Inherits="TastyRecipes.pages.Menu" %>

<div class="collapse navbar-collapse" id="navbarColor01" style="position: relative">
    <asp:Panel ID="pnlNotLogedIn" runat="server">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item <%if (Page.Title == "About")
                {%>active<%}%>">
                <a href="#" class="nav-link">About</a>
            </li>
            <li class="nav-item <%if (Page.Title == "Contact")
                {%>active<%}%>">
                <a href="#" class="nav-link">Contact</a>
            </li>
        </ul>

    </asp:Panel>

    <asp:Panel ID="pnlLogedIn" runat="server" Visible="false">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item <%if (Page.Title == "Home")
                {%>active<%}%>">
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
    </asp:Panel>

    <asp:LinkButton runat="server" ID="loginBtn" CssClass="btn btn-secondary my-2 my-sm-0" Text="Login" OnClick="btnLogin_click"
        CausesValidation="false" Style="position: absolute; right: 0; font-family: cursive;"></asp:LinkButton>
    <%--<button class="btn btn-secondary my-2 my-sm-0" style="position: absolute; right: 0">Login</button>--%>

</div>
