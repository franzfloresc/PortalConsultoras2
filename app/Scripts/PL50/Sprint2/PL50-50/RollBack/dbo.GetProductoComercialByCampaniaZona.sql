USE BelcorpPeru
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona
	@CampaniaID int,
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@RowCount int,
	@Criterio int,
	@TextoBusqueda varchar(100)
AS
BEGIN
	--INI: Lista de Ofertas
	declare @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250),
		ConfiguracionOfertaID int,
		TipoOfertaSisID int,
		ImagenProducto varchar(250)
	);

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from OfertaProducto op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	union all

	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from ShowRoom.OfertaShowRoom op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID    
	where c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas
	
	--INI: Lista de Productos Faltantes
	declare @ProductoFaltanteTemp table (CUV varchar(6))

	insert into @ProductoFaltanteTemp
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante with(nolock)
	where CampaniaID = @CampaniaID and Zonaid = @ZonaID

	union all

	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa with(nolock)
	inner join ods.Campania c with(nolock) on fa.CampaniaID = c.CampaniaID
	where 
		c.Codigo = @CampaniaID 
		and (fa.CodigoRegion IS NULL or rtrim(fa.CodigoRegion) = @CodigoRegion)
		and (fa.CodigoZona IS NULL or rtrim(fa.CodigoZona) = @CodigoZona)
	--FIN: Lista de Productos Faltantes
	
	select distinct top (@RowCount)
		p.CUV,
		p.CodigoProducto as CodigoSAP,
		coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion, p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		iif(isnull(pf.CUV,0) = 0, 1, 0) as TieneStock,
		isnull(pcc.EsExpoOferta,0) as EsExpoOferta,
		isnull(pcc.CUVRevista,'') as CUVRevista,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		isnull(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		isnull(op.TipoOfertaSisID,0) TipoOfertaSisID,
		isnull(te.flagNueva, 0) FlagNueva,
		isnull(te.TipoEstrategiaID, '') TipoEstrategiaID,
		iif(PS.ProductoSugeridoID is null, 0, 1) as TieneSugerido,
		isnull(Cat.Descripcion,'') as CatalogoDescripcion,
		coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) as ImagenOferta,
		coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05,
			mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) as ImagenProducto,
		coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta,
		coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	from ods.ProductoComercial p
	left join Marca M ON p.MarcaId = M.MarcaId
	left join dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia EST ON
		(p.AnoCampania between EST.CampaniaID and isnull(EST.CampaniaIDFin, EST.CampaniaID))
		and
		EST.CUV2 = p.CUV and EST.Activo = 1
	left join TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	left join ProductoSugerido PS on PS.CampaniaID = p.AnoCampania and PS.CUV = P.CUV and PS.Estado = 1
	left join ProductoSugerido PS2 on PS2.CampaniaID = p.AnoCampania and PS2.CUVSugerido = P.CUV and PS.Estado = 1
	left join ods.Catalogo Cat with(nolock) on p.CodigoCatalago = Cat.CodigoCatalogo
	where
		p.AnoCampania = @CampaniaID and p.IndicadorDigitable = 1
		and
		CHARINDEX(@TextoBusqueda,iif(
			@Criterio = 1,
			p.CUV,
			coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion)
		))>0;
END

GO

USE BelcorpMexico
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona
	@CampaniaID int,
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@RowCount int,
	@Criterio int,
	@TextoBusqueda varchar(100)
AS
BEGIN
	--INI: Lista de Ofertas
	declare @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250),
		ConfiguracionOfertaID int,
		TipoOfertaSisID int,
		ImagenProducto varchar(250)
	);

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from OfertaProducto op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	union all

	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from ShowRoom.OfertaShowRoom op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID    
	where c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas
	
	--INI: Lista de Productos Faltantes
	declare @ProductoFaltanteTemp table (CUV varchar(6))

	insert into @ProductoFaltanteTemp
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante with(nolock)
	where CampaniaID = @CampaniaID and Zonaid = @ZonaID

	union all

	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa with(nolock)
	inner join ods.Campania c with(nolock) on fa.CampaniaID = c.CampaniaID
	where 
		c.Codigo = @CampaniaID 
		and (fa.CodigoRegion IS NULL or rtrim(fa.CodigoRegion) = @CodigoRegion)
		and (fa.CodigoZona IS NULL or rtrim(fa.CodigoZona) = @CodigoZona)
	--FIN: Lista de Productos Faltantes
	
	select distinct top (@RowCount)
		p.CUV,
		p.CodigoProducto as CodigoSAP,
		coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion, p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		iif(isnull(pf.CUV,0) = 0, 1, 0) as TieneStock,
		isnull(pcc.EsExpoOferta,0) as EsExpoOferta,
		isnull(pcc.CUVRevista,'') as CUVRevista,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		isnull(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		isnull(op.TipoOfertaSisID,0) TipoOfertaSisID,
		isnull(te.flagNueva, 0) FlagNueva,
		isnull(te.TipoEstrategiaID, '') TipoEstrategiaID,
		iif(PS.ProductoSugeridoID is null, 0, 1) as TieneSugerido,
		isnull(Cat.Descripcion,'') as CatalogoDescripcion,
		coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) as ImagenOferta,
		coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05,
			mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) as ImagenProducto,
		coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta,
		coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	from ods.ProductoComercial p
	left join Marca M ON p.MarcaId = M.MarcaId
	left join dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia EST ON
		(p.AnoCampania between EST.CampaniaID and isnull(EST.CampaniaIDFin, EST.CampaniaID))
		and
		EST.CUV2 = p.CUV and EST.Activo = 1
	left join TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	left join ProductoSugerido PS on PS.CampaniaID = p.AnoCampania and PS.CUV = P.CUV and PS.Estado = 1
	left join ProductoSugerido PS2 on PS2.CampaniaID = p.AnoCampania and PS2.CUVSugerido = P.CUV and PS.Estado = 1
	left join ods.Catalogo Cat with(nolock) on p.CodigoCatalago = Cat.CodigoCatalogo
	where
		p.AnoCampania = @CampaniaID and p.IndicadorDigitable = 1
		and
		CHARINDEX(@TextoBusqueda,iif(
			@Criterio = 1,
			p.CUV,
			coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion)
		))>0;
