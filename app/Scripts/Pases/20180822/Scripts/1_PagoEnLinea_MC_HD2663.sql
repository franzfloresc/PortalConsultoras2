USE BelcorpPeru
GO

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
	TipoVisualizacionTyC varchar(10),
	TerminosCondiciones varchar(max),
	TipoPasarelaCodigoPlataforma varchar(10),
	TipoTarjeta varchar(10),
	ExpresionRegularTarjeta varchar(100),
	Estado bit
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

create table dbo.PagoEnLineaTipoPasarela
(
	PagoEnLineaTipoPasarelaId int identity(1,1) primary key,
	CodigoPlataforma varchar(10),
	Codigo varchar(10),
	Descripcion varchar(100),
	Valor varchar(500)
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

create table dbo.PagoEnLineaPasarelaCampos
(
	PagoEnLineaPasarelaCamposId int identity(1,1) primary key,
	Codigo varchar(10),
	Descripcion varchar(100),
	EsObligatorio bit,
	Estado bit
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
	pd.TipoVisualizacionTyC,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	pd.TipoTarjeta,
	pd.ExpresionRegularTarjeta,
	pd.Estado,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
	and pd.Estado = 1
order by pd.Orden

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

create procedure dbo.ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
@CodigoPlataforma varchar(10)
as
/*
ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma 'A'
*/
begin

select
	PagoEnLineaTipoPasarelaId,
	CodigoPlataforma,
	Codigo,
	Descripcion,
	Valor
from PagoEnLineaTipoPasarela
where CodigoPlataforma = @CodigoPlataforma

end

go

USE BelcorpMexico
GO

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
	TipoVisualizacionTyC varchar(10),
	TerminosCondiciones varchar(max),
	TipoPasarelaCodigoPlataforma varchar(10),
	TipoTarjeta varchar(10),
	ExpresionRegularTarjeta varchar(100),
	Estado bit
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

create table dbo.PagoEnLineaTipoPasarela
(
	PagoEnLineaTipoPasarelaId int identity(1,1) primary key,
	CodigoPlataforma varchar(10),
	Codigo varchar(10),
	Descripcion varchar(100),
	Valor varchar(500)
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

create table dbo.PagoEnLineaPasarelaCampos
(
	PagoEnLineaPasarelaCamposId int identity(1,1) primary key,
	Codigo varchar(10),
	Descripcion varchar(100),
	EsObligatorio bit,
	Estado bit
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
	pd.TipoVisualizacionTyC,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	pd.TipoTarjeta,
	pd.ExpresionRegularTarjeta,
	pd.Estado,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
	and pd.Estado = 1
order by pd.Orden

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

create procedure dbo.ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
@CodigoPlataforma varchar(10)
as
/*
ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma 'A'
*/
begin

select
	PagoEnLineaTipoPasarelaId,
	CodigoPlataforma,
	Codigo,
	Descripcion,
	Valor
from PagoEnLineaTipoPasarela
where CodigoPlataforma = @CodigoPlataforma

end

go

USE BelcorpColombia
GO

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
	TipoVisualizacionTyC varchar(10),
	TerminosCondiciones varchar(max),
	TipoPasarelaCodigoPlataforma varchar(10),
	TipoTarjeta varchar(10),
	ExpresionRegularTarjeta varchar(100),
	Estado bit
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

create table dbo.PagoEnLineaTipoPasarela
(
	PagoEnLineaTipoPasarelaId int identity(1,1) primary key,
	CodigoPlataforma varchar(10),
	Codigo varchar(10),
	Descripcion varchar(100),
	Valor varchar(500)
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

create table dbo.PagoEnLineaPasarelaCampos
(
	PagoEnLineaPasarelaCamposId int identity(1,1) primary key,
	Codigo varchar(10),
	Descripcion varchar(100),
	EsObligatorio bit,
	Estado bit
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
	pd.TipoVisualizacionTyC,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	pd.TipoTarjeta,
	pd.ExpresionRegularTarjeta,
	pd.Estado,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
	and pd.Estado = 1
order by pd.Orden

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

create procedure dbo.ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
@CodigoPlataforma varchar(10)
as
/*
ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma 'A'
*/
begin

select
	PagoEnLineaTipoPasarelaId,
	CodigoPlataforma,
	Codigo,
	Descripcion,
	Valor
from PagoEnLineaTipoPasarela
where CodigoPlataforma = @CodigoPlataforma

end

go

USE BelcorpSalvador
GO

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
	TipoVisualizacionTyC varchar(10),
	TerminosCondiciones varchar(max),
	TipoPasarelaCodigoPlataforma varchar(10),
	TipoTarjeta varchar(10),
	ExpresionRegularTarjeta varchar(100),
	Estado bit
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

create table dbo.PagoEnLineaTipoPasarela
(
	PagoEnLineaTipoPasarelaId int identity(1,1) primary key,
	CodigoPlataforma varchar(10),
	Codigo varchar(10),
	Descripcion varchar(100),
	Valor varchar(500)
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

create table dbo.PagoEnLineaPasarelaCampos
(
	PagoEnLineaPasarelaCamposId int identity(1,1) primary key,
	Codigo varchar(10),
	Descripcion varchar(100),
	EsObligatorio bit,
	Estado bit
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
	pd.TipoVisualizacionTyC,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	pd.TipoTarjeta,
	pd.ExpresionRegularTarjeta,
	pd.Estado,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
	and pd.Estado = 1
order by pd.Orden

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

create procedure dbo.ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
@CodigoPlataforma varchar(10)
as
/*
ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma 'A'
*/
begin

select
	PagoEnLineaTipoPasarelaId,
	CodigoPlataforma,
	Codigo,
	Descripcion,
	Valor
from PagoEnLineaTipoPasarela
where CodigoPlataforma = @CodigoPlataforma

end

go

USE BelcorpPuertoRico
GO

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
	TipoVisualizacionTyC varchar(10),
	TerminosCondiciones varchar(max),
	TipoPasarelaCodigoPlataforma varchar(10),
	TipoTarjeta varchar(10),
	ExpresionRegularTarjeta varchar(100),
	Estado bit
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

create table dbo.PagoEnLineaTipoPasarela
(
	PagoEnLineaTipoPasarelaId int identity(1,1) primary key,
	CodigoPlataforma varchar(10),
	Codigo varchar(10),
	Descripcion varchar(100),
	Valor varchar(500)
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

create table dbo.PagoEnLineaPasarelaCampos
(
	PagoEnLineaPasarelaCamposId int identity(1,1) primary key,
	Codigo varchar(10),
	Descripcion varchar(100),
	EsObligatorio bit,
	Estado bit
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
	pd.TipoVisualizacionTyC,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	pd.TipoTarjeta,
	pd.ExpresionRegularTarjeta,
	pd.Estado,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
	and pd.Estado = 1
order by pd.Orden

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

create procedure dbo.ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
@CodigoPlataforma varchar(10)
as
/*
ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma 'A'
*/
begin

select
	PagoEnLineaTipoPasarelaId,
	CodigoPlataforma,
	Codigo,
	Descripcion,
	Valor
from PagoEnLineaTipoPasarela
where CodigoPlataforma = @CodigoPlataforma

end

go

USE BelcorpPanama
GO

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
	TipoVisualizacionTyC varchar(10),
	TerminosCondiciones varchar(max),
	TipoPasarelaCodigoPlataforma varchar(10),
	TipoTarjeta varchar(10),
	ExpresionRegularTarjeta varchar(100),
	Estado bit
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

create table dbo.PagoEnLineaTipoPasarela
(
	PagoEnLineaTipoPasarelaId int identity(1,1) primary key,
	CodigoPlataforma varchar(10),
	Codigo varchar(10),
	Descripcion varchar(100),
	Valor varchar(500)
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

create table dbo.PagoEnLineaPasarelaCampos
(
	PagoEnLineaPasarelaCamposId int identity(1,1) primary key,
	Codigo varchar(10),
	Descripcion varchar(100),
	EsObligatorio bit,
	Estado bit
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
	pd.TipoVisualizacionTyC,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	pd.TipoTarjeta,
	pd.ExpresionRegularTarjeta,
	pd.Estado,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
	and pd.Estado = 1
order by pd.Orden

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

create procedure dbo.ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
@CodigoPlataforma varchar(10)
as
/*
ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma 'A'
*/
begin

select
	PagoEnLineaTipoPasarelaId,
	CodigoPlataforma,
	Codigo,
	Descripcion,
	Valor
from PagoEnLineaTipoPasarela
where CodigoPlataforma = @CodigoPlataforma

end

go

USE BelcorpGuatemala
GO

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
	TipoVisualizacionTyC varchar(10),
	TerminosCondiciones varchar(max),
	TipoPasarelaCodigoPlataforma varchar(10),
	TipoTarjeta varchar(10),
	ExpresionRegularTarjeta varchar(100),
	Estado bit
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

create table dbo.PagoEnLineaTipoPasarela
(
	PagoEnLineaTipoPasarelaId int identity(1,1) primary key,
	CodigoPlataforma varchar(10),
	Codigo varchar(10),
	Descripcion varchar(100),
	Valor varchar(500)
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

create table dbo.PagoEnLineaPasarelaCampos
(
	PagoEnLineaPasarelaCamposId int identity(1,1) primary key,
	Codigo varchar(10),
	Descripcion varchar(100),
	EsObligatorio bit,
	Estado bit
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
	pd.TipoVisualizacionTyC,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	pd.TipoTarjeta,
	pd.ExpresionRegularTarjeta,
	pd.Estado,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
	and pd.Estado = 1
order by pd.Orden

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

create procedure dbo.ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
@CodigoPlataforma varchar(10)
as
/*
ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma 'A'
*/
begin

select
	PagoEnLineaTipoPasarelaId,
	CodigoPlataforma,
	Codigo,
	Descripcion,
	Valor
from PagoEnLineaTipoPasarela
where CodigoPlataforma = @CodigoPlataforma

end

go

USE BelcorpEcuador
GO

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
	TipoVisualizacionTyC varchar(10),
	TerminosCondiciones varchar(max),
	TipoPasarelaCodigoPlataforma varchar(10),
	TipoTarjeta varchar(10),
	ExpresionRegularTarjeta varchar(100),
	Estado bit
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

create table dbo.PagoEnLineaTipoPasarela
(
	PagoEnLineaTipoPasarelaId int identity(1,1) primary key,
	CodigoPlataforma varchar(10),
	Codigo varchar(10),
	Descripcion varchar(100),
	Valor varchar(500)
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

create table dbo.PagoEnLineaPasarelaCampos
(
	PagoEnLineaPasarelaCamposId int identity(1,1) primary key,
	Codigo varchar(10),
	Descripcion varchar(100),
	EsObligatorio bit,
	Estado bit
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
	pd.TipoVisualizacionTyC,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	pd.TipoTarjeta,
	pd.ExpresionRegularTarjeta,
	pd.Estado,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
	and pd.Estado = 1
order by pd.Orden

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

create procedure dbo.ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
@CodigoPlataforma varchar(10)
as
/*
ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma 'A'
*/
begin

select
	PagoEnLineaTipoPasarelaId,
	CodigoPlataforma,
	Codigo,
	Descripcion,
	Valor
from PagoEnLineaTipoPasarela
where CodigoPlataforma = @CodigoPlataforma

end

go

USE BelcorpDominicana
GO

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
	TipoVisualizacionTyC varchar(10),
	TerminosCondiciones varchar(max),
	TipoPasarelaCodigoPlataforma varchar(10),
	TipoTarjeta varchar(10),
	ExpresionRegularTarjeta varchar(100),
	Estado bit
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

create table dbo.PagoEnLineaTipoPasarela
(
	PagoEnLineaTipoPasarelaId int identity(1,1) primary key,
	CodigoPlataforma varchar(10),
	Codigo varchar(10),
	Descripcion varchar(100),
	Valor varchar(500)
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

create table dbo.PagoEnLineaPasarelaCampos
(
	PagoEnLineaPasarelaCamposId int identity(1,1) primary key,
	Codigo varchar(10),
	Descripcion varchar(100),
	EsObligatorio bit,
	Estado bit
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
	pd.TipoVisualizacionTyC,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	pd.TipoTarjeta,
	pd.ExpresionRegularTarjeta,
	pd.Estado,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
	and pd.Estado = 1
order by pd.Orden

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

create procedure dbo.ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
@CodigoPlataforma varchar(10)
as
/*
ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma 'A'
*/
begin

select
	PagoEnLineaTipoPasarelaId,
	CodigoPlataforma,
	Codigo,
	Descripcion,
	Valor
from PagoEnLineaTipoPasarela
where CodigoPlataforma = @CodigoPlataforma

end

go

USE BelcorpCostaRica
GO

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
	TipoVisualizacionTyC varchar(10),
	TerminosCondiciones varchar(max),
	TipoPasarelaCodigoPlataforma varchar(10),
	TipoTarjeta varchar(10),
	ExpresionRegularTarjeta varchar(100),
	Estado bit
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

create table dbo.PagoEnLineaTipoPasarela
(
	PagoEnLineaTipoPasarelaId int identity(1,1) primary key,
	CodigoPlataforma varchar(10),
	Codigo varchar(10),
	Descripcion varchar(100),
	Valor varchar(500)
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

create table dbo.PagoEnLineaPasarelaCampos
(
	PagoEnLineaPasarelaCamposId int identity(1,1) primary key,
	Codigo varchar(10),
	Descripcion varchar(100),
	EsObligatorio bit,
	Estado bit
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
	pd.TipoVisualizacionTyC,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	pd.TipoTarjeta,
	pd.ExpresionRegularTarjeta,
	pd.Estado,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
	and pd.Estado = 1
order by pd.Orden

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

create procedure dbo.ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
@CodigoPlataforma varchar(10)
as
/*
ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma 'A'
*/
begin

select
	PagoEnLineaTipoPasarelaId,
	CodigoPlataforma,
	Codigo,
	Descripcion,
	Valor
from PagoEnLineaTipoPasarela
where CodigoPlataforma = @CodigoPlataforma

end

go

USE BelcorpChile
GO

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
	TipoVisualizacionTyC varchar(10),
	TerminosCondiciones varchar(max),
	TipoPasarelaCodigoPlataforma varchar(10),
	TipoTarjeta varchar(10),
	ExpresionRegularTarjeta varchar(100),
	Estado bit
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

create table dbo.PagoEnLineaTipoPasarela
(
	PagoEnLineaTipoPasarelaId int identity(1,1) primary key,
	CodigoPlataforma varchar(10),
	Codigo varchar(10),
	Descripcion varchar(100),
	Valor varchar(500)
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

create table dbo.PagoEnLineaPasarelaCampos
(
	PagoEnLineaPasarelaCamposId int identity(1,1) primary key,
	Codigo varchar(10),
	Descripcion varchar(100),
	EsObligatorio bit,
	Estado bit
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
	pd.TipoVisualizacionTyC,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	pd.TipoTarjeta,
	pd.ExpresionRegularTarjeta,
	pd.Estado,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
	and pd.Estado = 1
order by pd.Orden

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

create procedure dbo.ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
@CodigoPlataforma varchar(10)
as
/*
ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma 'A'
*/
begin

select
	PagoEnLineaTipoPasarelaId,
	CodigoPlataforma,
	Codigo,
	Descripcion,
	Valor
from PagoEnLineaTipoPasarela
where CodigoPlataforma = @CodigoPlataforma

end

go

USE BelcorpBolivia
GO

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
	TipoVisualizacionTyC varchar(10),
	TerminosCondiciones varchar(max),
	TipoPasarelaCodigoPlataforma varchar(10),
	TipoTarjeta varchar(10),
	ExpresionRegularTarjeta varchar(100),
	Estado bit
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaTipoPasarela') and type = 'U')
   drop table dbo.PagoEnLineaTipoPasarela
go

create table dbo.PagoEnLineaTipoPasarela
(
	PagoEnLineaTipoPasarelaId int identity(1,1) primary key,
	CodigoPlataforma varchar(10),
	Codigo varchar(10),
	Descripcion varchar(100),
	Valor varchar(500)
)

go

if exists (select 1 from sysobjects where id = object_id('dbo.PagoEnLineaPasarelaCampos') and type = 'U')
   drop table dbo.PagoEnLineaPasarelaCampos
go

create table dbo.PagoEnLineaPasarelaCampos
(
	PagoEnLineaPasarelaCamposId int identity(1,1) primary key,
	Codigo varchar(10),
	Descripcion varchar(100),
	EsObligatorio bit,
	Estado bit
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
	pd.TipoVisualizacionTyC,
	pd.TerminosCondiciones,
	pd.TipoPasarelaCodigoPlataforma,
	pd.TipoTarjeta,
	pd.ExpresionRegularTarjeta,
	pd.Estado,
	p.RutaIcono
from PagoEnLineaMedioPago p
inner join PagoEnLineaMedioPagoDetalle pd on
	p.PagoEnLineaMedioPagoId = pd.PagoEnLineaMedioPagoId
where
	p.Estado = 1
	and pd.Estado = 1
order by pd.Orden

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
GO

create procedure dbo.ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma
@CodigoPlataforma varchar(10)
as
/*
ObtenerPagoEnLineaTipoPasarelaByCodigoPlataforma 'A'
*/
begin

select
	PagoEnLineaTipoPasarelaId,
	CodigoPlataforma,
	Codigo,
	Descripcion,
	Valor
from PagoEnLineaTipoPasarela
where CodigoPlataforma = @CodigoPlataforma

end

go

