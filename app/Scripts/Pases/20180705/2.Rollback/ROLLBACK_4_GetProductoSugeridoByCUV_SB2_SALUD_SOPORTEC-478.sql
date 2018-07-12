USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[GetProductoSugeridoByCUV_SB2]
@CampaniaID int,
@ConsultoraID int,
@CUV varchar(100),
@RegionID int,
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
as
/*
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
GetProductoSugeridoByCUV_SB2 201809, 50131316, '29677', 2002, 2589, '80', '8026'
*/
begin

declare @tablaSugerido table
(
	Orden int,
	ImagenProducto varchar(150),
	CUV varchar(20)
)

insert into @tablaSugerido
select Orden, ImagenProducto, CUVSugerido
from ProductoSugerido
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV
	and Estado = '1'

declare @tablaCUV table(
	CUV varchar(20), Descripcion varchar(100), PrecioCatalogo decimal(18,2), 
	MarcaID int, EstaEnRevista int, TieneStock int, EsExpoOferta int,
	CUVRevista varchar(20), CUVComplemento varchar(20), PaisID int,
	CampaniaID varchar(6), CodigoCatalago varchar(6), CodigoProducto varchar(12),
	IndicadorMontoMinimo int, DescripcionMarca varchar(20), DescripcionCategoria varchar(20),
	DescripcionEstrategia varchar(200), ConfiguracionOfertaID int, TipoOfertaSisID int,
	FlagNueva int, TipoEstrategiaID int, IndicadorOferta bit, TieneSugerido int, TieneOfertaRevista int,
	PrecioValorizado decimal(18,2), TieneLanzamientoCatalogoPersonalizado bit, TipoOfertaRevista VARCHAR(20),
	TipoEstrategiaCodigo varchar(100), EsOfertaIndependiente bit
) 

DECLARE cursorSugerido CURSOR
    FOR SELECT CUV FROM @tablaSugerido
OPEN cursorSugerido
FETCH NEXT FROM cursorSugerido into @CUV

WHILE @@FETCH_STATUS = 0   
BEGIN         

	   insert into @tablaCUV
	   exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 @CampaniaID,1,1,@CUV,@RegionID,@ZonaID,@CodigoRegion,@CodigoZona	   
	   
	   FETCH NEXT FROM cursorSugerido INTO @CUV 
END

--declare @tablaPedidoDetalle table ( CUV varchar(20) )
--insert into @tablaPedidoDetalle
--select pd.CUV from PedidoWeb p
--inner join PedidoWebDetalle pd on
--	p.PedidoID = pd.PedidoID and p.CampaniaID = pd.CampaniaID
--where p.ConsultoraID = @ConsultoraID and p.CampaniaID = @CampaniaID

--Verificar que tenga stock
select
	t.CUV, t.Descripcion, t.PrecioCatalogo, 
	t.MarcaID, t.EstaEnRevista, t.TieneStock, t.EsExpoOferta,
	t.CUVRevista, t.CUVComplemento, t.PaisID,
	t.CampaniaID, t.CodigoCatalago, t.CodigoProducto,
	t.IndicadorMontoMinimo, t.DescripcionMarca, t.DescripcionCategoria,
	t.DescripcionEstrategia, t.ConfiguracionOfertaID, t.TipoOfertaSisID,
	t.FlagNueva, t.TipoEstrategiaID, t.IndicadorOferta, ts.ImagenProducto as ImagenProductoSugerido
from @tablaCUV t
inner join @tablaSugerido ts on
	t.CUV = ts.CUV
where t.TieneStock = 1
	--and t.CUV not in (select CUV from @tablaPedidoDetalle)
order by ts.Orden

END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[GetProductoSugeridoByCUV_SB2]
@CampaniaID int,
@ConsultoraID int,
@CUV varchar(100),
@RegionID int,
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
as
/*
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
*/
begin

declare @tablaSugerido table
(
	Orden int,
	ImagenProducto varchar(150),
	CUV varchar(20)
)

insert into @tablaSugerido
select Orden, ImagenProducto, CUVSugerido
from ProductoSugerido
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV
	and Estado = '1'

declare @tablaCUV table(
	CUV varchar(20), Descripcion varchar(100), PrecioCatalogo decimal(18,2), 
	MarcaID int, EstaEnRevista int, TieneStock int, EsExpoOferta int,
	CUVRevista varchar(20), CUVComplemento varchar(20), PaisID int,
	CampaniaID varchar(6), CodigoCatalago varchar(6), CodigoProducto varchar(12),
	IndicadorMontoMinimo int, DescripcionMarca varchar(20), DescripcionCategoria varchar(20),
	DescripcionEstrategia varchar(200), ConfiguracionOfertaID int, TipoOfertaSisID int,
	FlagNueva int, TipoEstrategiaID int, IndicadorOferta bit, TieneSugerido int, TieneOfertaRevista int,
	PrecioValorizado decimal(18,2), TieneLanzamientoCatalogoPersonalizado bit, TipoOfertaRevista VARCHAR(20),
	TipoEstrategiaCodigo varchar(100), EsOfertaIndependiente bit
) 

