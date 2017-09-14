USE BelcorpBolivia
go

USE BelcorpChile_BPT
go

USE BelcorpColombia
go

USE BelcorpCostaRica
go

USE BelcorpDominicana
go

USE BelcorpEcuador
go

USE BelcorpGuatemala
go

USE BelcorpMexico_Plan20
go

IF EXISTS (select * from sys.objects where type = 'U' and name like '%EventoFestivo%')
	DROP TABLE [dbo].[EventoFestivo]
GO

IF EXISTS (select * from sys.objects where type = 'P' and name like '%GetEventoFestivo%')
BEGIN
	DROP PROC [dbo].[GetEventoFestivo]
END

go

USE BelcorpPanama
go

USE BelcorpPeru_BPT
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

USE BelcorpSalvador
go

USE BelcorpVenezuela
go