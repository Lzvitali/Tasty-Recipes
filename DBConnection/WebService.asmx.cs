using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
    }
}
