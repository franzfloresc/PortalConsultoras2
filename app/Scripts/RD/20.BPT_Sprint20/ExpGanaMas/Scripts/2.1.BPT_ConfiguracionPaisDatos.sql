﻿use BelcorpChile_bpt
go

print db_name()

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoNoActiva'	))
begin
	print 'Actualizando PaisConfiguracionDatos : LogoComercialFondoNoActiva'

	update cpd
	set 
	cpd.Valor1 = 'logo-ganamas-rojo.png',
	cpd.Valor2 = null
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoNoActiva'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoActiva'	))
begin
	print 'Actualizando PaisConfiguracionDatos : LogoComercialFondoActiva'

	update cpd
	set 
	cpd.Valor1 = 'logo-club-ganamas-dorado.png',
	cpd.Valor2 = null
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoActiva'

end

if( not exists(	select 1
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasNoActivaNoSuscrita'

	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	,Componente
	)
	values(
	(select ConfiguracionPaisID from ConfiguracionPais cp where cp.Codigo = 'RD')
	,'BannerOfertasNoActivaNoSuscrita'
	,0
	,'banner-ganamas.jpg'
	,null
	,null
	,'Fondo de la cabecera del contendor de ofertas para consultora No Activa No Suscrita'
	,1
	,null
	)
end

if( not exists(	select 1
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasNoActivaSuscrita'

	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	,Componente
	)
	values(
	(select ConfiguracionPaisID from ConfiguracionPais cp where cp.Codigo = 'RD')
	,'BannerOfertasNoActivaSuscrita'
	,0
	,'banner-ganamas.jpg'
	,null
	,null
	,'Fondo de la cabecera del contendor de ofertas para consultora No Activa Suscrita'
	,1
	,null
	)
end

if( not exists(	select 1
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaNoSuscrita'

	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	,Componente
	)
	values(
	(select ConfiguracionPaisID from ConfiguracionPais cp where cp.Codigo = 'RD')
	,'BannerOfertasActivaNoSuscrita'
	,0
	,'banner-ganamas.jpg'
	,null
	,null
	,'Fondo de la cabecera del contendor de ofertas para consultora Activa No Suscrita'
	,1
	,null
	)
end

if( not exists(	select 1
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaSuscrita'

	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	,Componente
	)
	values(
	(select ConfiguracionPaisID from ConfiguracionPais cp where cp.Codigo = 'RD')
	,'BannerOfertasActivaSuscrita'
	,0
	,'banner-ganamas.jpg'
	,null
	,null
	,'Fondo de la cabecera del contendor de ofertas para consultora Activa Suscrita'
	,1
	,null
	)
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaNoSuscrita'	))
begin
	print 'Actualizando PaisConfiguracionDatos : DLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = 'APROVECHA OFERTAS HECHAS A TU MEDIDA EN',
	cpd.Valor2 = NULL
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaNoSuscrita'

end
	
if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerNoActivaNoSuscrita'	))
begin
	print 'Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = 'APROVECHA OFERTAS HECHAS A TU MEDIDA EN',
	cpd.Valor2 = NULL
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerNoActivaNoSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerNoActivaSuscrita'	))
begin
	print 'Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = 'APROVECHA OFERTAS HECHAS A TU MEDIDA EN',
	cpd.Valor2 = NULL
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerNoActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'	))
begin
	print 'Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = 'APROVECHA OFERTAS HECHAS A TU MEDIDA EN',
	cpd.Valor2 = NULL
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( not	exists(	select 1
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaNoSuscrita'

	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	,Componente
	)
	values(
	(select ConfiguracionPaisID from ConfiguracionPais cp where cp.Codigo = 'RD')
	,'DLandingBannerInicioRdActivaNoSuscrita'
	,0
	,'#Nombre, Bienvenida a tu espacio exclusivo'
	,null
	,null
	,'Título de la cabecera del contendor de ofertas para consultora Activa No Suscrita'
	,1
	,null
	)
end

if( not	exists(	select 1
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaNoSuscrita'

	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	,Componente
	)
	values(
	(select ConfiguracionPaisID from ConfiguracionPais cp where cp.Codigo = 'RD')
	,'DLandingBannerInicioRdNoActivaNoSuscrita'
	,0
	,'#Nombre, Bienvenida a tu espacio exclusivo'
	,null
	,null
	,'Título de la cabecera del contendor de ofertas para consultora No Activa No Suscrita'
	,1
	,null
	)
end

if( not exists(	select 1
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaSuscrita'

	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	,Componente
	)
	values(
	(select ConfiguracionPaisID from ConfiguracionPais cp where cp.Codigo = 'RD')
	,'DLandingBannerInicioRdNoActivaSuscrita'
	,0
	,'#Nombre, Bienvenida a'
	,null
	,null
	,'Título de la cabecera del contendor de ofertas para consultora No Activa Suscrita'
	,1
	,null
	)
end

if( not exists(	select 1
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaSuscrita'

	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	,Componente
	)
	values(
	(select ConfiguracionPaisID from ConfiguracionPais cp where cp.Codigo = 'RD')
	,'DLandingBannerInicioRdActivaSuscrita'
	,0
	,'#Nombre, Bienvenida a'
	,null
	,null
	,'Título de la cabecera del contendor de ofertas para consultora Activa Suscrita'
	,1
	,null
	)
end

if( not exists(	select 1
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'LogoComercialColorActiva'	))
begin
	print 'Insertando PaisConfiguracionDatos : LogoComercialColorActiva'

	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	,Componente
	)
	values(
	(select ConfiguracionPaisID from ConfiguracionPais cp where cp.Codigo = 'RD')
	,'LogoComercialColorActiva'
	,0
	,'logo-club-ganamas_normal.svg'
	,'logo-club-ganamas_normal.svg'
	,null
	,'Logo de club gana mas en color dorado'
	,1
	,null
	)
end

if( not exists(	select 1
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'LogoComercialColorNoActiva'	))
begin
	print 'Insertando PaisConfiguracionDatos : LogoComercialColorNoActiva'

	insert into ConfiguracionPaisDatos(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	,Componente
	)
	values(
	(select ConfiguracionPaisID from ConfiguracionPais cp where cp.Codigo = 'RD')
	,'LogoComercialColorNoActiva'
	,0
	,'logo-ganamas_normal.svg'
	,'logo-ganamas_normal.svg'
	,null
	,'Logo de club gana mas en color morado'
	,1
	,null
	)
end