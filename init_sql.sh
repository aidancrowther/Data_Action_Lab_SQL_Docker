#!/bin/bash

#Init mysql
nohup mysqld &

sleep 10

#Grant SQL access to external users
echo "Updating mysql configs in /etc/mysql/my.cnf."
sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
echo "Updated mysql bind address in /etc/mysql/my.cnf to 0.0.0.0 to allow external connections."
service mysql stop
service mysql start

sleep 10

#Create SQL read only user
mysql -e "CREATE DATABASE school"
mysql -e "CREATE USER 'Ruser'@'%' IDENTIFIED BY 'Ruser'";
mysql -e "GRANT SELECT, SHOW VIEW ON *.* TO 'Ruser'@'%'";
mysql -e "FLUSH PRIVILEGES";

#Init professor table
mysql -e "CREATE TABLE school.Professors ( NAME varchar(255) NOT NULL, SALARY int, FACULTY_ID int NOT NULL AUTO_INCREMENT, AGE int, FACULTY varchar(255), PRIMARY KEY (FACULTY_ID) )"
mysql -e "INSERT INTO school.Professors VALUES ( 'Adam Smith', 90000, 1, 67, 'Economics' )"
mysql -e "INSERT INTO school.Professors VALUES ( 'Paige Ryans', 180000, 2, 48, 'Physics' )"
mysql -e "INSERT INTO school.Professors VALUES ( 'Alex Doe', 190000, 3, 37, NULL )"
mysql -e "INSERT INTO school.Professors VALUES ( 'Landon Liu', 120000, 4, 34, 'Cognitive Science' )"
mysql -e "INSERT INTO school.Professors VALUES ( 'Marcel Orosz', NULL, 5, 48, NULL )"
mysql -e "INSERT INTO school.Professors VALUES ( 'Kyra Carmichael', 200000, 6, 30, 'Business' )"
mysql -e "INSERT INTO school.Professors VALUES ( 'Heather Wong', 200000, 7, 34, 'Economics' )"
mysql -e "INSERT INTO school.Professors VALUES ( 'Quine Ngyogne', 115000, 8, 55, 'Chemistry' )"
mysql -e "INSERT INTO school.Professors VALUES ( 'Vikram  Das', 500000, 9, 60, 'Computer Science' )"
mysql -e "INSERT INTO school.Professors VALUES ( 'Samuel Koffi', 300000, 10, 40, 'Political Science' )"

#Init course table
mysql -e "CREATE TABLE school.Courses ( COURSE varchar(255), FULL bool, Semester varchar(255), FACULTY_ID int, PRIMARY KEY (COURSE), FOREIGN KEY (FACULTY_ID) REFERENCES school.Professors(FACULTY_ID) )"
mysql -e "INSERT INTO school.Courses VALUES ( 'ECON101', true, 'FALL', 1 )"
mysql -e "INSERT INTO school.Courses VALUES ( 'PHYS201', false, 'WINTER', 2 )"
mysql -e "INSERT INTO school.Courses VALUES ( 'ECON401', false, 'WINTER', 1 )"
mysql -e "INSERT INTO school.Courses VALUES ( 'MUSI101', false, 'SUMMER', NULL )"
mysql -e "INSERT INTO school.Courses VALUES ( 'CGSC101', true, 'SUMMER', 4 )"
mysql -e "INSERT INTO school.Courses VALUES ( 'BUSI202', true, 'SUMMER', 6 )"
mysql -e "INSERT INTO school.Courses VALUES ( 'CHEM404', false, 'WINTER', 8)"
mysql -e "INSERT INTO school.Courses VALUES ( 'COMP490', true, 'FALL', 9)"
mysql -e "INSERT INTO school.Courses VALUES ( 'CGSC202', true, 'WINTER', 4)"

#Init student table
mysql -e "CREATE TABLE school.Students ( NAME varchar(255), GENDER varchar(255), AGE int, STUDENT_ID int, FACULTY varchar(255), PRIMARY KEY (STUDENT_ID) )"
mysql -e "INSERT INTO school.Students VALUES ('Aidan Crowther', 'Male', 20, 100, 'Cognitive Science' )"
mysql -e "INSERT INTO school.Students VALUES ('Esha Vasquez', 'Female', 19, 101, 'Economics' )"
mysql -e "INSERT INTO school.Students VALUES ('Fabian Tate', 'Non-Binary', 21, 102, 'Business' )"
mysql -e "INSERT INTO school.Students VALUES ('Haaris Lucas', 'Male', 19, 103, 'Cognitive Science' )"
mysql -e "INSERT INTO school.Students VALUES ('Danny Mcintosh', 'Female', 20, 104, 'Chemisty' )"
mysql -e "INSERT INTO school.Students VALUES ('Aaryan Combs', 'Male', 20, 105, NULL )"
mysql -e "INSERT INTO school.Students VALUES ('Anton Krueger', 'Male', 21, 106, 'Physics' )"

#Init registration table
mysql -e "CREATE TABLE school.Registrations ( STUDENT_ID int, COURSE varchar(255), GRADE float(4, 2), STATUS varchar(255), FOREIGN KEY (STUDENT_ID) REFERENCES school.Students(STUDENT_ID), FOREIGN KEY (COURSE) REFERENCES school.Courses(COURSE) )"
mysql -e "INSERT INTO school.Registrations VALUES ( 100, 'ECON401', NULL, 'Registered' )"
mysql -e "INSERT INTO school.Registrations VALUES ( 100, 'ECON101', 10.00, 'Passed' )"
mysql -e "INSERT INTO school.Registrations VALUES ( 101, 'ECON101', 2.45, 'Failed' )"
mysql -e "INSERT INTO school.Registrations VALUES ( 102, 'BUSI202', NULL, 'Registered' )"
mysql -e "INSERT INTO school.Registrations VALUES ( 102, 'ECON101', NULL, 'DNF' )"
mysql -e "INSERT INTO school.Registrations VALUES ( 104, 'CHEM404', NULL, 'Registered' )"
mysql -e "INSERT INTO school.Registrations VALUES ( 104, 'COMP490', 9.80, 'Passed' )"
mysql -e "INSERT INTO school.Registrations VALUES ( 101, 'BUSI202', 3.52, 'Failed' )"
