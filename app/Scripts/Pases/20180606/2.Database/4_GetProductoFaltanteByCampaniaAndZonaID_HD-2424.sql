USE [BelcorpPeru]  
GO
ALTER procedure dbo.GetProductoFaltanteByCampaniaAndZonaID 
    @CampaniaID				int,
    @ZonaID					int,
	@CUV					varchar(12) = null,
	@DescripcionProducto	varchar(500) = null,
	@CodCategoria			varchar(12) = null,
	@CodCatalogo			varchar(150) = null
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID;

	set @CUV					= isnull(@CUV,'');
	set @DescripcionProducto	= isnull(@DescripcionProducto,'');
	set @CodCategoria			= isnull(@CodCategoria,'');
	set @CodCatalogo			= ltrim(rtrim(isnull(@CodCatalogo,'')));

	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.Descripcion,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	fa.CodigoVenta as CUV
		from ods.FaltanteAnunciado fa with(nolock)
		inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
		where
			ca.Codigo = @CampaniaID and
			(rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion is null) and
			(rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona is null)
			and (fa.Origen != 'PROL' or fa.Origen is null)
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 
		and (@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) 
		and (@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'))
		and (@CodCategoria = '' or SP.CodigoCategoria = @CodCategoria)
		and (@CodCatalogo ='' or isnull(Cat.Descripcion,'OTROS') = @CodCatalogo)
	order by  
	CASE WHEN  Cat.Descripcion IS NULL THEN 1 ELSE 0 END, 
	Cat.Descripcion,
	NumeroPagina asc
end
go

USE [BelcorpBolivia]
GO
ALTER procedure dbo.GetProductoFaltanteByCampaniaAndZonaID 
    @CampaniaID				int,
    @ZonaID					int,
	@CUV					varchar(12) = null,
	@DescripcionProducto	varchar(500) = null,
	@CodCategoria			varchar(12) = null,
	@CodCatalogo			varchar(150) = null
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID;

	set @CUV					= isnull(@CUV,'');
	set @DescripcionProducto	= isnull(@DescripcionProducto,'');
	set @CodCategoria			= isnull(@CodCategoria,'');
	set @CodCatalogo			= ltrim(rtrim(isnull(@CodCatalogo,'')));

	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.Descripcion,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	fa.CodigoVenta as CUV
		from ods.FaltanteAnunciado fa with(nolock)
		inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
		where
			ca.Codigo = @CampaniaID and
			(rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion is null) and
			(rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona is null)
			and (fa.Origen != 'PROL' or fa.Origen is null)
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 
		and (@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) 
		and (@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'))
		and (@CodCategoria = '' or SP.CodigoCategoria = @CodCategoria)
		and (@CodCatalogo ='' or isnull(Cat.Descripcion,'OTROS') = @CodCatalogo)
	order by  
	CASE WHEN  Cat.Descripcion IS NULL THEN 1 ELSE 0 END, 
	Cat.Descripcion,
	NumeroPagina asc
end
go

USE [BelcorpChile]
GO
ALTER procedure dbo.GetProductoFaltanteByCampaniaAndZonaID 
    @CampaniaID				int,
    @ZonaID					int,
	@CUV					varchar(12) = null,
	@DescripcionProducto	varchar(500) = null,
	@CodCategoria			varchar(12) = null,
	@CodCatalogo			varchar(150) = null
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID;

	set @CUV					= isnull(@CUV,'');
	set @DescripcionProducto	= isnull(@DescripcionProducto,'');
	set @CodCategoria			= isnull(@CodCategoria,'');
	set @CodCatalogo			= ltrim(rtrim(isnull(@CodCatalogo,'')));

	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.Descripcion,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	fa.CodigoVenta as CUV
		from ods.FaltanteAnunciado fa with(nolock)
		inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
		where
			ca.Codigo = @CampaniaID and
			(rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion is null) and
			(rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona is null)
			and (fa.Origen != 'PROL' or fa.Origen is null)
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 
		and (@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) 
		and (@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'))
		and (@CodCategoria = '' or SP.CodigoCategoria = @CodCategoria)
		and (@CodCatalogo ='' or isnull(Cat.Descripcion,'OTROS') = @CodCatalogo)
	order by  
	CASE WHEN  Cat.Descripcion IS NULL THEN 1 ELSE 0 END, 
	Cat.Descripcion,
	NumeroPagina asc
end
go

USE [BelcorpColombia]
GO
ALTER procedure dbo.GetProductoFaltanteByCampaniaAndZonaID 
    @CampaniaID				int,
    @ZonaID					int,
	@CUV					varchar(12) = null,
	@DescripcionProducto	varchar(500) = null,
	@CodCategoria			varchar(12) = null,
	@CodCatalogo			varchar(150) = null
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID;

	set @CUV					= isnull(@CUV,'');
	set @DescripcionProducto	= isnull(@DescripcionProducto,'');
	set @CodCategoria			= isnull(@CodCategoria,'');
	set @CodCatalogo			= ltrim(rtrim(isnull(@CodCatalogo,'')));

	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.Descripcion,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	fa.CodigoVenta as CUV
		from ods.FaltanteAnunciado fa with(nolock)
		inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
		where
			ca.Codigo = @CampaniaID and
			(rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion is null) and
			(rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona is null)
			and (fa.Origen != 'PROL' or fa.Origen is null)
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 
		and (@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) 
		and (@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'))
		and (@CodCategoria = '' or SP.CodigoCategoria = @CodCategoria)
		and (@CodCatalogo ='' or isnull(Cat.Descripcion,'OTROS') = @CodCatalogo)
	order by  
	CASE WHEN  Cat.Descripcion IS NULL THEN 1 ELSE 0 END, 
	Cat.Descripcion,
	NumeroPagina asc
end
go

USE [BelcorpCostaRica]
GO
ALTER procedure dbo.GetProductoFaltanteByCampaniaAndZonaID 
    @CampaniaID				int,
    @ZonaID					int,
	@CUV					varchar(12) = null,
	@DescripcionProducto	varchar(500) = null,
	@CodCategoria			varchar(12) = null,
	@CodCatalogo			varchar(150) = null
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID;

	set @CUV					= isnull(@CUV,'');
	set @DescripcionProducto	= isnull(@DescripcionProducto,'');
	set @CodCategoria			= isnull(@CodCategoria,'');
	set @CodCatalogo			= ltrim(rtrim(isnull(@CodCatalogo,'')));

	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.Descripcion,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	fa.CodigoVenta as CUV
		from ods.FaltanteAnunciado fa with(nolock)
		inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
		where
			ca.Codigo = @CampaniaID and
			(rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion is null) and
			(rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona is null)
			and (fa.Origen != 'PROL' or fa.Origen is null)
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 
		and (@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) 
		and (@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'))
		and (@CodCategoria = '' or SP.CodigoCategoria = @CodCategoria)
		and (@CodCatalogo ='' or isnull(Cat.Descripcion,'OTROS') = @CodCatalogo)
	order by  
	CASE WHEN  Cat.Descripcion IS NULL THEN 1 ELSE 0 END, 
	Cat.Descripcion,
	NumeroPagina asc
end
go

USE [BelcorpDominicana]
GO
ALTER procedure dbo.GetProductoFaltanteByCampaniaAndZonaID 
    @CampaniaID				int,
    @ZonaID					int,
	@CUV					varchar(12) = null,
	@DescripcionProducto	varchar(500) = null,
	@CodCategoria			varchar(12) = null,
	@CodCatalogo			varchar(150) = null
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID;

	set @CUV					= isnull(@CUV,'');
	set @DescripcionProducto	= isnull(@DescripcionProducto,'');
	set @CodCategoria			= isnull(@CodCategoria,'');
	set @CodCatalogo			= ltrim(rtrim(isnull(@CodCatalogo,'')));

	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.Descripcion,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	fa.CodigoVenta as CUV
		from ods.FaltanteAnunciado fa with(nolock)
		inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
		where
			ca.Codigo = @CampaniaID and
			(rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion is null) and
			(rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona is null)
			and (fa.Origen != 'PROL' or fa.Origen is null)
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 
		and (@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) 
		and (@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'))
		and (@CodCategoria = '' or SP.CodigoCategoria = @CodCategoria)
		and (@CodCatalogo ='' or isnull(Cat.Descripcion,'OTROS') = @CodCatalogo)
	order by  
	CASE WHEN  Cat.Descripcion IS NULL THEN 1 ELSE 0 END, 
	Cat.Descripcion,
	NumeroPagina asc
end
go

USE [BelcorpEcuador]
GO
ALTER procedure dbo.GetProductoFaltanteByCampaniaAndZonaID 
    @CampaniaID				int,
    @ZonaID					int,
	@CUV					varchar(12) = null,
	@DescripcionProducto	varchar(500) = null,
	@CodCategoria			varchar(12) = null,
	@CodCatalogo			varchar(150) = null
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID;

	set @CUV					= isnull(@CUV,'');
	set @DescripcionProducto	= isnull(@DescripcionProducto,'');
	set @CodCategoria			= isnull(@CodCategoria,'');
	set @CodCatalogo			= ltrim(rtrim(isnull(@CodCatalogo,'')));

	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.Descripcion,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	fa.CodigoVenta as CUV
		from ods.FaltanteAnunciado fa with(nolock)
		inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
		where
			ca.Codigo = @CampaniaID and
			(rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion is null) and
			(rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona is null)
			and (fa.Origen != 'PROL' or fa.Origen is null)
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 
		and (@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) 
		and (@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'))
		and (@CodCategoria = '' or SP.CodigoCategoria = @CodCategoria)
		and (@CodCatalogo ='' or isnull(Cat.Descripcion,'OTROS') = @CodCatalogo)
	order by  
	CASE WHEN  Cat.Descripcion IS NULL THEN 1 ELSE 0 END, 
	Cat.Descripcion,
	NumeroPagina asc
end
go

USE [BelcorpGuatemala]
GO
ALTER procedure dbo.GetProductoFaltanteByCampaniaAndZonaID 
    @CampaniaID				int,
    @ZonaID					int,
	@CUV					varchar(12) = null,
	@DescripcionProducto	varchar(500) = null,
	@CodCategoria			varchar(12) = null,
	@CodCatalogo			varchar(150) = null
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID;

	set @CUV					= isnull(@CUV,'');
	set @DescripcionProducto	= isnull(@DescripcionProducto,'');
	set @CodCategoria			= isnull(@CodCategoria,'');
	set @CodCatalogo			= ltrim(rtrim(isnull(@CodCatalogo,'')));

	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.Descripcion,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	fa.CodigoVenta as CUV
		from ods.FaltanteAnunciado fa with(nolock)
		inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
		where
			ca.Codigo = @CampaniaID and
			(rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion is null) and
			(rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona is null)
			and (fa.Origen != 'PROL' or fa.Origen is null)
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 
		and (@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) 
		and (@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'))
		and (@CodCategoria = '' or SP.CodigoCategoria = @CodCategoria)
		and (@CodCatalogo ='' or isnull(Cat.Descripcion,'OTROS') = @CodCatalogo)
	order by  
	CASE WHEN  Cat.Descripcion IS NULL THEN 1 ELSE 0 END, 
	Cat.Descripcion,
	NumeroPagina asc
end
go

USE [BelcorpMexico]
GO
ALTER procedure dbo.GetProductoFaltanteByCampaniaAndZonaID 
    @CampaniaID				int,
    @ZonaID					int,
	@CUV					varchar(12) = null,
	@DescripcionProducto	varchar(500) = null,
	@CodCategoria			varchar(12) = null,
	@CodCatalogo			varchar(150) = null
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID;

	set @CUV					= isnull(@CUV,'');
	set @DescripcionProducto	= isnull(@DescripcionProducto,'');
	set @CodCategoria			= isnull(@CodCategoria,'');
	set @CodCatalogo			= ltrim(rtrim(isnull(@CodCatalogo,'')));

	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.Descripcion,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	fa.CodigoVenta as CUV
		from ods.FaltanteAnunciado fa with(nolock)
		inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
		where
			ca.Codigo = @CampaniaID and
			(rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion is null) and
			(rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona is null)
			and (fa.Origen != 'PROL' or fa.Origen is null)
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 
		and (@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) 
		and (@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'))
		and (@CodCategoria = '' or SP.CodigoCategoria = @CodCategoria)
		and (@CodCatalogo ='' or isnull(Cat.Descripcion,'OTROS') = @CodCatalogo)
	order by  
	CASE WHEN  Cat.Descripcion IS NULL THEN 1 ELSE 0 END, 
	Cat.Descripcion,
	NumeroPagina asc
end
go

USE [BelcorpPanama]
GO
ALTER procedure dbo.GetProductoFaltanteByCampaniaAndZonaID 
    @CampaniaID				int,
    @ZonaID					int,
	@CUV					varchar(12) = null,
	@DescripcionProducto	varchar(500) = null,
	@CodCategoria			varchar(12) = null,
	@CodCatalogo			varchar(150) = null
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID;

	set @CUV					= isnull(@CUV,'');
	set @DescripcionProducto	= isnull(@DescripcionProducto,'');
	set @CodCategoria			= isnull(@CodCategoria,'');
	set @CodCatalogo			= ltrim(rtrim(isnull(@CodCatalogo,'')));

	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.Descripcion,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	fa.CodigoVenta as CUV
		from ods.FaltanteAnunciado fa with(nolock)
		inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
		where
			ca.Codigo = @CampaniaID and
			(rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion is null) and
			(rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona is null)
			and (fa.Origen != 'PROL' or fa.Origen is null)
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 
		and (@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) 
		and (@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'))
		and (@CodCategoria = '' or SP.CodigoCategoria = @CodCategoria)
		and (@CodCatalogo ='' or isnull(Cat.Descripcion,'OTROS') = @CodCatalogo)
	order by  
	CASE WHEN  Cat.Descripcion IS NULL THEN 1 ELSE 0 END, 
	Cat.Descripcion,
	NumeroPagina asc
end
go

USE [BelcorpPuertoRico]
GO
ALTER procedure dbo.GetProductoFaltanteByCampaniaAndZonaID 
    @CampaniaID				int,
    @ZonaID					int,
	@CUV					varchar(12) = null,
	@DescripcionProducto	varchar(500) = null,
	@CodCategoria			varchar(12) = null,
	@CodCatalogo			varchar(150) = null
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID;

	set @CUV					= isnull(@CUV,'');
	set @DescripcionProducto	= isnull(@DescripcionProducto,'');
	set @CodCategoria			= isnull(@CodCategoria,'');
	set @CodCatalogo			= ltrim(rtrim(isnull(@CodCatalogo,'')));

	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.Descripcion,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	fa.CodigoVenta as CUV
		from ods.FaltanteAnunciado fa with(nolock)
		inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
		where
			ca.Codigo = @CampaniaID and
			(rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion is null) and
			(rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona is null)
			and (fa.Origen != 'PROL' or fa.Origen is null)
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 
		and (@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) 
		and (@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'))
		and (@CodCategoria = '' or SP.CodigoCategoria = @CodCategoria)
		and (@CodCatalogo ='' or isnull(Cat.Descripcion,'OTROS') = @CodCatalogo)
	order by  
	CASE WHEN  Cat.Descripcion IS NULL THEN 1 ELSE 0 END, 
	Cat.Descripcion,
	NumeroPagina asc
end
go

USE [BelcorpSalvador]
GO
ALTER procedure dbo.GetProductoFaltanteByCampaniaAndZonaID 
    @CampaniaID				int,
    @ZonaID					int,
	@CUV					varchar(12) = null,
	@DescripcionProducto	varchar(500) = null,
	@CodCategoria			varchar(12) = null,
	@CodCatalogo			varchar(150) = null
as
begin
    declare @CodigoRegion varchar(4)
    declare @CodigoZona varchar(6)

    select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
    from ods.Zona z with(nolock)
    inner join ods.Region r with(nolock) on z.RegionID = r.RegionID
    where z.ZonaID = @ZonaID;

	set @CUV					= isnull(@CUV,'');
	set @DescripcionProducto	= isnull(@DescripcionProducto,'');
	set @CodCategoria			= isnull(@CodCategoria,'');
	set @CodCatalogo			= ltrim(rtrim(isnull(@CodCatalogo,'')));

	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.Descripcion,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	fa.CodigoVenta as CUV
		from ods.FaltanteAnunciado fa with(nolock)
		inner join ods.Campania ca with(nolock) on fa.CampaniaID = ca.CampaniaID
		where
			ca.Codigo = @CampaniaID and
			(rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion is null) and
			(rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona is null)
			and (fa.Origen != 'PROL' or fa.Origen is null)
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 
		and (@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) 
		and (@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'))
		and (@CodCategoria = '' or SP.CodigoCategoria = @CodCategoria)
		and (@CodCatalogo ='' or isnull(Cat.Descripcion,'OTROS') = @CodCatalogo)
	order by  
	CASE WHEN  Cat.Descripcion IS NULL THEN 1 ELSE 0 END, 
	Cat.Descripcion,
	NumeroPagina asc
end
go
