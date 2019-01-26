go
use LibrarySystem


--ɾ�����
if exists(select name from sys.tables where name = 'Te_Borrow_Records')
	alter table Te_Borrow_Records drop constraint Te_Book_ID_FK
	alter table Te_Borrow_Records drop constraint Te_Bro_IDs_FK
	alter table Te_Borrow_Records drop constraint Te_Worker_IDs_FK


if exists(select name from sys.tables where name = 'Stu_Borrow_Records')
	alter table Stu_Borrow_Records drop constraint Stu_Book_ID_FK
	alter table Stu_Borrow_Records drop constraint Stu_Bro_IDs_FK
	alter table Stu_Borrow_Records drop constraint Stu_Worker_IDs_FK


--����Book��
go
if exists (select name from sys.tables where name='Book')
	drop table Book
create table Book
(
	BookNo char(10) not null,--���
	BookCatagory varchar(30) not null,--���
	BookName varchar(100) not null,--����
	BookPubPress varchar(50) not null,--������
	BookYear int,--���
	BookAuthor varchar(50) not null,--����
	BookPrice numeric(8, 2) not null,--�۸�
	BookTotalNum int not null,--�ܿ��
	BookStoreNum int default(0),--Ŀǰ���
	constraint Book_PK primary key (BookNo),--�������Ϊ����
)

--������ʱBook��
go
if exists (select name from sys.tables where name='TempTable')
	drop table TempTable
create table TempTable
(
	BookNo char(10) not null,--���
	BookCatagory varchar(30) not null,--���
	BookName varchar(100) not null,--����
	BookPubPress varchar(50) not null,--������
	BookYear int,--���
	BookAuthor varchar(50) not null,--����
	BookPrice numeric(8, 2) not null,--�۸�
	BookTotalNum int not null,--�ܿ��
)

--������ʦ����֤��
go
if exists (select name from sys.tables where name = 'Te_Library_Card')
	drop table Te_Library_Card
create table Te_Library_Card
(
	CardNo char(10) not null,
	CardName varchar(30) not null,
	Dept_Name varchar(30),
	Classfy varchar(30) not null ,
	constraint Te_Library_Card_PK primary key (CardNo),
	check (Classfy in('Teacher'))
)

--����ѧ������֤��
go
if exists (select name from sys.tables where name = 'Stu_Library_Card')
	drop table Stu_Library_Card
create table Stu_Library_Card
(
	CardNo char(10) not null,
	CardName varchar(30) not null,
	Dept_Name varchar(30),
	Classfy varchar(30) not null ,
	constraint Stu_Library_Card_PK primary key (CardNo),
	check (Classfy in('Student'))
)

--��������Ա��
go
if exists (select name from sys.tables where name = 'Administrators')
	drop table Administrators
create table Administrators
(
	Admin_ID char(10) not null,
	Passwords varchar(30) not null,
	AdminName varchar(30) not null,
	PhoneNum char(11),
	constraint Administrators_PK primary key(Admin_ID)
)

--������ʦ�����¼��
go
if exists(select name from sys.tables where name = 'Te_Borrow_Records')
	drop table Te_Borrow_Records
create table Te_Borrow_Records
(
	Book_ID char(10) not null,
	Bro_ID char(10) not null,
	Borrow_Time smalldatetime not null,
	Return_Time smalldatetime ,
	Worker_ID char(10),
	constraint Te_Borrow_Records_PK primary key (Book_ID, Bro_ID),
	constraint Te_Book_ID_FK foreign key (Book_ID) references Book(BookNo),
	constraint Te_Bro_IDs_FK foreign key (Bro_ID) references Te_Library_Card(CardNo),
	constraint Te_Worker_IDs_FK foreign key (Worker_ID) references Administrators(Admin_ID)
)

--����ѧ�������¼��
go
if exists(select name from sys.tables where name = 'Stu_Borrow_Records')
	drop table Stu_Borrow_Records
create table Stu_Borrow_Records
(
	Book_ID char(10) not null,
	Bro_ID char(10) not null,
	Borrow_Time smalldatetime not null,
	Return_Time smalldatetime ,
	Worker_ID char(10),
	constraint Stu_Borrow_Records_PK primary key (Book_ID, Bro_ID),
	constraint Stu_Book_ID_FK foreign key (Book_ID) references Book(BookNo),
	constraint Stu_Bro_IDs_FK foreign key (Bro_ID) references Stu_Library_Card(CardNo),
	constraint Stu_Worker_IDs_FK foreign key (Worker_ID) references Administrators(Admin_ID)
)
