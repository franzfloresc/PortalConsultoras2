USE BelcorpBolivia
GO
ALTER PROCEDURE dbo.GetCDRWebDetalleLog
(
	@LogCDRWebID int
)
AS
/*GetCDRWebDetalleLog 16*/
BEGIN
	declare @Campania int = 0;
	declare @CDRWebId int = 0;
	select @Campania = CampaniaId, @CDRWebId = CDRWebId
	from interfaces.LogCDRWeb
	where LogCDRWebID = @LogCDRWebID;

	declare @PedidoId int = 0;
	select @PedidoId = PedidoId
	from CDRWeb
	where CDRWebId = @CDRWebId;

	SELECT
		cd.CDRWebDetalleID
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR as CodigoOperacion
		,cd.CodigoMotivoCDR as CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR as Estado
		,cd.CodigoRechazo as MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.ObservacionRechazo as Observacion
		,pc.Descripcion as Descripcion
		,isnull(pc2.Descripcion,'') as Descripcion2
		,case
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @Campania
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @Campania
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoId
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.CodigoRechazo = cmr.CodigoRechazo
	WHERE c.LogCDRWebID = @LogCDRWebID
END
GO
/*end*/

USE BelcorpChile
GO
ALTER PROCEDURE dbo.GetCDRWebDetalleLog
(
	@LogCDRWebID int
)
AS
/*GetCDRWebDetalleLog 16*/
BEGIN
	declare @Campania int = 0;
	declare @CDRWebId int = 0;
	select @Campania = CampaniaId, @CDRWebId = CDRWebId
	from interfaces.LogCDRWeb
	where LogCDRWebID = @LogCDRWebID;

	declare @PedidoId int = 0;
	select @PedidoId = PedidoId
	from CDRWeb
	where CDRWebId = @CDRWebId;

	SELECT
		cd.CDRWebDetalleID
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR as CodigoOperacion
		,cd.CodigoMotivoCDR as CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR as Estado
		,cd.CodigoRechazo as MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.ObservacionRechazo as Observacion
		,pc.Descripcion as Descripcion
		,isnull(pc2.Descripcion,'') as Descripcion2
		,case
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @Campania
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @Campania
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoId
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.CodigoRechazo = cmr.CodigoRechazo
	WHERE c.LogCDRWebID = @LogCDRWebID
END
GO
/*end*/

USE BelcorpCostaRica
GO
ALTER PROCEDURE dbo.GetCDRWebDetalleLog
(
	@LogCDRWebID int
)
AS
/*GetCDRWebDetalleLog 16*/
BEGIN
	declare @Campania int = 0;
	declare @CDRWebId int = 0;
	select @Campania = CampaniaId, @CDRWebId = CDRWebId
	from interfaces.LogCDRWeb
	where LogCDRWebID = @LogCDRWebID;

	declare @PedidoId int = 0;
	select @PedidoId = PedidoId
	from CDRWeb
	where CDRWebId = @CDRWebId;

	SELECT
		cd.CDRWebDetalleID
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR as CodigoOperacion
		,cd.CodigoMotivoCDR as CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR as Estado
		,cd.CodigoRechazo as MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.ObservacionRechazo as Observacion
		,pc.Descripcion as Descripcion
		,isnull(pc2.Descripcion,'') as Descripcion2
		,case
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @Campania
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @Campania
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoId
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.CodigoRechazo = cmr.CodigoRechazo
	WHERE c.LogCDRWebID = @LogCDRWebID
END
GO
/*end*/

USE BelcorpDominicana
GO
ALTER PROCEDURE dbo.GetCDRWebDetalleLog
(
	@LogCDRWebID int
)
AS
/*GetCDRWebDetalleLog 16*/
BEGIN
	declare @Campania int = 0;
	declare @CDRWebId int = 0;
	select @Campania = CampaniaId, @CDRWebId = CDRWebId
	from interfaces.LogCDRWeb
	where LogCDRWebID = @LogCDRWebID;

	declare @PedidoId int = 0;
	select @PedidoId = PedidoId
	from CDRWeb
	where CDRWebId = @CDRWebId;

	SELECT
		cd.CDRWebDetalleID
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR as CodigoOperacion
		,cd.CodigoMotivoCDR as CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR as Estado
		,cd.CodigoRechazo as MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.ObservacionRechazo as Observacion
		,pc.Descripcion as Descripcion
		,isnull(pc2.Descripcion,'') as Descripcion2
		,case
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @Campania
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @Campania
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoId
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.CodigoRechazo = cmr.CodigoRechazo
	WHERE c.LogCDRWebID = @LogCDRWebID
END
GO
/*end*/

