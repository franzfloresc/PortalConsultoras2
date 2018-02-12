USE BelcorpPeru
GO

print(DB_NAME())

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
		print('Elimando registros de ConfiguracionPaisDatos relacionados a RDI')
		delete cpd
		from ConfiguracionPaisDatos cpd
			join ConfiguracionPais cp 
			on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
			and cp.Codigo = 'RDI'
		
		print('Elimando registro RDI de ConfiguracionPais ')
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

print(DB_NAME())

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
		print('Elimando registros de ConfiguracionPaisDatos relacionados a RDI')
		delete cpd
		from ConfiguracionPaisDatos cpd
			join ConfiguracionPais cp 
			on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
			and cp.Codigo = 'RDI'
		
		print('Elimando registro RDI de ConfiguracionPais ')
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

print(DB_NAME())

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
		print('Elimando registros de ConfiguracionPaisDatos relacionados a RDI')
		delete cpd
		from ConfiguracionPaisDatos cpd
			join ConfiguracionPais cp 
			on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
			and cp.Codigo = 'RDI'
		
		print('Elimando registro RDI de ConfiguracionPais ')
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

print(DB_NAME())

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
		print('Elimando registros de ConfiguracionPaisDatos relacionados a RDI')
		delete cpd
		from ConfiguracionPaisDatos cpd
			join ConfiguracionPais cp 
			on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
			and cp.Codigo = 'RDI'
		
		print('Elimando registro RDI de ConfiguracionPais ')
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

print(DB_NAME())

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
		print('Elimando registros de ConfiguracionPaisDatos relacionados a RDI')
		delete cpd
		from ConfiguracionPaisDatos cpd
			join ConfiguracionPais cp 
			on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
			and cp.Codigo = 'RDI'
		
		print('Elimando registro RDI de ConfiguracionPais ')
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

print(DB_NAME())

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
		print('Elimando registros de ConfiguracionPaisDatos relacionados a RDI')
		delete cpd
		from ConfiguracionPaisDatos cpd
			join ConfiguracionPais cp 
			on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
			and cp.Codigo = 'RDI'
		
		print('Elimando registro RDI de ConfiguracionPais ')
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

print(DB_NAME())

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
		print('Elimando registros de ConfiguracionPaisDatos relacionados a RDI')
		delete cpd
		from ConfiguracionPaisDatos cpd
			join ConfiguracionPais cp 
			on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
			and cp.Codigo = 'RDI'
		
		print('Elimando registro RDI de ConfiguracionPais ')
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

print(DB_NAME())

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
		print('Elimando registros de ConfiguracionPaisDatos relacionados a RDI')
		delete cpd
		from ConfiguracionPaisDatos cpd
			join ConfiguracionPais cp 
			on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
			and cp.Codigo = 'RDI'
		
		print('Elimando registro RDI de ConfiguracionPais ')
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

print(DB_NAME())

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
		print('Elimando registros de ConfiguracionPaisDatos relacionados a RDI')
		delete cpd
		from ConfiguracionPaisDatos cpd
			join ConfiguracionPais cp 
			on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
			and cp.Codigo = 'RDI'
		
		print('Elimando registro RDI de ConfiguracionPais ')
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

print(DB_NAME())

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
		print('Elimando registros de ConfiguracionPaisDatos relacionados a RDI')
		delete cpd
		from ConfiguracionPaisDatos cpd
			join ConfiguracionPais cp 
			on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
			and cp.Codigo = 'RDI'
		
		print('Elimando registro RDI de ConfiguracionPais ')
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

print(DB_NAME())

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
		print('Elimando registros de ConfiguracionPaisDatos relacionados a RDI')
		delete cpd
		from ConfiguracionPaisDatos cpd
			join ConfiguracionPais cp 
			on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
			and cp.Codigo = 'RDI'
		
		print('Elimando registro RDI de ConfiguracionPais ')
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

print(DB_NAME())

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
		print('Elimando registros de ConfiguracionPaisDatos relacionados a RDI')
		delete cpd
		from ConfiguracionPaisDatos cpd
			join ConfiguracionPais cp 
			on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
			and cp.Codigo = 'RDI'
		
		print('Elimando registro RDI de ConfiguracionPais ')
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

print(DB_NAME())

IF EXISTS (SELECT 1 FROM CONFIGURACIONPAIS WHERE CODIGO = 'RDI')
BEGIN
	begin transaction [t1]

	begin try
		print('Elimando registros de ConfiguracionPaisDatos relacionados a RDI')
		delete cpd
		from ConfiguracionPaisDatos cpd
			join ConfiguracionPais cp 
			on cp.ConfiguracionPaisID = cpd.ConfiguracionPaisID
			and cp.Codigo = 'RDI'
		
		print('Elimando registro RDI de ConfiguracionPais ')
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

