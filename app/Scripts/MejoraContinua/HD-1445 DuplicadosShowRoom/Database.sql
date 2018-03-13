USE BelcorpBolivia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsOrUpdOfertaShowRoom' AND SPECIFIC_SCHEMA = 'ShowRoom' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
END
GO
CREATE PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@Usuario varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2) = 0,
	@EsSubCampania bit
AS
BEGIN
	if not exists(select 1 from ShowRoom.OfertaShowRoom where CampaniaID = @CampaniaID and CUV = @CUV)
	begin
		INSERT INTO ShowRoom.OfertaShowRoom
		(
			CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado,
			Stock, StockInicial, ImagenProducto, Orden, UnidadesPermitidas, FlagHabilitarProducto,
			DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,	EsSubCampania
		)
		VALUES
		(
			@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado,
			0, 0, @ImagenProducto, @Orden, @UnidadesPermitidas, @FlagHabilitarProducto,
			@DescripcionLegal, @Usuario, getdate(), @ImagenMini, @PrecioOferta, @EsSubCampania
		);
	end
	else
	begin
		update ShowRoom.OfertaShowRoom
		set
			Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @Usuario,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
		 where CampaniaID = @CampaniaID and CUV = @CUV;
	end
END
GO
/*end*/

USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsOrUpdOfertaShowRoom' AND SPECIFIC_SCHEMA = 'ShowRoom' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
END
GO
CREATE PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@Usuario varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2) = 0,
	@EsSubCampania bit
AS
BEGIN
	if not exists(select 1 from ShowRoom.OfertaShowRoom where CampaniaID = @CampaniaID and CUV = @CUV)
	begin
		INSERT INTO ShowRoom.OfertaShowRoom
		(
			CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado,
			Stock, StockInicial, ImagenProducto, Orden, UnidadesPermitidas, FlagHabilitarProducto,
			DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,	EsSubCampania
		)
		VALUES
		(
			@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado,
			0, 0, @ImagenProducto, @Orden, @UnidadesPermitidas, @FlagHabilitarProducto,
			@DescripcionLegal, @Usuario, getdate(), @ImagenMini, @PrecioOferta, @EsSubCampania
		);
	end
	else
	begin
		update ShowRoom.OfertaShowRoom
		set
			Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @Usuario,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
		 where CampaniaID = @CampaniaID and CUV = @CUV;
	end
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsOrUpdOfertaShowRoom' AND SPECIFIC_SCHEMA = 'ShowRoom' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
END
GO
CREATE PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@Usuario varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2) = 0,
	@EsSubCampania bit
AS
BEGIN
	if not exists(select 1 from ShowRoom.OfertaShowRoom where CampaniaID = @CampaniaID and CUV = @CUV)
	begin
		INSERT INTO ShowRoom.OfertaShowRoom
		(
			CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado,
			Stock, StockInicial, ImagenProducto, Orden, UnidadesPermitidas, FlagHabilitarProducto,
			DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,	EsSubCampania
		)
		VALUES
		(
			@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado,
			0, 0, @ImagenProducto, @Orden, @UnidadesPermitidas, @FlagHabilitarProducto,
			@DescripcionLegal, @Usuario, getdate(), @ImagenMini, @PrecioOferta, @EsSubCampania
		);
	end
	else
	begin
		update ShowRoom.OfertaShowRoom
		set
			Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @Usuario,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
		 where CampaniaID = @CampaniaID and CUV = @CUV;
	end
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsOrUpdOfertaShowRoom' AND SPECIFIC_SCHEMA = 'ShowRoom' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
END
GO
CREATE PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@Usuario varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2) = 0,
	@EsSubCampania bit
AS
BEGIN
	if not exists(select 1 from ShowRoom.OfertaShowRoom where CampaniaID = @CampaniaID and CUV = @CUV)
	begin
		INSERT INTO ShowRoom.OfertaShowRoom
		(
			CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado,
			Stock, StockInicial, ImagenProducto, Orden, UnidadesPermitidas, FlagHabilitarProducto,
			DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,	EsSubCampania
		)
		VALUES
		(
			@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado,
			0, 0, @ImagenProducto, @Orden, @UnidadesPermitidas, @FlagHabilitarProducto,
			@DescripcionLegal, @Usuario, getdate(), @ImagenMini, @PrecioOferta, @EsSubCampania
		);
	end
	else
	begin
		update ShowRoom.OfertaShowRoom
		set
			Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @Usuario,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
		 where CampaniaID = @CampaniaID and CUV = @CUV;
	end
END
GO
/*end*/

USE BelcorpDominicana
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsOrUpdOfertaShowRoom' AND SPECIFIC_SCHEMA = 'ShowRoom' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
END
GO
CREATE PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@Usuario varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2) = 0,
	@EsSubCampania bit