DECLARE cursorSugerido CURSOR
    FOR SELECT CUV FROM @tablaSugerido
OPEN cursorSugerido
FETCH NEXT FROM cursorSugerido into @CUV

WHILE @@FETCH_STATUS = 0   
BEGIN         

	   insert into @tablaCUV
	   exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 @CampaniaID,1,1,@CUV,@RegionID,@ZonaID,@CodigoRegion,@CodigoZona	   
	   
	   FETCH NEXT FROM cursorSugerido INTO @CUV 
END

--declare @tablaPedidoDetalle table ( CUV varchar(20) )
--insert into @tablaPedidoDetalle
--select pd.CUV from PedidoWeb p
--inner join PedidoWebDetalle pd on
--	p.PedidoID = pd.PedidoID and p.CampaniaID = pd.CampaniaID
--where p.ConsultoraID = @ConsultoraID and p.CampaniaID = @CampaniaID

--Verificar que tenga stock
select
	t.CUV, t.Descripcion, t.PrecioCatalogo, 
	t.MarcaID, t.EstaEnRevista, t.TieneStock, t.EsExpoOferta,
	t.CUVRevista, t.CUVComplemento, t.PaisID,
	t.CampaniaID, t.CodigoCatalago, t.CodigoProducto,
	t.IndicadorMontoMinimo, t.DescripcionMarca, t.DescripcionCategoria,
	t.DescripcionEstrategia, t.ConfiguracionOfertaID, t.TipoOfertaSisID,
	t.FlagNueva, t.TipoEstrategiaID, t.IndicadorOferta, ts.ImagenProducto as ImagenProductoSugerido
from @tablaCUV t
inner join @tablaSugerido ts on
	t.CUV = ts.CUV
where t.TieneStock = 1
	--and t.CUV not in (select CUV from @tablaPedidoDetalle)
order by ts.Orden

END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[GetProductoSugeridoByCUV_SB2]
@CampaniaID int,
@ConsultoraID int,
@CUV varchar(100),
@RegionID int,
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
as
/*
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
*/
begin

declare @tablaSugerido table
(
	Orden int,
	ImagenProducto varchar(150),
	CUV varchar(20)
)

insert into @tablaSugerido
select Orden, ImagenProducto, CUVSugerido
from ProductoSugerido
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV
	and Estado = '1'

declare @tablaCUV table(
	CUV varchar(20), Descripcion varchar(100), PrecioCatalogo decimal(18,2), 
	MarcaID int, EstaEnRevista int, TieneStock int, EsExpoOferta int,
	CUVRevista varchar(20), CUVComplemento varchar(20), PaisID int,
	CampaniaID varchar(6), CodigoCatalago varchar(6), CodigoProducto varchar(12),
	IndicadorMontoMinimo int, DescripcionMarca varchar(20), DescripcionCategoria varchar(20),
	DescripcionEstrategia varchar(200), ConfiguracionOfertaID int, TipoOfertaSisID int,
	FlagNueva int, TipoEstrategiaID int, IndicadorOferta bit, TieneSugerido int, TieneOfertaRevista int,
	PrecioValorizado decimal(18,2), TieneLanzamientoCatalogoPersonalizado bit, TipoOfertaRevista VARCHAR(20),
	TipoEstrategiaCodigo varchar(100), EsOfertaIndependiente bit
) 

DECLARE cursorSugerido CURSOR
    FOR SELECT CUV FROM @tablaSugerido
OPEN cursorSugerido
FETCH NEXT FROM cursorSugerido into @CUV

WHILE @@FETCH_STATUS = 0   
BEGIN         

	   insert into @tablaCUV
	   exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 @CampaniaID,1,1,@CUV,@RegionID,@ZonaID,@CodigoRegion,@CodigoZona	   
	   
	   FETCH NEXT FROM cursorSugerido INTO @CUV 
END

--declare @tablaPedidoDetalle table ( CUV varchar(20) )
--insert into @tablaPedidoDetalle
--select pd.CUV from PedidoWeb p
--inner join PedidoWebDetalle pd on
--	p.PedidoID = pd.PedidoID and p.CampaniaID = pd.CampaniaID
--where p.ConsultoraID = @ConsultoraID and p.CampaniaID = @CampaniaID

--Verificar que tenga stock
select
	t.CUV, t.Descripcion, t.PrecioCatalogo, 
	t.MarcaID, t.EstaEnRevista, t.TieneStock, t.EsExpoOferta,
	t.CUVRevista, t.CUVComplemento, t.PaisID,
	t.CampaniaID, t.CodigoCatalago, t.CodigoProducto,
	t.IndicadorMontoMinimo, t.DescripcionMarca, t.DescripcionCategoria,
	t.DescripcionEstrategia, t.ConfiguracionOfertaID, t.TipoOfertaSisID,
	t.FlagNueva, t.TipoEstrategiaID, t.IndicadorOferta, ts.ImagenProducto as ImagenProductoSugerido
