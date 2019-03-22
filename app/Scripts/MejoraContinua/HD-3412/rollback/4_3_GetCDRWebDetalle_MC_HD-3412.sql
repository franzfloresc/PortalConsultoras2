USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[GetCDRWebDetalle] (
	@CDRWebID INT
	,@PedidoID INT = 0
	)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	DECLARE @CampaniaId INT = 0;

	SELECT @CampaniaId = CampaniaID
	FROM CDRWeb
	WHERE CDRWebID = @CDRWebID;

	SET @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	IF (@CDRWebID = 0)
	BEGIN
		SELECT TOP 1 @CDRWebID = CDRWebID
			,@CampaniaId = CampaniaID
		FROM CDRWeb
		WHERE PedidoID = @PedidoID
	END

	SELECT cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.CUV
			ELSE cd.CUV2
			END AS CUV2
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.Cantidad
			ELSE cd.Cantidad2
			END AS Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo, 0) AS TipoMotivoRechazo
		--,cd.Observacion
		,ISNULL((
				SELECT TOP 1 RTRIM(Descripcion)
				FROM [dbo].[CDRWebDescripcion]
				WHERE Tipo = 'Motivo'
					AND EntidadSSIC = 'Observacion'
					AND CodigoSSIC = cd.MotivoRechazo
				), cd.Observacion) AS Observacion
		,cd.Eliminado
		,pc.Descripcion AS Descripcion
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN pc.Descripcion
			ELSE pc2.Descripcion
			END AS Descripcion2
		,CASE 
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc ON cd.CUV = pc.CUV
		AND pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 ON cd.CUV2 = pc2.CUV
		AND pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd ON pwd.CUV = cd.CUV
		AND pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr ON cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID
		AND cd.Eliminado = 0
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[GetCDRWebDetalle] (
	@CDRWebID INT
	,@PedidoID INT = 0
	)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	DECLARE @CampaniaId INT = 0;

	SELECT @CampaniaId = CampaniaID
	FROM CDRWeb
	WHERE CDRWebID = @CDRWebID;

	SET @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	IF (@CDRWebID = 0)
	BEGIN
		SELECT TOP 1 @CDRWebID = CDRWebID
			,@CampaniaId = CampaniaID
		FROM CDRWeb
		WHERE PedidoID = @PedidoID
	END

	SELECT cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.CUV
			ELSE cd.CUV2
			END AS CUV2
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.Cantidad
			ELSE cd.Cantidad2
			END AS Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo, 0) AS TipoMotivoRechazo
		--,cd.Observacion
		,ISNULL((
				SELECT TOP 1 RTRIM(Descripcion)
				FROM [dbo].[CDRWebDescripcion]
				WHERE Tipo = 'Motivo'
					AND EntidadSSIC = 'Observacion'
					AND CodigoSSIC = cd.MotivoRechazo
				), cd.Observacion) AS Observacion
		,cd.Eliminado
		,pc.Descripcion AS Descripcion
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN pc.Descripcion
			ELSE pc2.Descripcion
			END AS Descripcion2
		,CASE 
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc ON cd.CUV = pc.CUV
		AND pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 ON cd.CUV2 = pc2.CUV
		AND pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd ON pwd.CUV = cd.CUV
		AND pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr ON cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID
		AND cd.Eliminado = 0
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[GetCDRWebDetalle] (
	@CDRWebID INT
	,@PedidoID INT = 0
	)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	DECLARE @CampaniaId INT = 0;

	SELECT @CampaniaId = CampaniaID
	FROM CDRWeb
	WHERE CDRWebID = @CDRWebID;

	SET @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	IF (@CDRWebID = 0)
	BEGIN
		SELECT TOP 1 @CDRWebID = CDRWebID
			,@CampaniaId = CampaniaID
		FROM CDRWeb
		WHERE PedidoID = @PedidoID
	END

	SELECT cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.CUV
			ELSE cd.CUV2
			END AS CUV2
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.Cantidad
			ELSE cd.Cantidad2
			END AS Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo, 0) AS TipoMotivoRechazo
		--,cd.Observacion
		,ISNULL((
				SELECT TOP 1 RTRIM(Descripcion)
				FROM [dbo].[CDRWebDescripcion]
				WHERE Tipo = 'Motivo'
					AND EntidadSSIC = 'Observacion'
					AND CodigoSSIC = cd.MotivoRechazo
				), cd.Observacion) AS Observacion
		,cd.Eliminado
		,pc.Descripcion AS Descripcion
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN pc.Descripcion
			ELSE pc2.Descripcion
			END AS Descripcion2
		,CASE 
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc ON cd.CUV = pc.CUV
		AND pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 ON cd.CUV2 = pc2.CUV
		AND pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd ON pwd.CUV = cd.CUV
		AND pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr ON cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID
		AND cd.Eliminado = 0
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[GetCDRWebDetalle] (
	@CDRWebID INT
	,@PedidoID INT = 0
	)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	DECLARE @CampaniaId INT = 0;

	SELECT @CampaniaId = CampaniaID
	FROM CDRWeb
	WHERE CDRWebID = @CDRWebID;

	SET @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	IF (@CDRWebID = 0)
	BEGIN
		SELECT TOP 1 @CDRWebID = CDRWebID
			,@CampaniaId = CampaniaID
		FROM CDRWeb
		WHERE PedidoID = @PedidoID
	END

	SELECT cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.CUV
			ELSE cd.CUV2
			END AS CUV2
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.Cantidad
			ELSE cd.Cantidad2
			END AS Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo, 0) AS TipoMotivoRechazo
		--,cd.Observacion
		,ISNULL((
				SELECT TOP 1 RTRIM(Descripcion)
				FROM [dbo].[CDRWebDescripcion]
				WHERE Tipo = 'Motivo'
					AND EntidadSSIC = 'Observacion'
					AND CodigoSSIC = cd.MotivoRechazo
				), cd.Observacion) AS Observacion
		,cd.Eliminado
		,pc.Descripcion AS Descripcion
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN pc.Descripcion
			ELSE pc2.Descripcion
			END AS Descripcion2
		,CASE 
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc ON cd.CUV = pc.CUV
		AND pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 ON cd.CUV2 = pc2.CUV
		AND pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd ON pwd.CUV = cd.CUV
		AND pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr ON cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID
		AND cd.Eliminado = 0
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[GetCDRWebDetalle] (
	@CDRWebID INT
	,@PedidoID INT = 0
	)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	DECLARE @CampaniaId INT = 0;

	SELECT @CampaniaId = CampaniaID
	FROM CDRWeb
	WHERE CDRWebID = @CDRWebID;

	SET @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	IF (@CDRWebID = 0)
	BEGIN
		SELECT TOP 1 @CDRWebID = CDRWebID
			,@CampaniaId = CampaniaID
		FROM CDRWeb
		WHERE PedidoID = @PedidoID
	END

	SELECT cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.CUV
			ELSE cd.CUV2
			END AS CUV2
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.Cantidad
			ELSE cd.Cantidad2
			END AS Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo, 0) AS TipoMotivoRechazo
		--,cd.Observacion
		,ISNULL((
				SELECT TOP 1 RTRIM(Descripcion)
				FROM [dbo].[CDRWebDescripcion]
				WHERE Tipo = 'Motivo'
					AND EntidadSSIC = 'Observacion'
					AND CodigoSSIC = cd.MotivoRechazo
				), cd.Observacion) AS Observacion
		,cd.Eliminado
		,pc.Descripcion AS Descripcion
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN pc.Descripcion
			ELSE pc2.Descripcion
			END AS Descripcion2
		,CASE 
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc ON cd.CUV = pc.CUV
		AND pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 ON cd.CUV2 = pc2.CUV
		AND pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd ON pwd.CUV = cd.CUV
		AND pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr ON cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID
		AND cd.Eliminado = 0
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[GetCDRWebDetalle] (
	@CDRWebID INT
	,@PedidoID INT = 0
	)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	DECLARE @CampaniaId INT = 0;

	SELECT @CampaniaId = CampaniaID
	FROM CDRWeb
	WHERE CDRWebID = @CDRWebID;

	SET @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	IF (@CDRWebID = 0)
	BEGIN
		SELECT TOP 1 @CDRWebID = CDRWebID
			,@CampaniaId = CampaniaID
		FROM CDRWeb
		WHERE PedidoID = @PedidoID
	END

	SELECT cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.CUV
			ELSE cd.CUV2
			END AS CUV2
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.Cantidad
			ELSE cd.Cantidad2
			END AS Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo, 0) AS TipoMotivoRechazo
		--,cd.Observacion
		,ISNULL((
				SELECT TOP 1 RTRIM(Descripcion)
				FROM [dbo].[CDRWebDescripcion]
				WHERE Tipo = 'Motivo'
					AND EntidadSSIC = 'Observacion'
					AND CodigoSSIC = cd.MotivoRechazo
				), cd.Observacion) AS Observacion
		,cd.Eliminado
		,pc.Descripcion AS Descripcion
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN pc.Descripcion
			ELSE pc2.Descripcion
			END AS Descripcion2
		,CASE 
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc ON cd.CUV = pc.CUV
		AND pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 ON cd.CUV2 = pc2.CUV
		AND pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd ON pwd.CUV = cd.CUV
		AND pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr ON cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID
		AND cd.Eliminado = 0
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetCDRWebDetalle] (
	@CDRWebID INT
	,@PedidoID INT = 0
	)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	DECLARE @CampaniaId INT = 0;

	SELECT @CampaniaId = CampaniaID
	FROM CDRWeb
	WHERE CDRWebID = @CDRWebID;

	SET @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	IF (@CDRWebID = 0)
	BEGIN
		SELECT TOP 1 @CDRWebID = CDRWebID
			,@CampaniaId = CampaniaID
		FROM CDRWeb
		WHERE PedidoID = @PedidoID
	END

	SELECT cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.CUV
			ELSE cd.CUV2
			END AS CUV2
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.Cantidad
			ELSE cd.Cantidad2
			END AS Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo, 0) AS TipoMotivoRechazo
		--,cd.Observacion
		,ISNULL((
				SELECT TOP 1 RTRIM(Descripcion)
				FROM [dbo].[CDRWebDescripcion]
				WHERE Tipo = 'Motivo'
					AND EntidadSSIC = 'Observacion'
					AND CodigoSSIC = cd.MotivoRechazo
				), cd.Observacion) AS Observacion
		,cd.Eliminado
		,pc.Descripcion AS Descripcion
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN pc.Descripcion
			ELSE pc2.Descripcion
			END AS Descripcion2
		,CASE 
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc ON cd.CUV = pc.CUV
		AND pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 ON cd.CUV2 = pc2.CUV
		AND pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd ON pwd.CUV = cd.CUV
		AND pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr ON cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID
		AND cd.Eliminado = 0
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[GetCDRWebDetalle] (
	@CDRWebID INT
	,@PedidoID INT = 0
	)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	DECLARE @CampaniaId INT = 0;

	SELECT @CampaniaId = CampaniaID
	FROM CDRWeb
	WHERE CDRWebID = @CDRWebID;

	SET @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	IF (@CDRWebID = 0)
	BEGIN
		SELECT TOP 1 @CDRWebID = CDRWebID
			,@CampaniaId = CampaniaID
		FROM CDRWeb
		WHERE PedidoID = @PedidoID
	END

	SELECT cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.CUV
			ELSE cd.CUV2
			END AS CUV2
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.Cantidad
			ELSE cd.Cantidad2
			END AS Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo, 0) AS TipoMotivoRechazo
		--,cd.Observacion
		,ISNULL((
				SELECT TOP 1 RTRIM(Descripcion)
				FROM [dbo].[CDRWebDescripcion]
				WHERE Tipo = 'Motivo'
					AND EntidadSSIC = 'Observacion'
					AND CodigoSSIC = cd.MotivoRechazo
				), cd.Observacion) AS Observacion
		,cd.Eliminado
		,pc.Descripcion AS Descripcion
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN pc.Descripcion
			ELSE pc2.Descripcion
			END AS Descripcion2
		,CASE 
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc ON cd.CUV = pc.CUV
		AND pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 ON cd.CUV2 = pc2.CUV
		AND pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd ON pwd.CUV = cd.CUV
		AND pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr ON cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID
		AND cd.Eliminado = 0
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[GetCDRWebDetalle] (
	@CDRWebID INT
	,@PedidoID INT = 0
	)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	DECLARE @CampaniaId INT = 0;

	SELECT @CampaniaId = CampaniaID
	FROM CDRWeb
	WHERE CDRWebID = @CDRWebID;

	SET @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	IF (@CDRWebID = 0)
	BEGIN
		SELECT TOP 1 @CDRWebID = CDRWebID
			,@CampaniaId = CampaniaID
		FROM CDRWeb
		WHERE PedidoID = @PedidoID
	END

	SELECT cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.CUV
			ELSE cd.CUV2
			END AS CUV2
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.Cantidad
			ELSE cd.Cantidad2
			END AS Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo, 0) AS TipoMotivoRechazo
		--,cd.Observacion
		,ISNULL((
				SELECT TOP 1 RTRIM(Descripcion)
				FROM [dbo].[CDRWebDescripcion]
				WHERE Tipo = 'Motivo'
					AND EntidadSSIC = 'Observacion'
					AND CodigoSSIC = cd.MotivoRechazo
				), cd.Observacion) AS Observacion
		,cd.Eliminado
		,pc.Descripcion AS Descripcion
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN pc.Descripcion
			ELSE pc2.Descripcion
			END AS Descripcion2
		,CASE 
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc ON cd.CUV = pc.CUV
		AND pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 ON cd.CUV2 = pc2.CUV
		AND pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd ON pwd.CUV = cd.CUV
		AND pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr ON cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID
		AND cd.Eliminado = 0
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[GetCDRWebDetalle] (
	@CDRWebID INT
	,@PedidoID INT = 0
	)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	DECLARE @CampaniaId INT = 0;

	SELECT @CampaniaId = CampaniaID
	FROM CDRWeb
	WHERE CDRWebID = @CDRWebID;

	SET @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	IF (@CDRWebID = 0)
	BEGIN
		SELECT TOP 1 @CDRWebID = CDRWebID
			,@CampaniaId = CampaniaID
		FROM CDRWeb
		WHERE PedidoID = @PedidoID
	END

	SELECT cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.CUV
			ELSE cd.CUV2
			END AS CUV2
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.Cantidad
			ELSE cd.Cantidad2
			END AS Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo, 0) AS TipoMotivoRechazo
		--,cd.Observacion
		,ISNULL((
				SELECT TOP 1 RTRIM(Descripcion)
				FROM [dbo].[CDRWebDescripcion]
				WHERE Tipo = 'Motivo'
					AND EntidadSSIC = 'Observacion'
					AND CodigoSSIC = cd.MotivoRechazo
				), cd.Observacion) AS Observacion
		,cd.Eliminado
		,pc.Descripcion AS Descripcion
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN pc.Descripcion
			ELSE pc2.Descripcion
			END AS Descripcion2
		,CASE 
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc ON cd.CUV = pc.CUV
		AND pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 ON cd.CUV2 = pc2.CUV
		AND pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd ON pwd.CUV = cd.CUV
		AND pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr ON cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID
		AND cd.Eliminado = 0
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[GetCDRWebDetalle] (
	@CDRWebID INT
	,@PedidoID INT = 0
	)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	DECLARE @CampaniaId INT = 0;

	SELECT @CampaniaId = CampaniaID
	FROM CDRWeb
	WHERE CDRWebID = @CDRWebID;

	SET @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	IF (@CDRWebID = 0)
	BEGIN
		SELECT TOP 1 @CDRWebID = CDRWebID
			,@CampaniaId = CampaniaID
		FROM CDRWeb
		WHERE PedidoID = @PedidoID
	END

	SELECT cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.CUV
			ELSE cd.CUV2
			END AS CUV2
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.Cantidad
			ELSE cd.Cantidad2
			END AS Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo, 0) AS TipoMotivoRechazo
		--,cd.Observacion
		,ISNULL((
				SELECT TOP 1 RTRIM(Descripcion)
				FROM [dbo].[CDRWebDescripcion]
				WHERE Tipo = 'Motivo'
					AND EntidadSSIC = 'Observacion'
					AND CodigoSSIC = cd.MotivoRechazo
				), cd.Observacion) AS Observacion
		,cd.Eliminado
		,pc.Descripcion AS Descripcion
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN pc.Descripcion
			ELSE pc2.Descripcion
			END AS Descripcion2
		,CASE 
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc ON cd.CUV = pc.CUV
		AND pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 ON cd.CUV2 = pc2.CUV
		AND pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd ON pwd.CUV = cd.CUV
		AND pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr ON cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID
		AND cd.Eliminado = 0
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[GetCDRWebDetalle] (
	@CDRWebID INT
	,@PedidoID INT = 0
	)
