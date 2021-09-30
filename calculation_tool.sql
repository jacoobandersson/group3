-- The database is been creating
CREATE DATABASE `calculation_tool`;

-- The Database is used
USE `calculation_tool`;

-- We are creating The table User with attributtes
CREATE TABLE `user` (
  `User_Id` int(11) NOT NULL AUTO_INCREMENT, -- The user's Id, to identify the user
  `Name` varchar(45) NOT NULL, -- The user's name
  `Email` varchar(45) NOT NULL, -- The user's Email
  `Username` varchar(45) NOT NULL, -- The user's chosen username
  `Password` varchar(45) NOT NULL, -- The user's chosen password
  `Phone_Number` varchar(45) DEFAULT NULL, -- The user's phonenumber
  PRIMARY KEY (`User_Id`) -- The tables primery key
);

-- We are creating The table Company with attributtes
CREATE TABLE `company` (
  `Company_Id` int(11) NOT NULL AUTO_INCREMENT, -- The company's Id, to identify the company 
  `Name` varchar(255) NOT NULL, -- The company's name
  `Phone_Number` varchar(45) NOT NULL, -- The company's phonenumber
  `Contact_Person` int(11) NOT NULL, -- Is the foreign key from the table user, and shows The company's contact person
  PRIMARY KEY (`Company_Id`), -- The tables primery key
  KEY `Company_User_idx` (`Contact_Person`), -- Is the relation between company and user
  CONSTRAINT `Company_User` FOREIGN KEY (`Contact_Person`) REFERENCES `user` (`User_Id`) -- User Id is the foreign key in company
);

-- We are creating The table Project Member with attributtes
CREATE TABLE `project_member` (
  `Project_Member_Id` int(11) NOT NULL AUTO_INCREMENT, -- The Project member's Id, to identify the project member 
  `Project_Role` varchar(45) NOT NULL, -- Shows which role the project member has on the project eg. developer
  `User_Id` int(11) NOT NULL, -- Is the foreign key from the user table, and shows which member the user are
  `Sub_Project_Id` int(11) NOT NULL, -- Is the foreign key from the sub project table, and shows which member are connected to the projects
  PRIMARY KEY (`Project_Member_Id`), -- The tables primery key
  KEY `Project_Manager_User_idx` (`User_Id`), -- Is the relation between Project member and user
  CONSTRAINT `Project_Member_User` FOREIGN KEY (`User_Id`) REFERENCES `user` (`User_Id`) -- User Id is the foreign key in project member
);

-- We are creating The table Project with attributtes
CREATE TABLE `project` (
  `Project_Id` int(11) NOT NULL AUTO_INCREMENT, -- The Project's Id, to identify the project
  `Start_Date` datetime DEFAULT NULL, -- The project start date
  `Deadline` datetime DEFAULT NULL, -- The project end date
  `Company_Id` int(11) NOT NULL, -- Is the foreign key from the company table, and shows which project the company has
  `Project_Manager` int(11) NOT NULL, -- Is the foreign key from the project member table, and shows which member there is the project manager on the project
  PRIMARY KEY (`Project_Id`), -- The tables primery key
  KEY `Project_Company_idx` (`Company_Id`), -- Is the relationsship between project and company
  KEY `Project_Project_Member_idx` (`Project_Manager`), -- Is the relationsship between project and project member
  CONSTRAINT `Project_Company` FOREIGN KEY (`Company_Id`) REFERENCES `company` (`Company_Id`), -- Company Id is the foreign key in project
  CONSTRAINT `Project_Project_Member` FOREIGN KEY (`Project_Manager`) REFERENCES `project_member` (`Project_Member_Id`) -- project maneger is the foreign key in project
);

