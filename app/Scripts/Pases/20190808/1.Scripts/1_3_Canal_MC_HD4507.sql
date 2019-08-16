USE [BelcorpBolivia];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	CONSTRAINT PK_CanalID PRIMARY KEY (CanalID)
);
GO
USE [BelcorpChile];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	CONSTRAINT PK_CanalID PRIMARY KEY (CanalID)
);
GO
USE [BelcorpColombia];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	CONSTRAINT PK_CanalID PRIMARY KEY (CanalID)
);
GO
USE [BelcorpCostaRica];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	CONSTRAINT PK_CanalID PRIMARY KEY (CanalID)
);
GO
USE [BelcorpDominicana];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	CONSTRAINT PK_CanalID PRIMARY KEY (CanalID)
);
GO
USE [BelcorpEcuador];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	CONSTRAINT PK_CanalID PRIMARY KEY (CanalID)
);
GO
USE [BelcorpGuatemala];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	CONSTRAINT PK_CanalID PRIMARY KEY (CanalID)
);
GO
USE [BelcorpMexico];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	CONSTRAINT PK_CanalID PRIMARY KEY (CanalID)
);
GO
USE [BelcorpPanama];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	CONSTRAINT PK_CanalID PRIMARY KEY (CanalID)
);
GO
USE [BelcorpPeru];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	CONSTRAINT PK_CanalID PRIMARY KEY (CanalID)
);
GO
USE [BelcorpPuertoRico];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	CONSTRAINT PK_CanalID PRIMARY KEY (CanalID)
);
GO
USE [BelcorpSalvador];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	CONSTRAINT PK_CanalID PRIMARY KEY (CanalID)
);
GO
