
USE BelcorpBolivia
GO

ALTER PROCEDURE [ShowRoom].[InsOfertaShowRoom]
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150)
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini
	)
END
GO

/*end*/

USE BelcorpChile
GO

ALTER PROCEDURE [ShowRoom].[InsOfertaShowRoom]
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150)
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini
	)
END
GO
/*end*/

USE BelcorpColombia
GO

ALTER PROCEDURE [ShowRoom].[InsOfertaShowRoom]
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150)
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini
	)
END
GO
/*end*/

USE BelcorpCostaRica
GO

ALTER PROCEDURE [ShowRoom].[InsOfertaShowRoom]
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150)
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini
	)
END
GO
/*end*/

USE BelcorpDominicana
GO

ALTER PROCEDURE [ShowRoom].[InsOfertaShowRoom]
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150)
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini
	)
END
GO
/*end*/

USE BelcorpEcuador
GO

ALTER PROCEDURE [ShowRoom].[InsOfertaShowRoom]
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150)
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini
	)
END
GO
/*end*/

USE BelcorpGuatemala
GO

ALTER PROCEDURE [ShowRoom].[InsOfertaShowRoom]
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150)
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini
	)
END
GO
/*end*/

USE BelcorpMexico
GO

ALTER PROCEDURE [ShowRoom].[InsOfertaShowRoom]
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150)
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini
	)
END
GO
/*end*/

USE BelcorpPanama
GO

ALTER PROCEDURE [ShowRoom].[InsOfertaShowRoom]
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150)
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini
	)
END
GO
/*end*/

USE BelcorpPeru
GO

ALTER PROCEDURE [ShowRoom].[InsOfertaShowRoom]
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150)
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini
	)
END
GO
/*end*/

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [ShowRoom].[InsOfertaShowRoom]
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150)
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini
	)
END
GO
/*end*/

USE BelcorpSalvador
GO

ALTER PROCEDURE [ShowRoom].[InsOfertaShowRoom]
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150)
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini
	)
END
GO
/*end*/

USE BelcorpVenezuela
GO

ALTER PROCEDURE [ShowRoom].[InsOfertaShowRoom]
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150)
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini
	)
END
GO



