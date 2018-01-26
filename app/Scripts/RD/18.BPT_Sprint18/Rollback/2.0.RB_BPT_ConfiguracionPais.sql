USE BelcorpChile_BPT
GO

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN

	update ConfiguracionPais
	set 
	Estado = 1
	where Codigo = 'RD'

	delete 
	from ConfiguracionPais
	where Codigo = 'RDI'
END
GO