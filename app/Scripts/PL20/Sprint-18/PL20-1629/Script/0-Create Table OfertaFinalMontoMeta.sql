use BelcorpChile
go
if not exists(select 1 from sysobjects where name = 'OfertaFinalMontoMeta' and xtype = 'u')
Begin
	create table OfertaFinalMontoMeta
	(
		CampaniaId int not null,
		ConsultoraId int not null,
		MontoPedido decimal(18,2),
		GapMinimo decimal(18,2),
		GapMaximo decimal(18,2),
		GapAgregar decimal(18,2),
		MontoMeta decimal(18,2),
		Cuv varchar(10)
		PRIMARY KEY CLUSTERED (CampaniaId,ConsultoraId)
	)
End