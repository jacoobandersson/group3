# This will be a page
from flask import Flask, render_template, request, redirect, session, url_for
from flask_mysqldb import MySQL
import MySQLdb

app = Flask(__name__)
app.secret_key = "123456789"
app.config["MYSQL_HOST"] = "127.0.0.1"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "57P_8o1asd"
app.config["MYSQL_DATABASE"] = "calculation_tool_1"
db = MySQL(app)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        if 'username' in request.form and 'password' in request.form:
            username = request.form['username']
            password = request.form['password']
            cursor = db.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("SELECT * FROM calculation_tool_1.user WHERE Username=%s AND Password=%s",(username,password))
            info = cursor.fetchone()
            print(info)
            global userID
            userID = info['User_Id']
            print(userID)
            if info is not None:
                if info['Username'] == username and info['Password'] == password:
                    session['loginsuccess'] = True
                    return redirect(url_for('profile'))
            else:
                #popup when password is not correct
                return redirect(url_for('index'))
    return render_template('login.html')


@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == "POST":
        if "zero" in request.form and "one" in request.form and "two" in request.form and "three" in request.form:
            name = request.form['zero']
            username = request.form['one']
            email = request.form['two']
            password = request.form['three']
            phone = request.form['four']
            cur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            cur.execute("INSERT INTO calculation_tool_1.user(Name, Email, Username, Password, Phone_Number)VALUES(%s,%s,%s,%s,%s)",(name, email, username, password, phone))
            db.connection.commit()
            return redirect(url_for('index'))
    return render_template('register.html')

@app.route('/project', methods=['GET', 'POST'])
def project():
    print(userID)
    compcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
    compcur.execute("SELECT * FROM calculation_tool_1.company WHERE Contact_Person=%s",(userID,))
    company_list = compcur.fetchall()
    print(company_list)
    company_len = len(company_list)
    print(company_len)
    global companies, companies_id
    companies = []
    companies_id = []

    if company_len > 0:
        print("true")
        for i in company_list:
            print(i)
            companies.append(i['Company_Name'])
            companies_id.append(i['Company_Id'])
            print(companies)
    print(companies)

    comp_dat = companies

    if request.method == "POST":
        if "p_one" in request.form and "p_two" in request.form and "p_three" in request.form:
            project_name = request.form['p_one']
            project_start_date = request.form['p_two']
            company_choice = request.form['p_three']
            print(project_name)
            print(project_start_date)
            print(company_choice)

            company_id = companies_id[(companies.index(company_choice))]

            ccur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            ccur.execute("INSERT INTO calculation_tool_1.project(Project_Name, Start_Date, Company_Id)VALUES(%s,%s,%s)",(project_name, project_start_date,company_id))
            db.connection.commit()

            global projectID
            projectID = ccur.lastrowid

            dcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            dcur.execute("INSERT INTO calculation_tool_1.project_user(Project_Id, User_Id, Role)VALUES(%s,%s,%s)",(projectID, userID,'Project Manager'))
            db.connection.commit()

            return redirect(url_for('profile',))

    return render_template('project.html',comp_dat=comp_dat)

@app.route('/editproject', methods=['GET', 'POST'])
def editproject():
    # project setup 
    editcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
    editcur.execute("USE calculation_tool_1;")
    editcur.execute("DROP VIEW IF EXISTS AreaView1;")
    editcur.execute("CREATE VIEW AreaView1 AS SELECT * FROM calculation_tool_1.project JOIN calculation_tool_1.project_user USING (Project_Id) WHERE User_Id=%s",(userID,))
    editcur.execute("SELECT * FROM AreaView1;")
    
    projects_list = editcur.fetchall()
    print(projects_list)
    projects_len = len(projects_list)
    print(projects_len)
    global projects, projects_id
    projects = []
    projects_id = []

    if projects_len > 0:
        print("true")
        for i in projects_list:
            print(i)
            projects.append(i['Project_Name'])
            projects_id.append(i['Project_Id'])
            print(projects)

    projects_dat = projects

    if request.method == "POST":
        # add user
        if "p_one" in request.form and "p_two" in request.form and "p_three" in request.form:
            
            project_choice = request.form['p_one']
            username = request.form['p_two']
            role = request.form['p_three']
            print(project_choice)
            print(username)
            print(role)

            usersor = db.connection.cursor(MySQLdb.cursors.DictCursor)
            usersor.execute("SELECT * FROM calculation_tool_1.user WHERE Username=%s ",(username,))
            info = usersor.fetchone()

            global projectuserID
            projectuserID = info['User_Id']
            print(projectuserID)

            project_id = projects_id[(projects.index(project_choice))]

            usercur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            usercur.execute("INSERT INTO calculation_tool_1.project_user(Project_Id, User_Id, Role)VALUES(%s,%s,%s)",(project_id, projectuserID, role))
            db.connection.commit()

        # add subtask
        if "p_one" in request.form and "p_four" in request.form:

            project_choice = request.form['p_one']
            sub_name = request.form['p_four']
            print(project_choice)
            print(sub_name)
            
            project_id = projects_id[(projects.index(project_choice))]

            subcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            subcur.execute("INSERT INTO calculation_tool_1.sub_project(Project_Id, Sub_Project_Name)VALUES(%s,%s)",(project_id, sub_name))
            db.connection.commit()

        # edit subtasks
        if "sp_one" in request.form:
            project_choice = request.form['sp_one']
            print(project_choice)

            project_id = projects_id[(projects.index(project_choice))]
            print(project_id)
            session['project_id'] = project_id
            return redirect(url_for('subproject'))
    
    return render_template('editproject.html',projects_dat=projects_dat)

