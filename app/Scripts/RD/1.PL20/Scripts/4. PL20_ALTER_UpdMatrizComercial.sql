USE BelcorpBolivia
GO
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;

GO
USE BelcorpCostaRica
GO
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;

GO
USE BelcorpChile
GO
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;

GO
USE BelcorpColombia
GO
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;

GO
USE BelcorpDominicana
GO
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;

GO
USE BelcorpEcuador
GO
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;

GO
USE BelcorpGuatemala
GO
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;

GO
USE BelcorpMexico
GO
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;

GO
USE BelcorpPanama
GO
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;

GO
USE BelcorpPeru
GO
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;

GO
USE BelcorpPuertoRico
GO
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;

GO
USE BelcorpSalvador
GO
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;

GO
USE BelcorpVenezuela
GO
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;

GO