from @tablaCUV t
inner join @tablaSugerido ts on
	t.CUV = ts.CUV
where t.TieneStock = 1
	--and t.CUV not in (select CUV from @tablaPedidoDetalle)
order by ts.Orden

END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[GetProductoSugeridoByCUV_SB2]
@CampaniaID int,
@ConsultoraID int,
@CUV varchar(100),
@RegionID int,
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
as
/*
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
*/
begin

declare @tablaSugerido table
(
	Orden int,
	ImagenProducto varchar(150),
	CUV varchar(20)
)

insert into @tablaSugerido
select Orden, ImagenProducto, CUVSugerido
from ProductoSugerido
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV
	and Estado = '1'

declare @tablaCUV table(
	CUV varchar(20), Descripcion varchar(100), PrecioCatalogo decimal(18,2), 
	MarcaID int, EstaEnRevista int, TieneStock int, EsExpoOferta int,
	CUVRevista varchar(20), CUVComplemento varchar(20), PaisID int,
	CampaniaID varchar(6), CodigoCatalago varchar(6), CodigoProducto varchar(12),
	IndicadorMontoMinimo int, DescripcionMarca varchar(20), DescripcionCategoria varchar(20),
	DescripcionEstrategia varchar(200), ConfiguracionOfertaID int, TipoOfertaSisID int,
	FlagNueva int, TipoEstrategiaID int, IndicadorOferta bit, TieneSugerido int, TieneOfertaRevista int,
	PrecioValorizado decimal(18,2), TieneLanzamientoCatalogoPersonalizado bit, TipoOfertaRevista VARCHAR(20),
	TipoEstrategiaCodigo varchar(100), EsOfertaIndependiente bit
) 

DECLARE cursorSugerido CURSOR
    FOR SELECT CUV FROM @tablaSugerido
OPEN cursorSugerido
FETCH NEXT FROM cursorSugerido into @CUV

WHILE @@FETCH_STATUS = 0   
BEGIN         

	   insert into @tablaCUV
	   exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 @CampaniaID,1,1,@CUV,@RegionID,@ZonaID,@CodigoRegion,@CodigoZona	   
	   
	   FETCH NEXT FROM cursorSugerido INTO @CUV 
END

--declare @tablaPedidoDetalle table ( CUV varchar(20) )
--insert into @tablaPedidoDetalle
--select pd.CUV from PedidoWeb p
--inner join PedidoWebDetalle pd on
--	p.PedidoID = pd.PedidoID and p.CampaniaID = pd.CampaniaID
--where p.ConsultoraID = @ConsultoraID and p.CampaniaID = @CampaniaID

--Verificar que tenga stock
select
	t.CUV, t.Descripcion, t.PrecioCatalogo, 
	t.MarcaID, t.EstaEnRevista, t.TieneStock, t.EsExpoOferta,
	t.CUVRevista, t.CUVComplemento, t.PaisID,
	t.CampaniaID, t.CodigoCatalago, t.CodigoProducto,
	t.IndicadorMontoMinimo, t.DescripcionMarca, t.DescripcionCategoria,
	t.DescripcionEstrategia, t.ConfiguracionOfertaID, t.TipoOfertaSisID,
	t.FlagNueva, t.TipoEstrategiaID, t.IndicadorOferta, ts.ImagenProducto as ImagenProductoSugerido
from @tablaCUV t
inner join @tablaSugerido ts on
	t.CUV = ts.CUV
where t.TieneStock = 1
	--and t.CUV not in (select CUV from @tablaPedidoDetalle)
order by ts.Orden

END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[GetProductoSugeridoByCUV_SB2]
@CampaniaID int,
@ConsultoraID int,
@CUV varchar(100),
@RegionID int,
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
as
/*
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
*/
begin

declare @tablaSugerido table
(
	Orden int,
	ImagenProducto varchar(150),
	CUV varchar(20)
)

insert into @tablaSugerido
select Orden, ImagenProducto, CUVSugerido
from ProductoSugerido
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV
	and Estado = '1'

declare @tablaCUV table(
	CUV varchar(20), Descripcion varchar(100), PrecioCatalogo decimal(18,2), 
	MarcaID int, EstaEnRevista int, TieneStock int, EsExpoOferta int,
	CUVRevista varchar(20), CUVComplemento varchar(20), PaisID int,
	CampaniaID varchar(6), CodigoCatalago varchar(6), CodigoProducto varchar(12),
	IndicadorMontoMinimo int, DescripcionMarca varchar(20), DescripcionCategoria varchar(20),
	DescripcionEstrategia varchar(200), ConfiguracionOfertaID int, TipoOfertaSisID int,
	FlagNueva int, TipoEstrategiaID int, IndicadorOferta bit, TieneSugerido int, TieneOfertaRevista int,
	PrecioValorizado decimal(18,2), TieneLanzamientoCatalogoPersonalizado bit, TipoOfertaRevista VARCHAR(20),
	TipoEstrategiaCodigo varchar(100), EsOfertaIndependiente bit
) 