END

GO

USE BelcorpColombia
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona
	@CampaniaID int,
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@RowCount int,
	@Criterio int,
	@TextoBusqueda varchar(100)
AS
BEGIN
	--INI: Lista de Ofertas
	declare @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250),
		ConfiguracionOfertaID int,
		TipoOfertaSisID int,
		ImagenProducto varchar(250)
	);

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from OfertaProducto op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	union all

	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from ShowRoom.OfertaShowRoom op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID    
	where c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas
	
	--INI: Lista de Productos Faltantes
	declare @ProductoFaltanteTemp table (CUV varchar(6))

	insert into @ProductoFaltanteTemp
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante with(nolock)
	where CampaniaID = @CampaniaID and Zonaid = @ZonaID

	union all

	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa with(nolock)
	inner join ods.Campania c with(nolock) on fa.CampaniaID = c.CampaniaID
	where 
		c.Codigo = @CampaniaID 
		and (fa.CodigoRegion IS NULL or rtrim(fa.CodigoRegion) = @CodigoRegion)
		and (fa.CodigoZona IS NULL or rtrim(fa.CodigoZona) = @CodigoZona)
	--FIN: Lista de Productos Faltantes
	
	select distinct top (@RowCount)
		p.CUV,
		p.CodigoProducto as CodigoSAP,
		coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion, p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		iif(isnull(pf.CUV,0) = 0, 1, 0) as TieneStock,
		isnull(pcc.EsExpoOferta,0) as EsExpoOferta,
		isnull(pcc.CUVRevista,'') as CUVRevista,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		isnull(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		isnull(op.TipoOfertaSisID,0) TipoOfertaSisID,
		isnull(te.flagNueva, 0) FlagNueva,
		isnull(te.TipoEstrategiaID, '') TipoEstrategiaID,
		iif(PS.ProductoSugeridoID is null, 0, 1) as TieneSugerido,
		isnull(Cat.Descripcion,'') as CatalogoDescripcion,
		coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) as ImagenOferta,
		coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05,
			mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) as ImagenProducto,
		coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta,
		coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	from ods.ProductoComercial p
	left join Marca M ON p.MarcaId = M.MarcaId
	left join dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia EST ON
		(p.AnoCampania between EST.CampaniaID and isnull(EST.CampaniaIDFin, EST.CampaniaID))
		and
		EST.CUV2 = p.CUV and EST.Activo = 1
	left join TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	left join ProductoSugerido PS on PS.CampaniaID = p.AnoCampania and PS.CUV = P.CUV and PS.Estado = 1
	left join ProductoSugerido PS2 on PS2.CampaniaID = p.AnoCampania and PS2.CUVSugerido = P.CUV and PS.Estado = 1
	left join ods.Catalogo Cat with(nolock) on p.CodigoCatalago = Cat.CodigoCatalogo
	where
		p.AnoCampania = @CampaniaID and p.IndicadorDigitable = 1
		and
		CHARINDEX(@TextoBusqueda,iif(
			@Criterio = 1,
			p.CUV,
			coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion)
		))>0;
END

GO

USE BelcorpVenezuela
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona
	@CampaniaID int,
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@RowCount int,
	@Criterio int,
	@TextoBusqueda varchar(100)
