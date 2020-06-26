using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace TastyRecipes.DBConnection
{
    /// <summary>
    /// Summary description for WebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class WebService : System.Web.Services.WebService
    {

        [WebMethod(EnableSession = true)]
        public string GetRecipes()
        {
            using (var db = new DBConnection.TastyRecipesEntities())
            {
                var recipes = db.tbRecipes.ToList();

                // used this reference: http://www.siddharthpandey.net/solve-self-referencing-loop-issue-when-using-newtonsoft-json/
                // there was an error: Newtonsoft.Json.JsonSerializationException: 'Self referencing loop detected with type...
                return JsonConvert.SerializeObject(recipes, new JsonSerializerSettings()
                {
                    PreserveReferencesHandling = PreserveReferencesHandling.Objects,
                    Formatting = Formatting.Indented
                });

            }
        }


        [WebMethod(EnableSession = true)]
        public int SaveRecipe()
        {
            using (var stream = new MemoryStream())
            {
                var request = HttpContext.Current.Request;
                request.InputStream.Seek(0, SeekOrigin.Begin);
                request.InputStream.CopyTo(stream);
                var dataStr = Encoding.UTF8.GetString(stream.ToArray());
                var data = (dynamic)JsonConvert.DeserializeObject(dataStr);
                using (var db = new DBConnection.TastyRecipesEntities())
                {
                    var d = data.data;
                    int id = Convert.ToInt32(d["id"]);
                    var recipe = id == 0 ? new tbRecipe() : db.tbRecipes.Where(i => i.id == id).FirstOrDefault();
                    recipe.RecipeName = Convert.ToString(d["RecipeName"]);
                    recipe.RecipeDescription = Convert.ToString(d["RecipeDescription"]);
                    recipe.RecipeMealType = Convert.ToString(d["RecipeMealType"]);
                    recipe.RecipeCategory = Convert.ToString(d["RecipeCategory"]);
                    recipe.RecipeIngredients = Convert.ToString(d["RecipeIngredients"]);
                    recipe.RecipeTime = Convert.ToInt32(d["RecipeTime"]);
                    recipe.RecipeDifficulty = Convert.ToString(d["RecipeDifficulty"]);
                    recipe.RecipeInstructions = Convert.ToString(d["RecipeInstructions"]);
                    recipe.RecipeImg = (byte[])(d["RecipeImg"]);
                    recipe.UserName = Convert.ToString(d["UserName"]);
                    recipe.UserEmail = Convert.ToString(d["UserEmail"]);

                    if (id == 0) db.tbRecipes.Add(recipe);
                    db.SaveChanges();

                    return recipe.id;
                }
            }

        }
    }
}
