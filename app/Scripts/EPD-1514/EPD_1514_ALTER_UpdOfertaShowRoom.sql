
USE BelcorpBolivia
GO

ALTER PROCEDURE [ShowRoom].[UpdOfertaShowRoom]

(

	@TipoOfertaSisID int,

	@CampaniaID int,

	@CUV varchar(20),

	@Descripcion varchar(250),

	@ImagenProducto varchar(150),

	@UnidadesPermitidas int,

	@FlagHabilitarProducto int,

	@Orden int,

	@DescripcionLegal varchar(250),

	@UsuarioModificacion varchar(50),

	@PrecioOferta decimal(18,2),

	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int

)

AS

BEGIN

	UPDATE ShowRoom.OfertaShowRoom

		SET Descripcion = @Descripcion,

			UnidadesPermitidas = @UnidadesPermitidas,

			FlagHabilitarProducto = @FlagHabilitarProducto,

			Orden = @Orden,

			ImagenProducto = @ImagenProducto,

			DescripcionLegal = @DescripcionLegal,

			UsuarioModificacion = @UsuarioModificacion,

			PrecioOferta = @PrecioOferta,

			FechaModificacion = getdate(),

			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END)

	where 

		CampaniaID = @CampaniaID

		AND CUV = @CUV

END

GO

/*end*/

USE BelcorpChile
GO

ALTER PROCEDURE [ShowRoom].[UpdOfertaShowRoom]
(
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(250),
	@ImagenProducto varchar(150),
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@Orden int,
	@DescripcionLegal varchar(250),
	@UsuarioModificacion varchar(50),
	@PrecioOferta decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int
)
AS
BEGIN
	UPDATE ShowRoom.OfertaShowRoom
		SET Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto =@FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @UsuarioModificacion,
			PrecioOferta = @PrecioOferta,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END)
	where 
		CampaniaID = @CampaniaID
		AND CUV = @CUV
END

GO
/*end*/


USE BelcorpColombia
GO

ALTER PROCEDURE [ShowRoom].[UpdOfertaShowRoom]
(
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(250),
	@ImagenProducto varchar(150),
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@Orden int,
	@DescripcionLegal varchar(250),
	@UsuarioModificacion varchar(50),
	@PrecioOferta decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int
)
AS
BEGIN
	UPDATE ShowRoom.OfertaShowRoom
		SET Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @UsuarioModificacion,
			PrecioOferta = @PrecioOferta,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END)
	where 
		CampaniaID = @CampaniaID
		AND CUV = @CUV
END

GO

/*end*/

USE BelcorpCostaRica
GO


ALTER PROCEDURE [ShowRoom].[UpdOfertaShowRoom]

(

	@TipoOfertaSisID int,

	@CampaniaID int,

	@CUV varchar(20),

	@Descripcion varchar(250),

	@ImagenProducto varchar(150),

	@UnidadesPermitidas int,

	@FlagHabilitarProducto int,

	@Orden int,

	@DescripcionLegal varchar(250),

	@UsuarioModificacion varchar(50),

	@PrecioOferta decimal(18,2),

	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int

)

AS

BEGIN

	UPDATE ShowRoom.OfertaShowRoom

		SET Descripcion = @Descripcion,

			UnidadesPermitidas = @UnidadesPermitidas,

			FlagHabilitarProducto = @FlagHabilitarProducto,

			Orden = @Orden,

			ImagenProducto = @ImagenProducto,

			DescripcionLegal = @DescripcionLegal,

			UsuarioModificacion = @UsuarioModificacion,

			PrecioOferta = @PrecioOferta,

			FechaModificacion = getdate(),

			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END)

	where 

		CampaniaID = @CampaniaID

		AND CUV = @CUV

END

GO

/*end*/

USE BelcorpDominicana
GO

ALTER PROCEDURE [ShowRoom].[UpdOfertaShowRoom]

(

	@TipoOfertaSisID int,

	@CampaniaID int,

	@CUV varchar(20),

	@Descripcion varchar(250),

	@ImagenProducto varchar(150),

	@UnidadesPermitidas int,

	@FlagHabilitarProducto int,

	@Orden int,

	@DescripcionLegal varchar(250),

	@UsuarioModificacion varchar(50),

	@PrecioOferta decimal(18,2),

	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int

)

AS

BEGIN

	UPDATE ShowRoom.OfertaShowRoom

		SET Descripcion = @Descripcion,

			UnidadesPermitidas = @UnidadesPermitidas,

			FlagHabilitarProducto = @FlagHabilitarProducto,

			Orden = @Orden,

			ImagenProducto = @ImagenProducto,

			DescripcionLegal = @DescripcionLegal,

			UsuarioModificacion = @UsuarioModificacion,

			PrecioOferta = @PrecioOferta,

			FechaModificacion = getdate(),

			ImagenMini = @ImagenMini,

			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END)

	where 

		CampaniaID = @CampaniaID

		AND CUV = @CUV

