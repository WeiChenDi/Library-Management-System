use LibrarySystem


----����
--go
--create procedure BorrowBook
--@CardNo char(10), @BookNo char(10), @Admin char(10) ,@feedback varchar(50) output--�ⲿ���������ID��ͼ��ID, 
--as
--declare @result int
--declare @BookNum int
--declare @BorrowerName varchar(30)
--declare @BookName varchar(30)
--declare @ReturnTime smalldatetime
--set @result = -1;
--set @feedback = '����ʧ�ܣ�';
--declare @Nearest_Return smalldatetime
--if(charindex('T', @CardNo)>0)--���������Ϊ��ʦ
--begin
--	if not exists(select * from Book where BookNo = @BookNo)
--	begin
--		set @feedback = '�����ڸ�ͼ�飡';
--		set @result = -1;
--	end

--	else if not exists(select * from Book where BookNo = @BookNo and BookStoreNum > 0)
--	begin
--		select @Nearest_Return = min(Return_Time) from Stu_Borrow_Records where Book_ID = @BookNo
--		set @feedback ='�������޿�棬����Ĺ黹ʱ��Ϊ'+ CONVERT(varchar(10),@Nearest_Return);
--		set @result = -1;
--	end

--	else if not exists(select * from Te_Library_Card where CardNo = @CardNo)
--	begin
--		set @feedback = '�����ڸý���֤��';
--		set @result = -1;
--	end

--	else
--	begin
--		select * from Te_Borrow_Records where Bro_ID = @CardNo
--		if exists(select * from Te_Borrow_Records where Book_ID=@BookNo and Bro_ID=@CardNo)
--		---һ�����޷��ظ�����ͬһ����
--		begin
--			set @feedback = '���Ѿ���������һ���飬�޷��ظ�����';
--			set @result = 0;
--		end

--		--�ɹ�����
--		else
--		begin
--		--������Ŀ��
--			update Book set BookStoreNum=BookStoreNum-1 where BookNo = @BookNo
--		--���������Ϣ
--			insert into Te_Borrow_Records(Book_ID, Bro_ID,Borrow_Time, Worker_ID ) values (@BookNo, @CardNo, GETDATE(), @Admin)
--			select @ReturnTime =  dateadd(mm,1,Borrow_Time) from Te_Borrow_Records where @CardNo = Bro_ID and @CardNo = Bro_ID
--			update Te_Borrow_Records set Return_Time = @ReturnTime where @BookNo = Book_ID and @CardNo = Bro_ID
--		--������ĳɹ���Ϣ
--			select @BorrowerName=CardName from Te_Library_Card where CardNo=@CardNo
--			select @BookName=BookName from Book where BookNo=@BookNo
--			set @result = 1;
--			print '����֤��Ϊ' +@CardNo + '����Ϊ'+ @BorrowerName + '�Ľ�ʦ����'+datename(year,GETDATE())+' �� '+datename(month,GETDATE())+' �� '+datename(day,GETDATE())+' �� '+datename(hour,GETDATE())+' ʱ '+datename(minute,GETDATE())+' �� '+datename(second,GETDATE())+' �룬�ɹ��ش�ͼ��ݽ����'+@BookName+'��һ��'
--			set @feedback = '����ɹ�������Ϊ�����н��ĵ������鼮';
--		end
--	end
--end
----������Ϊѧ��
--else if(CHARINDEX('S', @CardNo)>0)
--begin
--	if not exists(select * from Book where BookNo = @BookNo)
--	begin
--		set @feedback = '�����ڸ�ͼ�飡';
--		set @result = -1;
--	end

--	else if not exists(select * from Book where BookNo = @BookNo and BookStoreNum > 0)
--	begin
--		select @Nearest_Return = min(Return_Time) from Stu_Borrow_Records where @BookNo = Book_ID
--		set @feedback ='�������޿�棬����Ĺ黹ʱ��Ϊ'+ CONVERT(varchar(10),@Nearest_Return);
--		set @result = -1;
--	end

