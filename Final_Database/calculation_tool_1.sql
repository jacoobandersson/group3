-- The database is been creating
CREATE SCHEMA IF NOT EXISTS `calculation_tool_1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- The Database is used
USE `calculation_tool_1` ;

-- -----------------------------------------------------
-- We are creating The table User with attributtes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`user` (
  `User_Id` INT NOT NULL AUTO_INCREMENT, -- The user's Id, to identify the user
  `Name` VARCHAR(45) NOT NULL, -- The user's name
  `Email` VARCHAR(45) NOT NULL, -- The user's Email
  `Username` VARCHAR(45) NOT NULL, -- The user's chosen username
  `Password` VARCHAR(45) NOT NULL, -- The user's chosen password
  `Phone_Number` VARCHAR(45) NULL DEFAULT NULL, -- The user's phonenumber
  PRIMARY KEY (`User_Id`), -- The tables primery key
  UNIQUE INDEX `Username_UNIQUE` (`Username` ASC) VISIBLE,
  UNIQUE INDEX `User_Id_UNIQUE` (`User_Id` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  INDEX `A` (`Name` ASC, `Email` ASC, `Username` ASC, `Password` ASC, `Phone_Number` ASC) VISIBLE)
ENGINE = InnoDB -- Database format
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4 -- Type of characters
COLLATE = utf8mb4_0900_ai_ci; 


-- -----------------------------------------------------
-- We are creating The table Company with attributtes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`company` (
  `Company_Id` INT NOT NULL AUTO_INCREMENT, -- The company's Id, to identify the company
  `Company_Name` VARCHAR(225) NOT NULL, -- The company's name
  `Phone_Number` VARCHAR(45) NOT NULL, -- The company's phonenumber
  PRIMARY KEY (`Company_Id`), -- The tables primery key
  INDEX `A` (`Company_Name` ASC, `Phone_Number` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Creating table company_User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`company_User` (
  `User_Id` INT NOT NULL, -- Is the foreign key from the table user
  `Company_Id` INT NOT NULL, -- Is the foreign key from the table company
  `Role` VARCHAR(45) NULL DEFAULT NULL, -- Role of the user in the company, user that created the company will automatically be company manager in UI
  INDEX `Company_Id_idx` (`Company_Id` ASC) VISIBLE,
  INDEX `User_Id_idx` (`User_Id` ASC) VISIBLE,
  CONSTRAINT `Company_Id`
    FOREIGN KEY (`Company_Id`)
    REFERENCES `calculation_tool_1`.`company` (`Company_Id`) -- Company Id is the foreign key in company_user
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `User_Id`
    FOREIGN KEY (`User_Id`)
    REFERENCES `calculation_tool_1`.`user` (`User_Id`) -- User Id is the foreign key in company_user
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- We are creating The table Project with attributtes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`project` (
  `Project_Id` INT NOT NULL AUTO_INCREMENT, -- The Project's Id, to identify the project
  `Project_Name` VARCHAR(45) NOT NULL, -- The project start date
  `Start_Date` DATETIME NOT NULL, -- The project end date
  `Company_Id` INT NULL DEFAULT NULL, -- Is the foreign key from the company table, and shows which project the company has
  PRIMARY KEY (`Project_Id`, `Project_Name`), -- The tables primary key
  INDEX `A` (`Project_Name` ASC, `Start_Date` ASC) VISIBLE,
  INDEX `project_ibfk_1_idx` (`Company_Id` ASC) VISIBLE,
  CONSTRAINT `project_ibfk_1`
    FOREIGN KEY (`Company_Id`)
    REFERENCES `calculation_tool_1`.`company` (`Company_Id`)) -- Company Id is the foreign key in project
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Creating table project_user
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`project_user` (
  `Project_Id` INT NOT NULL, -- Is the foreign key from the table project
  `User_Id` INT NOT NULL, -- Is the foreign key from the table user
  `Role` VARCHAR(45) NULL DEFAULT NULL, -- Role of a user in the project
  INDEX `Project_Id` (`Project_Id` ASC) VISIBLE,
  INDEX `User_Id` (`User_Id` ASC) VISIBLE,
  INDEX `A` (`Role` ASC) VISIBLE,
  CONSTRAINT `project_user_ibfk_1`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `calculation_tool_1`.`project` (`Project_Id`), -- Project Id is the foreign key in project_user
  CONSTRAINT `project_user_ibfk_2`
    FOREIGN KEY (`User_Id`)
    REFERENCES `calculation_tool_1`.`user` (`User_Id`)) -- User Id is the foreign key in project_user
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- We are creating The table Sub Project with attributtes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`sub_project` (
  `Sub_Project_Id` INT NOT NULL AUTO_INCREMENT, -- The Sub Project's Id, to identify the sub project
  `Project_Id` INT NOT NULL, -- Is the foreign key from the project table, and shows which sub project the project has
  `Sub_Project_Name` VARCHAR(45) NULL DEFAULT NULL, -- name of the sub-project
  PRIMARY KEY (`Sub_Project_Id`), -- The table primary key
  INDEX `Project_Id` (`Project_Id` ASC) VISIBLE,
  CONSTRAINT `sub_project_ibfk_1`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `calculation_tool_1`.`project` (`Project_Id`)) -- Project Id is the foreign key in sub_project
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- We are creating The table Task with attributtes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`task` (
  `Task_Id` INT NOT NULL AUTO_INCREMENT, -- The task's Id, to identify the task
  `Sub_Project_Id` INT NOT NULL, -- Is the foreign key from the sub project table, and shows which task there is on the sub project
  `User_Id` INT NOT NULL, -- Is the foreign key from the user table, and shows which user is working on the task
  `Task_Name` VARCHAR(45) NOT NULL, -- Is the name of the task
  `Work_Hours_Estimated` INT NOT NULL, -- Shows how many hours we think a task will take
  `Comment` VARCHAR(255) NULL DEFAULT NULL, -- Comment
  PRIMARY KEY (`Task_Id`), -- The table primary key
  INDEX `Sub_Project_Id` (`Sub_Project_Id` ASC) VISIBLE,
  INDEX `User_Id` (`User_Id` ASC) VISIBLE,
  INDEX `A` (`Work_Hours_Estimated` ASC, `Comment` ASC) VISIBLE,
  CONSTRAINT `task_ibfk_1`
    FOREIGN KEY (`Sub_Project_Id`)
    REFERENCES `calculation_tool_1`.`sub_project` (`Sub_Project_Id`), -- Sub project Id is the foreign key in task
  CONSTRAINT `task_ibfk_2`
    FOREIGN KEY (`User_Id`)
    REFERENCES `calculation_tool_1`.`user` (`User_Id`)) -- User Id is the foreign key in task
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `calculation_tool_1`.`task_time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`task_time` (
  `Task_Time_Id` INT NOT NULL AUTO_INCREMENT, -- task_time ID to identify task_time
  `Task_Id` INT NOT NULL, -- Is the foreign key from the task table, and shows to which task table task_time belong 
  `Day` DATE NULL DEFAULT NULL, -- represents what day project member worked on a task
  `Hours_Worked` VARCHAR(45) NULL DEFAULT NULL, -- how many hours member worked on a task
  `Comment` TEXT NULL DEFAULT NULL, -- comment
  `Is_Finished` TINYINT(1) NOT NULL DEFAULT '0', -- is the task finished or not 
  PRIMARY KEY (`Task_Time_Id`),
  INDEX `Task_Id_idx` (`Task_Id` ASC) VISIBLE,
  CONSTRAINT `Task_Id`
    FOREIGN KEY (`Task_Id`)
    REFERENCES `calculation_tool_1`.`task` (`Task_Id`)) -- task Id is the foreign key in task_time
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `calculation_tool_1` ;

