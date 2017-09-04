GO
IF OBJECT_ID('GetPedidoFICDetalleByCampania') IS NULL
	exec sp_executesql N'CREATE PROCEDURE GetPedidoFICDetalleByCampania AS';
GO
ALTER PROCEDURE GetPedidoFICDetalleByCampania
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SELECT
		pwd.CampaniaID,
		pwd.PedidoID,
		pwd.PedidoDetalleID,
		isnull(pwd.MarcaID,0) as MarcaID,
		pwd.ConsultoraID,
		pwd.ClienteID,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.CUV,
		coalesce(OP.Descripcion,OG.Descripcion, mc.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd,
		c.Nombre,
		pwd.OfertaWeb,
		pc.IndicadorMontoMinimo,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID
	FROM dbo.PedidoFICDetalle pwd
	JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania AND OG.CUV = PC.CUV
	LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
	WHERE pwd.CampaniaID = @CampaniaID AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	ORDER BY pwd.PedidoDetalleID DESC;
END
GO