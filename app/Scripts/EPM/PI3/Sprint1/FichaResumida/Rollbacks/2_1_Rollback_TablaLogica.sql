use BelcorpPeru_BPT
go

print db_name()

declare @TablaLogicaId_FeatureFlags int = 158
declare @TablaLogicaDatosId_MisClientesResponsive int = @TablaLogicaId_FeatureFlags * 100 + 1

if  exists (	select 1
				from TablaLogica tl
				where tl.TablaLogicaID = @TablaLogicaId_FeatureFlags)
begin
	print 'Rollback insert into TablaLogica : 158 - Pantallas Responsive'
	
	delete tld
	from TablaLogicaDatos tld 
	where tld.TablaLogicaDatosID = @TablaLogicaDatosId_MisClientesResponsive
	and tld.TablaLogicaID = @TablaLogicaId_FeatureFlags

	delete tl
	from TablaLogica tl
	where tl.TablaLogicaID = @TablaLogicaId_FeatureFlags
end

