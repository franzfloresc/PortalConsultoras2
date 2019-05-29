USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[GetPremioElecProgNuevas]
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select
		CPN.CodigoCupon as CUVPremio,
		PC.CodigoProducto as CodigoSap,
		coalesce(PC.Descripcion, PD.Descripcion) as DescripcionPremio,
		isnull(PC.PrecioValorizado, 0) as PrecioValorizado
	from ods.CuponesProgramaNuevas CPN with(nolock)
	inner join ods.ProductoComercial PC with(nolock) on PC.AnoCampania = CPN.Campana and PC.CUV = CPN.CodigoCupon
	left join ProductoDescripcion PD with(nolock) on PD.CampaniaID = PC.AnoCampania and PD.CUV = PC.CUV
	where
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and
		CPN.CodigoNivel = @CodigoNivel and CPN.IND_CUPO_ELEC = 1
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END

GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[GetPremioElecProgNuevas]
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select
		CPN.CodigoCupon as CUVPremio,
		PC.CodigoProducto as CodigoSap,
		coalesce(PC.Descripcion, PD.Descripcion) as DescripcionPremio,
		isnull(PC.PrecioValorizado, 0) as PrecioValorizado
	from ods.CuponesProgramaNuevas CPN with(nolock)
	inner join ods.ProductoComercial PC with(nolock) on PC.AnoCampania = CPN.Campana and PC.CUV = CPN.CodigoCupon
	left join ProductoDescripcion PD with(nolock) on PD.CampaniaID = PC.AnoCampania and PD.CUV = PC.CUV
	where
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and
		CPN.CodigoNivel = @CodigoNivel and CPN.IND_CUPO_ELEC = 1
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END

GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[GetPremioElecProgNuevas]
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select
		CPN.CodigoCupon as CUVPremio,
		PC.CodigoProducto as CodigoSap,
		coalesce(PC.Descripcion, PD.Descripcion) as DescripcionPremio,
		isnull(PC.PrecioValorizado, 0) as PrecioValorizado
	from ods.CuponesProgramaNuevas CPN with(nolock)
	inner join ods.ProductoComercial PC with(nolock) on PC.AnoCampania = CPN.Campana and PC.CUV = CPN.CodigoCupon
	left join ProductoDescripcion PD with(nolock) on PD.CampaniaID = PC.AnoCampania and PD.CUV = PC.CUV
	where
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and
		CPN.CodigoNivel = @CodigoNivel and CPN.IND_CUPO_ELEC = 1
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END

GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[GetPremioElecProgNuevas]
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select
		CPN.CodigoCupon as CUVPremio,
		PC.CodigoProducto as CodigoSap,
		coalesce(PC.Descripcion, PD.Descripcion) as DescripcionPremio,
		isnull(PC.PrecioValorizado, 0) as PrecioValorizado
	from ods.CuponesProgramaNuevas CPN with(nolock)
	inner join ods.ProductoComercial PC with(nolock) on PC.AnoCampania = CPN.Campana and PC.CUV = CPN.CodigoCupon
	left join ProductoDescripcion PD with(nolock) on PD.CampaniaID = PC.AnoCampania and PD.CUV = PC.CUV
	where
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and
		CPN.CodigoNivel = @CodigoNivel and CPN.IND_CUPO_ELEC = 1
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END

GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[GetPremioElecProgNuevas]
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select
		CPN.CodigoCupon as CUVPremio,
		PC.CodigoProducto as CodigoSap,
		coalesce(PC.Descripcion, PD.Descripcion) as DescripcionPremio,
		isnull(PC.PrecioValorizado, 0) as PrecioValorizado
	from ods.CuponesProgramaNuevas CPN with(nolock)
	inner join ods.ProductoComercial PC with(nolock) on PC.AnoCampania = CPN.Campana and PC.CUV = CPN.CodigoCupon
	left join ProductoDescripcion PD with(nolock) on PD.CampaniaID = PC.AnoCampania and PD.CUV = PC.CUV
	where
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and
		CPN.CodigoNivel = @CodigoNivel and CPN.IND_CUPO_ELEC = 1
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END

GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[GetPremioElecProgNuevas]
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select
		CPN.CodigoCupon as CUVPremio,
		PC.CodigoProducto as CodigoSap,
		coalesce(PC.Descripcion, PD.Descripcion) as DescripcionPremio,
		isnull(PC.PrecioValorizado, 0) as PrecioValorizado
	from ods.CuponesProgramaNuevas CPN with(nolock)
	inner join ods.ProductoComercial PC with(nolock) on PC.AnoCampania = CPN.Campana and PC.CUV = CPN.CodigoCupon
	left join ProductoDescripcion PD with(nolock) on PD.CampaniaID = PC.AnoCampania and PD.CUV = PC.CUV
	where
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and
		CPN.CodigoNivel = @CodigoNivel and CPN.IND_CUPO_ELEC = 1
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END

GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[GetPremioElecProgNuevas]
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select
		CPN.CodigoCupon as CUVPremio,
		PC.CodigoProducto as CodigoSap,
		coalesce(PC.Descripcion, PD.Descripcion) as DescripcionPremio,
		isnull(PC.PrecioValorizado, 0) as PrecioValorizado
	from ods.CuponesProgramaNuevas CPN with(nolock)
	inner join ods.ProductoComercial PC with(nolock) on PC.AnoCampania = CPN.Campana and PC.CUV = CPN.CodigoCupon
	left join ProductoDescripcion PD with(nolock) on PD.CampaniaID = PC.AnoCampania and PD.CUV = PC.CUV
	where
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and
		CPN.CodigoNivel = @CodigoNivel and CPN.IND_CUPO_ELEC = 1
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END

GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[GetPremioElecProgNuevas]
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select
		CPN.CodigoCupon as CUVPremio,
		PC.CodigoProducto as CodigoSap,
		coalesce(PC.Descripcion, PD.Descripcion) as DescripcionPremio,
		isnull(PC.PrecioValorizado, 0) as PrecioValorizado
	from ods.CuponesProgramaNuevas CPN with(nolock)
	inner join ods.ProductoComercial PC with(nolock) on PC.AnoCampania = CPN.Campana and PC.CUV = CPN.CodigoCupon
	left join ProductoDescripcion PD with(nolock) on PD.CampaniaID = PC.AnoCampania and PD.CUV = PC.CUV
	where
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and
		CPN.CodigoNivel = @CodigoNivel and CPN.IND_CUPO_ELEC = 1
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END

GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[GetPremioElecProgNuevas]
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select
		CPN.CodigoCupon as CUVPremio,
		PC.CodigoProducto as CodigoSap,
		coalesce(PC.Descripcion, PD.Descripcion) as DescripcionPremio,
		isnull(PC.PrecioValorizado, 0) as PrecioValorizado
	from ods.CuponesProgramaNuevas CPN with(nolock)
	inner join ods.ProductoComercial PC with(nolock) on PC.AnoCampania = CPN.Campana and PC.CUV = CPN.CodigoCupon
	left join ProductoDescripcion PD with(nolock) on PD.CampaniaID = PC.AnoCampania and PD.CUV = PC.CUV
	where
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and
		CPN.CodigoNivel = @CodigoNivel and CPN.IND_CUPO_ELEC = 1
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END

GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetPremioElecProgNuevas]
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select
		CPN.CodigoCupon as CUVPremio,
		PC.CodigoProducto as CodigoSap,
		coalesce(PC.Descripcion, PD.Descripcion) as DescripcionPremio,
		isnull(PC.PrecioValorizado, 0) as PrecioValorizado
	from ods.CuponesProgramaNuevas CPN with(nolock)
	inner join ods.ProductoComercial PC with(nolock) on PC.AnoCampania = CPN.Campana and PC.CUV = CPN.CodigoCupon
	left join ProductoDescripcion PD with(nolock) on PD.CampaniaID = PC.AnoCampania and PD.CUV = PC.CUV
	where
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and
		CPN.CodigoNivel = @CodigoNivel and CPN.IND_CUPO_ELEC = 1
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END

GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[GetPremioElecProgNuevas]
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select
		CPN.CodigoCupon as CUVPremio,
		PC.CodigoProducto as CodigoSap,
		coalesce(PC.Descripcion, PD.Descripcion) as DescripcionPremio,
		isnull(PC.PrecioValorizado, 0) as PrecioValorizado
	from ods.CuponesProgramaNuevas CPN with(nolock)
	inner join ods.ProductoComercial PC with(nolock) on PC.AnoCampania = CPN.Campana and PC.CUV = CPN.CodigoCupon
	left join ProductoDescripcion PD with(nolock) on PD.CampaniaID = PC.AnoCampania and PD.CUV = PC.CUV
	where
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and
		CPN.CodigoNivel = @CodigoNivel and CPN.IND_CUPO_ELEC = 1
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END

GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[GetPremioElecProgNuevas]
	@CodigoPrograma varchar(3),
	@Campania char(6),
	@CodigoNivel char(2)
AS
BEGIN
	select
		CPN.CodigoCupon as CUVPremio,
		PC.CodigoProducto as CodigoSap,
		coalesce(PC.Descripcion, PD.Descripcion) as DescripcionPremio,
		isnull(PC.PrecioValorizado, 0) as PrecioValorizado
	from ods.CuponesProgramaNuevas CPN with(nolock)
	inner join ods.ProductoComercial PC with(nolock) on PC.AnoCampania = CPN.Campana and PC.CUV = CPN.CodigoCupon
	left join ProductoDescripcion PD with(nolock) on PD.CampaniaID = PC.AnoCampania and PD.CUV = PC.CUV
	where
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and
		CPN.CodigoNivel = @CodigoNivel and CPN.IND_CUPO_ELEC = 1
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END

GO