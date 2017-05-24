USE BelcorpCostaRica

GO
	
ALTER PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50),
	@NemoTecnico varchar(100)
AS
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro,
			NemoTecnico
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
			@UsuarioRegistro,
			GETDATE(),
			@NemoTecnico
		);
		
		SELECT SCOPE_IDENTITY();
GO