-- We are creating The table Sub Project with attributtes
CREATE TABLE `sub_project` (
  `Sub_Project_Id` int(11) NOT NULL AUTO_INCREMENT, -- The Sub Project's Id, to identify the sub project
  `Start_Date` datetime DEFAULT NULL, -- The sub project start date
  `Deadline` datetime DEFAULT NULL, -- The sub project end date
  `Project_Id` int(11) NOT NULL, -- Is the foreign key from the project table, and shows which sub project the project has
  `Project_Manager` int(11) NOT NULL, -- Is the foreign key from the project member table, and shows which member there is the project manager on the sub project
  PRIMARY KEY (`Sub_Project_Id`), -- The tables primery key
  KEY `Sub_Project_Project_Member_idx` (`Project_Manager`), -- Is the relationsship between sub project and project member
  KEY `Sub_Project_Project_idx` (`Project_Id`), -- Is the relationsship between sub project and project
  CONSTRAINT `Sub_Project_Project` FOREIGN KEY (`Project_Id`) REFERENCES `project` (`Project_Id`), -- Project Id is the foreign key in sub project
  CONSTRAINT `Sub_Project_Project_Member` FOREIGN KEY (`Project_Manager`) REFERENCES `project_member` (`Project_Member_Id`) -- Project manager is the foreign key in sub project
);

ALTER TABLE `project_member` -- We are altering the table project member
ADD FOREIGN KEY (`Sub_Project_Id`) REFERENCES `sub_project` (`Sub_Project_Id`); -- We are adding the foreign key sub project to project member

-- We are creating The table Task with attributtes
CREATE TABLE `task` (
  `Task_Id` int(11) NOT NULL AUTO_INCREMENT, -- The task's Id, to identify the task
  `Work_Hours_Estimate` decimal(10,2) NOT NULL, -- Shows how many hours a task will take
  `Deadline` datetime NOT NULL, -- The task end date
  `Status` varchar(45), -- The task status
  `Sub_Project_Id` int(11) NOT NULL, -- Is the foreign key from the sub project table, and shows which task there is on the sub project
  `Project_Member_Id` int(11) NOT NULL, -- Is the foreign key from the project member table, and shows which member there are responsable for the task
  PRIMARY KEY (`Task_Id`), -- The tables primery key
  KEY `Task_Sub_Project_idx` (`Sub_Project_Id`), -- Is the relationsship between task and sub project
  KEY `Task_Project_Member_idx` (`Project_Member_Id`), -- Is the relationsship between task and project member
  CONSTRAINT `Task_Sub_Project` FOREIGN KEY (`Sub_Project_Id`) REFERENCES `sub_project` (`Sub_Project_Id`), -- Sub project Id is the foreign key in task
  CONSTRAINT `Task_Project_Member` FOREIGN KEY (`Project_Member_Id`) REFERENCES `project_member` (`Project_Member_Id`) -- Project member Id is the foreign key in task
);

-- We are creating The table Time Registration with attributtes
CREATE TABLE `time_registration` (
  `Time_Registration_Id` int(11) NOT NULL AUTO_INCREMENT, -- The Time Registration's Id, to identify the time registration
  `Date` datetime NOT NULL, -- The date for the Time registration
  `Hours` decimal(10,2) NOT NULL, -- How much time are used
  `Commend` varchar(2000) DEFAULT NULL, -- Is there a commed to registration
  `Task_Id` int(11) NOT NULL, -- Is the foreign key from the task table, and shows how much time there are used on a task
  `Project_Member_Id` int(11) NOT NULL, -- Is the foreign key from the project member table, and shows which member has made the registration
  PRIMARY KEY (`Time_Registration_Id`), -- The tables primery key
  KEY `Time_Registration_Task_idx` (`Task_Id`), -- Is the relationsship between time registration and task
  KEY `Time_Registration_Project_Member_idx` (`Project_Member_Id`), -- Is the relationsship between time registration and project member
  CONSTRAINT `Time_Registration_Project_Member` FOREIGN KEY (`Project_Member_Id`) REFERENCES `project_member` (`Project_Member_Id`), -- Task Id is the foreign key in time registration
  CONSTRAINT `Time_Registration_Task` FOREIGN KEY (`Task_Id`) REFERENCES `task` (`Task_Id`) -- Project member Id is the foreign key in time registration
);