DECLARE cursorSugerido CURSOR
    FOR SELECT CUV FROM @tablaSugerido
OPEN cursorSugerido
FETCH NEXT FROM cursorSugerido into @CUV

WHILE @@FETCH_STATUS = 0   
BEGIN         

	   insert into @tablaCUV
	   exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 @CampaniaID,1,1,@CUV,@RegionID,@ZonaID,@CodigoRegion,@CodigoZona	   
	   
	   FETCH NEXT FROM cursorSugerido INTO @CUV 
END

--declare @tablaPedidoDetalle table ( CUV varchar(20) )
--insert into @tablaPedidoDetalle
--select pd.CUV from PedidoWeb p
--inner join PedidoWebDetalle pd on
--	p.PedidoID = pd.PedidoID and p.CampaniaID = pd.CampaniaID
--where p.ConsultoraID = @ConsultoraID and p.CampaniaID = @CampaniaID

--Verificar que tenga stock
select
	t.CUV, t.Descripcion, t.PrecioCatalogo, 
	t.MarcaID, t.EstaEnRevista, t.TieneStock, t.EsExpoOferta,
	t.CUVRevista, t.CUVComplemento, t.PaisID,
	t.CampaniaID, t.CodigoCatalago, t.CodigoProducto,
	t.IndicadorMontoMinimo, t.DescripcionMarca, t.DescripcionCategoria,
	t.DescripcionEstrategia, t.ConfiguracionOfertaID, t.TipoOfertaSisID,
	t.FlagNueva, t.TipoEstrategiaID, t.IndicadorOferta, ts.ImagenProducto as ImagenProductoSugerido
from @tablaCUV t
inner join @tablaSugerido ts on
	t.CUV = ts.CUV
where t.TieneStock = 1
	--and t.CUV not in (select CUV from @tablaPedidoDetalle)
order by ts.Orden

END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[GetProductoSugeridoByCUV_SB2]
@CampaniaID int,
@ConsultoraID int,
@CUV varchar(100),
@RegionID int,
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
as
/*
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
*/
begin

declare @tablaSugerido table
(
	Orden int,
	ImagenProducto varchar(150),
	CUV varchar(20)
)

insert into @tablaSugerido
select Orden, ImagenProducto, CUVSugerido
from ProductoSugerido
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV
	and Estado = '1'

declare @tablaCUV table(
	CUV varchar(20), Descripcion varchar(100), PrecioCatalogo decimal(18,2), 
	MarcaID int, EstaEnRevista int, TieneStock int, EsExpoOferta int,
	CUVRevista varchar(20), CUVComplemento varchar(20), PaisID int,
	CampaniaID varchar(6), CodigoCatalago varchar(6), CodigoProducto varchar(12),
	IndicadorMontoMinimo int, DescripcionMarca varchar(20), DescripcionCategoria varchar(20),
	DescripcionEstrategia varchar(200), ConfiguracionOfertaID int, TipoOfertaSisID int,
	FlagNueva int, TipoEstrategiaID int, IndicadorOferta bit, TieneSugerido int, TieneOfertaRevista int,
	PrecioValorizado decimal(18,2), TieneLanzamientoCatalogoPersonalizado bit, TipoOfertaRevista VARCHAR(20),
	TipoEstrategiaCodigo varchar(100), EsOfertaIndependiente bit
) 

DECLARE cursorSugerido CURSOR
    FOR SELECT CUV FROM @tablaSugerido
OPEN cursorSugerido
FETCH NEXT FROM cursorSugerido into @CUV

WHILE @@FETCH_STATUS = 0   
BEGIN         

	   insert into @tablaCUV
	   exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 @CampaniaID,1,1,@CUV,@RegionID,@ZonaID,@CodigoRegion,@CodigoZona	   
	   
	   FETCH NEXT FROM cursorSugerido INTO @CUV 
END

--declare @tablaPedidoDetalle table ( CUV varchar(20) )
--insert into @tablaPedidoDetalle
--select pd.CUV from PedidoWeb p
--inner join PedidoWebDetalle pd on
--	p.PedidoID = pd.PedidoID and p.CampaniaID = pd.CampaniaID
--where p.ConsultoraID = @ConsultoraID and p.CampaniaID = @CampaniaID

--Verificar que tenga stock
select
	t.CUV, t.Descripcion, t.PrecioCatalogo, 
	t.MarcaID, t.EstaEnRevista, t.TieneStock, t.EsExpoOferta,
	t.CUVRevista, t.CUVComplemento, t.PaisID,
	t.CampaniaID, t.CodigoCatalago, t.CodigoProducto,
	t.IndicadorMontoMinimo, t.DescripcionMarca, t.DescripcionCategoria,
	t.DescripcionEstrategia, t.ConfiguracionOfertaID, t.TipoOfertaSisID,
	t.FlagNueva, t.TipoEstrategiaID, t.IndicadorOferta, ts.ImagenProducto as ImagenProductoSugerido
from @tablaCUV t
inner join @tablaSugerido ts on
	t.CUV = ts.CUV
