USE BelcorpPeru_BPT
GO

PRINT DB_NAME()
IF EXISTS(	SELECT * 
			FROM SYS.OBJECTS SO
			WHERE SO.NAME = 'ActualizarTonos_CargaEstrategiaProductoTemporal'
			AND SO.[TYPE] = 'P')
BEGIN
	PRINT 'Eliminando Procedure : ActualizarTonos_CargaEstrategiaProductoTemporal'
	DROP PROCEDURE ActualizarTonos_CargaEstrategiaProductoTemporal
END
GO