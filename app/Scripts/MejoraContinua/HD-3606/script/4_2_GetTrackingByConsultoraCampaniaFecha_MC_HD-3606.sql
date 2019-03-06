USE BelcorpBolivia
GO

CREATE PROCEDURE [dbo].[GetTrackingByConsultoraCampaniaFecha]
	--GetTrackingByConsultoraCampaniaFecha_V2 '040891803' ,'201903','1900998502' 
	--GetTrackingByConsultoraCampaniaFecha '000758604',201901,'1808836983'
	(
	@CodigoConsultora AS VARCHAR(20)
	,@Campana AS VARCHAR(6)
	,@NroPedido AS VARCHAR(50)
	)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT s.ID AS Etapa
		,s.Situacion
		,CASE CONVERT(DATE, t.Fecha)
			WHEN '1900-01-01'
				THEN NULL
			ELSE t.Fecha
			END AS Fecha
		,CASE s.ID
			WHEN 6
				THEN ps.ValorTurno
			ELSE NULL
			END AS ValorTurno
	FROM (
		SELECT ROW_NUMBER() OVER (
				ORDER BY (
						SELECT 100
						)
				) Orden
			,Campana
			,Fecha
		FROM (
			SELECT Campana
				,NroPedido
				,isnull(FechaDigitado, '') AS FechaDigitado
				,isnull(Facturado, '') AS Facturado
				,isnull(EnArmado, '') AS EnArmado
				,isnull(Chequeado, '') AS Chequeado
				,isnull(Despachado, '') AS Despachado
				,CONVERT(DATETIME, FechaEstimada) AS FechaEstimada
				,isnull(Recibido, '') AS Recibido
				,isnull(FechaEstimadaDesde, '') AS FechaEstimadaDesde
				,isnull(FechaEstimadaHasta, '') AS FechaEstimadaHasta
			FROM vwTracking
			WHERE Consultora = @CodigoConsultora
				AND Campana = @Campana
				AND NroPedido = @NroPedido
			) p
		UNPIVOT(Fecha FOR p IN (
					FechaDigitado
					,Facturado
					,EnArmado
					,Chequeado
					,Despachado
					,FechaEstimada
					,Recibido
					,FechaEstimadaDesde
					,FechaEstimadaHasta
					)) AS unpvt
		) AS t
	LEFT JOIN vwSituacionPedido s ON t.Orden = s.ID
	LEFT JOIN ods.PedidoSeguimiento ps ON (
			t.Campana = ps.AnoCampana
			AND ps.CodigoConsultora = @CodigoConsultora
			)
	WHERE ps.NumeroDocumentoPedido = @NroPedido;

	SET NOCOUNT OFF;
END
GO

USE BelcorpChile
go

CREATE PROCEDURE [dbo].[GetTrackingByConsultoraCampaniaFecha]
	--GetTrackingByConsultoraCampaniaFecha_V2 '040891803' ,'201903','1900998502' 
	--GetTrackingByConsultoraCampaniaFecha '000758604',201901,'1808836983'
	(
	@CodigoConsultora AS VARCHAR(20)
	,@Campana AS VARCHAR(6)
	,@NroPedido AS VARCHAR(50)
	)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT s.ID AS Etapa
		,s.Situacion
		,CASE CONVERT(DATE, t.Fecha)
			WHEN '1900-01-01'
				THEN NULL
			ELSE t.Fecha
			END AS Fecha
		,CASE s.ID
			WHEN 6
				THEN ps.ValorTurno
			ELSE NULL
			END AS ValorTurno
	FROM (
		SELECT ROW_NUMBER() OVER (
				ORDER BY (
						SELECT 100
						)
				) Orden
			,Campana
			,Fecha
		FROM (
			SELECT Campana
				,NroPedido
				,isnull(FechaDigitado, '') AS FechaDigitado
				,isnull(Facturado, '') AS Facturado
				,isnull(EnArmado, '') AS EnArmado
				,isnull(Chequeado, '') AS Chequeado
				,isnull(Despachado, '') AS Despachado
				,CONVERT(DATETIME, FechaEstimada) AS FechaEstimada
				,isnull(Recibido, '') AS Recibido
				,isnull(FechaEstimadaDesde, '') AS FechaEstimadaDesde
				,isnull(FechaEstimadaHasta, '') AS FechaEstimadaHasta
			FROM vwTracking
			WHERE Consultora = @CodigoConsultora
				AND Campana = @Campana
				AND NroPedido = @NroPedido
			) p
		UNPIVOT(Fecha FOR p IN (
					FechaDigitado
					,Facturado
					,EnArmado
					,Chequeado
					,Despachado
					,FechaEstimada
					,Recibido
					,FechaEstimadaDesde
					,FechaEstimadaHasta
					)) AS unpvt
		) AS t
	LEFT JOIN vwSituacionPedido s ON t.Orden = s.ID
	LEFT JOIN ods.PedidoSeguimiento ps ON (
			t.Campana = ps.AnoCampana
			AND ps.CodigoConsultora = @CodigoConsultora
			)
	WHERE ps.NumeroDocumentoPedido = @NroPedido;

	SET NOCOUNT OFF;
