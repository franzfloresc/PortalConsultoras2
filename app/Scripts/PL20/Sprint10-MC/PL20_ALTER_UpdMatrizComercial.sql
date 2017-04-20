USE [BelcorpCostaRica]
GO
/****** Object:  StoredProcedure [dbo].[UpdMatrizComercial]    Script Date: 20/04/2017 3:05:04 p. m. ******/
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
