USE [BelcorpPeru]  
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActivarPremioNuevas') AND type in (N'U')) 
	DROP TABLE dbo.ActivarPremioNuevas
GO
CREATE TABLE dbo.ActivarPremioNuevas 				
(
	CodigoPrograma			varchar(10),
	AnoCampana				int,
	Nivel					varchar(10),
	ActiveTooltip			bit,			-- validar por descripcion y monto
	ActiveTooltipMonto		bit,			-- validar por monto
	Active					bit,			-- validar que aparecesca el regalo oh solo aparesca estatico
	FechaCreate				datetime  DEFAULT GETDATE() ,
	constraint PK_ActivarPremioNueva primary key (CodigoPrograma, AnoCampana ,Nivel)
)
GO

USE [BelcorpBolivia]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActivarPremioNuevas') AND type in (N'U')) 
	DROP TABLE dbo.ActivarPremioNuevas
GO
CREATE TABLE dbo.ActivarPremioNuevas 				
(
	CodigoPrograma			varchar(10),
	AnoCampana				int,
	Nivel					varchar(10),
	ActiveTooltip			bit,			-- validar por descripcion y monto
	ActiveTooltipMonto		bit,			-- validar por monto
	Active					bit,			-- validar que aparecesca el regalo oh solo aparesca estatico
	FechaCreate				datetime  DEFAULT GETDATE() ,
	constraint PK_ActivarPremioNueva primary key (CodigoPrograma, AnoCampana ,Nivel)
)
GO

USE [BelcorpChile]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActivarPremioNuevas') AND type in (N'U')) 
	DROP TABLE dbo.ActivarPremioNuevas
GO
CREATE TABLE dbo.ActivarPremioNuevas 				
(
	CodigoPrograma			varchar(10),
	AnoCampana				int,
	Nivel					varchar(10),
	ActiveTooltip			bit,			-- validar por descripcion y monto
	ActiveTooltipMonto		bit,			-- validar por monto
	Active					bit,			-- validar que aparecesca el regalo oh solo aparesca estatico
	FechaCreate				datetime  DEFAULT GETDATE() ,
	constraint PK_ActivarPremioNueva primary key (CodigoPrograma, AnoCampana ,Nivel)
)
GO

USE [BelcorpColombia]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActivarPremioNuevas') AND type in (N'U')) 
	DROP TABLE dbo.ActivarPremioNuevas
GO
CREATE TABLE dbo.ActivarPremioNuevas 				
(
	CodigoPrograma			varchar(10),
	AnoCampana				int,
	Nivel					varchar(10),
	ActiveTooltip			bit,			-- validar por descripcion y monto
	ActiveTooltipMonto		bit,			-- validar por monto
	Active					bit,			-- validar que aparecesca el regalo oh solo aparesca estatico
	FechaCreate				datetime  DEFAULT GETDATE() ,
	constraint PK_ActivarPremioNueva primary key (CodigoPrograma, AnoCampana ,Nivel)
)
GO

USE [BelcorpCostaRica]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActivarPremioNuevas') AND type in (N'U')) 
	DROP TABLE dbo.ActivarPremioNuevas
GO
CREATE TABLE dbo.ActivarPremioNuevas 				
(
	CodigoPrograma			varchar(10),
	AnoCampana				int,
	Nivel					varchar(10),
	ActiveTooltip			bit,			-- validar por descripcion y monto
	ActiveTooltipMonto		bit,			-- validar por monto
	Active					bit,			-- validar que aparecesca el regalo oh solo aparesca estatico
	FechaCreate				datetime  DEFAULT GETDATE() ,
	constraint PK_ActivarPremioNueva primary key (CodigoPrograma, AnoCampana ,Nivel)
)
GO

USE [BelcorpDominicana]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActivarPremioNuevas') AND type in (N'U')) 
	DROP TABLE dbo.ActivarPremioNuevas
GO
CREATE TABLE dbo.ActivarPremioNuevas 				
(
	CodigoPrograma			varchar(10),
	AnoCampana				int,
	Nivel					varchar(10),
	ActiveTooltip			bit,			-- validar por descripcion y monto
	ActiveTooltipMonto		bit,			-- validar por monto
	Active					bit,			-- validar que aparecesca el regalo oh solo aparesca estatico
	FechaCreate				datetime  DEFAULT GETDATE() ,
	constraint PK_ActivarPremioNueva primary key (CodigoPrograma, AnoCampana ,Nivel)
)
GO