END
GO

USE BelcorpColombia
GO

CREATE PROCEDURE [dbo].[GetTrackingByConsultoraCampaniaFecha]
	--GetTrackingByConsultoraCampaniaFecha_V2 '040891803' ,'201903','1900998502' 
	--GetTrackingByConsultoraCampaniaFecha '000758604',201901,'1808836983'
	(
	@CodigoConsultora AS VARCHAR(20)
	,@Campana AS VARCHAR(6)
	,@NroPedido AS VARCHAR(50)
	)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT s.ID AS Etapa
		,s.Situacion
		,CASE CONVERT(DATE, t.Fecha)
			WHEN '1900-01-01'
				THEN NULL
			ELSE t.Fecha
			END AS Fecha
		,CASE s.ID
			WHEN 6
				THEN ps.ValorTurno
			ELSE NULL
			END AS ValorTurno
	FROM (
		SELECT ROW_NUMBER() OVER (
				ORDER BY (
						SELECT 100
						)
				) Orden
			,Campana
			,Fecha
		FROM (
			SELECT Campana
				,NroPedido
				,isnull(FechaDigitado, '') AS FechaDigitado
				,isnull(Facturado, '') AS Facturado
				,isnull(EnArmado, '') AS EnArmado
				,isnull(Chequeado, '') AS Chequeado
				,isnull(Despachado, '') AS Despachado
				,CONVERT(DATETIME, FechaEstimada) AS FechaEstimada
				,isnull(Recibido, '') AS Recibido
				,isnull(FechaEstimadaDesde, '') AS FechaEstimadaDesde
				,isnull(FechaEstimadaHasta, '') AS FechaEstimadaHasta
			FROM vwTracking
			WHERE Consultora = @CodigoConsultora
				AND Campana = @Campana
				AND NroPedido = @NroPedido
			) p
		UNPIVOT(Fecha FOR p IN (
					FechaDigitado
					,Facturado
					,EnArmado
					,Chequeado
					,Despachado
					,FechaEstimada
					,Recibido
					,FechaEstimadaDesde
					,FechaEstimadaHasta
					)) AS unpvt
		) AS t
	LEFT JOIN vwSituacionPedido s ON t.Orden = s.ID
	LEFT JOIN ods.PedidoSeguimiento ps ON (
			t.Campana = ps.AnoCampana
			AND ps.CodigoConsultora = @CodigoConsultora
			)
	WHERE ps.NumeroDocumentoPedido = @NroPedido;

	SET NOCOUNT OFF;
END
GO

USE BelcorpCostaRica
GO

