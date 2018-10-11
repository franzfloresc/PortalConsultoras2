USE BelcorpPeru
GO

GO

ALTER PROCEDURE [dbo].[GetPedidoWebDetalleByPedidoValidado]
	
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		COALESCE(EST.DescripcionCUV2,OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido,
		pwd.ObservacionPROL,
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		PW.DescuentoProl
		,ISNULL(pwd.EsBackOrder,0) AS EsBackOrder,
		ISNULL(pwd.AceptoBackOrder,0) AS AceptoBackOrder
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN Estrategia EST WITH (NOLOCK) ON 
		PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
		AND EST.CUV2 = PWD.CUV
		AND EST.Activo=1
		AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
		AND (EST.TipoEstrategiaID = pwd.TipoEstrategiaID OR ISNULL(pwd.TipoEstrategiaID, 0) = 0)
	LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
		ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
			AND (
				TE.CodigoPrograma = @CodigoPrograma 
				OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
			)
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

USE BelcorpMexico
GO

GO

ALTER PROCEDURE [dbo].[GetPedidoWebDetalleByPedidoValidado]
	
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		COALESCE(EST.DescripcionCUV2,OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido,
		pwd.ObservacionPROL,
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		PW.DescuentoProl
		,ISNULL(pwd.EsBackOrder,0) AS EsBackOrder,
		ISNULL(pwd.AceptoBackOrder,0) AS AceptoBackOrder
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN Estrategia EST WITH (NOLOCK) ON 
		PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
		AND EST.CUV2 = PWD.CUV
		AND EST.Activo=1
		AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
		AND (EST.TipoEstrategiaID = pwd.TipoEstrategiaID OR ISNULL(pwd.TipoEstrategiaID, 0) = 0)
	LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
		ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
			AND (
				TE.CodigoPrograma = @CodigoPrograma 
				OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
			)
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

USE BelcorpColombia
GO

GO

ALTER PROCEDURE [dbo].[GetPedidoWebDetalleByPedidoValidado]
	
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		COALESCE(EST.DescripcionCUV2,OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido,
		pwd.ObservacionPROL,
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		PW.DescuentoProl
		,ISNULL(pwd.EsBackOrder,0) AS EsBackOrder,
		ISNULL(pwd.AceptoBackOrder,0) AS AceptoBackOrder
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN Estrategia EST WITH (NOLOCK) ON 
		PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
		AND EST.CUV2 = PWD.CUV
		AND EST.Activo=1
		AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
		AND (EST.TipoEstrategiaID = pwd.TipoEstrategiaID OR ISNULL(pwd.TipoEstrategiaID, 0) = 0)
	LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
		ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
			AND (
				TE.CodigoPrograma = @CodigoPrograma 
				OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
			)
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

USE BelcorpVenezuela
GO

GO

ALTER PROCEDURE [dbo].[GetPedidoWebDetalleByPedidoValidado]
	
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		COALESCE(EST.DescripcionCUV2,OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido,
		pwd.ObservacionPROL,
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		PW.DescuentoProl
		,ISNULL(pwd.EsBackOrder,0) AS EsBackOrder,
		ISNULL(pwd.AceptoBackOrder,0) AS AceptoBackOrder
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN Estrategia EST WITH (NOLOCK) ON 
		PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
		AND EST.CUV2 = PWD.CUV
		AND EST.Activo=1
		AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
		AND (EST.TipoEstrategiaID = pwd.TipoEstrategiaID OR ISNULL(pwd.TipoEstrategiaID, 0) = 0)
	LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
		ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
			AND (
				TE.CodigoPrograma = @CodigoPrograma 
				OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
			)
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

USE BelcorpSalvador
GO

GO

ALTER PROCEDURE [dbo].[GetPedidoWebDetalleByPedidoValidado]
	
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		COALESCE(EST.DescripcionCUV2,OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido,
		pwd.ObservacionPROL,
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		PW.DescuentoProl
		,ISNULL(pwd.EsBackOrder,0) AS EsBackOrder,
		ISNULL(pwd.AceptoBackOrder,0) AS AceptoBackOrder
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN Estrategia EST WITH (NOLOCK) ON 
		PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
		AND EST.CUV2 = PWD.CUV
		AND EST.Activo=1
		AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
		AND (EST.TipoEstrategiaID = pwd.TipoEstrategiaID OR ISNULL(pwd.TipoEstrategiaID, 0) = 0)
	LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
		ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
			AND (
				TE.CodigoPrograma = @CodigoPrograma 
				OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
			)
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

USE BelcorpPuertoRico
GO

GO

ALTER PROCEDURE [dbo].[GetPedidoWebDetalleByPedidoValidado]
	
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		COALESCE(EST.DescripcionCUV2,OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido,
		pwd.ObservacionPROL,
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		PW.DescuentoProl
		,ISNULL(pwd.EsBackOrder,0) AS EsBackOrder,
		ISNULL(pwd.AceptoBackOrder,0) AS AceptoBackOrder
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN Estrategia EST WITH (NOLOCK) ON 
		PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
		AND EST.CUV2 = PWD.CUV
		AND EST.Activo=1
		AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
		AND (EST.TipoEstrategiaID = pwd.TipoEstrategiaID OR ISNULL(pwd.TipoEstrategiaID, 0) = 0)
	LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
		ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
			AND (
				TE.CodigoPrograma = @CodigoPrograma 
				OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
			)
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

USE BelcorpPanama
GO

GO

ALTER PROCEDURE [dbo].[GetPedidoWebDetalleByPedidoValidado]
	
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		COALESCE(EST.DescripcionCUV2,OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido,
		pwd.ObservacionPROL,
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		PW.DescuentoProl
		,ISNULL(pwd.EsBackOrder,0) AS EsBackOrder,
		ISNULL(pwd.AceptoBackOrder,0) AS AceptoBackOrder
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN Estrategia EST WITH (NOLOCK) ON 
		PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
		AND EST.CUV2 = PWD.CUV
		AND EST.Activo=1
		AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
		AND (EST.TipoEstrategiaID = pwd.TipoEstrategiaID OR ISNULL(pwd.TipoEstrategiaID, 0) = 0)
	LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
		ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
			AND (
				TE.CodigoPrograma = @CodigoPrograma 
				OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
			)
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

USE BelcorpGuatemala
GO

GO

ALTER PROCEDURE [dbo].[GetPedidoWebDetalleByPedidoValidado]
	
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		COALESCE(EST.DescripcionCUV2,OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido,
		pwd.ObservacionPROL,
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		PW.DescuentoProl
		,ISNULL(pwd.EsBackOrder,0) AS EsBackOrder,
		ISNULL(pwd.AceptoBackOrder,0) AS AceptoBackOrder
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN Estrategia EST WITH (NOLOCK) ON 
		PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
		AND EST.CUV2 = PWD.CUV
		AND EST.Activo=1
		AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
		AND (EST.TipoEstrategiaID = pwd.TipoEstrategiaID OR ISNULL(pwd.TipoEstrategiaID, 0) = 0)
	LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
		ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
			AND (
				TE.CodigoPrograma = @CodigoPrograma 
				OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
			)
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

USE BelcorpEcuador
GO

GO

ALTER PROCEDURE [dbo].[GetPedidoWebDetalleByPedidoValidado]
	
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		COALESCE(EST.DescripcionCUV2,OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido,
		pwd.ObservacionPROL,
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		PW.DescuentoProl
		,ISNULL(pwd.EsBackOrder,0) AS EsBackOrder,
		ISNULL(pwd.AceptoBackOrder,0) AS AceptoBackOrder
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN Estrategia EST WITH (NOLOCK) ON 
		PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
		AND EST.CUV2 = PWD.CUV
		AND EST.Activo=1
		AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
		AND (EST.TipoEstrategiaID = pwd.TipoEstrategiaID OR ISNULL(pwd.TipoEstrategiaID, 0) = 0)
	LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
		ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
			AND (
				TE.CodigoPrograma = @CodigoPrograma 
				OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
			)
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

USE BelcorpDominicana
GO

GO

ALTER PROCEDURE [dbo].[GetPedidoWebDetalleByPedidoValidado]
	
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		COALESCE(EST.DescripcionCUV2,OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido,
		pwd.ObservacionPROL,
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		PW.DescuentoProl
		,ISNULL(pwd.EsBackOrder,0) AS EsBackOrder,
		ISNULL(pwd.AceptoBackOrder,0) AS AceptoBackOrder
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN Estrategia EST WITH (NOLOCK) ON 
		PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
		AND EST.CUV2 = PWD.CUV
		AND EST.Activo=1
		AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
		AND (EST.TipoEstrategiaID = pwd.TipoEstrategiaID OR ISNULL(pwd.TipoEstrategiaID, 0) = 0)
	LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
		ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
			AND (
				TE.CodigoPrograma = @CodigoPrograma 
				OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
			)
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

USE BelcorpCostaRica
GO

GO

ALTER PROCEDURE [dbo].[GetPedidoWebDetalleByPedidoValidado]
	
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		COALESCE(EST.DescripcionCUV2,OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido,
		pwd.ObservacionPROL,
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		PW.DescuentoProl
		,ISNULL(pwd.EsBackOrder,0) AS EsBackOrder,
		ISNULL(pwd.AceptoBackOrder,0) AS AceptoBackOrder
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN Estrategia EST WITH (NOLOCK) ON 
		PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
		AND EST.CUV2 = PWD.CUV
		AND EST.Activo=1
		AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
		AND (EST.TipoEstrategiaID = pwd.TipoEstrategiaID OR ISNULL(pwd.TipoEstrategiaID, 0) = 0)
	LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
		ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
			AND (
				TE.CodigoPrograma = @CodigoPrograma 
				OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
			)
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

USE BelcorpChile
GO

GO

ALTER PROCEDURE [dbo].[GetPedidoWebDetalleByPedidoValidado]
	
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		COALESCE(EST.DescripcionCUV2,OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido,
		pwd.ObservacionPROL,
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		PW.DescuentoProl
		,ISNULL(pwd.EsBackOrder,0) AS EsBackOrder,
		ISNULL(pwd.AceptoBackOrder,0) AS AceptoBackOrder
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN Estrategia EST WITH (NOLOCK) ON 
		PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
		AND EST.CUV2 = PWD.CUV
		AND EST.Activo=1
		AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
		AND (EST.TipoEstrategiaID = pwd.TipoEstrategiaID OR ISNULL(pwd.TipoEstrategiaID, 0) = 0)
	LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
		ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
			AND (
				TE.CodigoPrograma = @CodigoPrograma 
				OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
			)
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

USE BelcorpBolivia
GO

GO

ALTER PROCEDURE [dbo].[GetPedidoWebDetalleByPedidoValidado]
	
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		COALESCE(EST.DescripcionCUV2,OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido,
		pwd.ObservacionPROL,
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		PW.DescuentoProl
		,ISNULL(pwd.EsBackOrder,0) AS EsBackOrder,
		ISNULL(pwd.AceptoBackOrder,0) AS AceptoBackOrder
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN Estrategia EST WITH (NOLOCK) ON 
		PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
		AND EST.CUV2 = PWD.CUV
		AND EST.Activo=1
		AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
		AND (EST.TipoEstrategiaID = pwd.TipoEstrategiaID OR ISNULL(pwd.TipoEstrategiaID, 0) = 0)
	LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
		ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
			AND (
				TE.CodigoPrograma = @CodigoPrograma 
				OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
			)
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