where t.TieneStock = 1
	--and t.CUV not in (select CUV from @tablaPedidoDetalle)
order by ts.Orden

END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[GetProductoSugeridoByCUV_SB2]
@CampaniaID int,
@ConsultoraID int,
@CUV varchar(100),
@RegionID int,
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
as
/*
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
*/
begin

declare @tablaSugerido table
(
	Orden int,
	ImagenProducto varchar(150),
	CUV varchar(20)
)

insert into @tablaSugerido
select Orden, ImagenProducto, CUVSugerido
from ProductoSugerido
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV
	and Estado = '1'

declare @tablaCUV table(
	CUV varchar(20), Descripcion varchar(100), PrecioCatalogo decimal(18,2), 
	MarcaID int, EstaEnRevista int, TieneStock int, EsExpoOferta int,
	CUVRevista varchar(20), CUVComplemento varchar(20), PaisID int,
	CampaniaID varchar(6), CodigoCatalago varchar(6), CodigoProducto varchar(12),
	IndicadorMontoMinimo int, DescripcionMarca varchar(20), DescripcionCategoria varchar(20),
	DescripcionEstrategia varchar(200), ConfiguracionOfertaID int, TipoOfertaSisID int,
	FlagNueva int, TipoEstrategiaID int, IndicadorOferta bit, TieneSugerido int, TieneOfertaRevista int,
	PrecioValorizado decimal(18,2), TieneLanzamientoCatalogoPersonalizado bit, TipoOfertaRevista VARCHAR(20),
	TipoEstrategiaCodigo varchar(100), EsOfertaIndependiente bit
) 

DECLARE cursorSugerido CURSOR
    FOR SELECT CUV FROM @tablaSugerido
OPEN cursorSugerido
FETCH NEXT FROM cursorSugerido into @CUV

WHILE @@FETCH_STATUS = 0   
BEGIN         

	   insert into @tablaCUV
	   exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 @CampaniaID,1,1,@CUV,@RegionID,@ZonaID,@CodigoRegion,@CodigoZona	   
	   
	   FETCH NEXT FROM cursorSugerido INTO @CUV 
END

--declare @tablaPedidoDetalle table ( CUV varchar(20) )
--insert into @tablaPedidoDetalle
--select pd.CUV from PedidoWeb p
--inner join PedidoWebDetalle pd on
--	p.PedidoID = pd.PedidoID and p.CampaniaID = pd.CampaniaID
--where p.ConsultoraID = @ConsultoraID and p.CampaniaID = @CampaniaID

--Verificar que tenga stock
select
	t.CUV, t.Descripcion, t.PrecioCatalogo, 
	t.MarcaID, t.EstaEnRevista, t.TieneStock, t.EsExpoOferta,
	t.CUVRevista, t.CUVComplemento, t.PaisID,
	t.CampaniaID, t.CodigoCatalago, t.CodigoProducto,
	t.IndicadorMontoMinimo, t.DescripcionMarca, t.DescripcionCategoria,
	t.DescripcionEstrategia, t.ConfiguracionOfertaID, t.TipoOfertaSisID,
	t.FlagNueva, t.TipoEstrategiaID, t.IndicadorOferta, ts.ImagenProducto as ImagenProductoSugerido
from @tablaCUV t
inner join @tablaSugerido ts on
	t.CUV = ts.CUV
where t.TieneStock = 1
	--and t.CUV not in (select CUV from @tablaPedidoDetalle)
order by ts.Orden

END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[GetProductoSugeridoByCUV_SB2]
@CampaniaID int,
@ConsultoraID int,
@CUV varchar(100),
@RegionID int,
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
as
/*
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
*/
begin

declare @tablaSugerido table
(
	Orden int,
	ImagenProducto varchar(150),
	CUV varchar(20)
)

insert into @tablaSugerido
select Orden, ImagenProducto, CUVSugerido
from ProductoSugerido
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV
	and Estado = '1'

declare @tablaCUV table(
	CUV varchar(20), Descripcion varchar(100), PrecioCatalogo decimal(18,2), 
	MarcaID int, EstaEnRevista int, TieneStock int, EsExpoOferta int,
	CUVRevista varchar(20), CUVComplemento varchar(20), PaisID int,
	CampaniaID varchar(6), CodigoCatalago varchar(6), CodigoProducto varchar(12),
	IndicadorMontoMinimo int, DescripcionMarca varchar(20), DescripcionCategoria varchar(20),
	DescripcionEstrategia varchar(200), ConfiguracionOfertaID int, TipoOfertaSisID int,
	FlagNueva int, TipoEstrategiaID int, IndicadorOferta bit, TieneSugerido int, TieneOfertaRevista int,
	PrecioValorizado decimal(18,2), TieneLanzamientoCatalogoPersonalizado bit, TipoOfertaRevista VARCHAR(20),
	TipoEstrategiaCodigo varchar(100), EsOfertaIndependiente bit
) 

DECLARE cursorSugerido CURSOR
    FOR SELECT CUV FROM @tablaSugerido
