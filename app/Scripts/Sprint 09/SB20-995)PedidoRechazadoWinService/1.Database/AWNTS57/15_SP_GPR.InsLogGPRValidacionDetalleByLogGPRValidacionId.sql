USE BelcorpBolivia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'InsLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacionDetalle(
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta,
		ConfiguracionOfertaID
	)
	SELECT
		@LogGPRValidacionId,
		PWD.PedidoDetalleID,
		PWD.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion),
		PWD.Cantidad,
		PWD.PrecioUnidad,
		PWD.ImporteTotal,
		ISNULL(PC.IndicadorOferta,0),
		PWD.ConfiguracionOfertaID
	FROM GPR.LogGPRValidacion LGRPV WITH(NOLOCK)
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = PR.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'InsLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacionDetalle(
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta,
		ConfiguracionOfertaID
	)
	SELECT
		@LogGPRValidacionId,
		PWD.PedidoDetalleID,
		PWD.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion),
		PWD.Cantidad,
		PWD.PrecioUnidad,
		PWD.ImporteTotal,
		ISNULL(PC.IndicadorOferta,0),
		PWD.ConfiguracionOfertaID
	FROM GPR.LogGPRValidacion LGRPV WITH(NOLOCK)
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = PR.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'InsLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacionDetalle(
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta,
		ConfiguracionOfertaID
	)
	SELECT
		@LogGPRValidacionId,
		PWD.PedidoDetalleID,
		PWD.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion),
		PWD.Cantidad,
		PWD.PrecioUnidad,
		PWD.ImporteTotal,
		ISNULL(PC.IndicadorOferta,0),
		PWD.ConfiguracionOfertaID
	FROM GPR.LogGPRValidacion LGRPV WITH(NOLOCK)
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = PR.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpDominicana
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'InsLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacionDetalle(
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta,
		ConfiguracionOfertaID
	)
	SELECT
		@LogGPRValidacionId,
		PWD.PedidoDetalleID,
		PWD.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion),
		PWD.Cantidad,
		PWD.PrecioUnidad,
		PWD.ImporteTotal,
		ISNULL(PC.IndicadorOferta,0),
		PWD.ConfiguracionOfertaID
	FROM GPR.LogGPRValidacion LGRPV WITH(NOLOCK)
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = PR.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpEcuador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'InsLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacionDetalle(
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta,
		ConfiguracionOfertaID
	)
	SELECT
		@LogGPRValidacionId,
		PWD.PedidoDetalleID,
		PWD.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion),
		PWD.Cantidad,
		PWD.PrecioUnidad,
		PWD.ImporteTotal,
		ISNULL(PC.IndicadorOferta,0),
		PWD.ConfiguracionOfertaID
	FROM GPR.LogGPRValidacion LGRPV WITH(NOLOCK)
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = PR.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'InsLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacionDetalle(
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta,
		ConfiguracionOfertaID
	)
	SELECT
		@LogGPRValidacionId,
		PWD.PedidoDetalleID,
		PWD.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion),
		PWD.Cantidad,
		PWD.PrecioUnidad,
		PWD.ImporteTotal,
		ISNULL(PC.IndicadorOferta,0),
		PWD.ConfiguracionOfertaID
	FROM GPR.LogGPRValidacion LGRPV WITH(NOLOCK)
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = PR.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpPanama
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'InsLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacionDetalle(
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta,
		ConfiguracionOfertaID
	)
	SELECT
		@LogGPRValidacionId,
		PWD.PedidoDetalleID,
		PWD.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion),
		PWD.Cantidad,
		PWD.PrecioUnidad,
		PWD.ImporteTotal,
		ISNULL(PC.IndicadorOferta,0),
		PWD.ConfiguracionOfertaID
	FROM GPR.LogGPRValidacion LGRPV WITH(NOLOCK)
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = PR.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'InsLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacionDetalle(
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta,
		ConfiguracionOfertaID
	)
	SELECT
		@LogGPRValidacionId,
		PWD.PedidoDetalleID,
		PWD.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion),
		PWD.Cantidad,
		PWD.PrecioUnidad,
		PWD.ImporteTotal,
		ISNULL(PC.IndicadorOferta,0),
		PWD.ConfiguracionOfertaID
	FROM GPR.LogGPRValidacion LGRPV WITH(NOLOCK)
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = PR.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpSalvador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'InsLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacionDetalle(
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta,
		ConfiguracionOfertaID
	)
	SELECT
		@LogGPRValidacionId,
		PWD.PedidoDetalleID,
		PWD.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion),
		PWD.Cantidad,
		PWD.PrecioUnidad,
		PWD.ImporteTotal,
		ISNULL(PC.IndicadorOferta,0),
		PWD.ConfiguracionOfertaID
	FROM GPR.LogGPRValidacion LGRPV WITH(NOLOCK)
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = PR.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpVenezuela
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'InsLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacionDetalle(
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta,
		ConfiguracionOfertaID
	)
	SELECT
		@LogGPRValidacionId,
		PWD.PedidoDetalleID,
		PWD.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion),
		PWD.Cantidad,
		PWD.PrecioUnidad,
		PWD.ImporteTotal,
		ISNULL(PC.IndicadorOferta,0),
		PWD.ConfiguracionOfertaID
	FROM GPR.LogGPRValidacion LGRPV WITH(NOLOCK)
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = PR.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END
GO