USE BelcorpEcuador
GO
ALTER PROCEDURE dbo.GetCDRWebDetalleLog
(
	@LogCDRWebID int
)
AS
/*GetCDRWebDetalleLog 16*/
BEGIN
	declare @Campania int = 0;
	declare @CDRWebId int = 0;
	select @Campania = CampaniaId, @CDRWebId = CDRWebId
	from interfaces.LogCDRWeb
	where LogCDRWebID = @LogCDRWebID;

	declare @PedidoId int = 0;
	select @PedidoId = PedidoId
	from CDRWeb
	where CDRWebId = @CDRWebId;

	SELECT
		cd.CDRWebDetalleID
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR as CodigoOperacion
		,cd.CodigoMotivoCDR as CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR as Estado
		,cd.CodigoRechazo as MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.ObservacionRechazo as Observacion
		,pc.Descripcion as Descripcion
		,isnull(pc2.Descripcion,'') as Descripcion2
		,case
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @Campania
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @Campania
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoId
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.CodigoRechazo = cmr.CodigoRechazo
	WHERE c.LogCDRWebID = @LogCDRWebID
END
GO
/*end*/

USE BelcorpGuatemala
GO
ALTER PROCEDURE dbo.GetCDRWebDetalleLog
(
	@LogCDRWebID int
)
AS
/*GetCDRWebDetalleLog 16*/
BEGIN
	declare @Campania int = 0;
	declare @CDRWebId int = 0;
	select @Campania = CampaniaId, @CDRWebId = CDRWebId
	from interfaces.LogCDRWeb
	where LogCDRWebID = @LogCDRWebID;

	declare @PedidoId int = 0;
	select @PedidoId = PedidoId
	from CDRWeb
	where CDRWebId = @CDRWebId;

	SELECT
		cd.CDRWebDetalleID
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR as CodigoOperacion
		,cd.CodigoMotivoCDR as CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR as Estado
		,cd.CodigoRechazo as MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.ObservacionRechazo as Observacion
		,pc.Descripcion as Descripcion
		,isnull(pc2.Descripcion,'') as Descripcion2
		,case
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @Campania
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @Campania
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoId
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.CodigoRechazo = cmr.CodigoRechazo
	WHERE c.LogCDRWebID = @LogCDRWebID
END
GO
/*end*/

USE BelcorpPanama
GO
ALTER PROCEDURE dbo.GetCDRWebDetalleLog
(
	@LogCDRWebID int
)
AS
/*GetCDRWebDetalleLog 16*/
BEGIN
	declare @Campania int = 0;
	declare @CDRWebId int = 0;
	select @Campania = CampaniaId, @CDRWebId = CDRWebId
	from interfaces.LogCDRWeb
	where LogCDRWebID = @LogCDRWebID;

	declare @PedidoId int = 0;
	select @PedidoId = PedidoId
	from CDRWeb
	where CDRWebId = @CDRWebId;

	SELECT
		cd.CDRWebDetalleID
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR as CodigoOperacion
		,cd.CodigoMotivoCDR as CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR as Estado
		,cd.CodigoRechazo as MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.ObservacionRechazo as Observacion
		,pc.Descripcion as Descripcion
		,isnull(pc2.Descripcion,'') as Descripcion2
		,case
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @Campania
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @Campania
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoId
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.CodigoRechazo = cmr.CodigoRechazo
	WHERE c.LogCDRWebID = @LogCDRWebID
END
GO
/*end*/

USE BelcorpPuertoRico
GO
ALTER PROCEDURE dbo.GetCDRWebDetalleLog
(
	@LogCDRWebID int
)
AS
/*GetCDRWebDetalleLog 16*/
BEGIN
	declare @Campania int = 0;
	declare @CDRWebId int = 0;
	select @Campania = CampaniaId, @CDRWebId = CDRWebId
	from interfaces.LogCDRWeb
	where LogCDRWebID = @LogCDRWebID;

	declare @PedidoId int = 0;
	select @PedidoId = PedidoId
	from CDRWeb
	where CDRWebId = @CDRWebId;

	SELECT
		cd.CDRWebDetalleID
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR as CodigoOperacion
		,cd.CodigoMotivoCDR as CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR as Estado
		,cd.CodigoRechazo as MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.ObservacionRechazo as Observacion
		,pc.Descripcion as Descripcion
		,isnull(pc2.Descripcion,'') as Descripcion2
		,case
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @Campania
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @Campania
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoId
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.CodigoRechazo = cmr.CodigoRechazo
	WHERE c.LogCDRWebID = @LogCDRWebID
END
GO
/*end*/

USE BelcorpSalvador
GO
ALTER PROCEDURE dbo.GetCDRWebDetalleLog
(
	@LogCDRWebID int
)
AS
/*GetCDRWebDetalleLog 16*/
BEGIN
	declare @Campania int = 0;
	declare @CDRWebId int = 0;
	select @Campania = CampaniaId, @CDRWebId = CDRWebId
	from interfaces.LogCDRWeb
	where LogCDRWebID = @LogCDRWebID;

	declare @PedidoId int = 0;
	select @PedidoId = PedidoId
	from CDRWeb
	where CDRWebId = @CDRWebId;

	SELECT
		cd.CDRWebDetalleID
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR as CodigoOperacion
		,cd.CodigoMotivoCDR as CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR as Estado
		,cd.CodigoRechazo as MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.ObservacionRechazo as Observacion
		,pc.Descripcion as Descripcion
		,isnull(pc2.Descripcion,'') as Descripcion2
		,case
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @Campania
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @Campania
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoId
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.CodigoRechazo = cmr.CodigoRechazo
	WHERE c.LogCDRWebID = @LogCDRWebID
