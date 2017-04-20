USE [BelcorpCostaRica]
GO
/****** Object:  StoredProcedure [dbo].[InsMatrizComercial]    Script Date: 20/04/2017 3:01:53 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@UsuarioRegistro,
			GETDATE()
		);
	END
END
