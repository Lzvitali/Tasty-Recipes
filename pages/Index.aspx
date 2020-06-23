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

    <script>

        // Material Select Initialization
        $(document).ready(function () {
            $('select').selectpicker();
        });


        var app = angular.module('app', [])
            .controller('recipesCtrl', function ($scope, $http) {

                angular.element(document).ready(function () {
                    $scope.getRecipes();
                });

                $scope.getRecipes = function () {
                    $http.get("../DBConnection/webservice.asmx/GetRecipes", null)
                        .then(function (d) {
                            // success
                            $scope.recipesData = $scope.getResponceXML(d)
                            console.log($scope.recipesData);
                        }, function (er) {
                            // error
                            console.log(er);
                        });
                }


                // data from service xml -> json
                $scope.getResponceXML = function (d) {
                    var xmlDoc = $.parseXML(d.data);
                    if (xmlDoc == null) { // json format
                        return JSON.parse(d.data.d);
                    } else { // xml format
                        return JSON.parse(xmlDoc.documentElement.textContent);
                    }
                }

            });

    </script>
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


    <div id="divHome" class="container" runat="server" style="margin-top: 20px;" ng-app="app" ng-controller="recipesCtrl">
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
                            <asp:ListItem Value="option5">Suitable for all</asp:ListItem>
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
                            <asp:ListItem Value="option15">Others</asp:ListItem>
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
                        <asp:RangeValidator ID="RangevalidatorForTime" ErrorMessage="Please enter value between 0-400." ForeColor="Red" ControlToValidate="inputTime"
                            MinimumValue="0" MaximumValue="400" runat="server" Type="Integer" Display="Dynamic">
                        </asp:RangeValidator>
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

        <!-- ----------------------------------- Recipes content ----------------------------------- -->
        <div data-ng-repeat="recipe in recipesData">

            <div id="divRowRecipe" class="media border-bottom p-3" data-toggle="modal" data-target="#myModal{{$index}}">
                <img data-ng-src="{{recipe.RecipeImagePath}}" alt="{{recipe.RecipeName}}" class="mr-3 mt-3" style="width: 80px;">
                <div class="media-body">
                    <h4 data-ng-bind="recipe.RecipeName"></h4>
                    <p class="pLarger" data-ng-bind="recipe.RecipeDescription"></p>
                    <div class="row" style="margin-left: 1rem;">
                        <div>
                            <i class="fa fa-clock-o" aria-hidden="true" style="font-size: 24px; color: darkcyan"></i>

                        </div>
                        <div style="margin-left: 0.4rem; margin-top: 0.1rem">
                            <span class="pLarger" data-ng-bind="recipe.RecipeTime"></span>
                            <span class="pLarger">mins</span>
                        </div>

                        <div style="margin-left: 2rem;">
                            <i class="fa fa-line-chart" aria-hidden="true" style="font-size: 24px; color: darkcyan"></i>
                            <%--<i class="fa fa-hand-rock-o" aria-hidden="true" style="font-size: 24px; color: darkcyan"></i>--%>
                            <%--<i class="fa fa-tags" aria-hidden="true" style="font-size: 24px; color: darkcyan"></i>--%>
                        </div>
                        <div style="margin-left: 0.4rem; margin-top: 0.1rem">
                            <span class="pLarger" data-ng-bind="recipe.RecipeDifficulty"></span>
                        </div>
                    </div>
                </div>

            </div>

            <!-- The Modal -->
            <div class="modal" id="myModal{{$index}}">
                <div class="modal-dialog modal-dialog-scrollable">
                    <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h1 class="modal-title" data-ng-bind="recipe.RecipeName"></h1>
                            <button type="button" class="close" data-dismiss="modal">×</button>
                        </div>

                        <!-- Modal body -->
                        <div class="modal-body">
                            <h3>Some text to enable scrolling..</h3>
                            <p>Some text to enable scrolling.. Lorem ipsum dolor sit amet, consectetur adipiscing elit/</p>
                        </div>

                        <!-- Modal footer -->
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </div>



</asp:Content>
