GO
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@UsuarioRegistro,
			GETDATE(),
			NULL,
			NULL
		);
	END
END
GO