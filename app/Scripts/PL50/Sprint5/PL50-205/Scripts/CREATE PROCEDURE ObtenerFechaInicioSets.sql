 use belcorpperu_pl50
 go
IF (OBJECT_ID('dbo.ObtenerFechaInicioSets', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.ObtenerFechaInicioSets AS SET NOCOUNT ON;')
GO
alter PROCEDURE  ObtenerFechaInicioSets
AS
BEGIN
		select valor1+'-'+valor2+'-'+valor3 from configuracionpaisdatos where Codigo='InicioFechaSetAGrupados'
END
GO
