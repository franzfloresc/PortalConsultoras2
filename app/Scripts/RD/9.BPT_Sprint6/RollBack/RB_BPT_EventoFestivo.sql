USE BelcorpBolivia
go

IF EXISTS (select * from sys.objects where type = 'P' and name like '%GetEventoFestivo%')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END

GO

IF EXISTS (select * from sys.objects where type = 'U' and name like '%EventoFestivo%')
	DROP TABLE [dbo].[EventoFestivo]
GO

USE BelcorpChile
go

IF EXISTS (select * from sys.objects where type = 'P' and name like '%GetEventoFestivo%')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END

GO

IF EXISTS (select * from sys.objects where type = 'U' and name like '%EventoFestivo%')
	DROP TABLE [dbo].[EventoFestivo]
GO

USE BelcorpColombia
go

IF EXISTS (select * from sys.objects where type = 'P' and name like '%GetEventoFestivo%')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END

GO

IF EXISTS (select * from sys.objects where type = 'U' and name like '%EventoFestivo%')
	DROP TABLE [dbo].[EventoFestivo]
GO

USE BelcorpCostaRica
go

IF EXISTS (select * from sys.objects where type = 'P' and name like '%GetEventoFestivo%')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END

GO

IF EXISTS (select * from sys.objects where type = 'U' and name like '%EventoFestivo%')
	DROP TABLE [dbo].[EventoFestivo]
GO

USE BelcorpDominicana
go

IF EXISTS (select * from sys.objects where type = 'P' and name like '%GetEventoFestivo%')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END

GO

IF EXISTS (select * from sys.objects where type = 'U' and name like '%EventoFestivo%')
	DROP TABLE [dbo].[EventoFestivo]
GO

USE BelcorpEcuador
go

IF EXISTS (select * from sys.objects where type = 'P' and name like '%GetEventoFestivo%')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END

GO

IF EXISTS (select * from sys.objects where type = 'U' and name like '%EventoFestivo%')
	DROP TABLE [dbo].[EventoFestivo]
GO

USE BelcorpGuatemala
go

IF EXISTS (select * from sys.objects where type = 'P' and name like '%GetEventoFestivo%')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END

GO

IF EXISTS (select * from sys.objects where type = 'U' and name like '%EventoFestivo%')
	DROP TABLE [dbo].[EventoFestivo]
GO

USE BelcorpMexico
go

IF EXISTS (select * from sys.objects where type = 'P' and name like '%GetEventoFestivo%')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END

GO

IF EXISTS (select * from sys.objects where type = 'U' and name like '%EventoFestivo%')
	DROP TABLE [dbo].[EventoFestivo]
GO

USE BelcorpPanama
go

IF EXISTS (select * from sys.objects where type = 'P' and name like '%GetEventoFestivo%')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END

GO

IF EXISTS (select * from sys.objects where type = 'U' and name like '%EventoFestivo%')
	DROP TABLE [dbo].[EventoFestivo]
GO

USE BelcorpPeru
go

IF EXISTS (select * from sys.objects where type = 'U' and name like '%EventoFestivo%')
	DROP TABLE [dbo].[EventoFestivo]
GO

IF EXISTS (select * from sys.objects where type = 'P' and name like '%GetEventoFestivo%')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END

go

USE BelcorpPuertoRico
go

IF EXISTS (select * from sys.objects where type = 'P' and name like '%GetEventoFestivo%')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END

GO

IF EXISTS (select * from sys.objects where type = 'U' and name like '%EventoFestivo%')
	DROP TABLE [dbo].[EventoFestivo]
GO

USE BelcorpSalvador
go

IF EXISTS (select * from sys.objects where type = 'P' and name like '%GetEventoFestivo%')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END

GO

IF EXISTS (select * from sys.objects where type = 'U' and name like '%EventoFestivo%')
	DROP TABLE [dbo].[EventoFestivo]
GO

USE BelcorpVenezuela
go

IF EXISTS (select * from sys.objects where type = 'P' and name like '%GetEventoFestivo%')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END

GO

IF EXISTS (select * from sys.objects where type = 'U' and name like '%EventoFestivo%')
	DROP TABLE [dbo].[EventoFestivo]
GO