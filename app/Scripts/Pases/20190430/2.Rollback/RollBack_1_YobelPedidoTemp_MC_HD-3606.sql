USE BelcorpPeru
GO

IF EXISTS (
		SELECT *
		FROM sys.columns c
		INNER JOIN sys.tables t ON c.object_id = t.object_id
		WHERE t.name = N'YobelPedidoTemp'
			AND C.name = 'IndEntregaEstimada'
		)
BEGIN
	ALTER TABLE dbo.YobelPedidoTemp

	DROP COLUMN IndEntregaEstimada;
END

IF EXISTS (
		SELECT *
		FROM sys.columns c
		INNER JOIN sys.tables t ON c.object_id = t.object_id
		WHERE t.name = N'YobelPedidoTemp'
			AND C.name = 'FecHoraEntregaEstimadaDesde'
		)
BEGIN
	ALTER TABLE dbo.YobelPedidoTemp

	DROP COLUMN FecHoraEntregaEstimadaDesde;
END

IF EXISTS (
		SELECT *
		FROM sys.columns c
		INNER JOIN sys.tables t ON c.object_id = t.object_id
		WHERE t.name = N'YobelPedidoTemp'
			AND C.name = 'FecHoraEntregaEstimadaHasta'
		)
BEGIN
	ALTER TABLE dbo.YobelPedidoTemp

	DROP COLUMN FecHoraEntregaEstimadaHasta;
END

IF EXISTS (
		SELECT *
		FROM sys.columns c
		INNER JOIN sys.tables t ON c.object_id = t.object_id
		WHERE t.name = N'YobelPedidoTemp'
			AND C.name = 'IndTipoInformacion'
		)
BEGIN
	ALTER TABLE dbo.YobelPedidoTemp

	DROP COLUMN IndTipoInformacion;
END
go



