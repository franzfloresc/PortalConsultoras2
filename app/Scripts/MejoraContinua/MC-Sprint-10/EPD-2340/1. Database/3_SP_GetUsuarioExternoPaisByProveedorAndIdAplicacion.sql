USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioExternoPaisByProveedorAndIdAplicacion'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioExternoPaisByProveedorAndIdAplicacion
END
GO

CREATE PROCEDURE dbo.GetUsuarioExternoPaisByProveedorAndIdAplicacion
	@Proveedor VARCHAR(20),
	@IdAplicacion VARCHAR(50)
AS
BEGIN
	SELECT TOP 1
		Proveedor,
		IdAplicacion,
		PaisID,
		CodigoISO
	FROM UsuarioExternoPais
	WHERE Proveedor = @Proveedor AND IdAplicacion = @IdAplicacion
END