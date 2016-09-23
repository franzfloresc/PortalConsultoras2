ALTER PROCEDURE [dbo].InsPedidoWebDetalle_SB2
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
	@CodigoUsuarioCreacion varchar(25) = null,
	@SubTipoOfertaSisID smallint = null,
	@EsSugerido bit,
	@EskitNueva bit = 0,
	@OrigenPedidoWeb int = 0
AS	
BEGIN
	declare @orden int = 0

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		, @orden = max(ISNULL(OrdenPedidoWD,0))
	FROM dbo.PedidoWebDetalle 
	WHERE 
		CampaniaID = @CampaniaID
		AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @orden = ISNULL(@orden, 0) + 1

	INSERT INTO dbo.PedidoWebDetalle 
	(CampaniaID, PedidoID, PedidoDetalleID, MarcaID, ConsultoraID, ClienteID, Cantidad, PrecioUnidad, 
	ImporteTotal, CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, TipoOfertaSisID, 
	CodigoUsuarioCreacion, FechaCreacion, SubTipoOfertaSisID, EsSugerido, EskitNueva, OrdenPedidoWD, OrigenPedidoWeb)
	VALUES 
	(@CampaniaID, @PedidoID, @PedidoDetalleID, @MarcaID, @ConsultoraID, @ClienteID, @Cantidad, @PrecioUnidad, 
	@Cantidad*@PrecioUnidad, @CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, @TipoOfertaSisID, 
	@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(),@SubTipoOfertaSisID, @EsSugerido, @EskitNueva, @orden, @OrigenPedidoWeb)

END
GO

ALTER PROCEDURE [dbo].[InsPedidoWebDetalleOferta_SB2]
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@ConfiguracionOfertaID INT,
	@TipoOfertaSisID INT,
	@PaisID int,
	@IPUsuario varchar(25) = null,
	@CodigoUsuarioCreacion varchar(25) = null,
	@OrigenPedidoWeb int = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		   , @Orden = max(ISNULL(OrdenPedidoWD,0))
		   FROM dbo.PedidoWebDetalle 
		   WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @Orden = ISNULL(@Orden, 0) + 1

	--SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
	--							FROM	dbo.PedidoWebDetalle 
	--							WHERE	CampaniaID = @CampaniaID AND
	--									PedidoID = @PedidoID);

	/* Validar Al Agregar Nuevamente */
	set @ExisteDet = (select count(*) from PedidoWebDetalle 
						where CampaniaID = @CampaniaID 
							  AND PedidoID = @PedidoID
							  AND CUV = @CUV
							  AND ClienteID IS NULL);

	IF @ExisteDet = 0 
		BEGIN
			INSERT INTO dbo.PedidoWebDetalle 
			(
			 CampaniaID,
			 PedidoID,
			 PedidoDetalleID,
			 MarcaID,
			 ConsultoraID,
			 ClienteID,
			 Cantidad,
			 PrecioUnidad,
			 ImporteTotal,
			 CUV,
			 OfertaWeb, 
			 ModificaPedidoReservado,
			 ConfiguracionOfertaID,
			 TipoOfertaSisID,
			 CodigoUsuarioCreacion,
			 FechaCreacion,
			 OrdenPedidoWD,
			 OrigenPedidoWeb
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden,
					OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END
GO

ALTER PROCEDURE dbo.UpdPedidoWebDetalle_SB2
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null,
	@EsSugerido bit,
	@OrdenPedidoWD int = 0,
	@OrigenPedidoWeb int = 0
AS
BEGIN
	
	if @OrdenPedidoWD = 1
	begin
		
		SELECT @OrdenPedidoWD = max(ISNULL(OrdenPedidoWD,0))
		FROM dbo.PedidoWebDetalle 
		WHERE 
			CampaniaID = @CampaniaID
			AND PedidoID = @PedidoID

		set @OrdenPedidoWD = ISNULL(@OrdenPedidoWD, 0) + 1
	end
	else 
		set @OrdenPedidoWD = 0

	UPDATE dbo.PedidoWebDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais(),
		TipoPedido = CASE WHEN TipoPedido = 'M' THEN 'X' ELSE TipoPedido END,
		EsSugerido = @EsSugerido,
		OrdenPedidoWD = case when @OrdenPedidoWD > 0 then @OrdenPedidoWD else OrdenPedidoWD end,
		OrigenPedidoWeb = @OrigenPedidoWeb
	WHERE
		CampaniaID = @CampaniaID
		AND	PedidoID = @PedidoID
		AND	PedidoDetalleID = @PedidoDetalleID

END
GO

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

