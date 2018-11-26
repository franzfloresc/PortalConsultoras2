USE BelcorpPeru
GO

ALTER PROCEDURE GetOfertasPortal_2_SB2
@TipoOfertaSisID int,
@DuplaConsultora int,
@CodigoCampania int,
@Offset int,
@CantidadRegistros int
AS
/*
GetOfertasPortal 1702, 100, 201414
*/
BEGIN
SET NOCOUNT ON
-- Depuramos las tallas y colores
EXEC DepurarTallaColorLiquidacion @CodigoCampania

if @TipoOfertaSisID = 1701
BEGIN
if @DuplaConsultora = 1
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469 - JICM Nuevos Campos marcación
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
-- LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
-- LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
--LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
AND ConfiguracionOfertaID != 2
and CodigoOferta = pc.CodigoTipoOferta )

ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY

END
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
CASE
WHEN tcl.DescripcionCUV IS NOT NULL THEN tcl.DescripcionCUV
ELSE OP.Descripcion END Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
dbo.FiltrarTallaColorLiquidacion_2_SB2(op.CUV, CA.Codigo) TallaColor,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
left join TallaColorLiquidacion tcl with(nolock)
on tcl.CUV = pc.CUV and tcl.CampaniaID = pc.AnoCampania
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND OP.Stock > 0
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE GetOfertasPortal_2_SB2
@TipoOfertaSisID int,
@DuplaConsultora int,
@CodigoCampania int,
@Offset int,
@CantidadRegistros int
AS
/*
GetOfertasPortal 1702, 100, 201414
*/
BEGIN
SET NOCOUNT ON
-- Depuramos las tallas y colores
EXEC DepurarTallaColorLiquidacion @CodigoCampania

if @TipoOfertaSisID = 1701
BEGIN
if @DuplaConsultora = 1
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469 - JICM Nuevos Campos marcación
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
-- LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
-- LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
--LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
AND ConfiguracionOfertaID != 2
and CodigoOferta = pc.CodigoTipoOferta )

ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY

END
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
CASE
WHEN tcl.DescripcionCUV IS NOT NULL THEN tcl.DescripcionCUV
ELSE OP.Descripcion END Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
dbo.FiltrarTallaColorLiquidacion_2_SB2(op.CUV, CA.Codigo) TallaColor,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
left join TallaColorLiquidacion tcl with(nolock)
on tcl.CUV = pc.CUV and tcl.CampaniaID = pc.AnoCampania
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND OP.Stock > 0
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE GetOfertasPortal_2_SB2
@TipoOfertaSisID int,
@DuplaConsultora int,
@CodigoCampania int,
@Offset int,
@CantidadRegistros int
AS
/*
GetOfertasPortal 1702, 100, 201414
*/
BEGIN
SET NOCOUNT ON
-- Depuramos las tallas y colores
EXEC DepurarTallaColorLiquidacion @CodigoCampania

if @TipoOfertaSisID = 1701
BEGIN
if @DuplaConsultora = 1
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469 - JICM Nuevos Campos marcación
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
-- LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
-- LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
--LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
AND ConfiguracionOfertaID != 2
and CodigoOferta = pc.CodigoTipoOferta )

ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY

END
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
CASE
WHEN tcl.DescripcionCUV IS NOT NULL THEN tcl.DescripcionCUV
ELSE OP.Descripcion END Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
dbo.FiltrarTallaColorLiquidacion_2_SB2(op.CUV, CA.Codigo) TallaColor,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
left join TallaColorLiquidacion tcl with(nolock)
on tcl.CUV = pc.CUV and tcl.CampaniaID = pc.AnoCampania
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND OP.Stock > 0
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE GetOfertasPortal_2_SB2
@TipoOfertaSisID int,
@DuplaConsultora int,
@CodigoCampania int,
@Offset int,
@CantidadRegistros int
AS
/*
GetOfertasPortal 1702, 100, 201414
*/
BEGIN
SET NOCOUNT ON
-- Depuramos las tallas y colores
EXEC DepurarTallaColorLiquidacion @CodigoCampania

