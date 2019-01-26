use LibrarySystem


----借书
--go
--create procedure BorrowBook
--@CardNo char(10), @BookNo char(10), @Admin char(10) ,@feedback varchar(50) output--外部传入借书人ID与图书ID, 
--as
--declare @result int
--declare @BookNum int
--declare @BorrowerName varchar(30)
--declare @BookName varchar(30)
--declare @ReturnTime smalldatetime
--set @result = -1;
--set @feedback = '操作失败！';
--declare @Nearest_Return smalldatetime
--if(charindex('T', @CardNo)>0)--如果借书人为老师
--begin
--	if not exists(select * from Book where BookNo = @BookNo)
--	begin
--		set @feedback = '不存在该图书！';
--		set @result = -1;
--	end

--	else if not exists(select * from Book where BookNo = @BookNo and BookStoreNum > 0)
--	begin
--		select @Nearest_Return = min(Return_Time) from Stu_Borrow_Records where Book_ID = @BookNo
--		set @feedback ='该书已无库存，最近的归还时间为'+ CONVERT(varchar(10),@Nearest_Return);
--		set @result = -1;
--	end

--	else if not exists(select * from Te_Library_Card where CardNo = @CardNo)
--	begin
--		set @feedback = '不存在该借书证！';
--		set @result = -1;
--	end

--	else
--	begin
--		select * from Te_Borrow_Records where Bro_ID = @CardNo
--		if exists(select * from Te_Borrow_Records where Book_ID=@BookNo and Bro_ID=@CardNo)
--		---一个人无法重复借阅同一本书
--		begin
--			set @feedback = '您已经借阅了这一本书，无法重复借阅';
--			set @result = 0;
--		end

--		--成功借书
--		else
--		begin
--		--更新书的库存
--			update Book set BookStoreNum=BookStoreNum-1 where BookNo = @BookNo
--		--插入借阅信息
--			insert into Te_Borrow_Records(Book_ID, Bro_ID,Borrow_Time, Worker_ID ) values (@BookNo, @CardNo, GETDATE(), @Admin)
--			select @ReturnTime =  dateadd(mm,1,Borrow_Time) from Te_Borrow_Records where @CardNo = Bro_ID and @CardNo = Bro_ID
--			update Te_Borrow_Records set Return_Time = @ReturnTime where @BookNo = Book_ID and @CardNo = Bro_ID
--		--输出借阅成功信息
--			select @BorrowerName=CardName from Te_Library_Card where CardNo=@CardNo
--			select @BookName=BookName from Book where BookNo=@BookNo
--			set @result = 1;
--			print '借书证号为' +@CardNo + '姓名为'+ @BorrowerName + '的教师，于'+datename(year,GETDATE())+' 年 '+datename(month,GETDATE())+' 月 '+datename(day,GETDATE())+' 日 '+datename(hour,GETDATE())+' 时 '+datename(minute,GETDATE())+' 分 '+datename(second,GETDATE())+' 秒，成功地从图书馆借出《'+@BookName+'》一书'
--			set @feedback = '借书成功，以下为您所有借阅的所有书籍';
--		end
--	end
--end
----借书人为学生
--else if(CHARINDEX('S', @CardNo)>0)
--begin
--	if not exists(select * from Book where BookNo = @BookNo)
--	begin
--		set @feedback = '不存在该图书！';
--		set @result = -1;
--	end

--	else if not exists(select * from Book where BookNo = @BookNo and BookStoreNum > 0)
--	begin
--		select @Nearest_Return = min(Return_Time) from Stu_Borrow_Records where @BookNo = Book_ID
--		set @feedback ='该书已无库存，最近的归还时间为'+ CONVERT(varchar(10),@Nearest_Return);
--		set @result = -1;
--	end

--	else if not exists(select * from Stu_Library_Card where CardNo = @CardNo)
--	begin
--		set @feedback = '不存在该借书证！';
--		set @result = -1;
--	end

