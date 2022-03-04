--  
-- Workshop SQL 2022
--  
-- Authors: 
--   Nuno Antunes <nmsa@dei.uc.pt>
--   José Flora <jeflora@dei.uc.pt>
--   University of Coimbra
--  
-- Data from: 
--	 	Abraham Silberschatz, Henry F. Korth and S. Sudarshan, 
-- 		“Database System Concepts”, McGraw-Hill Education, Seventh Edition, 2019.
--
--


-- Drop tables if already exist (created before)

drop table if exists time_slot;

drop table if exists prereq;

drop table if exists advisor;

drop table if exists takes;

drop table if exists student;

drop table if exists teaches;

drop table if exists section;

drop table if exists instructor;

drop table if exists course;

drop table if exists department;

drop table if exists classroom;



-- Create tables

create table classroom
	(building varchar (15),
	 room_number varchar (7),
	 capacity numeric (4,0),
	 primary key (building, room_number));

create table department
	(dept_name varchar (20),
	 building varchar (15),
	 budget numeric (12,2) check (budget > 0),
	 primary key (dept_name));

create table course
	(course_id varchar (7),
	 title varchar (50),
	 dept_name varchar (20),
	 credits numeric (2,0) check (credits > 0),
	 primary key (course_id),
	 foreign key (dept_name) references department
	 		on delete set null);

create table instructor
	(ID varchar (5),
	 name varchar (20) not null,
	 dept_name varchar (20),
	 salary numeric (8,2) check (salary > 29000),
	 primary key (ID),
	 foreign key (dept_name) references department
	 		on delete set null);

create table section
	(course_id varchar (8),
	 sec_id varchar (8),
	 semester varchar (6) check (semester in ('Fall', 'Winter', 'Spring', 'Summer')),
	 year numeric (4,0) check (year > 1701 and year < 2100),
	 building varchar (15),
	 room_number varchar (7),
	 time_slot_id varchar (4),
	 primary key (course_id, sec_id, semester, year),
	 foreign key (course_id) references course
	 		on delete cascade,
	 foreign key (building, room_number) references classroom
	 		on delete set null);

create table teaches
	(ID varchar (5),
	 course_id varchar (8),
	 sec_id varchar (8),
	 semester varchar (6),
	 year numeric (4,0),
	 primary key (ID, course_id, sec_id, semester, year),
	 foreign key (course_id, sec_id, semester, year) references section
	 		on delete cascade,
	 foreign key (ID) references instructor
	 		on delete cascade);

create table student
	(ID varchar (5),
	 name varchar (20) not null,
	 dept_name varchar (20),
	 tot_cred numeric (3,0) check (tot_cred >= 0),
	 primary key (ID),
	 foreign key (dept_name) references department
	 		on delete set null);

create table takes
	(ID varchar (5),
	 course_id varchar (8),
	 sec_id varchar (8),
	 semester varchar (6),
	 year numeric (4,0),
	 grade varchar (2),
	 primary key (ID, course_id, sec_id, semester, year),
	 foreign key (course_id, sec_id, semester, year) references section
	 		on delete cascade,
	 foreign key (ID) references student
	 		on delete cascade);

create table advisor
	(s_ID varchar (5),
	 i_ID varchar (5),
	 primary key (s_ID),
	 foreign key (i_ID) references instructor (ID)
	 		on delete set null,
	 foreign key (s_ID) references student (ID)
	 		on delete cascade);

create table prereq
	(course_id varchar(8),
	 prereq_id varchar(8),
	 primary key (course_id, prereq_id),
	 foreign key (course_id) references course
	 		on delete cascade,
	 foreign key (prereq_id) references course);

create table time_slot
	(time_slot_id varchar (4),
	 day varchar (1) check (day in ('M', 'T', 'W', 'R', 'F', 'S', 'U')),
	 start_time time,
	 end_time time,
	 primary key (time_slot_id, day, start_time));



-- classroom

insert into classroom(building, room_number, capacity) values ('Packard','101',500);
insert into classroom(building, room_number, capacity) values ('Painter','514',10);
insert into classroom(building, room_number, capacity) values ('Taylor','3128',70);
insert into classroom(building, room_number, capacity) values ('Watson','100',30);
insert into classroom(building, room_number, capacity) values ('Watson','120',50);

-- department

insert into department(dept_name, building, budget) values('Biology', 'Watson', 90000);
insert into department(dept_name, building, budget) values('Comp. Sci.', 'Taylor', 100000);
insert into department(dept_name, building, budget) values('Elec. Eng.', 'Taylor', 85000);
insert into department(dept_name, building, budget) values('Finance', 'Painter', 120000);
insert into department(dept_name, building, budget) values('History', 'Painter', 50000);
insert into department(dept_name, building, budget) values('Music', 'Packard', 80000);
insert into department(dept_name, building, budget) values('Physics', 'Watson', 70000);