if @TipoOfertaSisID = 1701
BEGIN
if @DuplaConsultora = 1
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469 - JICM Nuevos Campos marcación
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
-- LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
-- LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
--LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
AND ConfiguracionOfertaID != 2
and CodigoOferta = pc.CodigoTipoOferta )

ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY

END
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
CASE
WHEN tcl.DescripcionCUV IS NOT NULL THEN tcl.DescripcionCUV
ELSE OP.Descripcion END Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
dbo.FiltrarTallaColorLiquidacion_2_SB2(op.CUV, CA.Codigo) TallaColor,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
left join TallaColorLiquidacion tcl with(nolock)
on tcl.CUV = pc.CUV and tcl.CampaniaID = pc.AnoCampania
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND OP.Stock > 0
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE GetOfertasPortal_2_SB2
@TipoOfertaSisID int,
@DuplaConsultora int,
@CodigoCampania int,
@Offset int,
@CantidadRegistros int
AS
/*
GetOfertasPortal 1702, 100, 201414
*/
BEGIN
SET NOCOUNT ON
-- Depuramos las tallas y colores
EXEC DepurarTallaColorLiquidacion @CodigoCampania

if @TipoOfertaSisID = 1701
BEGIN
if @DuplaConsultora = 1
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469 - JICM Nuevos Campos marcación
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
-- LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
-- LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
--LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
AND ConfiguracionOfertaID != 2
and CodigoOferta = pc.CodigoTipoOferta )

ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY

END
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
CASE
WHEN tcl.DescripcionCUV IS NOT NULL THEN tcl.DescripcionCUV
ELSE OP.Descripcion END Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
dbo.FiltrarTallaColorLiquidacion_2_SB2(op.CUV, CA.Codigo) TallaColor,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
left join TallaColorLiquidacion tcl with(nolock)
on tcl.CUV = pc.CUV and tcl.CampaniaID = pc.AnoCampania
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND OP.Stock > 0
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE GetOfertasPortal_2_SB2
@TipoOfertaSisID int,
@DuplaConsultora int,
@CodigoCampania int,
@Offset int,
@CantidadRegistros int
AS
/*
GetOfertasPortal 1702, 100, 201414
*/
BEGIN
SET NOCOUNT ON
-- Depuramos las tallas y colores
EXEC DepurarTallaColorLiquidacion @CodigoCampania

if @TipoOfertaSisID = 1701
BEGIN
if @DuplaConsultora = 1
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469 - JICM Nuevos Campos marcación
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
-- LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
-- LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
--LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
AND ConfiguracionOfertaID != 2
and CodigoOferta = pc.CodigoTipoOferta )

ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY

END
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
CASE
WHEN tcl.DescripcionCUV IS NOT NULL THEN tcl.DescripcionCUV
ELSE OP.Descripcion END Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
dbo.FiltrarTallaColorLiquidacion_2_SB2(op.CUV, CA.Codigo) TallaColor,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
left join TallaColorLiquidacion tcl with(nolock)
on tcl.CUV = pc.CUV and tcl.CampaniaID = pc.AnoCampania
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND OP.Stock > 0
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE GetOfertasPortal_2_SB2
@TipoOfertaSisID int,
@DuplaConsultora int,
@CodigoCampania int,
@Offset int,
@CantidadRegistros int
AS
/*
GetOfertasPortal 1702, 100, 201414
*/
BEGIN
SET NOCOUNT ON
-- Depuramos las tallas y colores
EXEC DepurarTallaColorLiquidacion @CodigoCampania

if @TipoOfertaSisID = 1701
BEGIN
if @DuplaConsultora = 1
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469 - JICM Nuevos Campos marcación
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
-- LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
-- LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
--LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
AND ConfiguracionOfertaID != 2
and CodigoOferta = pc.CodigoTipoOferta )

ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY

