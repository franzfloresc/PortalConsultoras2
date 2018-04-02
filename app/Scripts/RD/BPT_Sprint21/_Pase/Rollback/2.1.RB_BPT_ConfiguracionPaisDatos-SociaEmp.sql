USE BelcorpPeru
GO

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

go

USE BelcorpMexico
GO

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

go

USE BelcorpColombia
GO

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

go

USE BelcorpSalvador
GO

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

go

USE BelcorpPuertoRico
GO

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

go

USE BelcorpPanama
GO

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

go

USE BelcorpGuatemala
GO

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

go

USE BelcorpEcuador
GO

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

go

USE BelcorpDominicana
GO

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

go

USE BelcorpCostaRica
GO

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

go

USE BelcorpChile
GO

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

go

USE BelcorpBolivia
GO

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

go