--	else
--	begin
--		select * from Stu_Borrow_Records where Bro_ID = @CardNo
--		if exists(select * from Stu_Borrow_Records where Book_ID=@BookNo and Bro_ID=@CardNo)
--		---一个人无法重复借阅同一本书
--		begin
--			set @feedback = '您已经借阅了这一本书，无法重复借阅';
--			set @result = 0;
--		end
--		--成功借书
--		else
--		begin
--		--更新书的库存
--			update Book set BookStoreNum=BookStoreNum-1 where BookNo = @BookNo
--		--插入借阅信息
--			insert into Stu_Borrow_Records(Book_ID, Bro_ID,Borrow_Time , Worker_ID) values (@BookNo, @CardNo, GETDATE(), @Admin)
--			select @ReturnTime =  dateadd(mm,1,Borrow_Time) from Stu_Borrow_Records where @CardNo = Bro_ID and @CardNo = Bro_ID
--			update Stu_Borrow_Records set Return_Time = @ReturnTime where @BookNo = Book_ID and @CardNo = Bro_ID
--		--输出借阅成功信息
--			select @BorrowerName=CardName from Stu_Library_Card where CardNo=@CardNo
--			select @BookName=BookName from Book where BookNo=@BookNo
--			print '借书证号为' +@CardNo + '姓名为'+ @BorrowerName + '的学生，于'+datename(year,GETDATE())+' 年 '+datename(month,GETDATE())+' 月 '+datename(day,GETDATE())+' 日 '+datename(hour,GETDATE())+' 时 '+datename(minute,GETDATE())+' 分 '+datename(second,GETDATE())+' 秒，成功地从图书馆借出《'+@BookName+'》一书'
--			set @feedback = '借书成功，以下为您所有借阅的所有书籍';
--			set @result = 1;
--		end
--	end
--end
--return @result


----批量插入
--go
--create procedure Batch_Import_Data
--as
--delete from TempTable
--bulk insert  TempTable  from'C:\Users\asus\Desktop\课程\数据库\图书信息表.txt' with (fieldterminator = '	',rowterminator = '\n')
--insert into Book (BookNo,BookCatagory,BookName,BookPubPress,BookYear,BookAuthor,BookPrice,BookTotalNum) select * from TempTable
--update Book set BookStoreNum=BookTotalNum

----单本插入
--go
--create procedure Single_Import_Data
--@BookNo char(10), @BookCatagory varchar(30), @BookName varchar(100), @BookPubPress varchar(50), @BookYear int, @BookAuthor varchar(50), @BookPrice numeric(8, 2), @BookTotalNum int
--as
--insert into Book (BookNo,BookCatagory,BookName,BookPubPress,BookYear,BookAuthor,BookPrice,BookTotalNum) values(@BookNo, @BookCatagory, @BookName, @BookPubPress, @BookYear, @BookAuthor, @BookPrice, @BookTotalNum)
--update Book set BookStoreNum=BookTotalNum 
-----------------书目查询
----书号查询
--go
--create procedure BookNo_Search
--@BookNo char(10)
--as
--declare @BookNum int
--select top 50 * from Book where @BookNo=BookNo
--order by(BookName)
--select @BookNum = count(BookNo) from Book where @BookNo=BookNo
--print '总共检索到了'+CONVERT(varchar(10),@BookNum)+'条满足条件的书目'
--if not exists(select * from Book where @BookNo=BookNo)
--begin
--	print '对不起，您所查找的书目不存在！'
--end

----书名查询(可模糊查询)
--go
--create procedure BookName_Search
--@BookName varchar(100)
--as
--declare @BookNum int
--select top 50 * from Book where BookName like '%'+@BookName+'%'
--order by (BookName)
--select @BookNum = count(BookName) from Book where BookName like '%'+@BookName+'%'
--print '总共检索到了'+CONVERT(varchar(10),@BookNum)+'条满足条件的书目'
--if @BookNum=0
--begin
--	print '对不起，您所查找的书目不存在！'
--end

