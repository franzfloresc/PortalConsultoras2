--USE ODS_PE_BPT
--GO

USE ODS_PE
GO

PRINT DB_NAME()
GO

IF EXISTS(	SELECT 1
			FROM SYS.TABLES T
			WHERE T.TYPE = 'U'
			AND T.NAME = 'OfertasPersonalizadasCUV')
BEGIN 
	PRINT 'ELIMINANDO TABLA OfertasPersonalizadasCUV'
	DROP TABLE OfertasPersonalizadasCUV
END

PRINT 'CREANDO TABLA OfertasPersonalizadasCUV'

CREATE TABLE dbo.OfertasPersonalizadasCUV (
	AnioCampanaVenta INT
	,TipoPersonalizacion VARCHAR(10)
	,CUV VARCHAR(6)
	,FlagUltMinuto INT
	,LimUnidades INT
	,CONSTRAINT PK_OfertasPersonalizadasCUV PRIMARY KEY (AnioCampanaVenta, TipoPersonalizacion, CUV)
)

GO