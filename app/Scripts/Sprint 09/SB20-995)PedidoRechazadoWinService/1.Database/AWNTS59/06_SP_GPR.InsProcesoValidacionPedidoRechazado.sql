USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
END
GO
CREATE PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
	@CodigoProceso VARCHAR(6)
AS
BEGIN
	INSERT INTO GPR.ProcesoValidacionPedidoRechazado(CodigoProceso,FechaHoraInicio,Estado)
	VALUES(@CodigoProceso,getdate(),1);

	select SCOPE_IDENTITY();
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
END
GO
CREATE PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
	@CodigoProceso VARCHAR(6)
AS
BEGIN
	INSERT INTO GPR.ProcesoValidacionPedidoRechazado(CodigoProceso,FechaHoraInicio,Estado)
	VALUES(@CodigoProceso,getdate(),1);

	select SCOPE_IDENTITY();
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
END
GO
CREATE PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
	@CodigoProceso VARCHAR(6)
AS
BEGIN
	INSERT INTO GPR.ProcesoValidacionPedidoRechazado(CodigoProceso,FechaHoraInicio,Estado)
	VALUES(@CodigoProceso,getdate(),1);

	select SCOPE_IDENTITY();
END
GO