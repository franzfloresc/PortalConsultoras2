
USE BelcorpBolivia
GO


ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
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
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0,
	@TipoEstrategiaId int = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

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
			 OrigenPedidoWeb,
			 TipoEstrategiaId
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb,@TipoEstrategiaId)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden--,
					--OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END



GO


USE BelcorpChile
GO




ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
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
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0,
	@TipoEstrategiaId int = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

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
			 OrigenPedidoWeb,
			 TipoEstrategiaId
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb,@TipoEstrategiaId)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden--,
					--OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END



GO


USE BelcorpColombia
GO




ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
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
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0,
	@TipoEstrategiaId int = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

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
			 OrigenPedidoWeb,
			 TipoEstrategiaId
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb,@TipoEstrategiaId)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden--,
					--OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END



GO


USE BelcorpCostaRica
GO


ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
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
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0,
	@TipoEstrategiaId int = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

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
			 OrigenPedidoWeb,
			 TipoEstrategiaId
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb,@TipoEstrategiaId)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden--,
					--OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END



GO


USE BelcorpDominicana
GO




ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
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
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0,
	@TipoEstrategiaId int = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

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
			 OrigenPedidoWeb,
			 TipoEstrategiaId
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb,@TipoEstrategiaId)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden--,
					--OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END



GO


USE BelcorpEcuador
GO




ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
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
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0,
	@TipoEstrategiaId int = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

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
			 OrigenPedidoWeb,
			 TipoEstrategiaId
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb,@TipoEstrategiaId)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden--,
					--OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END



GO


USE BelcorpGuatemala
GO





ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
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
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0,
	@TipoEstrategiaId int = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

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
			 OrigenPedidoWeb,
			 TipoEstrategiaId
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb,@TipoEstrategiaId)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden--,
					--OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END



GO


USE BelcorpMexico
GO


ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
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
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0,
	@TipoEstrategiaId int = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

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
			 OrigenPedidoWeb,
			 TipoEstrategiaId
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb,@TipoEstrategiaId)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden--,
					--OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END



GO


USE BelcorpPanama
GO


ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
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
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0,
	@TipoEstrategiaId int = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

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
			 OrigenPedidoWeb,
			 TipoEstrategiaId
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb,@TipoEstrategiaId)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden--,
					--OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END



GO


USE BelcorpPeru
GO




ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
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
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0,
	@TipoEstrategiaId int = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

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
			 OrigenPedidoWeb,
			 TipoEstrategiaId
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb,@TipoEstrategiaId)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden--,
					--OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END



GO

USE BelcorpPuertoRico
GO




ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
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
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0,
	@TipoEstrategiaId int = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

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
			 OrigenPedidoWeb,
			 TipoEstrategiaId
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb,@TipoEstrategiaId)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden--,
					--OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END



GO

USE BelcorpSalvador
GO




ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
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
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0,
	@TipoEstrategiaId int = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

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
			 OrigenPedidoWeb,
			 TipoEstrategiaId
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb,@TipoEstrategiaId)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden--,
					--OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END



GO


