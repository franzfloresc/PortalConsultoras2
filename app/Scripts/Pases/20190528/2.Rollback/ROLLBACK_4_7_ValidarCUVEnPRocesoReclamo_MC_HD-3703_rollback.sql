USE BelcorpBolivia
GO

ALTER PROCEDURE ValidarCUVEnProcesoReclamo (
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
END

GO
USE BelcorpChile
GO
ALTER PROCEDURE ValidarCUVEnProcesoReclamo (
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
END

GO
USE BelcorpColombia
GO
ALTER PROCEDURE ValidarCUVEnProcesoReclamo (
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
END

GO
USE BelcorpCostaRica
GO
ALTER PROCEDURE ValidarCUVEnProcesoReclamo (
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
END

GO
USE BelcorpDominicana
GO
ALTER PROCEDURE ValidarCUVEnProcesoReclamo (
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
END

GO
USE BelcorpEcuador
GO
ALTER PROCEDURE ValidarCUVEnProcesoReclamo (
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
END

GO
USE BelcorpGuatemala
GO
ALTER PROCEDURE ValidarCUVEnProcesoReclamo (
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
END

GO
USE BelcorpMexico
GO
ALTER PROCEDURE ValidarCUVEnProcesoReclamo (
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
END

GO
USE BelcorpPanama
GO
ALTER PROCEDURE ValidarCUVEnProcesoReclamo (
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
END

GO
USE BelcorpPeru
GO
ALTER PROCEDURE ValidarCUVEnProcesoReclamo (
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
END

GO
USE BelcorpPuertoRico
GO
ALTER PROCEDURE ValidarCUVEnProcesoReclamo (
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
END

GO
USE BelcorpSalvador
GO
ALTER PROCEDURE ValidarCUVEnProcesoReclamo (
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
END
GO
