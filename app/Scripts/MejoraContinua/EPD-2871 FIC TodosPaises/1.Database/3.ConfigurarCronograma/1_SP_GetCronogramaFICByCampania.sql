GO
IF OBJECT_ID('GetCronogramaFICByCampania') IS NULL
	exec sp_executesql N'CREATE PROCEDURE GetCronogramaFICByCampania AS';
GO
ALTER PROCEDURE GetCronogramaFICByCampania
	@CampaniaCodigo varchar(20)
AS
BEGIN
	declare @CampaniaID int;
	
	select @CampaniaID = CampaniaID
	from ods.Campania
	where Codigo = @CampaniaCodigo;
	
	select
		cf.CampaniaID,
		cf.ZonaID,
		cf.FechaFin,
		z.Codigo as CodigoZona,
		c.Codigo as CodigoCampania
	from CronogramaFIC cf
	inner join ods.Zona z on cf.ZonaID = z.ZonaID
	inner join ods.Campania c on cf.CampaniaID = c.CampaniaID
	where cf.CampaniaID = @CampaniaID;
END
GO