END
GO
/*end*/

USE BelcorpVenezuela
GO
ALTER PROCEDURE dbo.GetCDRWebDetalleLog
(
	@LogCDRWebID int
)
AS
/*GetCDRWebDetalleLog 16*/
BEGIN
	declare @Campania int = 0;
	declare @CDRWebId int = 0;
	select @Campania = CampaniaId, @CDRWebId = CDRWebId
	from interfaces.LogCDRWeb
	where LogCDRWebID = @LogCDRWebID;

	declare @PedidoId int = 0;
	select @PedidoId = PedidoId
	from CDRWeb
	where CDRWebId = @CDRWebId;

	SELECT
		cd.CDRWebDetalleID
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR as CodigoOperacion
		,cd.CodigoMotivoCDR as CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR as Estado
		,cd.CodigoRechazo as MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.ObservacionRechazo as Observacion
		,pc.Descripcion as Descripcion
		,isnull(pc2.Descripcion,'') as Descripcion2
		,case
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @Campania
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @Campania
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoId
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.CodigoRechazo = cmr.CodigoRechazo
	WHERE c.LogCDRWebID = @LogCDRWebID
END
GO
/*end*/

USE BelcorpColombia
GO
ALTER PROCEDURE dbo.GetCDRWebDetalleLog
(
	@LogCDRWebID int
)
AS
/*GetCDRWebDetalleLog 16*/
BEGIN
	declare @Campania int = 0;
	declare @CDRWebId int = 0;
	select @Campania = CampaniaId, @CDRWebId = CDRWebId
	from interfaces.LogCDRWeb
	where LogCDRWebID = @LogCDRWebID;

	declare @PedidoId int = 0;
	select @PedidoId = PedidoId
	from CDRWeb
	where CDRWebId = @CDRWebId;

	SELECT
		cd.CDRWebDetalleID
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR as CodigoOperacion
		,cd.CodigoMotivoCDR as CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR as Estado
		,cd.CodigoRechazo as MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.ObservacionRechazo as Observacion
		,pc.Descripcion as Descripcion
		,isnull(pc2.Descripcion,'') as Descripcion2
		,case
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @Campania
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @Campania
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoId
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.CodigoRechazo = cmr.CodigoRechazo
	WHERE c.LogCDRWebID = @LogCDRWebID
END
GO
/*end*/

USE BelcorpMexico
GO
ALTER PROCEDURE dbo.GetCDRWebDetalleLog
(
	@LogCDRWebID int
)
AS
/*GetCDRWebDetalleLog 16*/
BEGIN
	declare @Campania int = 0;
	declare @CDRWebId int = 0;
	select @Campania = CampaniaId, @CDRWebId = CDRWebId
	from interfaces.LogCDRWeb
	where LogCDRWebID = @LogCDRWebID;

	declare @PedidoId int = 0;
	select @PedidoId = PedidoId
	from CDRWeb
	where CDRWebId = @CDRWebId;

	SELECT
		cd.CDRWebDetalleID
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR as CodigoOperacion
		,cd.CodigoMotivoCDR as CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR as Estado
		,cd.CodigoRechazo as MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.ObservacionRechazo as Observacion
		,pc.Descripcion as Descripcion
		,isnull(pc2.Descripcion,'') as Descripcion2
		,case
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @Campania
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @Campania
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoId
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.CodigoRechazo = cmr.CodigoRechazo
	WHERE c.LogCDRWebID = @LogCDRWebID
END
GO
/*end*/

USE BelcorpPeru
GO
ALTER PROCEDURE dbo.GetCDRWebDetalleLog
(
	@LogCDRWebID int
)
AS
/*GetCDRWebDetalleLog 16*/
BEGIN
	declare @Campania int = 0;
	declare @CDRWebId int = 0;
	select @Campania = CampaniaId, @CDRWebId = CDRWebId
	from interfaces.LogCDRWeb
	where LogCDRWebID = @LogCDRWebID;

	declare @PedidoId int = 0;
	select @PedidoId = PedidoId
	from CDRWeb
	where CDRWebId = @CDRWebId;

	SELECT
		cd.CDRWebDetalleID
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR as CodigoOperacion
		,cd.CodigoMotivoCDR as CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR as Estado
		,cd.CodigoRechazo as MotivoRechazo
		,isnull(cmr.Tipo,0) as TipoMotivoRechazo
		,cd.ObservacionRechazo as Observacion
		,pc.Descripcion as Descripcion
		,isnull(pc2.Descripcion,'') as Descripcion2
		,case
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)		
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CodigoOperacionCDR = LTRIM(RTRIM('T')) then (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			else (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = @Campania
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = @Campania
	INNER JOIN ods.PedidoDetalle pwd on pwd.CUV = cd.CUV and pwd.PedidoID = @PedidoId
	LEFT JOIN CDRWebMotivoRechazo cmr on cd.CodigoRechazo = cmr.CodigoRechazo
	WHERE c.LogCDRWebID = @LogCDRWebID
END
GO