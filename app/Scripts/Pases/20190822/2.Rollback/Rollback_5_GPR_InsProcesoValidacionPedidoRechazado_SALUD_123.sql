USE BelcorpBolivia
GO
IF OBJECT_ID('GPR.InsProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
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

USE BelcorpChile
GO
IF OBJECT_ID('GPR.InsProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
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

USE BelcorpColombia
GO
IF OBJECT_ID('GPR.InsProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
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

USE BelcorpCostaRica
GO
IF OBJECT_ID('GPR.InsProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
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

USE BelcorpDominicana
GO
IF OBJECT_ID('GPR.InsProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
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

USE BelcorpEcuador
GO
IF OBJECT_ID('GPR.InsProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
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

USE BelcorpGuatemala
GO
IF OBJECT_ID('GPR.InsProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
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

USE BelcorpMexico
GO
IF OBJECT_ID('GPR.InsProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
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

USE BelcorpPanama
GO
IF OBJECT_ID('GPR.InsProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
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

USE BelcorpPeru
GO
IF OBJECT_ID('GPR.InsProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
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

USE BelcorpPuertoRico
GO
IF OBJECT_ID('GPR.InsProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
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

USE BelcorpSalvador
GO
IF OBJECT_ID('GPR.InsProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
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