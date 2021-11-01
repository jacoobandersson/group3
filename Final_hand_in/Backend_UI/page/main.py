#Backend UI.
#Repeated lines are not commented. principle is the same as the first comment.
#Comments are to have better understanding of code and could be used in further development.


from flask import Flask, render_template, request, redirect, session, url_for    #Imports Flask module from flask library
from flask_mysqldb import MySQL                                                  #Imports MySQL module from flask mysqldb library
import MySQLdb 
from werkzeug.exceptions import HTTPException                                    #Imports Exceptions from a library

#Database Credentials - changeable for local machine.

app = Flask(__name__)                                                            #Definition of app variable for flask container to call
app.secret_key = "123456789"                                                     
app.config["MYSQL_HOST"] = "127.0.0.1"                                           #Local host IP of the database server
app.config["MYSQL_USER"] = "root"                                                #User of the database - setup in MySQL. currently root for local.
app.config["MYSQL_PASSWORD"] = "Mysql+37"                                        #Password of the connection to the MySQL database local server
app.config["MYSQL_DATABASE"] = "calculation_tool_1"                              #Current name of the database schema. - CHange this if you change schema name.
db = MySQL(app)                                                                  #definition of db variable to use for MySQL connector methods.

#Login page of the backend UI

@app.route('/', methods=['GET', 'POST'])                                         #Login UI page will use GET and POST methods. this is also a declaration of the link that is being used (local with port and a dir /)
def index():                                                                     #creating a callable definition of a index method declared inside.
    if request.method == 'POST':                                                 
        if 'username' in request.form and 'password' in request.form:            #If there is username and password in the request form (looking at rows in table)
            username = request.form['username']                                  #Setting up variable of username. when user types in his username in the UI, the username will be stored in this.
            password = request.form['password']                                  #Setting up variable of password (same as username functionality here)
            cursor = db.connection.cursor(MySQLdb.cursors.DictCursor)            #Creating a cursor that will go through the database.
            cursor.execute("SELECT * FROM calculation_tool_1.user WHERE Username=%s AND Password=%s",(username,password)) #Cursor executes an SQL SELECT query and gets info of the found table where the username and password values are found.
            info = cursor.fetchone()                                             #info variable is a value of fetch info. cursor is in the table of above checked user.
            print(info)                                                          #Print for the console(CMD) used for testing if the process above goes through
            global userID                                                        #Declaring a Global variable called userID for Login purposes
            userID = info['User_Id']                                             #Value of userID variable is the value of fetched User_Id row from a table
            print(userID)                                                        #Print for the console(CMD) used for testing if the process above goes through
            if info is not None:                                                 #Treating measures so that the user cannot get redirectede if there is no info fetched.
                if info['Username'] == username and info['Password'] == password:       #Validating credentials of logged user
                    session['loginsuccess'] = True                               #If the user login succeeds, redirects the user to his profile page.
                    return redirect(url_for('profile'))                          #redirect to a different HTML template(called profile).
            else: 
                return redirect(url_for('index'))                                #If password or username is not correct, resets main html template calling index method again.
    return render_template('login.html')                                         #login page uses login.html template from files.

#Register page of the Backend UI

@app.route('/register', methods=['GET', 'POST'])                                 #URL will change to register if this route is being used. 
def register():                                                                  #Declaration of callable method called register
    if request.method == "POST":         
        #numbers zero, one... are used in HTML as identifiers of fields.                                       
        if "zero" in request.form and "one" in request.form and "two" in request.form and "three" in request.form: 
            #same principle of variables as in login.
            name = request.form['zero']
            username = request.form['one']
            email = request.form['two']
            password = request.form['three']
            phone = request.form['four']
            cur = db.connection.cursor(MySQLdb.cursors.DictCursor)               #using cur as a name for new cursor, 
            cur.execute("INSERT INTO calculation_tool_1.user(Name, Email, Username, Password, Phone_Number)VALUES(%s,%s,%s,%s,%s)",(name, email, username, password, phone)) #Insert query declaration. process of inputed HTML data into above set variables and then into database using this query.
            db.connection.commit()                                               #commit of the above declared insert query
            return redirect(url_for('index'))                                    #afer registration, login page will be shown.
    return render_template('register.html')                                      #for registration, register.html template is being used.

#Project creation page.

