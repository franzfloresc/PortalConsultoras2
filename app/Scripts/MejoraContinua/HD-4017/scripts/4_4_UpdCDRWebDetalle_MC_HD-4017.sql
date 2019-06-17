USE BelcorpBolivia
GO
ALTER PROCEDURE [dbo].[UpdCDRWebDetalle] (
	@CDRWebDetalleID INT = 0	
	,@DetalleXML XML  = '' 
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
    SET NOCOUNT ON;
	SET @RetornoID = 0
	 UPDATE CDRWebDetalle
	 SET
	 DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
	 WHERE CDRWebDetalleID = @CDRWebDetalleID;
	 SET @RetornoID = 1	
	 SET NOCOUNT OFF;
END
GO

USE BelcorpChile
GO
ALTER PROCEDURE [dbo].[UpdCDRWebDetalle] (
	@CDRWebDetalleID INT = 0	
	,@DetalleXML XML  = '' 
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
    SET NOCOUNT ON;
	SET @RetornoID = 0
	 UPDATE CDRWebDetalle
	 SET
	 DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
	 WHERE CDRWebDetalleID = @CDRWebDetalleID;
	 SET @RetornoID = 1	
	 SET NOCOUNT OFF;
END
GO

USE BelcorpColombia
GO
ALTER PROCEDURE [dbo].[UpdCDRWebDetalle] (
	@CDRWebDetalleID INT = 0	
	,@DetalleXML XML  = '' 
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
    SET NOCOUNT ON;
	SET @RetornoID = 0
	 UPDATE CDRWebDetalle
	 SET
	 DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
	 WHERE CDRWebDetalleID = @CDRWebDetalleID;
	 SET @RetornoID = 1	
	 SET NOCOUNT OFF;
END
GO
	
USE BelcorpCostaRica
GO
ALTER PROCEDURE [dbo].[UpdCDRWebDetalle] (
	@CDRWebDetalleID INT = 0	
	,@DetalleXML XML  = '' 
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
    SET NOCOUNT ON;
	SET @RetornoID = 0
	 UPDATE CDRWebDetalle
	 SET
	 DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
	 WHERE CDRWebDetalleID = @CDRWebDetalleID;
	 SET @RetornoID = 1	
	 SET NOCOUNT OFF;
END
GO

USE BelcorpDominicana
GO
ALTER PROCEDURE [dbo].[UpdCDRWebDetalle] (
	@CDRWebDetalleID INT = 0	
	,@DetalleXML XML  = '' 
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
    SET NOCOUNT ON;
	SET @RetornoID = 0
	 UPDATE CDRWebDetalle
	 SET
	 DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
	 WHERE CDRWebDetalleID = @CDRWebDetalleID;
	 SET @RetornoID = 1	
	 SET NOCOUNT OFF;
END
GO

USE BelcorpEcuador
GO
ALTER PROCEDURE [dbo].[UpdCDRWebDetalle] (
	@CDRWebDetalleID INT = 0	
	,@DetalleXML XML  = '' 
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
    SET NOCOUNT ON;
	SET @RetornoID = 0
	 UPDATE CDRWebDetalle
	 SET
	 DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
	 WHERE CDRWebDetalleID = @CDRWebDetalleID;
	 SET @RetornoID = 1	
	 SET NOCOUNT OFF;
END
GO

USE BelcorpGuatemala
GO
ALTER PROCEDURE [dbo].[UpdCDRWebDetalle] (
	@CDRWebDetalleID INT = 0	
	,@DetalleXML XML  = '' 
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
    SET NOCOUNT ON;
	SET @RetornoID = 0
	 UPDATE CDRWebDetalle
	 SET
	 DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
	 WHERE CDRWebDetalleID = @CDRWebDetalleID;
	 SET @RetornoID = 1	
	 SET NOCOUNT OFF;
END
GO

USE BelcorpMexico
GO
ALTER PROCEDURE [dbo].[UpdCDRWebDetalle] (
	@CDRWebDetalleID INT = 0	
	,@DetalleXML XML  = '' 
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
    SET NOCOUNT ON;
	SET @RetornoID = 0
	 UPDATE CDRWebDetalle
	 SET
	 DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
	 WHERE CDRWebDetalleID = @CDRWebDetalleID;
	 SET @RetornoID = 1	
	 SET NOCOUNT OFF;
END
GO

USE BelcorpPanama
GO
ALTER PROCEDURE [dbo].[UpdCDRWebDetalle] (
	@CDRWebDetalleID INT = 0	
	,@DetalleXML XML  = '' 
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
    SET NOCOUNT ON;
	SET @RetornoID = 0
	 UPDATE CDRWebDetalle
	 SET
	 DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
	 WHERE CDRWebDetalleID = @CDRWebDetalleID;
	 SET @RetornoID = 1	
	 SET NOCOUNT OFF;
END
GO

USE BelcorpPeru
GO
ALTER PROCEDURE [dbo].[UpdCDRWebDetalle] (
	@CDRWebDetalleID INT = 0	
	,@DetalleXML XML  = '' 
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
    SET NOCOUNT ON;
	SET @RetornoID = 0
	 UPDATE CDRWebDetalle
	 SET
	 DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
	 WHERE CDRWebDetalleID = @CDRWebDetalleID;
	 SET @RetornoID = 1	
	 SET NOCOUNT OFF;
END
GO

USE BelcorpPuertoRico
GO
ALTER PROCEDURE [dbo].[UpdCDRWebDetalle] (
	@CDRWebDetalleID INT = 0	
	,@DetalleXML XML  = '' 
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
    SET NOCOUNT ON;
	SET @RetornoID = 0
	 UPDATE CDRWebDetalle
	 SET
	 DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
	 WHERE CDRWebDetalleID = @CDRWebDetalleID;
	 SET @RetornoID = 1	
	 SET NOCOUNT OFF;
END
GO

USE BelcorpSalvador
GO
ALTER PROCEDURE [dbo].[UpdCDRWebDetalle] (
	@CDRWebDetalleID INT = 0	
	,@DetalleXML XML  = '' 
	,@RetornoID INT OUTPUT
	)
AS
BEGIN
    SET NOCOUNT ON;
	SET @RetornoID = 0
	 UPDATE CDRWebDetalle
	 SET
	 DetalleReemplazo = ISNULL(@DetalleXML,DetalleReemplazo)
	 WHERE CDRWebDetalleID = @CDRWebDetalleID;
	 SET @RetornoID = 1	
	 SET NOCOUNT OFF;
END
GO