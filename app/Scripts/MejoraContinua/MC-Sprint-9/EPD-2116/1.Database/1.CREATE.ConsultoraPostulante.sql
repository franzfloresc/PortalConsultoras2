
USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'ConsultoraPostulante')
BEGIN
  DROP TABLE dbo.ConsultoraPostulante
END
GO

CREATE TABLE [dbo].[ConsultoraPostulante](
	[ConsultoraID] [bigint] NOT NULL,
	[SeccionID] [int] NULL, -- de la zona
	[RegionID] [int] NULL, --de zona
	[ZonaID] [int] NULL,-- UsuarioPostulante.
	[SegmentoID] [int] NULL, -- para ver por marquesina.	
	[TerritorioID] [int] NULL,
	[Codigo] [varchar](25) NULL,
	[PrimerNombre] [varchar](25) NULL,	
	[NombreCompleto] [varchar](200) NULL,
	[AutorizaPedido] [varchar](1) DEFAULT 1 NULL--
)
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'ConsultoraPostulante')
BEGIN
  DROP TABLE dbo.ConsultoraPostulante
END
GO

CREATE TABLE [dbo].[ConsultoraPostulante](
	[ConsultoraID] [bigint] NOT NULL,
	[SeccionID] [int] NULL, -- de la zona
	[RegionID] [int] NULL, --de zona
	[ZonaID] [int] NULL,-- UsuarioPostulante.
	[SegmentoID] [int] NULL, -- para ver por marquesina.	
	[TerritorioID] [int] NULL,
	[Codigo] [varchar](25) NULL,
	[PrimerNombre] [varchar](25) NULL,	
	[NombreCompleto] [varchar](200) NULL,
	[AutorizaPedido] [varchar](1) DEFAULT 1 NULL--
)
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'ConsultoraPostulante')
BEGIN
  DROP TABLE dbo.ConsultoraPostulante
END
GO

CREATE TABLE [dbo].[ConsultoraPostulante](
	[ConsultoraID] [bigint] NOT NULL,
	[SeccionID] [int] NULL, -- de la zona
	[RegionID] [int] NULL, --de zona
	[ZonaID] [int] NULL,-- UsuarioPostulante.
	[SegmentoID] [int] NULL, -- para ver por marquesina.	
	[TerritorioID] [int] NULL,
	[Codigo] [varchar](25) NULL,
	[PrimerNombre] [varchar](25) NULL,	
	[NombreCompleto] [varchar](200) NULL,
	[AutorizaPedido] [varchar](1) DEFAULT 1 NULL--
)
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'ConsultoraPostulante')
BEGIN
  DROP TABLE dbo.ConsultoraPostulante
END
GO

CREATE TABLE [dbo].[ConsultoraPostulante](
	[ConsultoraID] [bigint] NOT NULL,
	[SeccionID] [int] NULL, -- de la zona
	[RegionID] [int] NULL, --de zona
	[ZonaID] [int] NULL,-- UsuarioPostulante.
	[SegmentoID] [int] NULL, -- para ver por marquesina.	
	[TerritorioID] [int] NULL,
	[Codigo] [varchar](25) NULL,
	[PrimerNombre] [varchar](25) NULL,	
	[NombreCompleto] [varchar](200) NULL,
	[AutorizaPedido] [varchar](1) DEFAULT 1 NULL--
)
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'ConsultoraPostulante')
BEGIN
  DROP TABLE dbo.ConsultoraPostulante
END
GO

CREATE TABLE [dbo].[ConsultoraPostulante](
	[ConsultoraID] [bigint] NOT NULL,
	[SeccionID] [int] NULL, -- de la zona
	[RegionID] [int] NULL, --de zona
	[ZonaID] [int] NULL,-- UsuarioPostulante.
	[SegmentoID] [int] NULL, -- para ver por marquesina.	
	[TerritorioID] [int] NULL,
	[Codigo] [varchar](25) NULL,
	[PrimerNombre] [varchar](25) NULL,	
	[NombreCompleto] [varchar](200) NULL,
	[AutorizaPedido] [varchar](1) DEFAULT 1 NULL--
)
GO
/*end*/

USE BelcorpEcuador
GO


IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'ConsultoraPostulante')
BEGIN
  DROP TABLE dbo.ConsultoraPostulante
END
GO

CREATE TABLE [dbo].[ConsultoraPostulante](
	[ConsultoraID] [bigint] NOT NULL,
	[SeccionID] [int] NULL, -- de la zona
	[RegionID] [int] NULL, --de zona
	[ZonaID] [int] NULL,-- UsuarioPostulante.
	[SegmentoID] [int] NULL, -- para ver por marquesina.	
	[TerritorioID] [int] NULL,
	[Codigo] [varchar](25) NULL,
	[PrimerNombre] [varchar](25) NULL,	
	[NombreCompleto] [varchar](200) NULL,
	[AutorizaPedido] [varchar](1) DEFAULT 1 NULL--
)
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'ConsultoraPostulante')
BEGIN
  DROP TABLE dbo.ConsultoraPostulante
END
GO