OPEN cursorSugerido
FETCH NEXT FROM cursorSugerido into @CUV

WHILE @@FETCH_STATUS = 0   
BEGIN         

	   insert into @tablaCUV
	   exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 @CampaniaID,1,1,@CUV,@RegionID,@ZonaID,@CodigoRegion,@CodigoZona	   
	   
	   FETCH NEXT FROM cursorSugerido INTO @CUV 
END

--declare @tablaPedidoDetalle table ( CUV varchar(20) )
--insert into @tablaPedidoDetalle
--select pd.CUV from PedidoWeb p
--inner join PedidoWebDetalle pd on
--	p.PedidoID = pd.PedidoID and p.CampaniaID = pd.CampaniaID
--where p.ConsultoraID = @ConsultoraID and p.CampaniaID = @CampaniaID

--Verificar que tenga stock
select
	t.CUV, t.Descripcion, t.PrecioCatalogo, 
	t.MarcaID, t.EstaEnRevista, t.TieneStock, t.EsExpoOferta,
	t.CUVRevista, t.CUVComplemento, t.PaisID,
	t.CampaniaID, t.CodigoCatalago, t.CodigoProducto,
	t.IndicadorMontoMinimo, t.DescripcionMarca, t.DescripcionCategoria,
	t.DescripcionEstrategia, t.ConfiguracionOfertaID, t.TipoOfertaSisID,
	t.FlagNueva, t.TipoEstrategiaID, t.IndicadorOferta, ts.ImagenProducto as ImagenProductoSugerido
from @tablaCUV t
inner join @tablaSugerido ts on
	t.CUV = ts.CUV
where t.TieneStock = 1
	--and t.CUV not in (select CUV from @tablaPedidoDetalle)
order by ts.Orden

END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[GetProductoSugeridoByCUV_SB2]
@CampaniaID int,
@ConsultoraID int,
@CUV varchar(100),
@RegionID int,
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
as
/*
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
*/
begin

declare @tablaSugerido table
(
	Orden int,
	ImagenProducto varchar(150),
	CUV varchar(20)
)

insert into @tablaSugerido
select Orden, ImagenProducto, CUVSugerido
from ProductoSugerido
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV
	and Estado = '1'

declare @tablaCUV table(
	CUV varchar(20), Descripcion varchar(100), PrecioCatalogo decimal(18,2), 
	MarcaID int, EstaEnRevista int, TieneStock int, EsExpoOferta int,
	CUVRevista varchar(20), CUVComplemento varchar(20), PaisID int,
	CampaniaID varchar(6), CodigoCatalago varchar(6), CodigoProducto varchar(12),
	IndicadorMontoMinimo int, DescripcionMarca varchar(20), DescripcionCategoria varchar(20),
	DescripcionEstrategia varchar(200), ConfiguracionOfertaID int, TipoOfertaSisID int,
	FlagNueva int, TipoEstrategiaID int, IndicadorOferta bit, TieneSugerido int, TieneOfertaRevista int,
	PrecioValorizado decimal(18,2), TieneLanzamientoCatalogoPersonalizado bit, TipoOfertaRevista VARCHAR(20),
	TipoEstrategiaCodigo varchar(100), EsOfertaIndependiente bit
) 

DECLARE cursorSugerido CURSOR
    FOR SELECT CUV FROM @tablaSugerido
OPEN cursorSugerido
FETCH NEXT FROM cursorSugerido into @CUV

WHILE @@FETCH_STATUS = 0   
BEGIN         

	   insert into @tablaCUV
	   exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 @CampaniaID,1,1,@CUV,@RegionID,@ZonaID,@CodigoRegion,@CodigoZona	   
	   
	   FETCH NEXT FROM cursorSugerido INTO @CUV 
END

--declare @tablaPedidoDetalle table ( CUV varchar(20) )
--insert into @tablaPedidoDetalle
--select pd.CUV from PedidoWeb p
--inner join PedidoWebDetalle pd on
--	p.PedidoID = pd.PedidoID and p.CampaniaID = pd.CampaniaID
--where p.ConsultoraID = @ConsultoraID and p.CampaniaID = @CampaniaID

--Verificar que tenga stock
select
	t.CUV, t.Descripcion, t.PrecioCatalogo, 
	t.MarcaID, t.EstaEnRevista, t.TieneStock, t.EsExpoOferta,
	t.CUVRevista, t.CUVComplemento, t.PaisID,
	t.CampaniaID, t.CodigoCatalago, t.CodigoProducto,
	t.IndicadorMontoMinimo, t.DescripcionMarca, t.DescripcionCategoria,
	t.DescripcionEstrategia, t.ConfiguracionOfertaID, t.TipoOfertaSisID,
	t.FlagNueva, t.TipoEstrategiaID, t.IndicadorOferta, ts.ImagenProducto as ImagenProductoSugerido
from @tablaCUV t
inner join @tablaSugerido ts on
	t.CUV = ts.CUV
where t.TieneStock = 1
	--and t.CUV not in (select CUV from @tablaPedidoDetalle)
order by ts.Orden