-- course

insert into course(course_id, title, dept_name, credits) values ('BIO-101', 'Intro. to Biology', 'Biology', 4);
insert into course(course_id, title, dept_name, credits) values ('BIO-301', 'Genetics', 'Biology', 4);
insert into course(course_id, title, dept_name, credits) values ('BIO-399', 'Computational Biology', 'Biology', 3);
insert into course(course_id, title, dept_name, credits) values ('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', 4);
insert into course(course_id, title, dept_name, credits) values ('CS-190', 'Game Design', 'Comp. Sci.', 4);
insert into course(course_id, title, dept_name, credits) values ('CS-315', 'Robotics', 'Comp. Sci.', 3);
insert into course(course_id, title, dept_name, credits) values ('CS-319', 'Image Processing', 'Comp. Sci.', 3);
insert into course(course_id, title, dept_name, credits) values ('CS-347', 'Database System Concepts', 'Comp. Sci.', 3);
insert into course(course_id, title, dept_name, credits) values ('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', 3);
insert into course(course_id, title, dept_name, credits) values ('FIN-201', 'Investment Banking', 'Finance', 3);
insert into course(course_id, title, dept_name, credits) values ('HIS-351', 'World History', 'History', 3);
insert into course(course_id, title, dept_name, credits) values ('MU-199', 'Music Video Production', 'Music', 3);
insert into course(course_id, title, dept_name, credits) values ('PHY-101', 'Physical Principles', 'Physics', 4);

-- instructor

insert into instructor(ID, name, dept_name, salary) values('10101', 'Srinivasan', 'Comp. Sci.', 65000);
insert into instructor(ID, name, dept_name, salary) values('12121', 'Wu', 'Finance', 90000);
insert into instructor(ID, name, dept_name, salary) values('15151', 'Mozart', 'Music', 40000);
insert into instructor(ID, name, dept_name, salary) values('22222', 'Einstein', 'Physics', 95000);
insert into instructor(ID, name, dept_name, salary) values('32343', 'El Said', 'History', 60000);
insert into instructor(ID, name, dept_name, salary) values('33456', 'Gold', 'Physics', 87000);
insert into instructor(ID, name, dept_name, salary) values('45565', 'Katz', 'Comp. Sci.', 75000);
insert into instructor(ID, name, dept_name, salary) values('58583', 'Califieri', 'History', 62000);
insert into instructor(ID, name, dept_name, salary) values('76543', 'Singh', 'Finance', 80000);
insert into instructor(ID, name, dept_name, salary) values('76766', 'Crick', 'Biology', 72000);
insert into instructor(ID, name, dept_name, salary) values('83821', 'Brandt', 'Comp. Sci.', 92000);
insert into instructor(ID, name, dept_name, salary) values('98345', 'Kim', 'Elec. Eng.', 80000);

-- section

insert into section(course_id, sec_id, semester, year, building, room_number, time_slot_id) values('BIO-101', '1', 'Summer', 2017, 'Painter', '514', 'B');
insert into section(course_id, sec_id, semester, year, building, room_number, time_slot_id) values('BIO-301', '1', 'Summer', 2018, 'Painter', '514', 'A');
insert into section(course_id, sec_id, semester, year, building, room_number, time_slot_id) values('CS-101', '1', 'Fall', 2017, 'Packard', '101', 'H');
insert into section(course_id, sec_id, semester, year, building, room_number, time_slot_id) values('CS-101', '1', 'Spring', 2018, 'Packard', '101', 'F');
insert into section(course_id, sec_id, semester, year, building, room_number, time_slot_id) values('CS-190', '1', 'Spring', 2017, 'Taylor', '3128', 'E');
insert into section(course_id, sec_id, semester, year, building, room_number, time_slot_id) values('CS-190', '2', 'Spring', 2017, 'Taylor', '3128', 'A');
insert into section(course_id, sec_id, semester, year, building, room_number, time_slot_id) values('CS-315', '1', 'Spring', 2018, 'Watson', '120', 'D');
insert into section(course_id, sec_id, semester, year, building, room_number, time_slot_id) values('CS-319', '1', 'Spring', 2018, 'Watson', '100', 'B');
insert into section(course_id, sec_id, semester, year, building, room_number, time_slot_id) values('CS-319', '2', 'Spring', 2018, 'Taylor', '3128', 'C');
insert into section(course_id, sec_id, semester, year, building, room_number, time_slot_id) values('CS-347', '1', 'Fall', 2017, 'Taylor', '3128', 'A');
insert into section(course_id, sec_id, semester, year, building, room_number, time_slot_id) values('EE-181', '1', 'Spring', 2017, 'Taylor', '3128', 'C');
insert into section(course_id, sec_id, semester, year, building, room_number, time_slot_id) values('FIN-201', '1', 'Spring', 2018, 'Packard', '101', 'B');
insert into section(course_id, sec_id, semester, year, building, room_number, time_slot_id) values('HIS-351', '1', 'Spring', 2018, 'Painter', '514', 'C');
insert into section(course_id, sec_id, semester, year, building, room_number, time_slot_id) values('MU-199', '1', 'Spring', 2018, 'Packard', '101', 'D');
insert into section(course_id, sec_id, semester, year, building, room_number, time_slot_id) values('PHY-101', '1', 'Fall', 2017, 'Watson', '100', 'A');

