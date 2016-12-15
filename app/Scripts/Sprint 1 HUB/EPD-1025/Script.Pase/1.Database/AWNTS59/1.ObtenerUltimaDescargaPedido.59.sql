
USE BelcorpColombia
GO
IF (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.PedidoDescarga') and SYSCOLUMNS.NAME = N'Desmarcado') = 0
	ALTER TABLE dbo.PedidoDescarga ADD Desmarcado BIT NULL
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaPedido]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaPedido]
GO

CREATE PROCEDURE [dbo].[ObtenerUltimaDescargaPedido]
AS

BEGIN
	DECLARE @NroLote AS INT

	DECLARE @NroPedidosWeb AS INT
	DECLARE @NroPedidosDD AS INT
	DECLARE @TipoCronograma AS INT

	-- Obtener el NroLote de la ultima descarga.
	SELECT TOP 1 @NroLote = NroLote, @TipoCronograma = TipoCronograma FROM PedidoDescarga ORDER BY FechaInicio DESC

	-- Obtener la cantidad de pedidos Web y DD.
	SELECT @NroPedidosWeb = COUNT(*) FROM LogCargaPedido WHERE NroLote = @NroLote AND Origen = 'W'
	SELECT @NroPedidosDD = COUNT(*) FROM LogCargaPedido WHERE NroLote = @NroLote AND Origen = 'D'
	
	SELECT	FechaInicio AS FechaHoraInicio, 
			FechaFin  AS FechaHoraFin, 
			CASE 
				WHEN Estado = 1 THEN 'Averiguar el Estado'
				WHEN Estado = 99 THEN 'Error'
				WHEN Estado = 2 THEN 'Terminado'
			END
			AS Estado,
			Mensaje, 
			@NroPedidosWeb AS NumeroPedidosWeb, 
			@NroPedidosDD AS NumeroPedidosDD, 
			CASE 
				WHEN TipoCronograma = 1 THEN 'Regular'
				WHEN TipoCronograma = 2 THEN 'Demanda Anticipada'
				WHEN TipoCronograma = 3 THEN 'Demanda Anticipada PRD'
				WHEN TipoCronograma = 4 THEN 'FIC'
				WHEN TipoCronograma = 5 THEN 'Generar Líderes'
				WHEN TipoCronograma = 6 THEN 'Digitacion Distribuida Parcial'
			END
			AS TipoProceso,			
			FechaFactura AS FechaFacturacion,
			NroLote,
			Desmarcado
	FROM	PedidoDescarga
	WHERE	NroLote = @NroLote 
END

GO
-----------------------------------------------------------------------



USE BelcorpMexico
GO
IF (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.PedidoDescarga') and SYSCOLUMNS.NAME = N'Desmarcado') = 0
	ALTER TABLE dbo.PedidoDescarga ADD Desmarcado BIT NULL
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaPedido]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaPedido]
GO

CREATE PROCEDURE [dbo].[ObtenerUltimaDescargaPedido]
AS

BEGIN
	DECLARE @NroLote AS INT

	DECLARE @NroPedidosWeb AS INT
	DECLARE @NroPedidosDD AS INT
	DECLARE @TipoCronograma AS INT

	-- Obtener el NroLote de la ultima descarga.
	SELECT TOP 1 @NroLote = NroLote, @TipoCronograma = TipoCronograma FROM PedidoDescarga ORDER BY FechaInicio DESC

	-- Obtener la cantidad de pedidos Web y DD.
	SELECT @NroPedidosWeb = COUNT(*) FROM LogCargaPedido WHERE NroLote = @NroLote AND Origen = 'W'
	SELECT @NroPedidosDD = COUNT(*) FROM LogCargaPedido WHERE NroLote = @NroLote AND Origen = 'D'
	
	SELECT	FechaInicio AS FechaHoraInicio, 
			FechaFin  AS FechaHoraFin, 
			CASE 
				WHEN Estado = 1 THEN 'Averiguar el Estado'
				WHEN Estado = 99 THEN 'Error'
				WHEN Estado = 2 THEN 'Terminado'
			END
			AS Estado,
			Mensaje, 
			@NroPedidosWeb AS NumeroPedidosWeb, 
			@NroPedidosDD AS NumeroPedidosDD, 
			CASE 
				WHEN TipoCronograma = 1 THEN 'Regular'
				WHEN TipoCronograma = 2 THEN 'Demanda Anticipada'
				WHEN TipoCronograma = 3 THEN 'Demanda Anticipada PRD'
				WHEN TipoCronograma = 4 THEN 'FIC'
				WHEN TipoCronograma = 5 THEN 'Generar Líderes'
				WHEN TipoCronograma = 6 THEN 'Digitacion Distribuida Parcial'
			END
			AS TipoProceso,			
			FechaFactura AS FechaFacturacion,
			NroLote,
			Desmarcado
	FROM	PedidoDescarga
	WHERE	NroLote = @NroLote 
END

GO
-----------------------------------------------------------------------



USE BelcorpPeru
GO
IF (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.PedidoDescarga') and SYSCOLUMNS.NAME = N'Desmarcado') = 0
	ALTER TABLE dbo.PedidoDescarga ADD Desmarcado BIT NULL
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerUltimaDescargaPedido]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerUltimaDescargaPedido]
GO

CREATE PROCEDURE [dbo].[ObtenerUltimaDescargaPedido]
AS

BEGIN
	DECLARE @NroLote AS INT

	DECLARE @NroPedidosWeb AS INT
	DECLARE @NroPedidosDD AS INT
	DECLARE @TipoCronograma AS INT

	-- Obtener el NroLote de la ultima descarga.
	SELECT TOP 1 @NroLote = NroLote, @TipoCronograma = TipoCronograma FROM PedidoDescarga ORDER BY FechaInicio DESC

	-- Obtener la cantidad de pedidos Web y DD.
	SELECT @NroPedidosWeb = COUNT(*) FROM LogCargaPedido WHERE NroLote = @NroLote AND Origen = 'W'
	SELECT @NroPedidosDD = COUNT(*) FROM LogCargaPedido WHERE NroLote = @NroLote AND Origen = 'D'
	
	SELECT	FechaInicio AS FechaHoraInicio, 
			FechaFin  AS FechaHoraFin, 
			CASE 
				WHEN Estado = 1 THEN 'Averiguar el Estado'
				WHEN Estado = 99 THEN 'Error'
				WHEN Estado = 2 THEN 'Terminado'
			END
			AS Estado,
			Mensaje, 
			@NroPedidosWeb AS NumeroPedidosWeb, 
			@NroPedidosDD AS NumeroPedidosDD, 
			CASE 
				WHEN TipoCronograma = 1 THEN 'Regular'
				WHEN TipoCronograma = 2 THEN 'Demanda Anticipada'
				WHEN TipoCronograma = 3 THEN 'Demanda Anticipada PRD'
				WHEN TipoCronograma = 4 THEN 'FIC'
				WHEN TipoCronograma = 5 THEN 'Generar Líderes'
				WHEN TipoCronograma = 6 THEN 'Digitacion Distribuida Parcial'
			END
			AS TipoProceso,			
			FechaFactura AS FechaFacturacion,
			NroLote,
			Desmarcado
	FROM	PedidoDescarga
	WHERE	NroLote = @NroLote 
END

GO