--	else if not exists(select * from Stu_Library_Card where CardNo = @CardNo)
--	begin
--		set @feedback = '�����ڸý���֤��';
--		set @result = -1;
--	end

--	else
--	begin
--		select * from Stu_Borrow_Records where Bro_ID = @CardNo
--		if exists(select * from Stu_Borrow_Records where Book_ID=@BookNo and Bro_ID=@CardNo)
--		---һ�����޷��ظ�����ͬһ����
--		begin
--			set @feedback = '���Ѿ���������һ���飬�޷��ظ�����';
--			set @result = 0;
--		end
--		--�ɹ�����
--		else
--		begin
--		--������Ŀ��
--			update Book set BookStoreNum=BookStoreNum-1 where BookNo = @BookNo
--		--���������Ϣ
--			insert into Stu_Borrow_Records(Book_ID, Bro_ID,Borrow_Time , Worker_ID) values (@BookNo, @CardNo, GETDATE(), @Admin)
--			select @ReturnTime =  dateadd(mm,1,Borrow_Time) from Stu_Borrow_Records where @CardNo = Bro_ID and @CardNo = Bro_ID
--			update Stu_Borrow_Records set Return_Time = @ReturnTime where @BookNo = Book_ID and @CardNo = Bro_ID
--		--������ĳɹ���Ϣ
--			select @BorrowerName=CardName from Stu_Library_Card where CardNo=@CardNo
--			select @BookName=BookName from Book where BookNo=@BookNo
--			print '����֤��Ϊ' +@CardNo + '����Ϊ'+ @BorrowerName + '��ѧ������'+datename(year,GETDATE())+' �� '+datename(month,GETDATE())+' �� '+datename(day,GETDATE())+' �� '+datename(hour,GETDATE())+' ʱ '+datename(minute,GETDATE())+' �� '+datename(second,GETDATE())+' �룬�ɹ��ش�ͼ��ݽ����'+@BookName+'��һ��'
--			set @feedback = '����ɹ�������Ϊ�����н��ĵ������鼮';
--			set @result = 1;
--		end
--	end
--end
--return @result


----��������
--go
--create procedure Batch_Import_Data
--as
--delete from TempTable
--bulk insert  TempTable  from'C:\Users\asus\Desktop\�γ�\���ݿ�\ͼ����Ϣ��.txt' with (fieldterminator = '	',rowterminator = '\n')
--insert into Book (BookNo,BookCatagory,BookName,BookPubPress,BookYear,BookAuthor,BookPrice,BookTotalNum) select * from TempTable
--update Book set BookStoreNum=BookTotalNum

----��������
--go
--create procedure Single_Import_Data
--@BookNo char(10), @BookCatagory varchar(30), @BookName varchar(100), @BookPubPress varchar(50), @BookYear int, @BookAuthor varchar(50), @BookPrice numeric(8, 2), @BookTotalNum int
--as
--insert into Book (BookNo,BookCatagory,BookName,BookPubPress,BookYear,BookAuthor,BookPrice,BookTotalNum) values(@BookNo, @BookCatagory, @BookName, @BookPubPress, @BookYear, @BookAuthor, @BookPrice, @BookTotalNum)
--update Book set BookStoreNum=BookTotalNum 
-----------------��Ŀ��ѯ
----��Ų�ѯ
--go
--create procedure BookNo_Search
--@BookNo char(10)
--as
--declare @BookNum int
--select top 50 * from Book where @BookNo=BookNo
--order by(BookName)
--select @BookNum = count(BookNo) from Book where @BookNo=BookNo
--print '�ܹ���������'+CONVERT(varchar(10),@BookNum)+'��������������Ŀ'
--if not exists(select * from Book where @BookNo=BookNo)
--begin
--	print '�Բ����������ҵ���Ŀ�����ڣ�'
--end

