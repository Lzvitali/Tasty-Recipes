//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TastyRecipes.DBConnection
{
    using System;
    using System.Collections.Generic;
    
    public partial class tbRecipe
    {
        public int id { get; set; }
        public string RecipeName { get; set; }
        public string RecipeDescription { get; set; }
        public string RecipeMealType { get; set; }
        public string RecipeCategory { get; set; }
        public string RecipeIngredients { get; set; }
        public int RecipeTime { get; set; }
        public string RecipeDifficulty { get; set; }
        public string RecipeInstructions { get; set; }
        public byte[] RecipeImg { get; set; }
        public string UserName { get; set; }
        public string UserEmail { get; set; }
    
        public virtual tbUser tbUser { get; set; }
    }
}
