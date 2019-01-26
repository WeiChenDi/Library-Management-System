use LibrarySystem

--������  ��Ŀû�п�����޷�����
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
print'�Բ�����Ŀ�治�㣬����ʧ��'
--δ����-------------------------------------------------------------------------
declare @Nearest_Return1 smalldatetime
declare @Nearest_Return2 smalldatetime
select @Nearest_Return1 = min(Return_Time) from Stu_Borrow_Records where @BookNo = Book_ID
select @Nearest_Return2 = min(Return_Time) from Te_Borrow_Records where @BookNo = Book_ID
if @Nearest_Return1>=@Nearest_Return2 or @Nearest_Return1 is null
begin
print'����Ĺ黹ʱ��Ϊ'+ CONVERT(varchar(30),@Nearest_Return2)
end
else
begin
print'����Ĺ黹ʱ��Ϊ'+ CONVERT(varchar(30),@Nearest_Return1)
end
rollback transaction
end

--��������ѧ�����ܽ賬��5����
go
create trigger Tri_StuBookBorrowedNum
on Stu_Borrow_Records
for insert
as
declare @Bro_ID char(10),--ѧ��֤���
@StuBookBorrowedNum int
select @Bro_ID = Bro_ID from inserted
select @StuBookBorrowedNum = count(*) from Stu_Borrow_Records where Bro_ID = @Bro_ID
if(@StuBookBorrowedNum>5)--������ý赽��5����
begin
	rollback transaction
	print '�Բ������Ľ��������Ѵ����ޣ�����ʧ��'
end

--����������ʦ���ܽ賬��5����
go
create trigger Tri_TeBookBorrowedNum
on Te_Borrow_Records
for insert
as
declare @Bro_ID char(10),--ѧ��֤���
@TeBookBorrowedNum int
select @Bro_ID = Bro_ID from inserted
select @TeBookBorrowedNum = count(*) from Te_Borrow_Records where Bro_ID = @Bro_ID
if(@TeBookBorrowedNum>5)--������ý赽��5����
begin
	rollback transaction
	print '�Բ������Ľ��������Ѵ����ޣ�����ʧ��'
end