USE BelcorpBolivia
GO

IF NOT EXISTS(select 1 from sysobjects where name = 'OfertaFinalMontoMeta' and xtype = 'u')
BEGIN
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
END
GO
/*end*/

USE BelcorpChile
GO

IF NOT EXISTS(select 1 from sysobjects where name = 'OfertaFinalMontoMeta' and xtype = 'u')
BEGIN
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
END
GO
/*end*/

USE BelcorpColombia
GO

IF NOT EXISTS(select 1 from sysobjects where name = 'OfertaFinalMontoMeta' and xtype = 'u')
BEGIN
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
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF NOT EXISTS(select 1 from sysobjects where name = 'OfertaFinalMontoMeta' and xtype = 'u')
BEGIN
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
END
GO
/*end*/

USE BelcorpDominicana
GO

IF NOT EXISTS(select 1 from sysobjects where name = 'OfertaFinalMontoMeta' and xtype = 'u')
BEGIN
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
END
GO
/*end*/

USE BelcorpEcuador
GO

IF NOT EXISTS(select 1 from sysobjects where name = 'OfertaFinalMontoMeta' and xtype = 'u')
BEGIN
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
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF NOT EXISTS(select 1 from sysobjects where name = 'OfertaFinalMontoMeta' and xtype = 'u')
BEGIN
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
END
GO
/*end*/

USE BelcorpMexico
GO

IF NOT EXISTS(select 1 from sysobjects where name = 'OfertaFinalMontoMeta' and xtype = 'u')
BEGIN
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
END
GO
/*end*/

USE BelcorpPanama
GO

IF NOT EXISTS(select 1 from sysobjects where name = 'OfertaFinalMontoMeta' and xtype = 'u')
BEGIN
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
END
GO
/*end*/

USE BelcorpPeru
GO

IF NOT EXISTS(select 1 from sysobjects where name = 'OfertaFinalMontoMeta' and xtype = 'u')
BEGIN
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
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF NOT EXISTS(select 1 from sysobjects where name = 'OfertaFinalMontoMeta' and xtype = 'u')
BEGIN
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
END
GO
/*end*/

USE BelcorpSalvador
GO

IF NOT EXISTS(select 1 from sysobjects where name = 'OfertaFinalMontoMeta' and xtype = 'u')
BEGIN
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
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF NOT EXISTS(select 1 from sysobjects where name = 'OfertaFinalMontoMeta' and xtype = 'u')
BEGIN
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
END
GO
