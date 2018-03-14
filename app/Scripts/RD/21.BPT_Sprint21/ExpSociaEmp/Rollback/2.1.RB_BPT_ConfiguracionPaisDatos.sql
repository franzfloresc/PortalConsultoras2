--use BelcorpChile_bpt
--go

use BelcorpPeru_bpt
go

--use BelcorpCostaRica_bpt
--go

print db_name()

if(	exists(	select cpd.*
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'SEExperienciaClub'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : SEExperienciaClub'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'SEExperienciaClub'
end

if( exists(	select cpd.*
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'SESuscritaNoActivaCancelarSuscripcion'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : SESuscritaNoActivaCancelarSuscripcion'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'SESuscritaNoActivaCancelarSuscripcion'
end

if( exists(	select cpd.*
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'SESuscritaActivaCancelarSuscripcion'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : SESuscritaActivaCancelarSuscripcion'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'SESuscritaActivaCancelarSuscripcion'
end

if( exists(	select cpd.*
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'SENoSuscritaNoActivaVerGnd'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : SENoSuscritaNoActivaVerGnd'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'SENoSuscritaNoActivaVerGnd'
end

if( exists(	select cpd.*
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'SENoSuscritaActivaVerGnd'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : SENoSuscritaActivaVerGnd'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'SENoSuscritaActivaVerGnd'
end

if( exists(	select cpd.*
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'SESuscritaNoActivaVerGnd'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : SENoSuscritaActivaVerGnd'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'SESuscritaNoActivaVerGnd'
end

if( exists(	select cpd.*
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'SESuscritaActivaVerGnd'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : SESuscritaActivaVerGnd'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'SESuscritaActivaVerGnd'
end

if( exists(	select cpd.*
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'SENoSuscritaNoActivaComprarEnGnd'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : SENoSuscritaNoActivaComprarEnGnd'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'SENoSuscritaNoActivaComprarEnGnd'
end

if( exists(	select cpd.*
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'SENoSuscritaActivaComprarEnGnd'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : SENoSuscritaActivaComprarEnGnd'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'SENoSuscritaActivaComprarEnGnd'
end

if( exists(	select cpd.*
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'SESuscritaNoActivaComprarEnGnd'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : SESuscritaNoActivaComprarEnGnd'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'SESuscritaNoActivaComprarEnGnd'
end

if( exists(	select cpd.*
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'SESuscritaActivaComprarEnGnd'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : SESuscritaActivaComprarEnGnd'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'SESuscritaActivaComprarEnGnd'
end

if( exists(	select cpd.*
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'SENoSuscritaNoActivaProductosGndEnPedido'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : SENoSuscritaNoActivaProductosGndEnPedido'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'SENoSuscritaNoActivaProductosGndEnPedido'
end

if( exists(	select cpd.*
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'SENoSuscritaActivaProductosGndEnPedido'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : SENoSuscritaActivaProductosGndEnPedido'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'SENoSuscritaActivaProductosGndEnPedido'
end

if( exists(	select cpd.*
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'SESuscritaNoActivaProductosGndEnPedido'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : SESuscritaNoActivaProductosGndEnPedido'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'SESuscritaNoActivaProductosGndEnPedido'
end

if( exists(	select cpd.*
			from ConfiguracionPaisDatos cpd
				join ConfiguracionPais cp
				on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
				and cp.Codigo = 'RD'
				and cpd.Codigo = 'SESuscritaActivaProductosGndEnPedido'	))
begin
	print 'Rollback Insertando PaisConfiguracionDatos : SESuscritaActivaProductosGndEnPedido'

	delete cpd
	from ConfiguracionPaisDatos cpd
		join ConfiguracionPais cp
		on cpd.ConfiguracionPaisID = cp.ConfiguracionPaisID
		and cp.Codigo = 'RD'
		and cpd.Codigo = 'SESuscritaActivaProductosGndEnPedido'
end