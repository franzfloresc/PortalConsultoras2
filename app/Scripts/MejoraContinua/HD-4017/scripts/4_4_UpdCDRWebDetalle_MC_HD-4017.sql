USE BelcorpBolivia
GO

IF  EXISTS(SELECT * FROM sys.procedures WHERE name  = N'UpdCDRWebDetalle')
BEGIN
	 DROP PROC UpdCDRWebDetalle
END
GO

CREATE PROCEDURE [dbo].[UpdCDRWebDetalle] (
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
IF  EXISTS(SELECT * FROM sys.procedures WHERE name  = N'UpdCDRWebDetalle')
BEGIN
	 DROP PROC UpdCDRWebDetalle
END
GO

CREATE PROCEDURE [dbo].[UpdCDRWebDetalle] (
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
IF  EXISTS(SELECT * FROM sys.procedures WHERE name  = N'UpdCDRWebDetalle')
BEGIN
	 DROP PROC UpdCDRWebDetalle
END
GO

CREATE PROCEDURE [dbo].[UpdCDRWebDetalle] (
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
IF  EXISTS(SELECT * FROM sys.procedures WHERE name  = N'UpdCDRWebDetalle')
BEGIN
	 DROP PROC UpdCDRWebDetalle
END
GO

CREATE PROCEDURE [dbo].[UpdCDRWebDetalle] (
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
IF  EXISTS(SELECT * FROM sys.procedures WHERE name  = N'UpdCDRWebDetalle')
BEGIN
	 DROP PROC UpdCDRWebDetalle
END
GO

CREATE PROCEDURE [dbo].[UpdCDRWebDetalle] (
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
IF  EXISTS(SELECT * FROM sys.procedures WHERE name  = N'UpdCDRWebDetalle')
BEGIN
	 DROP PROC UpdCDRWebDetalle
END
GO

CREATE PROCEDURE [dbo].[UpdCDRWebDetalle] (
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
IF  EXISTS(SELECT * FROM sys.procedures WHERE name  = N'UpdCDRWebDetalle')
BEGIN
	 DROP PROC UpdCDRWebDetalle
END
GO

CREATE PROCEDURE [dbo].[UpdCDRWebDetalle] (
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
IF  EXISTS(SELECT * FROM sys.procedures WHERE name  = N'UpdCDRWebDetalle')
BEGIN
	 DROP PROC UpdCDRWebDetalle
END
GO

CREATE PROCEDURE [dbo].[UpdCDRWebDetalle] (
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
IF  EXISTS(SELECT * FROM sys.procedures WHERE name  = N'UpdCDRWebDetalle')
BEGIN
	 DROP PROC UpdCDRWebDetalle
END
GO

CREATE PROCEDURE [dbo].[UpdCDRWebDetalle] (
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
IF  EXISTS(SELECT * FROM sys.procedures WHERE name  = N'UpdCDRWebDetalle')
BEGIN
	 DROP PROC UpdCDRWebDetalle
END
GO

CREATE PROCEDURE [dbo].[UpdCDRWebDetalle] (
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
IF  EXISTS(SELECT * FROM sys.procedures WHERE name  = N'UpdCDRWebDetalle')
BEGIN
	 DROP PROC UpdCDRWebDetalle
END
GO

CREATE PROCEDURE [dbo].[UpdCDRWebDetalle] (
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
IF  EXISTS(SELECT * FROM sys.procedures WHERE name  = N'UpdCDRWebDetalle')
BEGIN
	 DROP PROC UpdCDRWebDetalle
END
GO

CREATE PROCEDURE [dbo].[UpdCDRWebDetalle] (
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
