use BelcorpPeru_BPT
go

print db_name()

declare @TablaLogicaId_FeatureFlags int = 158
declare @TablaLogicaDescripcion_FeatureFlags varchar(30) = 'Pantallas Responsive'
--
declare @TablaLogicaDatosId_MisClientesResponsive int = @TablaLogicaId_FeatureFlags * 100 + 1

if not exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId_FeatureFlags)
begin
	print 'insert into TablaLogica : 158 - Pantallas Responsive'
	insert into TablaLogica(
	TablaLogicaID
	,Descripcion
	)
	values
	(
	@TablaLogicaId_FeatureFlags
	,@TablaLogicaDescripcion_FeatureFlags
	)

	print 'insert into TablaLogicaDatos : MisClientes'
	insert into TablaLogicaDatos(
	TablaLogicaDatosID
	,TablaLogicaID
	,Codigo
	,Descripcion
	,Valor
	)
	values
	(
	@TablaLogicaDatosId_MisClientesResponsive
	,@TablaLogicaId_FeatureFlags
	,'MisClientes'
	,'0 : Habilitar, 1: Deshabilitar'
	,'1'
	)
end

