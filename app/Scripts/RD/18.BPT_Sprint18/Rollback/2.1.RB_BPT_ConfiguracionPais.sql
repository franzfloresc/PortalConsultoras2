USE BelcorpPeru
GO

GO

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
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
		print('Se produjo un error ...')
		print('Rollback ...')
		rollback transaction [t1]
	end catch
END
GO

USE BelcorpMexico
GO

GO

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
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
		print('Se produjo un error ...')
		print('Rollback ...')
		rollback transaction [t1]
	end catch
END
GO

USE BelcorpColombia
GO

GO

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
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
		print('Se produjo un error ...')
		print('Rollback ...')
		rollback transaction [t1]
	end catch
END
GO

USE BelcorpVenezuela
GO

GO

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
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
		print('Se produjo un error ...')
		print('Rollback ...')
		rollback transaction [t1]
	end catch
END
GO

USE BelcorpSalvador
GO

GO

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
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
		print('Se produjo un error ...')
		print('Rollback ...')
		rollback transaction [t1]
	end catch
END
GO

USE BelcorpPuertoRico
GO

GO

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
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
		print('Se produjo un error ...')
		print('Rollback ...')
		rollback transaction [t1]
	end catch
END
GO

USE BelcorpPanama
GO

GO

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
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
		print('Se produjo un error ...')
		print('Rollback ...')
		rollback transaction [t1]
	end catch
END
GO

USE BelcorpGuatemala
GO

GO

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
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
		print('Se produjo un error ...')
		print('Rollback ...')
		rollback transaction [t1]
	end catch
END
GO

USE BelcorpEcuador
GO

GO

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
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
		print('Se produjo un error ...')
		print('Rollback ...')
		rollback transaction [t1]
	end catch
END
GO

USE BelcorpDominicana
GO

GO

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
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
		print('Se produjo un error ...')
		print('Rollback ...')
		rollback transaction [t1]
	end catch
END
GO

USE BelcorpCostaRica
GO

GO

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
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
		print('Se produjo un error ...')
		print('Rollback ...')
		rollback transaction [t1]
	end catch
END
GO

USE BelcorpChile
GO

GO

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
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
		print('Se produjo un error ...')
		print('Rollback ...')
		rollback transaction [t1]
	end catch
END
GO

USE BelcorpBolivia
GO

GO

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
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
		print('Se produjo un error ...')
		print('Rollback ...')
		rollback transaction [t1]
	end catch
END
GO

