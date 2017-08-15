USE BelcorpBolivia
go

alter procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

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
GO

USE BelcorpChile
go

alter procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

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
GO

USE BelcorpColombia
go

alter procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

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
GO

USE BelcorpCostaRica
go

alter procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

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
GO

USE BelcorpDominicana
go

alter procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

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
GO

USE BelcorpEcuador
go

alter procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

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
GO

USE BelcorpGuatemala
go

alter procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

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
GO

USE BelcorpMexico
go

alter procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

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
GO

USE BelcorpPanama
go

alter procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

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
GO

USE BelcorpPeru
go

alter procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

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
GO

USE BelcorpPuertoRico
go

alter procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

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
GO

USE BelcorpSalvador
go

alter procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

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
GO

USE BelcorpVenezuela
go

alter procedure dbo.GetCantidadOfertasParaTi
@CampaniaID int,
@TipoConfigurado int
as
/*
exec GetCantidadOfertasParaTi 201618,0
exec GetCantidadOfertasParaTi 201618,1
exec GetCantidadOfertasParaTi 201618,2
*/
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))
	insert into @tablaCuvsOPT
	select distinct @CampaniaID, CUV from ods.OfertasPersonalizadas where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion='OPT'

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
GO



