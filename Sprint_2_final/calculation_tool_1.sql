-- MySQL Workbench Forward Engineering
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema calculation_tool_1
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema calculation_tool_1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `calculation_tool_1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `calculation_tool_1` ;

-- -----------------------------------------------------
-- Table `calculation_tool_1`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`user` (
  `User_Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Username` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Phone_Number` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`User_Id`),
  UNIQUE INDEX `Username_UNIQUE` (`Username` ASC) VISIBLE,
  UNIQUE INDEX `User_Id_UNIQUE` (`User_Id` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  INDEX `A` (`Name` ASC, `Email` ASC, `Username` ASC, `Password` ASC, `Phone_Number` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `calculation_tool_1`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`company` (
  `Company_Id` INT NOT NULL AUTO_INCREMENT,
  `Company_Name` VARCHAR(225) NOT NULL,
  `Phone_Number` VARCHAR(45) NOT NULL,
  `Contact_Person` INT NOT NULL,
  PRIMARY KEY (`Company_Id`),
  INDEX `A` (`Company_Name` ASC, `Phone_Number` ASC) VISIBLE,
  INDEX `Contact_Person_Id_idx` (`Contact_Person` ASC) VISIBLE,
  CONSTRAINT `Contact_Person_Id`
    FOREIGN KEY (`Contact_Person`)
    REFERENCES `calculation_tool_1`.`user` (`User_Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `calculation_tool_1`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`project` (
  `Project_Id` INT NOT NULL AUTO_INCREMENT,
  `Project_Name` VARCHAR(45) NOT NULL,
  `Start_Date` DATETIME NOT NULL,
  `Company_Id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Project_Id`, `Project_Name`),
  INDEX `A` (`Project_Name` ASC, `Start_Date` ASC) VISIBLE,
  INDEX `project_ibfk_1_idx` (`Company_Id` ASC) VISIBLE,
  CONSTRAINT `project_ibfk_1`
    FOREIGN KEY (`Company_Id`)
    REFERENCES `calculation_tool_1`.`company` (`Company_Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `calculation_tool_1`.`project_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`project_user` (
  `Project_Id` INT NOT NULL,
  `User_Id` INT NOT NULL,
  `Role` VARCHAR(45) NULL DEFAULT NULL,
  INDEX `Project_Id` (`Project_Id` ASC) VISIBLE,
  INDEX `User_Id` (`User_Id` ASC) VISIBLE,
  INDEX `A` (`Role` ASC) VISIBLE,
  CONSTRAINT `project_user_ibfk_1`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `calculation_tool_1`.`project` (`Project_Id`),
  CONSTRAINT `project_user_ibfk_2`
    FOREIGN KEY (`User_Id`)
    REFERENCES `calculation_tool_1`.`user` (`User_Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `calculation_tool_1`.`sub_project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`sub_project` (
  `Sub_Project_Id` INT NOT NULL AUTO_INCREMENT,
  `Project_Id` INT NOT NULL,
  `Sub_Project_Name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Sub_Project_Id`),
  INDEX `Project_Id` (`Project_Id` ASC) VISIBLE,
  CONSTRAINT `sub_project_ibfk_1`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `calculation_tool_1`.`project` (`Project_Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `calculation_tool_1`.`task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`task` (
  `Task_Id` INT NOT NULL AUTO_INCREMENT,
  `Sub_Project_Id` INT NOT NULL,
  `User_Id` INT NOT NULL,
  `Task_Name` VARCHAR(45) NOT NULL,
  `Work_Hours_Estimated` INT NOT NULL,
  `Comment` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`Task_Id`),
  INDEX `Sub_Project_Id` (`Sub_Project_Id` ASC) VISIBLE,
  INDEX `User_Id` (`User_Id` ASC) VISIBLE,
  INDEX `A` (`Work_Hours_Estimated` ASC, `Comment` ASC) VISIBLE,
  CONSTRAINT `task_ibfk_1`
    FOREIGN KEY (`Sub_Project_Id`)
    REFERENCES `calculation_tool_1`.`sub_project` (`Sub_Project_Id`),
  CONSTRAINT `task_ibfk_2`
    FOREIGN KEY (`User_Id`)
    REFERENCES `calculation_tool_1`.`user` (`User_Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `calculation_tool_1`.`task_time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`task_time` (
  `Task_Time_Id` INT NOT NULL AUTO_INCREMENT,
  `Task_Id` INT NOT NULL,
  `Day` DATE NULL DEFAULT NULL,
  `Hours_Worked` VARCHAR(45) NULL DEFAULT NULL,
  `Comment` TEXT NULL DEFAULT NULL,
  `Is_Finished` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Task_Time_Id`),
  INDEX `Task_Id_idx` (`Task_Id` ASC) VISIBLE,
  CONSTRAINT `Task_Id`
    FOREIGN KEY (`Task_Id`)
    REFERENCES `calculation_tool_1`.`task` (`Task_Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `calculation_tool_1` ;

-- -----------------------------------------------------
-- Placeholder table for view `calculation_tool_1`.`areaview1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`areaview1` (`Project_Id` INT, `Project_Name` INT, `Start_Date` INT, `Company_Id` INT, `User_Id` INT, `Role` INT);

-- -----------------------------------------------------
-- Placeholder table for view `calculation_tool_1`.`areaview2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`areaview2` (`User_Id` INT, `Project_Id` INT, `Project_Name` INT, `Start_Date` INT, `Company_Id` INT, `Role` INT, `Name` INT, `Email` INT, `Username` INT, `Password` INT, `Phone_Number` INT);

-- -----------------------------------------------------
-- Placeholder table for view `calculation_tool_1`.`subview1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`subview1` (`Project_Id` INT, `Sub_Project_Id` INT, `Sub_Project_Name` INT, `User_Id` INT, `Role` INT);

-- -----------------------------------------------------
-- Placeholder table for view `calculation_tool_1`.`subview2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`subview2` (`Project_Id` INT, `Sub_Project_Id` INT, `Sub_Project_Name` INT, `User_Id` INT, `Role` INT, `Project_Name` INT, `Start_Date` INT, `Company_Id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `calculation_tool_1`.`taskview1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`taskview1` (`Sub_Project_Id` INT, `Task_Id` INT, `User_Id` INT, `Task_Name` INT, `Work_Hours_Estimated` INT, `Comment` INT, `Project_Id` INT, `Sub_Project_Name` INT);

-- -----------------------------------------------------
-- Placeholder table for view `calculation_tool_1`.`userview1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`userview1` (`User_Id` INT, `Name` INT, `Email` INT, `Username` INT, `Password` INT, `Phone_Number` INT, `Project_Id` INT, `Role` INT);

-- -----------------------------------------------------
-- View `calculation_tool_1`.`areaview1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calculation_tool_1`.`areaview1`;
USE `calculation_tool_1`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `calculation_tool_1`.`areaview1` AS select `calculation_tool_1`.`project`.`Project_Id` AS `Project_Id`,`calculation_tool_1`.`project`.`Project_Name` AS `Project_Name`,`calculation_tool_1`.`project`.`Start_Date` AS `Start_Date`,`calculation_tool_1`.`project`.`Company_Id` AS `Company_Id`,`calculation_tool_1`.`project_user`.`User_Id` AS `User_Id`,`calculation_tool_1`.`project_user`.`Role` AS `Role` from (`calculation_tool_1`.`project` join `calculation_tool_1`.`project_user` on((`calculation_tool_1`.`project`.`Project_Id` = `calculation_tool_1`.`project_user`.`Project_Id`))) where (`calculation_tool_1`.`project_user`.`User_Id` = 1);

-- -----------------------------------------------------
-- View `calculation_tool_1`.`areaview2`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calculation_tool_1`.`areaview2`;
USE `calculation_tool_1`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `calculation_tool_1`.`areaview2` AS select `calculation_tool_1`.`areaview1`.`User_Id` AS `User_Id`,`calculation_tool_1`.`areaview1`.`Project_Id` AS `Project_Id`,`calculation_tool_1`.`areaview1`.`Project_Name` AS `Project_Name`,`calculation_tool_1`.`areaview1`.`Start_Date` AS `Start_Date`,`calculation_tool_1`.`areaview1`.`Company_Id` AS `Company_Id`,`calculation_tool_1`.`areaview1`.`Role` AS `Role`,`calculation_tool_1`.`user`.`Name` AS `Name`,`calculation_tool_1`.`user`.`Email` AS `Email`,`calculation_tool_1`.`user`.`Username` AS `Username`,`calculation_tool_1`.`user`.`Password` AS `Password`,`calculation_tool_1`.`user`.`Phone_Number` AS `Phone_Number` from (`calculation_tool_1`.`areaview1` join `calculation_tool_1`.`user` on((`calculation_tool_1`.`areaview1`.`User_Id` = `calculation_tool_1`.`user`.`User_Id`))) where (`calculation_tool_1`.`areaview1`.`User_Id` = 1);

-- -----------------------------------------------------
-- View `calculation_tool_1`.`subview1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calculation_tool_1`.`subview1`;
USE `calculation_tool_1`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `calculation_tool_1`.`subview1` AS select `calculation_tool_1`.`sub_project`.`Project_Id` AS `Project_Id`,`calculation_tool_1`.`sub_project`.`Sub_Project_Id` AS `Sub_Project_Id`,`calculation_tool_1`.`sub_project`.`Sub_Project_Name` AS `Sub_Project_Name`,`calculation_tool_1`.`project_user`.`User_Id` AS `User_Id`,`calculation_tool_1`.`project_user`.`Role` AS `Role` from (`calculation_tool_1`.`sub_project` join `calculation_tool_1`.`project_user` on((`calculation_tool_1`.`sub_project`.`Project_Id` = `calculation_tool_1`.`project_user`.`Project_Id`))) where ((`calculation_tool_1`.`project_user`.`User_Id` = 1) and (`calculation_tool_1`.`sub_project`.`Project_Id` = 4));

-- -----------------------------------------------------
-- View `calculation_tool_1`.`subview2`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calculation_tool_1`.`subview2`;
USE `calculation_tool_1`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `calculation_tool_1`.`subview2` AS select `calculation_tool_1`.`subview1`.`Project_Id` AS `Project_Id`,`calculation_tool_1`.`subview1`.`Sub_Project_Id` AS `Sub_Project_Id`,`calculation_tool_1`.`subview1`.`Sub_Project_Name` AS `Sub_Project_Name`,`calculation_tool_1`.`subview1`.`User_Id` AS `User_Id`,`calculation_tool_1`.`subview1`.`Role` AS `Role`,`calculation_tool_1`.`project`.`Project_Name` AS `Project_Name`,`calculation_tool_1`.`project`.`Start_Date` AS `Start_Date`,`calculation_tool_1`.`project`.`Company_Id` AS `Company_Id` from (`calculation_tool_1`.`subview1` join `calculation_tool_1`.`project` on((`calculation_tool_1`.`subview1`.`Project_Id` = `calculation_tool_1`.`project`.`Project_Id`))) where (`calculation_tool_1`.`subview1`.`User_Id` = 1);

-- -----------------------------------------------------
-- View `calculation_tool_1`.`taskview1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calculation_tool_1`.`taskview1`;
USE `calculation_tool_1`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `calculation_tool_1`.`taskview1` AS select `calculation_tool_1`.`task`.`Sub_Project_Id` AS `Sub_Project_Id`,`calculation_tool_1`.`task`.`Task_Id` AS `Task_Id`,`calculation_tool_1`.`task`.`User_Id` AS `User_Id`,`calculation_tool_1`.`task`.`Task_Name` AS `Task_Name`,`calculation_tool_1`.`task`.`Work_Hours_Estimated` AS `Work_Hours_Estimated`,`calculation_tool_1`.`task`.`Comment` AS `Comment`,`calculation_tool_1`.`sub_project`.`Project_Id` AS `Project_Id`,`calculation_tool_1`.`sub_project`.`Sub_Project_Name` AS `Sub_Project_Name` from (`calculation_tool_1`.`task` join `calculation_tool_1`.`sub_project` on((`calculation_tool_1`.`task`.`Sub_Project_Id` = `calculation_tool_1`.`sub_project`.`Sub_Project_Id`))) where ((`calculation_tool_1`.`task`.`User_Id` = 1) and (`calculation_tool_1`.`sub_project`.`Project_Id` = 5));

-- -----------------------------------------------------
-- View `calculation_tool_1`.`userview1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `calculation_tool_1`.`userview1`;
USE `calculation_tool_1`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `calculation_tool_1`.`userview1` AS select `calculation_tool_1`.`user`.`User_Id` AS `User_Id`,`calculation_tool_1`.`user`.`Name` AS `Name`,`calculation_tool_1`.`user`.`Email` AS `Email`,`calculation_tool_1`.`user`.`Username` AS `Username`,`calculation_tool_1`.`user`.`Password` AS `Password`,`calculation_tool_1`.`user`.`Phone_Number` AS `Phone_Number`,`calculation_tool_1`.`project_user`.`Project_Id` AS `Project_Id`,`calculation_tool_1`.`project_user`.`Role` AS `Role` from (`calculation_tool_1`.`user` join `calculation_tool_1`.`project_user` on((`calculation_tool_1`.`user`.`User_Id` = `calculation_tool_1`.`project_user`.`User_Id`))) where (`calculation_tool_1`.`project_user`.`Project_Id` = 5);
