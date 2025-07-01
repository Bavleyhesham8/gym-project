#create database gym;

create table trainers (id int primary key auto_increment,name varchar(20),num varchar(11),SSN varchar(14) ,salary double ,st_date date);

create table members (id int primary key auto_increment, name varchar(20),num varchar(11),age int ,trainer varchar(15) references trainers(name),s_date date,e_date date,sub double);

create table expired (id int primary key auto_increment, name varchar(20),num varchar(11),age int ,trainer varchar(15) references trainers(name),s_date date,e_date date,sub double);

#create table signup(username varchar(25),email varchar(50),phone varchar(11),password varchar(20));

#create table  login(username varchar(25) references login(username),password varchar(20) references login(password));

insert into trainers values(1,"anas","01116569594","30412049503265",NULL,"2023-12-15");

insert into trainers (name,num,SSN,st_date) values("bavely","01280491677","31503031403183","2023-10-20"),("ayat","01060134256","31703041809560","2020-10-21"),("aya","01225319610","30506044816193","2025-07-18"),("saleh","01122536499","31908041506193","2027-12-09"),("basmla","01002287616","30311041704173","2023-10-15");

insert into members values(1,"mohsen","01150030155",18,"anas","2023-11-15","2023-12-15",null);

insert into members (name,num,age,trainer,s_date,e_date) values("sameh","01515063915",21,"bavely","2023-07-10","2023-12-10"),("sondos","01009387501",15,"aya","2023-08-09","2024-01-09"),("ayman","01213141520",37,"saleh","2023-07-10","2023-12-10"),("shrouk","01201509010",25,"ayat","2023-12-18","2024-02-18"),("salma","01011178290",21,"basmla","2023-11-15","2024-12-15");

delete from trainers where id>1015;

insert into members (name,num,age,trainer,s_date,e_date) values("mohamed","01515063915",21,"bavely","2023-11-18","2023-12-18"),("mina","01312384211",21,"saleh","2023-09-18","2023-12-19"),("samia","01515063915",21,"ayat","2023-11-18","2023-12-18");
#drop table members ;
insert into expired (id,name,num,age,trainer,s_date,e_date,sub) select id,name,num,age,trainer,s_date,e_date,sub from members where id>=1 and e_date<=curdate();

insert into members (id,name,num,age,trainer,s_date,e_date,sub) select id,name,num,age,trainer,s_date,e_date,sub from expired where id>=1 and curdate()<e_date;

delete from members where id >=1 and e_date<=curdate();

delete from expired where id >=1 and curdate()<e_date;

update members set sub=DATEDIFF(e_date, s_date) div 30 * 600 where id >1;

update expired set sub=DATEDIFF(e_date, s_date) div 30 * 600 where id >1;

UPDATE trainers
SET salary = (SELECT COUNT(*) FROM members WHERE members.trainer = trainers.name )  WHERE id > 1;

UPDATE trainers
SET salary = (
    SELECT sum(trainers.salary * members.sub * 1/6 ) AS result
    FROM members
   WHERE members.trainer = trainers.name
)
WHERE trainers.id > 1;

select * from trainers;

select * from members;

select * from expired;

select name from trainers;
SELECT DATEDIFF(e_date, s_date) div 30 * 600 AS date_difference FROM members;
SELECT COUNT(*) AS name_count
FROM expired
GROUP BY trainer;
#drop table trainers;
select * from members; 
select id,name,num,age,trainer,s_date,e_date,sub from members;
#drop table trainers;
#drop table members;
#drop table expired;