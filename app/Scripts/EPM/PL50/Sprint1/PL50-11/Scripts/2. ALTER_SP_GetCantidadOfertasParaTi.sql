
USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 20 THEN 'BS'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		WHEN 12 THEN 'GND'
		WHEN 30 THEN 'SR'
		ELSE 'OPT'
	END

	insert into @tablaCuvsOPT
		select @CampaniaID, CUV 
		from ods.OfertasPersonalizadas 
		where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV

	if @TipoConfigurado=0

	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else if @TipoConfigurado = 1

	begin
		set @resultado = (select count(*) from (select t.CUV
		from @tablaCuvsOPT t 
		inner join Estrategia e on
			e.CampaniaID = t.CampaniaID
			and e.CUV2 = t.CUV
		where e.CampaniaID = @CampaniaID
		group by t.CUV) AS A
		)
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
	select @resultado	
END
GO


USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 20 THEN 'BS'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		WHEN 12 THEN 'GND'
		WHEN 30 THEN 'SR'
		ELSE 'OPT'
	END

	insert into @tablaCuvsOPT
		select @CampaniaID, CUV 
		from ods.OfertasPersonalizadas 
		where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV

	if @TipoConfigurado=0

	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else if @TipoConfigurado = 1

	begin
		set @resultado = (select count(*) from (select t.CUV
		from @tablaCuvsOPT t 
		inner join Estrategia e on
			e.CampaniaID = t.CampaniaID
			and e.CUV2 = t.CUV
		where e.CampaniaID = @CampaniaID
		group by t.CUV) AS A
		)
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
	select @resultado	
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 20 THEN 'BS'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		WHEN 12 THEN 'GND'
		WHEN 30 THEN 'SR'
		ELSE 'OPT'
	END

	insert into @tablaCuvsOPT
		select @CampaniaID, CUV 
		from ods.OfertasPersonalizadas 
		where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV

	if @TipoConfigurado=0

	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else if @TipoConfigurado = 1

	begin
		set @resultado = (select count(*) from (select t.CUV
		from @tablaCuvsOPT t 
		inner join Estrategia e on
			e.CampaniaID = t.CampaniaID
			and e.CUV2 = t.CUV
		where e.CampaniaID = @CampaniaID
		group by t.CUV) AS A
		)
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
	select @resultado	
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 20 THEN 'BS'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		WHEN 12 THEN 'GND'
		WHEN 30 THEN 'SR'
		ELSE 'OPT'
	END

	insert into @tablaCuvsOPT
		select @CampaniaID, CUV 
		from ods.OfertasPersonalizadas 
		where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV

	if @TipoConfigurado=0

	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else if @TipoConfigurado = 1

	begin
		set @resultado = (select count(*) from (select t.CUV
		from @tablaCuvsOPT t 
		inner join Estrategia e on
			e.CampaniaID = t.CampaniaID
			and e.CUV2 = t.CUV
		where e.CampaniaID = @CampaniaID
		group by t.CUV) AS A
		)
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
	select @resultado	
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 20 THEN 'BS'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		WHEN 12 THEN 'GND'
		WHEN 30 THEN 'SR'
		ELSE 'OPT'
	END

	insert into @tablaCuvsOPT
		select @CampaniaID, CUV 
		from ods.OfertasPersonalizadas 
		where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV

	if @TipoConfigurado=0

	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else if @TipoConfigurado = 1

	begin
		set @resultado = (select count(*) from (select t.CUV
		from @tablaCuvsOPT t 
		inner join Estrategia e on
			e.CampaniaID = t.CampaniaID
			and e.CUV2 = t.CUV
		where e.CampaniaID = @CampaniaID
		group by t.CUV) AS A
		)
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
	select @resultado	
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 20 THEN 'BS'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		WHEN 12 THEN 'GND'
		WHEN 30 THEN 'SR'
		ELSE 'OPT'
	END

	insert into @tablaCuvsOPT
		select @CampaniaID, CUV 
		from ods.OfertasPersonalizadas 
		where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV

	if @TipoConfigurado=0

	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else if @TipoConfigurado = 1

	begin
		set @resultado = (select count(*) from (select t.CUV
		from @tablaCuvsOPT t 
		inner join Estrategia e on
			e.CampaniaID = t.CampaniaID
			and e.CUV2 = t.CUV
		where e.CampaniaID = @CampaniaID
		group by t.CUV) AS A
		)
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
	select @resultado	
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 20 THEN 'BS'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		WHEN 12 THEN 'GND'
		WHEN 30 THEN 'SR'
		ELSE 'OPT'
	END

	insert into @tablaCuvsOPT
		select @CampaniaID, CUV 
		from ods.OfertasPersonalizadas 
		where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV

	if @TipoConfigurado=0

	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else if @TipoConfigurado = 1

	begin
		set @resultado = (select count(*) from (select t.CUV
		from @tablaCuvsOPT t 
		inner join Estrategia e on
			e.CampaniaID = t.CampaniaID
			and e.CUV2 = t.CUV
		where e.CampaniaID = @CampaniaID
		group by t.CUV) AS A
		)
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
	select @resultado	
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 20 THEN 'BS'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		WHEN 12 THEN 'GND'
		WHEN 30 THEN 'SR'
		ELSE 'OPT'
	END

	insert into @tablaCuvsOPT
		select @CampaniaID, CUV 
		from ods.OfertasPersonalizadas 
		where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV

	if @TipoConfigurado=0

	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else if @TipoConfigurado = 1

	begin
		set @resultado = (select count(*) from (select t.CUV
		from @tablaCuvsOPT t 
		inner join Estrategia e on
			e.CampaniaID = t.CampaniaID
			and e.CUV2 = t.CUV
		where e.CampaniaID = @CampaniaID
		group by t.CUV) AS A
		)
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
	select @resultado	
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 20 THEN 'BS'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		WHEN 12 THEN 'GND'
		WHEN 30 THEN 'SR'
		ELSE 'OPT'
	END

	insert into @tablaCuvsOPT
		select @CampaniaID, CUV 
		from ods.OfertasPersonalizadas 
		where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV

	if @TipoConfigurado=0

	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else if @TipoConfigurado = 1

	begin
		set @resultado = (select count(*) from (select t.CUV
		from @tablaCuvsOPT t 
		inner join Estrategia e on
			e.CampaniaID = t.CampaniaID
			and e.CUV2 = t.CUV
		where e.CampaniaID = @CampaniaID
		group by t.CUV) AS A
		)
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
	select @resultado	