AS
BEGIN
	--INI: Lista de Ofertas
	declare @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250),
		ConfiguracionOfertaID int,
		TipoOfertaSisID int,
		ImagenProducto varchar(250)
	);

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from OfertaProducto op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	union all

	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from ShowRoom.OfertaShowRoom op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID    
	where c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas
	
	--INI: Lista de Productos Faltantes
	declare @ProductoFaltanteTemp table (CUV varchar(6))

	insert into @ProductoFaltanteTemp
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante with(nolock)
	where CampaniaID = @CampaniaID and Zonaid = @ZonaID

	union all

	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa with(nolock)
	inner join ods.Campania c with(nolock) on fa.CampaniaID = c.CampaniaID
	where 
		c.Codigo = @CampaniaID 
		and (fa.CodigoRegion IS NULL or rtrim(fa.CodigoRegion) = @CodigoRegion)
		and (fa.CodigoZona IS NULL or rtrim(fa.CodigoZona) = @CodigoZona)
	--FIN: Lista de Productos Faltantes
	
	select distinct top (@RowCount)
		p.CUV,
		p.CodigoProducto as CodigoSAP,
		coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion, p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		iif(isnull(pf.CUV,0) = 0, 1, 0) as TieneStock,
		isnull(pcc.EsExpoOferta,0) as EsExpoOferta,
		isnull(pcc.CUVRevista,'') as CUVRevista,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		isnull(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		isnull(op.TipoOfertaSisID,0) TipoOfertaSisID,
		isnull(te.flagNueva, 0) FlagNueva,
		isnull(te.TipoEstrategiaID, '') TipoEstrategiaID,
		iif(PS.ProductoSugeridoID is null, 0, 1) as TieneSugerido,
		isnull(Cat.Descripcion,'') as CatalogoDescripcion,
		coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) as ImagenOferta,
		coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05,
			mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) as ImagenProducto,
		coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta,
		coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	from ods.ProductoComercial p
	left join Marca M ON p.MarcaId = M.MarcaId
	left join dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia EST ON
		(p.AnoCampania between EST.CampaniaID and isnull(EST.CampaniaIDFin, EST.CampaniaID))
		and
		EST.CUV2 = p.CUV and EST.Activo = 1
	left join TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	left join ProductoSugerido PS on PS.CampaniaID = p.AnoCampania and PS.CUV = P.CUV and PS.Estado = 1
	left join ProductoSugerido PS2 on PS2.CampaniaID = p.AnoCampania and PS2.CUVSugerido = P.CUV and PS.Estado = 1
	left join ods.Catalogo Cat with(nolock) on p.CodigoCatalago = Cat.CodigoCatalogo
	where
		p.AnoCampania = @CampaniaID and p.IndicadorDigitable = 1
		and
		CHARINDEX(@TextoBusqueda,iif(
			@Criterio = 1,
			p.CUV,
			coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion)
		))>0;
END

GO

USE BelcorpSalvador
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona
	@CampaniaID int,
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@RowCount int,
	@Criterio int,
	@TextoBusqueda varchar(100)
AS
BEGIN
	--INI: Lista de Ofertas
	declare @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250),
		ConfiguracionOfertaID int,
		TipoOfertaSisID int,
		ImagenProducto varchar(250)
	);

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from OfertaProducto op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	union all

	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from ShowRoom.OfertaShowRoom op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID    
	where c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas
	
	--INI: Lista de Productos Faltantes
	declare @ProductoFaltanteTemp table (CUV varchar(6))

	insert into @ProductoFaltanteTemp
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante with(nolock)
	where CampaniaID = @CampaniaID and Zonaid = @ZonaID

	union all

	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa with(nolock)
	inner join ods.Campania c with(nolock) on fa.CampaniaID = c.CampaniaID
	where 
		c.Codigo = @CampaniaID 
		and (fa.CodigoRegion IS NULL or rtrim(fa.CodigoRegion) = @CodigoRegion)
		and (fa.CodigoZona IS NULL or rtrim(fa.CodigoZona) = @CodigoZona)
	--FIN: Lista de Productos Faltantes
	
	select distinct top (@RowCount)
		p.CUV,
		p.CodigoProducto as CodigoSAP,
		coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion, p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		iif(isnull(pf.CUV,0) = 0, 1, 0) as TieneStock,
		isnull(pcc.EsExpoOferta,0) as EsExpoOferta,
		isnull(pcc.CUVRevista,'') as CUVRevista,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		isnull(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		isnull(op.TipoOfertaSisID,0) TipoOfertaSisID,
		isnull(te.flagNueva, 0) FlagNueva,
		isnull(te.TipoEstrategiaID, '') TipoEstrategiaID,
		iif(PS.ProductoSugeridoID is null, 0, 1) as TieneSugerido,
		isnull(Cat.Descripcion,'') as CatalogoDescripcion,
		coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) as ImagenOferta,
		coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05,
			mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) as ImagenProducto,
		coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta,
		coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	from ods.ProductoComercial p
	left join Marca M ON p.MarcaId = M.MarcaId
	left join dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia EST ON
		(p.AnoCampania between EST.CampaniaID and isnull(EST.CampaniaIDFin, EST.CampaniaID))
		and
		EST.CUV2 = p.CUV and EST.Activo = 1
	left join TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	left join ProductoSugerido PS on PS.CampaniaID = p.AnoCampania and PS.CUV = P.CUV and PS.Estado = 1
	left join ProductoSugerido PS2 on PS2.CampaniaID = p.AnoCampania and PS2.CUVSugerido = P.CUV and PS.Estado = 1
	left join ods.Catalogo Cat with(nolock) on p.CodigoCatalago = Cat.CodigoCatalogo
	where
		p.AnoCampania = @CampaniaID and p.IndicadorDigitable = 1
		and
		CHARINDEX(@TextoBusqueda,iif(
			@Criterio = 1,
			p.CUV,
			coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion)
		))>0;