----类别查询
--go
--create procedure BookCatagory_Search
--@BookCatagory varchar(30)
--as
--declare @BookNum int
--select top 50 * from Book where @BookCatagory=BookCatagory
--order by(BookName)
--select @BookNum=count(BookNo)from Book where @BookCatagory=BookCatagory
--print '总共检索到了'+CONVERT(varchar(10),@BookNum)+'条满足条件的书目'
--if @BookNum=0
--begin
--	print '对不起，您所查找的书目不存在！'
--end

----出版社查询
--go
--create procedure BookPress_Search
--@BookPress varchar(50)
--as
--declare @BookNum int
--select top 50 * from Book where @BookPress = BookPubPress
--order by(BookName)
--select @BookNum=count(BookNo)from Book where @BookPress = BookPubPress
--print '总共检索到了'+CONVERT(varchar(10),@BookNum)+'条满足条件的书目'
--if @BookNum=0
--begin
--	print '对不起，您所查找的书目不存在！'
--end

----年份查询
--go
--create procedure BookPubYear_Search
--@BookPubYear1 int, @BookPubYear2 int
--as
--declare @BookNum int
--select top 50 * from Book where BookYear between @BookPubYear1 and @BookPubYear2
--order by (BookName)
--select @BookNum = count(BookNo) from Book where BookYear between @BookPubYear1 and @BookPubYear2
--print '总共检索到了'+CONVERT(varchar(10),@BookNum)+'条满足条件的书目'
--if @BookNum=0
--begin
--	print '对不起，您所查找的书目不存在！'
--end

----作者查询
--go
--create procedure BookAuthor_Search
--@BookAuthor varchar(50)
--as
--declare @BookNum int
--select top 50 * from Book where BookAuthor like '%'+@BookAuthor+'%'
--order by BookName
--select @BookNum = count(BookNo) from Book where BookAuthor like '%'+@BookAuthor+'%'
--print '总共检索到了'+CONVERT(varchar(10),@BookNum)+'条满足条件的书目'
--if @BookNum=0
--begin
--	print '对不起，您所查找的书目不存在！'
--end

----价格查询
--go
--create procedure BookPrice_Search
--@BookPrice1 numeric, @BookPrice2 numeric
--as
--declare @BookNum int
--select top 50 * from Book where BookPrice between @BookPrice1 and @BookPrice2
--order by(BookName)
--select @BookNum = count (BookNo) from Book where BookPrice between @BookPrice1 and @BookPrice2
--print '总共检索到了'+CONVERT(varchar(10),@BookNum)+'条满足条件的书目'
--if @BookNum=0
--begin
--	print '对不起，您所查找的书目不存在！'
--end



--还书
--go
--create procedure ReturnBook
--@CardNo char(10), @BookNo char(10),@feedback varchar(50) output
--as
--set @feedback='对不起，没有查询到相应记录，请重试'
--if CHARINDEX('T', @CardNo)>0--还书人为老师
--begin--输出已经借的所有书
--	select * from Te_Borrow_Records where Bro_ID = @CardNo
--	if not exists(select * from Te_Borrow_Records where @CardNo = Bro_ID and @BookNo = Book_ID)
--	begin
--		print '对不起，没有查询到相应记录，请重试!'
--		set @feedback = '对不起，没有查询到相应记录，请重试!'
--	end
--	else
--	begin
--		set @feedback = '还书成功！'
--		print'还书成功！'
--		update Book set BookStoreNum = BookStoreNum +1 where @BookNo = BookNo--更新库存
--		delete from Te_Borrow_Records where @CardNo = Bro_ID and @BookNo = Book_ID--删除这本书的借书记录
--	end
--end
--else if(CHARINDEX('S', @CardNo)>0)--还书人为学生
--begin
--	select * from Stu_Borrow_Records where Bro_ID = @CardNo
--	if not exists(select * from Stu_Borrow_Records where @CardNo = Bro_ID and @BookNo = Book_ID)
--	begin
--		set @feedback = '对不起，没有查询到相应记录，请重试'
--		print '对不起，没有查询到相应记录，请重试'
--	end
--	else
--	begin
--		set @feedback = '还书成功！'
--		print'还书成功！'
--		update Book set BookStoreNum = BookStoreNum + 1 where @BookNo = BookNo
--		delete from Stu_Borrow_Records where @CardNo = Bro_ID and @BookNo = Book_ID
--	end
--end

