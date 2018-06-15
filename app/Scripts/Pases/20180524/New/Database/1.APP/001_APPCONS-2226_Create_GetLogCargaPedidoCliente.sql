USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.GetLogCargaPedidoCliente', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.GetLogCargaPedidoCliente
GO
CREATE PROCEDURE dbo.GetLogCargaPedidoCliente
@NroLote INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoISOProd VARCHAR(3),
			@PaisID INT

	DECLARE @TBL_LOG_PEDIDO TABLE
	(
		PedidoID INT NOT NULL,
		Origen CHAR(1) NOT NULL,
		FechaFacturacion DATE NOT NULL

		PRIMARY KEY(PedidoID, Origen)
	)

	SELECT TOP 1
		@PaisID = PaisID
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	SELECT TOP 1
		@CodigoISOProd = CodigoISOProd
	FROM BelcorpPeru.dbo.Pais (NOLOCK)
	WHERE PaisID = @PaisID

	INSERT INTO @TBL_LOG_PEDIDO
	(
		PedidoID,
		Origen,
		FechaFacturacion
	)
	SELECT 
		PedidoID,
		Origen,
		FechaFacturacion
	FROM dbo.LogCargaPedido (NOLOCK) 
	WHERE NroLote = @NroLote

	SELECT 
		@CodigoISOProd AS PaisISO,
		PWD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PWD.CUV,
		PWD.Cantidad,
		ISNULL(CLI.CodigoCliente, 0) AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoWebDetalle PWD (NOLOCK)
	ON TBL.PedidoID = PWD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PWD.ConsultoraID
	LEFT JOIN dbo.Cliente CLI (NOLOCK)
	ON CLI.ConsultoraID = PWD.ConsultoraID
	AND CLI.ClienteID = PWD.ClienteID
	WHERE TBL.Origen = 'W'

	UNION ALL

	SELECT 
		@CodigoISOProd AS PaisISO,
		PDD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PDD.CUV,
		PDD.Cantidad,
		0 AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoDDDetalle PDD (NOLOCK)
	ON TBL.PedidoID = PDD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PDD.ConsultoraID
	WHERE TBL.Origen = 'D'

	SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( 'dbo.GetLogCargaPedidoCliente', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.GetLogCargaPedidoCliente
GO
CREATE PROCEDURE dbo.GetLogCargaPedidoCliente
@NroLote INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoISOProd VARCHAR(3),
			@PaisID INT

	DECLARE @TBL_LOG_PEDIDO TABLE
	(
		PedidoID INT NOT NULL,
		Origen CHAR(1) NOT NULL,
		FechaFacturacion DATE NOT NULL

		PRIMARY KEY(PedidoID, Origen)
	)

	SELECT TOP 1
		@PaisID = PaisID
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	SELECT TOP 1
		@CodigoISOProd = CodigoISOProd
	FROM BelcorpPeru.dbo.Pais (NOLOCK)
	WHERE PaisID = @PaisID

	INSERT INTO @TBL_LOG_PEDIDO
	(
		PedidoID,
		Origen,
		FechaFacturacion
	)
	SELECT 
		PedidoID,
		Origen,
		FechaFacturacion
	FROM dbo.LogCargaPedido (NOLOCK) 
	WHERE NroLote = @NroLote

	SELECT 
		@CodigoISOProd AS PaisISO,
		PWD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PWD.CUV,
		PWD.Cantidad,
		ISNULL(CLI.CodigoCliente, 0) AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoWebDetalle PWD (NOLOCK)
	ON TBL.PedidoID = PWD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PWD.ConsultoraID
	LEFT JOIN dbo.Cliente CLI (NOLOCK)
	ON CLI.ConsultoraID = PWD.ConsultoraID
	AND CLI.ClienteID = PWD.ClienteID
	WHERE TBL.Origen = 'W'

	UNION ALL

	SELECT 
		@CodigoISOProd AS PaisISO,
		PDD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PDD.CUV,
		PDD.Cantidad,
		0 AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoDDDetalle PDD (NOLOCK)
	ON TBL.PedidoID = PDD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PDD.ConsultoraID
	WHERE TBL.Origen = 'D'

	SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( 'dbo.GetLogCargaPedidoCliente', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.GetLogCargaPedidoCliente
GO
CREATE PROCEDURE dbo.GetLogCargaPedidoCliente
@NroLote INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoISOProd VARCHAR(3),
			@PaisID INT

	DECLARE @TBL_LOG_PEDIDO TABLE
	(
		PedidoID INT NOT NULL,
		Origen CHAR(1) NOT NULL,
		FechaFacturacion DATE NOT NULL

		PRIMARY KEY(PedidoID, Origen)
	)

	SELECT TOP 1
		@PaisID = PaisID
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	SELECT TOP 1
		@CodigoISOProd = CodigoISOProd
	FROM BelcorpPeru.dbo.Pais (NOLOCK)
	WHERE PaisID = @PaisID

	INSERT INTO @TBL_LOG_PEDIDO
	(
		PedidoID,
		Origen,
		FechaFacturacion
	)
	SELECT 
		PedidoID,
		Origen,
		FechaFacturacion
	FROM dbo.LogCargaPedido (NOLOCK) 
	WHERE NroLote = @NroLote

	SELECT 
		@CodigoISOProd AS PaisISO,
		PWD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PWD.CUV,
		PWD.Cantidad,
		ISNULL(CLI.CodigoCliente, 0) AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoWebDetalle PWD (NOLOCK)
	ON TBL.PedidoID = PWD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PWD.ConsultoraID
	LEFT JOIN dbo.Cliente CLI (NOLOCK)
	ON CLI.ConsultoraID = PWD.ConsultoraID
	AND CLI.ClienteID = PWD.ClienteID
	WHERE TBL.Origen = 'W'

	UNION ALL

	SELECT 
		@CodigoISOProd AS PaisISO,
		PDD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PDD.CUV,
		PDD.Cantidad,
		0 AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoDDDetalle PDD (NOLOCK)
	ON TBL.PedidoID = PDD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PDD.ConsultoraID
	WHERE TBL.Origen = 'D'

	SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( 'dbo.GetLogCargaPedidoCliente', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.GetLogCargaPedidoCliente
GO
CREATE PROCEDURE dbo.GetLogCargaPedidoCliente
@NroLote INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoISOProd VARCHAR(3),
			@PaisID INT

	DECLARE @TBL_LOG_PEDIDO TABLE
	(
		PedidoID INT NOT NULL,
		Origen CHAR(1) NOT NULL,
		FechaFacturacion DATE NOT NULL

		PRIMARY KEY(PedidoID, Origen)
	)

	SELECT TOP 1
		@PaisID = PaisID
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	SELECT TOP 1
		@CodigoISOProd = CodigoISOProd
	FROM BelcorpPeru.dbo.Pais (NOLOCK)
	WHERE PaisID = @PaisID

	INSERT INTO @TBL_LOG_PEDIDO
	(
		PedidoID,
		Origen,
		FechaFacturacion
	)
	SELECT 
		PedidoID,
		Origen,
		FechaFacturacion
	FROM dbo.LogCargaPedido (NOLOCK) 
	WHERE NroLote = @NroLote

	SELECT 
		@CodigoISOProd AS PaisISO,
		PWD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PWD.CUV,
		PWD.Cantidad,
		ISNULL(CLI.CodigoCliente, 0) AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoWebDetalle PWD (NOLOCK)
	ON TBL.PedidoID = PWD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PWD.ConsultoraID
	LEFT JOIN dbo.Cliente CLI (NOLOCK)
	ON CLI.ConsultoraID = PWD.ConsultoraID
	AND CLI.ClienteID = PWD.ClienteID
	WHERE TBL.Origen = 'W'

	UNION ALL

	SELECT 
		@CodigoISOProd AS PaisISO,
		PDD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PDD.CUV,
		PDD.Cantidad,
		0 AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoDDDetalle PDD (NOLOCK)
	ON TBL.PedidoID = PDD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PDD.ConsultoraID
	WHERE TBL.Origen = 'D'

	SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( 'dbo.GetLogCargaPedidoCliente', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.GetLogCargaPedidoCliente
GO
CREATE PROCEDURE dbo.GetLogCargaPedidoCliente
@NroLote INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoISOProd VARCHAR(3),
			@PaisID INT

	DECLARE @TBL_LOG_PEDIDO TABLE
	(
		PedidoID INT NOT NULL,
		Origen CHAR(1) NOT NULL,
		FechaFacturacion DATE NOT NULL

		PRIMARY KEY(PedidoID, Origen)
	)

	SELECT TOP 1
		@PaisID = PaisID
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	SELECT TOP 1
		@CodigoISOProd = CodigoISOProd
	FROM BelcorpPeru.dbo.Pais (NOLOCK)
	WHERE PaisID = @PaisID

	INSERT INTO @TBL_LOG_PEDIDO
	(
		PedidoID,
		Origen,
		FechaFacturacion
	)
	SELECT 
		PedidoID,
		Origen,
		FechaFacturacion
	FROM dbo.LogCargaPedido (NOLOCK) 
	WHERE NroLote = @NroLote

	SELECT 
		@CodigoISOProd AS PaisISO,
		PWD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PWD.CUV,
		PWD.Cantidad,
		ISNULL(CLI.CodigoCliente, 0) AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoWebDetalle PWD (NOLOCK)
	ON TBL.PedidoID = PWD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PWD.ConsultoraID
	LEFT JOIN dbo.Cliente CLI (NOLOCK)
	ON CLI.ConsultoraID = PWD.ConsultoraID
	AND CLI.ClienteID = PWD.ClienteID
	WHERE TBL.Origen = 'W'

	UNION ALL

	SELECT 
		@CodigoISOProd AS PaisISO,
		PDD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PDD.CUV,
		PDD.Cantidad,
		0 AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoDDDetalle PDD (NOLOCK)
	ON TBL.PedidoID = PDD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PDD.ConsultoraID
	WHERE TBL.Origen = 'D'

	SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( 'dbo.GetLogCargaPedidoCliente', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.GetLogCargaPedidoCliente
GO
CREATE PROCEDURE dbo.GetLogCargaPedidoCliente
@NroLote INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoISOProd VARCHAR(3),
			@PaisID INT

	DECLARE @TBL_LOG_PEDIDO TABLE
	(
		PedidoID INT NOT NULL,
		Origen CHAR(1) NOT NULL,
		FechaFacturacion DATE NOT NULL

		PRIMARY KEY(PedidoID, Origen)
	)

	SELECT TOP 1
		@PaisID = PaisID
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	SELECT TOP 1
		@CodigoISOProd = CodigoISOProd
	FROM BelcorpPeru.dbo.Pais (NOLOCK)
	WHERE PaisID = @PaisID

	INSERT INTO @TBL_LOG_PEDIDO
	(
		PedidoID,
		Origen,
		FechaFacturacion
	)
	SELECT 
		PedidoID,
		Origen,
		FechaFacturacion
	FROM dbo.LogCargaPedido (NOLOCK) 
	WHERE NroLote = @NroLote

	SELECT 
		@CodigoISOProd AS PaisISO,
		PWD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PWD.CUV,
		PWD.Cantidad,
		ISNULL(CLI.CodigoCliente, 0) AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoWebDetalle PWD (NOLOCK)
	ON TBL.PedidoID = PWD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PWD.ConsultoraID
	LEFT JOIN dbo.Cliente CLI (NOLOCK)
	ON CLI.ConsultoraID = PWD.ConsultoraID
	AND CLI.ClienteID = PWD.ClienteID
	WHERE TBL.Origen = 'W'

	UNION ALL

	SELECT 
		@CodigoISOProd AS PaisISO,
		PDD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PDD.CUV,
		PDD.Cantidad,
		0 AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoDDDetalle PDD (NOLOCK)
	ON TBL.PedidoID = PDD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PDD.ConsultoraID
	WHERE TBL.Origen = 'D'

	SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( 'dbo.GetLogCargaPedidoCliente', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.GetLogCargaPedidoCliente
GO
CREATE PROCEDURE dbo.GetLogCargaPedidoCliente
@NroLote INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoISOProd VARCHAR(3),
			@PaisID INT

	DECLARE @TBL_LOG_PEDIDO TABLE
	(
		PedidoID INT NOT NULL,
		Origen CHAR(1) NOT NULL,
		FechaFacturacion DATE NOT NULL

		PRIMARY KEY(PedidoID, Origen)
	)

	SELECT TOP 1
		@PaisID = PaisID
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	SELECT TOP 1
		@CodigoISOProd = CodigoISOProd
	FROM BelcorpPeru.dbo.Pais (NOLOCK)
	WHERE PaisID = @PaisID

	INSERT INTO @TBL_LOG_PEDIDO
	(
		PedidoID,
		Origen,
		FechaFacturacion
	)
	SELECT 
		PedidoID,
		Origen,
		FechaFacturacion
	FROM dbo.LogCargaPedido (NOLOCK) 
	WHERE NroLote = @NroLote

	SELECT 
		@CodigoISOProd AS PaisISO,
		PWD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PWD.CUV,
		PWD.Cantidad,
		ISNULL(CLI.CodigoCliente, 0) AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoWebDetalle PWD (NOLOCK)
	ON TBL.PedidoID = PWD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PWD.ConsultoraID
	LEFT JOIN dbo.Cliente CLI (NOLOCK)
	ON CLI.ConsultoraID = PWD.ConsultoraID
	AND CLI.ClienteID = PWD.ClienteID
	WHERE TBL.Origen = 'W'

	UNION ALL

	SELECT 
		@CodigoISOProd AS PaisISO,
		PDD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PDD.CUV,
		PDD.Cantidad,
		0 AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoDDDetalle PDD (NOLOCK)
	ON TBL.PedidoID = PDD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PDD.ConsultoraID
	WHERE TBL.Origen = 'D'

	SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( 'dbo.GetLogCargaPedidoCliente', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.GetLogCargaPedidoCliente
GO
CREATE PROCEDURE dbo.GetLogCargaPedidoCliente
@NroLote INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoISOProd VARCHAR(3),
			@PaisID INT

	DECLARE @TBL_LOG_PEDIDO TABLE
	(
		PedidoID INT NOT NULL,
		Origen CHAR(1) NOT NULL,
		FechaFacturacion DATE NOT NULL

		PRIMARY KEY(PedidoID, Origen)
	)

	SELECT TOP 1
		@PaisID = PaisID
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	SELECT TOP 1
		@CodigoISOProd = CodigoISOProd
	FROM BelcorpPeru.dbo.Pais (NOLOCK)
	WHERE PaisID = @PaisID

	INSERT INTO @TBL_LOG_PEDIDO
	(
		PedidoID,
		Origen,
		FechaFacturacion
	)
	SELECT 
		PedidoID,
		Origen,
		FechaFacturacion
	FROM dbo.LogCargaPedido (NOLOCK) 
	WHERE NroLote = @NroLote

	SELECT 
		@CodigoISOProd AS PaisISO,
		PWD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PWD.CUV,
		PWD.Cantidad,
		ISNULL(CLI.CodigoCliente, 0) AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoWebDetalle PWD (NOLOCK)
	ON TBL.PedidoID = PWD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PWD.ConsultoraID
	LEFT JOIN dbo.Cliente CLI (NOLOCK)
	ON CLI.ConsultoraID = PWD.ConsultoraID
	AND CLI.ClienteID = PWD.ClienteID
	WHERE TBL.Origen = 'W'

	UNION ALL

	SELECT 
		@CodigoISOProd AS PaisISO,
		PDD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PDD.CUV,
		PDD.Cantidad,
		0 AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoDDDetalle PDD (NOLOCK)
	ON TBL.PedidoID = PDD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PDD.ConsultoraID
	WHERE TBL.Origen = 'D'

	SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( 'dbo.GetLogCargaPedidoCliente', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.GetLogCargaPedidoCliente
GO
CREATE PROCEDURE dbo.GetLogCargaPedidoCliente
@NroLote INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoISOProd VARCHAR(3),
			@PaisID INT

	DECLARE @TBL_LOG_PEDIDO TABLE
	(
		PedidoID INT NOT NULL,
		Origen CHAR(1) NOT NULL,
		FechaFacturacion DATE NOT NULL

		PRIMARY KEY(PedidoID, Origen)
	)

	SELECT TOP 1
		@PaisID = PaisID
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	SELECT TOP 1
		@CodigoISOProd = CodigoISOProd
	FROM BelcorpPeru.dbo.Pais (NOLOCK)
	WHERE PaisID = @PaisID

	INSERT INTO @TBL_LOG_PEDIDO
	(
		PedidoID,
		Origen,
		FechaFacturacion
	)
	SELECT 
		PedidoID,
		Origen,
		FechaFacturacion
	FROM dbo.LogCargaPedido (NOLOCK) 
	WHERE NroLote = @NroLote

	SELECT 
		@CodigoISOProd AS PaisISO,
		PWD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PWD.CUV,
		PWD.Cantidad,
		ISNULL(CLI.CodigoCliente, 0) AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoWebDetalle PWD (NOLOCK)
	ON TBL.PedidoID = PWD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PWD.ConsultoraID
	LEFT JOIN dbo.Cliente CLI (NOLOCK)
	ON CLI.ConsultoraID = PWD.ConsultoraID
	AND CLI.ClienteID = PWD.ClienteID
	WHERE TBL.Origen = 'W'

	UNION ALL

	SELECT 
		@CodigoISOProd AS PaisISO,
		PDD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PDD.CUV,
		PDD.Cantidad,
		0 AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoDDDetalle PDD (NOLOCK)
	ON TBL.PedidoID = PDD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PDD.ConsultoraID
	WHERE TBL.Origen = 'D'

	SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( 'dbo.GetLogCargaPedidoCliente', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.GetLogCargaPedidoCliente
GO
CREATE PROCEDURE dbo.GetLogCargaPedidoCliente
@NroLote INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoISOProd VARCHAR(3),
			@PaisID INT

	DECLARE @TBL_LOG_PEDIDO TABLE
	(
		PedidoID INT NOT NULL,
		Origen CHAR(1) NOT NULL,
		FechaFacturacion DATE NOT NULL

		PRIMARY KEY(PedidoID, Origen)
	)

	SELECT TOP 1
		@PaisID = PaisID
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	SELECT TOP 1
		@CodigoISOProd = CodigoISOProd
	FROM BelcorpPeru.dbo.Pais (NOLOCK)
	WHERE PaisID = @PaisID

	INSERT INTO @TBL_LOG_PEDIDO
	(
		PedidoID,
		Origen,
		FechaFacturacion
	)
	SELECT 
		PedidoID,
		Origen,
		FechaFacturacion
	FROM dbo.LogCargaPedido (NOLOCK) 
	WHERE NroLote = @NroLote

	SELECT 
		@CodigoISOProd AS PaisISO,
		PWD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PWD.CUV,
		PWD.Cantidad,
		ISNULL(CLI.CodigoCliente, 0) AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoWebDetalle PWD (NOLOCK)
	ON TBL.PedidoID = PWD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PWD.ConsultoraID
	LEFT JOIN dbo.Cliente CLI (NOLOCK)
	ON CLI.ConsultoraID = PWD.ConsultoraID
	AND CLI.ClienteID = PWD.ClienteID
	WHERE TBL.Origen = 'W'

	UNION ALL

	SELECT 
		@CodigoISOProd AS PaisISO,
		PDD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PDD.CUV,
		PDD.Cantidad,
		0 AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoDDDetalle PDD (NOLOCK)
	ON TBL.PedidoID = PDD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PDD.ConsultoraID
	WHERE TBL.Origen = 'D'

	SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

IF (OBJECT_ID ( 'dbo.GetLogCargaPedidoCliente', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.GetLogCargaPedidoCliente
GO
CREATE PROCEDURE dbo.GetLogCargaPedidoCliente
@NroLote INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoISOProd VARCHAR(3),
			@PaisID INT

	DECLARE @TBL_LOG_PEDIDO TABLE
	(
		PedidoID INT NOT NULL,
		Origen CHAR(1) NOT NULL,
		FechaFacturacion DATE NOT NULL

		PRIMARY KEY(PedidoID, Origen)
	)

	SELECT TOP 1
		@PaisID = PaisID
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	SELECT TOP 1
		@CodigoISOProd = CodigoISOProd
	FROM BelcorpPeru.dbo.Pais (NOLOCK)
	WHERE PaisID = @PaisID

	INSERT INTO @TBL_LOG_PEDIDO
	(
		PedidoID,
		Origen,
		FechaFacturacion
	)
	SELECT 
		PedidoID,
		Origen,
		FechaFacturacion
	FROM dbo.LogCargaPedido (NOLOCK) 
	WHERE NroLote = @NroLote

	SELECT 
		@CodigoISOProd AS PaisISO,
		PWD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PWD.CUV,
		PWD.Cantidad,
		ISNULL(CLI.CodigoCliente, 0) AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoWebDetalle PWD (NOLOCK)
	ON TBL.PedidoID = PWD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PWD.ConsultoraID
	LEFT JOIN dbo.Cliente CLI (NOLOCK)
	ON CLI.ConsultoraID = PWD.ConsultoraID
	AND CLI.ClienteID = PWD.ClienteID
	WHERE TBL.Origen = 'W'

	UNION ALL

	SELECT 
		@CodigoISOProd AS PaisISO,
		PDD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PDD.CUV,
		PDD.Cantidad,
		0 AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoDDDetalle PDD (NOLOCK)
	ON TBL.PedidoID = PDD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PDD.ConsultoraID
	WHERE TBL.Origen = 'D'

	SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( 'dbo.GetLogCargaPedidoCliente', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.GetLogCargaPedidoCliente
GO
CREATE PROCEDURE dbo.GetLogCargaPedidoCliente
@NroLote INT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoISOProd VARCHAR(3),
			@PaisID INT

	DECLARE @TBL_LOG_PEDIDO TABLE
	(
		PedidoID INT NOT NULL,
		Origen CHAR(1) NOT NULL,
		FechaFacturacion DATE NOT NULL

		PRIMARY KEY(PedidoID, Origen)
	)

	SELECT TOP 1
		@PaisID = PaisID
	FROM dbo.Pais (NOLOCK)
	WHERE EstadoActivo = 1

	SELECT TOP 1
		@CodigoISOProd = CodigoISOProd
	FROM BelcorpPeru.dbo.Pais (NOLOCK)
	WHERE PaisID = @PaisID

	INSERT INTO @TBL_LOG_PEDIDO
	(
		PedidoID,
		Origen,
		FechaFacturacion
	)
	SELECT 
		PedidoID,
		Origen,
		FechaFacturacion
	FROM dbo.LogCargaPedido (NOLOCK) 
	WHERE NroLote = @NroLote

	SELECT 
		@CodigoISOProd AS PaisISO,
		PWD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PWD.CUV,
		PWD.Cantidad,
		ISNULL(CLI.CodigoCliente, 0) AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoWebDetalle PWD (NOLOCK)
	ON TBL.PedidoID = PWD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PWD.ConsultoraID
	LEFT JOIN dbo.Cliente CLI (NOLOCK)
	ON CLI.ConsultoraID = PWD.ConsultoraID
	AND CLI.ClienteID = PWD.ClienteID
	WHERE TBL.Origen = 'W'

	UNION ALL

	SELECT 
		@CodigoISOProd AS PaisISO,
		PDD.CampaniaID,
		C.Codigo AS CodigoConsultora,
		TBL.FechaFacturacion,
		PDD.CUV,
		PDD.Cantidad,
		0 AS CodigoCliente
	FROM @TBL_LOG_PEDIDO TBL
	INNER JOIN dbo.PedidoDDDetalle PDD (NOLOCK)
	ON TBL.PedidoID = PDD.PedidoID
	INNER JOIN ods.Consultora C (NOLOCK)
	ON C.ConsultoraID = PDD.ConsultoraID
	WHERE TBL.Origen = 'D'

	SET NOCOUNT OFF
END
GO

