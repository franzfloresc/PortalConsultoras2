USE BelcorpBolivia
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

USE BelcorpChile
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

USE BelcorpCostaRica
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

USE BelcorpDominicana
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

USE BelcorpEcuador
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

USE BelcorpGuatemala
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

USE BelcorpPanama
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

USE BelcorpPuertoRico
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

USE BelcorpSalvador
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

USE BelcorpVenezuela
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