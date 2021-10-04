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
  INDEX `A` (`Name` ASC, `Email` ASC, `Username` ASC, `Password` ASC, `Phone_Number` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `calculation_tool_1`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`company` (
  `Company_Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(225) NOT NULL,
  `Phone_Number` VARCHAR(45) NOT NULL,
  `Contact_Person` INT NOT NULL,
  PRIMARY KEY (`Company_Id`),
  INDEX `A` (`Name` ASC, `Phone_Number` ASC) VISIBLE,
  INDEX `Contact_Person_Id_idx` (`Contact_Person` ASC) VISIBLE,
  CONSTRAINT `Contact_Person_Id`
    FOREIGN KEY (`Contact_Person`)
    REFERENCES `calculation_tool_1`.`user` (`User_Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `calculation_tool_1`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`project` (
  `Project_Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Start_Date` DATETIME NOT NULL,
  `Company_Id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Project_Id`, `Name`),
  INDEX `A` (`Name` ASC, `Start_Date` ASC) VISIBLE,
  INDEX `project_ibfk_1_idx` (`Company_Id` ASC) VISIBLE,
  CONSTRAINT `project_ibfk_1`
    FOREIGN KEY (`Company_Id`)
    REFERENCES `calculation_tool_1`.`company` (`Company_Id`))
ENGINE = InnoDB
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
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Sub_Project_Id`),
  INDEX `Project_Id` (`Project_Id` ASC) VISIBLE,
  CONSTRAINT `sub_project_ibfk_1`
    FOREIGN KEY (`Project_Id`)
    REFERENCES `calculation_tool_1`.`project` (`Project_Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `calculation_tool_1`.`task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`task` (
  `Task_Id` INT NOT NULL AUTO_INCREMENT,
  `Sub_Project_Id` INT NOT NULL,
  `User_Id` INT NOT NULL,
  `Work_Hours_Estimated` DECIMAL(10,2) NOT NULL,
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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `calculation_tool_1`.`Task_time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calculation_tool_1`.`Task_time` (
  `Task_Time_Id` INT NOT NULL AUTO_INCREMENT,
  `Task_Id` INT NOT NULL,
  `Day` DATE NULL,
  `Hours_Worked` VARCHAR(45) NULL,
  `Comment` TEXT(2000) NULL,
  PRIMARY KEY (`Task_Time_Id`),
  INDEX `Task_Id_idx` (`Task_Id` ASC) VISIBLE,
  CONSTRAINT `Task_Id`
    FOREIGN KEY (`Task_Id`)
    REFERENCES `calculation_tool_1`.`task` (`Task_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
