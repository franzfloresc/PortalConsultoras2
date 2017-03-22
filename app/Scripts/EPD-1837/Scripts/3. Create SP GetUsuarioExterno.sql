
USE BelcorpPeru
GO


IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioExterno'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioExterno
END
GO

CREATE PROCEDURE GetUsuarioExterno
(
	@Proveedor VARCHAR(20),
	@IdAplicacion VARCHAR(30)
)
AS

BEGIN
	SELECT TOP 1
		CodigoUsuario,
		Proveedor,
		IdAplicacion,
		[Login],
		Nombres,
		Apellidos,
		FechaNacimiento,
		Correo,
		Genero,
		Ubicacion,
		LinkPerfil,
		FotoPerfil,
		FechaRegistro,
		Estado 
	FROM UsuarioExterno 
	WHERE Proveedor = @Proveedor 
	AND IdAplicacion = @IdAplicacion
END
GO
