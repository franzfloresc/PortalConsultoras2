USE BelcorpBolivia
GO
ALTER PROCEDURE interfaces.GetLogCDRWebDetalle
	@LogCDRWebId BIGINT
AS
BEGIN
	INSERT INTO interfaces.LogCDRWebDetalle(
		LogCDRWebId,
		CDRWebDetalleId,
		CodigoOperacionCDR,
		CodigoMotivoCDR,
		CUV,
		Cantidad,
		PedidoId,
		CUV2,
		Cantidad2
	)
	SELECT
		@LogCDRWebId,
		CDRWD.CDRWebDetalleID,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		LCDRW.PedidoId,
		CDRWD.CUV2,
		CDRWD.Cantidad2
	FROM LogCDRWeb LCDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = LCDRW.CDRWebId
	WHERE LCDRW.LogCDRWebId = @LogCDRWebId AND CDRWD.Eliminado = 0;

	SELECT
		cd.LogCDRWebDetalleId,
		cd.CDRWebDetalleID,
		cd.LogCDRWebId,
		cd.PedidoId
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR
		,cd.CodigoMotivoCDR
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR
		,cd.CodigoRechazo
		,cd.ObservacionRechazo
		,pc.Descripcion as NombreProducto
		,isnull(pc2.Descripcion,'') as NombreProducto2
		,case
			when isnull(cd.CUV2,'') = '' or cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)			
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO
/*end*/

USE BelcorpChile
GO
ALTER PROCEDURE interfaces.GetLogCDRWebDetalle
	@LogCDRWebId BIGINT
AS
BEGIN
	INSERT INTO interfaces.LogCDRWebDetalle(
		LogCDRWebId,
		CDRWebDetalleId,
		CodigoOperacionCDR,
		CodigoMotivoCDR,
		CUV,
		Cantidad,
		PedidoId,
		CUV2,
		Cantidad2
	)
	SELECT
		@LogCDRWebId,
		CDRWD.CDRWebDetalleID,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		LCDRW.PedidoId,
		CDRWD.CUV2,
		CDRWD.Cantidad2
	FROM LogCDRWeb LCDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = LCDRW.CDRWebId
	WHERE LCDRW.LogCDRWebId = @LogCDRWebId AND CDRWD.Eliminado = 0;

	SELECT
		cd.LogCDRWebDetalleId,
		cd.CDRWebDetalleID,
		cd.LogCDRWebId,
		cd.PedidoId
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR
		,cd.CodigoMotivoCDR
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR
		,cd.CodigoRechazo
		,cd.ObservacionRechazo
		,pc.Descripcion as NombreProducto
		,isnull(pc2.Descripcion,'') as NombreProducto2
		,case
			when isnull(cd.CUV2,'') = '' or cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)			
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO
/*end*/

USE BelcorpCostaRica
GO
ALTER PROCEDURE interfaces.GetLogCDRWebDetalle
	@LogCDRWebId BIGINT
AS
BEGIN
	INSERT INTO interfaces.LogCDRWebDetalle(
		LogCDRWebId,
		CDRWebDetalleId,
		CodigoOperacionCDR,
		CodigoMotivoCDR,
		CUV,
		Cantidad,
		PedidoId,
		CUV2,
		Cantidad2
	)
	SELECT
		@LogCDRWebId,
		CDRWD.CDRWebDetalleID,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		LCDRW.PedidoId,
		CDRWD.CUV2,
		CDRWD.Cantidad2
	FROM LogCDRWeb LCDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = LCDRW.CDRWebId
	WHERE LCDRW.LogCDRWebId = @LogCDRWebId AND CDRWD.Eliminado = 0;

	SELECT
		cd.LogCDRWebDetalleId,
		cd.CDRWebDetalleID,
		cd.LogCDRWebId,
		cd.PedidoId
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR
		,cd.CodigoMotivoCDR
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR
		,cd.CodigoRechazo
		,cd.ObservacionRechazo
		,pc.Descripcion as NombreProducto
		,isnull(pc2.Descripcion,'') as NombreProducto2
		,case
			when isnull(cd.CUV2,'') = '' or cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)			
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO
/*end*/

USE BelcorpDominicana
GO
ALTER PROCEDURE interfaces.GetLogCDRWebDetalle
	@LogCDRWebId BIGINT