END

GO

/*end*/

USE BelcorpEcuador
GO


ALTER PROCEDURE [ShowRoom].[UpdOfertaShowRoom]

(

	@TipoOfertaSisID int,

	@CampaniaID int,

	@CUV varchar(20),

	@Descripcion varchar(250),

	@ImagenProducto varchar(150),

	@UnidadesPermitidas int,

	@FlagHabilitarProducto int,

	@Orden int,

	@DescripcionLegal varchar(250),

	@UsuarioModificacion varchar(50),

	@PrecioOferta decimal(18,2),

	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int

)

AS

BEGIN

	UPDATE ShowRoom.OfertaShowRoom

		SET Descripcion = @Descripcion,

			UnidadesPermitidas = @UnidadesPermitidas,

			FlagHabilitarProducto = @FlagHabilitarProducto,

			Orden = @Orden,

			ImagenProducto = @ImagenProducto,

			DescripcionLegal = @DescripcionLegal,

			UsuarioModificacion = @UsuarioModificacion,

			PrecioOferta = @PrecioOferta,

			FechaModificacion = getdate(),

			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END)

	where 

		CampaniaID = @CampaniaID

		AND CUV = @CUV

END

GO

/*end*/

USE BelcorpGuatemala
GO


ALTER PROCEDURE [ShowRoom].[UpdOfertaShowRoom]

(

	@TipoOfertaSisID int,

	@CampaniaID int,

	@CUV varchar(20),

	@Descripcion varchar(250),

	@ImagenProducto varchar(150),

	@UnidadesPermitidas int,

	@FlagHabilitarProducto int,

	@Orden int,

	@DescripcionLegal varchar(250),

	@UsuarioModificacion varchar(50),

	@PrecioOferta decimal(18,2),

	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int

)

AS

BEGIN

	UPDATE ShowRoom.OfertaShowRoom

		SET Descripcion = @Descripcion,

			UnidadesPermitidas = @UnidadesPermitidas,

			FlagHabilitarProducto = @FlagHabilitarProducto,

			Orden = @Orden,

			ImagenProducto = @ImagenProducto,

			DescripcionLegal = @DescripcionLegal,

			UsuarioModificacion = @UsuarioModificacion,

			PrecioOferta = @PrecioOferta,

			FechaModificacion = getdate(),

			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END)

	where 

		CampaniaID = @CampaniaID

		AND CUV = @CUV

END

GO

/*end*/

USE BelcorpMexico
GO


ALTER PROCEDURE [ShowRoom].[UpdOfertaShowRoom]

(

	@TipoOfertaSisID int,

	@CampaniaID int,

	@CUV varchar(20),

	@Descripcion varchar(250),

	@ImagenProducto varchar(150),

	@UnidadesPermitidas int,

	@FlagHabilitarProducto int,

	@Orden int,

	@DescripcionLegal varchar(250),

	@UsuarioModificacion varchar(50),

	@PrecioOferta decimal(18,2),

	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int

)

AS

BEGIN

	UPDATE ShowRoom.OfertaShowRoom

		SET Descripcion = @Descripcion,

			UnidadesPermitidas = @UnidadesPermitidas,

			FlagHabilitarProducto = @FlagHabilitarProducto,

			Orden = @Orden,

			ImagenProducto = @ImagenProducto,

			DescripcionLegal = @DescripcionLegal,

			UsuarioModificacion = @UsuarioModificacion,

			PrecioOferta = @PrecioOferta,

			FechaModificacion = getdate(),

			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END)

	where 

		CampaniaID = @CampaniaID

		AND CUV = @CUV

END

GO

/*end*/


USE BelcorpPanama
GO

ALTER PROCEDURE [ShowRoom].[UpdOfertaShowRoom]

(

	@TipoOfertaSisID int,

	@CampaniaID int,

	@CUV varchar(20),

	@Descripcion varchar(250),

	@ImagenProducto varchar(150),

	@UnidadesPermitidas int,

	@FlagHabilitarProducto int,

	@Orden int,

	@DescripcionLegal varchar(250),

	@UsuarioModificacion varchar(50),

	@PrecioOferta decimal(18,2),

	@ImagenMini varchar(150),

	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int

)

AS

BEGIN

	UPDATE ShowRoom.OfertaShowRoom

		SET Descripcion = @Descripcion,

			UnidadesPermitidas = @UnidadesPermitidas,

			FlagHabilitarProducto = @FlagHabilitarProducto,

			Orden = @Orden,

			ImagenProducto = @ImagenProducto,

			DescripcionLegal = @DescripcionLegal,

			UsuarioModificacion = @UsuarioModificacion,

			PrecioOferta = @PrecioOferta,

			FechaModificacion = getdate(),

			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END)

	where 

		CampaniaID = @CampaniaID

		AND CUV = @CUV

