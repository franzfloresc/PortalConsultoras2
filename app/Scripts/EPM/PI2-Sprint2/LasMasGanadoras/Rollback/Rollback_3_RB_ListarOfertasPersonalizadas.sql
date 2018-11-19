USE BelcorpPeru_BPT
GO

--USE BelcorpChile_BPT
--GO

--USE BelcorpCostaRica_BPT
--GO
PRINT DB_NAME()

IF EXISTS (	SELECT 1
			FROM SYS.objects SO
			WHERE SO.[name] = 'ListarOfertasPersonalizadas'
			AND SO.[type] = 'P'	)
BEGIN
	PRINT 'ROLLBACK : DROP PROCEDURE ''ListarOfertasPersonalizadas'''
	DROP PROCEDURE ListarOfertasPersonalizadas
END

GO 

