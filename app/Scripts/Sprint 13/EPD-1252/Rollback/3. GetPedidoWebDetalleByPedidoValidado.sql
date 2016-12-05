
USE BelcorpBolivia
GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByPedidoValidado
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		--COALESCE(OP.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		COALESCE(OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido, --PV: Producto Validado / PNV: Producto No Validado
		pwd.ObservacionPROL,
		/*R20150701LR-I*/
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		/*R20150701LR-F*/
		PW.DescuentoProl --GR-846
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID /*R20150701LR*/
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND
		pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

/*end*/

USE BelcorpChile
GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByPedidoValidado
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		--COALESCE(OP.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		COALESCE(OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido, --PV: Producto Validado / PNV: Producto No Validado
		pwd.ObservacionPROL,
		/*R20150701LR-I*/
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		/*R20150701LR-F*/
		PW.DescuentoProl --GR-846
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID /*R20150701LR*/
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND
		pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

/*end*/

USE BelcorpColombia
GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByPedidoValidado
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		--COALESCE(OP.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		COALESCE(OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido, --PV: Producto Validado / PNV: Producto No Validado
		pwd.ObservacionPROL,
		/*R20150701LR-I*/
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		/*R20150701LR-F*/
		PW.DescuentoProl --GR-846
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID /*R20150701LR*/
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND
		pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

/*end*/

USE BelcorpCostaRica
GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByPedidoValidado
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		--COALESCE(OP.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		COALESCE(OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido, --PV: Producto Validado / PNV: Producto No Validado
		pwd.ObservacionPROL,
		/*R20150701LR-I*/
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		/*R20150701LR-F*/
		PW.DescuentoProl --GR-846
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID /*R20150701LR*/
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND
		pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

/*end*/

USE BelcorpDominicana
GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByPedidoValidado
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		--COALESCE(OP.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		COALESCE(OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido, --PV: Producto Validado / PNV: Producto No Validado
		pwd.ObservacionPROL,
		/*R20150701LR-I*/
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		/*R20150701LR-F*/
		PW.DescuentoProl --GR-846
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID /*R20150701LR*/
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND
		pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

/*end*/

USE BelcorpEcuador
GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByPedidoValidado
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		--COALESCE(OP.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		COALESCE(OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido, --PV: Producto Validado / PNV: Producto No Validado
		pwd.ObservacionPROL,
		/*R20150701LR-I*/
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		/*R20150701LR-F*/
		PW.DescuentoProl --GR-846
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID /*R20150701LR*/
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND
		pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

/*end*/

USE BelcorpGuatemala
GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByPedidoValidado
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		--COALESCE(OP.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		COALESCE(OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido, --PV: Producto Validado / PNV: Producto No Validado
		pwd.ObservacionPROL,
		/*R20150701LR-I*/
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		/*R20150701LR-F*/
		PW.DescuentoProl --GR-846
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID /*R20150701LR*/
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND
		pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

/*end*/

USE BelcorpMexico
GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByPedidoValidado
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		--COALESCE(OP.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		COALESCE(OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido, --PV: Producto Validado / PNV: Producto No Validado
		pwd.ObservacionPROL,
		/*R20150701LR-I*/
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		/*R20150701LR-F*/
		PW.DescuentoProl --GR-846
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID /*R20150701LR*/
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND
		pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

/*end*/

USE BelcorpPanama
GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByPedidoValidado
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		--COALESCE(OP.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		COALESCE(OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido, --PV: Producto Validado / PNV: Producto No Validado
		pwd.ObservacionPROL,
		/*R20150701LR-I*/
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		/*R20150701LR-F*/
		PW.DescuentoProl --GR-846
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID /*R20150701LR*/
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND
		pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

/*end*/

USE BelcorpPeru
GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByPedidoValidado
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		--COALESCE(OP.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		COALESCE(OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido, --PV: Producto Validado / PNV: Producto No Validado
		pwd.ObservacionPROL,
		/*R20150701LR-I*/
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		/*R20150701LR-F*/
		PW.DescuentoProl --GR-846
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID /*R20150701LR*/
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND
		pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

/*end*/

USE BelcorpPuertoRico
GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByPedidoValidado
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		--COALESCE(OP.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		COALESCE(OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido, --PV: Producto Validado / PNV: Producto No Validado
		pwd.ObservacionPROL,
		/*R20150701LR-I*/
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		/*R20150701LR-F*/
		PW.DescuentoProl --GR-846
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID /*R20150701LR*/
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND
		pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

/*end*/

USE BelcorpSalvador
GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByPedidoValidado
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		--COALESCE(OP.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		COALESCE(OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido, --PV: Producto Validado / PNV: Producto No Validado
		pwd.ObservacionPROL,
		/*R20150701LR-I*/
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		/*R20150701LR-F*/
		PW.DescuentoProl --GR-846
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID /*R20150701LR*/
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND
		pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO

/*end*/

USE BelcorpVenezuela
GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByPedidoValidado
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SELECT pwd.CampaniaID, pwd.PedidoID, pwd.PedidoDetalleID, ISNULL(pwd.MarcaID, 0) MarcaID, pwd.ConsultoraID,
		pwd.ClienteID, pwd.Cantidad, pwd.PrecioUnidad, pwd.ImporteTotal, pwd.CUV,
		--COALESCE(OP.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		COALESCE(OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre, pwd.OfertaWeb,
		pwd.CUVPadre, pwd.PedidoDetalleIDPadre,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		CASE WHEN pwd.ModificaPedidoReservadoMovil = 0 THEN 'PV' ELSE 'PNV' END AS TipoPedido, --PV: Producto Validado / PNV: Producto No Validado
		pwd.ObservacionPROL,
		/*R20150701LR-I*/
		pc.IndicadorOferta AS IndicadorOfertaCUV,
		PW.PedidoID,
		PW.MontoTotalProl,
		/*R20150701LR-F*/
		PW.DescuentoProl --GR-846
	FROM dbo.PedidoWebDetalle pwd
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.ProductoComercial pc	ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.ProductoDescripcion pd ON	pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID /*R20150701LR*/
	WHERE
		pwd.CampaniaID = @CampaniaID
		AND
		pwd.ConsultoraID = @ConsultoraID
	ORDER BY 
		pwd.PedidoDetalleID,
		ISNULL(pwd.PedidoDetalleIDPadre,1) DESC;
END

GO


