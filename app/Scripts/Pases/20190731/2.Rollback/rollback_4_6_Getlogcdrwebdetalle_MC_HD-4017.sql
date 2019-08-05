USE BELCORPBOLIVIA
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[GetLogCDRWebDetalle]
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
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO


USE BelcorpChile
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[GetLogCDRWebDetalle]
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
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO

USE BelcorpColombia
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[GetLogCDRWebDetalle]
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
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO


USE BelcorpCostaRica
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[GetLogCDRWebDetalle]
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
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO


USE BelcorpDominicana
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[GetLogCDRWebDetalle]
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
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO 


USE BelcorpEcuador 
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[GetLogCDRWebDetalle]
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
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO


USE BelcorpGuatemala
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[GetLogCDRWebDetalle]
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
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO


USE BelcorpMexico
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[GetLogCDRWebDetalle]
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
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO


USE BelcorpPanama 
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[GetLogCDRWebDetalle]
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
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO


USE BelcorpPeru 
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[GetLogCDRWebDetalle]
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
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO


USE BelcorpPuertoRico
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[GetLogCDRWebDetalle]
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
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO


USE BelcorpSalvador
GO 

/* 
MODIFICADO POR : PAQUIRRI SEPERAK 
FECHA : 20191505 
DESCRIPCIÓN : SE AGREGÓ UN CAMPO MÁS LLAMADO DETALLEREEMPLAZOPARA PODER CARGAR LOS DETALLES DE PRODUCTOS PARA USO DEL TRUEQUE
REQUERIMIENTO  HD-4017 
*/ 
ALTER PROCEDURE [interfaces].[GetLogCDRWebDetalle]
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
	INNER JOIN ods.ProductoComercial pc on cd.CUV = pc.CUV and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on cd.CUV2 = pc2.CUV and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on	pwd.CUV = cd.CUV and pwd.PedidoId = cd.PedidoId
	WHERE c.LogCDRWebID = @LogCDRWebID;
END
GO