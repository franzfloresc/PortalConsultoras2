USE BelcorpPeru
GO

IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'ValidarCUVEnProcesoReclamo'
		)
BEGIN
	DROP PROCEDURE ValidarCUVEnProcesoReclamo
END
GO

CREATE PROCEDURE ValidarCUVEnProcesoReclamo (
	@PedidoID INT = 0
	,@CUV VARCHAR(7) = NULL
	,@Resultado INT OUTPUT
	)
	--SP_ValidarCUVEnProcesoReclamo  728811937, '07634' ,0
AS
BEGIN
	SET NOCOUNT ON;
	SET @Resultado = 0;

	SELECT @Resultado = ISNULL(c.Estado, 0)
	FROM dbo.CDRWeb c
	INNER JOIN dbo.CDRWebDetalle d ON c.CDRWebID = d.CDRWebID
	WHERE c.PedidoID = @PedidoID
		AND d.CUV = @CUV
		AND D.Estado NOT IN (4);
END;
GO

USE BelcorpBolivia
GO

IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'ValidarCUVEnProcesoReclamo'
		)
BEGIN
	DROP PROCEDURE ValidarCUVEnProcesoReclamo
END
GO

CREATE PROCEDURE ValidarCUVEnProcesoReclamo (
	@PedidoID INT = 0
	,@CUV VARCHAR(7) = NULL
	,@Resultado INT OUTPUT
	)
	--SP_ValidarCUVEnProcesoReclamo  728811937, '07634' ,0
AS
BEGIN
	SET NOCOUNT ON;
	SET @Resultado = 0;

	SELECT @Resultado = ISNULL(c.Estado, 0)
	FROM dbo.CDRWeb c
	INNER JOIN dbo.CDRWebDetalle d ON c.CDRWebID = d.CDRWebID
	WHERE c.PedidoID = @PedidoID
		AND d.CUV = @CUV
		AND D.Estado NOT IN (4);
END;
GO

USE BelcorpChile
GO

IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'ValidarCUVEnProcesoReclamo'
		)
BEGIN
	DROP PROCEDURE ValidarCUVEnProcesoReclamo
END
GO

CREATE PROCEDURE ValidarCUVEnProcesoReclamo (
	@PedidoID INT = 0
	,@CUV VARCHAR(7) = NULL
	,@Resultado INT OUTPUT
	)
	--SP_ValidarCUVEnProcesoReclamo  728811937, '07634' ,0
AS
BEGIN
	SET NOCOUNT ON;
	SET @Resultado = 0;

	SELECT @Resultado = ISNULL(c.Estado, 0)
	FROM dbo.CDRWeb c
	INNER JOIN dbo.CDRWebDetalle d ON c.CDRWebID = d.CDRWebID
	WHERE c.PedidoID = @PedidoID
		AND d.CUV = @CUV
		AND D.Estado NOT IN (4);
END;
GO

USE BelcorpColombia
GO

IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'ValidarCUVEnProcesoReclamo'
		)
BEGIN
	DROP PROCEDURE ValidarCUVEnProcesoReclamo
END
GO

CREATE PROCEDURE ValidarCUVEnProcesoReclamo (
	@PedidoID INT = 0
	,@CUV VARCHAR(7) = NULL
	,@Resultado INT OUTPUT
	)
	--SP_ValidarCUVEnProcesoReclamo  728811937, '07634' ,0
AS
BEGIN
	SET NOCOUNT ON;
	SET @Resultado = 0;

	SELECT @Resultado = ISNULL(c.Estado, 0)
	FROM dbo.CDRWeb c
	INNER JOIN dbo.CDRWebDetalle d ON c.CDRWebID = d.CDRWebID
	WHERE c.PedidoID = @PedidoID
		AND d.CUV = @CUV
		AND D.Estado NOT IN (4);
END;
GO

USE BelcorpGuatemala
GO

IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'ValidarCUVEnProcesoReclamo'
		)
BEGIN
	DROP PROCEDURE ValidarCUVEnProcesoReclamo
END
GO

CREATE PROCEDURE ValidarCUVEnProcesoReclamo (
	@PedidoID INT = 0
	,@CUV VARCHAR(7) = NULL
	,@Resultado INT OUTPUT
	)
	--SP_ValidarCUVEnProcesoReclamo  728811937, '07634' ,0
AS
BEGIN
	SET NOCOUNT ON;
	SET @Resultado = 0;

	SELECT @Resultado = ISNULL(c.Estado, 0)
	FROM dbo.CDRWeb c
	INNER JOIN dbo.CDRWebDetalle d ON c.CDRWebID = d.CDRWebID
	WHERE c.PedidoID = @PedidoID
		AND d.CUV = @CUV
		AND D.Estado NOT IN (4);
END;
GO

USE BelcorpMexico
GO

IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'ValidarCUVEnProcesoReclamo'
		)
BEGIN
	DROP PROCEDURE ValidarCUVEnProcesoReclamo
END
GO

CREATE PROCEDURE ValidarCUVEnProcesoReclamo (
	@PedidoID INT = 0
	,@CUV VARCHAR(7) = NULL
	,@Resultado INT OUTPUT
	)
	--SP_ValidarCUVEnProcesoReclamo  728811937, '07634' ,0
AS
BEGIN
	SET NOCOUNT ON;
	SET @Resultado = 0;

	SELECT @Resultado = ISNULL(c.Estado, 0)
	FROM dbo.CDRWeb c
	INNER JOIN dbo.CDRWebDetalle d ON c.CDRWebID = d.CDRWebID
	WHERE c.PedidoID = @PedidoID
		AND d.CUV = @CUV
		AND D.Estado NOT IN (4);
