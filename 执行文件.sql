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

--�����������

--delete from Book
--exec Batch_Import_Data
--select * from Book

--�����������
--exec Single_Import_Data C001, �������ѧ,���ݿ�ϵͳ����, �㽭��ѧ������, 2012, ��Խ, 9.99, 20
--update Book set BookStoreNum=BookTotalNum 


--��Ų�ѯ
--exec BookNo_Search null

--������ѯ
--exec BookName_Search n1

--����ѯ
--exec BookCatagory_Search �������ѧ
--union
--exec BookPress_Search �Ϻ��������������

--�������ѯ
--exec BookPress_Search �Ϻ��������������

--��������ѯ
--exec BookPubYear_Search 1998,

--���߲�ѯ
--exec BookAuthor_Search κ��

--�۸��ѯ
--exec BookPrice_Search 10.00, 15.00

--select * from Stu_Borrow_Records
--����
--exec ReturnBook S070407101, F001
--exec ReturnBook S070407101, F005
--select * from Stu_Borrow_Records
--select* from Book

--���������ʦ
--exec Batch_Import_Te
--select * from Te_Library_Card

--��������ѧ��
--exec Batch_Import_Stu
--select * from Stu_Library_Card

--�������Ա
--exec AdminInsertion Ad001, 123456789, Chenyue, 18868109739
--select * from Administrators

--����Ա��¼
--exec AdminSignIn Ad001, 123456789

--exec BorrowBook T0001, F002, Ad001
--select * from Te_Borrow_Records