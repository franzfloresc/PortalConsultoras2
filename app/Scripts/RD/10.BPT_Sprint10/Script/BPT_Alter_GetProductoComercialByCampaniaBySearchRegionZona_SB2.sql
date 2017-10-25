USE BelcorpPeru
GO

GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]
	@CampaniaID int,
	@RowCount int,
	@Criterio int,
	@CodigoDescripcion varchar(100),
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@ValidarOPT bit = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp table
(
	CampaniaID int,
	CUV varchar(6),
	Descripcion varchar(250),
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	PrecioOferta numeric(12,2)
)

insert into @OfertaProductoTemp
select 
	op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null
FROM OfertaProducto op with(nolock)
inner join ods.Campania c with(nolock) on
	op.CampaniaID = c.CampaniaID
where
	c.codigo = @CampaniaID

insert into @OfertaProductoTemp    
select op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null    
FROM ShowRoom.OfertaShowRoom op with(nolock)   
inner join ods.Campania c with(nolock) on     
	op.CampaniaID = c.CampaniaID    
where   
	c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp table (CUV varchar(6))

INSERT INTO @ProductoFaltanteTemp
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante with(nolock)
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa with(nolock)
inner join ods.Campania c with(nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
declare @TieneSugerido int = 0
if exists (	
		select 1 from dbo.ProductoSugerido 
		where CampaniaID = @CampaniaID 
			and CUV = @CodigoDescripcion 
			and Estado = 1
)
begin
	set @TieneSugerido = 1
end

	select 
		distinct top (@RowCount) p.CUV,
		coalesce(EST.DescripcionCUV2 + 
		(
			case when @Criterio = 1 then isnull(' '+ tccS.Descripcion, '')
			else '' end
		),
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(	SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 END TieneOfertaRevista,		
		p.PrecioValorizado,
		case 
			when pl.CodigoSAP is null then 0
			else 1 end as TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') as TipoOfertaRevista,
		TE.Codigo as TipoEstrategiaCodigo
	from ods.ProductoComercial p with(nolock)
	left join dbo.ProductoDescripcion pd with(nolock) ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc with(nolock) ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	left join MatrizComercial mc with(nolock) on 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST with(nolock) ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania between EST.CampaniaID and EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tccS with(nolock)
		ON tccS.CUV = p.CUV 
		AND tccS.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE with(nolock) ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M with(nolock) ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl with(nolock) on
		p.CodigoProducto = pl.CodigoSAP
		and p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor with(nolock) ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	where 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		AND (
			(@Criterio = 1 and CHARINDEX(@CodigoDescripcion,p.CUV) > 0 )
			or (@Criterio != 1 and  CHARINDEX(@CodigoDescripcion,coalesce(op.Descripcion,pd.Descripcion, p.Descripcion)) > 0 )
		)

END

GO

USE BelcorpMexico
GO

GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]
	@CampaniaID int,
	@RowCount int,
	@Criterio int,
	@CodigoDescripcion varchar(100),
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@ValidarOPT bit = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp table
(
	CampaniaID int,
	CUV varchar(6),
	Descripcion varchar(250),
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	PrecioOferta numeric(12,2)
)

insert into @OfertaProductoTemp
select 
	op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null
FROM OfertaProducto op with(nolock)
inner join ods.Campania c with(nolock) on
	op.CampaniaID = c.CampaniaID
where
	c.codigo = @CampaniaID

insert into @OfertaProductoTemp    
select op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null    
FROM ShowRoom.OfertaShowRoom op with(nolock)   
inner join ods.Campania c with(nolock) on     
	op.CampaniaID = c.CampaniaID    
where   
	c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp table (CUV varchar(6))

INSERT INTO @ProductoFaltanteTemp
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante with(nolock)
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa with(nolock)
inner join ods.Campania c with(nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
declare @TieneSugerido int = 0
if exists (	
		select 1 from dbo.ProductoSugerido 
		where CampaniaID = @CampaniaID 
			and CUV = @CodigoDescripcion 
			and Estado = 1
)
begin
	set @TieneSugerido = 1
end

	select 
		distinct top (@RowCount) p.CUV,
		coalesce(EST.DescripcionCUV2 + 
		(
			case when @Criterio = 1 then isnull(' '+ tccS.Descripcion, '')
			else '' end
		),
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(	SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 END TieneOfertaRevista,		
		p.PrecioValorizado,
		case 
			when pl.CodigoSAP is null then 0
			else 1 end as TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') as TipoOfertaRevista,
		TE.Codigo as TipoEstrategiaCodigo
	from ods.ProductoComercial p with(nolock)
	left join dbo.ProductoDescripcion pd with(nolock) ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc with(nolock) ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	left join MatrizComercial mc with(nolock) on 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST with(nolock) ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania between EST.CampaniaID and EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tccS with(nolock)
		ON tccS.CUV = p.CUV 
		AND tccS.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE with(nolock) ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M with(nolock) ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl with(nolock) on
		p.CodigoProducto = pl.CodigoSAP
		and p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor with(nolock) ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	where 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		AND (
			(@Criterio = 1 and CHARINDEX(@CodigoDescripcion,p.CUV) > 0 )
			or (@Criterio != 1 and  CHARINDEX(@CodigoDescripcion,coalesce(op.Descripcion,pd.Descripcion, p.Descripcion)) > 0 )
		)

END

GO

USE BelcorpColombia
GO

GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]
	@CampaniaID int,
	@RowCount int,
	@Criterio int,
	@CodigoDescripcion varchar(100),
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@ValidarOPT bit = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp table
(
	CampaniaID int,
	CUV varchar(6),
	Descripcion varchar(250),
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	PrecioOferta numeric(12,2)
)

insert into @OfertaProductoTemp
select 
	op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null
FROM OfertaProducto op with(nolock)
inner join ods.Campania c with(nolock) on
	op.CampaniaID = c.CampaniaID
where
	c.codigo = @CampaniaID

insert into @OfertaProductoTemp    
select op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null    
FROM ShowRoom.OfertaShowRoom op with(nolock)   
inner join ods.Campania c with(nolock) on     
	op.CampaniaID = c.CampaniaID    
where   
	c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp table (CUV varchar(6))

INSERT INTO @ProductoFaltanteTemp
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante with(nolock)
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa with(nolock)
inner join ods.Campania c with(nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
declare @TieneSugerido int = 0
if exists (	
		select 1 from dbo.ProductoSugerido 
		where CampaniaID = @CampaniaID 
			and CUV = @CodigoDescripcion 
			and Estado = 1
)
begin
	set @TieneSugerido = 1
end

	select 
		distinct top (@RowCount) p.CUV,
		coalesce(EST.DescripcionCUV2 + 
		(
			case when @Criterio = 1 then isnull(' '+ tccS.Descripcion, '')
			else '' end
		),
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(	SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 END TieneOfertaRevista,		
		p.PrecioValorizado,
		case 
			when pl.CodigoSAP is null then 0
			else 1 end as TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') as TipoOfertaRevista,
		TE.Codigo as TipoEstrategiaCodigo
	from ods.ProductoComercial p with(nolock)
	left join dbo.ProductoDescripcion pd with(nolock) ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc with(nolock) ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	left join MatrizComercial mc with(nolock) on 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST with(nolock) ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania between EST.CampaniaID and EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tccS with(nolock)
		ON tccS.CUV = p.CUV 
		AND tccS.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE with(nolock) ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M with(nolock) ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl with(nolock) on
		p.CodigoProducto = pl.CodigoSAP
		and p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor with(nolock) ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	where 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		AND (
			(@Criterio = 1 and CHARINDEX(@CodigoDescripcion,p.CUV) > 0 )
			or (@Criterio != 1 and  CHARINDEX(@CodigoDescripcion,coalesce(op.Descripcion,pd.Descripcion, p.Descripcion)) > 0 )
		)

END

GO

USE BelcorpVenezuela
GO

GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]
	@CampaniaID int,
	@RowCount int,
	@Criterio int,
	@CodigoDescripcion varchar(100),
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@ValidarOPT bit = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp table
(
	CampaniaID int,
	CUV varchar(6),
	Descripcion varchar(250),
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	PrecioOferta numeric(12,2)
)

insert into @OfertaProductoTemp
select 
	op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null
FROM OfertaProducto op with(nolock)
inner join ods.Campania c with(nolock) on
	op.CampaniaID = c.CampaniaID
where
	c.codigo = @CampaniaID

insert into @OfertaProductoTemp    
select op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null    
FROM ShowRoom.OfertaShowRoom op with(nolock)   
inner join ods.Campania c with(nolock) on     
	op.CampaniaID = c.CampaniaID    
where   
	c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp table (CUV varchar(6))

INSERT INTO @ProductoFaltanteTemp
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante with(nolock)
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa with(nolock)
inner join ods.Campania c with(nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
declare @TieneSugerido int = 0
if exists (	
		select 1 from dbo.ProductoSugerido 
		where CampaniaID = @CampaniaID 
			and CUV = @CodigoDescripcion 
			and Estado = 1
)
begin
	set @TieneSugerido = 1
end

	select 
		distinct top (@RowCount) p.CUV,
		coalesce(EST.DescripcionCUV2 + 
		(
			case when @Criterio = 1 then isnull(' '+ tccS.Descripcion, '')
			else '' end
		),
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(	SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 END TieneOfertaRevista,		
		p.PrecioValorizado,
		case 
			when pl.CodigoSAP is null then 0
			else 1 end as TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') as TipoOfertaRevista,
		TE.Codigo as TipoEstrategiaCodigo
	from ods.ProductoComercial p with(nolock)
	left join dbo.ProductoDescripcion pd with(nolock) ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc with(nolock) ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	left join MatrizComercial mc with(nolock) on 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST with(nolock) ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania between EST.CampaniaID and EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tccS with(nolock)
		ON tccS.CUV = p.CUV 
		AND tccS.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE with(nolock) ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M with(nolock) ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl with(nolock) on
		p.CodigoProducto = pl.CodigoSAP
		and p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor with(nolock) ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	where 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		AND (
			(@Criterio = 1 and CHARINDEX(@CodigoDescripcion,p.CUV) > 0 )
			or (@Criterio != 1 and  CHARINDEX(@CodigoDescripcion,coalesce(op.Descripcion,pd.Descripcion, p.Descripcion)) > 0 )
		)

END

GO

USE BelcorpSalvador
GO

GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]
	@CampaniaID int,
	@RowCount int,
	@Criterio int,
	@CodigoDescripcion varchar(100),
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@ValidarOPT bit = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp table
(
	CampaniaID int,
	CUV varchar(6),
	Descripcion varchar(250),
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	PrecioOferta numeric(12,2)
)

insert into @OfertaProductoTemp
select 
	op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null
FROM OfertaProducto op with(nolock)
inner join ods.Campania c with(nolock) on
	op.CampaniaID = c.CampaniaID
where
	c.codigo = @CampaniaID

insert into @OfertaProductoTemp    
select op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null    
FROM ShowRoom.OfertaShowRoom op with(nolock)   
inner join ods.Campania c with(nolock) on     
	op.CampaniaID = c.CampaniaID    
where   
	c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp table (CUV varchar(6))

INSERT INTO @ProductoFaltanteTemp
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante with(nolock)
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa with(nolock)
inner join ods.Campania c with(nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
declare @TieneSugerido int = 0
if exists (	
		select 1 from dbo.ProductoSugerido 
		where CampaniaID = @CampaniaID 
			and CUV = @CodigoDescripcion 
			and Estado = 1
)
begin
	set @TieneSugerido = 1
end

	select 
		distinct top (@RowCount) p.CUV,
		coalesce(EST.DescripcionCUV2 + 
		(
			case when @Criterio = 1 then isnull(' '+ tccS.Descripcion, '')
			else '' end
		),
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(	SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 END TieneOfertaRevista,		
		p.PrecioValorizado,
		case 
			when pl.CodigoSAP is null then 0
			else 1 end as TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') as TipoOfertaRevista,
		TE.Codigo as TipoEstrategiaCodigo
	from ods.ProductoComercial p with(nolock)
	left join dbo.ProductoDescripcion pd with(nolock) ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc with(nolock) ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	left join MatrizComercial mc with(nolock) on 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST with(nolock) ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania between EST.CampaniaID and EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tccS with(nolock)
		ON tccS.CUV = p.CUV 
		AND tccS.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE with(nolock) ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M with(nolock) ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl with(nolock) on
		p.CodigoProducto = pl.CodigoSAP
		and p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor with(nolock) ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	where 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		AND (
			(@Criterio = 1 and CHARINDEX(@CodigoDescripcion,p.CUV) > 0 )
			or (@Criterio != 1 and  CHARINDEX(@CodigoDescripcion,coalesce(op.Descripcion,pd.Descripcion, p.Descripcion)) > 0 )
		)

END

GO

USE BelcorpPuertoRico
GO

GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]
	@CampaniaID int,
	@RowCount int,
	@Criterio int,
	@CodigoDescripcion varchar(100),
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@ValidarOPT bit = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp table
(
	CampaniaID int,
	CUV varchar(6),
	Descripcion varchar(250),
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	PrecioOferta numeric(12,2)
)

insert into @OfertaProductoTemp
select 
	op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null
FROM OfertaProducto op with(nolock)
inner join ods.Campania c with(nolock) on
	op.CampaniaID = c.CampaniaID
where
	c.codigo = @CampaniaID

insert into @OfertaProductoTemp    
select op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null    
FROM ShowRoom.OfertaShowRoom op with(nolock)   
inner join ods.Campania c with(nolock) on     
	op.CampaniaID = c.CampaniaID    
where   
	c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp table (CUV varchar(6))

INSERT INTO @ProductoFaltanteTemp
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante with(nolock)
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa with(nolock)
inner join ods.Campania c with(nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
declare @TieneSugerido int = 0
if exists (	
		select 1 from dbo.ProductoSugerido 
		where CampaniaID = @CampaniaID 
			and CUV = @CodigoDescripcion 
			and Estado = 1
)
begin
	set @TieneSugerido = 1
end

	select 
		distinct top (@RowCount) p.CUV,
		coalesce(EST.DescripcionCUV2 + 
		(
			case when @Criterio = 1 then isnull(' '+ tccS.Descripcion, '')
			else '' end
		),
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(	SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 END TieneOfertaRevista,		
		p.PrecioValorizado,
		case 
			when pl.CodigoSAP is null then 0
			else 1 end as TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') as TipoOfertaRevista,
		TE.Codigo as TipoEstrategiaCodigo
	from ods.ProductoComercial p with(nolock)
	left join dbo.ProductoDescripcion pd with(nolock) ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc with(nolock) ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	left join MatrizComercial mc with(nolock) on 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST with(nolock) ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania between EST.CampaniaID and EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tccS with(nolock)
		ON tccS.CUV = p.CUV 
		AND tccS.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE with(nolock) ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M with(nolock) ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl with(nolock) on
		p.CodigoProducto = pl.CodigoSAP
		and p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor with(nolock) ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	where 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		AND (
			(@Criterio = 1 and CHARINDEX(@CodigoDescripcion,p.CUV) > 0 )
			or (@Criterio != 1 and  CHARINDEX(@CodigoDescripcion,coalesce(op.Descripcion,pd.Descripcion, p.Descripcion)) > 0 )
		)

END

GO

USE BelcorpPanama
GO

GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]
	@CampaniaID int,
	@RowCount int,
	@Criterio int,
	@CodigoDescripcion varchar(100),
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@ValidarOPT bit = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp table
(
	CampaniaID int,
	CUV varchar(6),
	Descripcion varchar(250),
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	PrecioOferta numeric(12,2)
)

insert into @OfertaProductoTemp
select 
	op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null
FROM OfertaProducto op with(nolock)
inner join ods.Campania c with(nolock) on
	op.CampaniaID = c.CampaniaID
where
	c.codigo = @CampaniaID

insert into @OfertaProductoTemp    
select op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null    
FROM ShowRoom.OfertaShowRoom op with(nolock)   
inner join ods.Campania c with(nolock) on     
	op.CampaniaID = c.CampaniaID    
where   
	c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp table (CUV varchar(6))

INSERT INTO @ProductoFaltanteTemp
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante with(nolock)
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa with(nolock)
inner join ods.Campania c with(nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
declare @TieneSugerido int = 0
if exists (	
		select 1 from dbo.ProductoSugerido 
		where CampaniaID = @CampaniaID 
			and CUV = @CodigoDescripcion 
			and Estado = 1
)
begin
	set @TieneSugerido = 1
end

	select 
		distinct top (@RowCount) p.CUV,
		coalesce(EST.DescripcionCUV2 + 
		(
			case when @Criterio = 1 then isnull(' '+ tccS.Descripcion, '')
			else '' end
		),
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(	SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 END TieneOfertaRevista,		
		p.PrecioValorizado,
		case 
			when pl.CodigoSAP is null then 0
			else 1 end as TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') as TipoOfertaRevista,
		TE.Codigo as TipoEstrategiaCodigo
	from ods.ProductoComercial p with(nolock)
	left join dbo.ProductoDescripcion pd with(nolock) ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc with(nolock) ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	left join MatrizComercial mc with(nolock) on 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST with(nolock) ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania between EST.CampaniaID and EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tccS with(nolock)
		ON tccS.CUV = p.CUV 
		AND tccS.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE with(nolock) ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M with(nolock) ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl with(nolock) on
		p.CodigoProducto = pl.CodigoSAP
		and p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor with(nolock) ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	where 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		AND (
			(@Criterio = 1 and CHARINDEX(@CodigoDescripcion,p.CUV) > 0 )
			or (@Criterio != 1 and  CHARINDEX(@CodigoDescripcion,coalesce(op.Descripcion,pd.Descripcion, p.Descripcion)) > 0 )
		)

END

GO

USE BelcorpGuatemala
GO

GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]
	@CampaniaID int,
	@RowCount int,
	@Criterio int,
	@CodigoDescripcion varchar(100),
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@ValidarOPT bit = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp table
(
	CampaniaID int,
	CUV varchar(6),
	Descripcion varchar(250),
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	PrecioOferta numeric(12,2)
)

insert into @OfertaProductoTemp
select 
	op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null
FROM OfertaProducto op with(nolock)
inner join ods.Campania c with(nolock) on
	op.CampaniaID = c.CampaniaID
where
	c.codigo = @CampaniaID

insert into @OfertaProductoTemp    
select op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null    
FROM ShowRoom.OfertaShowRoom op with(nolock)   
inner join ods.Campania c with(nolock) on     
	op.CampaniaID = c.CampaniaID    
where   
	c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp table (CUV varchar(6))

INSERT INTO @ProductoFaltanteTemp
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante with(nolock)
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa with(nolock)
inner join ods.Campania c with(nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
declare @TieneSugerido int = 0
if exists (	
		select 1 from dbo.ProductoSugerido 
		where CampaniaID = @CampaniaID 
			and CUV = @CodigoDescripcion 
			and Estado = 1
)
begin
	set @TieneSugerido = 1
end

	select 
		distinct top (@RowCount) p.CUV,
		coalesce(EST.DescripcionCUV2 + 
		(
			case when @Criterio = 1 then isnull(' '+ tccS.Descripcion, '')
			else '' end
		),
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(	SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 END TieneOfertaRevista,		
		p.PrecioValorizado,
		case 
			when pl.CodigoSAP is null then 0
			else 1 end as TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') as TipoOfertaRevista,
		TE.Codigo as TipoEstrategiaCodigo
	from ods.ProductoComercial p with(nolock)
	left join dbo.ProductoDescripcion pd with(nolock) ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc with(nolock) ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	left join MatrizComercial mc with(nolock) on 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST with(nolock) ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania between EST.CampaniaID and EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tccS with(nolock)
		ON tccS.CUV = p.CUV 
		AND tccS.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE with(nolock) ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M with(nolock) ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl with(nolock) on
		p.CodigoProducto = pl.CodigoSAP
		and p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor with(nolock) ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	where 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		AND (
			(@Criterio = 1 and CHARINDEX(@CodigoDescripcion,p.CUV) > 0 )
			or (@Criterio != 1 and  CHARINDEX(@CodigoDescripcion,coalesce(op.Descripcion,pd.Descripcion, p.Descripcion)) > 0 )
		)

END

GO

USE BelcorpEcuador
GO

GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]
	@CampaniaID int,
	@RowCount int,
	@Criterio int,
	@CodigoDescripcion varchar(100),
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@ValidarOPT bit = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp table
(
	CampaniaID int,
	CUV varchar(6),
	Descripcion varchar(250),
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	PrecioOferta numeric(12,2)
)

insert into @OfertaProductoTemp
select 
	op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null
FROM OfertaProducto op with(nolock)
inner join ods.Campania c with(nolock) on
	op.CampaniaID = c.CampaniaID
where
	c.codigo = @CampaniaID

insert into @OfertaProductoTemp    
select op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null    
FROM ShowRoom.OfertaShowRoom op with(nolock)   
inner join ods.Campania c with(nolock) on     
	op.CampaniaID = c.CampaniaID    
where   
	c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp table (CUV varchar(6))

INSERT INTO @ProductoFaltanteTemp
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante with(nolock)
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa with(nolock)
inner join ods.Campania c with(nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
declare @TieneSugerido int = 0
if exists (	
		select 1 from dbo.ProductoSugerido 
		where CampaniaID = @CampaniaID 
			and CUV = @CodigoDescripcion 
			and Estado = 1
)
begin
	set @TieneSugerido = 1
end

	select 
		distinct top (@RowCount) p.CUV,
		coalesce(EST.DescripcionCUV2 + 
		(
			case when @Criterio = 1 then isnull(' '+ tccS.Descripcion, '')
			else '' end
		),
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(	SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 END TieneOfertaRevista,		
		p.PrecioValorizado,
		case 
			when pl.CodigoSAP is null then 0
			else 1 end as TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') as TipoOfertaRevista,
		TE.Codigo as TipoEstrategiaCodigo
	from ods.ProductoComercial p with(nolock)
	left join dbo.ProductoDescripcion pd with(nolock) ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc with(nolock) ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	left join MatrizComercial mc with(nolock) on 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST with(nolock) ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania between EST.CampaniaID and EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tccS with(nolock)
		ON tccS.CUV = p.CUV 
		AND tccS.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE with(nolock) ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M with(nolock) ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl with(nolock) on
		p.CodigoProducto = pl.CodigoSAP
		and p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor with(nolock) ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	where 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		AND (
			(@Criterio = 1 and CHARINDEX(@CodigoDescripcion,p.CUV) > 0 )
			or (@Criterio != 1 and  CHARINDEX(@CodigoDescripcion,coalesce(op.Descripcion,pd.Descripcion, p.Descripcion)) > 0 )
		)

END

GO

USE BelcorpDominicana
GO

GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]
	@CampaniaID int,
	@RowCount int,
	@Criterio int,
	@CodigoDescripcion varchar(100),
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@ValidarOPT bit = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp table
(
	CampaniaID int,
	CUV varchar(6),
	Descripcion varchar(250),
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	PrecioOferta numeric(12,2)
)

insert into @OfertaProductoTemp
select 
	op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null
FROM OfertaProducto op with(nolock)
inner join ods.Campania c with(nolock) on
	op.CampaniaID = c.CampaniaID
where
	c.codigo = @CampaniaID

insert into @OfertaProductoTemp    
select op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null    
FROM ShowRoom.OfertaShowRoom op with(nolock)   
inner join ods.Campania c with(nolock) on     
	op.CampaniaID = c.CampaniaID    
where   
	c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp table (CUV varchar(6))

INSERT INTO @ProductoFaltanteTemp
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante with(nolock)
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa with(nolock)
inner join ods.Campania c with(nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
declare @TieneSugerido int = 0
if exists (	
		select 1 from dbo.ProductoSugerido 
		where CampaniaID = @CampaniaID 
			and CUV = @CodigoDescripcion 
			and Estado = 1
)
begin
	set @TieneSugerido = 1
end

	select 
		distinct top (@RowCount) p.CUV,
		coalesce(EST.DescripcionCUV2 + 
		(
			case when @Criterio = 1 then isnull(' '+ tccS.Descripcion, '')
			else '' end
		),
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(	SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 END TieneOfertaRevista,		
		p.PrecioValorizado,
		case 
			when pl.CodigoSAP is null then 0
			else 1 end as TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') as TipoOfertaRevista,
		TE.Codigo as TipoEstrategiaCodigo
	from ods.ProductoComercial p with(nolock)
	left join dbo.ProductoDescripcion pd with(nolock) ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc with(nolock) ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	left join MatrizComercial mc with(nolock) on 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST with(nolock) ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania between EST.CampaniaID and EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tccS with(nolock)
		ON tccS.CUV = p.CUV 
		AND tccS.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE with(nolock) ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M with(nolock) ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl with(nolock) on
		p.CodigoProducto = pl.CodigoSAP
		and p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor with(nolock) ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	where 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		AND (
			(@Criterio = 1 and CHARINDEX(@CodigoDescripcion,p.CUV) > 0 )
			or (@Criterio != 1 and  CHARINDEX(@CodigoDescripcion,coalesce(op.Descripcion,pd.Descripcion, p.Descripcion)) > 0 )
		)

END

GO

USE BelcorpCostaRica
GO

GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]
	@CampaniaID int,
	@RowCount int,
	@Criterio int,
	@CodigoDescripcion varchar(100),
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@ValidarOPT bit = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp table
(
	CampaniaID int,
	CUV varchar(6),
	Descripcion varchar(250),
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	PrecioOferta numeric(12,2)
)

insert into @OfertaProductoTemp
select 
	op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null
FROM OfertaProducto op with(nolock)
inner join ods.Campania c with(nolock) on
	op.CampaniaID = c.CampaniaID
where
	c.codigo = @CampaniaID

insert into @OfertaProductoTemp    
select op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null    
FROM ShowRoom.OfertaShowRoom op with(nolock)   
inner join ods.Campania c with(nolock) on     
	op.CampaniaID = c.CampaniaID    
where   
	c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp table (CUV varchar(6))

INSERT INTO @ProductoFaltanteTemp
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante with(nolock)
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa with(nolock)
inner join ods.Campania c with(nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
declare @TieneSugerido int = 0
if exists (	
		select 1 from dbo.ProductoSugerido 
		where CampaniaID = @CampaniaID 
			and CUV = @CodigoDescripcion 
			and Estado = 1
)
begin
	set @TieneSugerido = 1
end

	select 
		distinct top (@RowCount) p.CUV,
		coalesce(EST.DescripcionCUV2 + 
		(
			case when @Criterio = 1 then isnull(' '+ tccS.Descripcion, '')
			else '' end
		),
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(	SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 END TieneOfertaRevista,		
		p.PrecioValorizado,
		case 
			when pl.CodigoSAP is null then 0
			else 1 end as TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') as TipoOfertaRevista,
		TE.Codigo as TipoEstrategiaCodigo
	from ods.ProductoComercial p with(nolock)
	left join dbo.ProductoDescripcion pd with(nolock) ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc with(nolock) ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	left join MatrizComercial mc with(nolock) on 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST with(nolock) ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania between EST.CampaniaID and EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tccS with(nolock)
		ON tccS.CUV = p.CUV 
		AND tccS.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE with(nolock) ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M with(nolock) ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl with(nolock) on
		p.CodigoProducto = pl.CodigoSAP
		and p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor with(nolock) ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	where 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		AND (
			(@Criterio = 1 and CHARINDEX(@CodigoDescripcion,p.CUV) > 0 )
			or (@Criterio != 1 and  CHARINDEX(@CodigoDescripcion,coalesce(op.Descripcion,pd.Descripcion, p.Descripcion)) > 0 )
		)

END

GO

USE BelcorpChile
GO

GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]
	@CampaniaID int,
	@RowCount int,
	@Criterio int,
	@CodigoDescripcion varchar(100),
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@ValidarOPT bit = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp table
(
	CampaniaID int,
	CUV varchar(6),
	Descripcion varchar(250),
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	PrecioOferta numeric(12,2)
)

insert into @OfertaProductoTemp
select 
	op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null
FROM OfertaProducto op with(nolock)
inner join ods.Campania c with(nolock) on
	op.CampaniaID = c.CampaniaID
where
	c.codigo = @CampaniaID

insert into @OfertaProductoTemp    
select op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null    
FROM ShowRoom.OfertaShowRoom op with(nolock)   
inner join ods.Campania c with(nolock) on     
	op.CampaniaID = c.CampaniaID    
where   
	c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp table (CUV varchar(6))

INSERT INTO @ProductoFaltanteTemp
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante with(nolock)
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa with(nolock)
inner join ods.Campania c with(nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
declare @TieneSugerido int = 0
if exists (	
		select 1 from dbo.ProductoSugerido 
		where CampaniaID = @CampaniaID 
			and CUV = @CodigoDescripcion 
			and Estado = 1
)
begin
	set @TieneSugerido = 1
end

	select 
		distinct top (@RowCount) p.CUV,
		coalesce(EST.DescripcionCUV2 + 
		(
			case when @Criterio = 1 then isnull(' '+ tccS.Descripcion, '')
			else '' end
		),
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(	SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 END TieneOfertaRevista,		
		p.PrecioValorizado,
		case 
			when pl.CodigoSAP is null then 0
			else 1 end as TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') as TipoOfertaRevista,
		TE.Codigo as TipoEstrategiaCodigo
	from ods.ProductoComercial p with(nolock)
	left join dbo.ProductoDescripcion pd with(nolock) ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc with(nolock) ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	left join MatrizComercial mc with(nolock) on 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST with(nolock) ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania between EST.CampaniaID and EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tccS with(nolock)
		ON tccS.CUV = p.CUV 
		AND tccS.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE with(nolock) ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M with(nolock) ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl with(nolock) on
		p.CodigoProducto = pl.CodigoSAP
		and p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor with(nolock) ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	where 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		AND (
			(@Criterio = 1 and CHARINDEX(@CodigoDescripcion,p.CUV) > 0 )
			or (@Criterio != 1 and  CHARINDEX(@CodigoDescripcion,coalesce(op.Descripcion,pd.Descripcion, p.Descripcion)) > 0 )
		)

END

GO

USE BelcorpBolivia
GO

GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]
	@CampaniaID int,
	@RowCount int,
	@Criterio int,
	@CodigoDescripcion varchar(100),
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10),
	@ValidarOPT bit = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp table
(
	CampaniaID int,
	CUV varchar(6),
	Descripcion varchar(250),
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	PrecioOferta numeric(12,2)
)

insert into @OfertaProductoTemp
select 
	op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null
FROM OfertaProducto op with(nolock)
inner join ods.Campania c with(nolock) on
	op.CampaniaID = c.CampaniaID
where
	c.codigo = @CampaniaID

insert into @OfertaProductoTemp    
select op.CampaniaID, 
	op.CUV, 
	op.Descripcion, 
	op.ConfiguracionOfertaID, 
	op.TipoOfertaSisID,
	null    
FROM ShowRoom.OfertaShowRoom op with(nolock)   
inner join ods.Campania c with(nolock) on     
	op.CampaniaID = c.CampaniaID    
where   
	c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp table (CUV varchar(6))

INSERT INTO @ProductoFaltanteTemp
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante with(nolock)
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa with(nolock)
inner join ods.Campania c with(nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
declare @TieneSugerido int = 0
if exists (	
		select 1 from dbo.ProductoSugerido 
		where CampaniaID = @CampaniaID 
			and CUV = @CodigoDescripcion 
			and Estado = 1
)
begin
	set @TieneSugerido = 1
end

	select 
		distinct top (@RowCount) p.CUV,
		coalesce(EST.DescripcionCUV2 + 
		(
			case when @Criterio = 1 then isnull(' '+ tccS.Descripcion, '')
			else '' end
		),
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(	SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 END TieneOfertaRevista,		
		p.PrecioValorizado,
		case 
			when pl.CodigoSAP is null then 0
			else 1 end as TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') as TipoOfertaRevista,
		TE.Codigo as TipoEstrategiaCodigo
	from ods.ProductoComercial p with(nolock)
	left join dbo.ProductoDescripcion pd with(nolock) ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc with(nolock) ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	left join MatrizComercial mc with(nolock) on 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST with(nolock) ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania between EST.CampaniaID and EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tccS with(nolock)
		ON tccS.CUV = p.CUV 
		AND tccS.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE with(nolock) ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M with(nolock) ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl with(nolock) on
		p.CodigoProducto = pl.CodigoSAP
		and p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor with(nolock) ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	where 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		AND (
			(@Criterio = 1 and CHARINDEX(@CodigoDescripcion,p.CUV) > 0 )
			or (@Criterio != 1 and  CHARINDEX(@CodigoDescripcion,coalesce(op.Descripcion,pd.Descripcion, p.Descripcion)) > 0 )
		)

END

GO

