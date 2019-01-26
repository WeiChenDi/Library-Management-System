use LibrarySystem

--go
--delete from Te_Borrow_Records
--delete from Stu_Borrow_Records



--select * from Book
--select *from Stu_Library_Card
--select *from Stu_Borrow_Records
--update Book set BookStoreNum = 0
--select * from Book

--delete from Stu_Library_Card


--select * from Stu_Library_Card

--批量插入语句

--delete from Book
--exec Batch_Import_Data
--select * from Book

--单本插入语句
--exec Single_Import_Data C001, 计算机科学,数据库系统概念, 浙江大学出版社, 2012, 陈越, 9.99, 20
--update Book set BookStoreNum=BookTotalNum 


--书号查询
--exec BookNo_Search null

--书名查询
--exec BookName_Search n1

--类别查询
--exec BookCatagory_Search 计算机科学
--union
--exec BookPress_Search 上海外语教育出版社

--出版社查询
--exec BookPress_Search 上海外语教育出版社

--年份区间查询
--exec BookPubYear_Search 1998,

--作者查询
--exec BookAuthor_Search 魏琛棣

--价格查询
--exec BookPrice_Search 10.00, 15.00

--select * from Stu_Borrow_Records
--还书
--exec ReturnBook S070407101, F001
--exec ReturnBook S070407101, F005
--select * from Stu_Borrow_Records
--select* from Book

--批量插入教师
--exec Batch_Import_Te
--select * from Te_Library_Card

--批量插入学生
--exec Batch_Import_Stu
--select * from Stu_Library_Card

--插入管理员
--exec AdminInsertion Ad001, 123456789, Chenyue, 18868109739
--select * from Administrators

--管理员登录
--exec AdminSignIn Ad001, 123456789

--exec BorrowBook T0001, F002, Ad001
--select * from Te_Borrow_Records