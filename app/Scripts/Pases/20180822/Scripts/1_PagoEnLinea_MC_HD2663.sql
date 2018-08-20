GO
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


GO
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


GO
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


GO
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


GO
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


GO
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


GO
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


GO
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


GO
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


GO
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


GO
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


GO
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


GO