AS
BEGIN
	if not exists(select 1 from ShowRoom.OfertaShowRoom where CampaniaID = @CampaniaID and CUV = @CUV)
	begin
		INSERT INTO ShowRoom.OfertaShowRoom
		(
			CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado,
			Stock, StockInicial, ImagenProducto, Orden, UnidadesPermitidas, FlagHabilitarProducto,
			DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,	EsSubCampania
		)
		VALUES
		(
			@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado,
			0, 0, @ImagenProducto, @Orden, @UnidadesPermitidas, @FlagHabilitarProducto,
			@DescripcionLegal, @Usuario, getdate(), @ImagenMini, @PrecioOferta, @EsSubCampania
		);
	end
	else
	begin
		update ShowRoom.OfertaShowRoom
		set
			Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @Usuario,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
		 where CampaniaID = @CampaniaID and CUV = @CUV;
	end
END
GO
/*end*/

USE BelcorpEcuador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsOrUpdOfertaShowRoom' AND SPECIFIC_SCHEMA = 'ShowRoom' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
END
GO
CREATE PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@Usuario varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2) = 0,
	@EsSubCampania bit
AS
BEGIN
	if not exists(select 1 from ShowRoom.OfertaShowRoom where CampaniaID = @CampaniaID and CUV = @CUV)
	begin
		INSERT INTO ShowRoom.OfertaShowRoom
		(
			CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado,
			Stock, StockInicial, ImagenProducto, Orden, UnidadesPermitidas, FlagHabilitarProducto,
			DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,	EsSubCampania
		)
		VALUES
		(
			@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado,
			0, 0, @ImagenProducto, @Orden, @UnidadesPermitidas, @FlagHabilitarProducto,
			@DescripcionLegal, @Usuario, getdate(), @ImagenMini, @PrecioOferta, @EsSubCampania
		);
	end
	else
	begin
		update ShowRoom.OfertaShowRoom
		set
			Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @Usuario,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
		 where CampaniaID = @CampaniaID and CUV = @CUV;
	end
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsOrUpdOfertaShowRoom' AND SPECIFIC_SCHEMA = 'ShowRoom' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
END
GO
CREATE PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@Usuario varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2) = 0,
	@EsSubCampania bit
AS
BEGIN
	if not exists(select 1 from ShowRoom.OfertaShowRoom where CampaniaID = @CampaniaID and CUV = @CUV)
	begin
		INSERT INTO ShowRoom.OfertaShowRoom
		(
			CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado,
			Stock, StockInicial, ImagenProducto, Orden, UnidadesPermitidas, FlagHabilitarProducto,
			DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,	EsSubCampania
		)
		VALUES
		(
			@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado,
			0, 0, @ImagenProducto, @Orden, @UnidadesPermitidas, @FlagHabilitarProducto,
			@DescripcionLegal, @Usuario, getdate(), @ImagenMini, @PrecioOferta, @EsSubCampania
		);
	end
	else
	begin
		update ShowRoom.OfertaShowRoom
		set
			Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @Usuario,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
		 where CampaniaID = @CampaniaID and CUV = @CUV;
	end
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsOrUpdOfertaShowRoom' AND SPECIFIC_SCHEMA = 'ShowRoom' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
END
GO
CREATE PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@Usuario varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2) = 0,
	@EsSubCampania bit
AS
BEGIN
	if not exists(select 1 from ShowRoom.OfertaShowRoom where CampaniaID = @CampaniaID and CUV = @CUV)
	begin
		INSERT INTO ShowRoom.OfertaShowRoom
		(
			CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado,
			Stock, StockInicial, ImagenProducto, Orden, UnidadesPermitidas, FlagHabilitarProducto,
			DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,	EsSubCampania
		)
		VALUES
		(
			@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado,
			0, 0, @ImagenProducto, @Orden, @UnidadesPermitidas, @FlagHabilitarProducto,
			@DescripcionLegal, @Usuario, getdate(), @ImagenMini, @PrecioOferta, @EsSubCampania
		);
	end
	else
	begin
		update ShowRoom.OfertaShowRoom
		set
			Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @Usuario,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
		 where CampaniaID = @CampaniaID and CUV = @CUV;
	end
END
GO
/*end*/

USE BelcorpPanama
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsOrUpdOfertaShowRoom' AND SPECIFIC_SCHEMA = 'ShowRoom' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
END
GO
CREATE PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@Usuario varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2) = 0,
	@EsSubCampania bit
