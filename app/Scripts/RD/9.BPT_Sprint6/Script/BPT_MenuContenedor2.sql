
go

if not Exists (select * from ConfiguracionPais where Codigo = 'InicioContenedor')
	insert into ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil)
	values('InicioContenedor', 1, 'Configuracion por defecto para el men� del contenedor de ofertas', 1, 1)

go