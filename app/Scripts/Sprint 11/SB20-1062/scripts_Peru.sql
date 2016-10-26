USE [BelcorpPeru]
GO

ALTER procedure [ShowRoom].[GetProductosShowRoom]
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201616
*/
begin

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	0 as ConfiguracionOfertaID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	'' as TipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoAcceso = 'SH'
	AND CA.Codigo = @CampaniaID
ORDER BY OS.CUV desc

end

