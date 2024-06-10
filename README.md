# MusicApp
This is group project 27 Music App for CS338
We will be using **html + javascript** for our front end and **nodejs** for our backend
and we will also be using **PostgreSQL** running at local as our DBMS 

### First Step: Install nodejs
Head to the [Node.js](https://nodejs.org/en) and Click the Long Term Support version

![Image of this step](/assets/nodejs/1.png)

Run the installer and Follow the prompts in the installer 

![Image of this step](/assets/nodejs/2.png)

To confirm that **Node** has been installed successfully on your computer by opening your terminal and typing in the commands 
> [!IMPORTANT]
> node --version
### Second Step: Install PostgreSQL
**Windows Users**: Download the Postgres Installer here:

    https://sbp.enterprisedb.com/getfile.jsp?fileid=1258649

**Mac Users**: Download the Postgres Installer here:

    https://sbp.enterprisedb.com/getfile.jsp?fileid=1258653

 Click Next to continue through the installer, until you reach this pane and make sure that everything is selected especially **pgAdmin**.

 ![Image of this step](/assets/postgresql/1.png)

 Continue clicking Next until you reach this screen. Your superuser username is postgres and you need to set a password. It is recommand to use "admin" which is assmued to be the default password for later pool connection. 
 > [!IMPORTANT]
> Make sure you write this **password** down. We will need this later to access our database. By default, we will use "admin".

![Image of this step](/assets/postgresql/2.png)

Continue through the installer, leave everything as the default and just keep clicking **Next**. Once installation completes then you're done!

### Third Step: Create first table in PostgreSQL
Open **pgAdmin** which provides a graphical administration tool to make it easier to manipulate schema and data in PostgreSQL.
![Image of this step](/assets/postgresql/3.png)
Navigate to our server and double click PostgreSQL 15. It will ask you for **password** we enter previously. By default, you should have "admin" as your password.
![Image of this step](/assets/postgresql/4.png)
You should be able to see your database server and our server comes with a database named "postgres", this is the database we will be using.
![Image of this step](/assets/postgresql/5.png)
Head to the **Schemas** --> **public** --> **Tables** and right click to select **Query Tool**. We are going to create our first users table in our database.
![Image of this step](/assets/postgresql/6.png)
Type the following command in order to create our first table. Press the **Execute/Refresh(F5)** and you should see the Messages box display query returned successfully.
![Image of this step](/assets/postgresql/7.png)
You can view your tables by refreshing your table and navigating users table through **View/Edit Data** --> **All Rows**
![Image of this step](/assets/postgresql/8.png)
And you should be able to see the our users table and attribute being displayed.
![Image of this step](/assets/postgresql/9.png)
