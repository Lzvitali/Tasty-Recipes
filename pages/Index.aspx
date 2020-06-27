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



        var app = angular.module('app', []);

        // this script will not upload anything. 
        // It will only populate your model with the contents of your file encoded ad a data - uri(base64).
        // reference credit: https://stackoverflow.com/questions/17063000/ng-model-for-input-type-file-with-directive-demo
        app.directive('appFilereader', function ($q) {
            var slice = Array.prototype.slice;
            return {
                restrict: 'A',
                require: '?ngModel',
                link: function (scope, element, attrs, ngModel) {
                    if (!ngModel) return;

                    ngModel.$render = function () { };

                    element.bind('change', function (e) {
                        var element = e.target;

                        $q.all(slice.call(element.files, 0).map(readFile))
                            .then(function (values) {
                                if (element.multiple) ngModel.$setViewValue(values);
                                else ngModel.$setViewValue(values.length ? values[0] : null);
                            });

                        function readFile(file) {
                            var deferred = $q.defer();

                            var reader = new FileReader();
                            reader.onload = function (e) {
                                deferred.resolve(e.target.result);
                            };
                            reader.onerror = function (e) {
                                deferred.reject(e);
                            };
                            reader.readAsDataURL(file);

                            return deferred.promise;
                        }

                    }); //change

                } //link
            }; //return
        });


        app.controller('recipesCtrl', function ($scope, $http) {

            $scope.currentUser = "<%=Session["UserEmail"]%>";

            angular.element(document).ready(function () {
                $scope.getRecipes();
            });

            $scope.addImgPref = function () {
                $scope.newRecipe.RecipeImg = "data:image/JPEG;image/png;base64," + $scope.newRecipe.RecipeImg;
            }

            $scope.getImgSrc = function () {
                if ('d' == $scope.newRecipe.RecipeImg[0]) {
                    var subStr = $scope.newRecipe.RecipeImg.substr(0, 33);
                    if ("data:image/JPEG;image/png;base64," == subStr) {
                        $scope.newRecipe.RecipeImg = $scope.newRecipe.RecipeImg.substr(33, $scope.newRecipe.RecipeImg.length);
                    }
                    else if ('J' == $scope.newRecipe.RecipeImg[11] || 'j' == $scope.newRecipe.RecipeImg[11]) {
                        $scope.newRecipe.RecipeImg = $scope.newRecipe.RecipeImg.substr(23, $scope.newRecipe.RecipeImg.length);
                    }
                    else if ('P' == $scope.newRecipe.RecipeImg[11] || 'p' == $scope.newRecipe.RecipeImg[11]) {
                        $scope.newRecipe.RecipeImg = $scope.newRecipe.RecipeImg.substr(22, $scope.newRecipe.RecipeImg.length);
                    }
                }
            }

            //var config = { responseType: 'blob' };

            $scope.getRecipes = function () {
                $http.get("../DBConnection/webservice.asmx/GetRecipes", null)
                    .then(function (d) {
                        // success
                        console.log(d);
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


            $scope.initNewRecipe = function (recipe) {
                if (arguments.length == 0) {
                    $scope.newRecipe = {
                        id: 0,
                        RecipeName: "",
                        RecipeDescription: "",
                        RecipeMealType: "",
                        RecipeCategory: "",
                        RecipeIngredients: "",
                        RecipeTime: "",
                        RecipeDifficulty: "",
                        RecipeInstructions: "",
                        RecipeImg: "",
                        UserName: "<%=Session["UserName"]%>",
                        UserEmail: "<%=Session["UserEmail"]%>"
                    }
                }
                else {
                    $scope.newRecipe = angular.copy(recipe);
                    $scope.addImgPref();
                    $scope.insertDataMealType();
                }

                $("#modalAdd").modal("show");
            }


            $scope.checkValidation = function () {
                $scope.newRecipe.RecipeMealType = $scope.dataMealType.label;
                $scope.newRecipe.RecipeCategory = $scope.dataCategory.label;
                $scope.newRecipe.RecipeDifficulty = $scope.dataDifficulty.label;
                if ($scope.newRecipe.RecipeName == "" || $scope.newRecipe.RecipeDescription == ""
                    || $scope.newRecipe.RecipeMealType == "" || $scope.newRecipe.RecipeCategory == ""
                    || $scope.newRecipe.RecipeIngredients == "" || $scope.newRecipe.RecipeTime == ""
                    || $scope.newRecipe.RecipeDifficulty == "" || $scope.newRecipe.RecipeInstructions == ""
                    || $scope.newRecipe.RecipeImg == "") {
                    return;
                }
                else {
                    $scope.getImgSrc();
                    $scope.save();
                }

            }

            $scope.save = function () {
                var recipe = angular.copy($scope.newRecipe);
                var isNew = $scope.newRecipe.id == 0;
                var url = $scope.service + "SaveRecipe";
                var data = { data: recipe };
                $http.post("../DBConnection/webservice.asmx/SaveRecipe", data, null).then(
                    function (d) { // success
                        if (isNew) {
                            recipe.id = d.data.d;
                            $scope.recipesData.push(recipe);
                        } else {
                            $scope.recipesData.map((x, i) => {
                                if (x.id == d.data.d) {
                                    $scope.recipesData[i] = recipe;
                                }
                            });
                        }
                        $scope.safeApply();
                        $("#modalAdd").modal("hide");
                    },
                    function (e) { // error
                        console.log(e);
                    }
                )

            }


            $scope.unitsMealType = [
                { 'id': 'Breakfast'         , 'label': 'Breakfast' },
                { 'id': 'Dinners'           , 'label': 'Dinners' },
                { 'id': 'Lunch'             , 'label': 'Lunch' },
                { 'id': 'Desserts'          , 'label': 'Desserts' },
                { 'id': 'Suitable for all'  , 'label': 'Suitable for all' },
            ]
            
            $scope.dataMealType = $scope.unitsMealType[4];

            $scope.insertDataMealType = function () {
                $scope.dataMealType.id = $scope.newRecipe.RecipeMealType;
                $scope.dataMealType.label = $scope.newRecipe.RecipeMealType;
            }

            $scope.unitsCategory = [
                { 'id': 'Snacks', 'label': 'Snacks' },
                { 'id': 'Appetisers', 'label': 'Appetisers' },
                { 'id': 'Soups', 'label': 'Soups' },
                { 'id': 'Salads', 'label': 'Salads' },
                { 'id': 'Sides', 'label': 'Sides' },
                { 'id': 'Pizza', 'label': 'Pizza' },
                { 'id': 'Pies', 'label': 'Pies' },
                { 'id': 'Burgers', 'label': 'Burgers' },
                { 'id': 'Pasta', 'label': 'Pasta' },
                { 'id': 'Chicken', 'label': 'Chicken' },
                { 'id': 'Seafood', 'label': 'Seafood' },
                { 'id': 'Meat', 'label': 'Meat' },
                { 'id': 'Vegetarian', 'label': 'Vegetarian' },
                { 'id': 'Baking', 'label': 'Baking' },
                { 'id': 'Desserts', 'label': 'Desserts' },
                { 'id': 'Others', 'label': 'Others' },
            ]

            $scope.dataCategory = $scope.unitsCategory[15];

            
            $scope.unitsDifficulty = [
                { 'id': 'Easy', 'label': 'Easy' },
                { 'id': 'Medium', 'label': 'Medium' },
                { 'id': 'Hard', 'label': 'Hard' },
            ]

            $scope.dataDifficulty = $scope.unitsDifficulty[0];
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
                            <asp:ListItem Value="option16">Others</asp:ListItem>
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

        <!-- ----------------------------------- Add button ----------------------------------- -->
        <div class="row" style="float: right; padding-right: 15px;" data-ng-show="currentUser != ''">
            <div>
                <button type="button" class="btn btn-outline-primary" data-ng-click="initNewRecipe()">
                    <i class="fa fa-plus" aria-hidden="true"></i>
                    Add
                </button>
            </div>
        </div>
        <div style="clear: both"></div>

        <!-- ---------------------- The Modal for adding new recipe ----------------------------- -->
        <div class="modal" id="modalAdd">
            <div class="modal-dialog modal-dialog-scrollable" style="max-width: 700px; margin: 4.5rem auto; max-height: calc(88%);">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                        <div class="form-group" style="margin: auto;">
                            <label class="col-form-label col-form-label-lg displayInlineBlock" for="inputLarge">Recipe name: </label>
                            <input class="form-control form-control-lg displayInlineBlock" type="text" placeholder="Enter recipe name"
                                id="inputRecipeName" style="margin-left: 5px; width: 300px" data-ng-model="newRecipe.RecipeName" required />
                        </div>
                        <button type="button" class="close" data-dismiss="modal" style="margin: -1rem -1rem">×</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">

                        <div class="row" style="margin-bottom: 10px">
                            <div class="col-md-5">

                                <!--reference for use of ng-src: https://makandracards.com/makandra/29415-resolving-angular-not-updating-an-image-src-when-ng-src-is-empty -->
                                <img ng-src="{{ newRecipe.RecipeImg || '//:0' }}" alt="image" style="width: 270px; min-height: 222px" />
                                

                                <div class="form-group" style="margin-top: 10px">
                                    <div class="input-group mb-3">
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="inputRecipeImage" accept="image/jpeg,image/png"
                                                data-ng-model="newRecipe.RecipeImg" data-app-filereader data-ng-required="0 == newRecipe.id">
                                            <label class="custom-file-label" for="inputGroupFile02">Choose file</label>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="form-group col-md-7">
                                <label class="col-form-label col-form-label-lg displayInlineBlock" for="inputLarge">Description: </label>
                                <textarea class="form-control" id="textareaDescription" rows="10" placeholder="Enter description" data-ng-model="newRecipe.RecipeDescription" required></textarea>
                            </div>
                        </div>

                        <div class="row" style="margin-bottom: 10px">
                            <div class="col-sm-12">
                                <div class="displayInlineBlock" style="margin-right: 1rem">
                                    <div class="form-group" style="width: 150px;">
                                        <h5 class="displayInlineBlock">Meal type: </h5>
                                        <select class="form-control" data-ng-model="dataMealType" data-ng-options="opt as opt.label for opt in unitsMealType "> </select>
                                    </div>
                                </div>

                                <div class="displayInlineBlock">
                                    <div class="form-group" style="width: 130px;">
                                        <h5 class="displayInlineBlock">Category: </h5>
                                        <select class="form-control" data-ng-model="dataCategory" data-ng-options="opt as opt.label for opt in unitsCategory "> </select>
                                    </div>
                                </div>

                                <div class="displayInlineBlock" style="margin-left: 2rem;">
                                    <i class="fa fa-clock-o" aria-hidden="true" style="font-size: 24px; color: darkcyan"></i>
                                </div>
                                <div class="displayInlineBlock" style="margin-left: 0.4rem; margin-top: 0.1rem;">
                                    <input class="form-control inputTime" type="number" min="0" max="400" step="5" id="inputRecipeTime" data-ng-model="newRecipe.RecipeTime" required />
                                    <label style="margin-bottom: 0;">(minutes)</label>
                                </div>

                                <div class="displayInlineBlock">
                                    <div class="form-group" style="width: 110px; margin-left: 2rem;">
                                        <h5 class="displayInlineBlock">Difficulty: </h5>
                                        <select class="form-control" data-ng-model="dataDifficulty" data-ng-options="opt as opt.label for opt in unitsDifficulty "> </select>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div style="margin-top: 1rem">
                            <h5 class="font-weight-bold">Ingredients: </h5>
                            <textarea class="form-control" id="textareaIngredients" rows="5" placeholder="Enter recipe ingredients" data-ng-model="newRecipe.RecipeIngredients" required></textarea>
                        </div>

                        <div style="margin-top: 1rem">
                            <h5 class="font-weight-bold">Instructions: </h5>
                            <textarea class="form-control" id="textareaInstructions" rows="10" placeholder="Enter recipe instructions" data-ng-model="newRecipe.RecipeInstructions" required></textarea>
                        </div>


                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Canel</button>
                        <button type="submit" class="btn btn-success" data-ng-click="checkValidation()">Save</button>
                    </div>

                </div>
            </div>
        </div>


        <!-- ----------------------------------- Recipes content ----------------------------------- -->
        <div data-ng-repeat="recipe in recipesData">

            <div id="divRowRecipe" class="media border-bottom p-3" data-toggle="modal" data-target="#myModal{{$index}}">
                <img data-ng-src="data:image/JPEG;image/png;base64,{{recipe.RecipeImg}}" alt="{{recipe.RecipeName}}" class="mr-3 mt-3" style="width: 80px;" />
                <div class="media-body">
                    <h4 data-ng-bind="recipe.RecipeName"></h4>
                    <p class="pLarger" data-ng-bind="recipe.RecipeDescription"></p>

                    <div class="row" style="margin-left: 1rem;">
                        <div class="col-sm-10">
                            <div class="displayInlineBlock">
                                <i class="fa fa-clock-o" aria-hidden="true" style="font-size: 24px; color: darkcyan"></i>
                            </div>
                            <div class="displayInlineBlock" style="margin-left: 0.4rem; margin-top: 0.1rem">
                                <span class="pLarger" data-ng-bind="recipe.RecipeTime"></span>
                                <span class="pLarger">mins</span>
                            </div>

                            <div class="displayInlineBlock" style="margin-left: 2rem;">
                                <i class="fa fa-line-chart" aria-hidden="true" style="font-size: 24px; color: darkcyan"></i>
                                <%--<i class="fa fa-hand-rock-o" aria-hidden="true" style="font-size: 24px; color: darkcyan"></i>--%>
                                <%--<i class="fa fa-tags" aria-hidden="true" style="font-size: 24px; color: darkcyan"></i>--%>
                            </div>
                            <div class="displayInlineBlock" style="margin-left: 0.4rem; margin-top: 0.1rem">
                                <span class="pLarger" data-ng-bind="recipe.RecipeDifficulty"></span>
                            </div>
                        </div>

                        <div class="col-sm-2" style="text-align: right" data-ng-show="currentUser == recipe.UserEmail">
                            <button type="button" class="btn btn-sm btn-outline-warning" data-ng-click="initNewRecipe(recipe); $event.stopPropagation()"
                                style="margin-right: 0.5rem; font-weight: bold;">
                                Edit</button>
                            <button type="button" class="btn btn-sm btn-outline-danger" style="font-weight: bold;" data-ng-click="$event.stopPropagation()">Delete</button>
                        </div>
                    </div>
                </div>

            </div>

            <!-- ------------------------------------ The Modal for viewing only ------------------------------------ -->
            <div class="modal" id="myModal{{$index}}">
                <div class="modal-dialog modal-dialog-scrollable" style="max-width: 700px; margin: 4.5rem auto; max-height: calc(88%);">
                    <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h1 class="modal-title" style="margin: auto" data-ng-bind="recipe.RecipeName"></h1>
                            <button type="button" class="close" data-dismiss="modal" style="margin: -1rem -1rem">×</button>
                        </div>

                        <!-- Modal body -->
                        <div class="modal-body">

                            <div class="row" style="margin-bottom: 10px">
                                <div class="col-md-5">
                                    <img ng-src="data:image/JPEG;image/png;base64,{{recipe.RecipeImg}}" alt="{{recipe.RecipeName}}" style="width: 270px;">
                                </div>
                                <div class="col-md-7">
                                    <h5 style="white-space: pre-line" data-ng-bind="recipe.RecipeDescription"></h5>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12" style="text-align: center;">
                                    <div class="displayInlineBlock">
                                        <h5 class="displayInlineBlock">Meal type: </h5>
                                        <span class="pLarger" data-ng-bind="recipe.RecipeMealType"></span>
                                    </div>

                                    <div class="displayInlineBlock" style="margin-left: 2rem;">
                                        <h5 class="displayInlineBlock">Category: </h5>
                                        <span class="pLarger" data-ng-bind="recipe.RecipeCategory"></span>
                                    </div>

                                    <div class="displayInlineBlock" style="margin-left: 2rem;">
                                        <i class="fa fa-clock-o" aria-hidden="true" style="font-size: 24px; color: darkcyan"></i>
                                    </div>
                                    <div class="displayInlineBlock" style="margin-left: 0.4rem; margin-top: 0.1rem;">
                                        <span class="pLarger" data-ng-bind="recipe.RecipeTime"></span>
                                        <span class="pLarger">mins</span>
                                    </div>

                                    <div class="displayInlineBlock" style="margin-left: 2rem;">
                                        <i class="fa fa-line-chart" aria-hidden="true" style="font-size: 24px; color: darkcyan"></i>
                                        <%--<i class="fa fa-hand-rock-o" aria-hidden="true" style="font-size: 24px; color: darkcyan"></i>--%>
                                        <%--<i class="fa fa-tags" aria-hidden="true" style="font-size: 24px; color: darkcyan"></i>--%>
                                    </div>
                                    <div class="displayInlineBlock" style="margin-left: 0.4rem; margin-top: 0.1rem;">
                                        <span class="pLarger" data-ng-bind="recipe.RecipeDifficulty"></span>
                                    </div>
                                </div>
                            </div>

                            <div style="margin-top: 1rem">
                                <h5 class="font-weight-bold">Ingredients: </h5>
                                <span class="pLarger" style="white-space: pre-line" data-ng-bind="recipe.RecipeIngredients"></span>
                            </div>

                            <div style="margin-top: 1rem">
                                <h5 class="font-weight-bold">Instructions: </h5>
                                <span class="pLarger" style="white-space: pre-line" data-ng-bind="recipe.RecipeInstructions"></span>
                            </div>

                            <div class="displayInlineBlock" style="margin-top: 1rem">
                                <h5 class="displayInlineBlock">Posted by: </h5>
                                <span class="pLarger" data-ng-bind="recipe.UserName"></span>
                            </div>

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
