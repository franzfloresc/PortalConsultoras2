use BelcorpChile_Plan20
go
if exists(select 1 from sysobjects where name = 'OfertaFinalRegaloXCampania' and xtype = 'u')
Begin
	drop table OfertaFinalRegaloXCampania
End
