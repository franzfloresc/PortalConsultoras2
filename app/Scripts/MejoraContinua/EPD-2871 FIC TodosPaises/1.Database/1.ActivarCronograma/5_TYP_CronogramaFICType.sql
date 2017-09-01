GO
IF TYPE_ID('CronogramaFICType') IS NULL
	CREATE TYPE CronogramaFICType AS TABLE(
		[CodigoConsultora] [varchar](20) NULL,
		[Zona] [varchar](6) NULL
	)
GO