CREATE PROCEDURE [dbo].[GetTrackingByConsultoraCampaniaFecha]
	--GetTrackingByConsultoraCampaniaFecha_V2 '040891803' ,'201903','1900998502' 
	--GetTrackingByConsultoraCampaniaFecha '000758604',201901,'1808836983'
	(
	@CodigoConsultora AS VARCHAR(20)
	,@Campana AS VARCHAR(6)
	,@NroPedido AS VARCHAR(50)
	)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT s.ID AS Etapa
		,s.Situacion
		,CASE CONVERT(DATE, t.Fecha)
			WHEN '1900-01-01'
				THEN NULL
			ELSE t.Fecha
			END AS Fecha
		,CASE s.ID
			WHEN 6
				THEN ps.ValorTurno
			ELSE NULL
			END AS ValorTurno
	FROM (
		SELECT ROW_NUMBER() OVER (
				ORDER BY (
						SELECT 100
						)
				) Orden
			,Campana
			,Fecha
		FROM (
			SELECT Campana
				,NroPedido
				,isnull(FechaDigitado, '') AS FechaDigitado
				,isnull(Facturado, '') AS Facturado
				,isnull(EnArmado, '') AS EnArmado
				,isnull(Chequeado, '') AS Chequeado
				,isnull(Despachado, '') AS Despachado
				,CONVERT(DATETIME, FechaEstimada) AS FechaEstimada
				,isnull(Recibido, '') AS Recibido
				,isnull(FechaEstimadaDesde, '') AS FechaEstimadaDesde
				,isnull(FechaEstimadaHasta, '') AS FechaEstimadaHasta
			FROM vwTracking
			WHERE Consultora = @CodigoConsultora
				AND Campana = @Campana
				AND NroPedido = @NroPedido
			) p
		UNPIVOT(Fecha FOR p IN (
					FechaDigitado
					,Facturado
					,EnArmado
					,Chequeado
					,Despachado
					,FechaEstimada
					,Recibido
					,FechaEstimadaDesde
					,FechaEstimadaHasta
					)) AS unpvt
		) AS t
	LEFT JOIN vwSituacionPedido s ON t.Orden = s.ID
	LEFT JOIN ods.PedidoSeguimiento ps ON (
			t.Campana = ps.AnoCampana
			AND ps.CodigoConsultora = @CodigoConsultora
			)
	WHERE ps.NumeroDocumentoPedido = @NroPedido;

	SET NOCOUNT OFF;
END
GO

USE BelcorpDominicana
GO

CREATE PROCEDURE [dbo].[GetTrackingByConsultoraCampaniaFecha]
	--GetTrackingByConsultoraCampaniaFecha_V2 '040891803' ,'201903','1900998502' 
	--GetTrackingByConsultoraCampaniaFecha '000758604',201901,'1808836983'
	(
	@CodigoConsultora AS VARCHAR(20)
	,@Campana AS VARCHAR(6)
	,@NroPedido AS VARCHAR(50)
	)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT s.ID AS Etapa
		,s.Situacion
		,CASE CONVERT(DATE, t.Fecha)
			WHEN '1900-01-01'
				THEN NULL
			ELSE t.Fecha
			END AS Fecha
		,CASE s.ID
			WHEN 6
				THEN ps.ValorTurno
			ELSE NULL
			END AS ValorTurno
	FROM (
		SELECT ROW_NUMBER() OVER (
				ORDER BY (
						SELECT 100
						)
				) Orden
			,Campana
			,Fecha
		FROM (
			SELECT Campana
				,NroPedido
				,isnull(FechaDigitado, '') AS FechaDigitado
				,isnull(Facturado, '') AS Facturado
				,isnull(EnArmado, '') AS EnArmado
				,isnull(Chequeado, '') AS Chequeado
				,isnull(Despachado, '') AS Despachado
				,CONVERT(DATETIME, FechaEstimada) AS FechaEstimada
				,isnull(Recibido, '') AS Recibido
				,isnull(FechaEstimadaDesde, '') AS FechaEstimadaDesde
				,isnull(FechaEstimadaHasta, '') AS FechaEstimadaHasta
			FROM vwTracking
			WHERE Consultora = @CodigoConsultora
				AND Campana = @Campana
				AND NroPedido = @NroPedido
			) p
		UNPIVOT(Fecha FOR p IN (
					FechaDigitado
					,Facturado
					,EnArmado
					,Chequeado
					,Despachado
					,FechaEstimada
					,Recibido
					,FechaEstimadaDesde
					,FechaEstimadaHasta
					)) AS unpvt
		) AS t
	LEFT JOIN vwSituacionPedido s ON t.Orden = s.ID
	LEFT JOIN ods.PedidoSeguimiento ps ON (
			t.Campana = ps.AnoCampana
			AND ps.CodigoConsultora = @CodigoConsultora
			)
	WHERE ps.NumeroDocumentoPedido = @NroPedido;

	SET NOCOUNT OFF;
END
GO

USE BelcorpEcuador
GO

