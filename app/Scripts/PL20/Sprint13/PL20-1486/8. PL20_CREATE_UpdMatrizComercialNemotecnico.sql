USE BelcorpCostaRica
GO

CREATE PROCEDURE [dbo].[UpdMatrizComercialNemotecnico]
(
	@IdMatrizComercialImagen varchar(50),
	@UsuarioModificacion varchar(50),
	@NemoTecnico varchar(100)
)
AS
UPDATE MatrizComercialImagen
	SET
		UsuarioModificacion = @UsuarioModificacion,
		FechaModificacion = getdate(),
		NemoTecnico = @NemoTecnico
	WHERE IdMatrizComercialImagen = @IdMatrizComercialImagen ;