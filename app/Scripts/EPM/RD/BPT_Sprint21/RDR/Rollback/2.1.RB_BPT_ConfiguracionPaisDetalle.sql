
go
declare @ConfPaisId int = 0

select @ConfPaisId = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

if @ConfPaisId > 0
begin
	
	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @ConfPaisId
	
	delete from ConfiguracionPaisDetalle 
	where ConfiguracionPaisID = @ConfPaisId

end
go
