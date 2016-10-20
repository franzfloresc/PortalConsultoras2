USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetLogGPRValidacionByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN		
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		PR.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON PR.IdPedidoRechazado = LGPRV.IdPedidoRechazado
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetLogGPRValidacionByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN		
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		PR.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON PR.IdPedidoRechazado = LGPRV.IdPedidoRechazado
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetLogGPRValidacionByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN		
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		PR.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON PR.IdPedidoRechazado = LGPRV.IdPedidoRechazado
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO