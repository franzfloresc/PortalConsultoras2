
USE BelcorpBolivia
GO

UPDATE os
SET os.PrecioOferta2 = pc.PrecioCatalogo
FROM ShowRoom.OfertaShowRoom os 
INNER JOIN ods.ProductoComercial pc ON pc.CampaniaID = os.CampaniaID
	AND os.CUV = pc.CUV
	AND pc.IndicadorDigitable = 1
WHERE os.CampaniaID > 2978 AND ISNULL(os.PrecioOferta2,0) = 0
AND os.TipoOfertaSisID = 1707
GO

/*end*/

USE BelcorpChile
GO

UPDATE os
SET os.PrecioOferta2 = pc.PrecioCatalogo
FROM ShowRoom.OfertaShowRoom os 
INNER JOIN ods.ProductoComercial pc ON pc.CampaniaID = os.CampaniaID
	AND os.CUV = pc.CUV
	AND pc.IndicadorDigitable = 1
WHERE os.CampaniaID > 2978 AND ISNULL(os.PrecioOferta2,0) = 0
AND os.TipoOfertaSisID = 1707
GO

/*end*/

USE BelcorpColombia
GO

UPDATE os
SET os.PrecioOferta2 = pc.PrecioCatalogo
FROM ShowRoom.OfertaShowRoom os 
INNER JOIN ods.ProductoComercial pc ON pc.CampaniaID = os.CampaniaID
	AND os.CUV = pc.CUV
	AND pc.IndicadorDigitable = 1
WHERE os.CampaniaID > 2978 AND ISNULL(os.PrecioOferta2,0) = 0
AND os.TipoOfertaSisID = 1707
GO

/*end*/

USE BelcorpCostaRica
GO

UPDATE os
SET os.PrecioOferta2 = pc.PrecioCatalogo
FROM ShowRoom.OfertaShowRoom os 
INNER JOIN ods.ProductoComercial pc ON pc.CampaniaID = os.CampaniaID
	AND os.CUV = pc.CUV
	AND pc.IndicadorDigitable = 1
WHERE os.CampaniaID > 2978 AND ISNULL(os.PrecioOferta2,0) = 0
AND os.TipoOfertaSisID = 1707
GO

/*end*/

USE BelcorpDominicana
GO

UPDATE os
SET os.PrecioOferta2 = pc.PrecioCatalogo
FROM ShowRoom.OfertaShowRoom os 
INNER JOIN ods.ProductoComercial pc ON pc.CampaniaID = os.CampaniaID
	AND os.CUV = pc.CUV
	AND pc.IndicadorDigitable = 1
WHERE os.CampaniaID > 2978 AND ISNULL(os.PrecioOferta2,0) = 0
AND os.TipoOfertaSisID = 1707
GO

/*end*/

USE BelcorpEcuador
GO

UPDATE os
SET os.PrecioOferta2 = pc.PrecioCatalogo
FROM ShowRoom.OfertaShowRoom os 
INNER JOIN ods.ProductoComercial pc ON pc.CampaniaID = os.CampaniaID
	AND os.CUV = pc.CUV
	AND pc.IndicadorDigitable = 1
WHERE os.CampaniaID > 2978 AND ISNULL(os.PrecioOferta2,0) = 0
AND os.TipoOfertaSisID = 1707
GO

/*end*/

USE BelcorpGuatemala
GO

UPDATE os
SET os.PrecioOferta2 = pc.PrecioCatalogo
FROM ShowRoom.OfertaShowRoom os 
INNER JOIN ods.ProductoComercial pc ON pc.CampaniaID = os.CampaniaID
	AND os.CUV = pc.CUV
	AND pc.IndicadorDigitable = 1
WHERE os.CampaniaID > 2978 AND ISNULL(os.PrecioOferta2,0) = 0
AND os.TipoOfertaSisID = 1707
GO

/*end*/

USE BelcorpMexico
GO

UPDATE os
SET os.PrecioOferta2 = pc.PrecioCatalogo
FROM ShowRoom.OfertaShowRoom os 
INNER JOIN ods.ProductoComercial pc ON pc.CampaniaID = os.CampaniaID
	AND os.CUV = pc.CUV
	AND pc.IndicadorDigitable = 1
WHERE os.CampaniaID > 2978 AND ISNULL(os.PrecioOferta2,0) = 0
AND os.TipoOfertaSisID = 1707
GO

/*end*/

USE BelcorpPanama
GO

UPDATE os
SET os.PrecioOferta2 = pc.PrecioCatalogo
FROM ShowRoom.OfertaShowRoom os 
INNER JOIN ods.ProductoComercial pc ON pc.CampaniaID = os.CampaniaID
	AND os.CUV = pc.CUV
	AND pc.IndicadorDigitable = 1
WHERE os.CampaniaID > 2978 AND ISNULL(os.PrecioOferta2,0) = 0
AND os.TipoOfertaSisID = 1707
GO

/*end*/

USE BelcorpPeru
GO

UPDATE os
SET os.PrecioOferta2 = pc.PrecioCatalogo
FROM ShowRoom.OfertaShowRoom os 
INNER JOIN ods.ProductoComercial pc ON pc.CampaniaID = os.CampaniaID
	AND os.CUV = pc.CUV
	AND pc.IndicadorDigitable = 1
WHERE os.CampaniaID > 2978 AND ISNULL(os.PrecioOferta2,0) = 0
AND os.TipoOfertaSisID = 1707
GO

/*end*/

USE BelcorpPuertoRico
GO

UPDATE os
SET os.PrecioOferta2 = pc.PrecioCatalogo
FROM ShowRoom.OfertaShowRoom os 
INNER JOIN ods.ProductoComercial pc ON pc.CampaniaID = os.CampaniaID
	AND os.CUV = pc.CUV
	AND pc.IndicadorDigitable = 1
WHERE os.CampaniaID > 2978 AND ISNULL(os.PrecioOferta2,0) = 0
AND os.TipoOfertaSisID = 1707
GO

/*end*/

USE BelcorpSalvador
GO

UPDATE os
SET os.PrecioOferta2 = pc.PrecioCatalogo
FROM ShowRoom.OfertaShowRoom os 
INNER JOIN ods.ProductoComercial pc ON pc.CampaniaID = os.CampaniaID
	AND os.CUV = pc.CUV
	AND pc.IndicadorDigitable = 1
WHERE os.CampaniaID > 2978 AND ISNULL(os.PrecioOferta2,0) = 0
AND os.TipoOfertaSisID = 1707
GO

/*end*/

USE BelcorpVenezuela
GO

UPDATE os
SET os.PrecioOferta2 = pc.PrecioCatalogo
FROM ShowRoom.OfertaShowRoom os 
INNER JOIN ods.ProductoComercial pc ON pc.CampaniaID = os.CampaniaID
	AND os.CUV = pc.CUV
	AND pc.IndicadorDigitable = 1
WHERE os.CampaniaID > 2978 AND ISNULL(os.PrecioOferta2,0) = 0
AND os.TipoOfertaSisID = 1707
GO
