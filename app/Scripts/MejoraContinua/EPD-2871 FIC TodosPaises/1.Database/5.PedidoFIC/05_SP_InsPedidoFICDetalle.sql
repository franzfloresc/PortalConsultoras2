GO
IF OBJECT_ID('InsPedidoFICDetalle') IS NULL
	exec sp_executesql N'CREATE PROCEDURE InsPedidoFICDetalle AS';
GO
ALTER PROCEDURE InsPedidoFICDetalle
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@ClienteID smallint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@PedidoID int,
	@OfertaWeb bit,
	@ConfiguracionOfertaID int,
	@TipoOfertaSisID int,
	@PedidoDetalleID smallint output,
	@CodigoUsuarioCreacion varchar(25) = null
AS
BEGIN
	SET @PedidoDetalleID = (
		SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
		FROM dbo.PedidoFICDetalle 
		WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	);

	INSERT INTO dbo.PedidoFICDetalle(CampaniaID, PedidoID, PedidoDetalleID,
		MarcaID, ConsultoraID, ClienteID,
		Cantidad, PrecioUnidad, ImporteTotal,
		CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, 
		TipoOfertaSisID, CodigoUsuarioCreacion, FechaCreacion)
	VALUES (@CampaniaID, @PedidoID, @PedidoDetalleID,
		@MarcaID, @ConsultoraID, @ClienteID,
		@Cantidad, @PrecioUnidad, @Cantidad*@PrecioUnidad,
		@CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, 
		@TipoOfertaSisID, @CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais());
END
GO