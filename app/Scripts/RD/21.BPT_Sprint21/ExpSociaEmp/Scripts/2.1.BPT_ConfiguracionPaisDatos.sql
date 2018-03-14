--use BelcorpChile_bpt
--go

use BelcorpPeru_bpt
go

--use BelcorpCostaRica_bpt
--go

print db_name()

if( not exists(	select cpd.*
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'SEExperienciaClub'	))
begin
	print 'Insertando PaisConfiguracionDatos : SEExperienciaClub'

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
	,'SEExperienciaClub'
	,0
	,1
	,null
	,null
	,'Habilita modificar la experiencia de la Socia Empresaria para Gana+'
	,1
	,'SociaEmpresariaExperienciaClub'
	)
end

if( not exists(	select cpd.*
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'SESuscritaNoActivaCancelarSuscripcion'	))
begin
	print 'Insertando PaisConfiguracionDatos : SESuscritaNoActivaCancelarSuscripcion'

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
	,'SESuscritaNoActivaCancelarSuscripcion'
	,0
	,0
	,null
	,null
	,'Habilita la cancelación de la suscripción para la Socia Empresaria Suscrita No Activa'
	,1
	,'SociaEmpresariaExperienciaClub'
	)
end

if( not exists(	select cpd.*
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'SESuscritaActivaCancelarSuscripcion'	))
begin
	print 'Insertando PaisConfiguracionDatos : SESuscritaActivaCancelarSuscripcion'

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
	,'SESuscritaActivaCancelarSuscripcion'
	,0
	,0
	,null
	,null
	,'Habilita la cancelación de la suscripcioón para la Socia Empresaria Suscrita Activa'
	,1
	,'SociaEmpresariaExperienciaClub'
	)
end

if( not exists(	select cpd.*
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'SENoSuscritaNoActivaVerGnd'	))
begin
	print 'Insertando PaisConfiguracionDatos : SENoSuscritaNoActivaVerGnd'

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
	,'SENoSuscritaNoActivaVerGnd'
	,0
	,0
	,null
	,null
	,'Habilita Guía de Negocio Digital para la Socia Empresaria No Suscrita No Activa'
	,1
	,'SociaEmpresariaExperienciaClub'
	)
end

if( not exists(	select cpd.*
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'SENoSuscritaActivaVerGnd'	))
begin
	print 'Insertando PaisConfiguracionDatos : SENoSuscritaActivaVerGnd'

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
	,'SENoSuscritaActivaVerGnd'
	,0
	,0
	,null
	,null
	,'Habilita Guía de Negocio Digital para la Socia Empresaria No Suscrita Activa'
	,1
	,'SociaEmpresariaExperienciaClub'
	)
end

if( not exists(	select cpd.*
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'SESuscritaNoActivaVerGnd'	))
begin
	print 'Insertando PaisConfiguracionDatos : SESuscritaNoActivaVerGnd'

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
	,'SESuscritaNoActivaVerGnd'
	,0
	,0
	,null
	,null
	,'Habilita Guía de Negocio Digital para la Socia Empresaria Suscrita No Activa'
	,1
	,'SociaEmpresariaExperienciaClub'
	)
end

if( not exists(	select cpd.*
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'SESuscritaActivaVerGnd'	))
begin
	print 'Insertando PaisConfiguracionDatos : SESuscritaActivaVerGnd'

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
	,'SESuscritaActivaVerGnd'
	,0
	,1
	,null
	,null
	,'Habilita Guía de Negocio Digital para la Socia Empresaria Suscrita Activa'
	,1
	,'SociaEmpresariaExperienciaClub'
	)
end

if( not exists(	select cpd.*
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'SENoSuscritaNoActivaComprarEnGnd'	))
begin
	print 'Insertando PaisConfiguracionDatos : SENoSuscritaNoActivaComprarEnGnd'

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
	,'SENoSuscritaNoActivaComprarEnGnd'
	,0
	,0
	,null
	,null
	,'Habilita Comprar productos de Guía de Negocio Digital para la Socia Empresaria No Suscrita No Activa'
	,1
	,'SociaEmpresariaExperienciaClub'
	)
