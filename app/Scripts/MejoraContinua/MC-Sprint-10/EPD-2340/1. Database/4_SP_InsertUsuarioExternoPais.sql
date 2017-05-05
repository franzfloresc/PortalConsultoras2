USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsertUsuarioExternoPais'))
BEGIN
    DROP PROCEDURE dbo.InsertUsuarioExternoPais
END
GO

CREATE PROCEDURE dbo.InsertUsuarioExternoPais
	@Proveedor VARCHAR(20),
	@IdAplicacion VARCHAR(50),
	@PaisID TINYINT,
	@CodigoISO VARCHAR(2)
AS
BEGIN
	INSERT INTO UsuarioExternoPais(Proveedor, IdAplicacion, PaisID, CodigoISO)
	VALUES(@Proveedor, @IdAplicacion, @PaisID, @CodigoISO)
END