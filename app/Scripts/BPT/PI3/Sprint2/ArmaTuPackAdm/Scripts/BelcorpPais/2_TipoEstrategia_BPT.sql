GO
USE BelcorpPeru_BPT
go
USE BelcorpChile_BPT
go
USE BelcorpCostaRica_BPT
GO

print db_name()

declare @codigo varchar(5) = '004'

delete from TipoEstrategia where Codigo = @codigo

insert into TipoEstrategia(
	DescripcionEstrategia
	,ImagenEstrategia
	,Orden
	,FlagActivo
	,flagNueva
	,flagRecoProduc
	,flagRecoPerfil
	,CodigoPrograma
	,FlagMostrarImg
	,Codigo
	,MostrarImgOfertaIndependiente
	,ImagenOfertaIndependiente
	,FlagValidarImagen
	,PesoMaximoImagen
	,NombreComercial
	,MensajeValidacion
)
values
(
	'Arma Tu Pack'
	,''
	,1
	,1
	,0
	,0
	,1
	,null
	,null
	,@codigo
	,null
	,null
	,0
	,null
	,'Arma Tu Pack'
	,'Este producto es una oferta digital. Te invitamos a que revises tu sección de ofertas.'

)