-- teaches

insert into teaches(ID, course_id, sec_id, semester, year) values('10101', 'CS-101', '1', 'Fall', 2017);
insert into teaches(ID, course_id, sec_id, semester, year) values('10101', 'CS-315', '1', 'Spring', 2018);
insert into teaches(ID, course_id, sec_id, semester, year) values('10101', 'CS-347', '1', 'Fall', 2017);
insert into teaches(ID, course_id, sec_id, semester, year) values('12121', 'FIN-201', '1', 'Spring', 2018);
insert into teaches(ID, course_id, sec_id, semester, year) values('15151', 'MU-199', '1', 'Spring', 2018);
insert into teaches(ID, course_id, sec_id, semester, year) values('22222', 'PHY-101', '1', 'Fall', 2017);
insert into teaches(ID, course_id, sec_id, semester, year) values('32343', 'HIS-351', '1', 'Spring', 2018);
insert into teaches(ID, course_id, sec_id, semester, year) values('45565', 'CS-101', '1', 'Spring', 2018);
insert into teaches(ID, course_id, sec_id, semester, year) values('45565', 'CS-319', '1', 'Spring', 2018);
insert into teaches(ID, course_id, sec_id, semester, year) values('76766', 'BIO-101', '1', 'Summer', 2017);
insert into teaches(ID, course_id, sec_id, semester, year) values('76766', 'BIO-301', '1', 'Summer', 2018);
insert into teaches(ID, course_id, sec_id, semester, year) values('83821', 'CS-190', '1', 'Spring', 2017);
insert into teaches(ID, course_id, sec_id, semester, year) values('83821', 'CS-190', '2', 'Spring', 2017);
insert into teaches(ID, course_id, sec_id, semester, year) values('83821', 'CS-319', '2', 'Spring', 2018);
insert into teaches(ID, course_id, sec_id, semester, year) values('98345', 'EE-181', '1', 'Spring', 2017);

-- student

insert into student(ID, name, dept_name, tot_cred) values ('00128', 'Zhang', 'Comp. Sci.', 102);
insert into student(ID, name, dept_name, tot_cred) values ('12345', 'Shankar', 'Comp. Sci.', 32);
insert into student(ID, name, dept_name, tot_cred) values ('19991', 'Brandt', 'History', 80);
insert into student(ID, name, dept_name, tot_cred) values ('23121', 'Chavez', 'Finance', 110);
insert into student(ID, name, dept_name, tot_cred) values ('44553', 'Peltier', 'Physics', 56);
insert into student(ID, name, dept_name, tot_cred) values ('45678', 'Levy', 'Physics', 46);
insert into student(ID, name, dept_name, tot_cred) values ('54321', 'Williams', 'Comp. Sci.', 54);
insert into student(ID, name, dept_name, tot_cred) values ('55739', 'Sanchez', 'Music', 38);
insert into student(ID, name, dept_name, tot_cred) values ('70557', 'Snow', 'Physics', 0);
insert into student(ID, name, dept_name, tot_cred) values ('76543', 'Brown', 'Comp. Sci.', 58);
insert into student(ID, name, dept_name, tot_cred) values ('76653', 'Aoi', 'Elec. Eng.', 60);
insert into student(ID, name, dept_name, tot_cred) values ('98765', 'Bourikas', 'Elec. Eng.', 98);
insert into student(ID, name, dept_name, tot_cred) values ('98988', 'Tanaka', 'Biology', 120);

-- takes