AS
BEGIN
	INSERT INTO interfaces.LogCDRWebDetalle(
		LogCDRWebId,
		CDRWebDetalleId,
		CodigoOperacionCDR,
		CodigoMotivoCDR,
		CUV,
		Cantidad,
		PedidoId,
		CUV2,
		Cantidad2
	)
	SELECT
		@LogCDRWebId,
		CDRWD.CDRWebDetalleID,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		LCDRW.PedidoId,
		CDRWD.CUV2,
		CDRWD.Cantidad2
	FROM LogCDRWeb LCDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = LCDRW.CDRWebId
	WHERE LCDRW.LogCDRWebId = @LogCDRWebId AND CDRWD.Eliminado = 0;

	SELECT
		cd.LogCDRWebDetalleId,
		cd.CDRWebDetalleID,
		cd.LogCDRWebId,
		cd.PedidoId
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR
		,cd.CodigoMotivoCDR
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR
		,cd.CodigoRechazo
		,cd.ObservacionRechazo
		,pc.Descripcion as NombreProducto
		,isnull(pc2.Descripcion,'') as NombreProducto2
		,case
			when isnull(cd.CUV2,'') = '' or cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)			
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO
/*end*/

USE BelcorpEcuador
GO
ALTER PROCEDURE interfaces.GetLogCDRWebDetalle
	@LogCDRWebId BIGINT
AS
BEGIN
	INSERT INTO interfaces.LogCDRWebDetalle(
		LogCDRWebId,
		CDRWebDetalleId,
		CodigoOperacionCDR,
		CodigoMotivoCDR,
		CUV,
		Cantidad,
		PedidoId,
		CUV2,
		Cantidad2
	)
	SELECT
		@LogCDRWebId,
		CDRWD.CDRWebDetalleID,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		LCDRW.PedidoId,
		CDRWD.CUV2,
		CDRWD.Cantidad2
	FROM LogCDRWeb LCDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = LCDRW.CDRWebId
	WHERE LCDRW.LogCDRWebId = @LogCDRWebId AND CDRWD.Eliminado = 0;

	SELECT
		cd.LogCDRWebDetalleId,
		cd.CDRWebDetalleID,
		cd.LogCDRWebId,
		cd.PedidoId
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR
		,cd.CodigoMotivoCDR
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR
		,cd.CodigoRechazo
		,cd.ObservacionRechazo
		,pc.Descripcion as NombreProducto
		,isnull(pc2.Descripcion,'') as NombreProducto2
		,case
			when isnull(cd.CUV2,'') = '' or cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)			
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO
/*end*/

USE BelcorpGuatemala
GO
ALTER PROCEDURE interfaces.GetLogCDRWebDetalle
	@LogCDRWebId BIGINT
AS
BEGIN
	INSERT INTO interfaces.LogCDRWebDetalle(
		LogCDRWebId,
		CDRWebDetalleId,
		CodigoOperacionCDR,
		CodigoMotivoCDR,
		CUV,
		Cantidad,
		PedidoId,
		CUV2,
		Cantidad2
	)
	SELECT
		@LogCDRWebId,
		CDRWD.CDRWebDetalleID,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		LCDRW.PedidoId,
		CDRWD.CUV2,
		CDRWD.Cantidad2
	FROM LogCDRWeb LCDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = LCDRW.CDRWebId
	WHERE LCDRW.LogCDRWebId = @LogCDRWebId AND CDRWD.Eliminado = 0;

	SELECT
		cd.LogCDRWebDetalleId,
		cd.CDRWebDetalleID,
		cd.LogCDRWebId,
		cd.PedidoId
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR
		,cd.CodigoMotivoCDR
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR
		,cd.CodigoRechazo
		,cd.ObservacionRechazo
		,pc.Descripcion as NombreProducto
		,isnull(pc2.Descripcion,'') as NombreProducto2
		,case
			when isnull(cd.CUV2,'') = '' or cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)			
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO
/*end*/

USE BelcorpPanama
GO
ALTER PROCEDURE interfaces.GetLogCDRWebDetalle
	@LogCDRWebId BIGINT
