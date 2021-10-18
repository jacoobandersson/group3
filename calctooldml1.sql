INSERT INTO user(`Name`, `Email`, `Username`, `Password`, `Phone_Number`) VALUES('John', 'John@mail.com', 'Johnusernamne', '1111', '112');
INSERT INTO user(`Name`, `Email`, `Username`, `Password`, `Phone_Number`) VALUES('Sofia', 'Sofia@mail.com', 'Sofiausernamne', '1111', '113');
INSERT INTO user(`Name`, `Email`, `Username`, `Password`, `Phone_Number`) VALUES('Martin', 'Martin@mail.com', 'Martinusernamne', '1111', '114');
INSERT INTO user(`Name`, `Email`, `Username`, `Password`, `Phone_Number`) VALUES('Agnete', 'Agnete@mail.com', 'Agneteusernamne', '1111', '115');
INSERT INTO user(`Name`, `Email`, `Username`, `Password`, `Phone_Number`) VALUES('Asbjorn', 'Asbjorn@mail.com', 'Asbjornusernamne', '1111', '116');
INSERT INTO user(`Name`, `Email`, `Username`, `Password`, `Phone_Number`) VALUES('Bjarke', 'Bjarke@mail.com', 'Bjarkeusernamne', '1111', '117');
INSERT INTO user(`Name`, `Email`, `Username`, `Password`, `Phone_Number`) VALUES('Ditte', 'Ditte@mail.com', 'Ditteusernamne', '1111', '118');
INSERT INTO user(`Name`, `Email`, `Username`, `Password`, `Phone_Number`) VALUES('Grete', 'Grete@mail.com', 'Greteusernamne', '1111', '119');
INSERT INTO user(`Name`, `Email`, `Username`, `Password`, `Phone_Number`) VALUES('Holger', 'Holger@mail.com', 'Holgerusernamne', '1111', '120');
INSERT INTO user(`Name`, `Email`, `Username`, `Password`, `Phone_Number`) VALUES('Jannik', 'Jannik@mail.com', 'Jannikusernamne', '1111', '121');
INSERT INTO user(`Name`, `Email`, `Username`, `Password`, `Phone_Number`) VALUES('Margit', 'Margit@mail.com', 'Margitusernamne', '1111', '122');
INSERT INTO user(`Name`, `Email`, `Username`, `Password`, `Phone_Number`) VALUES('Peder', 'Peder@mail.com', 'Pederusernamne', '1111', '123');
INSERT INTO user(`Name`, `Email`, `Username`, `Password`, `Phone_Number`) VALUES('Solvej', 'Solvej@mail.com', 'Solvejusernamne', '1111', '124');
INSERT INTO user(`Name`, `Email`, `Username`, `Password`, `Phone_Number`) VALUES('Ragna', 'Ragna@mail.com', 'Ragnajusernamne', '1111', '125');

INSERT INTO company(`Company_Name`, `Phone_Number`) VALUES('Bizniz', '911');
INSERT INTO company(`Company_Name`, `Phone_Number`) VALUES('Dunder Mifflin', '912');

INSERT INTO company_User(`User_Id`, `Company_Id`, `Role`) VALUES(3, 5, 'company manager');
INSERT INTO company_User(`User_Id`, `Company_Id`, `Role`) VALUES(4, 5, 'Systems Architect');
INSERT INTO company_User(`User_Id`, `Company_Id`, `Role`) VALUES(5, 5, 'Requirements specialist');
INSERT INTO company_User(`User_Id`, `Company_Id`, `Role`) VALUES(6, 5, 'UI expert');
INSERT INTO company_User(`User_Id`, `Company_Id`, `Role`) VALUES(7, 5, 'Full Stack Programmer');
INSERT INTO company_User(`User_Id`, `Company_Id`, `Role`) VALUES(8, 5, 'Full Stack Programmer');
INSERT INTO company_User(`User_Id`, `Company_Id`, `Role`) VALUES(9, 5, 'Backend expert');
INSERT INTO company_User(`User_Id`, `Company_Id`, `Role`) VALUES(10, 6, 'company manager');
INSERT INTO company_User(`User_Id`, `Company_Id`, `Role`) VALUES(11, 6, 'Full Stack Programmer');
INSERT INTO company_User(`User_Id`, `Company_Id`, `Role`) VALUES(12, 6, 'Full Stack Programmer');
INSERT INTO company_User(`User_Id`, `Company_Id`, `Role`) VALUES(13, 6, 'Requirements specialist');
INSERT INTO company_User(`User_Id`, `Company_Id`, `Role`) VALUES(14, 6, 'Systems Architect');
INSERT INTO company_User(`User_Id`, `Company_Id`, `Role`) VALUES(15, 6, 'Frontend programmer');
INSERT INTO company_User(`User_Id`, `Company_Id`, `Role`) VALUES(16, 6, 'UI expert');

