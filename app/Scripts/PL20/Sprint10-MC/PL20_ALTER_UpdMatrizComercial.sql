USE BelcorpBolivia
GO

BEGIN
	
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
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
	SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
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
	SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
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
	SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
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
	SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
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
	SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[UpdMatrizComercial]
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;
END
END
GO





