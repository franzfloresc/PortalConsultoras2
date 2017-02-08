USE BelcorpBolivia
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int,
	@FaltantesAnunciados dbo.ProductoFaltanteType readonly,
	@CUV varchar(12) = null,
	@DescripcionProducto varchar(500) = null
as
--GetOnlyProductoFaltante 201616,2541
begin
	set @CUV = isnull(@CUV,'');
	set @DescripcionProducto = isnull(@DescripcionProducto,'');
	
	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.DescripcionCatalogo,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	CUV
		from @FaltantesAnunciados
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 and
		(@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) and
		(@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'));
end
go
/*end*/

USE BelcorpChile
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int,
	@FaltantesAnunciados dbo.ProductoFaltanteType readonly,
	@CUV varchar(12) = null,
	@DescripcionProducto varchar(500) = null
as
--GetOnlyProductoFaltante 201616,2541
begin
	set @CUV = isnull(@CUV,'');
	set @DescripcionProducto = isnull(@DescripcionProducto,'');
	
	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.DescripcionCatalogo,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	CUV
		from @FaltantesAnunciados
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 and
		(@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) and
		(@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'));
end
go
/*end*/

USE BelcorpCostaRica
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int,
	@FaltantesAnunciados dbo.ProductoFaltanteType readonly,
	@CUV varchar(12) = null,
	@DescripcionProducto varchar(500) = null
as
--GetOnlyProductoFaltante 201616,2541
begin
	set @CUV = isnull(@CUV,'');
	set @DescripcionProducto = isnull(@DescripcionProducto,'');
	
	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.DescripcionCatalogo,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	CUV
		from @FaltantesAnunciados
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 and
		(@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) and
		(@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'));
end
go
/*end*/

USE BelcorpDominicana
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int,
	@FaltantesAnunciados dbo.ProductoFaltanteType readonly,
	@CUV varchar(12) = null,
	@DescripcionProducto varchar(500) = null
as
--GetOnlyProductoFaltante 201616,2541
begin
	set @CUV = isnull(@CUV,'');
	set @DescripcionProducto = isnull(@DescripcionProducto,'');
	
	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.DescripcionCatalogo,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	CUV
		from @FaltantesAnunciados
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 and
		(@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) and
		(@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'));
end
go
/*end*/

USE BelcorpEcuador
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int,
	@FaltantesAnunciados dbo.ProductoFaltanteType readonly,
	@CUV varchar(12) = null,
	@DescripcionProducto varchar(500) = null
as
--GetOnlyProductoFaltante 201616,2541
begin
	set @CUV = isnull(@CUV,'');
	set @DescripcionProducto = isnull(@DescripcionProducto,'');
	
	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.DescripcionCatalogo,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	CUV
		from @FaltantesAnunciados
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 and
		(@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) and
		(@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'));
end
go
/*end*/

USE BelcorpGuatemala
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int,
	@FaltantesAnunciados dbo.ProductoFaltanteType readonly,
	@CUV varchar(12) = null,
	@DescripcionProducto varchar(500) = null
as
--GetOnlyProductoFaltante 201616,2541
begin
	set @CUV = isnull(@CUV,'');
	set @DescripcionProducto = isnull(@DescripcionProducto,'');
	
	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.DescripcionCatalogo,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	CUV
		from @FaltantesAnunciados
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 and
		(@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) and
		(@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'));
end
go
/*end*/

USE BelcorpPanama
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int,
	@FaltantesAnunciados dbo.ProductoFaltanteType readonly,
	@CUV varchar(12) = null,
	@DescripcionProducto varchar(500) = null
as
--GetOnlyProductoFaltante 201616,2541
begin
	set @CUV = isnull(@CUV,'');
	set @DescripcionProducto = isnull(@DescripcionProducto,'');
	
	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.DescripcionCatalogo,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	CUV
		from @FaltantesAnunciados
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 and
		(@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) and
		(@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'));
end
go
/*end*/

USE BelcorpPuertoRico
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int,
	@FaltantesAnunciados dbo.ProductoFaltanteType readonly,
	@CUV varchar(12) = null,
	@DescripcionProducto varchar(500) = null
as
--GetOnlyProductoFaltante 201616,2541
begin
	set @CUV = isnull(@CUV,'');
	set @DescripcionProducto = isnull(@DescripcionProducto,'');
	
	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.DescripcionCatalogo,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	CUV
		from @FaltantesAnunciados
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 and
		(@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) and
		(@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'));
end
go
/*end*/

USE BelcorpSalvador
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int,
	@FaltantesAnunciados dbo.ProductoFaltanteType readonly,
	@CUV varchar(12) = null,
	@DescripcionProducto varchar(500) = null
as
--GetOnlyProductoFaltante 201616,2541
begin
	set @CUV = isnull(@CUV,'');
	set @DescripcionProducto = isnull(@DescripcionProducto,'');
	
	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.DescripcionCatalogo,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	CUV
		from @FaltantesAnunciados
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 and
		(@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) and
		(@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'));
end
go
/*end*/

USE BelcorpVenezuela
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int,
	@FaltantesAnunciados dbo.ProductoFaltanteType readonly,
	@CUV varchar(12) = null,
	@DescripcionProducto varchar(500) = null
as
--GetOnlyProductoFaltante 201616,2541
begin
	set @CUV = isnull(@CUV,'');
	set @DescripcionProducto = isnull(@DescripcionProducto,'');
	
	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.DescripcionCatalogo,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	CUV
		from @FaltantesAnunciados
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 and
		(@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) and
		(@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'));
end
go
/*end*/

USE BelcorpColombia
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int,
	@FaltantesAnunciados dbo.ProductoFaltanteType readonly,
	@CUV varchar(12) = null,
	@DescripcionProducto varchar(500) = null
as
--GetOnlyProductoFaltante 201616,2541
begin
	set @CUV = isnull(@CUV,'');
	set @DescripcionProducto = isnull(@DescripcionProducto,'');
	
	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.DescripcionCatalogo,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	CUV
		from @FaltantesAnunciados
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 and
		(@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) and
		(@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'));
end
go
/*end*/

USE BelcorpMexico
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int,
	@FaltantesAnunciados dbo.ProductoFaltanteType readonly,
	@CUV varchar(12) = null,
	@DescripcionProducto varchar(500) = null
as
--GetOnlyProductoFaltante 201616,2541
begin
	set @CUV = isnull(@CUV,'');
	set @DescripcionProducto = isnull(@DescripcionProducto,'');
	
	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.DescripcionCatalogo,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	CUV
		from @FaltantesAnunciados
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 and
		(@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) and
		(@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'));
end
go
/*end*/

USE BelcorpPeru
go
alter procedure GetOnlyProductoFaltante
	@CampaniaID int,
	@ZonaID int,
	@FaltantesAnunciados dbo.ProductoFaltanteType readonly,
	@CUV varchar(12) = null,
	@DescripcionProducto varchar(500) = null
as
--GetOnlyProductoFaltante 201616,2541
begin
	set @CUV = isnull(@CUV,'');
	set @DescripcionProducto = isnull(@DescripcionProducto,'');
	
	select
		SC.DescripcionCategoria as Categoria,
		PF.CUV,
		PC.Descripcion,
		isnull(Cat.DescripcionCatalogo,'') as Catalogo,
		PC.NumeroPagina
	from (
		select distinct	CUV
		from dbo.ProductoFaltante pf with(nolock)
		where
			CampaniaID = @CampaniaID and
			ZonaID = @ZonaID and
			isnull(FaltanteUltimoMinuto,0) = 0

		union 

		select distinct	CUV
		from @FaltantesAnunciados
	) AS PF
    inner join ods.ProductoComercial PC with(nolock) on @CampaniaID = PC.AnoCampania and PF.CUV = PC.CUV
	inner join ods.SAP_PRODUCTO SP with(nolock) on PC.CodigoProducto = SP.CodigoSap
	inner join ods.SAP_CATEGORIA SC with(nolock) on SP.CodigoCategoria = SC.CodigoCategoria
	left join ods.Catalogo Cat with(nolock) on PC.CodigoCatalago = Cat.CodigoCatalogo
	where
		PC.IndicadorDigitable = 1 and
		(@CUV = '' or PF.CUV like CONCAT(@CUV,'%')) and
		(@DescripcionProducto = '' or PC.Descripcion like CONCAT('%',@DescripcionProducto,'%'));
end
go