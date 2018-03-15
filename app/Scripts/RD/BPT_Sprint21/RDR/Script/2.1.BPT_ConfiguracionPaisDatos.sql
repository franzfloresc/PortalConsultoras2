
go
declare @ConfPaisId int = 0

select @ConfPaisId = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

if @ConfPaisId > 0
begin
	
	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @ConfPaisId

	delete from ConfiguracionPaisDetalle 
	where ConfiguracionPaisID = @ConfPaisId

	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, ''
		, 1
		, 1
	)

end
go
