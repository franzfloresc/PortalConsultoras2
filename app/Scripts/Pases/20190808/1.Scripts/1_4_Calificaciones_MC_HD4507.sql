USE [BelcorpBolivia];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	CONSTRAINT PK_CalificacionID PRIMARY KEY (CalificacionID),
	CONSTRAINT FK_Calificaciones_TipoCalificacionID FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
USE [BelcorpChile];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	CONSTRAINT PK_CalificacionID PRIMARY KEY (CalificacionID),
	CONSTRAINT FK_Calificaciones_TipoCalificacionID FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
USE [BelcorpColombia];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	CONSTRAINT PK_CalificacionID PRIMARY KEY (CalificacionID),
	CONSTRAINT FK_Calificaciones_TipoCalificacionID FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
USE [BelcorpCostaRica];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	CONSTRAINT PK_CalificacionID PRIMARY KEY (CalificacionID),
	CONSTRAINT FK_Calificaciones_TipoCalificacionID FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
USE [BelcorpDominicana];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	CONSTRAINT PK_CalificacionID PRIMARY KEY (CalificacionID),
	CONSTRAINT FK_Calificaciones_TipoCalificacionID FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
USE [BelcorpEcuador];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	CONSTRAINT PK_CalificacionID PRIMARY KEY (CalificacionID),
	CONSTRAINT FK_Calificaciones_TipoCalificacionID FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
USE [BelcorpGuatemala];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	CONSTRAINT PK_CalificacionID PRIMARY KEY (CalificacionID),
	CONSTRAINT FK_Calificaciones_TipoCalificacionID FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
USE [BelcorpMexico];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	CONSTRAINT PK_CalificacionID PRIMARY KEY (CalificacionID),
	CONSTRAINT FK_Calificaciones_TipoCalificacionID FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
USE [BelcorpPanama];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	CONSTRAINT PK_CalificacionID PRIMARY KEY (CalificacionID),
	CONSTRAINT FK_Calificaciones_TipoCalificacionID FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
USE [BelcorpPeru];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	CONSTRAINT PK_CalificacionID PRIMARY KEY (CalificacionID),
	CONSTRAINT FK_Calificaciones_TipoCalificacionID FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
USE [BelcorpPuertoRico];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	CONSTRAINT PK_CalificacionID PRIMARY KEY (CalificacionID),
	CONSTRAINT FK_Calificaciones_TipoCalificacionID FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
USE [BelcorpSalvador];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (OBJECT_ID(N'FK_Calificaciones_TipoCalificacionID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT FK_Calificaciones_TipoCalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	CONSTRAINT PK_CalificacionID PRIMARY KEY (CalificacionID),
	CONSTRAINT FK_Calificaciones_TipoCalificacionID FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
