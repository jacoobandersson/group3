________________________________________________________________________________________________________

Welcome to our Backend_UI_User_Manual_README.txt file which will guide you towards successfull test of our software. 
________________________________________________________________________________________________________

1. Make sure you have Python and MySQL workbench on your computer if not:
	- Please install MySQL workbench to run our mysql files.
	- Please install python 3.x.x to run our py files. 

Libraries that we will need to run main.py successfully:

Flask
#Library that allows us to build a web application
To install this: 
a. open command prompt
b. type: pip install Flask
NOTE: If it doesnt install properly, CMD probably needs to be started as an administrator.

Mysqldb
#Library that allows us to work with Python and MySQL simultaneusly
To install this: 
a. open command prompt
b. type: pip install mysqlclient


2. Download folder "Final_hand_in" with our Python, MySQL and HTML files.
3. In my MySQL Workbench open calculation_tool_1 and run it.
4. Navigate into Backend UI/page/main.py and in the python file main.py change database credentials for the local machine (MYSQL_HOST, MYSQL_USRE, MYSQL_PASSWORD, MYSQL_DATABASE)
6. After all previous steps are successfully done, you can run the programme and follow instructions in terminal.
7. Now you can see login page where you can login into to the system or register new user.
8. You can register a new user account using the “register” button which will redirect yoou to a registration page.
9. Fill in all information needed for the registration (remember your username and password) and use "create user" button to create an account.
10. After registering you are back on the login page where now you can login into the system by using your username and password.
11a. If you input wrong data, you will see an error page with button "Main page" and by clicking on it you will be back on the login page.
11b. If you input correct data, you will see a profile page with 4 opptions: register company, edit company, create project, edit project.
12. Using the "register company" button you will get to company page, where you can register you own company by inputing a name and a phone number and cliking on "create company" button.
13. Using the "edit company" button you will get to edit company page, where you can add new members to the company. Firstly you choose the company, to which you want add new member and then write member's username and role in the company and clik on a button "add".
14. Using the "create project" button you will get to create project page, where you can input project name, choose starting date and estimated finish date and company, which is working on it and create it by clicking on a button "create project".
15. Using the "edit project" button you will get to create edit page, where you can:
	- add a new member to the project by choosing the name of the project, inputing username and role, and clicking on the button "add"
	- create subproject by choosing the name of the project, inputing subproject name and clicking on the button "create sub project"
 	- edit subproject info, where you choose the name of the project and click on a button "edit subprojects"
16.  Using the "edit subprojects" button you will get to edit subprojects page, where you can:
	- create new task in sub project by choosing the subproject, assiging member, inputing task name, estimated time to completion, description of a task and clicking on a button "create task"
	- if you have any tasks assigend to your username you can create task progress record, where you choose a task, date of working on it, hours spend on it, some note, and whether you are finished or not. After your inputs you can create the record by clicking on a button "update task".
	- after finishing the task you will not be able to see it anymore in the progress record options.
 