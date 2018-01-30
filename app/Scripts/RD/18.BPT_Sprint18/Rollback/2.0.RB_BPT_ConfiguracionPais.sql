USE BelcorpChile_BPT
GO

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
		update ConfiguracionPais
		set 
		Estado = 1
		where Codigo = 'RD'

		delete cpd
		from ConfiguracionPaisDatos cpd
			join ConfiguracionPais cp 
			on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
			and cp.Codigo = 'RDI'

		delete 
		from ConfiguracionPais
		where Codigo = 'RDI'

		commit transaction [t1]
	end try
	begin catch
		rollback transaction [t1]
	end catch
END
GO