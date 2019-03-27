USE BelcorpBolivia
GO
if object_id('dbo.GetPremioElecProgNuevas') IS NOT NULL
	DROP PROC dbo.GetPremioElecProgNuevas
GO
CREATE PROCEDURE [dbo].[GetPremioElecProgNuevas]
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
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and CPN.CodigoNivel = @CodigoNivel and
		CPN.IND_CUPO_ELEC = 1 and isnull(CPN.PrecioUnitario,0) = 0 and isnull(PC.PrecioCatalogo,0) = 0
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END
GO

USE BelcorpChile
GO
if object_id('dbo.GetPremioElecProgNuevas') IS NOT NULL
	DROP PROC dbo.GetPremioElecProgNuevas
GO
CREATE PROCEDURE [dbo].[GetPremioElecProgNuevas]
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
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and CPN.CodigoNivel = @CodigoNivel and
		CPN.IND_CUPO_ELEC = 1 and isnull(CPN.PrecioUnitario,0) = 0 and isnull(PC.PrecioCatalogo,0) = 0
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END
GO

USE BelcorpColombia
GO
if object_id('dbo.GetPremioElecProgNuevas') IS NOT NULL
	DROP PROC dbo.GetPremioElecProgNuevas
GO
CREATE PROCEDURE [dbo].[GetPremioElecProgNuevas]
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
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and CPN.CodigoNivel = @CodigoNivel and
		CPN.IND_CUPO_ELEC = 1 and isnull(CPN.PrecioUnitario,0) = 0 and isnull(PC.PrecioCatalogo,0) = 0
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END
GO

USE BelcorpCostaRica
GO
if object_id('dbo.GetPremioElecProgNuevas') IS NOT NULL
	DROP PROC dbo.GetPremioElecProgNuevas
GO
CREATE PROCEDURE [dbo].[GetPremioElecProgNuevas]
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
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and CPN.CodigoNivel = @CodigoNivel and
		CPN.IND_CUPO_ELEC = 1 and isnull(CPN.PrecioUnitario,0) = 0 and isnull(PC.PrecioCatalogo,0) = 0
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END
GO

USE BelcorpDominicana
GO
if object_id('dbo.GetPremioElecProgNuevas') IS NOT NULL
	DROP PROC dbo.GetPremioElecProgNuevas
GO
CREATE PROCEDURE [dbo].[GetPremioElecProgNuevas]
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
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and CPN.CodigoNivel = @CodigoNivel and
		CPN.IND_CUPO_ELEC = 1 and isnull(CPN.PrecioUnitario,0) = 0 and isnull(PC.PrecioCatalogo,0) = 0
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END
GO

USE BelcorpEcuador
GO
if object_id('dbo.GetPremioElecProgNuevas') IS NOT NULL
	DROP PROC dbo.GetPremioElecProgNuevas
GO
CREATE PROCEDURE [dbo].[GetPremioElecProgNuevas]
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
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and CPN.CodigoNivel = @CodigoNivel and
		CPN.IND_CUPO_ELEC = 1 and isnull(CPN.PrecioUnitario,0) = 0 and isnull(PC.PrecioCatalogo,0) = 0
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END
GO

USE BelcorpGuatemala
GO
if object_id('dbo.GetPremioElecProgNuevas') IS NOT NULL
	DROP PROC dbo.GetPremioElecProgNuevas
GO
CREATE PROCEDURE [dbo].[GetPremioElecProgNuevas]
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
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and CPN.CodigoNivel = @CodigoNivel and
		CPN.IND_CUPO_ELEC = 1 and isnull(CPN.PrecioUnitario,0) = 0 and isnull(PC.PrecioCatalogo,0) = 0
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END
GO

USE BelcorpMexico
GO
if object_id('dbo.GetPremioElecProgNuevas') IS NOT NULL
	DROP PROC dbo.GetPremioElecProgNuevas
GO
CREATE PROCEDURE [dbo].[GetPremioElecProgNuevas]
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
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and CPN.CodigoNivel = @CodigoNivel and
		CPN.IND_CUPO_ELEC = 1 and isnull(CPN.PrecioUnitario,0) = 0 and isnull(PC.PrecioCatalogo,0) = 0
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END
GO

USE BelcorpPanama
GO
if object_id('dbo.GetPremioElecProgNuevas') IS NOT NULL
	DROP PROC dbo.GetPremioElecProgNuevas
GO
CREATE PROCEDURE [dbo].[GetPremioElecProgNuevas]
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
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and CPN.CodigoNivel = @CodigoNivel and
		CPN.IND_CUPO_ELEC = 1 and isnull(CPN.PrecioUnitario,0) = 0 and isnull(PC.PrecioCatalogo,0) = 0
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END
GO

USE BelcorpPeru
GO
if object_id('dbo.GetPremioElecProgNuevas') IS NOT NULL
	DROP PROC dbo.GetPremioElecProgNuevas
GO
CREATE PROCEDURE [dbo].[GetPremioElecProgNuevas]
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
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and CPN.CodigoNivel = @CodigoNivel and
		CPN.IND_CUPO_ELEC = 1 and isnull(CPN.PrecioUnitario,0) = 0 and isnull(PC.PrecioCatalogo,0) = 0
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END
GO

USE BelcorpPuertoRico
GO
if object_id('dbo.GetPremioElecProgNuevas') IS NOT NULL
	DROP PROC dbo.GetPremioElecProgNuevas
GO
CREATE PROCEDURE [dbo].[GetPremioElecProgNuevas]
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
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and CPN.CodigoNivel = @CodigoNivel and
		CPN.IND_CUPO_ELEC = 1 and isnull(CPN.PrecioUnitario,0) = 0 and isnull(PC.PrecioCatalogo,0) = 0
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END
GO

USE BelcorpSalvador
GO
if object_id('dbo.GetPremioElecProgNuevas') IS NOT NULL
	DROP PROC dbo.GetPremioElecProgNuevas
GO
CREATE PROCEDURE [dbo].[GetPremioElecProgNuevas]
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
		CPN.CodigoPrograma = @CodigoPrograma and CPN.Campana = @Campania and CPN.CodigoNivel = @CodigoNivel and
		CPN.IND_CUPO_ELEC = 1 and isnull(CPN.PrecioUnitario,0) = 0 and isnull(PC.PrecioCatalogo,0) = 0
	order by CPN.INC_CUPO_ELEC_DEFA desc;
END
GO