CREATE PROCEDURE [dbo].[GetTrackingByConsultoraCampaniaFecha]
	--GetTrackingByConsultoraCampaniaFecha_V2 '040891803' ,'201903','1900998502' 
	--GetTrackingByConsultoraCampaniaFecha '000758604',201901,'1808836983'
	(
	@CodigoConsultora AS VARCHAR(20)
	,@Campana AS VARCHAR(6)
	,@NroPedido AS VARCHAR(50)
	)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT s.ID AS Etapa
		,s.Situacion
		,CASE CONVERT(DATE, t.Fecha)
			WHEN '1900-01-01'
				THEN NULL
			ELSE t.Fecha
			END AS Fecha
		,CASE s.ID
			WHEN 6
				THEN ps.ValorTurno
			ELSE NULL
			END AS ValorTurno
	FROM (
		SELECT ROW_NUMBER() OVER (
				ORDER BY (
						SELECT 100
						)
				) Orden
			,Campana
			,Fecha
		FROM (
			SELECT Campana
				,NroPedido
				,isnull(FechaDigitado, '') AS FechaDigitado
				,isnull(Facturado, '') AS Facturado
				,isnull(EnArmado, '') AS EnArmado
				,isnull(Chequeado, '') AS Chequeado
				,isnull(Despachado, '') AS Despachado
				,CONVERT(DATETIME, FechaEstimada) AS FechaEstimada
				,isnull(Recibido, '') AS Recibido
				,isnull(FechaEstimadaDesde, '') AS FechaEstimadaDesde
				,isnull(FechaEstimadaHasta, '') AS FechaEstimadaHasta
			FROM vwTracking
			WHERE Consultora = @CodigoConsultora
				AND Campana = @Campana
				AND NroPedido = @NroPedido
			) p
		UNPIVOT(Fecha FOR p IN (
					FechaDigitado
					,Facturado
					,EnArmado
					,Chequeado
					,Despachado
					,FechaEstimada
					,Recibido
					,FechaEstimadaDesde
					,FechaEstimadaHasta
					)) AS unpvt
		) AS t
	LEFT JOIN vwSituacionPedido s ON t.Orden = s.ID
	LEFT JOIN ods.PedidoSeguimiento ps ON (
			t.Campana = ps.AnoCampana
			AND ps.CodigoConsultora = @CodigoConsultora
			)
	WHERE ps.NumeroDocumentoPedido = @NroPedido;

	SET NOCOUNT OFF;
END
GO

USE BelcorpGuatemala
GO

CREATE PROCEDURE [dbo].[GetTrackingByConsultoraCampaniaFecha]
	--GetTrackingByConsultoraCampaniaFecha_V2 '040891803' ,'201903','1900998502' 
	--GetTrackingByConsultoraCampaniaFecha '000758604',201901,'1808836983'
	(
	@CodigoConsultora AS VARCHAR(20)
	,@Campana AS VARCHAR(6)
	,@NroPedido AS VARCHAR(50)
	)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT s.ID AS Etapa
		,s.Situacion
		,CASE CONVERT(DATE, t.Fecha)
			WHEN '1900-01-01'
				THEN NULL
			ELSE t.Fecha
			END AS Fecha
		,CASE s.ID
			WHEN 6
				THEN ps.ValorTurno
			ELSE NULL
			END AS ValorTurno
	FROM (
		SELECT ROW_NUMBER() OVER (
				ORDER BY (
						SELECT 100
						)
				) Orden
			,Campana
			,Fecha
		FROM (
			SELECT Campana
				,NroPedido
				,isnull(FechaDigitado, '') AS FechaDigitado
				,isnull(Facturado, '') AS Facturado
				,isnull(EnArmado, '') AS EnArmado
				,isnull(Chequeado, '') AS Chequeado
				,isnull(Despachado, '') AS Despachado
				,CONVERT(DATETIME, FechaEstimada) AS FechaEstimada
				,isnull(Recibido, '') AS Recibido
				,isnull(FechaEstimadaDesde, '') AS FechaEstimadaDesde
				,isnull(FechaEstimadaHasta, '') AS FechaEstimadaHasta
			FROM vwTracking
			WHERE Consultora = @CodigoConsultora
				AND Campana = @Campana
				AND NroPedido = @NroPedido
			) p
		UNPIVOT(Fecha FOR p IN (
					FechaDigitado
					,Facturado
					,EnArmado
					,Chequeado
					,Despachado
					,FechaEstimada
					,Recibido
					,FechaEstimadaDesde
					,FechaEstimadaHasta
					)) AS unpvt
		) AS t
	LEFT JOIN vwSituacionPedido s ON t.Orden = s.ID
	LEFT JOIN ods.PedidoSeguimiento ps ON (
			t.Campana = ps.AnoCampana
			AND ps.CodigoConsultora = @CodigoConsultora
			)
	WHERE ps.NumeroDocumentoPedido = @NroPedido;

	SET NOCOUNT OFF;
