GO
IF OBJECT_ID('UpdCronogramaFIC') IS NULL
	exec sp_executesql N'CREATE PROCEDURE UpdCronogramaFIC AS';
GO
ALTER PROCEDURE UpdCronogramaFIC
	@CodigoCampania varchar(20),
	@CodigoZona varchar(20),
	@FechaLimite datetime
as
begin
	declare @ZonaID int = (select top 1 ZonaID from ods.Zona where codigo = @CodigoZona);
	declare @CampaniaID int = (select top 1 CampaniaID from ods.Campania where Codigo = @CodigoCampania);

	update CronogramaFIC
	set FechaFin = @FechaLimite
	where CampaniaID = @CampaniaID and ZonaID = @ZonaID;
end
GO