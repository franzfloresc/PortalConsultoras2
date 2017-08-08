use BelcorpChile_Plan20
go
if not exists(select 1 from sysobjects where name = 'OfertaFinalRegaloXCampania' and xtype = 'u')
Begin
	create table OfertaFinalRegaloXCampania
	(
		CampaniaId int not null,
		Cuv varchar(10),
		RangoId Int,
		PRIMARY KEY CLUSTERED (CampaniaId,Cuv,RangoId)
	)
End
