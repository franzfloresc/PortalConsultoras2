USE BelcorpPeru
GO

print db_name()

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoNoActiva'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoNoActiva'

	update cpd
	set 
	cpd.Valor1 = 'GanaMasFondo.png',
	cpd.Valor2 = 'GanaMasMobileFondo.png'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoActiva'

	update cpd
	set 
	cpd.Valor1 = 'ClubGanaMasFondo.png',
	cpd.Valor2 = 'ClubGanaMasMobileFondo.png'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoActiva'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : BannerOfertasNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre Bienvenida a Gana+ tu nuevo espacio online de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : MLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = NULL
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerNoActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioActiva'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioNoActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioNoActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioNoActiva'
end

GO

USE BelcorpMexico
GO

print db_name()

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoNoActiva'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoNoActiva'

	update cpd
	set 
	cpd.Valor1 = 'GanaMasFondo.png',
	cpd.Valor2 = 'GanaMasMobileFondo.png'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoActiva'

	update cpd
	set 
	cpd.Valor1 = 'ClubGanaMasFondo.png',
	cpd.Valor2 = 'ClubGanaMasMobileFondo.png'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoActiva'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : BannerOfertasNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre Bienvenida a Gana+ tu nuevo espacio online de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : MLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = NULL
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerNoActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioActiva'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioNoActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioNoActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioNoActiva'
end

GO

USE BelcorpColombia
GO

print db_name()

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoNoActiva'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoNoActiva'

	update cpd
	set 
	cpd.Valor1 = 'GanaMasFondo.png',
	cpd.Valor2 = 'GanaMasMobileFondo.png'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoActiva'

	update cpd
	set 
	cpd.Valor1 = 'ClubGanaMasFondo.png',
	cpd.Valor2 = 'ClubGanaMasMobileFondo.png'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoActiva'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : BannerOfertasNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre Bienvenida a Gana+ tu nuevo espacio online de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : MLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = NULL
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerNoActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioActiva'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioNoActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioNoActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioNoActiva'
end

GO

USE BelcorpSalvador
GO

print db_name()

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoNoActiva'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoNoActiva'

	update cpd
	set 
	cpd.Valor1 = 'GanaMasFondo.png',
	cpd.Valor2 = 'GanaMasMobileFondo.png'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoActiva'

	update cpd
	set 
	cpd.Valor1 = 'ClubGanaMasFondo.png',
	cpd.Valor2 = 'ClubGanaMasMobileFondo.png'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoActiva'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : BannerOfertasNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre Bienvenida a Gana+ tu nuevo espacio online de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : MLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = NULL
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerNoActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioActiva'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioNoActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioNoActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioNoActiva'
end

GO

USE BelcorpPuertoRico
GO

print db_name()

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoNoActiva'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoNoActiva'

	update cpd
	set 
	cpd.Valor1 = 'GanaMasFondo.png',
	cpd.Valor2 = 'GanaMasMobileFondo.png'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoActiva'

	update cpd
	set 
	cpd.Valor1 = 'ClubGanaMasFondo.png',
	cpd.Valor2 = 'ClubGanaMasMobileFondo.png'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoActiva'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : BannerOfertasNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre Bienvenida a Gana+ tu nuevo espacio online de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : MLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = NULL
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerNoActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioActiva'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioNoActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioNoActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioNoActiva'
end

GO

USE BelcorpPanama
GO

print db_name()

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoNoActiva'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoNoActiva'

	update cpd
	set 
	cpd.Valor1 = 'GanaMasFondo.png',
	cpd.Valor2 = 'GanaMasMobileFondo.png'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoActiva'

	update cpd
	set 
	cpd.Valor1 = 'ClubGanaMasFondo.png',
	cpd.Valor2 = 'ClubGanaMasMobileFondo.png'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoActiva'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : BannerOfertasNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre Bienvenida a Gana+ tu nuevo espacio online de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : MLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = NULL
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerNoActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioActiva'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioNoActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioNoActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioNoActiva'
end

GO

USE BelcorpGuatemala
GO

print db_name()

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoNoActiva'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoNoActiva'

	update cpd
	set 
	cpd.Valor1 = 'GanaMasFondo.png',
	cpd.Valor2 = 'GanaMasMobileFondo.png'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoActiva'

	update cpd
	set 
	cpd.Valor1 = 'ClubGanaMasFondo.png',
	cpd.Valor2 = 'ClubGanaMasMobileFondo.png'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoActiva'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : BannerOfertasNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre Bienvenida a Gana+ tu nuevo espacio online de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : MLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = NULL
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerNoActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioActiva'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioNoActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioNoActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioNoActiva'
end

