

use BelcorpBolivia
Go

IF (OBJECT_ID('dbo.InsPedidoWebDetalle_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsPedidoWebDetalle_SB2 AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[InsPedidoWebDetalle_SB2]
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
	@TipoEstrategiaID INT = 0,
	@TipoOfertaSisID int,
	@PedidoDetalleID smallint output,
	@CodigoUsuarioCreacion varchar(25) = null,
	@SubTipoOfertaSisID smallint = null,
	@EsSugerido bit,
	@EskitNueva bit = 0,
	@OrigenPedidoWeb int = 0
AS	
BEGIN
		--ajuste del id:showroom
	if( (select descripcionEstrategia from tipoestrategia where tipoestrategiaid =@TipoOfertaSisID) ='ShowRoom')
	begin
		set @TipoOfertaSisID = 1707
	end
	--

	declare @existe int = 0
	if @EskitNueva = 1
	begin
		select @existe = count(1)
		from dbo.PedidoWebDetalle
		where ConsultoraID = @ConsultoraID and CampaniaID = @CampaniaID and eskitNueva = 1

		set @existe = isnull(@existe, 0)
	end
	
	if (@existe = 0 and @EskitNueva = 1) or @EskitNueva = 0
	begin
		 
			declare @orden int = 0

			SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
				, @orden = max(ISNULL(OrdenPedidoWD,0))
			FROM dbo.PedidoWebDetalle 
			WHERE 
				CampaniaID = @CampaniaID
				AND PedidoID = @PedidoID
	
			SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
			SET @orden = ISNULL(@orden, 0) + 1

			SET @TipoEstrategiaID = ISNULL(@TipoEstrategiaID, 0)

			INSERT INTO dbo.PedidoWebDetalle 
			(
				CampaniaID, PedidoID, PedidoDetalleID, MarcaID, ConsultoraID, ClienteID, Cantidad, PrecioUnidad, 
				ImporteTotal, CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, TipoOfertaSisID, 
				CodigoUsuarioCreacion, FechaCreacion, SubTipoOfertaSisID, EsSugerido, EskitNueva, OrdenPedidoWD, OrigenPedidoWeb,
				TipoEstrategiaID
			)
			VALUES 
			(
				@CampaniaID, @PedidoID, @PedidoDetalleID, @MarcaID, @ConsultoraID, @ClienteID, @Cantidad, @PrecioUnidad, 
				@Cantidad*@PrecioUnidad, @CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, @TipoOfertaSisID, 
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(),@SubTipoOfertaSisID, @EsSugerido, @EskitNueva, @orden, @OrigenPedidoWeb,
				@TipoEstrategiaID
			)

	END

END


GO


use BelcorpChile
Go

IF (OBJECT_ID('dbo.InsPedidoWebDetalle_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsPedidoWebDetalle_SB2 AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[InsPedidoWebDetalle_SB2]
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
	@TipoEstrategiaID INT = 0,
	@TipoOfertaSisID int,
	@PedidoDetalleID smallint output,
	@CodigoUsuarioCreacion varchar(25) = null,
	@SubTipoOfertaSisID smallint = null,
	@EsSugerido bit,
	@EskitNueva bit = 0,
	@OrigenPedidoWeb int = 0
AS	
BEGIN
			--ajuste del id:showroom
	if( (select descripcionEstrategia from tipoestrategia where tipoestrategiaid =@TipoOfertaSisID) ='ShowRoom')
	begin
		set @TipoOfertaSisID = 1707
	end
	--

	declare @existe int = 0
	if @EskitNueva = 1
	begin
		select @existe = count(1)
		from dbo.PedidoWebDetalle
		where ConsultoraID = @ConsultoraID and CampaniaID = @CampaniaID and eskitNueva = 1

		set @existe = isnull(@existe, 0)
	end
	
	if (@existe = 0 and @EskitNueva = 1) or @EskitNueva = 0
	begin
		 
			declare @orden int = 0

			SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
				, @orden = max(ISNULL(OrdenPedidoWD,0))
			FROM dbo.PedidoWebDetalle 
			WHERE 
				CampaniaID = @CampaniaID
				AND PedidoID = @PedidoID
	
			SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
			SET @orden = ISNULL(@orden, 0) + 1

			SET @TipoEstrategiaID = ISNULL(@TipoEstrategiaID, 0)

			INSERT INTO dbo.PedidoWebDetalle 
			(
				CampaniaID, PedidoID, PedidoDetalleID, MarcaID, ConsultoraID, ClienteID, Cantidad, PrecioUnidad, 
				ImporteTotal, CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, TipoOfertaSisID, 
				CodigoUsuarioCreacion, FechaCreacion, SubTipoOfertaSisID, EsSugerido, EskitNueva, OrdenPedidoWD, OrigenPedidoWeb,
				TipoEstrategiaID
			)
			VALUES 
			(
				@CampaniaID, @PedidoID, @PedidoDetalleID, @MarcaID, @ConsultoraID, @ClienteID, @Cantidad, @PrecioUnidad, 
				@Cantidad*@PrecioUnidad, @CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, @TipoOfertaSisID, 
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(),@SubTipoOfertaSisID, @EsSugerido, @EskitNueva, @orden, @OrigenPedidoWeb,
				@TipoEstrategiaID
			)

	END

END


GO


use BelcorpColombia
Go

IF (OBJECT_ID('dbo.InsPedidoWebDetalle_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsPedidoWebDetalle_SB2 AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[InsPedidoWebDetalle_SB2]
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
	@TipoEstrategiaID INT = 0,
	@TipoOfertaSisID int,
	@PedidoDetalleID smallint output,
	@CodigoUsuarioCreacion varchar(25) = null,
	@SubTipoOfertaSisID smallint = null,
	@EsSugerido bit,
	@EskitNueva bit = 0,
	@OrigenPedidoWeb int = 0
AS	
BEGIN
			--ajuste del id:showroom
	if( (select descripcionEstrategia from tipoestrategia where tipoestrategiaid =@TipoOfertaSisID) ='ShowRoom')
	begin
		set @TipoOfertaSisID = 1707
	end
	--

	declare @existe int = 0
	if @EskitNueva = 1
	begin
		select @existe = count(1)
		from dbo.PedidoWebDetalle
		where ConsultoraID = @ConsultoraID and CampaniaID = @CampaniaID and eskitNueva = 1

		set @existe = isnull(@existe, 0)
	end
	
	if (@existe = 0 and @EskitNueva = 1) or @EskitNueva = 0
	begin
		 
			declare @orden int = 0

			SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
				, @orden = max(ISNULL(OrdenPedidoWD,0))
			FROM dbo.PedidoWebDetalle 
			WHERE 
				CampaniaID = @CampaniaID
				AND PedidoID = @PedidoID
	
			SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
			SET @orden = ISNULL(@orden, 0) + 1

			SET @TipoEstrategiaID = ISNULL(@TipoEstrategiaID, 0)

			INSERT INTO dbo.PedidoWebDetalle 
			(
				CampaniaID, PedidoID, PedidoDetalleID, MarcaID, ConsultoraID, ClienteID, Cantidad, PrecioUnidad, 
				ImporteTotal, CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, TipoOfertaSisID, 
				CodigoUsuarioCreacion, FechaCreacion, SubTipoOfertaSisID, EsSugerido, EskitNueva, OrdenPedidoWD, OrigenPedidoWeb,
				TipoEstrategiaID
			)
			VALUES 
			(
				@CampaniaID, @PedidoID, @PedidoDetalleID, @MarcaID, @ConsultoraID, @ClienteID, @Cantidad, @PrecioUnidad, 
				@Cantidad*@PrecioUnidad, @CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, @TipoOfertaSisID, 
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(),@SubTipoOfertaSisID, @EsSugerido, @EskitNueva, @orden, @OrigenPedidoWeb,
				@TipoEstrategiaID
			)

	END

END


GO


use BelcorpCostaRica
Go
IF (OBJECT_ID('dbo.InsPedidoWebDetalle_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsPedidoWebDetalle_SB2 AS SET NOCOUNT ON;')
GO


ALTER PROCEDURE [dbo].[InsPedidoWebDetalle_SB2]
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
	@TipoEstrategiaID INT = 0,
	@TipoOfertaSisID int,
	@PedidoDetalleID smallint output,
	@CodigoUsuarioCreacion varchar(25) = null,
	@SubTipoOfertaSisID smallint = null,
	@EsSugerido bit,
	@EskitNueva bit = 0,
	@OrigenPedidoWeb int = 0
AS	
BEGIN
			--ajuste del id:showroom
	if( (select descripcionEstrategia from tipoestrategia where tipoestrategiaid =@TipoOfertaSisID) ='ShowRoom')
	begin
		set @TipoOfertaSisID = 1707
	end
	--

	declare @existe int = 0
	if @EskitNueva = 1
	begin
		select @existe = count(1)
		from dbo.PedidoWebDetalle
		where ConsultoraID = @ConsultoraID and CampaniaID = @CampaniaID and eskitNueva = 1

		set @existe = isnull(@existe, 0)
	end
	
	if (@existe = 0 and @EskitNueva = 1) or @EskitNueva = 0
	begin
		 
			declare @orden int = 0

			SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
				, @orden = max(ISNULL(OrdenPedidoWD,0))
			FROM dbo.PedidoWebDetalle 
			WHERE 
				CampaniaID = @CampaniaID
				AND PedidoID = @PedidoID
	
			SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
			SET @orden = ISNULL(@orden, 0) + 1

			SET @TipoEstrategiaID = ISNULL(@TipoEstrategiaID, 0)

			INSERT INTO dbo.PedidoWebDetalle 
			(
				CampaniaID, PedidoID, PedidoDetalleID, MarcaID, ConsultoraID, ClienteID, Cantidad, PrecioUnidad, 
				ImporteTotal, CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, TipoOfertaSisID, 
				CodigoUsuarioCreacion, FechaCreacion, SubTipoOfertaSisID, EsSugerido, EskitNueva, OrdenPedidoWD, OrigenPedidoWeb,
				TipoEstrategiaID
			)
			VALUES 
			(
				@CampaniaID, @PedidoID, @PedidoDetalleID, @MarcaID, @ConsultoraID, @ClienteID, @Cantidad, @PrecioUnidad, 
				@Cantidad*@PrecioUnidad, @CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, @TipoOfertaSisID, 
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(),@SubTipoOfertaSisID, @EsSugerido, @EskitNueva, @orden, @OrigenPedidoWeb,
				@TipoEstrategiaID
			)

	END

END


GO


use BelcorpDominicana
Go

IF (OBJECT_ID('dbo.InsPedidoWebDetalle_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsPedidoWebDetalle_SB2 AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[InsPedidoWebDetalle_SB2]
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
	@TipoEstrategiaID INT = 0,
	@TipoOfertaSisID int,
	@PedidoDetalleID smallint output,
	@CodigoUsuarioCreacion varchar(25) = null,
	@SubTipoOfertaSisID smallint = null,
	@EsSugerido bit,
	@EskitNueva bit = 0,
	@OrigenPedidoWeb int = 0
AS	
BEGIN
			--ajuste del id:showroom
	if( (select descripcionEstrategia from tipoestrategia where tipoestrategiaid =@TipoOfertaSisID) ='ShowRoom')
	begin
		set @TipoOfertaSisID = 1707
	end
	--

	declare @existe int = 0
	if @EskitNueva = 1
	begin
		select @existe = count(1)
		from dbo.PedidoWebDetalle
		where ConsultoraID = @ConsultoraID and CampaniaID = @CampaniaID and eskitNueva = 1

		set @existe = isnull(@existe, 0)
	end
	
	if (@existe = 0 and @EskitNueva = 1) or @EskitNueva = 0
	begin
		 
			declare @orden int = 0

			SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
				, @orden = max(ISNULL(OrdenPedidoWD,0))
			FROM dbo.PedidoWebDetalle 
			WHERE 
				CampaniaID = @CampaniaID
				AND PedidoID = @PedidoID
	
			SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
			SET @orden = ISNULL(@orden, 0) + 1

			SET @TipoEstrategiaID = ISNULL(@TipoEstrategiaID, 0)

			INSERT INTO dbo.PedidoWebDetalle 
			(
				CampaniaID, PedidoID, PedidoDetalleID, MarcaID, ConsultoraID, ClienteID, Cantidad, PrecioUnidad, 
				ImporteTotal, CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, TipoOfertaSisID, 
				CodigoUsuarioCreacion, FechaCreacion, SubTipoOfertaSisID, EsSugerido, EskitNueva, OrdenPedidoWD, OrigenPedidoWeb,
				TipoEstrategiaID
			)
			VALUES 
			(
				@CampaniaID, @PedidoID, @PedidoDetalleID, @MarcaID, @ConsultoraID, @ClienteID, @Cantidad, @PrecioUnidad, 
				@Cantidad*@PrecioUnidad, @CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, @TipoOfertaSisID, 
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(),@SubTipoOfertaSisID, @EsSugerido, @EskitNueva, @orden, @OrigenPedidoWeb,
				@TipoEstrategiaID
			)

	END

END


GO

use BelcorpEcuador
Go
IF (OBJECT_ID('dbo.InsPedidoWebDetalle_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsPedidoWebDetalle_SB2 AS SET NOCOUNT ON;')
GO


ALTER PROCEDURE [dbo].[InsPedidoWebDetalle_SB2]
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
	@TipoEstrategiaID INT = 0,
	@TipoOfertaSisID int,
	@PedidoDetalleID smallint output,
	@CodigoUsuarioCreacion varchar(25) = null,
	@SubTipoOfertaSisID smallint = null,
	@EsSugerido bit,
	@EskitNueva bit = 0,
	@OrigenPedidoWeb int = 0
AS	
BEGIN
			--ajuste del id:showroom
	if( (select descripcionEstrategia from tipoestrategia where tipoestrategiaid =@TipoOfertaSisID) ='ShowRoom')
	begin
		set @TipoOfertaSisID = 1707
	end
	--

	declare @existe int = 0
	if @EskitNueva = 1
	begin
		select @existe = count(1)
		from dbo.PedidoWebDetalle
		where ConsultoraID = @ConsultoraID and CampaniaID = @CampaniaID and eskitNueva = 1

		set @existe = isnull(@existe, 0)
	end
	
	if (@existe = 0 and @EskitNueva = 1) or @EskitNueva = 0
	begin
		 
			declare @orden int = 0

			SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
				, @orden = max(ISNULL(OrdenPedidoWD,0))
			FROM dbo.PedidoWebDetalle 
			WHERE 
				CampaniaID = @CampaniaID
				AND PedidoID = @PedidoID
	
			SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
			SET @orden = ISNULL(@orden, 0) + 1

			SET @TipoEstrategiaID = ISNULL(@TipoEstrategiaID, 0)

			INSERT INTO dbo.PedidoWebDetalle 
			(
				CampaniaID, PedidoID, PedidoDetalleID, MarcaID, ConsultoraID, ClienteID, Cantidad, PrecioUnidad, 
				ImporteTotal, CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, TipoOfertaSisID, 
				CodigoUsuarioCreacion, FechaCreacion, SubTipoOfertaSisID, EsSugerido, EskitNueva, OrdenPedidoWD, OrigenPedidoWeb,
				TipoEstrategiaID
			)
			VALUES 
			(
				@CampaniaID, @PedidoID, @PedidoDetalleID, @MarcaID, @ConsultoraID, @ClienteID, @Cantidad, @PrecioUnidad, 
				@Cantidad*@PrecioUnidad, @CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, @TipoOfertaSisID, 
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(),@SubTipoOfertaSisID, @EsSugerido, @EskitNueva, @orden, @OrigenPedidoWeb,
				@TipoEstrategiaID
			)

	END

END


GO



use BelcorpGuatemala
Go
IF (OBJECT_ID('dbo.InsPedidoWebDetalle_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsPedidoWebDetalle_SB2 AS SET NOCOUNT ON;')
GO


ALTER PROCEDURE [dbo].[InsPedidoWebDetalle_SB2]
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
	@TipoEstrategiaID INT = 0,
	@TipoOfertaSisID int,
	@PedidoDetalleID smallint output,
	@CodigoUsuarioCreacion varchar(25) = null,
	@SubTipoOfertaSisID smallint = null,
	@EsSugerido bit,
	@EskitNueva bit = 0,
	@OrigenPedidoWeb int = 0
AS	
BEGIN
			--ajuste del id:showroom
	if( (select descripcionEstrategia from tipoestrategia where tipoestrategiaid =@TipoOfertaSisID) ='ShowRoom')
	begin
		set @TipoOfertaSisID = 1707
	end
	--

	declare @existe int = 0
	if @EskitNueva = 1
	begin
		select @existe = count(1)
		from dbo.PedidoWebDetalle
		where ConsultoraID = @ConsultoraID and CampaniaID = @CampaniaID and eskitNueva = 1

		set @existe = isnull(@existe, 0)
	end
	
	if (@existe = 0 and @EskitNueva = 1) or @EskitNueva = 0
	begin
		 
			declare @orden int = 0

			SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
				, @orden = max(ISNULL(OrdenPedidoWD,0))
			FROM dbo.PedidoWebDetalle 
			WHERE 
				CampaniaID = @CampaniaID
				AND PedidoID = @PedidoID
	
			SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
			SET @orden = ISNULL(@orden, 0) + 1

			SET @TipoEstrategiaID = ISNULL(@TipoEstrategiaID, 0)

			INSERT INTO dbo.PedidoWebDetalle 
			(
				CampaniaID, PedidoID, PedidoDetalleID, MarcaID, ConsultoraID, ClienteID, Cantidad, PrecioUnidad, 
				ImporteTotal, CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, TipoOfertaSisID, 
				CodigoUsuarioCreacion, FechaCreacion, SubTipoOfertaSisID, EsSugerido, EskitNueva, OrdenPedidoWD, OrigenPedidoWeb,
				TipoEstrategiaID
			)
			VALUES 
			(
				@CampaniaID, @PedidoID, @PedidoDetalleID, @MarcaID, @ConsultoraID, @ClienteID, @Cantidad, @PrecioUnidad, 
				@Cantidad*@PrecioUnidad, @CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, @TipoOfertaSisID, 
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(),@SubTipoOfertaSisID, @EsSugerido, @EskitNueva, @orden, @OrigenPedidoWeb,
				@TipoEstrategiaID
			)

	END

END


GO


use BelcorpMexico
Go

IF (OBJECT_ID('dbo.InsPedidoWebDetalle_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsPedidoWebDetalle_SB2 AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[InsPedidoWebDetalle_SB2]
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
	@TipoEstrategiaID INT = 0,
	@TipoOfertaSisID int,
	@PedidoDetalleID smallint output,
	@CodigoUsuarioCreacion varchar(25) = null,
	@SubTipoOfertaSisID smallint = null,
	@EsSugerido bit,
	@EskitNueva bit = 0,
	@OrigenPedidoWeb int = 0
AS	
BEGIN
			--ajuste del id:showroom
	if( (select descripcionEstrategia from tipoestrategia where tipoestrategiaid =@TipoOfertaSisID) ='ShowRoom')
	begin
		set @TipoOfertaSisID = 1707
	end
	--

	declare @existe int = 0
	if @EskitNueva = 1
	begin
		select @existe = count(1)
		from dbo.PedidoWebDetalle
		where ConsultoraID = @ConsultoraID and CampaniaID = @CampaniaID and eskitNueva = 1

		set @existe = isnull(@existe, 0)
	end
	
	if (@existe = 0 and @EskitNueva = 1) or @EskitNueva = 0
	begin
		 
			declare @orden int = 0

			SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
				, @orden = max(ISNULL(OrdenPedidoWD,0))
			FROM dbo.PedidoWebDetalle 
			WHERE 
				CampaniaID = @CampaniaID
				AND PedidoID = @PedidoID
	
			SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
			SET @orden = ISNULL(@orden, 0) + 1

			SET @TipoEstrategiaID = ISNULL(@TipoEstrategiaID, 0)

			INSERT INTO dbo.PedidoWebDetalle 
			(
				CampaniaID, PedidoID, PedidoDetalleID, MarcaID, ConsultoraID, ClienteID, Cantidad, PrecioUnidad, 
				ImporteTotal, CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, TipoOfertaSisID, 
				CodigoUsuarioCreacion, FechaCreacion, SubTipoOfertaSisID, EsSugerido, EskitNueva, OrdenPedidoWD, OrigenPedidoWeb,
				TipoEstrategiaID
			)
			VALUES 
			(
				@CampaniaID, @PedidoID, @PedidoDetalleID, @MarcaID, @ConsultoraID, @ClienteID, @Cantidad, @PrecioUnidad, 
				@Cantidad*@PrecioUnidad, @CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, @TipoOfertaSisID, 
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(),@SubTipoOfertaSisID, @EsSugerido, @EskitNueva, @orden, @OrigenPedidoWeb,
				@TipoEstrategiaID
			)

	END

END


GO


use BelcorpPanama
Go
IF (OBJECT_ID('dbo.InsPedidoWebDetalle_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsPedidoWebDetalle_SB2 AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[InsPedidoWebDetalle_SB2]
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
	@TipoEstrategiaID INT = 0,
	@TipoOfertaSisID int,
	@PedidoDetalleID smallint output,
	@CodigoUsuarioCreacion varchar(25) = null,
	@SubTipoOfertaSisID smallint = null,
	@EsSugerido bit,
	@EskitNueva bit = 0,
	@OrigenPedidoWeb int = 0
AS	
BEGIN
			--ajuste del id:showroom
	if( (select descripcionEstrategia from tipoestrategia where tipoestrategiaid =@TipoOfertaSisID) ='ShowRoom')
	begin
		set @TipoOfertaSisID = 1707
	end
	--

	declare @existe int = 0
	if @EskitNueva = 1
	begin
		select @existe = count(1)
		from dbo.PedidoWebDetalle
		where ConsultoraID = @ConsultoraID and CampaniaID = @CampaniaID and eskitNueva = 1

		set @existe = isnull(@existe, 0)
	end
	
	if (@existe = 0 and @EskitNueva = 1) or @EskitNueva = 0
	begin
		 
			declare @orden int = 0

			SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
				, @orden = max(ISNULL(OrdenPedidoWD,0))
			FROM dbo.PedidoWebDetalle 
			WHERE 
				CampaniaID = @CampaniaID
				AND PedidoID = @PedidoID
	
			SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
			SET @orden = ISNULL(@orden, 0) + 1

			SET @TipoEstrategiaID = ISNULL(@TipoEstrategiaID, 0)

			INSERT INTO dbo.PedidoWebDetalle 
			(
				CampaniaID, PedidoID, PedidoDetalleID, MarcaID, ConsultoraID, ClienteID, Cantidad, PrecioUnidad, 
				ImporteTotal, CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, TipoOfertaSisID, 
				CodigoUsuarioCreacion, FechaCreacion, SubTipoOfertaSisID, EsSugerido, EskitNueva, OrdenPedidoWD, OrigenPedidoWeb,
				TipoEstrategiaID
			)
			VALUES 
			(
				@CampaniaID, @PedidoID, @PedidoDetalleID, @MarcaID, @ConsultoraID, @ClienteID, @Cantidad, @PrecioUnidad, 
				@Cantidad*@PrecioUnidad, @CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, @TipoOfertaSisID, 
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(),@SubTipoOfertaSisID, @EsSugerido, @EskitNueva, @orden, @OrigenPedidoWeb,
				@TipoEstrategiaID
			)

	END

END


GO


use BelcorpPeru
Go
IF (OBJECT_ID('dbo.InsPedidoWebDetalle_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsPedidoWebDetalle_SB2 AS SET NOCOUNT ON;')
GO



ALTER PROCEDURE [dbo].[InsPedidoWebDetalle_SB2]
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
	@TipoEstrategiaID INT = 0,
	@TipoOfertaSisID int,
	@PedidoDetalleID smallint output,
	@CodigoUsuarioCreacion varchar(25) = null,
	@SubTipoOfertaSisID smallint = null,
	@EsSugerido bit,
	@EskitNueva bit = 0,
	@OrigenPedidoWeb int = 0
AS	
BEGIN
			--ajuste del id:showroom
	if( (select descripcionEstrategia from tipoestrategia where tipoestrategiaid =@TipoOfertaSisID) ='ShowRoom')
	begin
		set @TipoOfertaSisID = 1707
	end
	--

	declare @existe int = 0
	if @EskitNueva = 1
	begin
		select @existe = count(1)
		from dbo.PedidoWebDetalle
		where ConsultoraID = @ConsultoraID and CampaniaID = @CampaniaID and eskitNueva = 1

		set @existe = isnull(@existe, 0)
	end
	
	if (@existe = 0 and @EskitNueva = 1) or @EskitNueva = 0
	begin
		 
			declare @orden int = 0

			SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
				, @orden = max(ISNULL(OrdenPedidoWD,0))
			FROM dbo.PedidoWebDetalle 
			WHERE 
				CampaniaID = @CampaniaID
				AND PedidoID = @PedidoID
	
			SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
			SET @orden = ISNULL(@orden, 0) + 1

			SET @TipoEstrategiaID = ISNULL(@TipoEstrategiaID, 0)

			INSERT INTO dbo.PedidoWebDetalle 
			(
				CampaniaID, PedidoID, PedidoDetalleID, MarcaID, ConsultoraID, ClienteID, Cantidad, PrecioUnidad, 
				ImporteTotal, CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, TipoOfertaSisID, 
				CodigoUsuarioCreacion, FechaCreacion, SubTipoOfertaSisID, EsSugerido, EskitNueva, OrdenPedidoWD, OrigenPedidoWeb,
				TipoEstrategiaID
			)
			VALUES 
			(
				@CampaniaID, @PedidoID, @PedidoDetalleID, @MarcaID, @ConsultoraID, @ClienteID, @Cantidad, @PrecioUnidad, 
				@Cantidad*@PrecioUnidad, @CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, @TipoOfertaSisID, 
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(),@SubTipoOfertaSisID, @EsSugerido, @EskitNueva, @orden, @OrigenPedidoWeb,
				@TipoEstrategiaID
			)

	END

END


GO


use BelcorpPuertoRico
Go

IF (OBJECT_ID('dbo.InsPedidoWebDetalle_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsPedidoWebDetalle_SB2 AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[InsPedidoWebDetalle_SB2]
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
	@TipoEstrategiaID INT = 0,
	@TipoOfertaSisID int,
	@PedidoDetalleID smallint output,
	@CodigoUsuarioCreacion varchar(25) = null,
	@SubTipoOfertaSisID smallint = null,
	@EsSugerido bit,
	@EskitNueva bit = 0,
	@OrigenPedidoWeb int = 0
AS	
BEGIN
			--ajuste del id:showroom
	if( (select descripcionEstrategia from tipoestrategia where tipoestrategiaid =@TipoOfertaSisID) ='ShowRoom')
	begin
		set @TipoOfertaSisID = 1707
	end
	--

	declare @existe int = 0
	if @EskitNueva = 1
	begin
		select @existe = count(1)
		from dbo.PedidoWebDetalle
		where ConsultoraID = @ConsultoraID and CampaniaID = @CampaniaID and eskitNueva = 1

		set @existe = isnull(@existe, 0)
	end
	
	if (@existe = 0 and @EskitNueva = 1) or @EskitNueva = 0
	begin
		 
			declare @orden int = 0

			SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
				, @orden = max(ISNULL(OrdenPedidoWD,0))
			FROM dbo.PedidoWebDetalle 
			WHERE 
				CampaniaID = @CampaniaID
				AND PedidoID = @PedidoID
	
			SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
			SET @orden = ISNULL(@orden, 0) + 1

			SET @TipoEstrategiaID = ISNULL(@TipoEstrategiaID, 0)

			INSERT INTO dbo.PedidoWebDetalle 
			(
				CampaniaID, PedidoID, PedidoDetalleID, MarcaID, ConsultoraID, ClienteID, Cantidad, PrecioUnidad, 
				ImporteTotal, CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, TipoOfertaSisID, 
				CodigoUsuarioCreacion, FechaCreacion, SubTipoOfertaSisID, EsSugerido, EskitNueva, OrdenPedidoWD, OrigenPedidoWeb,
				TipoEstrategiaID
			)
			VALUES 
			(
				@CampaniaID, @PedidoID, @PedidoDetalleID, @MarcaID, @ConsultoraID, @ClienteID, @Cantidad, @PrecioUnidad, 
				@Cantidad*@PrecioUnidad, @CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, @TipoOfertaSisID, 
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(),@SubTipoOfertaSisID, @EsSugerido, @EskitNueva, @orden, @OrigenPedidoWeb,
				@TipoEstrategiaID
			)

	END

END


GO



use BelcorpSalvador
Go
IF (OBJECT_ID('dbo.InsPedidoWebDetalle_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsPedidoWebDetalle_SB2 AS SET NOCOUNT ON;')
GO



ALTER PROCEDURE [dbo].[InsPedidoWebDetalle_SB2]
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
	@TipoEstrategiaID INT = 0,
	@TipoOfertaSisID int,
	@PedidoDetalleID smallint output,
	@CodigoUsuarioCreacion varchar(25) = null,
	@SubTipoOfertaSisID smallint = null,
	@EsSugerido bit,
	@EskitNueva bit = 0,
	@OrigenPedidoWeb int = 0
AS	
BEGIN
			--ajuste del id:showroom
	if( (select descripcionEstrategia from tipoestrategia where tipoestrategiaid =@TipoOfertaSisID) ='ShowRoom')
	begin
		set @TipoOfertaSisID = 1707
	end
	--

	declare @existe int = 0
	if @EskitNueva = 1
	begin
		select @existe = count(1)
		from dbo.PedidoWebDetalle
		where ConsultoraID = @ConsultoraID and CampaniaID = @CampaniaID and eskitNueva = 1

		set @existe = isnull(@existe, 0)
	end
	
	if (@existe = 0 and @EskitNueva = 1) or @EskitNueva = 0
	begin
		 
			declare @orden int = 0

			SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
				, @orden = max(ISNULL(OrdenPedidoWD,0))
			FROM dbo.PedidoWebDetalle 
			WHERE 
				CampaniaID = @CampaniaID
				AND PedidoID = @PedidoID
	
			SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
			SET @orden = ISNULL(@orden, 0) + 1

			SET @TipoEstrategiaID = ISNULL(@TipoEstrategiaID, 0)

			INSERT INTO dbo.PedidoWebDetalle 
			(
				CampaniaID, PedidoID, PedidoDetalleID, MarcaID, ConsultoraID, ClienteID, Cantidad, PrecioUnidad, 
				ImporteTotal, CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, TipoOfertaSisID, 
				CodigoUsuarioCreacion, FechaCreacion, SubTipoOfertaSisID, EsSugerido, EskitNueva, OrdenPedidoWD, OrigenPedidoWeb,
				TipoEstrategiaID
			)
			VALUES 
			(
				@CampaniaID, @PedidoID, @PedidoDetalleID, @MarcaID, @ConsultoraID, @ClienteID, @Cantidad, @PrecioUnidad, 
				@Cantidad*@PrecioUnidad, @CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, @TipoOfertaSisID, 
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(),@SubTipoOfertaSisID, @EsSugerido, @EskitNueva, @orden, @OrigenPedidoWeb,
				@TipoEstrategiaID
			)

	END

END


GO


USE BelcorpVenezuela
GO


ALTER PROCEDURE [dbo].[InsPedidoWebDetalle_SB2]
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
	@TipoEstrategiaID INT = 0,
	@TipoOfertaSisID int,
	@PedidoDetalleID smallint output,
	@CodigoUsuarioCreacion varchar(25) = null,
	@SubTipoOfertaSisID smallint = null,
	@EsSugerido bit,
	@EskitNueva bit = 0,
	@OrigenPedidoWeb int = 0
AS	
BEGIN

		--ajuste del id:showroom
	if( (select descripcionEstrategia from tipoestrategia where tipoestrategiaid =@TipoOfertaSisID) ='ShowRoom')
	begin
		set @TipoOfertaSisID = 1707
	end
	--
	
	declare @existe int = 0
	if @EskitNueva = 1
	begin
		select @existe = count(1)
		from dbo.PedidoWebDetalle
		where ConsultoraID = @ConsultoraID and CampaniaID = @CampaniaID and eskitNueva = 1

		set @existe = isnull(@existe, 0)
	end
	
	if (@existe = 0 and @EskitNueva = 1) or @EskitNueva = 0
	begin
		 
			declare @orden int = 0

			SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
				, @orden = max(ISNULL(OrdenPedidoWD,0))
			FROM dbo.PedidoWebDetalle 
			WHERE 
				CampaniaID = @CampaniaID
				AND PedidoID = @PedidoID
	
			SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
			SET @orden = ISNULL(@orden, 0) + 1

			SET @TipoEstrategiaID = ISNULL(@TipoEstrategiaID, 0)

			INSERT INTO dbo.PedidoWebDetalle 
			(
				CampaniaID, PedidoID, PedidoDetalleID, MarcaID, ConsultoraID, ClienteID, Cantidad, PrecioUnidad, 
				ImporteTotal, CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, TipoOfertaSisID, 
				CodigoUsuarioCreacion, FechaCreacion, SubTipoOfertaSisID, EsSugerido, EskitNueva, OrdenPedidoWD, OrigenPedidoWeb,
				TipoEstrategiaID
			)
			VALUES 
			(
				@CampaniaID, @PedidoID, @PedidoDetalleID, @MarcaID, @ConsultoraID, @ClienteID, @Cantidad, @PrecioUnidad, 
				@Cantidad*@PrecioUnidad, @CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, @TipoOfertaSisID, 
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(),@SubTipoOfertaSisID, @EsSugerido, @EskitNueva, @orden, @OrigenPedidoWeb,
				@TipoEstrategiaID
			)

	END

END


GO