INSERT INTO project(`Project_Name`, `Start_Date`, `End_Date`,`Company_Id`) VALUES('System for Ball Original', '2021-10-17', '2021-10-20', 5);
INSERT INTO project(`Project_Name`, `Start_Date`, `End_Date`,`Company_Id`)VALUES('System for Hafnia', '2021-10-10', '2021-10-16', 5);
INSERT INTO project(`Project_Name`, `Start_Date`, `End_Date`,`Company_Id`) VALUES('System for ordering paper online', '2021-10-15', '2021-10-31', 5);

INSERT INTO  project_user(`Project_Id`, `User_Id`, `Role`) VALUES(6, 3, 'company manager');
INSERT INTO  project_user(`Project_Id`, `User_Id`, `Role`) VALUES(6, 4, 'Systems Architect');
INSERT INTO  project_user(`Project_Id`, `User_Id`, `Role`) VALUES(6, 5, 'Requirements specialist');
INSERT INTO  project_user(`Project_Id`, `User_Id`, `Role`) VALUES(6, 6, 'UI expert');
INSERT INTO  project_user(`Project_Id`, `User_Id`, `Role`) VALUES(6, 7, 'Full Stack Programmer');
INSERT INTO  project_user(`Project_Id`, `User_Id`, `Role`) VALUES(7, 4, 'Systems Architect');
INSERT INTO  project_user(`Project_Id`, `User_Id`, `Role`) VALUES(7, 9, 'Backend expert');
INSERT INTO  project_user(`Project_Id`, `User_Id`, `Role`) VALUES(7, 7, 'Full Stack Programmer');
INSERT INTO  project_user(`Project_Id`, `User_Id`, `Role`) VALUES(8, 13, 'Requirements specialist');
INSERT INTO  project_user(`Project_Id`, `User_Id`, `Role`) VALUES(8, 14, 'Systems Architect');
INSERT INTO  project_user(`Project_Id`, `User_Id`, `Role`) VALUES(8, 16, 'UI expert');
INSERT INTO  project_user(`Project_Id`, `User_Id`, `Role`) VALUES(8, 15, 'Frontend programmer');
INSERT INTO  project_user(`Project_Id`, `User_Id`, `Role`) VALUES(8, 11, 'Full Stack programmer');
INSERT INTO  project_user(`Project_Id`, `User_Id`, `Role`) VALUES(8, 12, 'Full Stack programmer');

INSERT INTO sub_project(`Project_Id`, `Sub_Project_Name`) VALUES(6, 'Get it started'); 
INSERT INTO sub_project(`Project_Id`, `Sub_Project_Name`) VALUES(6, 'Create demo'); 
INSERT INTO sub_project(`Project_Id`, `Sub_Project_Name`) VALUES(7, 'Build backend'); 
INSERT INTO sub_project(`Project_Id`, `Sub_Project_Name`) VALUES(8, 'Specify requirements'); 
INSERT INTO sub_project(`Project_Id`, `Sub_Project_Name`) VALUES(8, 'Build backend'); 
INSERT INTO sub_project(`Project_Id`, `Sub_Project_Name`) VALUES(8, 'Build frontend'); 
INSERT INTO sub_project(`Project_Id`, `Sub_Project_Name`) VALUES(8, 'Build architecture'); 


