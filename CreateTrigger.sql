use LibrarySystem

--触发器  书目没有库存则无法借阅
go
create trigger Tri_BookStore
on Book
for update
as
declare @BookStoreNum int
declare @BookNo varchar(50)
select @BookStoreNum = BookStoreNum from inserted
select @BookNo = BookNo from inserted
if(@BookStoreNum < 0)
begin
print'对不起，书的库存不足，借阅失败'
--未测试-------------------------------------------------------------------------
declare @Nearest_Return1 smalldatetime
declare @Nearest_Return2 smalldatetime
select @Nearest_Return1 = min(Return_Time) from Stu_Borrow_Records where @BookNo = Book_ID
select @Nearest_Return2 = min(Return_Time) from Te_Borrow_Records where @BookNo = Book_ID
if @Nearest_Return1>=@Nearest_Return2 or @Nearest_Return1 is null
begin
print'最近的归还时间为'+ CONVERT(varchar(30),@Nearest_Return2)
end
else
begin
print'最近的归还时间为'+ CONVERT(varchar(30),@Nearest_Return1)
end
rollback transaction
end

--触发器，学生不能借超过5本书
go
create trigger Tri_StuBookBorrowedNum
on Stu_Borrow_Records
for insert
as
declare @Bro_ID char(10),--学生证编号
@StuBookBorrowedNum int
select @Bro_ID = Bro_ID from inserted
select @StuBookBorrowedNum = count(*) from Stu_Borrow_Records where Bro_ID = @Bro_ID
if(@StuBookBorrowedNum>5)--如果正好借到了5本书
begin
	rollback transaction
	print '对不起，您的借阅数量已达上限，借阅失败'
end

--触发器，老师不能借超过5本书
go
create trigger Tri_TeBookBorrowedNum
on Te_Borrow_Records
for insert
as
declare @Bro_ID char(10),--学生证编号
@TeBookBorrowedNum int
select @Bro_ID = Bro_ID from inserted
select @TeBookBorrowedNum = count(*) from Te_Borrow_Records where Bro_ID = @Bro_ID
if(@TeBookBorrowedNum>5)--如果正好借到了5本书
begin
	rollback transaction
	print '对不起，您的借阅数量已达上限，借阅失败'
end