END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetProductoSugeridoByCUV_SB2]
@CampaniaID int,
@ConsultoraID int,
@CUV varchar(100),
@RegionID int,
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
as
/*
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
*/
begin

declare @tablaSugerido table
(
	Orden int,
	ImagenProducto varchar(150),
	CUV varchar(20)
)

insert into @tablaSugerido
select Orden, ImagenProducto, CUVSugerido
from ProductoSugerido
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV
	and Estado = '1'

declare @tablaCUV table(
	CUV varchar(20), Descripcion varchar(100), PrecioCatalogo decimal(18,2), 
	MarcaID int, EstaEnRevista int, TieneStock int, EsExpoOferta int,
	CUVRevista varchar(20), CUVComplemento varchar(20), PaisID int,
	CampaniaID varchar(6), CodigoCatalago varchar(6), CodigoProducto varchar(12),
	IndicadorMontoMinimo int, DescripcionMarca varchar(20), DescripcionCategoria varchar(20),
	DescripcionEstrategia varchar(200), ConfiguracionOfertaID int, TipoOfertaSisID int,
	FlagNueva int, TipoEstrategiaID int, IndicadorOferta bit, TieneSugerido int, TieneOfertaRevista int,
	PrecioValorizado decimal(18,2), TieneLanzamientoCatalogoPersonalizado bit, TipoOfertaRevista VARCHAR(20),
	TipoEstrategiaCodigo varchar(100), EsOfertaIndependiente bit
) 

DECLARE cursorSugerido CURSOR
    FOR SELECT CUV FROM @tablaSugerido
OPEN cursorSugerido
FETCH NEXT FROM cursorSugerido into @CUV

WHILE @@FETCH_STATUS = 0   
BEGIN         

	   insert into @tablaCUV
	   exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 @CampaniaID,1,1,@CUV,@RegionID,@ZonaID,@CodigoRegion,@CodigoZona	   
	   
	   FETCH NEXT FROM cursorSugerido INTO @CUV 
END

--declare @tablaPedidoDetalle table ( CUV varchar(20) )
--insert into @tablaPedidoDetalle
--select pd.CUV from PedidoWeb p
--inner join PedidoWebDetalle pd on
--	p.PedidoID = pd.PedidoID and p.CampaniaID = pd.CampaniaID
--where p.ConsultoraID = @ConsultoraID and p.CampaniaID = @CampaniaID

--Verificar que tenga stock
select
	t.CUV, t.Descripcion, t.PrecioCatalogo, 
	t.MarcaID, t.EstaEnRevista, t.TieneStock, t.EsExpoOferta,
	t.CUVRevista, t.CUVComplemento, t.PaisID,
	t.CampaniaID, t.CodigoCatalago, t.CodigoProducto,
	t.IndicadorMontoMinimo, t.DescripcionMarca, t.DescripcionCategoria,
	t.DescripcionEstrategia, t.ConfiguracionOfertaID, t.TipoOfertaSisID,
	t.FlagNueva, t.TipoEstrategiaID, t.IndicadorOferta, ts.ImagenProducto as ImagenProductoSugerido
from @tablaCUV t
inner join @tablaSugerido ts on
	t.CUV = ts.CUV
where t.TieneStock = 1
	--and t.CUV not in (select CUV from @tablaPedidoDetalle)
order by ts.Orden

END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[GetProductoSugeridoByCUV_SB2]
@CampaniaID int,
@ConsultoraID int,
@CUV varchar(100),
@RegionID int,
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
as
/*
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
*/
begin

declare @tablaSugerido table
(
	Orden int,
	ImagenProducto varchar(150),
	CUV varchar(20)
)

insert into @tablaSugerido
select Orden, ImagenProducto, CUVSugerido
from ProductoSugerido
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV
	and Estado = '1'

declare @tablaCUV table(
	CUV varchar(20), Descripcion varchar(100), PrecioCatalogo decimal(18,2), 
	MarcaID int, EstaEnRevista int, TieneStock int, EsExpoOferta int,
	CUVRevista varchar(20), CUVComplemento varchar(20), PaisID int,
	CampaniaID varchar(6), CodigoCatalago varchar(6), CodigoProducto varchar(12),
	IndicadorMontoMinimo int, DescripcionMarca varchar(20), DescripcionCategoria varchar(20),
	DescripcionEstrategia varchar(200), ConfiguracionOfertaID int, TipoOfertaSisID int,
	FlagNueva int, TipoEstrategiaID int, IndicadorOferta bit, TieneSugerido int, TieneOfertaRevista int,
	PrecioValorizado decimal(18,2), TieneLanzamientoCatalogoPersonalizado bit, TipoOfertaRevista VARCHAR(20),
	TipoEstrategiaCodigo varchar(100), EsOfertaIndependiente bit
) 

DECLARE cursorSugerido CURSOR
    FOR SELECT CUV FROM @tablaSugerido
OPEN cursorSugerido
FETCH NEXT FROM cursorSugerido into @CUV

