USE BelcorpPeru
GO

ALTER PROCEDURE GetPedidoWebCorreoPROL
	@ValAutomaticaPROLLogId BIGINT,
	@TipoOrigen INT = null
AS
BEGIN
	DECLARE @MontoTotalProl MONEY;
	DECLARE @DescuentoProl MONEY;

	SET @TipoOrigen = ISNULL(@TipoOrigen,1);
	IF (@TipoOrigen=1)
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),
			@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionAutomaticaPROLLog
		WHERE ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId;
	END
	ELSE
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionMovilPROLLog
		WHERE ValidacionMovilPROLLogId = @ValAutomaticaPROLLogId;
	END

	SELECT
		pwd.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.ObservacionPROL,
		ISNULL(pc.IndicadorOferta,0) AS IndicadorOferta,
		--ISNULL(pw.ImporteTotal,0) as ImporteTotalPedido,
		0 AS ImporteTotalPedido,
		@MontoTotalProl AS MontoTotalProl,
		@DescuentoProl AS DescuentoProl,
		cl.Nombre as NombreCliente
	FROM PedidoWebCorreoPROL pwd with(nolock)
	inner join dbo.PedidoWebDetalle pw with(nolock) on
		pwd.PedidoID = pw.PedidoID and pwd.CampaniaID = pw.CampaniaID and pwd.PedidoDetalleID = pw.PedidoDetalleID
		left join dbo.Cliente cl on cl.ConsultoraID = pw.ConsultoraID and pw.ClienteID = cl.ClienteID
	INNER JOIN ods.ProductoComercial pc with(nolock) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd with(nolock) ON
	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP with(nolock) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC with(nolock) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE pwd.ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId and TipoOrigen = @TipoOrigen
	ORDER BY pwd.PedidoDetalleID;
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE GetPedidoWebCorreoPROL
	@ValAutomaticaPROLLogId BIGINT,
	@TipoOrigen INT = null
AS
BEGIN
	DECLARE @MontoTotalProl MONEY;
	DECLARE @DescuentoProl MONEY;

	SET @TipoOrigen = ISNULL(@TipoOrigen,1);
	IF (@TipoOrigen=1)
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),
			@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionAutomaticaPROLLog
		WHERE ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId;
	END
	ELSE
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionMovilPROLLog
		WHERE ValidacionMovilPROLLogId = @ValAutomaticaPROLLogId;
	END

	SELECT
		pwd.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.ObservacionPROL,
		ISNULL(pc.IndicadorOferta,0) AS IndicadorOferta,
		--ISNULL(pw.ImporteTotal,0) as ImporteTotalPedido,
		0 AS ImporteTotalPedido,
		@MontoTotalProl AS MontoTotalProl,
		@DescuentoProl AS DescuentoProl,
		cl.Nombre as NombreCliente
	FROM PedidoWebCorreoPROL pwd with(nolock)
	inner join dbo.PedidoWebDetalle pw with(nolock) on
		pwd.PedidoID = pw.PedidoID and pwd.CampaniaID = pw.CampaniaID and pwd.PedidoDetalleID = pw.PedidoDetalleID
		left join dbo.Cliente cl on cl.ConsultoraID = pw.ConsultoraID and pw.ClienteID = cl.ClienteID
	INNER JOIN ods.ProductoComercial pc with(nolock) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd with(nolock) ON
	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP with(nolock) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC with(nolock) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE pwd.ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId and TipoOrigen = @TipoOrigen
	ORDER BY pwd.PedidoDetalleID;
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE GetPedidoWebCorreoPROL
	@ValAutomaticaPROLLogId BIGINT,
	@TipoOrigen INT = null
AS
BEGIN
	DECLARE @MontoTotalProl MONEY;
	DECLARE @DescuentoProl MONEY;

	SET @TipoOrigen = ISNULL(@TipoOrigen,1);
	IF (@TipoOrigen=1)
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),
			@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionAutomaticaPROLLog
		WHERE ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId;
	END
	ELSE
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionMovilPROLLog
		WHERE ValidacionMovilPROLLogId = @ValAutomaticaPROLLogId;
	END

	SELECT
		pwd.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.ObservacionPROL,
		ISNULL(pc.IndicadorOferta,0) AS IndicadorOferta,
		--ISNULL(pw.ImporteTotal,0) as ImporteTotalPedido,
		0 AS ImporteTotalPedido,
		@MontoTotalProl AS MontoTotalProl,
		@DescuentoProl AS DescuentoProl,
		cl.Nombre as NombreCliente
	FROM PedidoWebCorreoPROL pwd with(nolock)
	inner join dbo.PedidoWebDetalle pw with(nolock) on
		pwd.PedidoID = pw.PedidoID and pwd.CampaniaID = pw.CampaniaID and pwd.PedidoDetalleID = pw.PedidoDetalleID
		left join dbo.Cliente cl on cl.ConsultoraID = pw.ConsultoraID and pw.ClienteID = cl.ClienteID
	INNER JOIN ods.ProductoComercial pc with(nolock) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd with(nolock) ON
	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP with(nolock) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC with(nolock) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE pwd.ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId and TipoOrigen = @TipoOrigen
	ORDER BY pwd.PedidoDetalleID;