----������ѯ(��ģ����ѯ)
--go
--create procedure BookName_Search
--@BookName varchar(100)
--as
--declare @BookNum int
--select top 50 * from Book where BookName like '%'+@BookName+'%'
--order by (BookName)
--select @BookNum = count(BookName) from Book where BookName like '%'+@BookName+'%'
--print '�ܹ���������'+CONVERT(varchar(10),@BookNum)+'��������������Ŀ'
--if @BookNum=0
--begin
--	print '�Բ����������ҵ���Ŀ�����ڣ�'
--end

----����ѯ
--go
--create procedure BookCatagory_Search
--@BookCatagory varchar(30)
--as
--declare @BookNum int
--select top 50 * from Book where @BookCatagory=BookCatagory
--order by(BookName)
--select @BookNum=count(BookNo)from Book where @BookCatagory=BookCatagory
--print '�ܹ���������'+CONVERT(varchar(10),@BookNum)+'��������������Ŀ'
--if @BookNum=0
--begin
--	print '�Բ����������ҵ���Ŀ�����ڣ�'
--end

----�������ѯ
--go
--create procedure BookPress_Search
--@BookPress varchar(50)
--as
--declare @BookNum int
--select top 50 * from Book where @BookPress = BookPubPress
--order by(BookName)
--select @BookNum=count(BookNo)from Book where @BookPress = BookPubPress
--print '�ܹ���������'+CONVERT(varchar(10),@BookNum)+'��������������Ŀ'
--if @BookNum=0
--begin
--	print '�Բ����������ҵ���Ŀ�����ڣ�'
--end

----��ݲ�ѯ
--go
--create procedure BookPubYear_Search
--@BookPubYear1 int, @BookPubYear2 int
--as
--declare @BookNum int
--select top 50 * from Book where BookYear between @BookPubYear1 and @BookPubYear2
--order by (BookName)
--select @BookNum = count(BookNo) from Book where BookYear between @BookPubYear1 and @BookPubYear2
--print '�ܹ���������'+CONVERT(varchar(10),@BookNum)+'��������������Ŀ'
--if @BookNum=0
--begin
--	print '�Բ����������ҵ���Ŀ�����ڣ�'
--end

----���߲�ѯ
--go
--create procedure BookAuthor_Search
--@BookAuthor varchar(50)
--as
--declare @BookNum int
--select top 50 * from Book where BookAuthor like '%'+@BookAuthor+'%'
--order by BookName
--select @BookNum = count(BookNo) from Book where BookAuthor like '%'+@BookAuthor+'%'
--print '�ܹ���������'+CONVERT(varchar(10),@BookNum)+'��������������Ŀ'
--if @BookNum=0
--begin
--	print '�Բ����������ҵ���Ŀ�����ڣ�'
--end

----�۸��ѯ
--go
--create procedure BookPrice_Search
--@BookPrice1 numeric, @BookPrice2 numeric
--as
--declare @BookNum int
--select top 50 * from Book where BookPrice between @BookPrice1 and @BookPrice2
--order by(BookName)
--select @BookNum = count (BookNo) from Book where BookPrice between @BookPrice1 and @BookPrice2
--print '�ܹ���������'+CONVERT(varchar(10),@BookNum)+'��������������Ŀ'
--if @BookNum=0
--begin
--	print '�Բ����������ҵ���Ŀ�����ڣ�'
--end



