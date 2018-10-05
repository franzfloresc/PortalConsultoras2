--USE BelcorpPeru_BPT
--GO

USE BelcorpPeru
GO

PRINT DB_NAME()
GO

IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS 
				WHERE NAME = 'OfertasPersonalizadasCUV'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[OfertasPersonalizadasCUV]'
	DROP SYNONYM [ods].[OfertasPersonalizadasCUV]
END

PRINT 'CREANDO SINÓNIMO [ods].[OfertasPersonalizadasCUV]'
CREATE SYNONYM [ods].[OfertasPersonalizadasCUV] FOR [ODS_PE].[dbo].[OfertasPersonalizadasCUV]

GO

USE BelcorpMexico
GO

PRINT DB_NAME()
GO

IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS 
				WHERE NAME = 'OfertasPersonalizadasCUV'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[OfertasPersonalizadasCUV]'
	DROP SYNONYM [ods].[OfertasPersonalizadasCUV]
END

PRINT 'CREANDO SINÓNIMO [ods].[OfertasPersonalizadasCUV]'
CREATE SYNONYM [ods].[OfertasPersonalizadasCUV] FOR [ODS_MX].[dbo].[OfertasPersonalizadasCUV]

GO

USE BelcorpColombia
GO

PRINT DB_NAME()
GO

IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS 
				WHERE NAME = 'OfertasPersonalizadasCUV'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[OfertasPersonalizadasCUV]'
	DROP SYNONYM [ods].[OfertasPersonalizadasCUV]
END

PRINT 'CREANDO SINÓNIMO [ods].[OfertasPersonalizadasCUV]'
CREATE SYNONYM [ods].[OfertasPersonalizadasCUV] FOR [ODS_CO].[dbo].[OfertasPersonalizadasCUV]

GO

USE BelcorpSalvador
GO

PRINT DB_NAME()
GO

IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS 
				WHERE NAME = 'OfertasPersonalizadasCUV'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[OfertasPersonalizadasCUV]'
	DROP SYNONYM [ods].[OfertasPersonalizadasCUV]
END

PRINT 'CREANDO SINÓNIMO [ods].[OfertasPersonalizadasCUV]'
CREATE SYNONYM [ods].[OfertasPersonalizadasCUV] FOR [ODS_SV].[dbo].[OfertasPersonalizadasCUV]

GO

USE BelcorpPuertoRico
GO

PRINT DB_NAME()
GO

IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS 
				WHERE NAME = 'OfertasPersonalizadasCUV'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[OfertasPersonalizadasCUV]'
	DROP SYNONYM [ods].[OfertasPersonalizadasCUV]
END

PRINT 'CREANDO SINÓNIMO [ods].[OfertasPersonalizadasCUV]'
CREATE SYNONYM [ods].[OfertasPersonalizadasCUV] FOR [ODS_PR].[dbo].[OfertasPersonalizadasCUV]

GO

USE BelcorpPanama
GO

PRINT DB_NAME()
GO

IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS 
				WHERE NAME = 'OfertasPersonalizadasCUV'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[OfertasPersonalizadasCUV]'
	DROP SYNONYM [ods].[OfertasPersonalizadasCUV]
END

PRINT 'CREANDO SINÓNIMO [ods].[OfertasPersonalizadasCUV]'
CREATE SYNONYM [ods].[OfertasPersonalizadasCUV] FOR [ODS_PA].[dbo].[OfertasPersonalizadasCUV]

GO

USE BelcorpGuatemala
GO

PRINT DB_NAME()
GO

IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS 
				WHERE NAME = 'OfertasPersonalizadasCUV'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[OfertasPersonalizadasCUV]'
	DROP SYNONYM [ods].[OfertasPersonalizadasCUV]
END

PRINT 'CREANDO SINÓNIMO [ods].[OfertasPersonalizadasCUV]'
CREATE SYNONYM [ods].[OfertasPersonalizadasCUV] FOR [ODS_GT].[dbo].[OfertasPersonalizadasCUV]

GO

USE BelcorpEcuador
GO

PRINT DB_NAME()
GO

IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS 
				WHERE NAME = 'OfertasPersonalizadasCUV'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[OfertasPersonalizadasCUV]'
	DROP SYNONYM [ods].[OfertasPersonalizadasCUV]
END

PRINT 'CREANDO SINÓNIMO [ods].[OfertasPersonalizadasCUV]'
CREATE SYNONYM [ods].[OfertasPersonalizadasCUV] FOR [ODS_EC].[dbo].[OfertasPersonalizadasCUV]

GO

USE BelcorpDominicana
GO

PRINT DB_NAME()
GO

IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS 
				WHERE NAME = 'OfertasPersonalizadasCUV'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[OfertasPersonalizadasCUV]'
	DROP SYNONYM [ods].[OfertasPersonalizadasCUV]
END

PRINT 'CREANDO SINÓNIMO [ods].[OfertasPersonalizadasCUV]'
CREATE SYNONYM [ods].[OfertasPersonalizadasCUV] FOR [ODS_DO].[dbo].[OfertasPersonalizadasCUV]

GO

USE BelcorpCostaRica
GO

PRINT DB_NAME()
GO

IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS 
				WHERE NAME = 'OfertasPersonalizadasCUV'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[OfertasPersonalizadasCUV]'
	DROP SYNONYM [ods].[OfertasPersonalizadasCUV]
END

PRINT 'CREANDO SINÓNIMO [ods].[OfertasPersonalizadasCUV]'
CREATE SYNONYM [ods].[OfertasPersonalizadasCUV] FOR [ODS_CR].[dbo].[OfertasPersonalizadasCUV]

GO

USE BelcorpChile
GO

PRINT DB_NAME()
GO

IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS 
				WHERE NAME = 'OfertasPersonalizadasCUV'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[OfertasPersonalizadasCUV]'
	DROP SYNONYM [ods].[OfertasPersonalizadasCUV]
END

PRINT 'CREANDO SINÓNIMO [ods].[OfertasPersonalizadasCUV]'
CREATE SYNONYM [ods].[OfertasPersonalizadasCUV] FOR [ODS_CL].[dbo].[OfertasPersonalizadasCUV]

GO

USE BelcorpBolivia
GO

PRINT DB_NAME()
GO

IF EXISTS (	SELECT 1
				FROM SYS.OBJECTS 
				WHERE NAME = 'OfertasPersonalizadasCUV'
				AND TYPE = 'SN')
BEGIN
	PRINT 'ELIMINANDO SINONIMO [ods].[OfertasPersonalizadasCUV]'
	DROP SYNONYM [ods].[OfertasPersonalizadasCUV]
END

PRINT 'CREANDO SINÓNIMO [ods].[OfertasPersonalizadasCUV]'
CREATE SYNONYM [ods].[OfertasPersonalizadasCUV] FOR [ODS_BO].[dbo].[OfertasPersonalizadasCUV]

GO

