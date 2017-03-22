
USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetListaLoginExterno'))
BEGIN
    DROP PROCEDURE dbo.GetListaLoginExterno
END
GO

CREATE PROCEDURE [dbo].[GetListaLoginExterno]
(
	@CodigoUsuario VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 5
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
	WHERE CodigoUsuario = @CodigoUsuario
	AND Estado = 1
END
