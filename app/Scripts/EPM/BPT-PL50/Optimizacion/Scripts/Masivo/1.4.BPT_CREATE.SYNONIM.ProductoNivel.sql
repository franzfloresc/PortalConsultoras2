USE BelcorpPeru_BPT
GO

--USE BelcorpPeru
--GO

PRINT DB_NAME()
GO

IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS 
				WHERE NAME = 'ProductoNivel'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[ProductoNivel]'
	DROP SYNONYM [ods].ProductoNivel
END

PRINT 'CREANDO SINÓNIMO [ods].[ProductoNivel]'
CREATE SYNONYM [ods].ProductoNivel FOR [ODS_PE_BPT].[dbo].ProductoNivel

GO