END
GO

USE BelcorpVenezuela
GO

ALTER PROCEDURE GetPedidoWebCorreoPROL
	@ValAutomaticaPROLLogId BIGINT,
	@TipoOrigen INT = null
AS
BEGIN
	DECLARE @MontoTotalProl MONEY;
	DECLARE @DescuentoProl MONEY;

	SET @TipoOrigen = ISNULL(@TipoOrigen,1);
	IF (@TipoOrigen=1)
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),
			@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionAutomaticaPROLLog
		WHERE ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId;
	END
	ELSE
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionMovilPROLLog
		WHERE ValidacionMovilPROLLogId = @ValAutomaticaPROLLogId;
	END

	SELECT
		pwd.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.ObservacionPROL,
		ISNULL(pc.IndicadorOferta,0) AS IndicadorOferta,
		--ISNULL(pw.ImporteTotal,0) as ImporteTotalPedido,
		0 AS ImporteTotalPedido,
		@MontoTotalProl AS MontoTotalProl,
		@DescuentoProl AS DescuentoProl,
		cl.Nombre as NombreCliente
	FROM PedidoWebCorreoPROL pwd with(nolock)
	inner join dbo.PedidoWebDetalle pw with(nolock) on
		pwd.PedidoID = pw.PedidoID and pwd.CampaniaID = pw.CampaniaID and pwd.PedidoDetalleID = pw.PedidoDetalleID
		left join dbo.Cliente cl on cl.ConsultoraID = pw.ConsultoraID and pw.ClienteID = cl.ClienteID
	INNER JOIN ods.ProductoComercial pc with(nolock) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd with(nolock) ON
	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP with(nolock) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC with(nolock) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE pwd.ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId and TipoOrigen = @TipoOrigen
	ORDER BY pwd.PedidoDetalleID;
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE GetPedidoWebCorreoPROL
	@ValAutomaticaPROLLogId BIGINT,
	@TipoOrigen INT = null
AS
BEGIN
	DECLARE @MontoTotalProl MONEY;
	DECLARE @DescuentoProl MONEY;

	SET @TipoOrigen = ISNULL(@TipoOrigen,1);
	IF (@TipoOrigen=1)
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),
			@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionAutomaticaPROLLog
		WHERE ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId;
	END
	ELSE
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionMovilPROLLog
		WHERE ValidacionMovilPROLLogId = @ValAutomaticaPROLLogId;
	END

	SELECT
		pwd.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.ObservacionPROL,
		ISNULL(pc.IndicadorOferta,0) AS IndicadorOferta,
		--ISNULL(pw.ImporteTotal,0) as ImporteTotalPedido,
		0 AS ImporteTotalPedido,
		@MontoTotalProl AS MontoTotalProl,
		@DescuentoProl AS DescuentoProl,
		cl.Nombre as NombreCliente
	FROM PedidoWebCorreoPROL pwd with(nolock)
	inner join dbo.PedidoWebDetalle pw with(nolock) on
		pwd.PedidoID = pw.PedidoID and pwd.CampaniaID = pw.CampaniaID and pwd.PedidoDetalleID = pw.PedidoDetalleID
		left join dbo.Cliente cl on cl.ConsultoraID = pw.ConsultoraID and pw.ClienteID = cl.ClienteID
	INNER JOIN ods.ProductoComercial pc with(nolock) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd with(nolock) ON
	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP with(nolock) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC with(nolock) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE pwd.ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId and TipoOrigen = @TipoOrigen
	ORDER BY pwd.PedidoDetalleID;
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE GetPedidoWebCorreoPROL
	@ValAutomaticaPROLLogId BIGINT,
	@TipoOrigen INT = null
