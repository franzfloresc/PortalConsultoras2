USE ODS_PE_BPT
GO

PRINT DB_NAME()
GO

IF NOT EXISTS(	SELECT 1
				FROM SYS.TABLES T
				WHERE T.TYPE = 'U'
				AND T.NAME = 'OfertasPersonalizadasCUV')
BEGIN 
	PRINT 'Creando tabla OfertasPersonalizadasCUV'
	CREATE TABLE OfertasPersonalizadasCUV(
		AnioCampanaVenta		INT
		,TipoPersonalizacion	CHAR(3)
		,CUV					CHAR(6)
		,FlagUltMinuto			INT
		,LimUnidades			INT
	)
END