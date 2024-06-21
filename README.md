# MusicApp
This is group project 27 Music App for CS338
We will be using **html + javascript** for our front end and **nodejs** for our backend
and we will also be using **PostgreSQL** running at local as our DBMS 

### First Step: Install nodejs
Head to the [Node.js](https://nodejs.org/en) and Click the Long Term Support version

<img src="./assets/nodejs/1.png" width="500" height="400">

Run the installer and Follow the prompts in the installer 

<img src="./assets/nodejs/2.png" width="500" height="400">

To confirm that **Node** has been installed successfully on your computer by opening your terminal and typing in the commands 
> [!IMPORTANT]
> node --version
### Second Step: Install PostgreSQL
**Windows Users**: Download the Postgres Installer here:

    https://sbp.enterprisedb.com/getfile.jsp?fileid=1258649

**Mac Users**: Download the Postgres Installer here:

    https://sbp.enterprisedb.com/getfile.jsp?fileid=1258653

 Click Next to continue through the installer, until you reach this pane and make sure that everything is selected especially **pgAdmin**.

<img src="./assets/postgresql/1.png" width="500" height="400">

 Continue clicking Next until you reach this screen. Your superuser username is postgres and you need to set a password. It is recommand to use "admin" which is assmued to be the default password for later pool connection. 
 > [!IMPORTANT]
> Make sure you write this **password** down. We will need this later to access our database. By default, we will use "admin".

<img src="./assets/postgresql/2.png" width="500" height="400">

Continue through the installer, leave everything as the default and just keep clicking **Next**. Once installation completes then you're done!

### Third Step: Create first table in PostgreSQL
Open **pgAdmin** which provides a graphical administration tool to make it easier to manipulate schema and data in PostgreSQL.

<img src="./assets/postgresql/3.png" width="700" height="400">

Navigate to our server and double click PostgreSQL 15. It will ask you for **password** we enter previously. By default, you should have "admin" as your password.

<img src="./assets/postgresql/4.png" width="600" height="200">

You should be able to see your database server and our server comes with a database named "postgres", this is the database we will be using.

<img src="./assets/postgresql/5.png" width="700" height="400">

Head to the **Schemas** --> **public** --> **Tables** and right click to select **Query Tool**. We are going to create our first users table in our database.

<img src="./assets/postgresql/6.png" width="700" height="400">

Type the following command (you can find the SQL query for users table in tables.sql) in order to create our first table. Press the **Execute/Refresh(F5)** and you should see the Messages box display query returned successfully.

<img src="./assets/postgresql/7.png" width="700" height="400">

You can view your tables by refreshing your table and navigating users table through **View/Edit Data** --> **All Rows**

<img src="./assets/postgresql/8.png" width="700" height="400">

And you should be able to see the our users table and attribute being displayed.

<img src="./assets/postgresql/9.png" width="700" height="400">


### Last Step: Run our application in Local environment

First you need to download our application to your local machine and unzip the file.

> [!IMPORTANT]
> if you have git installed, you can also run following command
> - git clone https://github.com/bigjackCN/MusicApp.git

<img src="./assets/application/1.png" width="450" height="300">

Now you should see the basic file structure of our application. It is important you have MusicApp as your current working directory.

<img src="./assets/application/2.png" width="450" height="300">

Before you start run your application, there is one last step to do.
Open the index.js file in any text editor, and at the very beginning of the file, you should find the line with **const pool**. Make sure the password matches the one you type in during the install of the postgreSQL. Once again, the default value is "admin".

<img src="./assets/application/3.png" width="500" height="300">

Now get back to your terminal, and double check your current working directory is MusicApp. Type "node index.js" and you should get the message of "Server running on port 3000".

<img src="./assets/application/4.png" width="500" height="300">

> [!IMPORTANT]
> If you are not able to start the server, make sure you are doing correct for the previous steps!

Great, head to your browser and you should be able to display our App in **localhost:3000**.

<img src="./assets/application/5.png" width="700" height="400">