AS
BEGIN
	DECLARE @MontoTotalProl MONEY;
	DECLARE @DescuentoProl MONEY;

	SET @TipoOrigen = ISNULL(@TipoOrigen,1);
	IF (@TipoOrigen=1)
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),
			@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionAutomaticaPROLLog
		WHERE ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId;
	END
	ELSE
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionMovilPROLLog
		WHERE ValidacionMovilPROLLogId = @ValAutomaticaPROLLogId;
	END

	SELECT
		pwd.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.ObservacionPROL,
		ISNULL(pc.IndicadorOferta,0) AS IndicadorOferta,
		--ISNULL(pw.ImporteTotal,0) as ImporteTotalPedido,
		0 AS ImporteTotalPedido,
		@MontoTotalProl AS MontoTotalProl,
		@DescuentoProl AS DescuentoProl,
		cl.Nombre as NombreCliente
	FROM PedidoWebCorreoPROL pwd with(nolock)
	inner join dbo.PedidoWebDetalle pw with(nolock) on
		pwd.PedidoID = pw.PedidoID and pwd.CampaniaID = pw.CampaniaID and pwd.PedidoDetalleID = pw.PedidoDetalleID
		left join dbo.Cliente cl on cl.ConsultoraID = pw.ConsultoraID and pw.ClienteID = cl.ClienteID
	INNER JOIN ods.ProductoComercial pc with(nolock) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd with(nolock) ON
	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP with(nolock) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC with(nolock) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE pwd.ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId and TipoOrigen = @TipoOrigen
	ORDER BY pwd.PedidoDetalleID;
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE GetPedidoWebCorreoPROL
	@ValAutomaticaPROLLogId BIGINT,
	@TipoOrigen INT = null
AS
BEGIN
	DECLARE @MontoTotalProl MONEY;
	DECLARE @DescuentoProl MONEY;

	SET @TipoOrigen = ISNULL(@TipoOrigen,1);
	IF (@TipoOrigen=1)
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),
			@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionAutomaticaPROLLog
		WHERE ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId;
	END
	ELSE
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionMovilPROLLog
		WHERE ValidacionMovilPROLLogId = @ValAutomaticaPROLLogId;
	END

	SELECT
		pwd.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.ObservacionPROL,
		ISNULL(pc.IndicadorOferta,0) AS IndicadorOferta,
		--ISNULL(pw.ImporteTotal,0) as ImporteTotalPedido,
		0 AS ImporteTotalPedido,
		@MontoTotalProl AS MontoTotalProl,
		@DescuentoProl AS DescuentoProl,
		cl.Nombre as NombreCliente
	FROM PedidoWebCorreoPROL pwd with(nolock)
	inner join dbo.PedidoWebDetalle pw with(nolock) on
		pwd.PedidoID = pw.PedidoID and pwd.CampaniaID = pw.CampaniaID and pwd.PedidoDetalleID = pw.PedidoDetalleID
		left join dbo.Cliente cl on cl.ConsultoraID = pw.ConsultoraID and pw.ClienteID = cl.ClienteID
	INNER JOIN ods.ProductoComercial pc with(nolock) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd with(nolock) ON
	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP with(nolock) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC with(nolock) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE pwd.ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId and TipoOrigen = @TipoOrigen
	ORDER BY pwd.PedidoDetalleID;
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE GetPedidoWebCorreoPROL
	@ValAutomaticaPROLLogId BIGINT,
	@TipoOrigen INT = null
AS
BEGIN
	DECLARE @MontoTotalProl MONEY;
	DECLARE @DescuentoProl MONEY;

	SET @TipoOrigen = ISNULL(@TipoOrigen,1);
	IF (@TipoOrigen=1)
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),
			@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionAutomaticaPROLLog
		WHERE ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId;
	END
	ELSE
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionMovilPROLLog
		WHERE ValidacionMovilPROLLogId = @ValAutomaticaPROLLogId;
	END

	SELECT
		pwd.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.ObservacionPROL,
		ISNULL(pc.IndicadorOferta,0) AS IndicadorOferta,
		--ISNULL(pw.ImporteTotal,0) as ImporteTotalPedido,
		0 AS ImporteTotalPedido,
		@MontoTotalProl AS MontoTotalProl,
		@DescuentoProl AS DescuentoProl,
		cl.Nombre as NombreCliente
	FROM PedidoWebCorreoPROL pwd with(nolock)
	inner join dbo.PedidoWebDetalle pw with(nolock) on
		pwd.PedidoID = pw.PedidoID and pwd.CampaniaID = pw.CampaniaID and pwd.PedidoDetalleID = pw.PedidoDetalleID
		left join dbo.Cliente cl on cl.ConsultoraID = pw.ConsultoraID and pw.ClienteID = cl.ClienteID
	INNER JOIN ods.ProductoComercial pc with(nolock) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd with(nolock) ON
	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP with(nolock) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC with(nolock) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE pwd.ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId and TipoOrigen = @TipoOrigen
	ORDER BY pwd.PedidoDetalleID;
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE GetPedidoWebCorreoPROL
	@ValAutomaticaPROLLogId BIGINT,
	@TipoOrigen INT = null
