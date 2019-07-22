USE BelcorpPeru
GO

IF NOT EXISTS (
		SELECT *
		FROM sys.columns c
		INNER JOIN sys.tables t ON c.object_id = t.object_id
		WHERE t.name = N'YobelPedidoTemp'
			AND C.name = 'IndEntregaEstimada'
		)
BEGIN
	ALTER TABLE dbo.YobelPedidoTemp ADD IndEntregaEstimada VARCHAR(2) NULL;
END

IF NOT EXISTS (
		SELECT *
		FROM sys.columns c
		INNER JOIN sys.tables t ON c.object_id = t.object_id
		WHERE t.name = N'YobelPedidoTemp'
			AND C.name = 'FecHoraEntregaEstimadaDesde'
		)
BEGIN
	ALTER TABLE dbo.YobelPedidoTemp ADD FecHoraEntregaEstimadaDesde DATETIME NULL;
END

IF NOT EXISTS (
		SELECT *
		FROM sys.columns c
		INNER JOIN sys.tables t ON c.object_id = t.object_id
		WHERE t.name = N'YobelPedidoTemp'
			AND C.name = 'FecHoraEntregaEstimadaHasta'
		)
BEGIN
	ALTER TABLE dbo.YobelPedidoTemp ADD FecHoraEntregaEstimadaHasta DATETIME NULL;
END

IF NOT EXISTS (
		SELECT *
		FROM sys.columns c
		INNER JOIN sys.tables t ON c.object_id = t.object_id
		WHERE t.name = N'YobelPedidoTemp'
			AND C.name = 'IndTipoInformacion'
		)
BEGIN
	ALTER TABLE dbo.YobelPedidoTemp ADD IndTipoInformacion VARCHAR(2) NULL;
END


