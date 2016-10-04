ALTER PROCEDURE [dbo].[UpdPedidoWebDetalleOferta]

	@ConsultoraID INT,
	@CampaniaID INT,
	@CUV Varchar(20),
	@Cantidad INT,
	@CantidadAnterior INT,
	@PrecioUnidad MONEY,
	@TipoOfertaSisID int,
	@CodigoUsuarioModificacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
--Nueva 2
--Anterior 4
-- Actual 4

--Nueva 4
--Anterior 2
-- Actual 12

--Nueva 4
--Anterior 4
-- Actual 12

Declare @CantidadActual int 

	SET @CantidadActual = (select isnull(cantidad,0) from pedidowebdetalle WHERE 
							CampaniaID = @CampaniaID AND
							CUV = @CUV AND
							TipoOfertaSisID = @TipoOfertaSisID AND
							ConsultoraID = @ConsultoraID)

UPDATE dbo.PedidoWebDetalle
	set Cantidad = CASE WHEN @Cantidad = @CantidadAnterior THEN @Cantidad
						WHEN @CantidadAnterior > @Cantidad THEN @CantidadActual - (@CantidadAnterior - @Cantidad)
						WHEN @CantidadAnterior < @Cantidad THEN @CantidadActual + (@Cantidad - @CantidadAnterior)
					  END,
	ImporteTotal = @Cantidad*@PrecioUnidad,
	CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
	FechaModificacion = dbo.fnObtenerFechaHoraPais(),
	OrigenPedidoWeb = @OrigenPedidoWeb
WHERE  CampaniaID = @CampaniaID AND
		CUV = @CUV AND
		TipoOfertaSisID = @TipoOfertaSisID AND
		ConsultoraID = @ConsultoraID
 
END

