
USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DesmarcarUltimaDescargaPedido]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]
GO

CREATE PROCEDURE dbo.DesmarcarUltimaDescargaPedido	
AS

BEGIN

	DECLARE @NroLote AS INT
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote

END

GO

---------------------------------------------------------------------


USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DesmarcarUltimaDescargaPedido]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]
GO

CREATE PROCEDURE dbo.DesmarcarUltimaDescargaPedido	
AS

BEGIN

	DECLARE @NroLote AS INT
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote

END

GO

---------------------------------------------------------------------


USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DesmarcarUltimaDescargaPedido]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[DesmarcarUltimaDescargaPedido]
GO

CREATE PROCEDURE dbo.DesmarcarUltimaDescargaPedido	
AS

BEGIN

	DECLARE @NroLote AS INT
	SELECT TOP 1 @NroLote = NroLote FROM PedidoDescarga ORDER BY FechaInicio DESC

	UPDATE PW
	SET PW.GPRSB = 0, PW.IndicadorEnviado = 0 
	FROM PedidoWeb PW
	INNER JOIN LogCargaPedidoDetalle LPD ON PW.PedidoID = LPD.PedidoID
	WHERE NroLote = @NroLote

	UPDATE PedidoDescarga SET Desmarcado = 1 WHERE NroLote = @NroLote

END

GO