CREATE TABLE [dbo].[ConsultoraPostulante](
	[ConsultoraID] [bigint] NOT NULL,
	[SeccionID] [int] NULL, -- de la zona
	[RegionID] [int] NULL, --de zona
	[ZonaID] [int] NULL,-- UsuarioPostulante.
	[SegmentoID] [int] NULL, -- para ver por marquesina.	
	[TerritorioID] [int] NULL,
	[Codigo] [varchar](25) NULL,
	[PrimerNombre] [varchar](25) NULL,	
	[NombreCompleto] [varchar](200) NULL,
	[AutorizaPedido] [varchar](1) DEFAULT 1 NULL--
)
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'ConsultoraPostulante')
BEGIN
  DROP TABLE dbo.ConsultoraPostulante
END
GO

CREATE TABLE [dbo].[ConsultoraPostulante](
	[ConsultoraID] [bigint] NOT NULL,
	[SeccionID] [int] NULL, -- de la zona
	[RegionID] [int] NULL, --de zona
	[ZonaID] [int] NULL,-- UsuarioPostulante.
	[SegmentoID] [int] NULL, -- para ver por marquesina.	
	[TerritorioID] [int] NULL,
	[Codigo] [varchar](25) NULL,
	[PrimerNombre] [varchar](25) NULL,	
	[NombreCompleto] [varchar](200) NULL,
	[AutorizaPedido] [varchar](1) DEFAULT 1 NULL--
)
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'ConsultoraPostulante')
BEGIN
  DROP TABLE dbo.ConsultoraPostulante
END
GO

CREATE TABLE [dbo].[ConsultoraPostulante](
	[ConsultoraID] [bigint] NOT NULL,
	[SeccionID] [int] NULL, -- de la zona
	[RegionID] [int] NULL, --de zona
	[ZonaID] [int] NULL,-- UsuarioPostulante.
	[SegmentoID] [int] NULL, -- para ver por marquesina.	
	[TerritorioID] [int] NULL,
	[Codigo] [varchar](25) NULL,
	[PrimerNombre] [varchar](25) NULL,	
	[NombreCompleto] [varchar](200) NULL,
	[AutorizaPedido] [varchar](1) DEFAULT 1 NULL--
)
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'ConsultoraPostulante')
BEGIN
  DROP TABLE dbo.ConsultoraPostulante
END
GO

CREATE TABLE [dbo].[ConsultoraPostulante](
	[ConsultoraID] [bigint] NOT NULL,
	[SeccionID] [int] NULL, -- de la zona
	[RegionID] [int] NULL, --de zona
	[ZonaID] [int] NULL,-- UsuarioPostulante.
	[SegmentoID] [int] NULL, -- para ver por marquesina.	
	[TerritorioID] [int] NULL,
	[Codigo] [varchar](25) NULL,
	[PrimerNombre] [varchar](25) NULL,	
	[NombreCompleto] [varchar](200) NULL,
	[AutorizaPedido] [varchar](1) DEFAULT 1 NULL--
)
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'ConsultoraPostulante')
BEGIN
  DROP TABLE dbo.ConsultoraPostulante
END
GO

CREATE TABLE [dbo].[ConsultoraPostulante](
	[ConsultoraID] [bigint] NOT NULL,
	[SeccionID] [int] NULL, -- de la zona
	[RegionID] [int] NULL, --de zona
	[ZonaID] [int] NULL,-- UsuarioPostulante.
	[SegmentoID] [int] NULL, -- para ver por marquesina.	
	[TerritorioID] [int] NULL,
	[Codigo] [varchar](25) NULL,
	[PrimerNombre] [varchar](25) NULL,	
	[NombreCompleto] [varchar](200) NULL,
	[AutorizaPedido] [varchar](1) DEFAULT 1 NULL--
)
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'ConsultoraPostulante')
BEGIN
  DROP TABLE dbo.ConsultoraPostulante
END
GO

CREATE TABLE [dbo].[ConsultoraPostulante](
	[ConsultoraID] [bigint] NOT NULL,
	[SeccionID] [int] NULL, -- de la zona
	[RegionID] [int] NULL, --de zona
	[ZonaID] [int] NULL,-- UsuarioPostulante.
	[SegmentoID] [int] NULL, -- para ver por marquesina.	
	[TerritorioID] [int] NULL,
	[Codigo] [varchar](25) NULL,
	[PrimerNombre] [varchar](25) NULL,	
	[NombreCompleto] [varchar](200) NULL,
	[AutorizaPedido] [varchar](1) DEFAULT 1 NULL--
)
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'ConsultoraPostulante')
BEGIN
  DROP TABLE dbo.ConsultoraPostulante
END
GO

CREATE TABLE [dbo].[ConsultoraPostulante](
	[ConsultoraID] [bigint] NOT NULL,
	[SeccionID] [int] NULL, -- de la zona
	[RegionID] [int] NULL, --de zona
	[ZonaID] [int] NULL,-- UsuarioPostulante.
	[SegmentoID] [int] NULL, -- para ver por marquesina.	
	[TerritorioID] [int] NULL,
	[Codigo] [varchar](25) NULL,
	[PrimerNombre] [varchar](25) NULL,	
	[NombreCompleto] [varchar](200) NULL,
	[AutorizaPedido] [varchar](1) DEFAULT 1 NULL--
)
GO