AS
BEGIN
	INSERT INTO interfaces.LogCDRWebDetalle(
		LogCDRWebId,
		CDRWebDetalleId,
		CodigoOperacionCDR,
		CodigoMotivoCDR,
		CUV,
		Cantidad,
		PedidoId,
		CUV2,
		Cantidad2
	)
	SELECT
		@LogCDRWebId,
		CDRWD.CDRWebDetalleID,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		LCDRW.PedidoId,
		CDRWD.CUV2,
		CDRWD.Cantidad2
	FROM LogCDRWeb LCDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = LCDRW.CDRWebId
	WHERE LCDRW.LogCDRWebId = @LogCDRWebId AND CDRWD.Eliminado = 0;

	SELECT
		cd.LogCDRWebDetalleId,
		cd.CDRWebDetalleID,
		cd.LogCDRWebId,
		cd.PedidoId
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR
		,cd.CodigoMotivoCDR
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR
		,cd.CodigoRechazo
		,cd.ObservacionRechazo
		,pc.Descripcion as NombreProducto
		,isnull(pc2.Descripcion,'') as NombreProducto2
		,case
			when isnull(cd.CUV2,'') = '' or cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)			
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
ALTER PROCEDURE interfaces.GetLogCDRWebDetalle
	@LogCDRWebId BIGINT
AS
BEGIN
	INSERT INTO interfaces.LogCDRWebDetalle(
		LogCDRWebId,
		CDRWebDetalleId,
		CodigoOperacionCDR,
		CodigoMotivoCDR,
		CUV,
		Cantidad,
		PedidoId,
		CUV2,
		Cantidad2
	)
	SELECT
		@LogCDRWebId,
		CDRWD.CDRWebDetalleID,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		LCDRW.PedidoId,
		CDRWD.CUV2,
		CDRWD.Cantidad2
	FROM LogCDRWeb LCDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = LCDRW.CDRWebId
	WHERE LCDRW.LogCDRWebId = @LogCDRWebId AND CDRWD.Eliminado = 0;

	SELECT
		cd.LogCDRWebDetalleId,
		cd.CDRWebDetalleID,
		cd.LogCDRWebId,
		cd.PedidoId
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR
		,cd.CodigoMotivoCDR
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR
		,cd.CodigoRechazo
		,cd.ObservacionRechazo
		,pc.Descripcion as NombreProducto
		,isnull(pc2.Descripcion,'') as NombreProducto2
		,case
			when isnull(cd.CUV2,'') = '' or cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)			
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO
/*end*/

USE BelcorpSalvador
GO
ALTER PROCEDURE interfaces.GetLogCDRWebDetalle
	@LogCDRWebId BIGINT
AS
BEGIN
	INSERT INTO interfaces.LogCDRWebDetalle(
		LogCDRWebId,
		CDRWebDetalleId,
		CodigoOperacionCDR,
		CodigoMotivoCDR,
		CUV,
		Cantidad,
		PedidoId,
		CUV2,
		Cantidad2
	)
	SELECT
		@LogCDRWebId,
		CDRWD.CDRWebDetalleID,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		LCDRW.PedidoId,
		CDRWD.CUV2,
		CDRWD.Cantidad2
	FROM LogCDRWeb LCDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = LCDRW.CDRWebId
	WHERE LCDRW.LogCDRWebId = @LogCDRWebId AND CDRWD.Eliminado = 0;

	SELECT
		cd.LogCDRWebDetalleId,
		cd.CDRWebDetalleID,
		cd.LogCDRWebId,
		cd.PedidoId
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR
		,cd.CodigoMotivoCDR
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR
		,cd.CodigoRechazo
		,cd.ObservacionRechazo
		,pc.Descripcion as NombreProducto
		,isnull(pc2.Descripcion,'') as NombreProducto2
		,case
			when isnull(cd.CUV2,'') = '' or cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)			
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO
/*end*/

USE BelcorpVenezuela
GO
ALTER PROCEDURE interfaces.GetLogCDRWebDetalle
	@LogCDRWebId BIGINT
AS
BEGIN
	INSERT INTO interfaces.LogCDRWebDetalle(
		LogCDRWebId,
		CDRWebDetalleId,
		CodigoOperacionCDR,
		CodigoMotivoCDR,
		CUV,
		Cantidad,
		PedidoId,
		CUV2,
		Cantidad2
	)
	SELECT
		@LogCDRWebId,
		CDRWD.CDRWebDetalleID,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		LCDRW.PedidoId,
		CDRWD.CUV2,
		CDRWD.Cantidad2
	FROM LogCDRWeb LCDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = LCDRW.CDRWebId
	WHERE LCDRW.LogCDRWebId = @LogCDRWebId AND CDRWD.Eliminado = 0;

	SELECT
		cd.LogCDRWebDetalleId,
		cd.CDRWebDetalleID,
		cd.LogCDRWebId,
		cd.PedidoId
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR
		,cd.CodigoMotivoCDR
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR
		,cd.CodigoRechazo
		,cd.ObservacionRechazo
		,pc.Descripcion as NombreProducto
		,isnull(pc2.Descripcion,'') as NombreProducto2
		,case
			when isnull(cd.CUV2,'') = '' or cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)			
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO
/*end*/

