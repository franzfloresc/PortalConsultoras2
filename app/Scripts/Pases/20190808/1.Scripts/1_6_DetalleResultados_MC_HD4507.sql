USE [BelcorpBolivia];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	CONSTRAINT PK_DetalleResultadoID PRIMARY KEY (DetalleResultadoID),
	CONSTRAINT FK_DetalleResultados_ResultadosID FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	CONSTRAINT FK_DetalleResultados_PreguntaID FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	CONSTRAINT FK_DetalleResultados_CalificacionID FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);
GO
USE [BelcorpChile];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	CONSTRAINT PK_DetalleResultadoID PRIMARY KEY (DetalleResultadoID),
	CONSTRAINT FK_DetalleResultados_ResultadosID FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	CONSTRAINT FK_DetalleResultados_PreguntaID FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	CONSTRAINT FK_DetalleResultados_CalificacionID FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);
GO
USE [BelcorpColombia];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	CONSTRAINT PK_DetalleResultadoID PRIMARY KEY (DetalleResultadoID),
	CONSTRAINT FK_DetalleResultados_ResultadosID FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	CONSTRAINT FK_DetalleResultados_PreguntaID FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	CONSTRAINT FK_DetalleResultados_CalificacionID FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);
GO
USE [BelcorpCostaRica];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	CONSTRAINT PK_DetalleResultadoID PRIMARY KEY (DetalleResultadoID),
	CONSTRAINT FK_DetalleResultados_ResultadosID FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	CONSTRAINT FK_DetalleResultados_PreguntaID FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	CONSTRAINT FK_DetalleResultados_CalificacionID FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);
GO
USE [BelcorpDominicana];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	CONSTRAINT PK_DetalleResultadoID PRIMARY KEY (DetalleResultadoID),
	CONSTRAINT FK_DetalleResultados_ResultadosID FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	CONSTRAINT FK_DetalleResultados_PreguntaID FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	CONSTRAINT FK_DetalleResultados_CalificacionID FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);
GO
USE [BelcorpEcuador];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	CONSTRAINT PK_DetalleResultadoID PRIMARY KEY (DetalleResultadoID),
	CONSTRAINT FK_DetalleResultados_ResultadosID FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	CONSTRAINT FK_DetalleResultados_PreguntaID FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	CONSTRAINT FK_DetalleResultados_CalificacionID FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);
GO
USE [BelcorpGuatemala];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	CONSTRAINT PK_DetalleResultadoID PRIMARY KEY (DetalleResultadoID),
	CONSTRAINT FK_DetalleResultados_ResultadosID FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	CONSTRAINT FK_DetalleResultados_PreguntaID FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	CONSTRAINT FK_DetalleResultados_CalificacionID FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);
GO
USE [BelcorpMexico];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	CONSTRAINT PK_DetalleResultadoID PRIMARY KEY (DetalleResultadoID),
	CONSTRAINT FK_DetalleResultados_ResultadosID FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	CONSTRAINT FK_DetalleResultados_PreguntaID FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	CONSTRAINT FK_DetalleResultados_CalificacionID FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);
GO
USE [BelcorpPanama];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	CONSTRAINT PK_DetalleResultadoID PRIMARY KEY (DetalleResultadoID),
	CONSTRAINT FK_DetalleResultados_ResultadosID FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	CONSTRAINT FK_DetalleResultados_PreguntaID FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	CONSTRAINT FK_DetalleResultados_CalificacionID FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);
GO
USE [BelcorpPeru];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	CONSTRAINT PK_DetalleResultadoID PRIMARY KEY (DetalleResultadoID),
	CONSTRAINT FK_DetalleResultados_ResultadosID FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	CONSTRAINT FK_DetalleResultados_PreguntaID FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	CONSTRAINT FK_DetalleResultados_CalificacionID FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);
GO
USE [BelcorpPuertoRico];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	CONSTRAINT PK_DetalleResultadoID PRIMARY KEY (DetalleResultadoID),
	CONSTRAINT FK_DetalleResultados_ResultadosID FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	CONSTRAINT FK_DetalleResultados_PreguntaID FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	CONSTRAINT FK_DetalleResultados_CalificacionID FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);
GO
USE [BelcorpSalvador];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (OBJECT_ID(N'FK_DetalleResultados_ResultadosID', 'F') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT FK_DetalleResultados_ResultadosID,FK_DetalleResultados_PreguntaID,FK_DetalleResultados_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	CONSTRAINT PK_DetalleResultadoID PRIMARY KEY (DetalleResultadoID),
	CONSTRAINT FK_DetalleResultados_ResultadosID FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	CONSTRAINT FK_DetalleResultados_PreguntaID FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	CONSTRAINT FK_DetalleResultados_CalificacionID FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);
GO
