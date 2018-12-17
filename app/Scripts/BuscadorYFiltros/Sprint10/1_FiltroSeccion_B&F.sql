GO
USE BelcorpPeru
GO
GO
IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.FiltroSeccion') AND TYPE = 'U')
   DROP TABLE DBO.FiltroSeccion
GO
CREATE TABLE FiltroSeccion(
	Id int primary key identity (1,1),
	TablaLogicaDatosId int,
	CampoES varchar(100),
	TipoOperadorES varchar(100)
)
GO

GO
USE BelcorpMexico
GO
GO
IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.FiltroSeccion') AND TYPE = 'U')
   DROP TABLE DBO.FiltroSeccion
GO
CREATE TABLE FiltroSeccion(
	Id int primary key identity (1,1),
	TablaLogicaDatosId int,
	CampoES varchar(100),
	TipoOperadorES varchar(100)
)
GO

GO
USE BelcorpColombia
GO
GO
IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.FiltroSeccion') AND TYPE = 'U')
   DROP TABLE DBO.FiltroSeccion
GO
CREATE TABLE FiltroSeccion(
	Id int primary key identity (1,1),
	TablaLogicaDatosId int,
	CampoES varchar(100),
	TipoOperadorES varchar(100)
)
GO

GO
USE BelcorpSalvador
GO
GO
IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.FiltroSeccion') AND TYPE = 'U')
   DROP TABLE DBO.FiltroSeccion
GO
CREATE TABLE FiltroSeccion(
	Id int primary key identity (1,1),
	TablaLogicaDatosId int,
	CampoES varchar(100),
	TipoOperadorES varchar(100)
)
GO

GO
USE BelcorpPuertoRico
GO
GO
IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.FiltroSeccion') AND TYPE = 'U')
   DROP TABLE DBO.FiltroSeccion
GO
CREATE TABLE FiltroSeccion(
	Id int primary key identity (1,1),
	TablaLogicaDatosId int,
	CampoES varchar(100),
	TipoOperadorES varchar(100)
)
GO

GO
USE BelcorpPanama
GO
GO
IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.FiltroSeccion') AND TYPE = 'U')
   DROP TABLE DBO.FiltroSeccion
GO
CREATE TABLE FiltroSeccion(
	Id int primary key identity (1,1),
	TablaLogicaDatosId int,
	CampoES varchar(100),
	TipoOperadorES varchar(100)
)
GO

GO
USE BelcorpGuatemala
GO
GO
IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.FiltroSeccion') AND TYPE = 'U')
   DROP TABLE DBO.FiltroSeccion
GO
CREATE TABLE FiltroSeccion(
	Id int primary key identity (1,1),
	TablaLogicaDatosId int,
	CampoES varchar(100),
	TipoOperadorES varchar(100)
)
GO

GO
USE BelcorpEcuador
GO
GO
IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.FiltroSeccion') AND TYPE = 'U')
   DROP TABLE DBO.FiltroSeccion
GO
CREATE TABLE FiltroSeccion(
	Id int primary key identity (1,1),
	TablaLogicaDatosId int,
	CampoES varchar(100),
	TipoOperadorES varchar(100)
)
GO

GO
USE BelcorpDominicana
GO
GO
IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.FiltroSeccion') AND TYPE = 'U')
   DROP TABLE DBO.FiltroSeccion
GO
CREATE TABLE FiltroSeccion(
	Id int primary key identity (1,1),
	TablaLogicaDatosId int,
	CampoES varchar(100),
	TipoOperadorES varchar(100)
)
GO

GO
USE BelcorpCostaRica
GO
GO
IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.FiltroSeccion') AND TYPE = 'U')
   DROP TABLE DBO.FiltroSeccion
GO
CREATE TABLE FiltroSeccion(
	Id int primary key identity (1,1),
	TablaLogicaDatosId int,
	CampoES varchar(100),
	TipoOperadorES varchar(100)
)
GO

GO
USE BelcorpChile
GO
GO
IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.FiltroSeccion') AND TYPE = 'U')
   DROP TABLE DBO.FiltroSeccion
GO
CREATE TABLE FiltroSeccion(
	Id int primary key identity (1,1),
	TablaLogicaDatosId int,
	CampoES varchar(100),
	TipoOperadorES varchar(100)
)
GO

GO
USE BelcorpBolivia
GO
GO
IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.FiltroSeccion') AND TYPE = 'U')
   DROP TABLE DBO.FiltroSeccion
GO
CREATE TABLE FiltroSeccion(
	Id int primary key identity (1,1),
	TablaLogicaDatosId int,
	CampoES varchar(100),
	TipoOperadorES varchar(100)
)
GO

GO
