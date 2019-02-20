USE BelcorpPeru
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