END
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
CASE
WHEN tcl.DescripcionCUV IS NOT NULL THEN tcl.DescripcionCUV
ELSE OP.Descripcion END Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
dbo.FiltrarTallaColorLiquidacion_2_SB2(op.CUV, CA.Codigo) TallaColor,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
left join TallaColorLiquidacion tcl with(nolock)
on tcl.CUV = pc.CUV and tcl.CampaniaID = pc.AnoCampania
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND OP.Stock > 0
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE GetOfertasPortal_2_SB2
@TipoOfertaSisID int,
@DuplaConsultora int,
@CodigoCampania int,
@Offset int,
@CantidadRegistros int
AS
/*
GetOfertasPortal 1702, 100, 201414
*/
BEGIN
SET NOCOUNT ON
-- Depuramos las tallas y colores
EXEC DepurarTallaColorLiquidacion @CodigoCampania

if @TipoOfertaSisID = 1701
BEGIN
if @DuplaConsultora = 1
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469 - JICM Nuevos Campos marcación
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
-- LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
-- LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
--LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
AND ConfiguracionOfertaID != 2
and CodigoOferta = pc.CodigoTipoOferta )

ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY

END
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
CASE
WHEN tcl.DescripcionCUV IS NOT NULL THEN tcl.DescripcionCUV
ELSE OP.Descripcion END Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
dbo.FiltrarTallaColorLiquidacion_2_SB2(op.CUV, CA.Codigo) TallaColor,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
left join TallaColorLiquidacion tcl with(nolock)
on tcl.CUV = pc.CUV and tcl.CampaniaID = pc.AnoCampania
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND OP.Stock > 0
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE GetOfertasPortal_2_SB2
@TipoOfertaSisID int,
@DuplaConsultora int,
@CodigoCampania int,
@Offset int,
@CantidadRegistros int
AS
/*
GetOfertasPortal 1702, 100, 201414
*/
BEGIN
SET NOCOUNT ON
-- Depuramos las tallas y colores
EXEC DepurarTallaColorLiquidacion @CodigoCampania

if @TipoOfertaSisID = 1701
BEGIN
if @DuplaConsultora = 1
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469 - JICM Nuevos Campos marcación
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
-- LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
-- LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
--LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
AND ConfiguracionOfertaID != 2
and CodigoOferta = pc.CodigoTipoOferta )

ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY

END
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
CASE
WHEN tcl.DescripcionCUV IS NOT NULL THEN tcl.DescripcionCUV
ELSE OP.Descripcion END Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
dbo.FiltrarTallaColorLiquidacion_2_SB2(op.CUV, CA.Codigo) TallaColor,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
left join TallaColorLiquidacion tcl with(nolock)
on tcl.CUV = pc.CUV and tcl.CampaniaID = pc.AnoCampania
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND OP.Stock > 0
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE GetOfertasPortal_2_SB2
@TipoOfertaSisID int,
@DuplaConsultora int,
@CodigoCampania int,
@Offset int,
@CantidadRegistros int
AS
/*
GetOfertasPortal 1702, 100, 201414
*/
BEGIN
SET NOCOUNT ON
-- Depuramos las tallas y colores
EXEC DepurarTallaColorLiquidacion @CodigoCampania

if @TipoOfertaSisID = 1701
BEGIN
if @DuplaConsultora = 1
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469 - JICM Nuevos Campos marcación
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
-- LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
-- LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
--LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
AND ConfiguracionOfertaID != 2
and CodigoOferta = pc.CodigoTipoOferta )

ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY

END
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
CASE
WHEN tcl.DescripcionCUV IS NOT NULL THEN tcl.DescripcionCUV
ELSE OP.Descripcion END Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
dbo.FiltrarTallaColorLiquidacion_2_SB2(op.CUV, CA.Codigo) TallaColor,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
left join TallaColorLiquidacion tcl with(nolock)
on tcl.CUV = pc.CUV and tcl.CampaniaID = pc.AnoCampania
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND OP.Stock > 0
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE GetOfertasPortal_2_SB2
@TipoOfertaSisID int,
@DuplaConsultora int,
@CodigoCampania int,
@Offset int,
@CantidadRegistros int
AS
/*
GetOfertasPortal 1702, 100, 201414
*/
BEGIN
SET NOCOUNT ON
-- Depuramos las tallas y colores
EXEC DepurarTallaColorLiquidacion @CodigoCampania