insert into takes(ID, course_id, sec_id, semester, year, grade) values('00128', 'CS-101', '1', 'Fall', 2017, 'A');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('00128', 'CS-347', '1', 'Fall', 2017, 'A-');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('12345', 'CS-101', '1', 'Fall', 2017, 'C');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('12345', 'CS-190', '2', 'Spring', 2017, 'A');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('12345', 'CS-315', '1', 'Spring', 2018, 'A');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('12345', 'CS-347', '1', 'Fall', 2017, 'A');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('19991', 'HIS-351', '1', 'Spring', 2018, 'B');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('23121', 'FIN-201', '1', 'Spring', 2018, 'C+');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('44553', 'PHY-101', '1', 'Fall', 2017, 'B-');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('45678', 'CS-101', '1', 'Fall', 2017, 'F');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('45678', 'CS-101', '1', 'Spring', 2018, 'B+');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('45678', 'CS-319', '1', 'Spring', 2018, 'B');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('54321', 'CS-101', '1', 'Fall', 2017, 'A-');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('54321', 'CS-190', '2', 'Spring', 2017, 'B+');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('55739', 'MU-199', '1', 'Spring', 2018, 'A-');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('76543', 'CS-101', '1', 'Fall', 2017, 'A');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('76543', 'CS-319', '2', 'Spring', 2018, 'A');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('76653', 'EE-181', '1', 'Spring', 2017, 'C');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('98765', 'CS-101', '1', 'Fall', 2017, 'C-');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('98765', 'CS-315', '1', 'Spring', 2018, 'B');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('98988', 'BIO-101', '1', 'Summer', 2017, 'A');
insert into takes(ID, course_id, sec_id, semester, year, grade) values('98988', 'BIO-301', '1', 'Summer', 2018, null);

-- advisor

insert into advisor(s_id, i_id) values('00128', '45565');
insert into advisor(s_id, i_id) values('12345', '10101');
insert into advisor(s_id, i_id) values('23121', '76543');
insert into advisor(s_id, i_id) values('44553', '22222');
insert into advisor(s_id, i_id) values('45678', '22222');
insert into advisor(s_id, i_id) values('76543', '45565');
insert into advisor(s_id, i_id) values('76653', '98345');
insert into advisor(s_id, i_id) values('98765', '98345');
insert into advisor(s_id, i_id) values('98988', '76766');

-- time_slot

insert into time_slot(time_slot_id, day, start_time, end_time) values('A', 'M', '8:00', '8:50');
insert into time_slot(time_slot_id, day, start_time, end_time) values('A', 'W', '8:00', '8:50');
insert into time_slot(time_slot_id, day, start_time, end_time) values('A', 'F', '8:00', '8:50');
insert into time_slot(time_slot_id, day, start_time, end_time) values('B', 'M', '9:00', '9:50');
insert into time_slot(time_slot_id, day, start_time, end_time) values('B', 'W', '9:00', '9:50');
insert into time_slot(time_slot_id, day, start_time, end_time) values('B', 'F', '9:00', '9:50');
insert into time_slot(time_slot_id, day, start_time, end_time) values('C', 'M', '11:00', '11:50');
insert into time_slot(time_slot_id, day, start_time, end_time) values('C', 'W', '11:00', '11:50');
insert into time_slot(time_slot_id, day, start_time, end_time) values('C', 'F', '11:00', '11:50');
insert into time_slot(time_slot_id, day, start_time, end_time) values('D', 'M', '13:00', '13:50');
insert into time_slot(time_slot_id, day, start_time, end_time) values('D', 'W', '13:00', '13:50');
insert into time_slot(time_slot_id, day, start_time, end_time) values('D', 'F', '13:00', '13:50');
insert into time_slot(time_slot_id, day, start_time, end_time) values('E', 'T', '10:30', '11:45');
insert into time_slot(time_slot_id, day, start_time, end_time) values('E', 'R', '10:30', '11:45');
insert into time_slot(time_slot_id, day, start_time, end_time) values('F', 'T', '14:30', '15:45');
insert into time_slot(time_slot_id, day, start_time, end_time) values('F', 'R', '14:30', '15:45');
insert into time_slot(time_slot_id, day, start_time, end_time) values('G', 'M', '16:00', '16:50');
insert into time_slot(time_slot_id, day, start_time, end_time) values('G', 'W', '16:00', '16:50');
insert into time_slot(time_slot_id, day, start_time, end_time) values('G', 'F', '16:00', '16:50');
insert into time_slot(time_slot_id, day, start_time, end_time) values('H', 'W', '10:00', '12:30');

-- prereq

insert into prereq(course_id, prereq_id) values('BIO-301', 'BIO-101');
insert into prereq(course_id, prereq_id) values('BIO-399', 'BIO-101');
insert into prereq(course_id, prereq_id) values('CS-190', 'CS-101');
insert into prereq(course_id, prereq_id) values('CS-315', 'CS-101');
insert into prereq(course_id, prereq_id) values('CS-319', 'CS-101');
insert into prereq(course_id, prereq_id) values('CS-347', 'CS-101');
insert into prereq(course_id, prereq_id) values('EE-181', 'PHY-101');




