<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Menu.ascx.cs" Inherits="TastyRecipes.pages.Menu" %>

<div class="collapse navbar-collapse" id="navbarColor01">
    <ul class="navbar-nav mr-auto" runat="server">
        <li class="nav-item" id="btnHome" runat="server">
            <asp:LinkButton class="nav-link" OnClick="clickHome" runat="server" CausesValidation="false">Home</asp:LinkButton>
        </li>
        <li class="nav-item" id="btnAbout" runat="server">
            <asp:LinkButton class="nav-link" OnClick="clickAbout" runat="server" CausesValidation="false">About</asp:LinkButton>
        </li>
        <li class="nav-item" id="btnContact" runat="server">
            <asp:LinkButton class="nav-link" OnClick="clickContact" runat="server" CausesValidation="false">Contact</asp:LinkButton>
        </li>
    </ul>

    <asp:Label ID="lableUserGreeting" runat="server" Style="font-family: cursive; font-size: 0.9rem; margin-right: 15px"></asp:Label>
    <asp:LinkButton runat="server" ID="btnLogin" CssClass="btn btn-secondary my-2 my-sm-0" OnClick="btnLogin_click"
        CausesValidation="false" Style="font-family: cursive;">
        <i id="iconLogin" class="fa fa-sign-in" runat="server" aria-hidden="true"></i>
        Login
    </asp:LinkButton>


</div>