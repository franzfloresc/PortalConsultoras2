USE BelcorpPeru
GO

IF EXISTS (
		SELECT *
		FROM sys.columns c
		INNER JOIN sys.tables t ON c.object_id = t.object_id
		WHERE t.name = N'YobelPedidoTemp'
			AND C.name = 'FlagHoraEstimadaEntrega'
		)
BEGIN
	ALTER TABLE dbo.YobelPedidoTemp

	DROP COLUMN FlagHoraEstimadaEntrega;
END

IF EXISTS (
		SELECT *
		FROM sys.columns c
		INNER JOIN sys.tables t ON c.object_id = t.object_id
		WHERE t.name = N'YobelPedidoTemp'
			AND C.name = 'HoraEstimadaEntregaDesde'
		)
BEGIN
	ALTER TABLE dbo.YobelPedidoTemp

	DROP COLUMN HoraEstimadaEntregaDesde;
END

IF NOT EXISTS (
		SELECT *
		FROM sys.columns c
		INNER JOIN sys.tables t ON c.object_id = t.object_id
		WHERE t.name = N'YobelPedidoTemp'
			AND C.name = 'HoraEstimadaEntregaHasta'
		)
BEGIN
	ALTER TABLE dbo.YobelPedidoTemp

	DROP COLUMN HoraEstimadaEntregaHasta;
END

IF NOT EXISTS (
		SELECT *
		FROM sys.columns c
		INNER JOIN sys.tables t ON c.object_id = t.object_id
		WHERE t.name = N'YobelPedidoTemp'
			AND C.name = 'ColumnaPorDefinir'
		)
BEGIN
	ALTER TABLE dbo.YobelPedidoTemp

	DROP COLUMN ColumnaPorDefinir;
END



