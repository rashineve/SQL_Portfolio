use master
IF DB_ID('mininstagram') IS NULL
	Begin
		CREATE DATABASE MiniInstagram
		PRINT 'Database Created'
	END 

	Begin 
	drop database Mininstagram
	Print 'data base already is there ! ' 
	end 

GO 

/*now we pick up the actual database we wanna 
make changes in */

use mininstagram 
GO 

--builing the schemas 

CREATE SCHEMA NOTIFICATION 
GO 

CREATE SCHEMA PERSONAL
GO 

CREATE SCHEMA [person] 
GO 

CREATE SCHEMA MEDIA 
GO 

--now pouring th++tables into schemas and building them

create table NOTIFICATION.[user]
(
	id int primary key identity
	,username int nvarchar(50) NOT NULL
	,email int nvarchar(50) not null 
	,password text not null ,
	bio )