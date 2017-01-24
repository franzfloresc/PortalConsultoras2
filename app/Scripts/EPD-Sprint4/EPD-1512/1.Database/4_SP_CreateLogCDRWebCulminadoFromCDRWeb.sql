USE BelcorpBolivia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CreateLogCDRWebCulminadoFromCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
END
GO
CREATE PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
	@CDRWebId INT
AS
BEGIN
	INSERT INTO LogCDRWebCulminado(
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	)
	SELECT
		CDRW.CDRWebId,
		CDRW.PedidoID,
		CDRW.PedidoNumero,
		CDRW.CampaniaID,
		CDRW.ConsultoraID,
		CDRW.FechaRegistro,
		CDRW.FechaCulminado
	FROM CDRWeb CDRW
	WHERE CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2

	DECLARE @LogCDRWebCulminadoId BIGINT = SCOPE_IDENTITY();

	INSERT INTO LogCDRWebDetalleCulminado(
		LogCDRWebCulminadoId,
		CodigoOperacion,
		CodigoReclamo,
		CUV,
		Cantidad,
		CUV2,
		Cantidad2,
		FechaRegistro
	)
	SELECT
		@LogCDRWebCulminadoId,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		CDRWD.CUV2,
		CDRWD.Cantidad2,
		CDRWD.FechaRegistro
	FROM CDRWeb CDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = CDRW.CDRWebId
	WHERE
		CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2
		AND
		CDRWD.Eliminado = 0;
END
GO
/*end*/

USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CreateLogCDRWebCulminadoFromCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
END
GO
CREATE PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
	@CDRWebId INT
AS
BEGIN
	INSERT INTO LogCDRWebCulminado(
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	)
	SELECT
		CDRW.CDRWebId,
		CDRW.PedidoID,
		CDRW.PedidoNumero,
		CDRW.CampaniaID,
		CDRW.ConsultoraID,
		CDRW.FechaRegistro,
		CDRW.FechaCulminado
	FROM CDRWeb CDRW
	WHERE CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2

	DECLARE @LogCDRWebCulminadoId BIGINT = SCOPE_IDENTITY();

	INSERT INTO LogCDRWebDetalleCulminado(
		LogCDRWebCulminadoId,
		CodigoOperacion,
		CodigoReclamo,
		CUV,
		Cantidad,
		CUV2,
		Cantidad2,
		FechaRegistro
	)
	SELECT
		@LogCDRWebCulminadoId,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		CDRWD.CUV2,
		CDRWD.Cantidad2,
		CDRWD.FechaRegistro
	FROM CDRWeb CDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = CDRW.CDRWebId
	WHERE
		CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2
		AND
		CDRWD.Eliminado = 0;
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CreateLogCDRWebCulminadoFromCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
END
GO
CREATE PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
	@CDRWebId INT
AS
BEGIN
	INSERT INTO LogCDRWebCulminado(
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	)
	SELECT
		CDRW.CDRWebId,
		CDRW.PedidoID,
		CDRW.PedidoNumero,
		CDRW.CampaniaID,
		CDRW.ConsultoraID,
		CDRW.FechaRegistro,
		CDRW.FechaCulminado
	FROM CDRWeb CDRW
	WHERE CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2

	DECLARE @LogCDRWebCulminadoId BIGINT = SCOPE_IDENTITY();

	INSERT INTO LogCDRWebDetalleCulminado(
		LogCDRWebCulminadoId,
		CodigoOperacion,
		CodigoReclamo,
		CUV,
		Cantidad,
		CUV2,
		Cantidad2,
		FechaRegistro
	)
	SELECT
		@LogCDRWebCulminadoId,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		CDRWD.CUV2,
		CDRWD.Cantidad2,
		CDRWD.FechaRegistro
	FROM CDRWeb CDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = CDRW.CDRWebId
	WHERE
		CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2
		AND
		CDRWD.Eliminado = 0;
END
GO
/*end*/

USE BelcorpDominicana
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CreateLogCDRWebCulminadoFromCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
END
GO
CREATE PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
	@CDRWebId INT
