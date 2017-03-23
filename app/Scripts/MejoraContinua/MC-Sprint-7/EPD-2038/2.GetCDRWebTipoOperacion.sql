USE [BelcorpBolivia]
go
if exists (select * from sys.objects where type = 'P' and name like '%GetCDRWebTipoOperacion%')
begin
	DROP PROCEDURE dbo.GetCDRWebTipoOperacion
	PRINT 'elimino'
end
go
CREATE PROC GetCDRWebTipoOperacion
as
begin
	select 
		CodigoOperacion,
		DescripcionOperacion,
		NumeroDiasAtrasOperacion
	from [dbo].[TipoOperacionesCDR]
end
go



USE [BelcorpChile]
go
if exists (select * from sys.objects where type = 'P' and name like '%GetCDRWebTipoOperacion%')
begin
	DROP PROCEDURE dbo.GetCDRWebTipoOperacion
	PRINT 'elimino'
end
go
CREATE PROC GetCDRWebTipoOperacion
as
begin
	select 
		CodigoOperacion,
		DescripcionOperacion,
		NumeroDiasAtrasOperacion
	from [dbo].[TipoOperacionesCDR]
end
go



USE [BelcorpColombia]
go
if exists (select * from sys.objects where type = 'P' and name like '%GetCDRWebTipoOperacion%')
begin
	DROP PROCEDURE dbo.GetCDRWebTipoOperacion
	PRINT 'elimino'
end
go
CREATE PROC GetCDRWebTipoOperacion
as
begin
	select 
		CodigoOperacion,
		DescripcionOperacion,
		NumeroDiasAtrasOperacion
	from [dbo].[TipoOperacionesCDR]
end
go




USE [BelcorpCostaRica]
go
if exists (select * from sys.objects where type = 'P' and name like '%GetCDRWebTipoOperacion%')
begin
	DROP PROCEDURE dbo.GetCDRWebTipoOperacion
	PRINT 'elimino'
end
go
CREATE PROC GetCDRWebTipoOperacion
as
begin
	select 
		CodigoOperacion,
		DescripcionOperacion,
		NumeroDiasAtrasOperacion
	from [dbo].[TipoOperacionesCDR]
end
go




USE [BelcorpDominicana]
go
if exists (select * from sys.objects where type = 'P' and name like '%GetCDRWebTipoOperacion%')
begin
	DROP PROCEDURE dbo.GetCDRWebTipoOperacion
	PRINT 'elimino'
end
go
CREATE PROC GetCDRWebTipoOperacion
as
begin
	select 
		CodigoOperacion,
		DescripcionOperacion,
		NumeroDiasAtrasOperacion
	from [dbo].[TipoOperacionesCDR]
end
go




USE [BelcorpEcuador]
go
if exists (select * from sys.objects where type = 'P' and name like '%GetCDRWebTipoOperacion%')
begin
	DROP PROCEDURE dbo.GetCDRWebTipoOperacion
	PRINT 'elimino'
end
go
CREATE PROC GetCDRWebTipoOperacion
as
begin
	select 
		CodigoOperacion,
		DescripcionOperacion,
		NumeroDiasAtrasOperacion
	from [dbo].[TipoOperacionesCDR]
end
go




USE [BelcorpGuatemala]
go
if exists (select * from sys.objects where type = 'P' and name like '%GetCDRWebTipoOperacion%')
begin
	DROP PROCEDURE dbo.GetCDRWebTipoOperacion
	PRINT 'elimino'
end
go
CREATE PROC GetCDRWebTipoOperacion
as
begin
	select 
		CodigoOperacion,
		DescripcionOperacion,
		NumeroDiasAtrasOperacion
	from [dbo].[TipoOperacionesCDR]
end
go




USE [BelcorpMexico]
go
if exists (select * from sys.objects where type = 'P' and name like '%GetCDRWebTipoOperacion%')
begin
	DROP PROCEDURE dbo.GetCDRWebTipoOperacion
	PRINT 'elimino'
end
go
CREATE PROC GetCDRWebTipoOperacion
as
begin
	select 
		CodigoOperacion,
		DescripcionOperacion,
		NumeroDiasAtrasOperacion
	from [dbo].[TipoOperacionesCDR]
end
go



USE [BelcorpPanama]
go
if exists (select * from sys.objects where type = 'P' and name like '%GetCDRWebTipoOperacion%')
begin
	DROP PROCEDURE dbo.GetCDRWebTipoOperacion
	PRINT 'elimino'
end
go
CREATE PROC GetCDRWebTipoOperacion
as
begin
	select 
		CodigoOperacion,
		DescripcionOperacion,
		NumeroDiasAtrasOperacion
	from [dbo].[TipoOperacionesCDR]
end
go




USE [BelcorpPeru]
go
if exists (select * from sys.objects where type = 'P' and name like '%GetCDRWebTipoOperacion%')
begin
	DROP PROCEDURE dbo.GetCDRWebTipoOperacion
	PRINT 'elimino'
end
go
CREATE PROC GetCDRWebTipoOperacion
as
begin
	select 
		CodigoOperacion,
		DescripcionOperacion,
		NumeroDiasAtrasOperacion
	from [dbo].[TipoOperacionesCDR]
end
go



USE [BelcorpPuertoRico]
go
if exists (select * from sys.objects where type = 'P' and name like '%GetCDRWebTipoOperacion%')
begin
	DROP PROCEDURE dbo.GetCDRWebTipoOperacion
	PRINT 'elimino'
end
go
CREATE PROC GetCDRWebTipoOperacion
as
begin
	select 
		CodigoOperacion,
		DescripcionOperacion,
		NumeroDiasAtrasOperacion
	from [dbo].[TipoOperacionesCDR]
end
go




USE [BelcorpSalvador]
go
if exists (select * from sys.objects where type = 'P' and name like '%GetCDRWebTipoOperacion%')
begin
	DROP PROCEDURE dbo.GetCDRWebTipoOperacion
	PRINT 'elimino'
end
go
CREATE PROC GetCDRWebTipoOperacion
as
begin
	select 
		CodigoOperacion,
		DescripcionOperacion,
		NumeroDiasAtrasOperacion
	from [dbo].[TipoOperacionesCDR]
end
go



USE [BelcorpVenezuela]
go
if exists (select * from sys.objects where type = 'P' and name like '%GetCDRWebTipoOperacion%')
begin
	DROP PROCEDURE dbo.GetCDRWebTipoOperacion
	PRINT 'elimino'
end
go
CREATE PROC GetCDRWebTipoOperacion
as
begin
	select 
		CodigoOperacion,
		DescripcionOperacion,
		NumeroDiasAtrasOperacion
	from [dbo].[TipoOperacionesCDR]
end
go