AS
/*
GetCDRWebDetalle 1,708100948
GetCDRWebDetalle 0,708100948
*/
BEGIN
	DECLARE @CampaniaId INT = 0;

	SELECT @CampaniaId = CampaniaID
	FROM CDRWeb
	WHERE CDRWebID = @CDRWebID;

	SET @CDRWebID = isnull(@CDRWebID, 0);

	--Obtener el CDRWebID
	IF (@CDRWebID = 0)
	BEGIN
		SELECT TOP 1 @CDRWebID = CDRWebID
			,@CampaniaId = CampaniaID
		FROM CDRWeb
		WHERE PedidoID = @PedidoID
	END

	SELECT cd.CDRWebDetalleID
		,cd.CDRWebID
		,cd.CodigoOperacion
		,cd.CodigoReclamo
		,cd.CUV
		,cd.Cantidad
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.CUV
			ELSE cd.CUV2
			END AS CUV2
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN cd.Cantidad
			ELSE cd.Cantidad2
			END AS Cantidad2
		,cd.FechaRegistro
		,cd.Estado
		,cd.MotivoRechazo
		,isnull(cmr.Tipo, 0) AS TipoMotivoRechazo
		--,cd.Observacion
		,ISNULL((
				SELECT TOP 1 RTRIM(Descripcion)
				FROM [dbo].[CDRWebDescripcion]
				WHERE Tipo = 'Motivo'
					AND EntidadSSIC = 'Observacion'
					AND CodigoSSIC = cd.MotivoRechazo
				), cd.Observacion) AS Observacion
		,cd.Eliminado
		,pc.Descripcion AS Descripcion
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN pc.Descripcion
			ELSE pc2.Descripcion
			END AS Descripcion2
		,CASE 
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio
		,CASE 
			WHEN isnull(cd.CUV2, '') = ''
				THEN (pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad)
			WHEN cd.CodigoOperacion = LTRIM(RTRIM('T'))
				THEN (pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2)
			ELSE (pwd.MontoPagar * cd.Cantidad / pwd.Cantidad)
			END AS Precio2
	FROM CDRWebDetalle cd
	INNER JOIN ods.ProductoComercial pc ON cd.CUV = pc.CUV
		AND pc.AnoCampania = @CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 ON cd.CUV2 = pc2.CUV
		AND pc2.AnoCampania = @CampaniaId
	INNER JOIN ods.PedidoDetalle pwd ON pwd.CUV = cd.CUV
		AND pwd.PedidoID = @PedidoID
	LEFT JOIN CDRWebMotivoRechazo cmr ON cd.MotivoRechazo = cmr.CodigoRechazo
	WHERE cd.CDRWebID = @CDRWebID
		AND cd.Eliminado = 0
END
GO