END

GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona
	@CampaniaID int,
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@RowCount int,
	@Criterio int,
	@TextoBusqueda varchar(100)
AS
BEGIN
	--INI: Lista de Ofertas
	declare @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250),
		ConfiguracionOfertaID int,
		TipoOfertaSisID int,
		ImagenProducto varchar(250)
	);

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from OfertaProducto op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	union all

	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from ShowRoom.OfertaShowRoom op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID    
	where c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas
	
	--INI: Lista de Productos Faltantes
	declare @ProductoFaltanteTemp table (CUV varchar(6))

	insert into @ProductoFaltanteTemp
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante with(nolock)
	where CampaniaID = @CampaniaID and Zonaid = @ZonaID

	union all

	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa with(nolock)
	inner join ods.Campania c with(nolock) on fa.CampaniaID = c.CampaniaID
	where 
		c.Codigo = @CampaniaID 
		and (fa.CodigoRegion IS NULL or rtrim(fa.CodigoRegion) = @CodigoRegion)
		and (fa.CodigoZona IS NULL or rtrim(fa.CodigoZona) = @CodigoZona)
	--FIN: Lista de Productos Faltantes
	
	select distinct top (@RowCount)
		p.CUV,
		p.CodigoProducto as CodigoSAP,
		coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion, p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		iif(isnull(pf.CUV,0) = 0, 1, 0) as TieneStock,
		isnull(pcc.EsExpoOferta,0) as EsExpoOferta,
		isnull(pcc.CUVRevista,'') as CUVRevista,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		isnull(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		isnull(op.TipoOfertaSisID,0) TipoOfertaSisID,
		isnull(te.flagNueva, 0) FlagNueva,
		isnull(te.TipoEstrategiaID, '') TipoEstrategiaID,
		iif(PS.ProductoSugeridoID is null, 0, 1) as TieneSugerido,
		isnull(Cat.Descripcion,'') as CatalogoDescripcion,
		coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) as ImagenOferta,
		coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05,
			mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) as ImagenProducto,
		coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta,
		coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	from ods.ProductoComercial p
	left join Marca M ON p.MarcaId = M.MarcaId
	left join dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia EST ON
		(p.AnoCampania between EST.CampaniaID and isnull(EST.CampaniaIDFin, EST.CampaniaID))
		and
		EST.CUV2 = p.CUV and EST.Activo = 1
	left join TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	left join ProductoSugerido PS on PS.CampaniaID = p.AnoCampania and PS.CUV = P.CUV and PS.Estado = 1
	left join ProductoSugerido PS2 on PS2.CampaniaID = p.AnoCampania and PS2.CUVSugerido = P.CUV and PS.Estado = 1
	left join ods.Catalogo Cat with(nolock) on p.CodigoCatalago = Cat.CodigoCatalogo
	where
		p.AnoCampania = @CampaniaID and p.IndicadorDigitable = 1
		and
		CHARINDEX(@TextoBusqueda,iif(
			@Criterio = 1,
			p.CUV,
			coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion)
		))>0;
END

GO

USE BelcorpPanama
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona
	@CampaniaID int,
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@RowCount int,
	@Criterio int,
	@TextoBusqueda varchar(100)
AS
BEGIN
	--INI: Lista de Ofertas
	declare @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250),
		ConfiguracionOfertaID int,
		TipoOfertaSisID int,
		ImagenProducto varchar(250)
	);

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from OfertaProducto op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	union all

	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from ShowRoom.OfertaShowRoom op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID    
	where c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas
	
	--INI: Lista de Productos Faltantes
	declare @ProductoFaltanteTemp table (CUV varchar(6))

	insert into @ProductoFaltanteTemp
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante with(nolock)
	where CampaniaID = @CampaniaID and Zonaid = @ZonaID

	union all

	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa with(nolock)
	inner join ods.Campania c with(nolock) on fa.CampaniaID = c.CampaniaID
	where 
		c.Codigo = @CampaniaID 
		and (fa.CodigoRegion IS NULL or rtrim(fa.CodigoRegion) = @CodigoRegion)
		and (fa.CodigoZona IS NULL or rtrim(fa.CodigoZona) = @CodigoZona)
	--FIN: Lista de Productos Faltantes
	
	select distinct top (@RowCount)
		p.CUV,
		p.CodigoProducto as CodigoSAP,
		coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion, p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		iif(isnull(pf.CUV,0) = 0, 1, 0) as TieneStock,
		isnull(pcc.EsExpoOferta,0) as EsExpoOferta,
		isnull(pcc.CUVRevista,'') as CUVRevista,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		isnull(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		isnull(op.TipoOfertaSisID,0) TipoOfertaSisID,
		isnull(te.flagNueva, 0) FlagNueva,
		isnull(te.TipoEstrategiaID, '') TipoEstrategiaID,
		iif(PS.ProductoSugeridoID is null, 0, 1) as TieneSugerido,
		isnull(Cat.Descripcion,'') as CatalogoDescripcion,
		coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) as ImagenOferta,
		coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05,
			mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) as ImagenProducto,
		coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta,
		coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	from ods.ProductoComercial p
	left join Marca M ON p.MarcaId = M.MarcaId
	left join dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia EST ON
		(p.AnoCampania between EST.CampaniaID and isnull(EST.CampaniaIDFin, EST.CampaniaID))
		and
		EST.CUV2 = p.CUV and EST.Activo = 1
	left join TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	left join ProductoSugerido PS on PS.CampaniaID = p.AnoCampania and PS.CUV = P.CUV and PS.Estado = 1
	left join ProductoSugerido PS2 on PS2.CampaniaID = p.AnoCampania and PS2.CUVSugerido = P.CUV and PS.Estado = 1
	left join ods.Catalogo Cat with(nolock) on p.CodigoCatalago = Cat.CodigoCatalogo
	where
		p.AnoCampania = @CampaniaID and p.IndicadorDigitable = 1
		and
		CHARINDEX(@TextoBusqueda,iif(
			@Criterio = 1,
			p.CUV,
			coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion)
		))>0;
