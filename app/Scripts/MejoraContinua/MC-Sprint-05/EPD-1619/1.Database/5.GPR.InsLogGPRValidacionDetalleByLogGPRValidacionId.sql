USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]
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
	--INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = LGRPV.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]
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
	--INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = LGRPV.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]
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
	--INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = LGRPV.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]
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
	--INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = LGRPV.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]
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
	--INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = LGRPV.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]
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
	--INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = LGRPV.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]
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
	--INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = LGRPV.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]
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
	--INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = LGRPV.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]
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
	--INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = LGRPV.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]
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
	--INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = LGRPV.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]
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
	--INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = LGRPV.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]
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
	--INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = LGRPV.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[InsLogGPRValidacionDetalleByLogGPRValidacionId]
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
	--INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = LGRPV.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END

GO