--����
--go
--create procedure ReturnBook
--@CardNo char(10), @BookNo char(10),@feedback varchar(50) output
--as
--set @feedback='�Բ���û�в�ѯ����Ӧ��¼��������'
--if CHARINDEX('T', @CardNo)>0--������Ϊ��ʦ
--begin--����Ѿ����������
--	select * from Te_Borrow_Records where Bro_ID = @CardNo
--	if not exists(select * from Te_Borrow_Records where @CardNo = Bro_ID and @BookNo = Book_ID)
--	begin
--		print '�Բ���û�в�ѯ����Ӧ��¼��������!'
--		set @feedback = '�Բ���û�в�ѯ����Ӧ��¼��������!'
--	end
--	else
--	begin
--		set @feedback = '����ɹ���'
--		print'����ɹ���'
--		update Book set BookStoreNum = BookStoreNum +1 where @BookNo = BookNo--���¿��
--		delete from Te_Borrow_Records where @CardNo = Bro_ID and @BookNo = Book_ID--ɾ���Ȿ��Ľ����¼
--	end
--end
--else if(CHARINDEX('S', @CardNo)>0)--������Ϊѧ��
--begin
--	select * from Stu_Borrow_Records where Bro_ID = @CardNo
--	if not exists(select * from Stu_Borrow_Records where @CardNo = Bro_ID and @BookNo = Book_ID)
--	begin
--		set @feedback = '�Բ���û�в�ѯ����Ӧ��¼��������'
--		print '�Բ���û�в�ѯ����Ӧ��¼��������'
--	end
--	else
--	begin
--		set @feedback = '����ɹ���'
--		print'����ɹ���'
--		update Book set BookStoreNum = BookStoreNum + 1 where @BookNo = BookNo
--		delete from Stu_Borrow_Records where @CardNo = Bro_ID and @BookNo = Book_ID
--	end
--end

--���������ʦ
go
alter procedure Batch_Import_Te
as
bulk insert  Te_Library_Card  from'C:\Users\a6054\Desktop\dbProj\��ʦ��Ϣ��.txt' with (fieldterminator = '	',rowterminator = '\n')

----���������ʦ
--go
--create procedure Single_Import_Te
--@CardNo char(10), @CardName varchar(30), @Dept_Name varchar(30), @Classfy varchar(30)
--as
--if exists (select * from Te_Library_Card where CardNo = @CardNo)
--begin
--	print('����Ŀ����Ѵ��ڣ����������룡')
--end
--else 
--begin
--	insert into Te_Library_Card values(@CardNo, @CardName, @Dept_Name, @Classfy)
--end



----��������ѧ��
--go
--create procedure Batch_Import_Stu
--as
--bulk insert  Stu_Library_Card  from'C:\Users\asus\Desktop\�γ�\���ݿ�\ѧ����Ϣ��.txt' with (fieldterminator = '	',rowterminator = '\n')

----��������ѧ��
--go
--create procedure Single_Import_Stu
--@CardNo char(10), @CardName varchar(30), @Dept_Name varchar(30), @Classfy varchar(30)
--as
--if exists (select * from Stu_Library_Card where CardNo = @CardNo)
--begin
--	print('����Ŀ����Ѵ��ڣ����������룡')
--end
--else 
--begin
--	insert into Stu_Library_Card values(@CardNo, @CardName, @Dept_Name, @Classfy)
--end


----����Ա�����
--go
--create procedure AdminInsertion
--@Admin_ID char(10), @Passwords varchar(30), @AdminName varchar(30), @PhoneNum char(11)
--as
--insert into Administrators values(@Admin_ID, @Passwords, @AdminName, @PhoneNum)

----����Ա��¼
--go
--create procedure AdminSignIn
--@Admin_ID char(10), @Passwords varchar(30)
--as
--declare @result int
--if not exists(select * from Administrators where @Admin_ID = Admin_ID)
--begin
--	print 'δ��ѯ���˹���Ա�������ԣ�'
--	set @result = -1
--	return  @result
--end
--else
--begin
--	if not exists(select * from Administrators where @Admin_ID = Admin_ID and @Passwords = Passwords)
--	begin
--		print'�����������'
--		set @result = 0
--		return @result
--	end
--	else
--	begin
--		print'��¼�ɹ���'
--		set @result = 1
--		return @result
--	end
--end

--���ز�ѯ
--go
--create procedure MultiSearch
--@BookNo char(10), @BookCatagory varchar(30), @BookName varchar(100), @BookPubPress varchar(50), @BookYear1 char(10), @BookYear2 char(20), @BookAuthor varchar(50), @BookPrice1 char(10), @BookPrice2 char(10), @Orderoption varchar(20), @Order int--@Orderoption������Year��Price����������ո�Ĭ����������Order������1��0,1Ϊ����0Ϊ����
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