END

GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona
	@CampaniaID int,
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@RowCount int,
	@Criterio int,
	@TextoBusqueda varchar(100)
AS
BEGIN
	--INI: Lista de Ofertas
	declare @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250),
		ConfiguracionOfertaID int,
		TipoOfertaSisID int,
		ImagenProducto varchar(250)
	);

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from OfertaProducto op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	union all

	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from ShowRoom.OfertaShowRoom op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID    
	where c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas
	
	--INI: Lista de Productos Faltantes
	declare @ProductoFaltanteTemp table (CUV varchar(6))

	insert into @ProductoFaltanteTemp
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante with(nolock)
	where CampaniaID = @CampaniaID and Zonaid = @ZonaID

	union all

	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa with(nolock)
	inner join ods.Campania c with(nolock) on fa.CampaniaID = c.CampaniaID
	where 
		c.Codigo = @CampaniaID 
		and (fa.CodigoRegion IS NULL or rtrim(fa.CodigoRegion) = @CodigoRegion)
		and (fa.CodigoZona IS NULL or rtrim(fa.CodigoZona) = @CodigoZona)
	--FIN: Lista de Productos Faltantes
	
	select distinct top (@RowCount)
		p.CUV,
		p.CodigoProducto as CodigoSAP,
		coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion, p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		iif(isnull(pf.CUV,0) = 0, 1, 0) as TieneStock,
		isnull(pcc.EsExpoOferta,0) as EsExpoOferta,
		isnull(pcc.CUVRevista,'') as CUVRevista,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		isnull(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		isnull(op.TipoOfertaSisID,0) TipoOfertaSisID,
		isnull(te.flagNueva, 0) FlagNueva,
		isnull(te.TipoEstrategiaID, '') TipoEstrategiaID,
		iif(PS.ProductoSugeridoID is null, 0, 1) as TieneSugerido,
		isnull(Cat.Descripcion,'') as CatalogoDescripcion,
		coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) as ImagenOferta,
		coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05,
			mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) as ImagenProducto,
		coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta,
		coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	from ods.ProductoComercial p
	left join Marca M ON p.MarcaId = M.MarcaId
	left join dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia EST ON
		(p.AnoCampania between EST.CampaniaID and isnull(EST.CampaniaIDFin, EST.CampaniaID))
		and
		EST.CUV2 = p.CUV and EST.Activo = 1
	left join TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	left join ProductoSugerido PS on PS.CampaniaID = p.AnoCampania and PS.CUV = P.CUV and PS.Estado = 1
	left join ProductoSugerido PS2 on PS2.CampaniaID = p.AnoCampania and PS2.CUVSugerido = P.CUV and PS.Estado = 1
	left join ods.Catalogo Cat with(nolock) on p.CodigoCatalago = Cat.CodigoCatalogo
	where
		p.AnoCampania = @CampaniaID and p.IndicadorDigitable = 1
		and
		CHARINDEX(@TextoBusqueda,iif(
			@Criterio = 1,
			p.CUV,
			coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion)
		))>0;
END

GO

USE BelcorpEcuador
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona
	@CampaniaID int,
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@RowCount int,
	@Criterio int,
	@TextoBusqueda varchar(100)
