USE BelcorpBolivia
GO

BEGIN
	
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
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
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
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
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
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
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
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
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
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
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
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
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
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
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
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
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
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
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
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
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
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
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
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
CREATE PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
END

END
GO



