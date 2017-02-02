USE BelcorpColombia
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CDRWebDatos]') AND (type = 'U') )
	DROP TABLE [dbo].CDRWebDatos
GO

create table dbo.CDRWebDatos
(
	CDRWebDatosID int identity(1,1) primary key,
	Codigo varchar(50),
	Valor varchar(100)
)

go

insert into dbo.CDRWebDatos (Codigo,Valor) values ('UnidadesPermitidasFaltante', '3')

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCDRWebDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCDRWebDatos
GO

create procedure GetCDRWebDatos
@Codigo varchar(50) = null
as
/*
GetCDRWebDatos
GetCDRWebDatos 'UnidadesPermitidasFaltante'
*/
begin

set @Codigo = isnull(@Codigo,'')

select 
	CDRWebDatosId,
	Codigo,
	Valor
from dbo.CDRWebDatos
where
	Codigo = @Codigo or @Codigo = ''

end

go

USE BelcorpMexico
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CDRWebDatos]') AND (type = 'U') )
	DROP TABLE [dbo].CDRWebDatos
GO

create table dbo.CDRWebDatos
(
	CDRWebDatosID int identity(1,1) primary key,
	Codigo varchar(50),
	Valor varchar(100)
)

go

insert into dbo.CDRWebDatos (Codigo,Valor) values ('UnidadesPermitidasFaltante', '3')

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCDRWebDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCDRWebDatos
GO

create procedure GetCDRWebDatos
@Codigo varchar(50) = null
as
/*
GetCDRWebDatos
GetCDRWebDatos 'UnidadesPermitidasFaltante'
*/
begin

set @Codigo = isnull(@Codigo,'')

select 
	CDRWebDatosId,
	Codigo,
	Valor
from dbo.CDRWebDatos
where
	Codigo = @Codigo or @Codigo = ''

end

go

USE BelcorpPeru
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[CDRWebDatos]') AND (type = 'U') )
	DROP TABLE [dbo].CDRWebDatos
GO

create table dbo.CDRWebDatos
(
	CDRWebDatosID int identity(1,1) primary key,
	Codigo varchar(50),
	Valor varchar(100)
)

go

insert into dbo.CDRWebDatos (Codigo,Valor) values ('UnidadesPermitidasFaltante', '3')

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCDRWebDatos]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCDRWebDatos
GO

create procedure GetCDRWebDatos
@Codigo varchar(50) = null
as
/*
GetCDRWebDatos
GetCDRWebDatos 'UnidadesPermitidasFaltante'
*/
begin

set @Codigo = isnull(@Codigo,'')

select 
	CDRWebDatosId,
	Codigo,
	Valor
from dbo.CDRWebDatos
where
	Codigo = @Codigo or @Codigo = ''

end

go