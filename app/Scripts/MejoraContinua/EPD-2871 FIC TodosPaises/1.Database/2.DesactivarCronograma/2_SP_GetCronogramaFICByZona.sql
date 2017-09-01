GO
IF OBJECT_ID('GetCronogramaFICByZona') IS NULL
	exec sp_executesql N'CREATE PROCEDURE GetCronogramaFICByZona AS';
GO
ALTER PROCEDURE GetCronogramaFICByZona
	@CampaniaCodigo varchar(20),
	@ZonaCodigo varchar(20)
AS
BEGIN
	declare @CampaniaID int;
	declare @ZonaID int;
	
	select @CampaniaID = CampaniaID
	from ods.Campania
	where Codigo = @CampaniaCodigo
	
	if @ZonaCodigo = 'x'
	begin	
		select cf.CampaniaID, cf.ZonaID, cf.FechaFin, z.Codigo CodigoZona, c.Codigo CodigoCampania, cfc.CodigoConsultora
		from CronogramaFIC cf
		inner join ods.Zona z on cf.ZonaID = z.ZonaID
		inner join ods.Campania c on cf.CampaniaID = c.CampaniaID
		left join CronogramaFICConsultora cfc on cf.ZonaID = cfc.ZonaID and cf.CampaniaID = cfc.CampaniaID
		where cf.CampaniaID = @CampaniaID;
	end
	else
	begin
		set @ZonaID = (cast(ltrim(rtrim(@ZonaCodigo)) as integer));
		
		select cf.CampaniaID, cf.ZonaID, cf.FechaFin, z.Codigo CodigoZona, c.Codigo CodigoCampania, cfc.CodigoConsultora
		from CronogramaFIC cf
		inner join ods.Zona z on cf.ZonaID = z.ZonaID
		inner join ods.Campania c on cf.CampaniaID = c.CampaniaID
		left join CronogramaFICConsultora cfc on cf.ZonaID = cfc.ZonaID and cf.CampaniaID = cfc.CampaniaID
		where 
			cf.CampaniaID = @CampaniaID
			and
			cf.ZonaID = @ZonaID;
	end
END
go