--批量插入教师
go
alter procedure Batch_Import_Te
as
bulk insert  Te_Library_Card  from'C:\Users\a6054\Desktop\dbProj\教师信息表.txt' with (fieldterminator = '	',rowterminator = '\n')

----单个插入教师
--go
--create procedure Single_Import_Te
--@CardNo char(10), @CardName varchar(30), @Dept_Name varchar(30), @Classfy varchar(30)
--as
--if exists (select * from Te_Library_Card where CardNo = @CardNo)
--begin
--	print('输入的卡号已存在，请重新输入！')
--end
--else 
--begin
--	insert into Te_Library_Card values(@CardNo, @CardName, @Dept_Name, @Classfy)
--end



----批量插入学生
--go
--create procedure Batch_Import_Stu
--as
--bulk insert  Stu_Library_Card  from'C:\Users\asus\Desktop\课程\数据库\学生信息表.txt' with (fieldterminator = '	',rowterminator = '\n')

----单个插入学生
--go
--create procedure Single_Import_Stu
--@CardNo char(10), @CardName varchar(30), @Dept_Name varchar(30), @Classfy varchar(30)
--as
--if exists (select * from Stu_Library_Card where CardNo = @CardNo)
--begin
--	print('输入的卡号已存在，请重新输入！')
--end
--else 
--begin
--	insert into Stu_Library_Card values(@CardNo, @CardName, @Dept_Name, @Classfy)
--end


----管理员表插入
--go
--create procedure AdminInsertion
--@Admin_ID char(10), @Passwords varchar(30), @AdminName varchar(30), @PhoneNum char(11)
--as
--insert into Administrators values(@Admin_ID, @Passwords, @AdminName, @PhoneNum)

----管理员登录
--go
--create procedure AdminSignIn
--@Admin_ID char(10), @Passwords varchar(30)
--as
--declare @result int
--if not exists(select * from Administrators where @Admin_ID = Admin_ID)
--begin
--	print '未查询到此管理员，请重试！'
--	set @result = -1
--	return  @result
--end
--else
--begin
--	if not exists(select * from Administrators where @Admin_ID = Admin_ID and @Passwords = Passwords)
--	begin
--		print'密码输入错误！'
--		set @result = 0
--		return @result
--	end
--	else
--	begin
--		print'登录成功！'
--		set @result = 1
--		return @result
--	end
--end

--多重查询
--go
--create procedure MultiSearch
--@BookNo char(10), @BookCatagory varchar(30), @BookName varchar(100), @BookPubPress varchar(50), @BookYear1 char(10), @BookYear2 char(20), @BookAuthor varchar(50), @BookPrice1 char(10), @BookPrice2 char(10), @Orderoption varchar(20), @Order int--@Orderoption可输入Year和Price，否则输入空格默认书名正序；Order可输入1或0,1为正序，0为逆序
--as
--declare @Year1 int 
--declare @Year2 int
--declare @Price1 numeric
--declare @Price2 numeric
--set @Year1 = convert(int, @BookYear1)
--set @Year2 = convert(int, @BookYear2)
--if @BookPrice1 !=' ' and @BookPrice2 !=' '
--begin
--set @Price1 = convert(numeric(8, 2), @BookPrice1)
--set @Price2 = convert(numeric(8, 2), @BookPrice2)
--end