end

if( not exists(	select cpd.*
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'SENoSuscritaActivaComprarEnGnd'	))
begin
	print 'Insertando PaisConfiguracionDatos : SENoSuscritaActivaComprarEnGnd'

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
	,'SENoSuscritaActivaComprarEnGnd'
	,0
	,0
	,null
	,null
	,'Habilita Comprar productos de Guía de Negocio Digital para la Socia Empresaria No Suscrita Activa'
	,1
	,'SociaEmpresariaExperienciaClub'
	)
end

if( not exists(	select cpd.*
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'SESuscritaNoActivaComprarEnGnd'	))
begin
	print 'Insertando PaisConfiguracionDatos : SESuscritaNoActivaComprarEnGnd'

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
	,'SESuscritaNoActivaComprarEnGnd'
	,0
	,0
	,null
	,null
	,'Habilita Comprar productos de Guía de Negocio Digital para la Socia Empresaria Suscrita No Activa'
	,1
	,'SociaEmpresariaExperienciaClub'
	)
end

if( not exists(	select cpd.*
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'SESuscritaActivaComprarEnGnd'	))
begin
	print 'Insertando PaisConfiguracionDatos : SESuscritaActivaComprarEnGnd'

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
	,'SESuscritaActivaComprarEnGnd'
	,0
	,0
	,null
	,null
	,'Habilita Comprar productos de Guía de Negocio Digital para la Socia Empresaria Suscrita Activa'
	,1
	,'SociaEmpresariaExperienciaClub'
	)
end

if( not exists(	select cpd.*
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'SENoSuscritaNoActivaProductosGndEnPedido'	))
begin
	print 'Insertando PaisConfiguracionDatos : SENoSuscritaNoActivaProductosGndEnPedido'

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
	,'SENoSuscritaNoActivaProductosGndEnPedido'
	,0
	,0
	,null
	,null
	,'Habilita bloquear productos de Guía de Negocio Digital en el pase de pedido para la Socia Empresaria No Suscrita No Activa'
	,1
	,'SociaEmpresariaExperienciaClub'
	)
end

if( not exists(	select cpd.*
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'SENoSuscritaActivaProductosGndEnPedido'	))
begin
	print 'Insertando PaisConfiguracionDatos : SENoSuscritaActivaProductosGndEnPedido'

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
	,'SENoSuscritaActivaProductosGndEnPedido'
	,0
	,0
	,null
	,null
	,'Habilita bloquear productos de Guía de Negocio Digital en el pase de pedido para la Socia Empresaria No Suscrita Activa'
	,1
	,'SociaEmpresariaExperienciaClub'
	)
end

if( not exists(	select cpd.*
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'SESuscritaNoActivaProductosGndEnPedido'	))
begin
	print 'Insertando PaisConfiguracionDatos : SESuscritaNoActivaProductosGndEnPedido'

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
	,'SESuscritaNoActivaProductosGndEnPedido'
	,0
	,0
	,null
	,null
	,'Habilita bloquear productos de Guía de Negocio Digital en el pase de pedido para la Socia Empresaria Suscrita No Activa'
	,1
	,'SociaEmpresariaExperienciaClub'
	)
end

if( not exists(	select cpd.*
				from ConfiguracionPaisDatos cpd
					join ConfiguracionPais cp
					on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
					and cp.Codigo = 'RD'
					and cpd.Codigo = 'SESuscritaActivaProductosGndEnPedido'	))
begin
	print 'Insertando PaisConfiguracionDatos : SESuscritaActivaProductosGndEnPedido'

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
	,'SESuscritaActivaProductosGndEnPedido'
	,0
	,0
	,null
	,null
	,'Habilita bloquear productos de Guía de Negocio Digital en el pase de pedido para la Socia Empresaria Suscrita Activa'
	,1
	,'SociaEmpresariaExperienciaClub'
	)
end