INSERT INTO task(`Sub_Project_Id`, `User_Id`, `Task_Name`, `Work_Hours_Estimated`, `Comment`) VALUES(4, 3, 'supervise the beginning of project', 5, 'boring');
INSERT INTO task(`Sub_Project_Id`, `User_Id`, `Task_Name`, `Work_Hours_Estimated`, `Comment`) VALUES(5, 4, 'create the systems architecture', 12, 'difficult');
INSERT INTO task(`Sub_Project_Id`, `User_Id`, `Task_Name`, `Work_Hours_Estimated`, `Comment`) VALUES(4, 5, 'Write requirements and user stories', 9, 'important');
INSERT INTO task(`Sub_Project_Id`, `User_Id`, `Task_Name`, `Work_Hours_Estimated`, `Comment`) VALUES(5, 6, 'create UI', 8, 'mockups only');
INSERT INTO task(`Sub_Project_Id`, `User_Id`, `Task_Name`, `Work_Hours_Estimated`, `Comment`) VALUES(5, 7, 'create prototype', 20, 'prototype only');
INSERT INTO task(`Sub_Project_Id`, `User_Id`, `Task_Name`, `Work_Hours_Estimated`, `Comment`) VALUES(6, 4, 'create prototype backend structure', 20, 'prototype only');
INSERT INTO task(`Sub_Project_Id`, `User_Id`, `Task_Name`, `Work_Hours_Estimated`, `Comment`) VALUES(6, 4, 'create prototype backend functionality', 30, 'prototype only');
INSERT INTO task(`Sub_Project_Id`, `User_Id`, `Task_Name`, `Work_Hours_Estimated`, `Comment`) VALUES(7, 13, 'Gather requirements', 8, '');
INSERT INTO task(`Sub_Project_Id`, `User_Id`, `Task_Name`, `Work_Hours_Estimated`, `Comment`) VALUES(10, 14, 'Build system architecture', 30, '');
INSERT INTO task(`Sub_Project_Id`, `User_Id`, `Task_Name`, `Work_Hours_Estimated`, `Comment`) VALUES(8, 12, 'Build backend connection', 60, '');
INSERT INTO task(`Sub_Project_Id`, `User_Id`, `Task_Name`, `Work_Hours_Estimated`, `Comment`) VALUES(8, 11, 'Build backend database', 60, '');
INSERT INTO task(`Sub_Project_Id`, `User_Id`, `Task_Name`, `Work_Hours_Estimated`, `Comment`) VALUES(8, 16, 'Create mockups for UI', 20, '');
INSERT INTO task(`Sub_Project_Id`, `User_Id`, `Task_Name`, `Work_Hours_Estimated`, `Comment`) VALUES(8, 15, 'Build frontend connection', 20, '');
INSERT INTO task(`Sub_Project_Id`, `User_Id`, `Task_Name`, `Work_Hours_Estimated`, `Comment`) VALUES(8, 15, 'Build frontend UI', 40, '');


INSERT INTO task_time(`Task_Id`, `Day`, `Hours_Worked`, `Comment`, `Is_Finished`) VALUES(22, '2021-10-17', 3, 'almost considerd done', 0);
INSERT INTO task_time(`Task_Id`, `Day`, `Hours_Worked`, `Comment`, `Is_Finished`) VALUES(23, '2021-10-17', 8, 'needs a day more', 0);
INSERT INTO task_time(`Task_Id`, `Day`, `Hours_Worked`, `Comment`, `Is_Finished`) VALUES(24, '2021-10-18', 2, 'groundwork done', 0);
INSERT INTO task_time(`Task_Id`, `Day`, `Hours_Worked`, `Comment`, `Is_Finished`) VALUES(25, '2021-10-18', 6, 'needs acceptance from client', 0);
INSERT INTO task_time(`Task_Id`, `Day`, `Hours_Worked`, `Comment`, `Is_Finished`) VALUES(26, '2021-10-18', 5, '', 0);
INSERT INTO task_time(`Task_Id`, `Day`, `Hours_Worked`, `Comment`, `Is_Finished`) VALUES(27, '2021-10-11', 7, '', 0);
INSERT INTO task_time(`Task_Id`, `Day`, `Hours_Worked`, `Comment`, `Is_Finished`) VALUES(27, '2021-10-12', 5, '', 0);
INSERT INTO task_time(`Task_Id`, `Day`, `Hours_Worked`, `Comment`, `Is_Finished`) VALUES(27, '2021-10-13', 6, 'considerd done', 1);
INSERT INTO task_time(`Task_Id`, `Day`, `Hours_Worked`, `Comment`, `Is_Finished`) VALUES(28, '2021-10-14', 5, '', 0);
INSERT INTO task_time(`Task_Id`, `Day`, `Hours_Worked`, `Comment`, `Is_Finished`) VALUES(28, '2021-10-14', 5, '', 0);
INSERT INTO task_time(`Task_Id`, `Day`, `Hours_Worked`, `Comment`, `Is_Finished`) VALUES(28, '2021-10-15', 5, '', 0);
INSERT INTO task_time(`Task_Id`, `Day`, `Hours_Worked`, `Comment`, `Is_Finished`) VALUES(28, '2021-10-15', 5, '', 0);
INSERT INTO task_time(`Task_Id`, `Day`, `Hours_Worked`, `Comment`, `Is_Finished`) VALUES(28, '2021-10-16', 5, 'considered done', 1);
INSERT INTO task_time(`Task_Id`, `Day`, `Hours_Worked`, `Comment`, `Is_Finished`) VALUES(29, '2021-10-15', 8, 'considered done', 1);
INSERT INTO task_time(`Task_Id`, `Day`, `Hours_Worked`, `Comment`, `Is_Finished`) VALUES(30, '2021-10-17', 8, '', 0);