END
GO

USE BelcorpMexico
GO

CREATE PROCEDURE [dbo].[GetTrackingByConsultoraCampaniaFecha]
	--GetTrackingByConsultoraCampaniaFecha_V2 '040891803' ,'201903','1900998502' 
	--GetTrackingByConsultoraCampaniaFecha '000758604',201901,'1808836983'
	(
	@CodigoConsultora AS VARCHAR(20)
	,@Campana AS VARCHAR(6)
	,@NroPedido AS VARCHAR(50)
	)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT s.ID AS Etapa
		,s.Situacion
		,CASE CONVERT(DATE, t.Fecha)
			WHEN '1900-01-01'
				THEN NULL
			ELSE t.Fecha
			END AS Fecha
		,CASE s.ID
			WHEN 6
				THEN ps.ValorTurno
			ELSE NULL
			END AS ValorTurno
	FROM (
		SELECT ROW_NUMBER() OVER (
				ORDER BY (
						SELECT 100
						)
				) Orden
			,Campana
			,Fecha
		FROM (
			SELECT Campana
				,NroPedido
				,isnull(FechaDigitado, '') AS FechaDigitado
				,isnull(Facturado, '') AS Facturado
				,isnull(EnArmado, '') AS EnArmado
				,isnull(Chequeado, '') AS Chequeado
				,isnull(Despachado, '') AS Despachado
				,CONVERT(DATETIME, FechaEstimada) AS FechaEstimada
				,isnull(Recibido, '') AS Recibido
				,isnull(FechaEstimadaDesde, '') AS FechaEstimadaDesde
				,isnull(FechaEstimadaHasta, '') AS FechaEstimadaHasta
			FROM vwTracking
			WHERE Consultora = @CodigoConsultora
				AND Campana = @Campana
				AND NroPedido = @NroPedido
			) p
		UNPIVOT(Fecha FOR p IN (
					FechaDigitado
					,Facturado
					,EnArmado
					,Chequeado
					,Despachado
					,FechaEstimada
					,Recibido
					,FechaEstimadaDesde
					,FechaEstimadaHasta
					)) AS unpvt
		) AS t
	LEFT JOIN vwSituacionPedido s ON t.Orden = s.ID
	LEFT JOIN ods.PedidoSeguimiento ps ON (
			t.Campana = ps.AnoCampana
			AND ps.CodigoConsultora = @CodigoConsultora
			)
	WHERE ps.NumeroDocumentoPedido = @NroPedido;

	SET NOCOUNT OFF;
END
GO

USE BelcorpPanama
GO

CREATE PROCEDURE [dbo].[GetTrackingByConsultoraCampaniaFecha]
	--GetTrackingByConsultoraCampaniaFecha_V2 '040891803' ,'201903','1900998502' 
	--GetTrackingByConsultoraCampaniaFecha '000758604',201901,'1808836983'
	(
	@CodigoConsultora AS VARCHAR(20)
	,@Campana AS VARCHAR(6)
	,@NroPedido AS VARCHAR(50)
	)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT s.ID AS Etapa
		,s.Situacion
		,CASE CONVERT(DATE, t.Fecha)
			WHEN '1900-01-01'
				THEN NULL
			ELSE t.Fecha
			END AS Fecha
		,CASE s.ID
			WHEN 6
				THEN ps.ValorTurno
			ELSE NULL
			END AS ValorTurno
	FROM (
		SELECT ROW_NUMBER() OVER (
				ORDER BY (
						SELECT 100
						)
				) Orden
			,Campana
			,Fecha
		FROM (
			SELECT Campana
				,NroPedido
				,isnull(FechaDigitado, '') AS FechaDigitado
				,isnull(Facturado, '') AS Facturado
				,isnull(EnArmado, '') AS EnArmado
				,isnull(Chequeado, '') AS Chequeado
				,isnull(Despachado, '') AS Despachado
				,CONVERT(DATETIME, FechaEstimada) AS FechaEstimada
				,isnull(Recibido, '') AS Recibido
				,isnull(FechaEstimadaDesde, '') AS FechaEstimadaDesde
				,isnull(FechaEstimadaHasta, '') AS FechaEstimadaHasta
			FROM vwTracking
			WHERE Consultora = @CodigoConsultora
				AND Campana = @Campana
				AND NroPedido = @NroPedido
			) p
		UNPIVOT(Fecha FOR p IN (
					FechaDigitado
					,Facturado
					,EnArmado
					,Chequeado
					,Despachado
					,FechaEstimada
					,Recibido
					,FechaEstimadaDesde
					,FechaEstimadaHasta
					)) AS unpvt
		) AS t
	LEFT JOIN vwSituacionPedido s ON t.Orden = s.ID
	LEFT JOIN ods.PedidoSeguimiento ps ON (
			t.Campana = ps.AnoCampana
			AND ps.CodigoConsultora = @CodigoConsultora
			)
	WHERE ps.NumeroDocumentoPedido = @NroPedido;

	SET NOCOUNT OFF;