END
GO

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 20 THEN 'BS'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		WHEN 12 THEN 'GND'
		WHEN 30 THEN 'SR'
		ELSE 'OPT'
	END

	insert into @tablaCuvsOPT
		select @CampaniaID, CUV 
		from ods.OfertasPersonalizadas 
		where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV

	if @TipoConfigurado=0

	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else if @TipoConfigurado = 1

	begin
		set @resultado = (select count(*) from (select t.CUV
		from @tablaCuvsOPT t 
		inner join Estrategia e on
			e.CampaniaID = t.CampaniaID
			and e.CUV2 = t.CUV
		where e.CampaniaID = @CampaniaID
		group by t.CUV) AS A
		)
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
	select @resultado	
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 20 THEN 'BS'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		WHEN 12 THEN 'GND'
		WHEN 30 THEN 'SR'
		ELSE 'OPT'
	END

	insert into @tablaCuvsOPT
		select @CampaniaID, CUV 
		from ods.OfertasPersonalizadas 
		where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV

	if @TipoConfigurado=0

	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else if @TipoConfigurado = 1

	begin
		set @resultado = (select count(*) from (select t.CUV
		from @tablaCuvsOPT t 
		inner join Estrategia e on
			e.CampaniaID = t.CampaniaID
			and e.CUV2 = t.CUV
		where e.CampaniaID = @CampaniaID
		group by t.CUV) AS A
		)
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
	select @resultado	
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 20 THEN 'BS'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		WHEN 12 THEN 'GND'
		WHEN 30 THEN 'SR'
		ELSE 'OPT'
	END

	insert into @tablaCuvsOPT
		select @CampaniaID, CUV 
		from ods.OfertasPersonalizadas 
		where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV

	if @TipoConfigurado=0

	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else if @TipoConfigurado = 1

	begin
		set @resultado = (select count(*) from (select t.CUV
		from @tablaCuvsOPT t 
		inner join Estrategia e on
			e.CampaniaID = t.CampaniaID
			and e.CUV2 = t.CUV
		where e.CampaniaID = @CampaniaID
		group by t.CUV) AS A
		)
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
	select @resultado	
END
GO

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 20 THEN 'BS'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		WHEN 12 THEN 'GND'
		WHEN 30 THEN 'SR'
		ELSE 'OPT'
	END

	insert into @tablaCuvsOPT
		select @CampaniaID, CUV 
		from ods.OfertasPersonalizadas 
		where AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV

	if @TipoConfigurado=0

	begin
		set @resultado = (select count(*) from @tablaCuvsOPT)
	end
	else if @TipoConfigurado = 1

	begin
		set @resultado = (select count(*) from (select t.CUV
		from @tablaCuvsOPT t 
		inner join Estrategia e on
			e.CampaniaID = t.CampaniaID
			and e.CUV2 = t.CUV
		where e.CampaniaID = @CampaniaID
		group by t.CUV) AS A
		)
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
	select @resultado	
END