AS
BEGIN
	--INI: Lista de Ofertas
	declare @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250),
		ConfiguracionOfertaID int,
		TipoOfertaSisID int,
		ImagenProducto varchar(250)
	);

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from OfertaProducto op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	union all

	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from ShowRoom.OfertaShowRoom op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID    
	where c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas
	
	--INI: Lista de Productos Faltantes
	declare @ProductoFaltanteTemp table (CUV varchar(6))

	insert into @ProductoFaltanteTemp
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante with(nolock)
	where CampaniaID = @CampaniaID and Zonaid = @ZonaID

	union all

	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa with(nolock)
	inner join ods.Campania c with(nolock) on fa.CampaniaID = c.CampaniaID
	where 
		c.Codigo = @CampaniaID 
		and (fa.CodigoRegion IS NULL or rtrim(fa.CodigoRegion) = @CodigoRegion)
		and (fa.CodigoZona IS NULL or rtrim(fa.CodigoZona) = @CodigoZona)
	--FIN: Lista de Productos Faltantes
	
	select distinct top (@RowCount)
		p.CUV,
		p.CodigoProducto as CodigoSAP,
		coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion, p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		iif(isnull(pf.CUV,0) = 0, 1, 0) as TieneStock,
		isnull(pcc.EsExpoOferta,0) as EsExpoOferta,
		isnull(pcc.CUVRevista,'') as CUVRevista,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		isnull(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		isnull(op.TipoOfertaSisID,0) TipoOfertaSisID,
		isnull(te.flagNueva, 0) FlagNueva,
		isnull(te.TipoEstrategiaID, '') TipoEstrategiaID,
		iif(PS.ProductoSugeridoID is null, 0, 1) as TieneSugerido,
		isnull(Cat.Descripcion,'') as CatalogoDescripcion,
		coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) as ImagenOferta,
		coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05,
			mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) as ImagenProducto,
		coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta,
		coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	from ods.ProductoComercial p
	left join Marca M ON p.MarcaId = M.MarcaId
	left join dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia EST ON
		(p.AnoCampania between EST.CampaniaID and isnull(EST.CampaniaIDFin, EST.CampaniaID))
		and
		EST.CUV2 = p.CUV and EST.Activo = 1
	left join TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	left join ProductoSugerido PS on PS.CampaniaID = p.AnoCampania and PS.CUV = P.CUV and PS.Estado = 1
	left join ProductoSugerido PS2 on PS2.CampaniaID = p.AnoCampania and PS2.CUVSugerido = P.CUV and PS.Estado = 1
	left join ods.Catalogo Cat with(nolock) on p.CodigoCatalago = Cat.CodigoCatalogo
	where
		p.AnoCampania = @CampaniaID and p.IndicadorDigitable = 1
		and
		CHARINDEX(@TextoBusqueda,iif(
			@Criterio = 1,
			p.CUV,
			coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion)
		))>0;
END

GO

USE BelcorpDominicana
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona
	@CampaniaID int,
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@RowCount int,
	@Criterio int,
	@TextoBusqueda varchar(100)
AS
BEGIN
	--INI: Lista de Ofertas
	declare @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250),
		ConfiguracionOfertaID int,
		TipoOfertaSisID int,
		ImagenProducto varchar(250)
	);

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from OfertaProducto op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	union all

	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from ShowRoom.OfertaShowRoom op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID    
	where c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas
	
	--INI: Lista de Productos Faltantes
	declare @ProductoFaltanteTemp table (CUV varchar(6))

	insert into @ProductoFaltanteTemp
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante with(nolock)
	where CampaniaID = @CampaniaID and Zonaid = @ZonaID

	union all

	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa with(nolock)
	inner join ods.Campania c with(nolock) on fa.CampaniaID = c.CampaniaID
	where 
		c.Codigo = @CampaniaID 
		and (fa.CodigoRegion IS NULL or rtrim(fa.CodigoRegion) = @CodigoRegion)
		and (fa.CodigoZona IS NULL or rtrim(fa.CodigoZona) = @CodigoZona)
	--FIN: Lista de Productos Faltantes
	
	select distinct top (@RowCount)
		p.CUV,
		p.CodigoProducto as CodigoSAP,
		coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion, p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		iif(isnull(pf.CUV,0) = 0, 1, 0) as TieneStock,
		isnull(pcc.EsExpoOferta,0) as EsExpoOferta,
		isnull(pcc.CUVRevista,'') as CUVRevista,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		isnull(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		isnull(op.TipoOfertaSisID,0) TipoOfertaSisID,
		isnull(te.flagNueva, 0) FlagNueva,
		isnull(te.TipoEstrategiaID, '') TipoEstrategiaID,
		iif(PS.ProductoSugeridoID is null, 0, 1) as TieneSugerido,
		isnull(Cat.Descripcion,'') as CatalogoDescripcion,
		coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) as ImagenOferta,
		coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05,
			mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) as ImagenProducto,
		coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta,
		coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	from ods.ProductoComercial p
	left join Marca M ON p.MarcaId = M.MarcaId
	left join dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia EST ON
		(p.AnoCampania between EST.CampaniaID and isnull(EST.CampaniaIDFin, EST.CampaniaID))
		and
		EST.CUV2 = p.CUV and EST.Activo = 1
	left join TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	left join ProductoSugerido PS on PS.CampaniaID = p.AnoCampania and PS.CUV = P.CUV and PS.Estado = 1
	left join ProductoSugerido PS2 on PS2.CampaniaID = p.AnoCampania and PS2.CUVSugerido = P.CUV and PS.Estado = 1
	left join ods.Catalogo Cat with(nolock) on p.CodigoCatalago = Cat.CodigoCatalogo
	where
		p.AnoCampania = @CampaniaID and p.IndicadorDigitable = 1
		and
		CHARINDEX(@TextoBusqueda,iif(
			@Criterio = 1,
			p.CUV,
			coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion)
		))>0;
