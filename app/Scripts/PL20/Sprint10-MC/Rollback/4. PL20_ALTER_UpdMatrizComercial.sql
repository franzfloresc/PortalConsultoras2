USE BelcorpBolivia
GO

BEGIN
	
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
BEGIN
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
END


END
GO
/*end*/

USE BelcorpChile
GO

BEGIN
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
BEGIN
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
END

END
GO
/*end*/

USE BelcorpColombia
GO

BEGIN
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
BEGIN
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
END

END

END
GO
/*end*/

USE BelcorpCostaRica
GO

BEGIN
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
BEGIN
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
END
	
END

END
GO
/*end*/

USE BelcorpDominicana
GO

BEGIN
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
BEGIN
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
END

END
GO
/*end*/

USE BelcorpEcuador
GO

BEGIN
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
BEGIN
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
END

END
GO
/*end*/

USE BelcorpGuatemala
GO

BEGIN
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
BEGIN
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
END

END
GO
/*end*/

USE BelcorpMexico
GO

BEGIN
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
BEGIN
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
END

END

END
GO
/*end*/

USE BelcorpPanama
GO

BEGIN
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
BEGIN
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
END

END
GO
/*end*/

USE BelcorpPeru
GO


BEGIN
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
BEGIN
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
END

END
GO
/*end*/

USE BelcorpPuertoRico
GO

BEGIN
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
BEGIN
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
END


END
GO
/*end*/

USE BelcorpSalvador
GO


BEGIN
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
BEGIN
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
END

END
GO
/*end*/

USE BelcorpVenezuela
GO

BEGIN
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
BEGIN
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
END

END
GO





