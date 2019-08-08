GO
USE BelcorpPeru
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

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
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpMexico
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

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
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpColombia
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

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
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpSalvador
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

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
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpPuertoRico
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

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
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpPanama
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

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
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpGuatemala
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

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
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpEcuador
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

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
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpDominicana
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

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
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpCostaRica
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

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
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpChile
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

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
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpBolivia
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

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
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