USE BelcorpColombia
GO
ALTER PROCEDURE interfaces.GetLogCDRWebDetalle
	@LogCDRWebId BIGINT
AS
BEGIN
	INSERT INTO interfaces.LogCDRWebDetalle(
		LogCDRWebId,
		CDRWebDetalleId,
		CodigoOperacionCDR,
		CodigoMotivoCDR,
		CUV,
		Cantidad,
		PedidoId,
		CUV2,
		Cantidad2
	)
	SELECT
		@LogCDRWebId,
		CDRWD.CDRWebDetalleID,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		LCDRW.PedidoId,
		CDRWD.CUV2,
		CDRWD.Cantidad2
	FROM LogCDRWeb LCDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = LCDRW.CDRWebId
	WHERE LCDRW.LogCDRWebId = @LogCDRWebId AND CDRWD.Eliminado = 0;

	SELECT
		cd.LogCDRWebDetalleId,
		cd.CDRWebDetalleID,
		cd.LogCDRWebId,
		cd.PedidoId
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR
		,cd.CodigoMotivoCDR
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR
		,cd.CodigoRechazo
		,cd.ObservacionRechazo
		,pc.Descripcion as NombreProducto
		,isnull(pc2.Descripcion,'') as NombreProducto2
		,case
			when isnull(cd.CUV2,'') = '' or cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)			
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO
/*end*/

USE BelcorpMexico
GO
ALTER PROCEDURE interfaces.GetLogCDRWebDetalle
	@LogCDRWebId BIGINT
AS
BEGIN
	INSERT INTO interfaces.LogCDRWebDetalle(
		LogCDRWebId,
		CDRWebDetalleId,
		CodigoOperacionCDR,
		CodigoMotivoCDR,
		CUV,
		Cantidad,
		PedidoId,
		CUV2,
		Cantidad2
	)
	SELECT
		@LogCDRWebId,
		CDRWD.CDRWebDetalleID,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		LCDRW.PedidoId,
		CDRWD.CUV2,
		CDRWD.Cantidad2
	FROM LogCDRWeb LCDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = LCDRW.CDRWebId
	WHERE LCDRW.LogCDRWebId = @LogCDRWebId AND CDRWD.Eliminado = 0;

	SELECT
		cd.LogCDRWebDetalleId,
		cd.CDRWebDetalleID,
		cd.LogCDRWebId,
		cd.PedidoId
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR
		,cd.CodigoMotivoCDR
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR
		,cd.CodigoRechazo
		,cd.ObservacionRechazo
		,pc.Descripcion as NombreProducto
		,isnull(pc2.Descripcion,'') as NombreProducto2
		,case
			when isnull(cd.CUV2,'') = '' or cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)			
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO
/*end*/

USE BelcorpPeru
GO
ALTER PROCEDURE interfaces.GetLogCDRWebDetalle
	@LogCDRWebId BIGINT
AS
BEGIN
	INSERT INTO interfaces.LogCDRWebDetalle(
		LogCDRWebId,
		CDRWebDetalleId,
		CodigoOperacionCDR,
		CodigoMotivoCDR,
		CUV,
		Cantidad,
		PedidoId,
		CUV2,
		Cantidad2
	)
	SELECT
		@LogCDRWebId,
		CDRWD.CDRWebDetalleID,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		LCDRW.PedidoId,
		CDRWD.CUV2,
		CDRWD.Cantidad2
	FROM LogCDRWeb LCDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = LCDRW.CDRWebId
	WHERE LCDRW.LogCDRWebId = @LogCDRWebId AND CDRWD.Eliminado = 0;

	SELECT
		cd.LogCDRWebDetalleId,
		cd.CDRWebDetalleID,
		cd.LogCDRWebId,
		cd.PedidoId
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR
		,cd.CodigoMotivoCDR
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR
		,cd.CodigoRechazo
		,cd.ObservacionRechazo
		,pc.Descripcion as NombreProducto
		,isnull(pc2.Descripcion,'') as NombreProducto2
		,case
			when isnull(cd.CUV2,'') = '' or cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)			
		end as Precio
		,case
			when isnull(cd.CUV2,'') = '' then 0
			when cd.CUV = cd.CUV2 then (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			else (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
		end as Precio2
	FROM interfaces.LogCDRWeb c
	INNER JOIN interfaces.LogCDRWebDetalle cd on c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO