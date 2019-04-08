GO
USE BelcorpPeru
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleByCUV]
	@CampaniaID INT,
	@PedidoID INT,
	@CUV VARCHAR(20),
	@Deleted SMALLINT OUTPUT
AS

BEGIN TRY
	UPDATE pw
	SET pw.Clientes = pw.Clientes - ISNULL(pwd.ClienteID,0),
		pw.ImporteTotal = pw.ImporteTotal - pwd.ImporteTotal,
		pw.FechaModificacion = getdate()
	FROM dbo.PedidoWeb pw
	INNER JOIN dbo.PedidoWebDetalle pwd on pw.CampaniaID = pwd.CampaniaID AND pw.PedidoID = pwd.PedidoID
	WHERE  pwd.CUV = @CUV


	DELETE FROM dbo.PedidoWebDetalle
	WHERE	CampaniaID = @CampaniaID AND
			PedidoID = @PedidoID AND
			CUV = @CUV

	SET	@Deleted = 1;
END TRY
BEGIN CATCH
  SET @Deleted = 0;
END CATCH

GO
USE BelcorpMexico
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleByCUV]
	@CampaniaID INT,
	@PedidoID INT,
	@CUV VARCHAR(20),
	@Deleted SMALLINT OUTPUT
AS

BEGIN TRY
	UPDATE pw
	SET pw.Clientes = pw.Clientes - ISNULL(pwd.ClienteID,0),
		pw.ImporteTotal = pw.ImporteTotal - pwd.ImporteTotal,
		pw.FechaModificacion = getdate()
	FROM dbo.PedidoWeb pw
	INNER JOIN dbo.PedidoWebDetalle pwd on pw.CampaniaID = pwd.CampaniaID AND pw.PedidoID = pwd.PedidoID
	WHERE  pwd.CUV = @CUV


	DELETE FROM dbo.PedidoWebDetalle
	WHERE	CampaniaID = @CampaniaID AND
			PedidoID = @PedidoID AND
			CUV = @CUV

	SET	@Deleted = 1;
END TRY
BEGIN CATCH
  SET @Deleted = 0;
END CATCH

GO
USE BelcorpColombia
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleByCUV]
	@CampaniaID INT,
	@PedidoID INT,
	@CUV VARCHAR(20),
	@Deleted SMALLINT OUTPUT
AS

BEGIN TRY
	UPDATE pw
	SET pw.Clientes = pw.Clientes - ISNULL(pwd.ClienteID,0),
		pw.ImporteTotal = pw.ImporteTotal - pwd.ImporteTotal,
		pw.FechaModificacion = getdate()
	FROM dbo.PedidoWeb pw
	INNER JOIN dbo.PedidoWebDetalle pwd on pw.CampaniaID = pwd.CampaniaID AND pw.PedidoID = pwd.PedidoID
	WHERE  pwd.CUV = @CUV


	DELETE FROM dbo.PedidoWebDetalle
	WHERE	CampaniaID = @CampaniaID AND
			PedidoID = @PedidoID AND
			CUV = @CUV

	SET	@Deleted = 1;
END TRY
BEGIN CATCH
  SET @Deleted = 0;
END CATCH

GO
USE BelcorpSalvador
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleByCUV]
	@CampaniaID INT,
	@PedidoID INT,
	@CUV VARCHAR(20),
	@Deleted SMALLINT OUTPUT
AS

BEGIN TRY
	UPDATE pw
	SET pw.Clientes = pw.Clientes - ISNULL(pwd.ClienteID,0),
		pw.ImporteTotal = pw.ImporteTotal - pwd.ImporteTotal,
		pw.FechaModificacion = getdate()
	FROM dbo.PedidoWeb pw
	INNER JOIN dbo.PedidoWebDetalle pwd on pw.CampaniaID = pwd.CampaniaID AND pw.PedidoID = pwd.PedidoID
	WHERE  pwd.CUV = @CUV


	DELETE FROM dbo.PedidoWebDetalle
	WHERE	CampaniaID = @CampaniaID AND
			PedidoID = @PedidoID AND
			CUV = @CUV

	SET	@Deleted = 1;
END TRY
BEGIN CATCH
  SET @Deleted = 0;
END CATCH

