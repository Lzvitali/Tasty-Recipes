 # Tasty Recipes
This project is a first experience in ASP.NET.  
It implements both frontend and backend, using SQL server, AngularJS, [Bootstrap](https://bootswatch.com/) etc.  
This is an ASP.NET Web application(C#) developed in Visual Studio and it statrs as "Empty" project (not as MVC/Web Forms/Web API...).  
The project includes a master page and few Web Form (.aspx) files, Web Forms User Control (.ascx) file, ADO.NET Entity Data Model (.edmx) file and Web Service (.asmx) file.

## Description
It is a food recipes web application where anyone can view all the recipes data.  
User that wish to add his own recipe to the web, must sign in to the system (make a registration). Once the user is loged-in he can edit or delete only his posts.

## Database
The query we used to initialize the database (Microsoft SQL Server) is [this](https://github.com/Lzvitali/Tasty-Recipes/blob/master/SQLInitQuery.sql/).  
There is a One-to-many relationship between the Recipe table and the User table. The user can have many recipes and each recipe belongs to one user.  
<img src="https://github.com/Lzvitali/Tasty-Recipes/blob/master/screenshots/Database%20diagram.PNG" alt="Database" width="420"/>



## Screenshots
### _<p align="center"> Home screen </p>_
<kbd><img src="https://github.com/Lzvitali/Tasty-Recipes/blob/master/screenshots/Home%20screen.PNG" alt="Home screen"/></kbd>

### _<p align="center"> Home screen - recipe info </p>_
<kbd><img src="https://github.com/Lzvitali/Tasty-Recipes/blob/master/screenshots/Recipe%20info.PNG" alt="Home screen - recipe info"/></kbd>  

### _<p align="center"> Registration and Login </p>_
<table><tr>
 <td>
<img src="https://github.com/Lzvitali/Tasty-Recipes/blob/master/screenshots/Registretion%20screen%20-%20croped.png"/>
</td>
 <td>
<img src="https://github.com/Lzvitali/Tasty-Recipes/blob/master/screenshots/Login%20screen%20-%20croped.PNG"/>
</td>
</tr></table>

### _<p align="center"> Home screen - for registerd user </p>_
<kbd><img src="https://github.com/Lzvitali/Tasty-Recipes/blob/master/screenshots/Home%20screen%20--%20for%20registered%20user.PNG" alt="Home screen - for registerd user"/></kbd>  
### _<p align="center"> Edit option - for registerd user </p>_
<kbd><img src="https://github.com/Lzvitali/Tasty-Recipes/blob/master/screenshots/Edit%20option.PNG" alt="Edit option - for registerd user"/></kbd>  


