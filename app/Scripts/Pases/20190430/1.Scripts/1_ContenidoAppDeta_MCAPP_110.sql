USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDeta') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoAppDeta
GO
CREATE TABLE dbo.ContenidoAppDeta
(
	IdContenidoDeta int NOT NULL IDENTITY (1, 1),
	IdContenido int NULL,
	CodigoDetalle varchar(150) NULL,
	Descripcion varchar(250) NULL,
	RutaContenido varchar(250) NULL,
	Accion varchar(20) NULL,
	Orden int NULL,
	Estado bit NULL,
	Tipo VARCHAR(25)
) 
GO
ALTER TABLE dbo.ContenidoAppDeta ADD CONSTRAINT PK_ContenidoAppDeta PRIMARY KEY (IdContenidoDeta) 
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDeta') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoAppDeta
GO
CREATE TABLE dbo.ContenidoAppDeta
(
	IdContenidoDeta int NOT NULL IDENTITY (1, 1),
	IdContenido int NULL,
	CodigoDetalle varchar(150) NULL,
	Descripcion varchar(250) NULL,
	RutaContenido varchar(250) NULL,
	Accion varchar(20) NULL,
	Orden int NULL,
	Estado bit NULL,
	Tipo VARCHAR(25)
) 
GO
ALTER TABLE dbo.ContenidoAppDeta ADD CONSTRAINT PK_ContenidoAppDeta PRIMARY KEY (IdContenidoDeta) 
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDeta') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoAppDeta
GO
CREATE TABLE dbo.ContenidoAppDeta
(
	IdContenidoDeta int NOT NULL IDENTITY (1, 1),
	IdContenido int NULL,
	CodigoDetalle varchar(150) NULL,
	Descripcion varchar(250) NULL,
	RutaContenido varchar(250) NULL,
	Accion varchar(20) NULL,
	Orden int NULL,
	Estado bit NULL,
	Tipo VARCHAR(25)
) 
GO
ALTER TABLE dbo.ContenidoAppDeta ADD CONSTRAINT PK_ContenidoAppDeta PRIMARY KEY (IdContenidoDeta) 
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDeta') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoAppDeta
GO
CREATE TABLE dbo.ContenidoAppDeta
(
	IdContenidoDeta int NOT NULL IDENTITY (1, 1),
	IdContenido int NULL,
	CodigoDetalle varchar(150) NULL,
	Descripcion varchar(250) NULL,
	RutaContenido varchar(250) NULL,
	Accion varchar(20) NULL,
	Orden int NULL,
	Estado bit NULL,
	Tipo VARCHAR(25)
) 
GO
ALTER TABLE dbo.ContenidoAppDeta ADD CONSTRAINT PK_ContenidoAppDeta PRIMARY KEY (IdContenidoDeta) 
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDeta') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoAppDeta
GO
CREATE TABLE dbo.ContenidoAppDeta
(
	IdContenidoDeta int NOT NULL IDENTITY (1, 1),
	IdContenido int NULL,
	CodigoDetalle varchar(150) NULL,
	Descripcion varchar(250) NULL,
	RutaContenido varchar(250) NULL,
	Accion varchar(20) NULL,
	Orden int NULL,
	Estado bit NULL,
	Tipo VARCHAR(25)
) 
GO
ALTER TABLE dbo.ContenidoAppDeta ADD CONSTRAINT PK_ContenidoAppDeta PRIMARY KEY (IdContenidoDeta) 
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDeta') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoAppDeta
GO
CREATE TABLE dbo.ContenidoAppDeta
(
	IdContenidoDeta int NOT NULL IDENTITY (1, 1),
	IdContenido int NULL,
	CodigoDetalle varchar(150) NULL,
	Descripcion varchar(250) NULL,
	RutaContenido varchar(250) NULL,
	Accion varchar(20) NULL,
	Orden int NULL,
	Estado bit NULL,
	Tipo VARCHAR(25)
) 
GO
ALTER TABLE dbo.ContenidoAppDeta ADD CONSTRAINT PK_ContenidoAppDeta PRIMARY KEY (IdContenidoDeta) 
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDeta') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoAppDeta
GO
CREATE TABLE dbo.ContenidoAppDeta
(
	IdContenidoDeta int NOT NULL IDENTITY (1, 1),
	IdContenido int NULL,
	CodigoDetalle varchar(150) NULL,
	Descripcion varchar(250) NULL,
	RutaContenido varchar(250) NULL,
	Accion varchar(20) NULL,
	Orden int NULL,
	Estado bit NULL,
	Tipo VARCHAR(25)
) 
GO
ALTER TABLE dbo.ContenidoAppDeta ADD CONSTRAINT PK_ContenidoAppDeta PRIMARY KEY (IdContenidoDeta) 
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDeta') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoAppDeta
GO
CREATE TABLE dbo.ContenidoAppDeta
(
	IdContenidoDeta int NOT NULL IDENTITY (1, 1),
	IdContenido int NULL,
	CodigoDetalle varchar(150) NULL,
	Descripcion varchar(250) NULL,
	RutaContenido varchar(250) NULL,
	Accion varchar(20) NULL,
	Orden int NULL,
	Estado bit NULL,
	Tipo VARCHAR(25)
) 
GO
ALTER TABLE dbo.ContenidoAppDeta ADD CONSTRAINT PK_ContenidoAppDeta PRIMARY KEY (IdContenidoDeta) 
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDeta') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoAppDeta
GO
CREATE TABLE dbo.ContenidoAppDeta
(
	IdContenidoDeta int NOT NULL IDENTITY (1, 1),
	IdContenido int NULL,
	CodigoDetalle varchar(150) NULL,
	Descripcion varchar(250) NULL,
	RutaContenido varchar(250) NULL,
	Accion varchar(20) NULL,
	Orden int NULL,
	Estado bit NULL,
	Tipo VARCHAR(25)
) 
GO
ALTER TABLE dbo.ContenidoAppDeta ADD CONSTRAINT PK_ContenidoAppDeta PRIMARY KEY (IdContenidoDeta) 
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDeta') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoAppDeta
GO
CREATE TABLE dbo.ContenidoAppDeta
(
	IdContenidoDeta int NOT NULL IDENTITY (1, 1),
	IdContenido int NULL,
	CodigoDetalle varchar(150) NULL,
	Descripcion varchar(250) NULL,
	RutaContenido varchar(250) NULL,
	Accion varchar(20) NULL,
	Orden int NULL,
	Estado bit NULL,
	Tipo VARCHAR(25)
) 
GO
ALTER TABLE dbo.ContenidoAppDeta ADD CONSTRAINT PK_ContenidoAppDeta PRIMARY KEY (IdContenidoDeta) 
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDeta') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoAppDeta
GO
CREATE TABLE dbo.ContenidoAppDeta
(
	IdContenidoDeta int NOT NULL IDENTITY (1, 1),
	IdContenido int NULL,
	CodigoDetalle varchar(150) NULL,
	Descripcion varchar(250) NULL,
	RutaContenido varchar(250) NULL,
	Accion varchar(20) NULL,
	Orden int NULL,
	Estado bit NULL,
	Tipo VARCHAR(25)
) 
GO
ALTER TABLE dbo.ContenidoAppDeta ADD CONSTRAINT PK_ContenidoAppDeta PRIMARY KEY (IdContenidoDeta) 
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.ContenidoAppDeta') AND TYPE = 'U')
   DROP TABLE dbo.ContenidoAppDeta
GO
CREATE TABLE dbo.ContenidoAppDeta
(
	IdContenidoDeta int NOT NULL IDENTITY (1, 1),
	IdContenido int NULL,
	CodigoDetalle varchar(150) NULL,
	Descripcion varchar(250) NULL,
	RutaContenido varchar(250) NULL,
	Accion varchar(20) NULL,
	Orden int NULL,
	Estado bit NULL,
	Tipo VARCHAR(25)
) 
GO
ALTER TABLE dbo.ContenidoAppDeta ADD CONSTRAINT PK_ContenidoAppDeta PRIMARY KEY (IdContenidoDeta) 
GO