GO
USE BelcorpPuertoRico
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleByCUV]
	@CampaniaID INT,
	@PedidoID INT,
	@CUV VARCHAR(20),
	@Deleted SMALLINT OUTPUT
AS

BEGIN TRY
	UPDATE pw
	SET pw.Clientes = pw.Clientes - ISNULL(pwd.ClienteID,0),
		pw.ImporteTotal = pw.ImporteTotal - pwd.ImporteTotal,
		pw.FechaModificacion = getdate()
	FROM dbo.PedidoWeb pw
	INNER JOIN dbo.PedidoWebDetalle pwd on pw.CampaniaID = pwd.CampaniaID AND pw.PedidoID = pwd.PedidoID
	WHERE  pwd.CUV = @CUV


	DELETE FROM dbo.PedidoWebDetalle
	WHERE	CampaniaID = @CampaniaID AND
			PedidoID = @PedidoID AND
			CUV = @CUV

	SET	@Deleted = 1;
END TRY
BEGIN CATCH
  SET @Deleted = 0;
END CATCH

GO
USE BelcorpPanama
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleByCUV]
	@CampaniaID INT,
	@PedidoID INT,
	@CUV VARCHAR(20),
	@Deleted SMALLINT OUTPUT
AS

BEGIN TRY
	UPDATE pw
	SET pw.Clientes = pw.Clientes - ISNULL(pwd.ClienteID,0),
		pw.ImporteTotal = pw.ImporteTotal - pwd.ImporteTotal,
		pw.FechaModificacion = getdate()
	FROM dbo.PedidoWeb pw
	INNER JOIN dbo.PedidoWebDetalle pwd on pw.CampaniaID = pwd.CampaniaID AND pw.PedidoID = pwd.PedidoID
	WHERE  pwd.CUV = @CUV


	DELETE FROM dbo.PedidoWebDetalle
	WHERE	CampaniaID = @CampaniaID AND
			PedidoID = @PedidoID AND
			CUV = @CUV

	SET	@Deleted = 1;
END TRY
BEGIN CATCH
  SET @Deleted = 0;
END CATCH

GO
USE BelcorpGuatemala
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleByCUV]
	@CampaniaID INT,
	@PedidoID INT,
	@CUV VARCHAR(20),
	@Deleted SMALLINT OUTPUT
AS

BEGIN TRY
	UPDATE pw
	SET pw.Clientes = pw.Clientes - ISNULL(pwd.ClienteID,0),
		pw.ImporteTotal = pw.ImporteTotal - pwd.ImporteTotal,
		pw.FechaModificacion = getdate()
	FROM dbo.PedidoWeb pw
	INNER JOIN dbo.PedidoWebDetalle pwd on pw.CampaniaID = pwd.CampaniaID AND pw.PedidoID = pwd.PedidoID
	WHERE  pwd.CUV = @CUV


	DELETE FROM dbo.PedidoWebDetalle
	WHERE	CampaniaID = @CampaniaID AND
			PedidoID = @PedidoID AND
			CUV = @CUV

	SET	@Deleted = 1;
END TRY
BEGIN CATCH
  SET @Deleted = 0;
END CATCH

GO
USE BelcorpEcuador
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleByCUV]
	@CampaniaID INT,
	@PedidoID INT,
	@CUV VARCHAR(20),
	@Deleted SMALLINT OUTPUT
AS

BEGIN TRY
	UPDATE pw
	SET pw.Clientes = pw.Clientes - ISNULL(pwd.ClienteID,0),
		pw.ImporteTotal = pw.ImporteTotal - pwd.ImporteTotal,
		pw.FechaModificacion = getdate()
	FROM dbo.PedidoWeb pw
	INNER JOIN dbo.PedidoWebDetalle pwd on pw.CampaniaID = pwd.CampaniaID AND pw.PedidoID = pwd.PedidoID
	WHERE  pwd.CUV = @CUV


	DELETE FROM dbo.PedidoWebDetalle
	WHERE	CampaniaID = @CampaniaID AND
			PedidoID = @PedidoID AND
			CUV = @CUV

	SET	@Deleted = 1;
END TRY
BEGIN CATCH
  SET @Deleted = 0;
END CATCH

GO
USE BelcorpDominicana
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleByCUV]
	@CampaniaID INT,
	@PedidoID INT,
	@CUV VARCHAR(20),
	@Deleted SMALLINT OUTPUT
AS

BEGIN TRY
	UPDATE pw
	SET pw.Clientes = pw.Clientes - ISNULL(pwd.ClienteID,0),
		pw.ImporteTotal = pw.ImporteTotal - pwd.ImporteTotal,
		pw.FechaModificacion = getdate()
	FROM dbo.PedidoWeb pw
	INNER JOIN dbo.PedidoWebDetalle pwd on pw.CampaniaID = pwd.CampaniaID AND pw.PedidoID = pwd.PedidoID
	WHERE  pwd.CUV = @CUV


	DELETE FROM dbo.PedidoWebDetalle
	WHERE	CampaniaID = @CampaniaID AND
			PedidoID = @PedidoID AND
			CUV = @CUV

	SET	@Deleted = 1;
END TRY
BEGIN CATCH
  SET @Deleted = 0;
END CATCH

GO
USE BelcorpCostaRica
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleByCUV]
	@CampaniaID INT,
	@PedidoID INT,
	@CUV VARCHAR(20),
	@Deleted SMALLINT OUTPUT
AS

BEGIN TRY
	UPDATE pw
	SET pw.Clientes = pw.Clientes - ISNULL(pwd.ClienteID,0),
		pw.ImporteTotal = pw.ImporteTotal - pwd.ImporteTotal,
		pw.FechaModificacion = getdate()
	FROM dbo.PedidoWeb pw
	INNER JOIN dbo.PedidoWebDetalle pwd on pw.CampaniaID = pwd.CampaniaID AND pw.PedidoID = pwd.PedidoID
	WHERE  pwd.CUV = @CUV


	DELETE FROM dbo.PedidoWebDetalle
	WHERE	CampaniaID = @CampaniaID AND
			PedidoID = @PedidoID AND
			CUV = @CUV

	SET	@Deleted = 1;
END TRY
BEGIN CATCH
  SET @Deleted = 0;
END CATCH

GO
USE BelcorpChile
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleByCUV]
	@CampaniaID INT,
	@PedidoID INT,
	@CUV VARCHAR(20),
	@Deleted SMALLINT OUTPUT
AS

BEGIN TRY
	UPDATE pw
	SET pw.Clientes = pw.Clientes - ISNULL(pwd.ClienteID,0),
		pw.ImporteTotal = pw.ImporteTotal - pwd.ImporteTotal,
		pw.FechaModificacion = getdate()
	FROM dbo.PedidoWeb pw
	INNER JOIN dbo.PedidoWebDetalle pwd on pw.CampaniaID = pwd.CampaniaID AND pw.PedidoID = pwd.PedidoID
	WHERE  pwd.CUV = @CUV


	DELETE FROM dbo.PedidoWebDetalle
	WHERE	CampaniaID = @CampaniaID AND
			PedidoID = @PedidoID AND
			CUV = @CUV

	SET	@Deleted = 1;
END TRY
BEGIN CATCH
  SET @Deleted = 0;
END CATCH

GO
USE BelcorpBolivia
GO
ALTER PROCEDURE [dbo].[DelPedidoWebDetalleByCUV]
	@CampaniaID INT,
	@PedidoID INT,
	@CUV VARCHAR(20),
	@Deleted SMALLINT OUTPUT
AS

BEGIN TRY
	UPDATE pw
	SET pw.Clientes = pw.Clientes - ISNULL(pwd.ClienteID,0),
		pw.ImporteTotal = pw.ImporteTotal - pwd.ImporteTotal,
		pw.FechaModificacion = getdate()
	FROM dbo.PedidoWeb pw
	INNER JOIN dbo.PedidoWebDetalle pwd on pw.CampaniaID = pwd.CampaniaID AND pw.PedidoID = pwd.PedidoID
	WHERE  pwd.CUV = @CUV


	DELETE FROM dbo.PedidoWebDetalle
	WHERE	CampaniaID = @CampaniaID AND
			PedidoID = @PedidoID AND
			CUV = @CUV

	SET	@Deleted = 1;
END TRY
BEGIN CATCH
  SET @Deleted = 0;
END CATCH

GO
