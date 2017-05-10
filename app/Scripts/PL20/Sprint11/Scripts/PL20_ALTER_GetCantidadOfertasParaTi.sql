use BelcorpCostaRica
go

alter procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int
as

begin

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	if @TipoEstrategia = 4
	begin
		insert into @tablaCuvsOPT
		select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'
	end
	else 
	begin
		insert into @tablaCuvsOPT
		select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='ODD'
	end

	if @TipoConfigurado=0

	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else
	begin

		if @TipoConfigurado = 1

		begin

			set @resultado = (select count(*)
			from Estrategia e
			inner join @tablaCuvsOPT t on
				e.CampaniaID = t.CampaniaID
				and e.CUV2 = t.CUV
			where e.CampaniaID = @CampaniaID)
		end

		else

		begin
			set @resultado = (select count(*)
			from @tablaCuvsOPT t
			left join Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2
			where 
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null)
		end

	end

	select @resultado	

end
go