END

GO

/*end*/


USE BelcorpPeru
GO

ALTER PROCEDURE [ShowRoom].[UpdOfertaShowRoom]

(

	@TipoOfertaSisID int,

	@CampaniaID int,

	@CUV varchar(20),

	@Descripcion varchar(250),

	@ImagenProducto varchar(150),

	@UnidadesPermitidas int,

	@FlagHabilitarProducto int,

	@Orden int,

	@DescripcionLegal varchar(250),

	@UsuarioModificacion varchar(50),

	@PrecioOferta decimal(18,2),

	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int

)

AS

BEGIN

	UPDATE ShowRoom.OfertaShowRoom

		SET Descripcion = @Descripcion,

			UnidadesPermitidas = @UnidadesPermitidas,

			FlagHabilitarProducto = @FlagHabilitarProducto,

			Orden = @Orden,

			ImagenProducto = @ImagenProducto,

			DescripcionLegal = @DescripcionLegal,

			UsuarioModificacion = @UsuarioModificacion,

			PrecioOferta = @PrecioOferta,

			FechaModificacion = getdate(),

			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END)

	where 

		CampaniaID = @CampaniaID

		AND CUV = @CUV

END

GO

/*end*/

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [ShowRoom].[UpdOfertaShowRoom]

(

	@TipoOfertaSisID int,

	@CampaniaID int,

	@CUV varchar(20),

	@Descripcion varchar(250),

	@ImagenProducto varchar(150),

	@UnidadesPermitidas int,

	@FlagHabilitarProducto int,

	@Orden int,

	@DescripcionLegal varchar(250),

	@UsuarioModificacion varchar(50),

	@PrecioOferta decimal(18,2),

	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int

)

AS

BEGIN

	UPDATE ShowRoom.OfertaShowRoom

		SET Descripcion = @Descripcion,

			UnidadesPermitidas = @UnidadesPermitidas,

			FlagHabilitarProducto = @FlagHabilitarProducto,

			Orden = @Orden,

			ImagenProducto = @ImagenProducto,

			DescripcionLegal = @DescripcionLegal,

			UsuarioModificacion = @UsuarioModificacion,

			PrecioOferta = @PrecioOferta,

			FechaModificacion = getdate(),

			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END)

	where 

		CampaniaID = @CampaniaID

		AND CUV = @CUV

END

GO

/*end*/

USE BelcorpSalvador
GO


ALTER PROCEDURE [ShowRoom].[UpdOfertaShowRoom]

(

	@TipoOfertaSisID int,

	@CampaniaID int,

	@CUV varchar(20),

	@Descripcion varchar(250),

	@ImagenProducto varchar(150),

	@UnidadesPermitidas int,

	@FlagHabilitarProducto int,

	@Orden int,

	@DescripcionLegal varchar(250),

	@UsuarioModificacion varchar(50),

	@PrecioOferta decimal(18,2),

	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int

)

AS

BEGIN

	UPDATE ShowRoom.OfertaShowRoom

		SET Descripcion = @Descripcion,

			UnidadesPermitidas = @UnidadesPermitidas,

			FlagHabilitarProducto = @FlagHabilitarProducto,

			Orden = @Orden,

			ImagenProducto = @ImagenProducto,

			DescripcionLegal = @DescripcionLegal,

			UsuarioModificacion = @UsuarioModificacion,

			PrecioOferta = @PrecioOferta,

			FechaModificacion = getdate(),

			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END)

	where 

		CampaniaID = @CampaniaID

		AND CUV = @CUV

END

GO

/*end*/


USE BelcorpVenezuela
GO


ALTER PROCEDURE [ShowRoom].[UpdOfertaShowRoom]

(

	@TipoOfertaSisID int,

	@CampaniaID int,

	@CUV varchar(20),

	@Descripcion varchar(250),

	@ImagenProducto varchar(150),

	@UnidadesPermitidas int,

	@FlagHabilitarProducto int,

	@Orden int,

	@DescripcionLegal varchar(250),

	@UsuarioModificacion varchar(50),

	@PrecioOferta decimal(18,2),

	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int

)

AS

BEGIN

	UPDATE ShowRoom.OfertaShowRoom

		SET Descripcion = @Descripcion,

			UnidadesPermitidas = @UnidadesPermitidas,

			FlagHabilitarProducto = @FlagHabilitarProducto,

			Orden = @Orden,

			ImagenProducto = @ImagenProducto,

			DescripcionLegal = @DescripcionLegal,

			UsuarioModificacion = @UsuarioModificacion,

			PrecioOferta = @PrecioOferta,

			FechaModificacion = getdate(),

			ImagenMini = @ImagenMini,

			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END)

	where 

		CampaniaID = @CampaniaID

		AND CUV = @CUV

END


GO
