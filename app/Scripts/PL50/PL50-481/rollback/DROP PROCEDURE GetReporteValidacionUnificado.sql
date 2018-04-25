USE belcorpperu
GO

IF (OBJECT_ID('dbo.GetReporteValidacionUnificado', 'P') IS NOT NULL)
	EXEC ('DROP PROCEDURE dbo.GetReporteValidacionUnificado AS SET NOCOUNT ON;')
GO