
GO

ALTER PROCEDURE [dbo].[UpdPedidoWebDetalle_SB2]
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null,
	@EsSugerido bit,
	@OrdenPedidoWD int = 0,
	@OrigenPedidoWeb int = 0,
	@TipoEstrategiaID int = 0
AS
BEGIN	
	if @OrdenPedidoWD = 1
	begin
		SET @OrdenPedidoWD = 0
		SELECT @OrdenPedidoWD = max(ISNULL(OrdenPedidoWD,0))
		FROM dbo.PedidoWebDetalle 
		WHERE 
			CampaniaID = @CampaniaID
			AND PedidoID = @PedidoID

		set @OrdenPedidoWD = ISNULL(@OrdenPedidoWD, 0) + 1
	end
	else 
		set @OrdenPedidoWD = 0

	SET @TipoEstrategiaID = ISNULL(@TipoEstrategiaID, 0)
	IF @TipoEstrategiaID < 0
		SET @TipoEstrategiaID = 0

	UPDATE dbo.PedidoWebDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais(),
		TipoPedido = CASE WHEN TipoPedido = 'M' THEN 'X' ELSE TipoPedido END,
		EsSugerido = @EsSugerido,
		OrdenPedidoWD = case when @OrdenPedidoWD > 0 then @OrdenPedidoWD else OrdenPedidoWD end,
		--OrigenPedidoWeb = @OrigenPedidoWeb,
		EsBackOrder = CASE WHEN ISNULL(EsBackOrder,0) = 1 THEN 1 ELSE 0 END,
		AceptoBackOrder = CASE WHEN ISNULL(AceptoBackOrder,0) = 1 THEN 1 ELSE 0 END,
		TipoEstrategiaID = CASE WHEN @TipoEstrategiaID = 0 THEN TipoEstrategiaID ELSE @TipoEstrategiaID END
	WHERE
		CampaniaID = @CampaniaID
		AND	PedidoID = @PedidoID
		AND	PedidoDetalleID = @PedidoDetalleID;
END

GO