END

GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona
	@CampaniaID int,
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@RowCount int,
	@Criterio int,
	@TextoBusqueda varchar(100)
AS
BEGIN
	--INI: Lista de Ofertas
	declare @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250),
		ConfiguracionOfertaID int,
		TipoOfertaSisID int,
		ImagenProducto varchar(250)
	);

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from OfertaProducto op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	union all

	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from ShowRoom.OfertaShowRoom op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID    
	where c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas
	
	--INI: Lista de Productos Faltantes
	declare @ProductoFaltanteTemp table (CUV varchar(6))

	insert into @ProductoFaltanteTemp
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante with(nolock)
	where CampaniaID = @CampaniaID and Zonaid = @ZonaID

	union all

	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa with(nolock)
	inner join ods.Campania c with(nolock) on fa.CampaniaID = c.CampaniaID
	where 
		c.Codigo = @CampaniaID 
		and (fa.CodigoRegion IS NULL or rtrim(fa.CodigoRegion) = @CodigoRegion)
		and (fa.CodigoZona IS NULL or rtrim(fa.CodigoZona) = @CodigoZona)
	--FIN: Lista de Productos Faltantes
	
	select distinct top (@RowCount)
		p.CUV,
		p.CodigoProducto as CodigoSAP,
		coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion, p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		iif(isnull(pf.CUV,0) = 0, 1, 0) as TieneStock,
		isnull(pcc.EsExpoOferta,0) as EsExpoOferta,
		isnull(pcc.CUVRevista,'') as CUVRevista,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		isnull(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		isnull(op.TipoOfertaSisID,0) TipoOfertaSisID,
		isnull(te.flagNueva, 0) FlagNueva,
		isnull(te.TipoEstrategiaID, '') TipoEstrategiaID,
		iif(PS.ProductoSugeridoID is null, 0, 1) as TieneSugerido,
		isnull(Cat.Descripcion,'') as CatalogoDescripcion,
		coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) as ImagenOferta,
		coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05,
			mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) as ImagenProducto,
		coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta,
		coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	from ods.ProductoComercial p
	left join Marca M ON p.MarcaId = M.MarcaId
	left join dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia EST ON
		(p.AnoCampania between EST.CampaniaID and isnull(EST.CampaniaIDFin, EST.CampaniaID))
		and
		EST.CUV2 = p.CUV and EST.Activo = 1
	left join TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	left join ProductoSugerido PS on PS.CampaniaID = p.AnoCampania and PS.CUV = P.CUV and PS.Estado = 1
	left join ProductoSugerido PS2 on PS2.CampaniaID = p.AnoCampania and PS2.CUVSugerido = P.CUV and PS.Estado = 1
	left join ods.Catalogo Cat with(nolock) on p.CodigoCatalago = Cat.CodigoCatalogo
	where
		p.AnoCampania = @CampaniaID and p.IndicadorDigitable = 1
		and
		CHARINDEX(@TextoBusqueda,iif(
			@Criterio = 1,
			p.CUV,
			coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion)
		))>0;
END

GO

USE BelcorpChile
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona
	@CampaniaID int,
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@RowCount int,
	@Criterio int,
	@TextoBusqueda varchar(100)
AS
BEGIN
	--INI: Lista de Ofertas
	declare @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250),
		ConfiguracionOfertaID int,
		TipoOfertaSisID int,
		ImagenProducto varchar(250)
	);

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from OfertaProducto op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	union all

	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from ShowRoom.OfertaShowRoom op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID    
	where c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas
	
	--INI: Lista de Productos Faltantes
	declare @ProductoFaltanteTemp table (CUV varchar(6))

	insert into @ProductoFaltanteTemp
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante with(nolock)
	where CampaniaID = @CampaniaID and Zonaid = @ZonaID

	union all

	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa with(nolock)
	inner join ods.Campania c with(nolock) on fa.CampaniaID = c.CampaniaID
	where 
		c.Codigo = @CampaniaID 
		and (fa.CodigoRegion IS NULL or rtrim(fa.CodigoRegion) = @CodigoRegion)
		and (fa.CodigoZona IS NULL or rtrim(fa.CodigoZona) = @CodigoZona)
	--FIN: Lista de Productos Faltantes
	
	select distinct top (@RowCount)
		p.CUV,
		p.CodigoProducto as CodigoSAP,
		coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion, p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		iif(isnull(pf.CUV,0) = 0, 1, 0) as TieneStock,
		isnull(pcc.EsExpoOferta,0) as EsExpoOferta,
		isnull(pcc.CUVRevista,'') as CUVRevista,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		isnull(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		isnull(op.TipoOfertaSisID,0) TipoOfertaSisID,
		isnull(te.flagNueva, 0) FlagNueva,
		isnull(te.TipoEstrategiaID, '') TipoEstrategiaID,
		iif(PS.ProductoSugeridoID is null, 0, 1) as TieneSugerido,
		isnull(Cat.Descripcion,'') as CatalogoDescripcion,
		coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) as ImagenOferta,
		coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05,
			mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) as ImagenProducto,
		coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta,
		coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	from ods.ProductoComercial p
	left join Marca M ON p.MarcaId = M.MarcaId
	left join dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia EST ON
		(p.AnoCampania between EST.CampaniaID and isnull(EST.CampaniaIDFin, EST.CampaniaID))
		and
		EST.CUV2 = p.CUV and EST.Activo = 1
	left join TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	left join ProductoSugerido PS on PS.CampaniaID = p.AnoCampania and PS.CUV = P.CUV and PS.Estado = 1
	left join ProductoSugerido PS2 on PS2.CampaniaID = p.AnoCampania and PS2.CUVSugerido = P.CUV and PS.Estado = 1
	left join ods.Catalogo Cat with(nolock) on p.CodigoCatalago = Cat.CodigoCatalogo
	where
		p.AnoCampania = @CampaniaID and p.IndicadorDigitable = 1
		and
		CHARINDEX(@TextoBusqueda,iif(
			@Criterio = 1,
			p.CUV,
			coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion)
		))>0;