if @TipoOfertaSisID = 1701
BEGIN
if @DuplaConsultora = 1
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469 - JICM Nuevos Campos marcación
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
-- LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
-- LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
--LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
AND ConfiguracionOfertaID != 2
and CodigoOferta = pc.CodigoTipoOferta )

ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY

END
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
CASE
WHEN tcl.DescripcionCUV IS NOT NULL THEN tcl.DescripcionCUV
ELSE OP.Descripcion END Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
dbo.FiltrarTallaColorLiquidacion_2_SB2(op.CUV, CA.Codigo) TallaColor,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
left join TallaColorLiquidacion tcl with(nolock)
on tcl.CUV = pc.CUV and tcl.CampaniaID = pc.AnoCampania
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND OP.Stock > 0
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE GetOfertasPortal_2_SB2
@TipoOfertaSisID int,
@DuplaConsultora int,
@CodigoCampania int,
@Offset int,
@CantidadRegistros int
AS
/*
GetOfertasPortal 1702, 100, 201414
*/
BEGIN
SET NOCOUNT ON
-- Depuramos las tallas y colores
EXEC DepurarTallaColorLiquidacion @CodigoCampania

if @TipoOfertaSisID = 1701
BEGIN
if @DuplaConsultora = 1
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469 - JICM Nuevos Campos marcación
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
-- LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
-- LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
OP.Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
--R2469
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
--LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
AND ConfiguracionOfertaID != 2
and CodigoOferta = pc.CodigoTipoOferta )

ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY

END
END
ELSE
BEGIN
select
OP.OfertaProductoID,
OP.CampaniaID,
ca.Codigo as CodigoCampania,
OP.CUV,
CASE
WHEN tcl.DescripcionCUV IS NOT NULL THEN tcl.DescripcionCUV
ELSE OP.Descripcion END Descripcion,
coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,
isnull(OP.Stock,0) Stock,
isnull(OP.ImagenProducto,'') ImagenProducto,
OP.Orden,
OP.UnidadesPermitidas,
isnull(OP.DescripcionLegal,'') DescripcionLegal,
OP.ConfiguracionOfertaID,
OP.TipoOfertaSisID,
PC.MarcaID,
dbo.FiltrarTallaColorLiquidacion_2_SB2(op.CUV, CA.Codigo) TallaColor,
M.Descripcion as DescripcionMarca, --R2469
'NO DISPONIBLE' AS DescripcionCategoria,
'NO DISPONIBLE' AS DescripcionEstrategia
from ofertaproducto op with(nolock)
inner join ods.campania ca with(nolock)
on op.campaniaid = ca.campaniaid
inner join ods.productocomercial pc with(nolock)
on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid
left join ProductoDescripcion pd with(nolock)
on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv
left join TallaColorLiquidacion tcl with(nolock)
on tcl.CUV = pc.CUV and tcl.CampaniaID = pc.AnoCampania
--LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
--LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
--LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
--LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2
-- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID
left join Marca M ON pc.MarcaId = M.MarcaId
where op.TipoOfertaSisID = @TipoOfertaSisID
and OP.FlagHabilitarProducto = 1
AND OP.Stock > 0
AND CA.Codigo = @CodigoCampania
AND OP.ConfiguracionOfertaID IN
(SELECT ConfiguracionOfertaID
FROM configuracionoferta with(nolock)
WHERE TipoOfertaSisID = @TipoOfertaSisID
and CodigoOferta = pc.CodigoTipoOferta )
ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC
OFFSET @Offset ROWS
FETCH NEXT @CantidadRegistros ROWS ONLY
END
SET NOCOUNT OFF
END
GO

