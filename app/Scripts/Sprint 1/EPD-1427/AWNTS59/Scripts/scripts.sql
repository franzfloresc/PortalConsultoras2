USE BelcorpColombia
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

CREATE TABLE LogConfiguracionCronograma
(
	IdRegistro INT IDENTITY(1,1) PRIMARY KEY,
	FechaRegistro DATETIME,
	CodigoUsuario VARCHAR(30),
	CodigoRegion VARCHAR(2),
	CodigoZona VARCHAR(4),
	DiasDuracionAnterior INT,
	DiasDuracionActual INT
)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogConfiguracionCronograma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsLogConfiguracionCronograma
GO

CREATE PROCEDURE InsLogConfiguracionCronograma
(
  @CodigoUsuario VARCHAR(30), 
  @ListaEntidadXml XML
)
AS
BEGIN

declare @tablaLog table
(
	RegionID int,
	ZonaID int,
	DiasDuracionAnterior int,
	DiasDuracionActual int
)

insert into @tablaLog
SELECT
	p.value('@CodigoRegion','INT'), 
	p.value('@CodigoZona','INT'),
	p.value('@DiasDuracionAnterior','INT'),
	p.value('@DiasDuracionActual','INT')
FROM @ListaEntidadXml.nodes('/ROOT/LogConfiguracionCronograma')n(p);

INSERT INTO LogConfiguracionCronograma
(
	FechaRegistro,
	CodigoUsuario,
	CodigoRegion,
	CodigoZona,
	DiasDuracionAnterior,
	DiasDuracionActual

)
select 
	getdate(),
	@CodigoUsuario,
	r.Codigo,
	z.Codigo,
	t.DiasDuracionAnterior,
	t.DiasDuracionActual
from @tablaLog t
inner join ods.Region r on
	t.RegionID = r.RegionID
inner join ods.Zona z on
	t.ZonaID = z.ZonaID

END

go

USE BelcorpMexico
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

CREATE TABLE LogConfiguracionCronograma
(
	IdRegistro INT IDENTITY(1,1) PRIMARY KEY,
	FechaRegistro DATETIME,
	CodigoUsuario VARCHAR(30),
	CodigoRegion VARCHAR(2),
	CodigoZona VARCHAR(4),
	DiasDuracionAnterior INT,
	DiasDuracionActual INT
)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogConfiguracionCronograma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsLogConfiguracionCronograma
GO

CREATE PROCEDURE InsLogConfiguracionCronograma
(
  @CodigoUsuario VARCHAR(30), 
  @ListaEntidadXml XML
)
AS
BEGIN

declare @tablaLog table
(
	RegionID int,
	ZonaID int,
	DiasDuracionAnterior int,
	DiasDuracionActual int
)

insert into @tablaLog
SELECT
	p.value('@CodigoRegion','INT'), 
	p.value('@CodigoZona','INT'),
	p.value('@DiasDuracionAnterior','INT'),
	p.value('@DiasDuracionActual','INT')
FROM @ListaEntidadXml.nodes('/ROOT/LogConfiguracionCronograma')n(p);

INSERT INTO LogConfiguracionCronograma
(
	FechaRegistro,
	CodigoUsuario,
	CodigoRegion,
	CodigoZona,
	DiasDuracionAnterior,
	DiasDuracionActual

)
select 
	getdate(),
	@CodigoUsuario,
	r.Codigo,
	z.Codigo,
	t.DiasDuracionAnterior,
	t.DiasDuracionActual
from @tablaLog t
inner join ods.Region r on
	t.RegionID = r.RegionID
inner join ods.Zona z on
	t.ZonaID = z.ZonaID

END

go

USE BelcorpPeru
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

CREATE TABLE LogConfiguracionCronograma
(
	IdRegistro INT IDENTITY(1,1) PRIMARY KEY,
	FechaRegistro DATETIME,
	CodigoUsuario VARCHAR(30),
	CodigoRegion VARCHAR(2),
	CodigoZona VARCHAR(4),
	DiasDuracionAnterior INT,
	DiasDuracionActual INT
)
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsLogConfiguracionCronograma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsLogConfiguracionCronograma
GO

CREATE PROCEDURE InsLogConfiguracionCronograma
(
  @CodigoUsuario VARCHAR(30), 
  @ListaEntidadXml XML
)
AS
BEGIN

declare @tablaLog table
(
	RegionID int,
	ZonaID int,
	DiasDuracionAnterior int,
	DiasDuracionActual int
)

insert into @tablaLog
SELECT
	p.value('@CodigoRegion','INT'), 
	p.value('@CodigoZona','INT'),
	p.value('@DiasDuracionAnterior','INT'),
	p.value('@DiasDuracionActual','INT')
FROM @ListaEntidadXml.nodes('/ROOT/LogConfiguracionCronograma')n(p);

INSERT INTO LogConfiguracionCronograma
(
	FechaRegistro,
	CodigoUsuario,
	CodigoRegion,
	CodigoZona,
	DiasDuracionAnterior,
	DiasDuracionActual

)
select 
	getdate(),
	@CodigoUsuario,
	r.Codigo,
	z.Codigo,
	t.DiasDuracionAnterior,
	t.DiasDuracionActual
from @tablaLog t
inner join ods.Region r on
	t.RegionID = r.RegionID
inner join ods.Zona z on
	t.ZonaID = z.ZonaID

END

go