@app.route('/project', methods=['GET', 'POST'])
def project():
    #Creating a View so that i can only use companies that i am a part of for a project.
    compcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
    compcur.execute("USE calculation_tool_1;")
    compcur.execute("DROP VIEW IF EXISTS CompanyView1;")
    compcur.execute("CREATE VIEW CompanyView1 AS SELECT * FROM calculation_tool_1.company JOIN calculation_tool_1.company_User USING (Company_Id) WHERE User_Id=%s",(userID,))
    compcur.execute("SELECT * FROM CompanyView1;")

    company_list = compcur.fetchall()                       
    company_len = len(company_list)  

    #Setting global variables as lists.

    global companies, companies_id
    companies = []
    companies_id = []
     
    #Name of company for the dropdown menu when creating a project.

    if company_len > 0:                                                          #if there are values in fetched cusrsor above, continues with this method.           
        for i in company_list:                                                   #for loop to append 2 rows into 2 lists.
            companies.append(i['Company_Name'])    
            companies_id.append(i['Company_Id'])

    comp_dat = companies

    #Setting up a project itself.

    if request.method == "POST":
        if "p_one" in request.form and "p_two" in request.form and "p_three" in request.form and "p_four" in request.form:
            
            project_name = request.form['p_one']
            project_start_date = request.form['p_two']
            project_end_date = request.form['p_three']
            company_choice = request.form['p_four']
            
            company_id = companies_id[(companies.index(company_choice))]        #company selected in dropdown will be checked for its Id to insert into the project table below.
             
            #Insert of info from creating a project into project database.
            ccur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            ccur.execute("INSERT INTO calculation_tool_1.project(Project_Name, Start_Date, End_Date, Company_Id)VALUES(%s,%s,%s,%s)",(project_name, project_start_date, project_end_date, company_id))
            db.connection.commit()

            #setting up global variable for last inserted project so that it is then inserted into join table between user and a project.
            global projectID
            projectID = ccur.lastrowid

            #Populating of the join table itself with last project created info. user creating a project is automatically a Project manager.

            dcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            dcur.execute("INSERT INTO calculation_tool_1.project_user(Project_Id, User_Id, Role)VALUES(%s,%s,%s)",(projectID, userID,'Project Manager'))
            db.connection.commit()

            return redirect(url_for('profile',))

    return render_template('project.html',comp_dat=comp_dat)

@app.route('/editproject', methods=['GET', 'POST'])
def editproject():
    #Creating a View to see projects and be able to edit them.
    editcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
    editcur.execute("USE calculation_tool_1;")
    editcur.execute("DROP VIEW IF EXISTS AreaView1;")
    editcur.execute("CREATE VIEW AreaView1 AS SELECT * FROM calculation_tool_1.project JOIN calculation_tool_1.project_user USING (Project_Id) WHERE User_Id=%s",(userID,))
    editcur.execute("SELECT * FROM AreaView1;")
    
    projects_list = editcur.fetchall()
    projects_len = len(projects_list)
    global projects, projects_id
    projects = []
    projects_id = []

    if projects_len > 0:
        for i in projects_list:
            projects.append(i['Project_Name'])
            projects_id.append(i['Project_Id'])

    projects_dat = projects

    if request.method == "POST":
        #Adding new user into the project. works on with finding an existing user by username and creating new insert to project_user table associating found user id and selected project by its id.
        if "p_one" in request.form and "p_two" in request.form and "p_three" in request.form:
            
            project_choice = request.form['p_one']
            username = request.form['p_two']
            role = request.form['p_three']                                 #with adding new user into project you can put a custom role that will be recorded to project_user table.
            
            usersor = db.connection.cursor(MySQLdb.cursors.DictCursor)
            usersor.execute("SELECT * FROM calculation_tool_1.user WHERE Username=%s ",(username,))
            info = usersor.fetchone()

            global projectuserID
            projectuserID = info['User_Id']

            project_id = projects_id[(projects.index(project_choice))]         #project dropdown menu choice. then used its id in the table

            usercur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            usercur.execute("INSERT INTO calculation_tool_1.project_user(Project_Id, User_Id, Role)VALUES(%s,%s,%s)",(project_id, projectuserID, role))
            db.connection.commit()

        #Adding new subproject into the project.  associating it with a created project
        if "p_one" in request.form and "p_four" in request.form:

            project_choice = request.form['p_one']
            sub_name = request.form['p_four']

            project_id = projects_id[(projects.index(project_choice))]

            subcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            subcur.execute("INSERT INTO calculation_tool_1.sub_project(Project_Id, Sub_Project_Name)VALUES(%s,%s)",(project_id, sub_name))
            db.connection.commit()

        #Selecting a subproject for a redirect to later options inside a subproject.
        if "sp_one" in request.form:
            project_choice = request.form['sp_one']

            project_id = projects_id[(projects.index(project_choice))]

            session['project_id'] = project_id
            return redirect(url_for('subproject'))
    
    return render_template('editproject.html',projects_dat=projects_dat)

