USE BelcorpBolivia
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN
	declare @limMax int = -1;
		
	if exists (select 1 from ods.GestionStock with(nolock) where CodPeriodo = @Campania and CodVenta = @Cuv)
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
		end
	
		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
		end
	end

	select @limMax;
END
GO
/*end*/

USE BelcorpChile
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN
	declare @limMax int = -1;
		
	if exists (select 1 from ods.GestionStock with(nolock) where CodPeriodo = @Campania and CodVenta = @Cuv)
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
		end
	
		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
		end
	end

	select @limMax;
END
GO
/*end*/

USE BelcorpColombia
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN
	declare @limMax int = -1;
		
	if exists (select 1 from ods.GestionStock with(nolock) where CodPeriodo = @Campania and CodVenta = @Cuv)
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
		end
	
		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
		end
	end

	select @limMax;
END
GO
/*end*/

USE BelcorpCostaRica
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN
	declare @limMax int = -1;
		
	if exists (select 1 from ods.GestionStock with(nolock) where CodPeriodo = @Campania and CodVenta = @Cuv)
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
		end
	
		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
		end
	end

	select @limMax;
END
GO
/*end*/

USE BelcorpDominicana
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN
	declare @limMax int = -1;
		
	if exists (select 1 from ods.GestionStock with(nolock) where CodPeriodo = @Campania and CodVenta = @Cuv)
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
		end
	
		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
		end
	end

	select @limMax;
END
GO
/*end*/

USE BelcorpEcuador
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN
	declare @limMax int = -1;
		
	if exists (select 1 from ods.GestionStock with(nolock) where CodPeriodo = @Campania and CodVenta = @Cuv)
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
		end
	
		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
		end
	end

	select @limMax;
END
GO
/*end*/

USE BelcorpGuatemala
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN
	declare @limMax int = -1;
		
	if exists (select 1 from ods.GestionStock with(nolock) where CodPeriodo = @Campania and CodVenta = @Cuv)
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
		end
	
		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
		end
	end

	select @limMax;
END
GO
/*end*/

USE BelcorpMexico
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN
	declare @limMax int = -1;
		
	if exists (select 1 from ods.GestionStock with(nolock) where CodPeriodo = @Campania and CodVenta = @Cuv)
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
		end
	
		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
		end
	end

	select @limMax;
END
GO
/*end*/

USE BelcorpPanama
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN
	declare @limMax int = -1;
		
	if exists (select 1 from ods.GestionStock with(nolock) where CodPeriodo = @Campania and CodVenta = @Cuv)
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
		end
	
		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
		end
	end

	select @limMax;
END
GO
/*end*/

USE BelcorpPeru
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN
	declare @limMax int = -1;
		
	if exists (select 1 from ods.GestionStock with(nolock) where CodPeriodo = @Campania and CodVenta = @Cuv)
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
		end
	
		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
		end
	end

	select @limMax;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN
	declare @limMax int = -1;
		
	if exists (select 1 from ods.GestionStock with(nolock) where CodPeriodo = @Campania and CodVenta = @Cuv)
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
		end
	
		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
		end
	end

	select @limMax;
END
GO
/*end*/

USE BelcorpSalvador
GO
ALTER PROC GetGestionStockLimMaxByCampaniaAndCuv
	@Campania varchar(6),
	@Cuv varchar(6),
	@CodigoRegion varchar(2),
	@CodigoZona varchar(4)
AS
BEGIN
	declare @limMax int = -1;
		
	if exists (select 1 from ods.GestionStock with(nolock) where CodPeriodo = @Campania and CodVenta = @Cuv)
	begin
		set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInPais(@Campania,@Cuv);

		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInRegion(@Campania,@Cuv,@CodigoRegion);
		end
	
		if @limMax = -1
		begin
			set @limMax = dbo.fnGetGestionStockLimMaxByCampaniaAndCuvInZona(@Campania,@Cuv,@CodigoRegion,@CodigoZona);
		end
	end

	select @limMax;
END
GO