END
GO

USE BelcorpPeru
GO

CREATE PROCEDURE [dbo].[GetTrackingByConsultoraCampaniaFecha]
	--GetTrackingByConsultoraCampaniaFecha_V2 '040891803' ,'201903','1900998502' 
	--GetTrackingByConsultoraCampaniaFecha '000758604',201901,'1808836983'
	(
	@CodigoConsultora AS VARCHAR(20)
	,@Campana AS VARCHAR(6)
	,@NroPedido AS VARCHAR(50)
	)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT s.ID AS Etapa
		,s.Situacion
		,CASE CONVERT(DATE, t.Fecha)
			WHEN '1900-01-01'
				THEN NULL
			ELSE t.Fecha
			END AS Fecha
		,CASE s.ID
			WHEN 6
				THEN ps.ValorTurno
			ELSE NULL
			END AS ValorTurno
	FROM (
		SELECT ROW_NUMBER() OVER (
				ORDER BY (
						SELECT 100
						)
				) Orden
			,Campana
			,Fecha
		FROM (
			SELECT Campana
				,NroPedido
				,isnull(FechaDigitado, '') AS FechaDigitado
				,isnull(Facturado, '') AS Facturado
				,isnull(EnArmado, '') AS EnArmado
				,isnull(Chequeado, '') AS Chequeado
				,isnull(Despachado, '') AS Despachado
				,CONVERT(DATETIME, FechaEstimada) AS FechaEstimada
				,isnull(Recibido, '') AS Recibido
				,isnull(FechaEstimadaDesde, '') AS FechaEstimadaDesde
				,isnull(FechaEstimadaHasta, '') AS FechaEstimadaHasta
			FROM vwTracking
			WHERE Consultora = @CodigoConsultora
				AND Campana = @Campana
				AND NroPedido = @NroPedido
			) p
		UNPIVOT(Fecha FOR p IN (
					FechaDigitado
					,Facturado
					,EnArmado
					,Chequeado
					,Despachado
					,FechaEstimada
					,Recibido
					,FechaEstimadaDesde
					,FechaEstimadaHasta
					)) AS unpvt
		) AS t
	LEFT JOIN vwSituacionPedido s ON t.Orden = s.ID
	LEFT JOIN ods.PedidoSeguimiento ps ON (
			t.Campana = ps.AnoCampana
			AND ps.CodigoConsultora = @CodigoConsultora
			)
	WHERE ps.NumeroDocumentoPedido = @NroPedido;

	SET NOCOUNT OFF;
END
GO

USE BelcorpPuertoRico
GO