AS
BEGIN
	INSERT INTO LogCDRWebCulminado(
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	)
	SELECT
		CDRW.CDRWebId,
		CDRW.PedidoID,
		CDRW.PedidoNumero,
		CDRW.CampaniaID,
		CDRW.ConsultoraID,
		CDRW.FechaRegistro,
		CDRW.FechaCulminado
	FROM CDRWeb CDRW
	WHERE CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2

	DECLARE @LogCDRWebCulminadoId BIGINT = SCOPE_IDENTITY();

	INSERT INTO LogCDRWebDetalleCulminado(
		LogCDRWebCulminadoId,
		CodigoOperacion,
		CodigoReclamo,
		CUV,
		Cantidad,
		CUV2,
		Cantidad2,
		FechaRegistro
	)
	SELECT
		@LogCDRWebCulminadoId,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		CDRWD.CUV2,
		CDRWD.Cantidad2,
		CDRWD.FechaRegistro
	FROM CDRWeb CDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = CDRW.CDRWebId
	WHERE
		CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2
		AND
		CDRWD.Eliminado = 0;
END
GO
/*end*/

USE BelcorpEcuador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CreateLogCDRWebCulminadoFromCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
END
GO
CREATE PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
	@CDRWebId INT
AS
BEGIN
	INSERT INTO LogCDRWebCulminado(
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	)
	SELECT
		CDRW.CDRWebId,
		CDRW.PedidoID,
		CDRW.PedidoNumero,
		CDRW.CampaniaID,
		CDRW.ConsultoraID,
		CDRW.FechaRegistro,
		CDRW.FechaCulminado
	FROM CDRWeb CDRW
	WHERE CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2

	DECLARE @LogCDRWebCulminadoId BIGINT = SCOPE_IDENTITY();

	INSERT INTO LogCDRWebDetalleCulminado(
		LogCDRWebCulminadoId,
		CodigoOperacion,
		CodigoReclamo,
		CUV,
		Cantidad,
		CUV2,
		Cantidad2,
		FechaRegistro
	)
	SELECT
		@LogCDRWebCulminadoId,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		CDRWD.CUV2,
		CDRWD.Cantidad2,
		CDRWD.FechaRegistro
	FROM CDRWeb CDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = CDRW.CDRWebId
	WHERE
		CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2
		AND
		CDRWD.Eliminado = 0;
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CreateLogCDRWebCulminadoFromCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
END
GO
CREATE PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
	@CDRWebId INT
AS
BEGIN
	INSERT INTO LogCDRWebCulminado(
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	)
	SELECT
		CDRW.CDRWebId,
		CDRW.PedidoID,
		CDRW.PedidoNumero,
		CDRW.CampaniaID,
		CDRW.ConsultoraID,
		CDRW.FechaRegistro,
		CDRW.FechaCulminado
	FROM CDRWeb CDRW
	WHERE CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2

	DECLARE @LogCDRWebCulminadoId BIGINT = SCOPE_IDENTITY();

	INSERT INTO LogCDRWebDetalleCulminado(
		LogCDRWebCulminadoId,
		CodigoOperacion,
		CodigoReclamo,
		CUV,
		Cantidad,
		CUV2,
		Cantidad2,
		FechaRegistro
	)
	SELECT
		@LogCDRWebCulminadoId,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		CDRWD.CUV2,
		CDRWD.Cantidad2,
		CDRWD.FechaRegistro
	FROM CDRWeb CDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = CDRW.CDRWebId
	WHERE
		CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2
		AND
		CDRWD.Eliminado = 0;
END
GO
/*end*/

USE BelcorpPanama
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CreateLogCDRWebCulminadoFromCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
END
GO
CREATE PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
	@CDRWebId INT
