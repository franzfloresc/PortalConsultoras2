USE [BelcorpBolivia];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	CONSTRAINT PK_ResultadosID PRIMARY KEY (ResultadosID),
	CONSTRAINT FK_Resultados_CanalID FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);
GO
USE [BelcorpChile];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	CONSTRAINT PK_ResultadosID PRIMARY KEY (ResultadosID),
	CONSTRAINT FK_Resultados_CanalID FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);
GO
USE [BelcorpColombia];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	CONSTRAINT PK_ResultadosID PRIMARY KEY (ResultadosID),
	CONSTRAINT FK_Resultados_CanalID FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);
GO
USE [BelcorpCostaRica];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	CONSTRAINT PK_ResultadosID PRIMARY KEY (ResultadosID),
	CONSTRAINT FK_Resultados_CanalID FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);
GO
USE [BelcorpDominicana];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	CONSTRAINT PK_ResultadosID PRIMARY KEY (ResultadosID),
	CONSTRAINT FK_Resultados_CanalID FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);
GO
USE [BelcorpEcuador];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	CONSTRAINT PK_ResultadosID PRIMARY KEY (ResultadosID),
	CONSTRAINT FK_Resultados_CanalID FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);
GO
USE [BelcorpGuatemala];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	CONSTRAINT PK_ResultadosID PRIMARY KEY (ResultadosID),
	CONSTRAINT FK_Resultados_CanalID FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);
GO
USE [BelcorpMexico];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	CONSTRAINT PK_ResultadosID PRIMARY KEY (ResultadosID),
	CONSTRAINT FK_Resultados_CanalID FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);
GO
USE [BelcorpPanama];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	CONSTRAINT PK_ResultadosID PRIMARY KEY (ResultadosID),
	CONSTRAINT FK_Resultados_CanalID FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);
GO
USE [BelcorpPeru];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	CONSTRAINT PK_ResultadosID PRIMARY KEY (ResultadosID),
	CONSTRAINT FK_Resultados_CanalID FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);
GO
USE [BelcorpPuertoRico];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	CONSTRAINT PK_ResultadosID PRIMARY KEY (ResultadosID),
	CONSTRAINT FK_Resultados_CanalID FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);
GO
USE [BelcorpSalvador];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (OBJECT_ID(N'FK_Resultados_CanalID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT FK_Resultados_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	CONSTRAINT PK_ResultadosID PRIMARY KEY (ResultadosID),
	CONSTRAINT FK_Resultados_CanalID FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);
GO
