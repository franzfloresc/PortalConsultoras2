
declare @idConfiPaisDetalle int = 0

select @idConfiPaisDetalle = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'GND'

delete from ConfiguracionPaisDetalle
where ConfiguracionPaisID = @idConfiPaisDetalle

delete from ConfiguracionOfertasHome
where ConfiguracionPaisID = @idConfiPaisDetalle

delete from ConfiguracionPais
where ConfiguracionPaisID = @idConfiPaisDetalle