--if(@BookNo = ' ' and @BookCatagory =' ' and @BookName =' ' and @BookPubPress=' ' and @BookYear1=' ' and @BookYear2= ' ' and @BookAuthor= ' ' and @BookPrice1=' ' and @BookPrice2= '' and @Orderoption = ' ')
--	select * from Book;
	

--else if(@Orderoption = ' ')
--begin
--select top 50 * from Book where (@BookNo = BookNo or @BookNo = ' ') and( @BookCatagory = BookCatagory or @BookCatagory = ' ' )
--and (@BookName = BookName or @BookName = ' ' ) and (@BookPubPress = BookPubPress or @BookPubPress = ' ') 
--and (BookYear between @Year1 and @Year2 or @BookYear1 = ' ' or @BookYear2 = ' ') and (@BookAuthor = BookAuthor or @BookAuthor = ' ')
--and (BookPrice between @Price1 and @Price2 or @BookPrice1 = ' ' or @BookPrice2 = ' '  )
--order by (BookName)
--end

--else if(@Orderoption = 'Year' and @Order = 1)
--begin
--select top 50 * from Book where (@BookNo = BookNo or @BookNo = ' ') and( @BookCatagory = BookCatagory or @BookCatagory = ' ' )
--and (@BookName = BookName or @BookName = ' ' ) and (@BookPubPress = BookPubPress or @BookPubPress = ' ') 
--and (BookYear between @Year1 and @Year2 or @BookYear1 = ' ' or @BookYear2 = ' ') and (@BookAuthor = BookAuthor or @BookAuthor = ' ')
--and (BookPrice between @Price1 and @Price2 or @BookPrice1 = ' ' or @BookPrice2 = ' '  )
--order by (BookYear)
--end

--else if(@Orderoption = 'Year' and @Order = 0)
--begin
--select top 50 * from Book where (@BookNo = BookNo or @BookNo = ' ') and( @BookCatagory = BookCatagory or @BookCatagory = ' ' )
--and (@BookName = BookName or @BookName = ' ' ) and (@BookPubPress = BookPubPress or @BookPubPress = ' ') 
--and (BookYear between @Year1 and @Year2 or @BookYear1 = ' ' or @BookYear2 = ' ') and (@BookAuthor = BookAuthor or @BookAuthor = ' ')
--and (BookPrice between @Price1 and @Price2 or @BookPrice1 = ' ' or @BookPrice2 = ' '  )
--order by(BookYear) desc
--end

--else if(@Orderoption = 'Price' and @Order = 1)
--begin
--select top 50 * from Book where (@BookNo = BookNo or @BookNo = ' ') and( @BookCatagory = BookCatagory or @BookCatagory = ' ' )
--and (@BookName = BookName or @BookName = ' ' ) and (@BookPubPress = BookPubPress or @BookPubPress = ' ') 
--and (BookYear between @Year1 and @Year2 or @BookYear1 = ' ' or @BookYear2 = ' ') and (@BookAuthor = BookAuthor or @BookAuthor = ' ')
--and (BookPrice between @Price1 and @Price2 or @BookPrice1 = ' ' or @BookPrice2 = ' '  )
--order by (BookPrice)
--end

--else if(@Orderoption = 'Price' and @Order = 0)
--begin
--select top 50 * from Book where (@BookNo = BookNo or @BookNo = ' ') and( @BookCatagory = BookCatagory or @BookCatagory = ' ' )
--and (@BookName = BookName or @BookName = ' ' ) and (@BookPubPress = BookPubPress or @BookPubPress = ' ') 
--and (BookYear between @Year1 and @Year2 or @BookYear1 = ' ' or @BookYear2 = ' ') and (@BookAuthor = BookAuthor or @BookAuthor = ' ')
--and (BookPrice between @Price1 and @Price2 or @BookPrice1 = ' ' or @BookPrice2 = ' '  )
--order by (BookPrice) desc
--end