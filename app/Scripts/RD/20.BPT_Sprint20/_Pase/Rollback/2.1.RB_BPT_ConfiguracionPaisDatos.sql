
GO

	declare @RevistaDigitalId int = 0
	declare @RevistaDigitalCodigo varchar(30) = 'RD'

	declare @datoCodigo varchar(100) = 'ActivoMDO'

	select @RevistaDigitalId = cp.ConfiguracionPaisID
	from ConfiguracionPais cp
	where cp.Codigo = @RevistaDigitalCodigo

	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @RevistaDigitalId
	and codigo = @datoCodigo

GO