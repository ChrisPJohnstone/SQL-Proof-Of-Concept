Use [master]
Go

--Create Database Example
If(db_id(N'TestDB') IS NULL)
Create Database [TestDB]
Go

Use [TestDB]
Go

--Create Table with Clustered Index and Composite Primary Key
If OBJECT_ID('[TestDB].[dbo].[Applicant Data]') is null
Create Table [Applicant Data] (
[Application Date] date not null
, [Applicant Name] varchar(25) not null
, [Position] varchar(25) null
, [Applicant Phone Number] varchar(15) null
, Constraint [Prevent Duplicates And Store Date Descending] Primary Key ([Application Date] desc, [Applicant Name] asc))

--Create Nonclustered index on existing table example
If Not Exists (Select Name From sysindexes Where Name = 'MPN Key')
Create Nonclustered Index [MPN Key] On [dbo].[Applicant Data] ([Applicant Phone Number])

--Declaring Variables example
Declare @DynamicSQLColumns nvarchar(max) = ''
Declare @DynamicSQLQuery nvarchar(max) = ''
Declare @Date Date = GetDate();

--Transaction Example
Begin Tran
	
	--Insert Example
	Insert Into [Applicant Data] ([Application Date], [Applicant Name])
	Select
		@Date [Application Date]
		, 'Christopher Johnstone' [Applicant Name]

	--Update Example
	Update [Applicant Data]
	Set [Position] = 'SQL BI Developer'
	, [Applicant Phone Number] = '07481924931'
	Where [Applicant Name] = 'Christopher Johnstone'

Commit;

--Common Table Expression Example
With CTE as (SELECT [name] FROM sys.columns WHERE object_id = OBJECT_ID('[TestDB].[dbo].[Applicant Data]'))

--Dynamic SQL example
Select @DynamicSQLColumns += QUOTENAME([name]) + ','
From CTE

Set @DynamicSQLColumns = LEFT(@DynamicSQLColumns, LEN(@DynamicSQLColumns)-1)
Set @DynamicSQLQuery = 'Select ' + CAST(@DynamicSQLColumns as nvarchar(max)) + 'From [TestDB].[dbo].[Applicant Data]'
Exec sp_executesql @DynamicSQLQuery

Use [master]
Go

--Drop Database Example / Cleanup
Drop Database [TestDB]
Go
