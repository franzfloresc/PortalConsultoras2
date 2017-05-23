USE BelcorpBolivia
GO
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),

	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion, 	
		FechaModificacion = getdate()
		where CodigoSAP = @CodigoSAP;
GO
USE BelcorpCostaRica
GO
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),

	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion, 	
		FechaModificacion = getdate()
		where CodigoSAP = @CodigoSAP;
GO
USE BelcorpChile
GO
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),

	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion, 	
		FechaModificacion = getdate()
		where CodigoSAP = @CodigoSAP;
GO
USE BelcorpColombia
GO
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),

	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion, 	
		FechaModificacion = getdate()
		where CodigoSAP = @CodigoSAP;
GO
USE BelcorpDominicana
GO
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),

	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion, 	
		FechaModificacion = getdate()
		where CodigoSAP = @CodigoSAP;
GO
USE BelcorpEcuador
GO
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),

	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion, 	
		FechaModificacion = getdate()
		where CodigoSAP = @CodigoSAP;
GO
USE BelcorpGuatemala
GO
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),

	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion, 	
		FechaModificacion = getdate()
		where CodigoSAP = @CodigoSAP;
GO
USE BelcorpMexico
GO
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),

	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion, 	
		FechaModificacion = getdate()
		where CodigoSAP = @CodigoSAP;
GO
USE BelcorpPanama
GO
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),

	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion, 	
		FechaModificacion = getdate()
		where CodigoSAP = @CodigoSAP;
GO
USE BelcorpPeru
GO
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),

	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion, 	
		FechaModificacion = getdate()
		where CodigoSAP = @CodigoSAP;
GO
USE BelcorpPuertoRico
GO
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),

	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion, 	
		FechaModificacion = getdate()
		where CodigoSAP = @CodigoSAP;
GO
USE BelcorpSalvador
GO
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),

	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion, 	
		FechaModificacion = getdate()
		where CodigoSAP = @CodigoSAP;
GO
USE BelcorpVenezuela
GO
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),

	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		FotoProducto04 = @FotoProducto04,
		FotoProducto05 = @FotoProducto05,
		FotoProducto06 = @FotoProducto06,
		FotoProducto07 = @FotoProducto07,
		FotoProducto08 = @FotoProducto08,
		FotoProducto09 = @FotoProducto09,
		FotoProducto10 = @FotoProducto10,
		UsuarioModificacion = @UsuarioModificacion, 	
		FechaModificacion = getdate()
		where CodigoSAP = @CodigoSAP;
GO
