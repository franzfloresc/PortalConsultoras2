USE BelcorpBolivia
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

USE BelcorpChile
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

USE BelcorpCostaRica
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

USE BelcorpDominicana
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

USE BelcorpEcuador
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

USE BelcorpGuatemala
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

USE BelcorpPanama
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

USE BelcorpPuertoRico
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

USE BelcorpSalvador
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

USE BelcorpVenezuela
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