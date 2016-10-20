USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.GetLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN		
	SELECT
		LogGPRValidacionDetalleId,
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta
	FROM GPR.LogGPRValidacionDetalle
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.GetLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN		
	SELECT
		LogGPRValidacionDetalleId,
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta
	FROM GPR.LogGPRValidacionDetalle
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.GetLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN		
	SELECT
		LogGPRValidacionDetalleId,
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta
	FROM GPR.LogGPRValidacionDetalle
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO