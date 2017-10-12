GO
alter procedure dbo.GetPedidosFacturadosDetalle
    @Campania VARCHAR(8),
	@Region VARCHAR(8),
	@Zona VARCHAR(8),
	@CodigoConsultora VARCHAR(25),
	@PedidoID int = null
AS
BEGIN
	DECLARE @CampaniaID INT
	DECLARE @RegionID INT
	DECLARE @ZonaID INT

	SELECT TOP 1 @CampaniaID = CampaniaID from ods.Campania with(nolock) where Codigo = @Campania

	IF @Region = '0'
		SET @RegionID = NULL
	ELSE
		SELECT TOP 1 @RegionID = RegionID from ods.Region with(nolock) where Codigo = @Region

	IF @Zona = '0'
		SET @ZonaID = NULL
	ELSE
		SELECT TOP 1 @ZonaID = ZonaID from ods.Zona with(nolock) where Codigo = @Zona

	IF @CodigoConsultora = '0'
		SET @CodigoConsultora = NULL
	
	SELECT top 5000
		CO.Codigo AS 'CodigoConsultora', cast(isnull(PD.MontoDescuento,0) as varchar) as 'MontoDescuento'
		, ISNULL(TE.Codigo,'') AS 'CodigoTerritorio'
		, ISNULL(PC.CUV, '') AS 'CUV' 
		, ISNULL(PC.CodigoProducto, '') AS 'CodigoProducto'
		, ISNULL(PC.Descripcion, '') AS 'Descripcion'
		, PD.Cantidad
		, PD.PrecioUnidad
		, PD.PrecioTotal AS 'ImporteTotal'
		, ISNULL(PC.CodigoTipoOferta, '') AS 'CodigoTipoOferta'
		, PD.Origen
		, PE.FechaModificacion AS 'FechaUltimaActualizacion'
	FROM ods.Pedido PE (nolock)
	INNER JOIN ods.PedidoDetalle PD (nolock) ON PD.PedidoID = PE.PedidoID
	INNER JOIN ods.Consultora CO (nolock) ON PE.ConsultoraID = CO.ConsultoraID
	LEFT JOIN ods.Territorio TE (nolock) ON CO.TerritorioID = TE.TerritorioID and CO.SeccionID = TE.SeccionID
	INNER JOIN ods.ProductoComercial PC (nolock) ON PD.CUV = PC.CUV AND PD.CampaniaID = PC.CampaniaID
	WHERE
		PE.CampaniaID = @CampaniaID AND
		(@PedidoID IS NULL OR @PedidoID = PE.PedidoID)AND
		CO.RegionID = COALESCE(@RegionID, CO.RegionID) AND
		CO.ZonaID = COALESCE(@ZonaID, CO.ZonaID) AND
		CO.Codigo = COALESCE(@CodigoConsultora, CO.Codigo);
END
GO