AS
BEGIN
	DECLARE @MontoTotalProl MONEY;
	DECLARE @DescuentoProl MONEY;

	SET @TipoOrigen = ISNULL(@TipoOrigen,1);
	IF (@TipoOrigen=1)
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),
			@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionAutomaticaPROLLog
		WHERE ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId;
	END
	ELSE
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionMovilPROLLog
		WHERE ValidacionMovilPROLLogId = @ValAutomaticaPROLLogId;
	END

	SELECT
		pwd.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.ObservacionPROL,
		ISNULL(pc.IndicadorOferta,0) AS IndicadorOferta,
		--ISNULL(pw.ImporteTotal,0) as ImporteTotalPedido,
		0 AS ImporteTotalPedido,
		@MontoTotalProl AS MontoTotalProl,
		@DescuentoProl AS DescuentoProl,
		cl.Nombre as NombreCliente
	FROM PedidoWebCorreoPROL pwd with(nolock)
	inner join dbo.PedidoWebDetalle pw with(nolock) on
		pwd.PedidoID = pw.PedidoID and pwd.CampaniaID = pw.CampaniaID and pwd.PedidoDetalleID = pw.PedidoDetalleID
		left join dbo.Cliente cl on cl.ConsultoraID = pw.ConsultoraID and pw.ClienteID = cl.ClienteID
	INNER JOIN ods.ProductoComercial pc with(nolock) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd with(nolock) ON
	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP with(nolock) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC with(nolock) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE pwd.ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId and TipoOrigen = @TipoOrigen
	ORDER BY pwd.PedidoDetalleID;
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE GetPedidoWebCorreoPROL
	@ValAutomaticaPROLLogId BIGINT,
	@TipoOrigen INT = null
AS
BEGIN
	DECLARE @MontoTotalProl MONEY;
	DECLARE @DescuentoProl MONEY;

	SET @TipoOrigen = ISNULL(@TipoOrigen,1);
	IF (@TipoOrigen=1)
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),
			@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionAutomaticaPROLLog
		WHERE ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId;
	END
	ELSE
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionMovilPROLLog
		WHERE ValidacionMovilPROLLogId = @ValAutomaticaPROLLogId;
	END

	SELECT
		pwd.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.ObservacionPROL,
		ISNULL(pc.IndicadorOferta,0) AS IndicadorOferta,
		--ISNULL(pw.ImporteTotal,0) as ImporteTotalPedido,
		0 AS ImporteTotalPedido,
		@MontoTotalProl AS MontoTotalProl,
		@DescuentoProl AS DescuentoProl,
		cl.Nombre as NombreCliente
	FROM PedidoWebCorreoPROL pwd with(nolock)
	inner join dbo.PedidoWebDetalle pw with(nolock) on
		pwd.PedidoID = pw.PedidoID and pwd.CampaniaID = pw.CampaniaID and pwd.PedidoDetalleID = pw.PedidoDetalleID
		left join dbo.Cliente cl on cl.ConsultoraID = pw.ConsultoraID and pw.ClienteID = cl.ClienteID
	INNER JOIN ods.ProductoComercial pc with(nolock) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd with(nolock) ON
	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP with(nolock) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC with(nolock) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE pwd.ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId and TipoOrigen = @TipoOrigen
	ORDER BY pwd.PedidoDetalleID;
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE GetPedidoWebCorreoPROL
	@ValAutomaticaPROLLogId BIGINT,
	@TipoOrigen INT = null
