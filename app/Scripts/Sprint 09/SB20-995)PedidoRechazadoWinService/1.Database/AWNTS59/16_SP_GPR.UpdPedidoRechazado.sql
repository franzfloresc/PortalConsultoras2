USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdPedidoRechazado
END
GO
CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdPedidoRechazado BIGINT,
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE GPR.PedidoRechazado
	SET
		Procesado = 1,
		Rechazado = @Rechazado,
		CodigoRechazoSomosBelcorp = @CodigoRechazoSomosBelcorp
	WHERE IdPedidoRechazado = @IdPedidoRechazado;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdPedidoRechazado
END
GO
CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdPedidoRechazado BIGINT,
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE GPR.PedidoRechazado
	SET
		Procesado = 1,
		Rechazado = @Rechazado,
		CodigoRechazoSomosBelcorp = @CodigoRechazoSomosBelcorp
	WHERE IdPedidoRechazado = @IdPedidoRechazado;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdPedidoRechazado
END
GO
CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdPedidoRechazado BIGINT,
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE GPR.PedidoRechazado
	SET
		Procesado = 1,
		Rechazado = @Rechazado,
		CodigoRechazoSomosBelcorp = @CodigoRechazoSomosBelcorp
	WHERE IdPedidoRechazado = @IdPedidoRechazado;
END
GO