AS
BEGIN
	INSERT INTO LogCDRWebCulminado(
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	)
	SELECT
		CDRW.CDRWebId,
		CDRW.PedidoID,
		CDRW.PedidoNumero,
		CDRW.CampaniaID,
		CDRW.ConsultoraID,
		CDRW.FechaRegistro,
		CDRW.FechaCulminado
	FROM CDRWeb CDRW
	WHERE CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2

	DECLARE @LogCDRWebCulminadoId BIGINT = SCOPE_IDENTITY();

	INSERT INTO LogCDRWebDetalleCulminado(
		LogCDRWebCulminadoId,
		CodigoOperacion,
		CodigoReclamo,
		CUV,
		Cantidad,
		CUV2,
		Cantidad2,
		FechaRegistro
	)
	SELECT
		@LogCDRWebCulminadoId,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		CDRWD.CUV2,
		CDRWD.Cantidad2,
		CDRWD.FechaRegistro
	FROM CDRWeb CDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = CDRW.CDRWebId
	WHERE
		CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2
		AND
		CDRWD.Eliminado = 0;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CreateLogCDRWebCulminadoFromCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
END
GO
CREATE PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
	@CDRWebId INT
AS
BEGIN
	INSERT INTO LogCDRWebCulminado(
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	)
	SELECT
		CDRW.CDRWebId,
		CDRW.PedidoID,
		CDRW.PedidoNumero,
		CDRW.CampaniaID,
		CDRW.ConsultoraID,
		CDRW.FechaRegistro,
		CDRW.FechaCulminado
	FROM CDRWeb CDRW
	WHERE CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2

	DECLARE @LogCDRWebCulminadoId BIGINT = SCOPE_IDENTITY();

	INSERT INTO LogCDRWebDetalleCulminado(
		LogCDRWebCulminadoId,
		CodigoOperacion,
		CodigoReclamo,
		CUV,
		Cantidad,
		CUV2,
		Cantidad2,
		FechaRegistro
	)
	SELECT
		@LogCDRWebCulminadoId,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		CDRWD.CUV2,
		CDRWD.Cantidad2,
		CDRWD.FechaRegistro
	FROM CDRWeb CDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = CDRW.CDRWebId
	WHERE
		CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2
		AND
		CDRWD.Eliminado = 0;
END
GO
/*end*/

USE BelcorpSalvador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CreateLogCDRWebCulminadoFromCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
END
GO
CREATE PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
	@CDRWebId INT
AS
BEGIN
	INSERT INTO LogCDRWebCulminado(
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	)
	SELECT
		CDRW.CDRWebId,
		CDRW.PedidoID,
		CDRW.PedidoNumero,
		CDRW.CampaniaID,
		CDRW.ConsultoraID,
		CDRW.FechaRegistro,
		CDRW.FechaCulminado
	FROM CDRWeb CDRW
	WHERE CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2

	DECLARE @LogCDRWebCulminadoId BIGINT = SCOPE_IDENTITY();

	INSERT INTO LogCDRWebDetalleCulminado(
		LogCDRWebCulminadoId,
		CodigoOperacion,
		CodigoReclamo,
		CUV,
		Cantidad,
		CUV2,
		Cantidad2,
		FechaRegistro
	)
	SELECT
		@LogCDRWebCulminadoId,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		CDRWD.CUV2,
		CDRWD.Cantidad2,
		CDRWD.FechaRegistro
	FROM CDRWeb CDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = CDRW.CDRWebId
	WHERE
		CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2
		AND
		CDRWD.Eliminado = 0;
END
GO
/*end*/

USE BelcorpVenezuela
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CreateLogCDRWebCulminadoFromCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
END
GO
CREATE PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
	@CDRWebId INT
AS
BEGIN
	INSERT INTO LogCDRWebCulminado(
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	)
	SELECT
		CDRW.CDRWebId,
		CDRW.PedidoID,
		CDRW.PedidoNumero,
		CDRW.CampaniaID,
		CDRW.ConsultoraID,
		CDRW.FechaRegistro,
		CDRW.FechaCulminado
	FROM CDRWeb CDRW
	WHERE CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2

	DECLARE @LogCDRWebCulminadoId BIGINT = SCOPE_IDENTITY();

	INSERT INTO LogCDRWebDetalleCulminado(
		LogCDRWebCulminadoId,
		CodigoOperacion,
		CodigoReclamo,
		CUV,
		Cantidad,
		CUV2,
		Cantidad2,
		FechaRegistro
	)
	SELECT
		@LogCDRWebCulminadoId,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		CDRWD.CUV2,
		CDRWD.Cantidad2,
		CDRWD.FechaRegistro
	FROM CDRWeb CDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = CDRW.CDRWebId
	WHERE
		CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2
		AND
		CDRWD.Eliminado = 0;
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CreateLogCDRWebCulminadoFromCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
END
GO
CREATE PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
	@CDRWebId INT
