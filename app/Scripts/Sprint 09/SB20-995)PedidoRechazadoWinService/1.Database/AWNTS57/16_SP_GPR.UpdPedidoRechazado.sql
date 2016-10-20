USE BelcorpBolivia
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

USE BelcorpChile
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

USE BelcorpCostaRica
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

USE BelcorpDominicana
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

USE BelcorpEcuador
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

USE BelcorpGuatemala
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

USE BelcorpPanama
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

USE BelcorpPuertoRico
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

USE BelcorpSalvador
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

USE BelcorpVenezuela
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