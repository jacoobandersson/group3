CREATE DATABASE `calculation_tool`;

USE `calculation_tool`;

CREATE TABLE `user` (
  `User_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `Username` varchar(45) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `Phone_Number` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`User_Id`)
);

CREATE TABLE `company` (
  `Company_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Phone_Number` varchar(45) NOT NULL,
  `Contact_Person` int(11) NOT NULL,
  PRIMARY KEY (`Company_Id`),
  KEY `Company_User_idx` (`Contact_Person`),
  CONSTRAINT `Company_User` FOREIGN KEY (`Contact_Person`) REFERENCES `user` (`User_Id`)
);

CREATE TABLE `project_member` (
  `Project_Member_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Project_Role` varchar(45) NOT NULL,
  `User_Id` int(11) NOT NULL,
  `Sub_Project_Id` int(11) NOT NULL,
  PRIMARY KEY (`Project_Member_Id`),
  KEY `Project_Manager_User_idx` (`User_Id`),
  CONSTRAINT `Project_Member_User` FOREIGN KEY (`User_Id`) REFERENCES `user` (`User_Id`)
);

CREATE TABLE `project` (
  `Project_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Start_Date` datetime DEFAULT NULL,
  `Deadline` datetime DEFAULT NULL,
  `Company_Id` int(11) NOT NULL,
  `Project_Manager` int(11) NOT NULL,
  PRIMARY KEY (`Project_Id`),
  KEY `Project_Company_idx` (`Company_Id`),
  KEY `Project_Project_Member_idx` (`Project_Manager`),
  CONSTRAINT `Project_Company` FOREIGN KEY (`Company_Id`) REFERENCES `company` (`Company_Id`),
  CONSTRAINT `Project_Project_Member` FOREIGN KEY (`Project_Manager`) REFERENCES `project_member` (`Project_Member_Id`)
);

CREATE TABLE `sub_project` (
  `Sub_Project_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Start_Date` datetime DEFAULT NULL,
  `Deadline` datetime DEFAULT NULL,
  `Project_Id` int(11) NOT NULL,
  `Project_Manager` int(11) NOT NULL,
  PRIMARY KEY (`Sub_Project_Id`),
  KEY `Sub_Project_Project_Member_idx` (`Project_Manager`),
  KEY `Sub_Project_Project_idx` (`Project_Id`),
  CONSTRAINT `Sub_Project_Project` FOREIGN KEY (`Project_Id`) REFERENCES `project` (`Project_Id`),
  CONSTRAINT `Sub_Project_Project_Member` FOREIGN KEY (`Project_Manager`) REFERENCES `project_member` (`Project_Member_Id`)
);

ALTER TABLE `project_member`
ADD FOREIGN KEY (`Sub_Project_Id`) REFERENCES `sub_project` (`Sub_Project_Id`);

CREATE TABLE `task` (
  `Task_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Work_Hours_Estimate` decimal(10,2) NOT NULL,
  `Deadline` datetime NOT NULL,
  `Sub_Project_Id` int(11) NOT NULL,
  `Project_Member_Id` int(11) NOT NULL,
  PRIMARY KEY (`Task_Id`),
  KEY `Task_Sub_Project_idx` (`Sub_Project_Id`),
  KEY `Task_Project_Member_idx` (`Project_Member_Id`),
  CONSTRAINT `Task_Project_Member` FOREIGN KEY (`Project_Member_Id`) REFERENCES `project_member` (`Project_Member_Id`),
  CONSTRAINT `Task_Sub_Project` FOREIGN KEY (`Sub_Project_Id`) REFERENCES `sub_project` (`Sub_Project_Id`)
);

CREATE TABLE `time_registration` (
  `Time_Registration_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Date` datetime NOT NULL,
  `Hours` decimal(10,2) NOT NULL,
  `Commend` varchar(2000) DEFAULT NULL,
  `Task_Id` int(11) NOT NULL,
  `Project_Member_Id` int(11) NOT NULL,
  PRIMARY KEY (`Time_Registration_Id`),
  KEY `Time_Registration_Task_idx` (`Task_Id`),
  KEY `Time_Registration_Project_Member_idx` (`Project_Member_Id`),
  CONSTRAINT `Time_Registration_Project_Member` FOREIGN KEY (`Project_Member_Id`) REFERENCES `project_member` (`Project_Member_Id`),
  CONSTRAINT `Time_Registration_Task` FOREIGN KEY (`Task_Id`) REFERENCES `task` (`Task_Id`)
);

