
go

if not Exists (select * from ConfiguracionPais where Codigo = 'InicioContenedor')
	insert into ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil)
	values('InicioContenedor', 1, 'Configuracion por defecto para el menú del contenedor de ofertas', 1, 1)

go

go

if not Exists (select * from ConfiguracionPais where Codigo = 'OPT')
	insert into ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil)
	values('OPT', 1, 'Oferta Para Ti', 1, 1)

go
