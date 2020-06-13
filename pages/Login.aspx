<%@ Page Title="" Language="C#" MasterPageFile="~/pages/MainTemplate.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TastyRecipes.pages.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Panel runat="server" ID="pnlLogin">
        <div class="modal-content" style="width: 400px; margin: 40px auto">
            <div class="modal-header">
                <h3 class="text-primary" style="font-weight: bold; margin-bottom: 0rem">Login</h3>
            </div>
            <div class="modal-body" style="padding: 20px;">
                <div class="form-group">
                    <label>Email address</label>
                    <asp:TextBox runat="server" ID="txtBoxMailLogin" CssClass="form-control ng-pristine ng-untouched ng-valid ng-empty"
                        placeholder="Enter email"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBoxMailLogin" ErrorMessage="Required field" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtBoxMailLogin" ForeColor="Red"
                        ErrorMessage="Invalid Email Format" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
                <div class="form-group mh-80">
                    <label for="exampleInputPassword1">Password</label>
                    <asp:TextBox runat="server" ID="txtBoxPasswordLogin" CssClass="form-control ng-pristine ng-untouched ng-valid ng-empty" TextMode="Password"
                        placeholder="Enter password"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBoxPasswordLogin" ErrorMessage="Required field" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <div>
                    <asp:Label runat="server" ID="lblError" ForeColor="Red"></asp:Label>
                </div>
            </div>
            <div class="modal-footer">
                <div style="width: 100%">
                    <div style="float: left; padding-top: 20px">
                        <!-- to disable RequiredFieldValidator: https://www.codeproject.com/Questions/808750/How-Do-I-Set-Required-Field-Validator-Only-For-One -->
                        <asp:LinkButton runat="server" ID="linkBtnRegister" Text="new user registration" OnClick="register_click" CausesValidation="false" Style="font-size: 1rem"></asp:LinkButton>
                        <%-- <button type="button" runat="server" id="register" onServerClick="register_Click">new user registration</button>--%>
                    </div>
                    <div style="float: right">
                        <asp:Button runat="server" ID="btnLogin" Text="Submit" OnClick="login_click" CssClass="btn btn-primary" />
                    </div>
                    <div style="clear: both"></div>
                </div>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel runat="server" ID="pnlRegistration">
        <div class="modal-content" style="width: 400px; margin: 40px auto">
            <div class="modal-header">
                <h3 class="text-primary" style="font-weight: bold; margin-bottom: 0rem">Registration</h3>
            </div>

            <div class="modal-body" style="padding: 20px;">
                <div class="form-group">
                    <label>User name</label>
                    <asp:TextBox runat="server" ID="txtBoxUserNameRegister" CssClass="form-control ng-pristine ng-untouched ng-valid ng-empty"
                        placeholder="Enter your user name"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBoxUserNameRegister" ErrorMessage="Required field" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <label>Email address</label>
                    <asp:TextBox runat="server" ID="txtBoxMailRegister" CssClass="form-control ng-pristine ng-untouched ng-valid ng-empty"
                        placeholder="Enter email"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBoxMailRegister" ErrorMessage="Required field" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ForeColor="Red" ControlToValidate="txtBoxMailRegister"
                        ErrorMessage="Invalid Email Format" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">Password</label>
                    <asp:TextBox runat="server" ID="txtBoxPasswordRegister" CssClass="form-control ng-pristine ng-untouched ng-valid ng-empty" TextMode="Password"
                        placeholder="Enter password"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBoxPasswordRegister" ErrorMessage="Required field" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div>
                    <asp:Label runat="server" ID="Label1" ForeColor="Red"></asp:Label>
                </div>
            </div>

            <div class="modal-footer">
                <div style="width: 100%">
                    <div style="float: left; padding-top: 20px">
                        <!-- to disable RequiredFieldValidator: https://www.codeproject.com/Questions/808750/How-Do-I-Set-Required-Field-Validator-Only-For-One -->
                        <asp:LinkButton runat="server" ID="LinkButton1" Text="login for existing user" OnClick="loginLink_click" CausesValidation="false" Style="font-size: 1rem"></asp:LinkButton>
                        <%-- <button type="button" runat="server" id="register" onServerClick="register_Click">new user registration</button>--%>
                    </div>
                    <div style="float: right">
                        <asp:Button runat="server" ID="btnRegister" Text="Register" OnClick="submit_registration_click" CssClass="btn btn-primary" />
                    </div>
                    <div style="clear: both"></div>
                </div>
            </div>

        </div>
    </asp:Panel>
</asp:Content>

