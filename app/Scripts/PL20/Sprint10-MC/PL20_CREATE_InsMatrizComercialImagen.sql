USE [BelcorpCostaRica]
GO
/****** Object:  StoredProcedure [dbo].[InsMatrizComercial]    Script Date: 20/04/2017 3:01:53 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[InsMatrizComercialImagen]
	@CodigoSAP varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	BEGIN
		INSERT INTO MatrizComercialImagen
		(
			CodigoSAP,
			Foto,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@Foto,
			@UsuarioRegistro,
			GETDATE()
		);
	END
END