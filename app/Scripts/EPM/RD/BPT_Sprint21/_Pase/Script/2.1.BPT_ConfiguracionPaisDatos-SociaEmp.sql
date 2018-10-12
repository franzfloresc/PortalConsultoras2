USE BelcorpPeru
GO

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

GO

USE BelcorpMexico
GO

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

GO

USE BelcorpColombia
GO

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

GO

USE BelcorpSalvador
GO

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

GO

USE BelcorpPuertoRico
GO

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

GO

USE BelcorpPanama
GO

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

GO

USE BelcorpGuatemala
GO

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

GO

USE BelcorpEcuador
GO

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

GO

USE BelcorpDominicana
GO

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

GO

USE BelcorpCostaRica
GO

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

GO

USE BelcorpChile
GO

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

GO

USE BelcorpBolivia
GO

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

GO

