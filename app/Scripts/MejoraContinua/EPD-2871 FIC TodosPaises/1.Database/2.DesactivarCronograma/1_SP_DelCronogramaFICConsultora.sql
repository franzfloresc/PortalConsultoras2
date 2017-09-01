GO
IF OBJECT_ID('DelCronogramaFICConsultora') IS NULL
	exec sp_executesql N'CREATE PROCEDURE DelCronogramaFICConsultora AS';
GO
ALTER PROCEDURE DelCronogramaFICConsultora
	@CampaniaCodigo varchar(20),
	@ZonaCodigo varchar(20),
	@CodigoConsultora varchar(20)
AS
BEGIN
	declare @CampaniaID int;
	declare @ZonaID int;
	declare @Cantidad int;
	
	select @CampaniaID = CampaniaID from ods.Campania where Codigo = @CampaniaCodigo;
	select @ZonaID = ZonaID from ods.Zona where Codigo = @ZonaCodigo;

	delete from CronogramaFICConsultora
	where 
		CampaniaID = @CampaniaID 
		and 
		ZonaID = @ZonaID 
		and 
		CodigoConsultora = @CodigoConsultora;
	
	set @Cantidad = (
		select count(*) 
		from CronogramaFICConsultora 
		where 
			CampaniaID = @CampaniaID 
			and 
			ZonaID = @ZonaID
		);
		
	if @Cantidad = 0
	begin
		delete from CronogramaFIC
		where 
			CampaniaID = @CampaniaID
			and
			ZonaID = @ZonaID;
	end
END
GO