USE BelcorpBolivia
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN	
	declare @limMax int = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
	end
	
	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
	end

	select @limMax;
END
GO

USE BelcorpChile
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN	
	declare @limMax int = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
	end
	
	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
	end

	select @limMax;
END
GO

USE BelcorpColombia
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN	
	declare @limMax int = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
	end
	
	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
	end

	select @limMax;
END
GO

USE BelcorpCostaRica
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN	
	declare @limMax int = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
	end
	
	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
	end

	select @limMax;
END
GO

USE BelcorpDominicana
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN	
	declare @limMax int = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
	end
	
	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
	end

	select @limMax;
END
GO

USE BelcorpEcuador
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN	
	declare @limMax int = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
	end
	
	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
	end

	select @limMax;
END
GO

USE BelcorpGuatemala
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN	
	declare @limMax int = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
	end
	
	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
	end

	select @limMax;
END
GO

USE BelcorpMexico
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN	
	declare @limMax int = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
	end
	
	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
	end

	select @limMax;
END
GO

USE BelcorpPanama
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN	
	declare @limMax int = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
	end
	
	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
	end

	select @limMax;
END
GO

USE BelcorpPeru
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN	
	declare @limMax int = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
	end
	
	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
	end

	select @limMax;
END
GO

USE BelcorpPuertoRico
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN	
	declare @limMax int = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
	end
	
	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
	end

	select @limMax;
END
GO

USE BelcorpSalvador
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN	
	declare @limMax int = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
	end
	
	if @limMax = -1
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
	end

	select @limMax;
END
GO