

go

if not Exists (select * from ConfiguracionPais where Codigo = 'Inicio')
	insert into ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil)
	values('Inicio', 1, 'Configuracion por defecto para el menú del contenedor de ofertas', 1, 1)

go


if not Exists (select * from ConfiguracionPais where Codigo = 'InicioRD')
	insert into ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil)
	values('InicioRD', 1, 'Configuracion por defecto de RD para el menú del contenedor de ofertas', 1, 1)

go