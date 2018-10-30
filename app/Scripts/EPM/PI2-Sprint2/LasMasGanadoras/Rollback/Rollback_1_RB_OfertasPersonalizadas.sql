USE ODS_PE_BPT
GO

--use ODS_CL_BPT
--go

--use ODS_CR_BPT
--go

PRINT DB_NAME()

IF EXISTS (
	SELECT 1 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'OfertasPersonalizadas'
	AND C.NAME = 'MaterialGanancia'
	)
BEGIN
	PRINT 'ROLLBACK : ADD COLUM ''MaterialGanancia'' TO OfertasPersonalizadas'
	ALTER TABLE OfertasPersonalizadas
	DROP COLUMN MaterialGanancia
END

GO
