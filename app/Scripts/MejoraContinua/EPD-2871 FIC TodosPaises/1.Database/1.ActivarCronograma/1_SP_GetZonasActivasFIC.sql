GO
IF OBJECT_ID('GetZonasActivasFIC') IS NULL
	exec sp_executesql N'CREATE PROCEDURE GetZonasActivasFIC AS';
GO
ALTER PROCEDURE GetZonasActivasFIC
	@CodigoCampania varchar(25)
AS
BEGIN
	declare @CampaniaID int = (select top 1 CampaniaID from ods.Campania where codigo = @CodigoCampania);

	select
		z.ZonaID,
		z.Codigo,
		z.RegionID,
		z.GerenteZona as NombreGerenteZona,
		z.Nombre
	from ods.zona z
	where 
		ZonaID in (select distinct ZonaID from CronogramaFIC where CampaniaID = @CampaniaID) and
		EstadoActivo = 1
	order by z.Codigo;
END	
GO