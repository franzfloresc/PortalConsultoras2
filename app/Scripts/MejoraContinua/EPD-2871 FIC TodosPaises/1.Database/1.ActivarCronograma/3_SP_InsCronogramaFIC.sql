GO
IF OBJECT_ID('InsCronogramaFIC') IS NULL
	exec sp_executesql N'CREATE PROCEDURE InsCronogramaFIC AS';
GO
ALTER PROCEDURE InsCronogramaFIC
	@CodigoZona varchar(max),
	@CodigoCampania varchar(10)
AS
BEGIN
	declare @nrocampanias int = (select top 1 NroCampanias from Pais with(nolock) where EstadoActivo = 1);
	declare @anio varchar(4) = substring(@CodigoCampania, 1,4);
	declare @campania varchar(2) = substring(@CodigoCampania, 5,2);

	if	@campania = @nrocampanias
	begin
		set @campania = '01'
		set @anio = cast(cast(@anio as integer) + 1 as varchar(4))
	end
	else
	begin
		set @campania = cast(cast(@campania as integer) + 1 as varchar(4))
		if LEN(@campania) = 1
			set @campania = '0' + @campania
	end

	declare @CodigoCampania_ varchar(20) = @anio + @campania;
	declare @CampaniaID int = (select top 1 CampaniaID from ods.Campania with(nolock) where Codigo = @CodigoCampania);
	declare @CampaniaID_ int = (select top 1 CampaniaID from ods.Campania with(nolock) where Codigo = @CodigoCampania_);

	insert into CronogramaFICConsultora(ZonaID, CampaniaID, CodigoConsultora)
	select distinct	z1.zonaid, @CampaniaID, C.Codigo
	from ods.zona z1 with(nolock) 
	inner join ods.Consultora C with(nolock) on z1.ZonaID = C.ZonaID
	where
		z1.codigo in (select item from dbo.fnsplit(@CodigoZona, ',')) and
		z1.ZonaID not in (
			select distinct z.ZonaID 
			from CronogramaFIC cf with(nolock)
			inner join ods.zona z with(nolock) on cf.ZonaID = z.ZonaID
			where 
				CampaniaID =  @CampaniaID and
				z.codigo in (select item from dbo.fnsplit(@CodigoZona, ','))
		);
	

	insert into CronogramaFIC(ZonaID, CampaniaID, CampaniaID_)
	select distinct zonaid, @CampaniaID, @CampaniaID_
	from ods.zona with(nolock)
	where
		codigo in (select item from dbo.fnsplit(@CodigoZona, ',')) and
		ZonaID not in (
			select distinct z.ZonaID 
			from CronogramaFIC cf with(nolock)
			inner join ods.zona z with(nolock) on cf.ZonaID = z.ZonaID
			where
				CampaniaID =  @CampaniaID and
				z.codigo in (select item from dbo.fnsplit(@CodigoZona, ','))
		);
END
GO