
-- SQL Test=================


use regex;


create table Students (
	StudentID INT primary key,
    Name Varchar(20),
    Age int,
    Grade Int,
    City Varchar(255)
);

desc Students;
insert into Students(StudentID, Name, Age, Grade, City) values
(1, 'Alice', 14, 9, 'New York'),
(2, 'Bob', 15, 10, 'Los Angeles'),
(3, 'Charlie', 14, 9, 'Chicago'),
(4, 'David', 16, 11, 'New York'),
(5, 'Eve', 15, 10, 'Chicago');

select * from Students;


-- =========
CREATE TABLE Marks (
    StudentID INT,
    Subject VARCHAR(255),
    marks INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

desc Marks;

INSERT INTO Marks (StudentID, Subject, marks) 
VALUES (1, 'Math', 85),
(1, 'Science', 90)
,(2, 'Math', 78)
,(2, 'Science', 88)
,(3, 'Math', 95)
,(3, 'Science', 89)
,(4, 'Math', 80)
,(4, 'Science', 70)
,(5, 'Math', 88)
,(5, 'Science', 92);

drop table Marks;

select * from Marks;

-- 1 ========
	
select Mar.Subject, Mar.Marks
from 
	Marks as Mar
join Students stud 
	on Mar.StudentID = stud.StudentID
where stud.Name = "charlie"; 

select * from Marks;
select * from Students;

-- 2 ===========

select Stud.name , Mar.marks 
from Students as stud
join Marks mar 
on stud.StudentID= mar.StudentID
where mar.Subject ="science" 
and 
mar.marks>=90;


select * from Marks;
select * from Students;


-- 3===============
select stud.name, sum(mar.marks) as TotalMarks
from Students as stud
join Marks as mar 
on stud.StudentID= mar.StudentID
group by stud.Name;


select * from Marks;
select * from Students;


-- 4 =======
select stud.Name, mar.marks
from Students as stud
join marks as mar 
on stud.StudentID = mar.StudentID
order by mar.marks desc 
limit 1;

select * from Marks;
select * from Students;

-- 5 ==============

select stud.Name
from Students as stud
join Marks mar 
on stud.StudentID = mar.StudentID
where mar.marks > 
(select avg(marks) from Marks where subject="Math");

select * from Marks;
select * from Students;


-- Theoritical ===============
-- 6 ===========

-- Index => is like a table of (data / content) in databases. 
-- 				it help databases stystem for finding information or data quickly. it use tree datastructure 
-- 				to stre data in it, and in normal iteration we search in all lines of databases but in this it 
-- 				jump too data by help of index and as we know tree structure is efficient for searching anything
-- 				it use to find data from large industry level data ocean beacause it is faster 


-- 7 ===========
-- rank() => used to give rank whenever there is same data then it skip rank. 
-- 				and next rank after skip will be increaced by how many skip done

-- dense_rank() => it is same as rank() but only difference is it dont skip any rank, 
-- 				if data is same rank will be same.alter

-- row_number() => assign distinct unique number to row in order of data it is showing


-- 8 =========
-- ddl => data defination language : used to change in databases like creation, modifying structure of database
-- 			to make tables, change in column, data type updation
-- 				[Example: new table employees creation with column employeeId, name, salary.]

-- dml => stands for data manipy=ulation language : used to adding , changeing, updation, 
-- 			deletion in table. by this you can also delete table which is not used or in which you made mistake
-- 				[example: using alter table in employee to change name to employeeName]

-- dcl => stands for data controlling  language : inwhich we have to give permision who can access it who can not, and other action like , read, write, delete etc
--  		by this we decide who can control it who can not by using grant, revoke keyword we grant or remove permission from any user
-- 				[example: grant/revoke permission on employees to bob]
