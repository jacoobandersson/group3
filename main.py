# This will be a page
from flask import Flask, render_template, request, redirect, session, url_for
from flask_mysqldb import MySQL
import MySQLdb

app = Flask(__name__)
app.secret_key = "123456789"
app.config["MYSQL_HOST"] = "127.0.0.1"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "Mysql+37"
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
    if request.method == "POST":
        if "p_one" in request.form and "p_two" in request.form and "p_three" in request.form:
            project_name = request.form['p_one']
            project_start_date = request.form['p_two']
            print(project_name)
            print(project_start_date)
            ccur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            ccur.execute("INSERT INTO calculation_tool_1.project(Project_Name, Start_Date)VALUES(%s,%s)",(project_name, project_start_date))
            db.connection.commit()

            dcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            #cursor.execute("SELECT * FROM calculation_tool_1.project WHERE Username=%s AND Password=%s",(username,password))
            info2 = dcur.fetchone()
            print(info2)
            global projectID
            projectID = info2['Project_Id']
            print(projectID)

            main_role = str("Project Manager")
            ecur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            ecur.execute("INSERT INTO calculation_tool_1.project_user(Project_Id, User_Id, Role)VALUES(%s,%s,%s)",(userID,projectID, main_role))
            db.connection.commit()
            return redirect(url_for('profile'))
    return render_template('project.html')

@app.route('/company', methods=['GET', 'POST'])
def company():
    if request.method == "POST":
        if "c_one" in request.form and "c_two" in request.form:
            company_name = request.form['c_one']
            company_phone_number = request.form['c_two']

            cccur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            cccur.execute("INSERT INTO calculation_tool_1.company(Name, Phone_Number, Contact_Person)VALUES(%s,%s,%s)",(company_name,company_phone_number,userID))
            db.connection.commit()
            return redirect(url_for('profile'))
    return render_template('company.html')

@app.route('/project/sub_project', methods=['GET', 'POST'])
def sub_project():
    if request.method == "POST":
        if "c_one" in request.form and "c_two" in request.form:
            foreign_projectID = request.form['c_one']
            sub_project_name = request.form['c_two']

            fcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            fcur.execute("INSERT INTO calculation_tool_1.sub_project(Project_Id, Name)VALUES(%s,%s)",(foreign_projectID,sub_project_name))
            db.connection.commit()
            return redirect(url_for('project'))
    return render_template('inside_project.html')

@app.route('/project/sub_project/task', methods=['GET', 'POST'])
def task():
    if request.method == "POST":
        if "c_one" in request.form and "c_two" in request.form and "c_three" in request.form and "c_four" in request.form:
            foreign_sub_projectID = request.form['c_one']
            foreign_userID = request.form['c_two']
            WHours_estimated = request.form['c_three']
            task_comment = request.form['c_four']
            fcur = db.connection.cursor(MySQLdb.cursors.DictCursor)
            fcur.execute("INSERT INTO calculation_tool_1.task(Sub_Project_Id, User_Id, Work_Hours_Estimated, Comment)VALUES(%s,%s,%s,%s)",(foreign_sub_projectID, foreign_userID,WHours_estimated, task_comment))
            db.connection.commit()
            return redirect(url_for('task'))
    return render_template('inside_task.html')

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