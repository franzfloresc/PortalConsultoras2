USE [BelcorpDominicana]
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


--- 

USE [BelcorpColombia]
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



USE [BelcorpPeru]
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

