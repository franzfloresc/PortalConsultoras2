GO
IF OBJECT_ID('InsCronogramaFICMasivo') IS NULL
	exec sp_executesql N'CREATE PROCEDURE InsCronogramaFICMasivo AS';
GO
ALTER PROCEDURE InsCronogramaFICMasivo
	@CronogramaFIC dbo.CronogramaFICType readonly,
	@CodigoCampania varchar(25)
AS
BEGIN
	declare @CampaniaID int
	declare @CampaniaID_ int
	declare @CodigoCampania_ varchar(20)
	declare @anio varchar(4)
	declare @campania varchar(2)
	declare @nrocampanias int

	select @nrocampanias = NroCampanias from Pais with(nolock) where EstadoActivo = 1
	select @anio = substring(@CodigoCampania, 1,4)
	select @campania = substring(@CodigoCampania, 5,2)

	if	@campania = @nrocampanias
	begin
		set @campania = '01'
		set @anio = cast(cast(@anio as integer) + 1 as varchar(4))
	end
	else
	begin
		set @campania = cast(cast(@campania as integer) + 1 as varchar(4))
		if	LEN(@campania) = 1
			set @campania = '0' + @campania
	end

	set @CodigoCampania_ = @anio + @campania
	select @CampaniaID = CampaniaID from ods.Campania with(nolock) where Codigo = @CodigoCampania
	select @CampaniaID_ = CampaniaID from ods.Campania with(nolock) where Codigo = @CodigoCampania_

	delete from CronogramaFICConsultora
	where
		CampaniaID = @CampaniaID 
		and
		ZonaID in
		(
			select distinct Z2.ZonaID
			from @CronogramaFIC CF2
			inner join ods.Zona Z2 on CF2.Zona = Z2.Codigo
		)

	delete from CronogramaFIC
	where
		CampaniaID = @CampaniaID
		and
		ZonaID in
		(
			select distinct Z2.ZonaID
			from @CronogramaFIC CF2 
			inner join ods.Zona Z2 on CF2.Zona = Z2.Codigo
		)

	insert into CronogramaFIC(ZonaID, CampaniaID, CampaniaID_)
	select distinct Z.ZonaID, @CampaniaID, @CampaniaID_
	from @CronogramaFIC CF 
	inner join ods.Zona Z with(nolock) on CF.Zona = Z.Codigo

	insert into CronogramaFICConsultora	(ZonaID, CampaniaID, CodigoConsultora)
	select distinct Z.ZonaID, @CampaniaID, CodigoConsultora
	from @CronogramaFIC CF 
	inner join ods.Zona Z with(nolock) on CF.Zona = Z.Codigo
END
GO