WHILE @@FETCH_STATUS = 0   
BEGIN         

	   insert into @tablaCUV
	   exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 @CampaniaID,1,1,@CUV,@RegionID,@ZonaID,@CodigoRegion,@CodigoZona	   
	   
	   FETCH NEXT FROM cursorSugerido INTO @CUV 
END

--declare @tablaPedidoDetalle table ( CUV varchar(20) )
--insert into @tablaPedidoDetalle
--select pd.CUV from PedidoWeb p
--inner join PedidoWebDetalle pd on
--	p.PedidoID = pd.PedidoID and p.CampaniaID = pd.CampaniaID
--where p.ConsultoraID = @ConsultoraID and p.CampaniaID = @CampaniaID

--Verificar que tenga stock
select
	t.CUV, t.Descripcion, t.PrecioCatalogo, 
	t.MarcaID, t.EstaEnRevista, t.TieneStock, t.EsExpoOferta,
	t.CUVRevista, t.CUVComplemento, t.PaisID,
	t.CampaniaID, t.CodigoCatalago, t.CodigoProducto,
	t.IndicadorMontoMinimo, t.DescripcionMarca, t.DescripcionCategoria,
	t.DescripcionEstrategia, t.ConfiguracionOfertaID, t.TipoOfertaSisID,
	t.FlagNueva, t.TipoEstrategiaID, t.IndicadorOferta, ts.ImagenProducto as ImagenProductoSugerido
from @tablaCUV t
inner join @tablaSugerido ts on
	t.CUV = ts.CUV
where t.TieneStock = 1
	--and t.CUV not in (select CUV from @tablaPedidoDetalle)
order by ts.Orden

END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[GetProductoSugeridoByCUV_SB2]
@CampaniaID int,
@ConsultoraID int,
@CUV varchar(100),
@RegionID int,
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
as
/*
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
dbo.GetProductoSugeridoByCUV_SB2 201614,2,'00040',2701,2161,'50','5052'
*/
begin

declare @tablaSugerido table
(
	Orden int,
	ImagenProducto varchar(150),
	CUV varchar(20)
)

insert into @tablaSugerido
select Orden, ImagenProducto, CUVSugerido
from ProductoSugerido
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV
	and Estado = '1'

declare @tablaCUV table(
	CUV varchar(20), Descripcion varchar(100), PrecioCatalogo decimal(18,2), 
	MarcaID int, EstaEnRevista int, TieneStock int, EsExpoOferta int,
	CUVRevista varchar(20), CUVComplemento varchar(20), PaisID int,
	CampaniaID varchar(6), CodigoCatalago varchar(6), CodigoProducto varchar(12),
	IndicadorMontoMinimo int, DescripcionMarca varchar(20), DescripcionCategoria varchar(20),
	DescripcionEstrategia varchar(200), ConfiguracionOfertaID int, TipoOfertaSisID int,
	FlagNueva int, TipoEstrategiaID int, IndicadorOferta bit, TieneSugerido int, TieneOfertaRevista int,
	PrecioValorizado decimal(18,2), TieneLanzamientoCatalogoPersonalizado bit, TipoOfertaRevista VARCHAR(20),
	TipoEstrategiaCodigo varchar(100), EsOfertaIndependiente bit
) 

DECLARE cursorSugerido CURSOR
    FOR SELECT CUV FROM @tablaSugerido
OPEN cursorSugerido
FETCH NEXT FROM cursorSugerido into @CUV

WHILE @@FETCH_STATUS = 0   
BEGIN         

	   insert into @tablaCUV
	   exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 @CampaniaID,1,1,@CUV,@RegionID,@ZonaID,@CodigoRegion,@CodigoZona	   
	   
	   FETCH NEXT FROM cursorSugerido INTO @CUV 
END

--declare @tablaPedidoDetalle table ( CUV varchar(20) )
--insert into @tablaPedidoDetalle
--select pd.CUV from PedidoWeb p
--inner join PedidoWebDetalle pd on
--	p.PedidoID = pd.PedidoID and p.CampaniaID = pd.CampaniaID
--where p.ConsultoraID = @ConsultoraID and p.CampaniaID = @CampaniaID

--Verificar que tenga stock
select
	t.CUV, t.Descripcion, t.PrecioCatalogo, 
	t.MarcaID, t.EstaEnRevista, t.TieneStock, t.EsExpoOferta,
	t.CUVRevista, t.CUVComplemento, t.PaisID,
	t.CampaniaID, t.CodigoCatalago, t.CodigoProducto,
	t.IndicadorMontoMinimo, t.DescripcionMarca, t.DescripcionCategoria,
	t.DescripcionEstrategia, t.ConfiguracionOfertaID, t.TipoOfertaSisID,
	t.FlagNueva, t.TipoEstrategiaID, t.IndicadorOferta, ts.ImagenProducto as ImagenProductoSugerido
from @tablaCUV t
inner join @tablaSugerido ts on
	t.CUV = ts.CUV
where t.TieneStock = 1
	--and t.CUV not in (select CUV from @tablaPedidoDetalle)
order by ts.Orden

END
GO

