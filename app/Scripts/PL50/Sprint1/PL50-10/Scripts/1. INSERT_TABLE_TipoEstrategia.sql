
USE BelcorpPeru_PL50
GO

INSERT INTO TipoEstrategia (
	DescripcionEstrategia, ImagenEstrategia, Orden, 
	FlagActivo, UsuarioRegistro, FechaRegistro, 
	flagNueva, flagRecoProduc, flagRecoPerfil, 
	CodigoPrograma, flagMostrarImg, Codigo, 
	MostrarImgOfertaIndependiente, ImagenOfertaIndependiente, FlagValidarImagen, 
	PesoMaximoImagen
	) 
VALUES(
	'ShowRoom', '', 14,
	1, 'ADMCONTENIDO', GETDATE(), 
	0,0,1,
	'',0,'030',
	0,'',0,
	0
	)