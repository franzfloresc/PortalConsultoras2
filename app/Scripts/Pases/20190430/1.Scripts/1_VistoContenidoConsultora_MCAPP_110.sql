USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.VistoContenidoConsultora') AND TYPE = 'U')
   DROP TABLE dbo.VistoContenidoConsultora
GO
CREATE TABLE dbo.VistoContenidoConsultora
(
	IdVistoContenido int NOT NULL IDENTITY (1, 1),
	CodigoConsultora varchar(20) NULL,
	IdContenidoDeta int NULL,
	FechaVisto date NULL
)
GO
ALTER TABLE dbo.VistoContenidoConsultora ADD CONSTRAINT PK_VistoContenidoConsultora PRIMARY KEY (IdVistoContenido) 
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.VistoContenidoConsultora') AND TYPE = 'U')
   DROP TABLE dbo.VistoContenidoConsultora
GO
CREATE TABLE dbo.VistoContenidoConsultora
(
	IdVistoContenido int NOT NULL IDENTITY (1, 1),
	CodigoConsultora varchar(20) NULL,
	IdContenidoDeta int NULL,
	FechaVisto date NULL
)
GO
ALTER TABLE dbo.VistoContenidoConsultora ADD CONSTRAINT PK_VistoContenidoConsultora PRIMARY KEY (IdVistoContenido) 
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.VistoContenidoConsultora') AND TYPE = 'U')
   DROP TABLE dbo.VistoContenidoConsultora
GO
CREATE TABLE dbo.VistoContenidoConsultora
(
	IdVistoContenido int NOT NULL IDENTITY (1, 1),
	CodigoConsultora varchar(20) NULL,
	IdContenidoDeta int NULL,
	FechaVisto date NULL
)
GO
ALTER TABLE dbo.VistoContenidoConsultora ADD CONSTRAINT PK_VistoContenidoConsultora PRIMARY KEY (IdVistoContenido) 
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.VistoContenidoConsultora') AND TYPE = 'U')
   DROP TABLE dbo.VistoContenidoConsultora
GO
CREATE TABLE dbo.VistoContenidoConsultora
(
	IdVistoContenido int NOT NULL IDENTITY (1, 1),
	CodigoConsultora varchar(20) NULL,
	IdContenidoDeta int NULL,
	FechaVisto date NULL
)
GO
ALTER TABLE dbo.VistoContenidoConsultora ADD CONSTRAINT PK_VistoContenidoConsultora PRIMARY KEY (IdVistoContenido) 
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.VistoContenidoConsultora') AND TYPE = 'U')
   DROP TABLE dbo.VistoContenidoConsultora
GO
CREATE TABLE dbo.VistoContenidoConsultora
(
	IdVistoContenido int NOT NULL IDENTITY (1, 1),
	CodigoConsultora varchar(20) NULL,
	IdContenidoDeta int NULL,
	FechaVisto date NULL
)
GO
ALTER TABLE dbo.VistoContenidoConsultora ADD CONSTRAINT PK_VistoContenidoConsultora PRIMARY KEY (IdVistoContenido) 
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.VistoContenidoConsultora') AND TYPE = 'U')
   DROP TABLE dbo.VistoContenidoConsultora
GO
CREATE TABLE dbo.VistoContenidoConsultora
(
	IdVistoContenido int NOT NULL IDENTITY (1, 1),
	CodigoConsultora varchar(20) NULL,
	IdContenidoDeta int NULL,
	FechaVisto date NULL
)
GO
ALTER TABLE dbo.VistoContenidoConsultora ADD CONSTRAINT PK_VistoContenidoConsultora PRIMARY KEY (IdVistoContenido) 
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.VistoContenidoConsultora') AND TYPE = 'U')
   DROP TABLE dbo.VistoContenidoConsultora
GO
CREATE TABLE dbo.VistoContenidoConsultora
(
	IdVistoContenido int NOT NULL IDENTITY (1, 1),
	CodigoConsultora varchar(20) NULL,
	IdContenidoDeta int NULL,
	FechaVisto date NULL
)
GO
ALTER TABLE dbo.VistoContenidoConsultora ADD CONSTRAINT PK_VistoContenidoConsultora PRIMARY KEY (IdVistoContenido) 
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.VistoContenidoConsultora') AND TYPE = 'U')
   DROP TABLE dbo.VistoContenidoConsultora
GO
CREATE TABLE dbo.VistoContenidoConsultora
(
	IdVistoContenido int NOT NULL IDENTITY (1, 1),
	CodigoConsultora varchar(20) NULL,
	IdContenidoDeta int NULL,
	FechaVisto date NULL
)
GO
ALTER TABLE dbo.VistoContenidoConsultora ADD CONSTRAINT PK_VistoContenidoConsultora PRIMARY KEY (IdVistoContenido) 
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.VistoContenidoConsultora') AND TYPE = 'U')
   DROP TABLE dbo.VistoContenidoConsultora
GO
CREATE TABLE dbo.VistoContenidoConsultora
(
	IdVistoContenido int NOT NULL IDENTITY (1, 1),
	CodigoConsultora varchar(20) NULL,
	IdContenidoDeta int NULL,
	FechaVisto date NULL
)
GO
ALTER TABLE dbo.VistoContenidoConsultora ADD CONSTRAINT PK_VistoContenidoConsultora PRIMARY KEY (IdVistoContenido) 
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.VistoContenidoConsultora') AND TYPE = 'U')
   DROP TABLE dbo.VistoContenidoConsultora
GO
CREATE TABLE dbo.VistoContenidoConsultora
(
	IdVistoContenido int NOT NULL IDENTITY (1, 1),
	CodigoConsultora varchar(20) NULL,
	IdContenidoDeta int NULL,
	FechaVisto date NULL
)
GO
ALTER TABLE dbo.VistoContenidoConsultora ADD CONSTRAINT PK_VistoContenidoConsultora PRIMARY KEY (IdVistoContenido) 
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.VistoContenidoConsultora') AND TYPE = 'U')
   DROP TABLE dbo.VistoContenidoConsultora
GO
CREATE TABLE dbo.VistoContenidoConsultora
(
	IdVistoContenido int NOT NULL IDENTITY (1, 1),
	CodigoConsultora varchar(20) NULL,
	IdContenidoDeta int NULL,
	FechaVisto date NULL
)
GO
ALTER TABLE dbo.VistoContenidoConsultora ADD CONSTRAINT PK_VistoContenidoConsultora PRIMARY KEY (IdVistoContenido) 
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.VistoContenidoConsultora') AND TYPE = 'U')
   DROP TABLE dbo.VistoContenidoConsultora
GO
CREATE TABLE dbo.VistoContenidoConsultora
(
	IdVistoContenido int NOT NULL IDENTITY (1, 1),
	CodigoConsultora varchar(20) NULL,
	IdContenidoDeta int NULL,
	FechaVisto date NULL
)
GO
ALTER TABLE dbo.VistoContenidoConsultora ADD CONSTRAINT PK_VistoContenidoConsultora PRIMARY KEY (IdVistoContenido) 
GO