END;
GO

USE BelcorpCostaRica
GO

IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'ValidarCUVEnProcesoReclamo'
		)
BEGIN
	DROP PROCEDURE ValidarCUVEnProcesoReclamo
END
GO

CREATE PROCEDURE ValidarCUVEnProcesoReclamo (
	@PedidoID INT = 0
	,@CUV VARCHAR(7) = NULL
	,@Resultado INT OUTPUT
	)
	--SP_ValidarCUVEnProcesoReclamo  728811937, '07634' ,0
AS
BEGIN
	SET NOCOUNT ON;
	SET @Resultado = 0;

	SELECT @Resultado = ISNULL(c.Estado, 0)
	FROM dbo.CDRWeb c
	INNER JOIN dbo.CDRWebDetalle d ON c.CDRWebID = d.CDRWebID
	WHERE c.PedidoID = @PedidoID
		AND d.CUV = @CUV
		AND D.Estado NOT IN (4);
END;
GO

USE BelcorpEcuador
GO

IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'ValidarCUVEnProcesoReclamo'
		)
BEGIN
	DROP PROCEDURE ValidarCUVEnProcesoReclamo
END
GO

CREATE PROCEDURE ValidarCUVEnProcesoReclamo (
	@PedidoID INT = 0
	,@CUV VARCHAR(7) = NULL
	,@Resultado INT OUTPUT
	)
	--SP_ValidarCUVEnProcesoReclamo  728811937, '07634' ,0
AS
BEGIN
	SET NOCOUNT ON;
	SET @Resultado = 0;

	SELECT @Resultado = ISNULL(c.Estado, 0)
	FROM dbo.CDRWeb c
	INNER JOIN dbo.CDRWebDetalle d ON c.CDRWebID = d.CDRWebID
	WHERE c.PedidoID = @PedidoID
		AND d.CUV = @CUV
		AND D.Estado NOT IN (4);
END;
GO

USE BelcorpSalvador
GO

IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'ValidarCUVEnProcesoReclamo'
		)
BEGIN
	DROP PROCEDURE ValidarCUVEnProcesoReclamo
END
GO

CREATE PROCEDURE ValidarCUVEnProcesoReclamo (
	@PedidoID INT = 0
	,@CUV VARCHAR(7) = NULL
	,@Resultado INT OUTPUT
	)
	--SP_ValidarCUVEnProcesoReclamo  728811937, '07634' ,0
AS
BEGIN
	SET NOCOUNT ON;
	SET @Resultado = 0;

	SELECT @Resultado = ISNULL(c.Estado, 0)
	FROM dbo.CDRWeb c
	INNER JOIN dbo.CDRWebDetalle d ON c.CDRWebID = d.CDRWebID
	WHERE c.PedidoID = @PedidoID
		AND d.CUV = @CUV
		AND D.Estado NOT IN (4);
END;
GO

USE BelcorpPanama
GO

IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'ValidarCUVEnProcesoReclamo'
		)
BEGIN
	DROP PROCEDURE ValidarCUVEnProcesoReclamo
END
GO

CREATE PROCEDURE ValidarCUVEnProcesoReclamo (
	@PedidoID INT = 0
	,@CUV VARCHAR(7) = NULL
	,@Resultado INT OUTPUT
	)
	--SP_ValidarCUVEnProcesoReclamo  728811937, '07634' ,0
AS
BEGIN
	SET NOCOUNT ON;
	SET @Resultado = 0;

	SELECT @Resultado = ISNULL(c.Estado, 0)
	FROM dbo.CDRWeb c
	INNER JOIN dbo.CDRWebDetalle d ON c.CDRWebID = d.CDRWebID
	WHERE c.PedidoID = @PedidoID
		AND d.CUV = @CUV
		AND D.Estado NOT IN (4);
END;
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'ValidarCUVEnProcesoReclamo'
		)
BEGIN
	DROP PROCEDURE ValidarCUVEnProcesoReclamo
END
GO

CREATE PROCEDURE ValidarCUVEnProcesoReclamo (
	@PedidoID INT = 0
	,@CUV VARCHAR(7) = NULL
	,@Resultado INT OUTPUT
	)
	--SP_ValidarCUVEnProcesoReclamo  728811937, '07634' ,0
AS
BEGIN
	SET NOCOUNT ON;
	SET @Resultado = 0;

	SELECT @Resultado = ISNULL(c.Estado, 0)
	FROM dbo.CDRWeb c
	INNER JOIN dbo.CDRWebDetalle d ON c.CDRWebID = d.CDRWebID
	WHERE c.PedidoID = @PedidoID
		AND d.CUV = @CUV
		AND D.Estado NOT IN (4);
END;
GO

USE BelcorpDominicana
GO

IF EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = N'ValidarCUVEnProcesoReclamo'
		)
BEGIN
	DROP PROCEDURE ValidarCUVEnProcesoReclamo
END
GO

CREATE PROCEDURE ValidarCUVEnProcesoReclamo (
	@PedidoID INT = 0
	,@CUV VARCHAR(7) = NULL
	,@Resultado INT OUTPUT
	)
	--SP_ValidarCUVEnProcesoReclamo  728811937, '07634' ,0
AS
BEGIN
	SET NOCOUNT ON;
	SET @Resultado = 0;

	SELECT @Resultado = ISNULL(c.Estado, 0)
	FROM dbo.CDRWeb c
	INNER JOIN dbo.CDRWebDetalle d ON c.CDRWebID = d.CDRWebID
	WHERE c.PedidoID = @PedidoID
		AND d.CUV = @CUV
		AND D.Estado NOT IN (4);
END;
GO