AS
BEGIN
	DECLARE @MontoTotalProl MONEY;
	DECLARE @DescuentoProl MONEY;

	SET @TipoOrigen = ISNULL(@TipoOrigen,1);
	IF (@TipoOrigen=1)
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),
			@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionAutomaticaPROLLog
		WHERE ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId;
	END
	ELSE
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionMovilPROLLog
		WHERE ValidacionMovilPROLLogId = @ValAutomaticaPROLLogId;
	END

	SELECT
		pwd.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.ObservacionPROL,
		ISNULL(pc.IndicadorOferta,0) AS IndicadorOferta,
		--ISNULL(pw.ImporteTotal,0) as ImporteTotalPedido,
		0 AS ImporteTotalPedido,
		@MontoTotalProl AS MontoTotalProl,
		@DescuentoProl AS DescuentoProl,
		cl.Nombre as NombreCliente
	FROM PedidoWebCorreoPROL pwd with(nolock)
	inner join dbo.PedidoWebDetalle pw with(nolock) on
		pwd.PedidoID = pw.PedidoID and pwd.CampaniaID = pw.CampaniaID and pwd.PedidoDetalleID = pw.PedidoDetalleID
		left join dbo.Cliente cl on cl.ConsultoraID = pw.ConsultoraID and pw.ClienteID = cl.ClienteID
	INNER JOIN ods.ProductoComercial pc with(nolock) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd with(nolock) ON
	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP with(nolock) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC with(nolock) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE pwd.ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId and TipoOrigen = @TipoOrigen
	ORDER BY pwd.PedidoDetalleID;
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE GetPedidoWebCorreoPROL
	@ValAutomaticaPROLLogId BIGINT,
	@TipoOrigen INT = null
AS
BEGIN
	DECLARE @MontoTotalProl MONEY;
	DECLARE @DescuentoProl MONEY;

	SET @TipoOrigen = ISNULL(@TipoOrigen,1);
	IF (@TipoOrigen=1)
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),
			@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionAutomaticaPROLLog
		WHERE ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId;
	END
	ELSE
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionMovilPROLLog
		WHERE ValidacionMovilPROLLogId = @ValAutomaticaPROLLogId;
	END

	SELECT
		pwd.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.ObservacionPROL,
		ISNULL(pc.IndicadorOferta,0) AS IndicadorOferta,
		--ISNULL(pw.ImporteTotal,0) as ImporteTotalPedido,
		0 AS ImporteTotalPedido,
		@MontoTotalProl AS MontoTotalProl,
		@DescuentoProl AS DescuentoProl,
		cl.Nombre as NombreCliente
	FROM PedidoWebCorreoPROL pwd with(nolock)
	inner join dbo.PedidoWebDetalle pw with(nolock) on
		pwd.PedidoID = pw.PedidoID and pwd.CampaniaID = pw.CampaniaID and pwd.PedidoDetalleID = pw.PedidoDetalleID
		left join dbo.Cliente cl on cl.ConsultoraID = pw.ConsultoraID and pw.ClienteID = cl.ClienteID
	INNER JOIN ods.ProductoComercial pc with(nolock) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd with(nolock) ON
	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP with(nolock) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC with(nolock) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE pwd.ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId and TipoOrigen = @TipoOrigen
	ORDER BY pwd.PedidoDetalleID;
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE GetPedidoWebCorreoPROL
	@ValAutomaticaPROLLogId BIGINT,
	@TipoOrigen INT = null
AS
BEGIN
	DECLARE @MontoTotalProl MONEY;
	DECLARE @DescuentoProl MONEY;

	SET @TipoOrigen = ISNULL(@TipoOrigen,1);
	IF (@TipoOrigen=1)
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),
			@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionAutomaticaPROLLog
		WHERE ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId;
	END
	ELSE
	BEGIN
		SELECT
			@MontoTotalProl = ISNULL(MontoTotalProl,0),@DescuentoProl = ISNULL(DescuentoProl,0)
		FROM ValidacionMovilPROLLog
		WHERE ValidacionMovilPROLLogId = @ValAutomaticaPROLLogId;
	END

	SELECT
		pwd.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.ObservacionPROL,
		ISNULL(pc.IndicadorOferta,0) AS IndicadorOferta,
		--ISNULL(pw.ImporteTotal,0) as ImporteTotalPedido,
		0 AS ImporteTotalPedido,
		@MontoTotalProl AS MontoTotalProl,
		@DescuentoProl AS DescuentoProl,
		cl.Nombre as NombreCliente
	FROM PedidoWebCorreoPROL pwd with(nolock)
	inner join dbo.PedidoWebDetalle pw with(nolock) on
		pwd.PedidoID = pw.PedidoID and pwd.CampaniaID = pw.CampaniaID and pwd.PedidoDetalleID = pw.PedidoDetalleID
		left join dbo.Cliente cl on cl.ConsultoraID = pw.ConsultoraID and pw.ClienteID = cl.ClienteID
	INNER JOIN ods.ProductoComercial pc with(nolock) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd with(nolock) ON
	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP with(nolock) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC with(nolock) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE pwd.ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId and TipoOrigen = @TipoOrigen
	ORDER BY pwd.PedidoDetalleID;
END
GO