GO

USE BelcorpEcuador
GO

print db_name()

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoNoActiva'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoNoActiva'

	update cpd
	set 
	cpd.Valor1 = 'GanaMasFondo.png',
	cpd.Valor2 = 'GanaMasMobileFondo.png'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoActiva'

	update cpd
	set 
	cpd.Valor1 = 'ClubGanaMasFondo.png',
	cpd.Valor2 = 'ClubGanaMasMobileFondo.png'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoActiva'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : BannerOfertasNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre Bienvenida a Gana+ tu nuevo espacio online de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : MLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = NULL
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerNoActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioActiva'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioNoActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioNoActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioNoActiva'
end

GO

USE BelcorpDominicana
GO

print db_name()

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoNoActiva'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoNoActiva'

	update cpd
	set 
	cpd.Valor1 = 'GanaMasFondo.png',
	cpd.Valor2 = 'GanaMasMobileFondo.png'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoActiva'

	update cpd
	set 
	cpd.Valor1 = 'ClubGanaMasFondo.png',
	cpd.Valor2 = 'ClubGanaMasMobileFondo.png'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoActiva'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : BannerOfertasNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre Bienvenida a Gana+ tu nuevo espacio online de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : MLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = NULL
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerNoActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioActiva'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioNoActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioNoActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioNoActiva'
end

GO

USE BelcorpCostaRica
GO

print db_name()

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoNoActiva'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoNoActiva'

	update cpd
	set 
	cpd.Valor1 = 'GanaMasFondo.png',
	cpd.Valor2 = 'GanaMasMobileFondo.png'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoActiva'

	update cpd
	set 
	cpd.Valor1 = 'ClubGanaMasFondo.png',
	cpd.Valor2 = 'ClubGanaMasMobileFondo.png'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoActiva'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : BannerOfertasNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre Bienvenida a Gana+ tu nuevo espacio online de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : MLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = NULL
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerNoActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioActiva'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioNoActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioNoActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioNoActiva'
end

GO

USE BelcorpChile
GO

print db_name()

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoNoActiva'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoNoActiva'

	update cpd
	set 
	cpd.Valor1 = 'GanaMasFondo.png',
	cpd.Valor2 = 'GanaMasMobileFondo.png'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoActiva'

	update cpd
	set 
	cpd.Valor1 = 'ClubGanaMasFondo.png',
	cpd.Valor2 = 'ClubGanaMasMobileFondo.png'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoActiva'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : BannerOfertasNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre Bienvenida a Gana+ tu nuevo espacio online de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : MLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = NULL
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerNoActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioActiva'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioNoActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioNoActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioNoActiva'
end

GO

USE BelcorpBolivia
GO

print db_name()

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoNoActiva'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoNoActiva'

	update cpd
	set 
	cpd.Valor1 = 'GanaMasFondo.png',
	cpd.Valor2 = 'GanaMasMobileFondo.png'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : LogoComercialFondoActiva'

	update cpd
	set 
	cpd.Valor1 = 'ClubGanaMasFondo.png',
	cpd.Valor2 = 'ClubGanaMasMobileFondo.png'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoComercialFondoActiva'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : BannerOfertasNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'BannerOfertasActivaSuscrita'	))
begin
	print 'Insertando PaisConfiguracionDatos : BannerOfertasActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'BannerOfertasActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre Bienvenida a Gana+ tu nuevo espacio online de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : MLandingBannerActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = NULL
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'MLandingBannerActivaNoSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerNoActivaNoSuscrita'	))
begin
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaNoSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerNoActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre ya estás suscrita a Gana+',
	cpd.Valor2 = 'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!'
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
	print 'Rollback Actualizando PaisConfiguracionDatos : DLandingBannerActivaSuscrita'

	update cpd
	set 
	cpd.Valor1 = '#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	cpd.Valor2 = 'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!'
	from ConfiguracionPaisDatos cpd
	inner join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerActivaSuscrita'

end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaNoSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaNoSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdNoActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdNoActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : DLandingBannerInicioRdActivaSuscrita'

	delete cpd
	from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'DLandingBannerInicioRdActivaSuscrita'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioActiva'
end

if( exists(	select 1
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'LogoMenuInicioNoActiva'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : LogoMenuInicioNoActiva'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'LogoMenuInicioNoActiva'
end

GO

