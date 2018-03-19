use BelcorpChile_bpt
go

--use BelcorpPeru_bpt
--go

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