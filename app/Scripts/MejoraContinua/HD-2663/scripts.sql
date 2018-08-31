if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPago') and type = 'U')
   drop table dbo.PagoEnLineaTipoPago
go

create table dbo.PagoEnLineaTipoPago
(
	PagoEnLineaTipoPagoId int identity(1,1) primary key,
	Descripcion varchar(100),
	Codigo varchar(10),
	Estado bit
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPago') and type = 'U')
   drop table dbo.PagoEnLineaMedioPago
go

create table dbo.PagoEnLineaMedioPago
(
	PagoEnLineaMedioPagoId int identity(1,1) primary key,
	Descripcion varchar(100),
	Codigo varchar(10),
	RutaIcono varchar(500),
	Orden int,
	TextoToolTip varchar(100),
	Estado bit
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaMedioPagoDetalle') and type = 'U')
   drop table dbo.PagoEnLineaMedioPagoDetalle
go

create table dbo.PagoEnLineaMedioPagoDetalle
(
	PagoEnLineaMedioPagoDetalleId int identity(1,1) primary key,
	PagoEnLineaMedioPagoId int,
	Descripcion varchar(100),
	Orden int,
	TerminosCondiciones varchar(max),
	TipoPasarelaCodigoPlataforma varchar(10)
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

create table PagoEnLineaTipoPasarela
(
	PagoEnLineaTipoPasarela int identity(1,1) primary key,
	CodigoPlataforma varchar(10),
	Codigo varchar(10),
	Descripcion varchar(100),
	Valor varchar(500)
)

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPago
GO

create procedure dbo.ObtenerPagoEnLineaTipoPago
as
/*
ObtenerPagoEnLineaTipoPago
*/
begin

select 
	PagoEnLineaTipoPagoId,
	Descripcion,
	Codigo,
	Estado
from PagoEnLineaTipoPago
where Estado = 1

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPago]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPago
GO

create procedure dbo.ObtenerPagoEnLineaMedioPago
as
/*
ObtenerPagoEnLineaMedioPago
*/
begin

select 
	PagoEnLineaMedioPagoId,
	Descripcion,
	Codigo,
	RutaIcono,
	Orden,
	TextoToolTip,
	Estado
from PagoEnLineaMedioPago
where Estado = 1
order by Orden

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaMedioPagoDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaMedioPagoDetalle
GO

create procedure dbo.ObtenerPagoEnLineaMedioPagoDetalle
as
/*
ObtenerPagoEnLineaMedioPagoDetalle
*/
begin

select 
	pd.PagoEnLineaMedioPagoDetalleId,
	pd.PagoEnLineaMedioPagoId,
	pd.Descripcion,
	pd.Orden,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
order by pd.Orden

end

go