AS
BEGIN
	if not exists(select 1 from ShowRoom.OfertaShowRoom where CampaniaID = @CampaniaID and CUV = @CUV)
	begin
		INSERT INTO ShowRoom.OfertaShowRoom
		(
			CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado,
			Stock, StockInicial, ImagenProducto, Orden, UnidadesPermitidas, FlagHabilitarProducto,
			DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,	EsSubCampania
		)
		VALUES
		(
			@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado,
			0, 0, @ImagenProducto, @Orden, @UnidadesPermitidas, @FlagHabilitarProducto,
			@DescripcionLegal, @Usuario, getdate(), @ImagenMini, @PrecioOferta, @EsSubCampania
		);
	end
	else
	begin
		update ShowRoom.OfertaShowRoom
		set
			Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @Usuario,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
		 where CampaniaID = @CampaniaID and CUV = @CUV;
	end
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsOrUpdOfertaShowRoom' AND SPECIFIC_SCHEMA = 'ShowRoom' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
END
GO
CREATE PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@Usuario varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2) = 0,
	@EsSubCampania bit
AS
BEGIN
	if not exists(select 1 from ShowRoom.OfertaShowRoom where CampaniaID = @CampaniaID and CUV = @CUV)
	begin
		INSERT INTO ShowRoom.OfertaShowRoom
		(
			CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado,
			Stock, StockInicial, ImagenProducto, Orden, UnidadesPermitidas, FlagHabilitarProducto,
			DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,	EsSubCampania
		)
		VALUES
		(
			@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado,
			0, 0, @ImagenProducto, @Orden, @UnidadesPermitidas, @FlagHabilitarProducto,
			@DescripcionLegal, @Usuario, getdate(), @ImagenMini, @PrecioOferta, @EsSubCampania
		);
	end
	else
	begin
		update ShowRoom.OfertaShowRoom
		set
			Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @Usuario,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
		 where CampaniaID = @CampaniaID and CUV = @CUV;
	end
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsOrUpdOfertaShowRoom' AND SPECIFIC_SCHEMA = 'ShowRoom' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
END
GO
CREATE PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@Usuario varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2) = 0,
	@EsSubCampania bit
AS
BEGIN
	if not exists(select 1 from ShowRoom.OfertaShowRoom where CampaniaID = @CampaniaID and CUV = @CUV)
	begin
		INSERT INTO ShowRoom.OfertaShowRoom
		(
			CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado,
			Stock, StockInicial, ImagenProducto, Orden, UnidadesPermitidas, FlagHabilitarProducto,
			DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,	EsSubCampania
		)
		VALUES
		(
			@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado,
			0, 0, @ImagenProducto, @Orden, @UnidadesPermitidas, @FlagHabilitarProducto,
			@DescripcionLegal, @Usuario, getdate(), @ImagenMini, @PrecioOferta, @EsSubCampania
		);
	end
	else
	begin
		update ShowRoom.OfertaShowRoom
		set
			Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @Usuario,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
		 where CampaniaID = @CampaniaID and CUV = @CUV;
	end
END
GO
/*end*/

USE BelcorpSalvador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsOrUpdOfertaShowRoom' AND SPECIFIC_SCHEMA = 'ShowRoom' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
END
GO
CREATE PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@Usuario varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2) = 0,
	@EsSubCampania bit
AS
BEGIN
	if not exists(select 1 from ShowRoom.OfertaShowRoom where CampaniaID = @CampaniaID and CUV = @CUV)
	begin
		INSERT INTO ShowRoom.OfertaShowRoom
		(
			CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado,
			Stock, StockInicial, ImagenProducto, Orden, UnidadesPermitidas, FlagHabilitarProducto,
			DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,	EsSubCampania
		)
		VALUES
		(
			@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado,
			0, 0, @ImagenProducto, @Orden, @UnidadesPermitidas, @FlagHabilitarProducto,
			@DescripcionLegal, @Usuario, getdate(), @ImagenMini, @PrecioOferta, @EsSubCampania
		);
	end
	else
	begin
		update ShowRoom.OfertaShowRoom
		set
			Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @Usuario,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
		 where CampaniaID = @CampaniaID and CUV = @CUV;
	end
END
GO
/*end*/

USE BelcorpVenezuela
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsOrUpdOfertaShowRoom' AND SPECIFIC_SCHEMA = 'ShowRoom' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
END
GO
CREATE PROCEDURE ShowRoom.InsOrUpdOfertaShowRoom
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@Usuario varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2) = 0,
	@EsSubCampania bit
AS
BEGIN
	if not exists(select 1 from ShowRoom.OfertaShowRoom where CampaniaID = @CampaniaID and CUV = @CUV)
	begin
		INSERT INTO ShowRoom.OfertaShowRoom
		(
			CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado,
			Stock, StockInicial, ImagenProducto, Orden, UnidadesPermitidas, FlagHabilitarProducto,
			DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,	EsSubCampania
		)
		VALUES
		(
			@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado,
			0, 0, @ImagenProducto, @Orden, @UnidadesPermitidas, @FlagHabilitarProducto,
			@DescripcionLegal, @Usuario, getdate(), @ImagenMini, @PrecioOferta, @EsSubCampania
		);
	end
	else
	begin
		update ShowRoom.OfertaShowRoom
		set
			Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @Usuario,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
		 where CampaniaID = @CampaniaID and CUV = @CUV;
	end
END
GO