USE [BelcorpEcuador]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActivarPremioNuevas') AND type in (N'U')) 
	DROP TABLE dbo.ActivarPremioNuevas
GO
CREATE TABLE dbo.ActivarPremioNuevas 				
(
	CodigoPrograma			varchar(10),
	AnoCampana				int,
	Nivel					varchar(10),
	ActiveTooltip			bit,			-- validar por descripcion y monto
	ActiveTooltipMonto		bit,			-- validar por monto
	Active					bit,			-- validar que aparecesca el regalo oh solo aparesca estatico
	FechaCreate				datetime  DEFAULT GETDATE() ,
	constraint PK_ActivarPremioNueva primary key (CodigoPrograma, AnoCampana ,Nivel)
)
GO

USE [BelcorpGuatemala]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActivarPremioNuevas') AND type in (N'U')) 
	DROP TABLE dbo.ActivarPremioNuevas
GO
CREATE TABLE dbo.ActivarPremioNuevas 				
(
	CodigoPrograma			varchar(10),
	AnoCampana				int,
	Nivel					varchar(10),
	ActiveTooltip			bit,			-- validar por descripcion y monto
	ActiveTooltipMonto		bit,			-- validar por monto
	Active					bit,			-- validar que aparecesca el regalo oh solo aparesca estatico
	FechaCreate				datetime  DEFAULT GETDATE() ,
	constraint PK_ActivarPremioNueva primary key (CodigoPrograma, AnoCampana ,Nivel)
)
GO

USE [BelcorpMexico]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActivarPremioNuevas') AND type in (N'U')) 
	DROP TABLE dbo.ActivarPremioNuevas
GO
CREATE TABLE dbo.ActivarPremioNuevas 				
(
	CodigoPrograma			varchar(10),
	AnoCampana				int,
	Nivel					varchar(10),
	ActiveTooltip			bit,			-- validar por descripcion y monto
	ActiveTooltipMonto		bit,			-- validar por monto
	Active					bit,			-- validar que aparecesca el regalo oh solo aparesca estatico
	FechaCreate				datetime  DEFAULT GETDATE() ,
	constraint PK_ActivarPremioNueva primary key (CodigoPrograma, AnoCampana ,Nivel)
)
GO

USE [BelcorpPanama]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActivarPremioNuevas') AND type in (N'U')) 
	DROP TABLE dbo.ActivarPremioNuevas
GO
CREATE TABLE dbo.ActivarPremioNuevas 				
(
	CodigoPrograma			varchar(10),
	AnoCampana				int,
	Nivel					varchar(10),
	ActiveTooltip			bit,			-- validar por descripcion y monto
	ActiveTooltipMonto		bit,			-- validar por monto
	Active					bit,			-- validar que aparecesca el regalo oh solo aparesca estatico
	FechaCreate				datetime  DEFAULT GETDATE() ,
	constraint PK_ActivarPremioNueva primary key (CodigoPrograma, AnoCampana ,Nivel)
)
GO

USE [BelcorpPuertoRico]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActivarPremioNuevas') AND type in (N'U')) 
	DROP TABLE dbo.ActivarPremioNuevas
GO
CREATE TABLE dbo.ActivarPremioNuevas 				
(
	CodigoPrograma			varchar(10),
	AnoCampana				int,
	Nivel					varchar(10),
	ActiveTooltip			bit,			-- validar por descripcion y monto
	ActiveTooltipMonto		bit,			-- validar por monto
	Active					bit,			-- validar que aparecesca el regalo oh solo aparesca estatico
	FechaCreate				datetime  DEFAULT GETDATE() ,
	constraint PK_ActivarPremioNueva primary key (CodigoPrograma, AnoCampana ,Nivel)
)
GO

USE [BelcorpSalvador]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ActivarPremioNuevas') AND type in (N'U')) 
	DROP TABLE dbo.ActivarPremioNuevas
GO
CREATE TABLE dbo.ActivarPremioNuevas 				
(
	CodigoPrograma			varchar(10),
	AnoCampana				int,
	Nivel					varchar(10),
	ActiveTooltip			bit,			-- validar por descripcion y monto
	ActiveTooltipMonto		bit,			-- validar por monto
	Active					bit,			-- validar que aparecesca el regalo oh solo aparesca estatico
	FechaCreate				datetime  DEFAULT GETDATE() ,
	constraint PK_ActivarPremioNueva primary key (CodigoPrograma, AnoCampana ,Nivel)
)
GO
