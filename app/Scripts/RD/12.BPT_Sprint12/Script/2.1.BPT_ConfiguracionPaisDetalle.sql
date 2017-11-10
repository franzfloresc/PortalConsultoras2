
Use BelcorpPeru

GO

declare @idConfiPaisDetalle int = 0

select @idConfiPaisDetalle = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'GND'

delete from ConfiguracionPaisDetalle
where ConfiguracionPaisID = @idConfiPaisDetalle

insert into ConfiguracionPaisDetalle (
	ConfiguracionPaisID,
	CodigoRegion, CodigoZona,
	CodigoSeccion, CodigoConsultora,
	Estado, BloqueoRevistaImpresa
)
values (
	@idConfiPaisDetalle,
	'70', NULL,
	NULL, NULL,
	1, NULL
)

insert into ConfiguracionPaisDetalle (
	ConfiguracionPaisID,
	CodigoRegion, CodigoZona,
	CodigoSeccion, CodigoConsultora,
	Estado, BloqueoRevistaImpresa
)
values (
	@idConfiPaisDetalle,
	'80', NULL,
	NULL, NULL,
	1, NULL
)

GO
