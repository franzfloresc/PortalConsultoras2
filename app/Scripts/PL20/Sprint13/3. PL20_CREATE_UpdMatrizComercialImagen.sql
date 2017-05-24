USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[UpdMatrizComercialImagen]
	@IdMatrizComercialImagen varchar(50),
	@Foto varchar(150),
	@UsuarioModificacion varchar(50),
	@NemoTecnico varchar(100)
AS
	UPDATE MatrizComercialImagen
	set
		Foto = @Foto,
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate(),
		NemoTecnico = @NemoTecnico
	where IdMatrizComercialImagen = @IdMatrizComercialImagen ;
GO