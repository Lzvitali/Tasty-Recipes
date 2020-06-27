alter database TastyRecipes set single_user with rollback immediate;
go
drop database if exists TastyRecipes

create database TastyRecipes
use TastyRecipes

create table tbUser
(
    UserName nvarchar(50),
    UserEmail nvarchar(50) primary key,
    UserPassword nvarchar(50),
)


create table tbRecipe
(
	id int not null identity(1,1) primary key,
    RecipeName nvarchar(50) not null,
	RecipeDescription nvarchar(300) not null,
	RecipeMealType nvarchar(50) not null,
	RecipeCategory nvarchar(50) not null,
	RecipeIngredients nvarchar(MAX) not null,
	RecipeTime int not null,
	RecipeDifficulty nvarchar(50) not null,
	RecipeInstructions nvarchar(MAX) not null,
	RecipeImg varbinary(max) not null,
	UserName nvarchar(50) not null,
    UserEmail nvarchar(50) not null foreign key references tbUser(UserEmail),
)




-- Examples for initial data insert --

insert into tbUser values('Natasha', 'kameneva0894@gmail.com', '12345')
insert into tbUser values('Vitali', 'lzvitali68@gmail.com', '12345')


--https://www.allrecipes.com/recipe/14172/caesar-salad-supreme/
insert into tbRecipe values('Caesar', 'A Caesar salad is a green salad of romaine lettuce and croutons dressed with lemon juice, olive oil, egg, Worcestershire sauce, anchovies, garlic, Dijon mustard, Parmesan cheese, and black pepper. In its original form, this salad was prepared and served tableside.',
'Suitable for all', 'Salads', '6 cloves garlic, peeled, divided, 3/4 cup mayonnaise, 5 anchovy fillets, minced, 6 tablespoons grated Parmesan cheese, divided 1 teaspoon Worcestershire sauce, 1 teaspoon Dijon mustard, 1 tablespoon lemon juice, or more to taste, salt to taste, ground black pepper to taste, 1/4 cup olive oil, 4 cups day-old bread, cubed, 1 head romaine lettuce, torn into bite-size pieces.', 
20, 'Easy', 'Step 1: Mince 3 cloves of garlic, and combine in a small bowl with mayonnaise, anchovies, 2 tablespoons of the Parmesan cheese, Worcestershire sauce, mustard, and lemon juice. Season to taste with salt and black pepper. Refrigerate until ready to use. 
Step 2: Heat oil in a large skillet over medium heat. Cut the remaining 3 cloves of garlic into quarters, and add to hot oil. Cook and stir until brown, and then remove garlic from pan. Add bread cubes to the hot oil. Cook, turning frequently, until lightly browned. Remove bread cubes from oil, and season with salt and pepper. 
Step 3: Place lettuce in a large bowl. Toss with dressing, remaining Parmesan cheese, and seasoned bread cubes.',
(SELECT * FROM OPENROWSET(BULK N'C:\Users\Vitali\Desktop\test\Caesar-Salad.jpg', SINGLE_BLOB) as T1), 'Natasha', 'kameneva0894@gmail.com')

--https://downshiftology.com/recipes/shakshuka/
insert into tbRecipe values('Shakshouka', 'Shakshouka is a dish of eggs poached in a sauce of tomatoes, olive oil, peppers, onion and garlic, and commonly spiced with cumin, paprika, cayenne pepper and nutmeg. The dish has existed in Mediterranean cultures for centuries.',
'Breakfast', 'Others', '1 medium onion, diced, 1 red bell pepper, seeded and diced, 4 garlic cloves, finely chopped, 2 tsp paprika, 1 tsp cumin, 1/4 tsp chili powder, 1 28-ounce can whole peeled tomatoes, 6 large eggs, salt and pepper, to taste, 1 small bunch fresh cilantro, chopped,1 small bunch fresh parsley, chopped.', 
30, 'Medium', 'Step 1: Heat olive oil in a large saut� pan on medium heat. Add the chopped bell pepper and onion and cook for 5 minutes or until the onion becomes translucent. 
Step 2: Add garlic and spices and cook an additional minute.
Step 3: Pour the can of tomatoes and juice into the pan and break down the tomatoes using a large spoon. Season with salt and pepper and bring the sauce to a simmer. 
Step 4: Use your large spoon to make small wells in the sauce and crack the eggs into each well. Cover the pan and cook for 5-8 minutes, or until the eggs are done to your liking. 
Step 5: Garnish with chopped cilantro and parsley.', (SELECT * FROM OPENROWSET(BULK N'C:\Users\Vitali\Desktop\test\Shakshuka.jpg', SINGLE_BLOB) as T1), 'Vitali', 'lzvitali68@gmail.com')

--DELETE FROM tbRecipe WHERE id=1


select *from tbRecipe