AS
BEGIN
	INSERT INTO LogCDRWebCulminado(
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	)
	SELECT
		CDRW.CDRWebId,
		CDRW.PedidoID,
		CDRW.PedidoNumero,
		CDRW.CampaniaID,
		CDRW.ConsultoraID,
		CDRW.FechaRegistro,
		CDRW.FechaCulminado
	FROM CDRWeb CDRW
	WHERE CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2

	DECLARE @LogCDRWebCulminadoId BIGINT = SCOPE_IDENTITY();

	INSERT INTO LogCDRWebDetalleCulminado(
		LogCDRWebCulminadoId,
		CodigoOperacion,
		CodigoReclamo,
		CUV,
		Cantidad,
		CUV2,
		Cantidad2,
		FechaRegistro
	)
	SELECT
		@LogCDRWebCulminadoId,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		CDRWD.CUV2,
		CDRWD.Cantidad2,
		CDRWD.FechaRegistro
	FROM CDRWeb CDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = CDRW.CDRWebId
	WHERE
		CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2
		AND
		CDRWD.Eliminado = 0;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CreateLogCDRWebCulminadoFromCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
END
GO
CREATE PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
	@CDRWebId INT
AS
BEGIN
	INSERT INTO LogCDRWebCulminado(
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	)
	SELECT
		CDRW.CDRWebId,
		CDRW.PedidoID,
		CDRW.PedidoNumero,
		CDRW.CampaniaID,
		CDRW.ConsultoraID,
		CDRW.FechaRegistro,
		CDRW.FechaCulminado
	FROM CDRWeb CDRW
	WHERE CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2

	DECLARE @LogCDRWebCulminadoId BIGINT = SCOPE_IDENTITY();

	INSERT INTO LogCDRWebDetalleCulminado(
		LogCDRWebCulminadoId,
		CodigoOperacion,
		CodigoReclamo,
		CUV,
		Cantidad,
		CUV2,
		Cantidad2,
		FechaRegistro
	)
	SELECT
		@LogCDRWebCulminadoId,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		CDRWD.CUV2,
		CDRWD.Cantidad2,
		CDRWD.FechaRegistro
	FROM CDRWeb CDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = CDRW.CDRWebId
	WHERE
		CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2
		AND
		CDRWD.Eliminado = 0;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CreateLogCDRWebCulminadoFromCDRWeb' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
END
GO
CREATE PROCEDURE dbo.CreateLogCDRWebCulminadoFromCDRWeb
	@CDRWebId INT
AS
BEGIN
	INSERT INTO LogCDRWebCulminado(
		CDRWebId,
		PedidoID,
		PedidoNumero,
		CampaniaID,
		ConsultoraID,
		FechaRegistro,
		FechaCulminado
	)
	SELECT
		CDRW.CDRWebId,
		CDRW.PedidoID,
		CDRW.PedidoNumero,
		CDRW.CampaniaID,
		CDRW.ConsultoraID,
		CDRW.FechaRegistro,
		CDRW.FechaCulminado
	FROM CDRWeb CDRW
	WHERE CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2

	DECLARE @LogCDRWebCulminadoId BIGINT = SCOPE_IDENTITY();

	INSERT INTO LogCDRWebDetalleCulminado(
		LogCDRWebCulminadoId,
		CodigoOperacion,
		CodigoReclamo,
		CUV,
		Cantidad,
		CUV2,
		Cantidad2,
		FechaRegistro
	)
	SELECT
		@LogCDRWebCulminadoId,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		CDRWD.CUV2,
		CDRWD.Cantidad2,
		CDRWD.FechaRegistro
	FROM CDRWeb CDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = CDRW.CDRWebId
	WHERE
		CDRW.CDRWebID = @CDRWebId AND CDRW.Estado = 2
		AND
		CDRWD.Eliminado = 0;
END
GO