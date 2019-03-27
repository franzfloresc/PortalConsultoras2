USE BelcorpPeru
GO

IF NOT EXISTS (
		SELECT *
		FROM sys.columns c
		INNER JOIN sys.tables t ON c.object_id = t.object_id
		WHERE t.name = N'YobelPedidoTemp'
			AND C.name = 'FlagHoraEstimadaEntrega'
		)
BEGIN
	ALTER TABLE dbo.YobelPedidoTemp ADD FlagHoraEstimadaEntrega VARCHAR(4) NULL;
END

IF NOT EXISTS (
		SELECT *
		FROM sys.columns c
		INNER JOIN sys.tables t ON c.object_id = t.object_id
		WHERE t.name = N'YobelPedidoTemp'
			AND C.name = 'HoraEstimadaEntregaDesde'
		)
BEGIN
	ALTER TABLE dbo.YobelPedidoTemp ADD HoraEstimadaEntregaDesde DATETIME NULL;
END

IF NOT EXISTS (
		SELECT *
		FROM sys.columns c
		INNER JOIN sys.tables t ON c.object_id = t.object_id
		WHERE t.name = N'YobelPedidoTemp'
			AND C.name = 'HoraEstimadaEntregaHasta'
		)
BEGIN
	ALTER TABLE dbo.YobelPedidoTemp ADD HoraEstimadaEntregaHasta DATETIME NULL;
END

IF NOT EXISTS (
		SELECT *
		FROM sys.columns c
		INNER JOIN sys.tables t ON c.object_id = t.object_id
		WHERE t.name = N'YobelPedidoTemp'
			AND C.name = 'ColumnaPorDefinir'
		)
BEGIN
	ALTER TABLE dbo.YobelPedidoTemp ADD ColumnaPorDefinir VARCHAR(4) NULL;
END

