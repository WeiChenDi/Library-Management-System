create database LibrarySystem
on primary
(
	name='LibrarySystem',
	filename='D:\SQL\MSSQL14.MSSQLSERVER02\MSSQL\DATA\LibrarySystem',
	size=10MB,
	maxsize=unlimited,
	filegrowth=1MB
)
log on
(
	name='LibrarySystem_Log',
	filename='D:\SQL\MSSQL14.MSSQLSERVER02\MSSQL\DATA\LibrarySystemLog',
	size=10MB,
	maxsize=unlimited,
	filegrowth=1MB
)




