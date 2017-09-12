GO
IF OBJECT_ID('DelCronogramaFIC') IS NULL
	exec sp_executesql N'CREATE PROCEDURE DelCronogramaFIC AS';
GO
ALTER PROCEDURE DelCronogramaFIC
	@CodigoZona varchar(max),
	@CodigoCampania varchar(10)
AS
BEGIN
	declare @CampaniaID int = (select top 1 CampaniaID from ods.Campania where Codigo = @CodigoCampania);

	delete from CronogramaFICConsultora 
	where
		ZonaID in (
			select zonaid
			from ods.zona
			where codigo in (select item from dbo.fnsplit(@CodigoZona, ','))
		) and
		CampaniaID = @CampaniaID

	delete from CronogramaFIC 
	where
		ZonaID in (
			select zonaid
			from ods.zona
			where codigo in (select item from dbo.fnsplit(@CodigoZona, ','))
		) and
		CampaniaID = @CampaniaID;
END
GO