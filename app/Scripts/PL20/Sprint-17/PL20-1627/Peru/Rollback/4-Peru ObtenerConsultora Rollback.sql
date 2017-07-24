use BelcorpPeru
go
if exists(select 1 from sysobjects where name = 'ObtenerConsultora' and xtype = 'p')
Drop Procedure ObtenerConsultora
go