@app.route('/subproject', methods=['GET', 'POST'])
def subproject():
    
    project_id = session.get('project_id', None)
    print(project_id)
    
    subpcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
    subpcur.execute("SELECT * FROM calculation_tool_1.sub_project WHERE Project_Id=%s",(project_id,))
    subp_list = subpcur.fetchall()
    print(subp_list)
    subp_len = len(subp_list)
    print(subp_len)
    global subprojects, subprojects_id
    subprojects = []
    subprojects_id = []

    if subp_len > 0:
        print("true")
        for i in subp_list:
            print(i)
            subprojects.append(i['Sub_Project_Name'])
            subprojects_id.append(i['Sub_Project_Id'])
            print(subprojects)

    subprojects_dat = subprojects

    # part 2

    u_sub_pcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
    u_sub_pcur.execute("USE calculation_tool_1;")
    u_sub_pcur.execute("DROP VIEW IF EXISTS UserView1;")
    u_sub_pcur.execute("CREATE VIEW UserView1 AS SELECT * FROM calculation_tool_1.user JOIN calculation_tool_1.project_user USING (User_Id) WHERE Project_Id=%s",(project_id,))
    u_sub_pcur.execute("SELECT * FROM UserView1;")

    u_sub_p_list = u_sub_pcur.fetchall()
    print(u_sub_p_list)
    u_sub_p_len = len(u_sub_p_list)
    print(u_sub_p_len)
    global u_sub_projects, u_sub_projects_id
    u_sub_projects = []
    u_sub_projects_id = []

    if u_sub_p_len > 0:
        print("true")
        for i in u_sub_p_list:
            print(i)
            u_sub_projects.append(i['Username'])
            u_sub_projects_id.append(i['User_Id'])
            print(u_sub_projects)

    username_dat = u_sub_projects

    # task setup
    print(userID)
    taskcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
    taskcur.execute("USE calculation_tool_1;")
    taskcur.execute("DROP VIEW IF EXISTS TaskView1;")
    taskcur.execute("CREATE VIEW TaskView1 AS SELECT * FROM calculation_tool_1.task JOIN calculation_tool_1.sub_project USING (Sub_Project_Id) WHERE User_Id=%s AND Project_Id=%s",(userID, project_id))
    taskcur.execute("SELECT * FROM TaskView1;")
    tasks_list = taskcur.fetchall()
    print(tasks_list)
    tasks_len = len(tasks_list)
    print(tasks_len)
    global tasks, tasks_id
    tasks = []
    tasks_id = []

    if tasks_len > 0:
        print("true")
        for i in tasks_list:
            print(i)
            tasks.append(i['Task_Name'])
            tasks_id.append(i['Task_Id'])
            print(tasks)

    tasks_dat = tasks




    if request.method == "POST":
        if "s_one" in request.form and "u_one" in request.form and "s_two" in request.form and "s_three" in request.form and "s_four" in request.form:
            print("POST")
            print("POST")
            print("POST")
            subproject_choice = request.form['s_one']
            username = request.form['u_one']
            task_name = request.form['s_two']
            work_estimate = request.form['s_three']
            comment = request.form['s_four']

            print(subproject_choice)
            print(username)
            print(task_name)
            print(work_estimate)
            print(comment)

            subproject_id = subprojects_id[(subprojects.index(subproject_choice))]
            u_sub_project_id = u_sub_projects_id[(u_sub_projects.index(username))]

            print(subproject_id)
            print(u_sub_project_id)


            taskcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            taskcur.execute("INSERT INTO calculation_tool_1.task(Sub_Project_Id, User_Id, Task_Name, Work_Hours_Estimated, Comment)VALUES(%s,%s,%s,%s,%s)",(subproject_id, u_sub_project_id, task_name, work_estimate, comment))
            db.connection.commit()
        
        # task

        if "t_one" in request.form and "t_two" in request.form and "t_three" in request.form and "t_four" in request.form and "t_five" in request.form:
            print("TASK")
            print("TASK")
            print("TASK")

            task_choice = request.form['t_one']
            date_of_work = request.form['t_two']
            hours_worked = request.form['t_three']
            comment = request.form['t_four']
            finished = request.form['t_five']

            task_id = tasks_id[(tasks.index(task_choice))]

            print(task_choice)
            print(date_of_work)
            print(hours_worked)
            print(comment)
            print(finished)


            timecur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            timecur.execute("INSERT INTO calculation_tool_1.task_time(Task_Id, Day, Hours_Worked, Comment, Is_Finished)VALUES(%s,%s,%s,%s,%s)",(task_id, date_of_work, hours_worked, comment, finished))
            db.connection.commit()
            

    return render_template('subproject.html',subprojects_dat=subprojects_dat,username_dat=username_dat, tasks_dat=tasks_dat), project_id

@app.route('/company', methods=['GET', 'POST'])
def company():
    if request.method == "POST":
        if "c_one" in request.form and "c_two" in request.form:
            company_name = request.form['c_one']
            company_phone_number = request.form['c_two']

            cccur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            cccur.execute("INSERT INTO calculation_tool_1.company(Company_Name, Phone_Number, Contact_Person)VALUES(%s,%s,%s)",(company_name,company_phone_number,userID))
            db.connection.commit()
            return redirect(url_for('profile'))
    return render_template('company.html')

@app.route('/profile', methods=['GET', 'POST'])
def profile():
    if session['loginsuccess'] == True:
        if request.method == "POST":
            if request.form.get("logout"):
                session['loginsuccess'] = False
                return redirect(url_for('index'))

        return render_template('profile.html')


if __name__ == '__main__':
    app.run(debug=True)