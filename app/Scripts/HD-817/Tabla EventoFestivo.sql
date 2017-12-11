USE BelcorpPeru
GO

IF NOT EXISTS (select * from sys.objects where type = 'U' and name = 'EventoFestivo')
BEGIN
CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)
END
GO

USE BelcorpMexico
GO

IF NOT EXISTS (select * from sys.objects where type = 'U' and name = 'EventoFestivo')
BEGIN
CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)
END
GO

USE BelcorpColombia
GO

IF NOT EXISTS (select * from sys.objects where type = 'U' and name = 'EventoFestivo')
BEGIN
CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)
END
GO

USE BelcorpVenezuela
GO

IF NOT EXISTS (select * from sys.objects where type = 'U' and name = 'EventoFestivo')
BEGIN
CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)
END
GO

USE BelcorpSalvador
GO

IF NOT EXISTS (select * from sys.objects where type = 'U' and name = 'EventoFestivo')
BEGIN
CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)
END
GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS (select * from sys.objects where type = 'U' and name = 'EventoFestivo')
BEGIN
CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)
END
GO

USE BelcorpPanama
GO

IF NOT EXISTS (select * from sys.objects where type = 'U' and name = 'EventoFestivo')
BEGIN
CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)
END
GO

USE BelcorpGuatemala
GO

IF NOT EXISTS (select * from sys.objects where type = 'U' and name = 'EventoFestivo')
BEGIN
CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)
END
GO

USE BelcorpEcuador
GO

IF NOT EXISTS (select * from sys.objects where type = 'U' and name = 'EventoFestivo')
BEGIN
CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)
END
GO

USE BelcorpDominicana
GO

IF NOT EXISTS (select * from sys.objects where type = 'U' and name = 'EventoFestivo')
BEGIN
CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)
END
GO

USE BelcorpCostaRica
GO

IF NOT EXISTS (select * from sys.objects where type = 'U' and name = 'EventoFestivo')
BEGIN
CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)
END
GO

USE BelcorpChile
GO

IF NOT EXISTS (select * from sys.objects where type = 'U' and name = 'EventoFestivo')
BEGIN
CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)
END
GO

USE BelcorpBolivia
GO

IF NOT EXISTS (select * from sys.objects where type = 'U' and name = 'EventoFestivo')
BEGIN
CREATE TABLE [dbo].[EventoFestivo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Alcance] [varchar](30) NULL,
	[Periodo] [varchar](2) NULL,
	[Inicio] [varchar](15) NULL,
	[Fin] [varchar](15) NULL,
	[Personalizacion] [varchar](max) NULL,
	[Estado] [bit] NULL,
	PRIMARY KEY (ID)
	)
END
GO