CREATE PROCEDURE [dbo].[GetTrackingByConsultoraCampaniaFecha]
	--GetTrackingByConsultoraCampaniaFecha_V2 '040891803' ,'201903','1900998502' 
	--GetTrackingByConsultoraCampaniaFecha '000758604',201901,'1808836983'
	(
	@CodigoConsultora AS VARCHAR(20)
	,@Campana AS VARCHAR(6)
	,@NroPedido AS VARCHAR(50)
	)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT s.ID AS Etapa
		,s.Situacion
		,CASE CONVERT(DATE, t.Fecha)
			WHEN '1900-01-01'
				THEN NULL
			ELSE t.Fecha
			END AS Fecha
		,CASE s.ID
			WHEN 6
				THEN ps.ValorTurno
			ELSE NULL
			END AS ValorTurno
	FROM (
		SELECT ROW_NUMBER() OVER (
				ORDER BY (
						SELECT 100
						)
				) Orden
			,Campana
			,Fecha
		FROM (
			SELECT Campana
				,NroPedido
				,isnull(FechaDigitado, '') AS FechaDigitado
				,isnull(Facturado, '') AS Facturado
				,isnull(EnArmado, '') AS EnArmado
				,isnull(Chequeado, '') AS Chequeado
				,isnull(Despachado, '') AS Despachado
				,CONVERT(DATETIME, FechaEstimada) AS FechaEstimada
				,isnull(Recibido, '') AS Recibido
				,isnull(FechaEstimadaDesde, '') AS FechaEstimadaDesde
				,isnull(FechaEstimadaHasta, '') AS FechaEstimadaHasta
			FROM vwTracking
			WHERE Consultora = @CodigoConsultora
				AND Campana = @Campana
				AND NroPedido = @NroPedido
			) p
		UNPIVOT(Fecha FOR p IN (
					FechaDigitado
					,Facturado
					,EnArmado
					,Chequeado
					,Despachado
					,FechaEstimada
					,Recibido
					,FechaEstimadaDesde
					,FechaEstimadaHasta
					)) AS unpvt
		) AS t
	LEFT JOIN vwSituacionPedido s ON t.Orden = s.ID
	LEFT JOIN ods.PedidoSeguimiento ps ON (
			t.Campana = ps.AnoCampana
			AND ps.CodigoConsultora = @CodigoConsultora
			)
	WHERE ps.NumeroDocumentoPedido = @NroPedido;

	SET NOCOUNT OFF;
END
GO

USE BelcorpSalvador
GO

CREATE PROCEDURE [dbo].[GetTrackingByConsultoraCampaniaFecha]
	--GetTrackingByConsultoraCampaniaFecha_V2 '040891803' ,'201903','1900998502' 
	--GetTrackingByConsultoraCampaniaFecha '000758604',201901,'1808836983'
	(
	@CodigoConsultora AS VARCHAR(20)
	,@Campana AS VARCHAR(6)
	,@NroPedido AS VARCHAR(50)
	)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT s.ID AS Etapa
		,s.Situacion
		,CASE CONVERT(DATE, t.Fecha)
			WHEN '1900-01-01'
				THEN NULL
			ELSE t.Fecha
			END AS Fecha
		,CASE s.ID
			WHEN 6
				THEN ps.ValorTurno
			ELSE NULL
			END AS ValorTurno
	FROM (
		SELECT ROW_NUMBER() OVER (
				ORDER BY (
						SELECT 100
						)
				) Orden
			,Campana
			,Fecha
		FROM (
			SELECT Campana
				,NroPedido
				,isnull(FechaDigitado, '') AS FechaDigitado
				,isnull(Facturado, '') AS Facturado
				,isnull(EnArmado, '') AS EnArmado
				,isnull(Chequeado, '') AS Chequeado
				,isnull(Despachado, '') AS Despachado
				,CONVERT(DATETIME, FechaEstimada) AS FechaEstimada
				,isnull(Recibido, '') AS Recibido
				,isnull(FechaEstimadaDesde, '') AS FechaEstimadaDesde
				,isnull(FechaEstimadaHasta, '') AS FechaEstimadaHasta
			FROM vwTracking
			WHERE Consultora = @CodigoConsultora
				AND Campana = @Campana
				AND NroPedido = @NroPedido
			) p
		UNPIVOT(Fecha FOR p IN (
					FechaDigitado
					,Facturado
					,EnArmado
					,Chequeado
					,Despachado
					,FechaEstimada
					,Recibido
					,FechaEstimadaDesde
					,FechaEstimadaHasta
					)) AS unpvt
		) AS t
	LEFT JOIN vwSituacionPedido s ON t.Orden = s.ID
	LEFT JOIN ods.PedidoSeguimiento ps ON (
			t.Campana = ps.AnoCampana
			AND ps.CodigoConsultora = @CodigoConsultora
			)
	WHERE ps.NumeroDocumentoPedido = @NroPedido;

	SET NOCOUNT OFF;
END
GO