-- -----------------------------------------------------
-- Placeholder table for view `calculation_tool_1`.`areaview1` consists of information from tables project and project_user
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`areaview1` (`Project_Id` INT, `Project_Name` INT, `Start_Date` INT, `Company_Id` INT, `User_Id` INT, `Role` INT);

-- -----------------------------------------------------
-- Placeholder table for view `calculation_tool_1`.`areaview2` consists of information from tables project, user and project_user
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`areaview2` (`User_Id` INT, `Project_Id` INT, `Project_Name` INT, `Start_Date` INT, `Company_Id` INT, `Role` INT, `Name` INT, `Email` INT, `Username` INT, `Password` INT, `Phone_Number` INT);

-- -----------------------------------------------------
-- Placeholder table for view `calculation_tool_1`.`subview1` consists of information from tables project, sub_project and project_user 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`subview1` (`Project_Id` INT, `Sub_Project_Id` INT, `Sub_Project_Name` INT, `User_Id` INT, `Role` INT);

-- -----------------------------------------------------
-- Placeholder table for view `calculation_tool_1`.`subview2` consists of information from tables project, sub_project and project_user 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`subview2` (`Project_Id` INT, `Sub_Project_Id` INT, `Sub_Project_Name` INT, `User_Id` INT, `Role` INT, `Project_Name` INT, `Start_Date` INT, `Company_Id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `calculation_tool_1`.`taskview1` consists of information from tables sub_project, task 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`taskview1` (`Sub_Project_Id` INT, `Task_Id` INT, `User_Id` INT, `Task_Name` INT, `Work_Hours_Estimated` INT, `Comment` INT, `Project_Id` INT, `Sub_Project_Name` INT);

-- -----------------------------------------------------
-- Placeholder table for view `calculation_tool_1`.`userview1` consists of information from tables user and project_user 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`userview1` (`User_Id` INT, `Name` INT, `Email` INT, `Username` INT, `Password` INT, `Phone_Number` INT, `Project_Id` INT, `Role` INT);

-- -----------------------------------------------------
-- Create view `calculation_tool_1`.`areaview1` where user_Id = 1
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calculation_tool_1`.`areaview1`;
USE `calculation_tool_1`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `calculation_tool_1`.`areaview1` AS select `calculation_tool_1`.`project`.`Project_Id` AS `Project_Id`,`calculation_tool_1`.`project`.`Project_Name` AS `Project_Name`,`calculation_tool_1`.`project`.`Start_Date` AS `Start_Date`,`calculation_tool_1`.`project`.`Company_Id` AS `Company_Id`,`calculation_tool_1`.`project_user`.`User_Id` AS `User_Id`,`calculation_tool_1`.`project_user`.`Role` AS `Role` from (`calculation_tool_1`.`project` join `calculation_tool_1`.`project_user` on((`calculation_tool_1`.`project`.`Project_Id` = `calculation_tool_1`.`project_user`.`Project_Id`))) where (`calculation_tool_1`.`project_user`.`User_Id` = 1);

-- -----------------------------------------------------
-- Create view `calculation_tool_1`.`areaview2` where user_Id = 1
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calculation_tool_1`.`areaview2`;
USE `calculation_tool_1`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `calculation_tool_1`.`areaview2` AS select `calculation_tool_1`.`areaview1`.`User_Id` AS `User_Id`,`calculation_tool_1`.`areaview1`.`Project_Id` AS `Project_Id`,`calculation_tool_1`.`areaview1`.`Project_Name` AS `Project_Name`,`calculation_tool_1`.`areaview1`.`Start_Date` AS `Start_Date`,`calculation_tool_1`.`areaview1`.`Company_Id` AS `Company_Id`,`calculation_tool_1`.`areaview1`.`Role` AS `Role`,`calculation_tool_1`.`user`.`Name` AS `Name`,`calculation_tool_1`.`user`.`Email` AS `Email`,`calculation_tool_1`.`user`.`Username` AS `Username`,`calculation_tool_1`.`user`.`Password` AS `Password`,`calculation_tool_1`.`user`.`Phone_Number` AS `Phone_Number` from (`calculation_tool_1`.`areaview1` join `calculation_tool_1`.`user` on((`calculation_tool_1`.`areaview1`.`User_Id` = `calculation_tool_1`.`user`.`User_Id`))) where (`calculation_tool_1`.`areaview1`.`User_Id` = 1);

-- -----------------------------------------------------
-- Create view `calculation_tool_1`.`subview1` project_Id = 4
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calculation_tool_1`.`subview1`;
USE `calculation_tool_1`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `calculation_tool_1`.`subview1` AS select `calculation_tool_1`.`sub_project`.`Project_Id` AS `Project_Id`,`calculation_tool_1`.`sub_project`.`Sub_Project_Id` AS `Sub_Project_Id`,`calculation_tool_1`.`sub_project`.`Sub_Project_Name` AS `Sub_Project_Name`,`calculation_tool_1`.`project_user`.`User_Id` AS `User_Id`,`calculation_tool_1`.`project_user`.`Role` AS `Role` from (`calculation_tool_1`.`sub_project` join `calculation_tool_1`.`project_user` on((`calculation_tool_1`.`sub_project`.`Project_Id` = `calculation_tool_1`.`project_user`.`Project_Id`))) where ((`calculation_tool_1`.`project_user`.`User_Id` = 1) and (`calculation_tool_1`.`sub_project`.`Project_Id` = 4));

-- -----------------------------------------------------
-- Create view `calculation_tool_1`.`subview2` where user_Id = 1
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calculation_tool_1`.`subview2`;
USE `calculation_tool_1`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `calculation_tool_1`.`subview2` AS select `calculation_tool_1`.`subview1`.`Project_Id` AS `Project_Id`,`calculation_tool_1`.`subview1`.`Sub_Project_Id` AS `Sub_Project_Id`,`calculation_tool_1`.`subview1`.`Sub_Project_Name` AS `Sub_Project_Name`,`calculation_tool_1`.`subview1`.`User_Id` AS `User_Id`,`calculation_tool_1`.`subview1`.`Role` AS `Role`,`calculation_tool_1`.`project`.`Project_Name` AS `Project_Name`,`calculation_tool_1`.`project`.`Start_Date` AS `Start_Date`,`calculation_tool_1`.`project`.`Company_Id` AS `Company_Id` from (`calculation_tool_1`.`subview1` join `calculation_tool_1`.`project` on((`calculation_tool_1`.`subview1`.`Project_Id` = `calculation_tool_1`.`project`.`Project_Id`))) where (`calculation_tool_1`.`subview1`.`User_Id` = 1);

-- -----------------------------------------------------
-- Create view `calculation_tool_1`.`taskview1` where project_Id = 5
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calculation_tool_1`.`taskview1`;
USE `calculation_tool_1`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `calculation_tool_1`.`taskview1` AS select `calculation_tool_1`.`task`.`Sub_Project_Id` AS `Sub_Project_Id`,`calculation_tool_1`.`task`.`Task_Id` AS `Task_Id`,`calculation_tool_1`.`task`.`User_Id` AS `User_Id`,`calculation_tool_1`.`task`.`Task_Name` AS `Task_Name`,`calculation_tool_1`.`task`.`Work_Hours_Estimated` AS `Work_Hours_Estimated`,`calculation_tool_1`.`task`.`Comment` AS `Comment`,`calculation_tool_1`.`sub_project`.`Project_Id` AS `Project_Id`,`calculation_tool_1`.`sub_project`.`Sub_Project_Name` AS `Sub_Project_Name` from (`calculation_tool_1`.`task` join `calculation_tool_1`.`sub_project` on((`calculation_tool_1`.`task`.`Sub_Project_Id` = `calculation_tool_1`.`sub_project`.`Sub_Project_Id`))) where ((`calculation_tool_1`.`task`.`User_Id` = 1) and (`calculation_tool_1`.`sub_project`.`Project_Id` = 5));

-- -----------------------------------------------------
-- Create view `calculation_tool_1`.`userview1` where project_Id = 5
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calculation_tool_1`.`userview1`;
USE `calculation_tool_1`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `calculation_tool_1`.`userview1` AS select `calculation_tool_1`.`user`.`User_Id` AS `User_Id`,`calculation_tool_1`.`user`.`Name` AS `Name`,`calculation_tool_1`.`user`.`Email` AS `Email`,`calculation_tool_1`.`user`.`Username` AS `Username`,`calculation_tool_1`.`user`.`Password` AS `Password`,`calculation_tool_1`.`user`.`Phone_Number` AS `Phone_Number`,`calculation_tool_1`.`project_user`.`Project_Id` AS `Project_Id`,`calculation_tool_1`.`project_user`.`Role` AS `Role` from (`calculation_tool_1`.`user` join `calculation_tool_1`.`project_user` on((`calculation_tool_1`.`user`.`User_Id` = `calculation_tool_1`.`project_user`.`User_Id`))) where (`calculation_tool_1`.`project_user`.`Project_Id` = 5);