END

GO

USE BelcorpBolivia
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona
	@CampaniaID int,
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@RowCount int,
	@Criterio int,
	@TextoBusqueda varchar(100)
AS
BEGIN
	--INI: Lista de Ofertas
	declare @OfertaProductoTemp table
	(
		CampaniaID int,
		CUV varchar(6),
		Descripcion varchar(250),
		ConfiguracionOfertaID int,
		TipoOfertaSisID int,
		ImagenProducto varchar(250)
	);

	insert into @OfertaProductoTemp
	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from OfertaProducto op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID
	where c.codigo = @CampaniaID

	union all

	select op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID, op.ImagenProducto
	from ShowRoom.OfertaShowRoom op with(nolock)
	inner join ods.Campania c on op.CampaniaID = c.CampaniaID    
	where c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas
	
	--INI: Lista de Productos Faltantes
	declare @ProductoFaltanteTemp table (CUV varchar(6))

	insert into @ProductoFaltanteTemp
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante with(nolock)
	where CampaniaID = @CampaniaID and Zonaid = @ZonaID

	union all

	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa with(nolock)
	inner join ods.Campania c with(nolock) on fa.CampaniaID = c.CampaniaID
	where 
		c.Codigo = @CampaniaID 
		and (fa.CodigoRegion IS NULL or rtrim(fa.CodigoRegion) = @CodigoRegion)
		and (fa.CodigoZona IS NULL or rtrim(fa.CodigoZona) = @CodigoZona)
	--FIN: Lista de Productos Faltantes
	
	select distinct top (@RowCount)
		p.CUV,
		p.CodigoProducto as CodigoSAP,
		coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		coalesce(est.precio2, pd.PrecioProducto*pd.FactorRepeticion, p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		iif(isnull(pf.CUV,0) = 0, 1, 0) as TieneStock,
		isnull(pcc.EsExpoOferta,0) as EsExpoOferta,
		isnull(pcc.CUVRevista,'') as CUVRevista,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		isnull(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		isnull(op.TipoOfertaSisID,0) TipoOfertaSisID,
		isnull(te.flagNueva, 0) FlagNueva,
		isnull(te.TipoEstrategiaID, '') TipoEstrategiaID,
		iif(PS.ProductoSugeridoID is null, 0, 1) as TieneSugerido,
		isnull(Cat.Descripcion,'') as CatalogoDescripcion,
		coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) as ImagenOferta,
		coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05,
			mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) as ImagenProducto,
		coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta,
		coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	from ods.ProductoComercial p
	left join Marca M ON p.MarcaId = M.MarcaId
	left join dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on op.CampaniaID = P.CampaniaID AND op.CUV = P.CUV
	left join MatrizComercial mc on p.CodigoProducto = mc.CodigoSAP
	left join Estrategia EST ON
		(p.AnoCampania between EST.CampaniaID and isnull(EST.CampaniaIDFin, EST.CampaniaID))
		and
		EST.CUV2 = p.CUV and EST.Activo = 1
	left join TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	left join ProductoSugerido PS on PS.CampaniaID = p.AnoCampania and PS.CUV = P.CUV and PS.Estado = 1
	left join ProductoSugerido PS2 on PS2.CampaniaID = p.AnoCampania and PS2.CUVSugerido = P.CUV and PS.Estado = 1
	left join ods.Catalogo Cat with(nolock) on p.CodigoCatalago = Cat.CodigoCatalogo
	where
		p.AnoCampania = @CampaniaID and p.IndicadorDigitable = 1
		and
		CHARINDEX(@TextoBusqueda,iif(
			@Criterio = 1,
			p.CUV,
			coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion)
		))>0;
END

GO

