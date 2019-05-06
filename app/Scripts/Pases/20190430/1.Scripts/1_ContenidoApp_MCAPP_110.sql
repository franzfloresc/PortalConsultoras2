USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoApp') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoApp
GO
CREATE TABLE dbo.ContenidoApp
(
	IdContenido int NOT NULL IDENTITY (1, 1),
	Codigo varchar(150) NULL,
	Descripcion varchar(250) NULL,
	UrlMiniatura varchar(250) NULL,
	Estado bit NULL,
	DesdeCampania int NULL,
	CantidadContenido int,
	RutaImagen varchar(250)
) 
GO
ALTER TABLE dbo.ContenidoApp ADD CONSTRAINT PK_ContenidoApp PRIMARY KEY (IdContenido)
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoApp') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoApp
GO
CREATE TABLE dbo.ContenidoApp
(
	IdContenido int NOT NULL IDENTITY (1, 1),
	Codigo varchar(150) NULL,
	Descripcion varchar(250) NULL,
	UrlMiniatura varchar(250) NULL,
	Estado bit NULL,
	DesdeCampania int NULL,
	CantidadContenido int,
	RutaImagen varchar(250)
) 
GO
ALTER TABLE dbo.ContenidoApp ADD CONSTRAINT PK_ContenidoApp PRIMARY KEY (IdContenido)
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoApp') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoApp
GO
CREATE TABLE dbo.ContenidoApp
(
	IdContenido int NOT NULL IDENTITY (1, 1),
	Codigo varchar(150) NULL,
	Descripcion varchar(250) NULL,
	UrlMiniatura varchar(250) NULL,
	Estado bit NULL,
	DesdeCampania int NULL,
	CantidadContenido int,
	RutaImagen varchar(250)
) 
GO
ALTER TABLE dbo.ContenidoApp ADD CONSTRAINT PK_ContenidoApp PRIMARY KEY (IdContenido)
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoApp') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoApp
GO
CREATE TABLE dbo.ContenidoApp
(
	IdContenido int NOT NULL IDENTITY (1, 1),
	Codigo varchar(150) NULL,
	Descripcion varchar(250) NULL,
	UrlMiniatura varchar(250) NULL,
	Estado bit NULL,
	DesdeCampania int NULL,
	CantidadContenido int,
	RutaImagen varchar(250)
) 
GO
ALTER TABLE dbo.ContenidoApp ADD CONSTRAINT PK_ContenidoApp PRIMARY KEY (IdContenido)
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoApp') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoApp
GO
CREATE TABLE dbo.ContenidoApp
(
	IdContenido int NOT NULL IDENTITY (1, 1),
	Codigo varchar(150) NULL,
	Descripcion varchar(250) NULL,
	UrlMiniatura varchar(250) NULL,
	Estado bit NULL,
	DesdeCampania int NULL,
	CantidadContenido int,
	RutaImagen varchar(250)
) 
GO
ALTER TABLE dbo.ContenidoApp ADD CONSTRAINT PK_ContenidoApp PRIMARY KEY (IdContenido)
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoApp') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoApp
GO
CREATE TABLE dbo.ContenidoApp
(
	IdContenido int NOT NULL IDENTITY (1, 1),
	Codigo varchar(150) NULL,
	Descripcion varchar(250) NULL,
	UrlMiniatura varchar(250) NULL,
	Estado bit NULL,
	DesdeCampania int NULL,
	CantidadContenido int,
	RutaImagen varchar(250)
) 
GO
ALTER TABLE dbo.ContenidoApp ADD CONSTRAINT PK_ContenidoApp PRIMARY KEY (IdContenido)
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoApp') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoApp
GO
CREATE TABLE dbo.ContenidoApp
(
	IdContenido int NOT NULL IDENTITY (1, 1),
	Codigo varchar(150) NULL,
	Descripcion varchar(250) NULL,
	UrlMiniatura varchar(250) NULL,
	Estado bit NULL,
	DesdeCampania int NULL,
	CantidadContenido int,
	RutaImagen varchar(250)
) 
GO
ALTER TABLE dbo.ContenidoApp ADD CONSTRAINT PK_ContenidoApp PRIMARY KEY (IdContenido)
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoApp') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoApp
GO
CREATE TABLE dbo.ContenidoApp
(
	IdContenido int NOT NULL IDENTITY (1, 1),
	Codigo varchar(150) NULL,
	Descripcion varchar(250) NULL,
	UrlMiniatura varchar(250) NULL,
	Estado bit NULL,
	DesdeCampania int NULL,
	CantidadContenido int,
	RutaImagen varchar(250)
) 
GO
ALTER TABLE dbo.ContenidoApp ADD CONSTRAINT PK_ContenidoApp PRIMARY KEY (IdContenido)
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoApp') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoApp
GO
CREATE TABLE dbo.ContenidoApp
(
	IdContenido int NOT NULL IDENTITY (1, 1),
	Codigo varchar(150) NULL,
	Descripcion varchar(250) NULL,
	UrlMiniatura varchar(250) NULL,
	Estado bit NULL,
	DesdeCampania int NULL,
	CantidadContenido int,
	RutaImagen varchar(250)
) 
GO
ALTER TABLE dbo.ContenidoApp ADD CONSTRAINT PK_ContenidoApp PRIMARY KEY (IdContenido)
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoApp') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoApp
GO
CREATE TABLE dbo.ContenidoApp
(
	IdContenido int NOT NULL IDENTITY (1, 1),
	Codigo varchar(150) NULL,
	Descripcion varchar(250) NULL,
	UrlMiniatura varchar(250) NULL,
	Estado bit NULL,
	DesdeCampania int NULL,
	CantidadContenido int,
	RutaImagen varchar(250)
) 
GO
ALTER TABLE dbo.ContenidoApp ADD CONSTRAINT PK_ContenidoApp PRIMARY KEY (IdContenido)
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoApp') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoApp
GO
CREATE TABLE dbo.ContenidoApp
(
	IdContenido int NOT NULL IDENTITY (1, 1),
	Codigo varchar(150) NULL,
	Descripcion varchar(250) NULL,
	UrlMiniatura varchar(250) NULL,
	Estado bit NULL,
	DesdeCampania int NULL,
	CantidadContenido int,
	RutaImagen varchar(250)
) 
GO
ALTER TABLE dbo.ContenidoApp ADD CONSTRAINT PK_ContenidoApp PRIMARY KEY (IdContenido)
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoApp') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoApp
GO
CREATE TABLE dbo.ContenidoApp
(
	IdContenido int NOT NULL IDENTITY (1, 1),
	Codigo varchar(150) NULL,
	Descripcion varchar(250) NULL,
	UrlMiniatura varchar(250) NULL,
	Estado bit NULL,
	DesdeCampania int NULL,
	CantidadContenido int,
	RutaImagen varchar(250)
) 
GO
ALTER TABLE dbo.ContenidoApp ADD CONSTRAINT PK_ContenidoApp PRIMARY KEY (IdContenido)
GO