#Selected subproject page.

@app.route('/subproject', methods=['GET', 'POST'])
def subproject():
    
    project_id = session.get('project_id', None)
    
    #working with the project that was previously selected based on project_id that is changing with select from dropdown menu.

    subpcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
    subpcur.execute("SELECT * FROM calculation_tool_1.sub_project WHERE Project_Id=%s",(project_id,))
    subp_list = subpcur.fetchall()
    subp_len = len(subp_list)

    #creating global variables of subproject lists within a selected project to use for tasks.

    global subprojects, subprojects_id
    subprojects = []
    subprojects_id = []

    
    if subp_len > 0:
        for i in subp_list:
            subprojects.append(i['Sub_Project_Name'])
            subprojects_id.append(i['Sub_Project_Id'])

    subprojects_dat = subprojects

    #Creating a view of users that are part of the project so that only these users can be assigned to a task later.

    u_sub_pcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
    u_sub_pcur.execute("USE calculation_tool_1;")
    u_sub_pcur.execute("DROP VIEW IF EXISTS UserView1;")
    u_sub_pcur.execute("CREATE VIEW UserView1 AS SELECT * FROM calculation_tool_1.user JOIN calculation_tool_1.project_user USING (User_Id) WHERE Project_Id=%s",(project_id,))
    u_sub_pcur.execute("SELECT * FROM UserView1;")

    u_sub_p_list = u_sub_pcur.fetchall()
    u_sub_p_len = len(u_sub_p_list)
    global u_sub_projects, u_sub_projects_id
    u_sub_projects = []
    u_sub_projects_id = []


    if u_sub_p_len > 0:
        for i in u_sub_p_list:
            u_sub_projects.append(i['Username'])
            u_sub_projects_id.append(i['User_Id'])

    username_dat = u_sub_projects

    #setting up a join view of task and subproject based on global variables project_id, userID so that the chain of project,subproject and task works properly when dropdown menus are shown.

    taskcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
    taskcur.execute("USE calculation_tool_1;")
    taskcur.execute("DROP VIEW IF EXISTS TaskView1;")
    taskcur.execute("CREATE VIEW TaskView1 AS SELECT * FROM calculation_tool_1.task JOIN calculation_tool_1.sub_project USING (Sub_Project_Id) WHERE User_Id=%s AND Project_Id=%s AND End_Date IS NULL ",(userID, project_id))
    taskcur.execute("SELECT * FROM TaskView1;")
    tasks_list = taskcur.fetchall()
    tasks_len = len(tasks_list)
    global tasks, tasks_id
    tasks = []
    tasks_id = []

    if tasks_len > 0:
        for i in tasks_list:
            tasks.append(i['Task_Name'])
            tasks_id.append(i['Task_Id'])

    tasks_dat = tasks


     #Creating a new task data from a HTML request forms.

    if request.method == "POST":
        if "s_one" in request.form and "u_one" in request.form and "s_two" in request.form and "s_three" in request.form and "s_four" in request.form:
            subproject_choice = request.form['s_one']
            username = request.form['u_one']
            task_name = request.form['s_two']
            work_estimate = request.form['s_three']
            comment = request.form['s_four']

            #Selecting a user that will be working on particular task

            subproject_id = subprojects_id[(subprojects.index(subproject_choice))]
            u_sub_project_id = u_sub_projects_id[(u_sub_projects.index(username))]     #previous view shows only users that are assigned to the project as available in dropdown menu to assign to a task.

            #Insert query of task table data.

            taskcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            taskcur.execute("INSERT INTO calculation_tool_1.task(Sub_Project_Id, User_Id, Task_Name, Work_Hours_Estimated, Comment)VALUES(%s,%s,%s,%s,%s)",(subproject_id, u_sub_project_id, task_name, work_estimate, comment))
            db.connection.commit()
        
        #request forms to later insert into the task_time table

        if "t_one" in request.form and "t_two" in request.form and "t_three" in request.form and "t_four" in request.form and "t_five" in request.form:

            task_choice = request.form['t_one']
            date_of_work = request.form['t_two']
            hours_worked = request.form['t_three']
            comment = request.form['t_four']
            finished = request.form['t_five']

            #dropdown of tasks that the logged use is assigned to.

            task_id = tasks_id[(tasks.index(task_choice))]

            #Insert new records into task_time table.

            timecur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            timecur.execute("INSERT INTO calculation_tool_1.task_time(Task_Id, Day, Hours_Worked, Comment, Is_Finished)VALUES(%s,%s,%s,%s,%s)",(task_id, date_of_work, hours_worked, comment, finished))
            db.connection.commit()

            if finished == "1":
                endcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
                endcur.execute("UPDATE calculation_tool_1.task SET End_Date = %s WHERE Task_Id = %s",(date_of_work, task_id))
                db.connection.commit()
                
            return redirect(url_for('subproject'))

    #using subproject.html template and using some of previous variables
    
    return render_template('subproject.html',subprojects_dat=subprojects_dat,username_dat=username_dat, tasks_dat=tasks_dat), project_id


