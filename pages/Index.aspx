<%@ Page Title="" Language="C#" MasterPageFile="~/pages/MainTemplate.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="TastyRecipes.pages.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .inputTime {
            background-color: rgb(250, 250, 250);
            text-align: center;
            width: 70px;
            display: inline-block
        }
    </style>
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

        <p class="text-secondary lead" style="padding: 0rem 2rem;">
            <em>Our website includes recipes at all levels of difficulty and all the variety of ingredients.<br>
                Anyone can view the recipes on the website. You can also sign up and then share your own recipes.<br>
            </em>
        </p>
    </div>

    <div id="divContact" class="container" runat="server" visible="false" style="margin-top: 20px;">
        <div class="jumbotron" style="padding: 1rem 2rem; margin-bottom: 1rem;">
            <h2 class="font-weight-bold">
                <span>Contact us
                </span>
            </h2>
            <em class="text-secondary lead">For any technical support or enquiries, please email
                <a href="mailto:tastyRecipes@gmail.com">tastyRecipes@gmail.com</a></em>
        </div>

        <p class="text-secondary lead" style="padding: 0rem 2rem;">
            <em>ORT Braude College of Engineering.<br>
                Software Departmant.<br>
                51 Snunit st. Carmiel.<br>
            </em>
        </p>
    </div>


    <div id="divHome" class="container" runat="server" style="margin-top: 20px;">
        <div class="jumbotron" style="padding: 0.5rem 1rem; margin-bottom: 1rem;">
            <div style="cursor: pointer;" data-toggle="collapse" data-target="#divFilter">
                <i class='fas fa-angle-double-down' runat="server" aria-hidden="true" style='font-size: 20px'></i>
                <p class="text-secondary lead" style="padding: 0rem 0.6rem; margin-bottom: 0; display: inline-block; font-size: 1.2rem;">
                    <em>Filter</em>
                </p>
            </div>

            <div id="divFilter" class="collapse" style="padding-top: 1rem">
                <div class="row" style="margin-bottom: 40px; margin-top: 10px">
                    <div class="col-sm-2">
                        <label class="font-weight-bold" style="font-size: 1rem">Meal type</label>
                    </div>
                    <div class="col-sm-2">
                        <asp:ListBox ID="listType" CssClass="selectpicker" SelectionMode="Multiple" runat="server" data-live-search="true">
                            <asp:ListItem Value="option1">Breakfast</asp:ListItem>
                            <asp:ListItem Value="option2">Dinners</asp:ListItem>
                            <asp:ListItem Value="option3">Lunch</asp:ListItem>
                            <asp:ListItem Value="option4">Desserts</asp:ListItem>
                        </asp:ListBox>
                    </div>

                </div>

                <div class="row" style="margin-bottom: 40px;">
                    <div class="col-sm-2">
                        <label class="font-weight-bold" style="font-size: 1rem">Category</label>
                    </div>
                    <div class="col-sm-2">
                        <asp:ListBox ID="listCategory" CssClass="selectpicker" SelectionMode="Multiple" runat="server" data-live-search="true">
                            <asp:ListItem Value="option1">Snacks</asp:ListItem>
                            <asp:ListItem Value="option2">Appetisers</asp:ListItem>
                            <asp:ListItem Value="option3">Soups</asp:ListItem>
                            <asp:ListItem Value="option4">Salads</asp:ListItem>
                            <asp:ListItem Value="option5">Sides</asp:ListItem>
                            <asp:ListItem Value="option6">Pizza</asp:ListItem>
                            <asp:ListItem Value="option7">Pies</asp:ListItem>
                            <asp:ListItem Value="option8">Burgers</asp:ListItem>
                            <asp:ListItem Value="option9">Pasta</asp:ListItem>
                            <asp:ListItem Value="option10">Chicken</asp:ListItem>
                            <asp:ListItem Value="option11">Seafood</asp:ListItem>
                            <asp:ListItem Value="option12">Meat</asp:ListItem>
                            <asp:ListItem Value="option13">Vegetarian</asp:ListItem>
                            <asp:ListItem Value="option14">Baking</asp:ListItem>
                            <asp:ListItem Value="option15">Desserts</asp:ListItem>
                        </asp:ListBox>
                    </div>

                </div>

                <div class="row" style="margin-bottom: 40px">
                    <div class="col-sm-2">
                        <label class="font-weight-bold" style="font-size: 1rem">Difficulty</label>
                    </div>
                    <div class="col-sm-2">
                        <asp:ListBox ID="listDifficulty" CssClass="selectpicker" SelectionMode="Multiple" runat="server" data-live-search="true">
                            <asp:ListItem Value="option1">Easy</asp:ListItem>
                            <asp:ListItem Value="option2">Medium</asp:ListItem>
                            <asp:ListItem Value="option3">Hard</asp:ListItem>
                        </asp:ListBox>
                    </div>
                </div>

                <div class="row" style="margin-bottom: 20px">
                    <div class="col-sm-2">
                        <label class="font-weight-bold" style="font-size: 1rem; margin-bottom: 0">Maximum time</label>
                        <br />
                        <label>(For any time insert: 0)</label>
                    </div>
                    <div class="col-sm-2">
                        <asp:TextBox ID="inputTime" runat="server" CssClass="form-control inputTime" type="number" value="0" min="0" max="400" step="5"></asp:TextBox>
                        <label style="margin-bottom: 0;">(minutes)</label>
                        <asp:rangevalidator ID="RangevalidatorForTime" errormessage="Please enter value between 0-400." forecolor="Red" controltovalidate="inputTime"
                            minimumvalue="0" maximumvalue="400" runat="server" Type="Integer" Display="Dynamic">
                        </asp:rangevalidator>
                    </div>
                </div>

                <div class="row" style="margin-bottom: 10px">
                    <div class="col-sm-4" style="text-align: center; margin-bottom: 10px">
                        <asp:LinkButton runat="server" ID="btnSearch" CssClass="btn btn-secondary my-2 my-sm-0" OnClick="btnSearch_click" Style="font-family: cursive;">
                            <i class="fa fa-search" aria-hidden="true"></i>
                         Search
                        </asp:LinkButton>
                    </div>
                </div>

                <div class="row" style="margin-bottom: 10px">
                    <div class="col-sm-2">
                        <asp:LinkButton runat="server" ID="LinkBtnMyPosts" Text="Show my posts" OnClick="myPosts_click" CausesValidation="false" Style="font-size: 1rem"></asp:LinkButton>
                    </div>
                </div>

            </div>

        </div>
    </div>





    <script>
        // Material Select Initialization
        $(document).ready(function () {
            $('select').selectpicker();
        });
    </script>

</asp:Content>
