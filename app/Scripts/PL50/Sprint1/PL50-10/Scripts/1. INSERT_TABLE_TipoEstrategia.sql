
use BelcorpPeru_PL50
go

insert into TipoEstrategia (
	DescripcionEstrategia, ImagenEstrategia, Orden, 
	FlagActivo, UsuarioRegistro, FechaRegistro, 
	flagNueva, flagRecoProduc, flagRecoPerfil, 
	CodigoPrograma, flagMostrarImg, Codigo, 
	MostrarImgOfertaIndependiente, ImagenOfertaIndependiente, FlagValidarImagen, 
	PesoMaximoImagen
	) 
values(
	'ShowRoom', '', 14,
	1, 'ADMCONTENIDO', getdate(), 
	0,0,1,
	'',0,'022',
	0,'',0,
	0
	)