#Creating a new company in profile.

@app.route('/company', methods=['GET', 'POST'])
def company():
    if request.method == "POST":
        if "c_one" in request.form and "c_two" in request.form:
            company_name = request.form['c_one']
            company_phone_number = request.form['c_two']

            cccur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            cccur.execute("INSERT INTO calculation_tool_1.company(Company_Name, Phone_Number)VALUES(%s,%s)",(company_name,company_phone_number))
            db.connection.commit()

            #Ensuring that when a company is created, there will be another entry to a company_User table where userID will be associated with Company ID.
            global companyID
            companyID = cccur.lastrowid
    
            acur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            acur.execute("INSERT INTO calculation_tool_1.company_User(company_Id, User_Id, Role)VALUES(%s,%s,%s)",(companyID, userID,'Company Manager'))
            db.connection.commit()

            return redirect(url_for('profile'))
    return render_template('company.html')

#Logout button to close logged session redirecting to login page.

#nove2
@app.route('/editcompany', methods=['GET', 'POST'])
def editcompany():
    #Creating a View to see companies that a user is part of and be able to add another user.
    editcompcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
    editcompcur.execute("USE calculation_tool_1;")
    editcompcur.execute("DROP VIEW IF EXISTS AreaView3;")
    editcompcur.execute("CREATE VIEW AreaView3 AS SELECT * FROM calculation_tool_1.company JOIN calculation_tool_1.company_User USING (Company_Id) WHERE User_Id=%s",(userID,))
    editcompcur.execute("SELECT * FROM AreaView3;")
    
    companiess_list = editcompcur.fetchall()
    companiess_len = len(companiess_list)
    global companiess, companiess_id
    companiess = []
    companiess_id = []

    if companiess_len > 0:
        for i in companiess_list:
            companiess.append(i['Company_Name'])
            companiess_id.append(i['Company_Id'])

    companiess_dat = companiess

    if request.method == "POST":
        #Adding new user into the company. works on with finding an existing user by username and creating new insert to company_User table associating found user id and selected company by its id.
        if "cc_one" in request.form and "cc_two" in request.form and "cc_three" in request.form:
            
            companiess_choice = request.form['cc_one']
            username = request.form['cc_two']
            role = request.form['cc_three']                                 #with adding new user into company you can put a custom role that will be recorded to company_User table.

            usercursor = db.connection.cursor(MySQLdb.cursors.DictCursor)
            usercursor.execute("SELECT * FROM calculation_tool_1.user WHERE Username=%s ",(username,))
            info = usercursor.fetchone()

            global companyuserID
            companyuserID = info['User_Id']

            companys_id = companiess_id[(companiess.index(companiess_choice))]         #company dropdown menu choice. then used its id in the table

            companycur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            companycur.execute("INSERT INTO calculation_tool_1.company_User(Company_Id, User_Id, Role)VALUES(%s,%s,%s)",(companys_id, companyuserID, role))
            db.connection.commit()
    return render_template('editcompany.html',companiess_dat=companiess_dat)

@app.route('/profile', methods=['GET', 'POST'])
def profile():
    if session['loginsuccess'] == True:
        if request.method == "POST":
            if request.form.get("logout"):
                session['loginsuccess'] = False
                return redirect(url_for('index'))

        return render_template('profile.html')

#If you put an invalid url, this will be triggered.
@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

@app.errorhandler(Exception)
def handle_exception(e):
    #looking for an error in HTTPexception.
    if isinstance(e, HTTPException):
        return e

    #Handling non HTTP exceptions so that code integrity is in place.
    return render_template("500.html", e=e), 500

#Trigger of the above code here.

if __name__ == '__main__':
    app.run(debug=True)