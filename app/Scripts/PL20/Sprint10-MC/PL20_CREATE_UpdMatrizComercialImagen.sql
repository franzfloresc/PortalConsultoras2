USE [BelcorpCostaRica]
GO
/****** Object:  StoredProcedure [dbo].[UpdMatrizComercial]    Script Date: 20/04/2017 3:13:03 p. m. ******/
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
