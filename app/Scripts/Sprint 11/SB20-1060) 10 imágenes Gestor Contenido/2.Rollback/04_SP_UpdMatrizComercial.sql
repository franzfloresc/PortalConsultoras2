GO
ALTER PROCEDURE UpdMatrizComercial
	@CodigoSAP varchar(50),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@UsuarioModificacion varchar(50)
AS
BEGIN
	UPDATE MatrizComercial
	set
		Descripcion = @Descripcion,
		FotoProducto01 = @FotoProducto01,
		FotoProducto02 = @FotoProducto02,
		FotoProducto03 = @FotoProducto03,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate()
	where CodigoSAP = @CodigoSAP;
END
GO