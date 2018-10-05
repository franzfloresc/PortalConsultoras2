USE BelcorpPeru 
GO
ALTER PROCEDURE [dbo].[FiltrarEstrategia]
@EstrategiaID INT = 0,
@CUV2 varchar(50),
@TipoEstrategiaID INT = 0,
@CampaniaID INT
AS
BEGIN
SELECT
EstrategiaID,
TipoEstrategiaID,
e.CampaniaID,
CampaniaIDFin,
NumeroPedido,
e.Activo,
ImagenURL,
LimiteVenta,
DescripcionCUV2,
FlagDescripcion,
e.CUV,
EtiquetaID,
Precio,
FlagCEP,
CUV2,
EtiquetaID2,
Precio2,
FlagCEP2,
TextoLibre,
FlagTextoLibre,
Cantidad,
FlagCantidad,
Zona,
Orden,
ISNULL(e.ColorFondo, '') ColorFondo,
ISNULL(e.FlagEstrella, 0) FlagEstrella,
mc.CodigoSAP,
mc.IdMatrizComercial,
e.EsOfertaIndependiente,
e.PrecioPublico,
e.Ganancia
FROM dbo.Estrategia e
INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
WHERE
((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
AND
((@CUV2 = '') OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
AND
((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
AND
((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));
END
go 


USE BelcorpBolivia
GO
ALTER PROCEDURE [dbo].[FiltrarEstrategia]
@EstrategiaID INT = 0,
@CUV2 varchar(50),
@TipoEstrategiaID INT = 0,
@CampaniaID INT
AS
BEGIN
SELECT
EstrategiaID,
TipoEstrategiaID,
e.CampaniaID,
CampaniaIDFin,
NumeroPedido,
e.Activo,
ImagenURL,
LimiteVenta,
DescripcionCUV2,
FlagDescripcion,
e.CUV,
EtiquetaID,
Precio,
FlagCEP,
CUV2,
EtiquetaID2,
Precio2,
FlagCEP2,
TextoLibre,
FlagTextoLibre,
Cantidad,
FlagCantidad,
Zona,
Orden,
ISNULL(e.ColorFondo, '') ColorFondo,
ISNULL(e.FlagEstrella, 0) FlagEstrella,
mc.CodigoSAP,
mc.IdMatrizComercial,
e.EsOfertaIndependiente,
e.PrecioPublico,
e.Ganancia
FROM dbo.Estrategia e
INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
WHERE
((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
AND
((@CUV2 = '') OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
AND
((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
AND
((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));
END
go 



USE BelcorpChile
GO
ALTER PROCEDURE [dbo].[FiltrarEstrategia]
@EstrategiaID INT = 0,
@CUV2 varchar(50),
@TipoEstrategiaID INT = 0,
@CampaniaID INT
AS
BEGIN
SELECT
EstrategiaID,
TipoEstrategiaID,
e.CampaniaID,
CampaniaIDFin,
NumeroPedido,
e.Activo,
ImagenURL,
LimiteVenta,
DescripcionCUV2,
FlagDescripcion,
e.CUV,
EtiquetaID,
Precio,
FlagCEP,
CUV2,
EtiquetaID2,
Precio2,
FlagCEP2,
TextoLibre,
FlagTextoLibre,
Cantidad,
FlagCantidad,
Zona,
Orden,
ISNULL(e.ColorFondo, '') ColorFondo,
ISNULL(e.FlagEstrella, 0) FlagEstrella,
mc.CodigoSAP,
mc.IdMatrizComercial,
e.EsOfertaIndependiente,
e.PrecioPublico,
e.Ganancia
FROM dbo.Estrategia e
INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
WHERE
((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
AND
((@CUV2 = '') OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
AND
((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
AND
((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));
END
go 



USE BelcorpColombia
GO
ALTER PROCEDURE [dbo].[FiltrarEstrategia]
@EstrategiaID INT = 0,
@CUV2 varchar(50),
@TipoEstrategiaID INT = 0,
@CampaniaID INT
AS
BEGIN
SELECT
EstrategiaID,
TipoEstrategiaID,
e.CampaniaID,
CampaniaIDFin,
NumeroPedido,
e.Activo,
ImagenURL,
LimiteVenta,
DescripcionCUV2,
FlagDescripcion,
e.CUV,
EtiquetaID,
Precio,
FlagCEP,
CUV2,
EtiquetaID2,
Precio2,
FlagCEP2,
TextoLibre,
FlagTextoLibre,
Cantidad,
FlagCantidad,
Zona,
Orden,
ISNULL(e.ColorFondo, '') ColorFondo,
ISNULL(e.FlagEstrella, 0) FlagEstrella,
mc.CodigoSAP,
mc.IdMatrizComercial,
e.EsOfertaIndependiente,
e.PrecioPublico,
e.Ganancia
FROM dbo.Estrategia e
INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
WHERE
((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
AND
((@CUV2 = '') OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
AND
((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
AND
((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));
END
go 



USE BelcorpCostaRica
GO
ALTER PROCEDURE [dbo].[FiltrarEstrategia]
@EstrategiaID INT = 0,
@CUV2 varchar(50),
@TipoEstrategiaID INT = 0,
@CampaniaID INT
AS
BEGIN
SELECT
EstrategiaID,
TipoEstrategiaID,
e.CampaniaID,
CampaniaIDFin,
NumeroPedido,
e.Activo,
ImagenURL,
LimiteVenta,
DescripcionCUV2,
FlagDescripcion,
e.CUV,
EtiquetaID,
Precio,
FlagCEP,
CUV2,
EtiquetaID2,
Precio2,
FlagCEP2,
TextoLibre,
FlagTextoLibre,
Cantidad,
FlagCantidad,
Zona,
Orden,
ISNULL(e.ColorFondo, '') ColorFondo,
ISNULL(e.FlagEstrella, 0) FlagEstrella,
mc.CodigoSAP,
mc.IdMatrizComercial,
e.EsOfertaIndependiente,
e.PrecioPublico,
e.Ganancia
FROM dbo.Estrategia e
INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
WHERE
((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
AND
((@CUV2 = '') OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
AND
((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
AND
((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));
END
go 



USE BelcorpDominicana
GO
ALTER PROCEDURE [dbo].[FiltrarEstrategia]
@EstrategiaID INT = 0,
@CUV2 varchar(50),
@TipoEstrategiaID INT = 0,
@CampaniaID INT
AS
BEGIN
SELECT
EstrategiaID,
TipoEstrategiaID,
e.CampaniaID,
CampaniaIDFin,
NumeroPedido,
e.Activo,
ImagenURL,
LimiteVenta,
DescripcionCUV2,
FlagDescripcion,
e.CUV,
EtiquetaID,
Precio,
FlagCEP,
CUV2,
EtiquetaID2,
Precio2,
FlagCEP2,
TextoLibre,
FlagTextoLibre,
Cantidad,
FlagCantidad,
Zona,
Orden,
ISNULL(e.ColorFondo, '') ColorFondo,
ISNULL(e.FlagEstrella, 0) FlagEstrella,
mc.CodigoSAP,
mc.IdMatrizComercial,
e.EsOfertaIndependiente,
e.PrecioPublico,
e.Ganancia
FROM dbo.Estrategia e
INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
WHERE
((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
AND
((@CUV2 = '') OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
AND
((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
AND
((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));
END
go 



USE BelcorpEcuador
GO
ALTER PROCEDURE [dbo].[FiltrarEstrategia]
@EstrategiaID INT = 0,
@CUV2 varchar(50),
@TipoEstrategiaID INT = 0,
@CampaniaID INT
AS
BEGIN
SELECT
EstrategiaID,
TipoEstrategiaID,
e.CampaniaID,
CampaniaIDFin,
NumeroPedido,
e.Activo,
ImagenURL,
LimiteVenta,
DescripcionCUV2,
FlagDescripcion,
e.CUV,
EtiquetaID,
Precio,
FlagCEP,
CUV2,
EtiquetaID2,
Precio2,
FlagCEP2,
TextoLibre,
FlagTextoLibre,
Cantidad,
FlagCantidad,
Zona,
Orden,
ISNULL(e.ColorFondo, '') ColorFondo,
ISNULL(e.FlagEstrella, 0) FlagEstrella,
mc.CodigoSAP,
mc.IdMatrizComercial,
e.EsOfertaIndependiente,
e.PrecioPublico,
e.Ganancia
FROM dbo.Estrategia e
INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
WHERE
((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
AND
((@CUV2 = '') OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
AND
((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
AND
((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));
END
go 



USE BelcorpGuatemala 
GO
ALTER PROCEDURE [dbo].[FiltrarEstrategia]
@EstrategiaID INT = 0,
@CUV2 varchar(50),
@TipoEstrategiaID INT = 0,
@CampaniaID INT
AS
BEGIN
SELECT
EstrategiaID,
TipoEstrategiaID,
e.CampaniaID,
CampaniaIDFin,
NumeroPedido,
e.Activo,
ImagenURL,
LimiteVenta,
DescripcionCUV2,
FlagDescripcion,
e.CUV,
EtiquetaID,
Precio,
FlagCEP,
CUV2,
EtiquetaID2,
Precio2,
FlagCEP2,
TextoLibre,
FlagTextoLibre,
Cantidad,
FlagCantidad,
Zona,
Orden,
ISNULL(e.ColorFondo, '') ColorFondo,
ISNULL(e.FlagEstrella, 0) FlagEstrella,
mc.CodigoSAP,
mc.IdMatrizComercial,
e.EsOfertaIndependiente,
e.PrecioPublico,
e.Ganancia
FROM dbo.Estrategia e
INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
WHERE
((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
AND
((@CUV2 = '') OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
AND
((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
AND
((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));
END
go 



USE BelcorpMexico
GO
ALTER PROCEDURE [dbo].[FiltrarEstrategia]
@EstrategiaID INT = 0,
@CUV2 varchar(50),
@TipoEstrategiaID INT = 0,
@CampaniaID INT
AS
BEGIN
SELECT
EstrategiaID,
TipoEstrategiaID,
e.CampaniaID,
CampaniaIDFin,
NumeroPedido,
e.Activo,
ImagenURL,
LimiteVenta,
DescripcionCUV2,
FlagDescripcion,
e.CUV,
EtiquetaID,
Precio,
FlagCEP,
CUV2,
EtiquetaID2,
Precio2,
FlagCEP2,
TextoLibre,
FlagTextoLibre,
Cantidad,
FlagCantidad,
Zona,
Orden,
ISNULL(e.ColorFondo, '') ColorFondo,
ISNULL(e.FlagEstrella, 0) FlagEstrella,
mc.CodigoSAP,
mc.IdMatrizComercial,
e.EsOfertaIndependiente,
e.PrecioPublico,
e.Ganancia
FROM dbo.Estrategia e
INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
WHERE
((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
AND
((@CUV2 = '') OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
AND
((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
AND
((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));
END
go 



USE BelcorpPanama
GO
ALTER PROCEDURE [dbo].[FiltrarEstrategia]
@EstrategiaID INT = 0,
@CUV2 varchar(50),
@TipoEstrategiaID INT = 0,
@CampaniaID INT
AS
BEGIN
SELECT
EstrategiaID,
TipoEstrategiaID,
e.CampaniaID,
CampaniaIDFin,
NumeroPedido,
e.Activo,
ImagenURL,
LimiteVenta,
DescripcionCUV2,
FlagDescripcion,
e.CUV,
EtiquetaID,
Precio,
FlagCEP,
CUV2,
EtiquetaID2,
Precio2,
FlagCEP2,
TextoLibre,
FlagTextoLibre,
Cantidad,
FlagCantidad,
Zona,
Orden,
ISNULL(e.ColorFondo, '') ColorFondo,
ISNULL(e.FlagEstrella, 0) FlagEstrella,
mc.CodigoSAP,
mc.IdMatrizComercial,
e.EsOfertaIndependiente,
e.PrecioPublico,
e.Ganancia
FROM dbo.Estrategia e
INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
WHERE
((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
AND
((@CUV2 = '') OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
AND
((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
AND
((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));
END
go 



USE BelcorpPuertoRico
GO
ALTER PROCEDURE [dbo].[FiltrarEstrategia]
@EstrategiaID INT = 0,
@CUV2 varchar(50),
@TipoEstrategiaID INT = 0,
@CampaniaID INT
AS
BEGIN
SELECT
EstrategiaID,
TipoEstrategiaID,
e.CampaniaID,
CampaniaIDFin,
NumeroPedido,
e.Activo,
ImagenURL,
LimiteVenta,
DescripcionCUV2,
FlagDescripcion,
e.CUV,
EtiquetaID,
Precio,
FlagCEP,
CUV2,
EtiquetaID2,
Precio2,
FlagCEP2,
TextoLibre,
FlagTextoLibre,
Cantidad,
FlagCantidad,
Zona,
Orden,
ISNULL(e.ColorFondo, '') ColorFondo,
ISNULL(e.FlagEstrella, 0) FlagEstrella,
mc.CodigoSAP,
mc.IdMatrizComercial,
e.EsOfertaIndependiente,
e.PrecioPublico,
e.Ganancia
FROM dbo.Estrategia e
INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
WHERE
((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
AND
((@CUV2 = '') OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
AND
((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
AND
((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));
END
go 



USE BelcorpSalvador
GO
ALTER PROCEDURE [dbo].[FiltrarEstrategia]
@EstrategiaID INT = 0,
@CUV2 varchar(50),
@TipoEstrategiaID INT = 0,
@CampaniaID INT
AS
BEGIN
SELECT
EstrategiaID,
TipoEstrategiaID,
e.CampaniaID,
CampaniaIDFin,
NumeroPedido,
e.Activo,
ImagenURL,
LimiteVenta,
DescripcionCUV2,
FlagDescripcion,
e.CUV,
EtiquetaID,
Precio,
FlagCEP,
CUV2,
EtiquetaID2,
Precio2,
FlagCEP2,
TextoLibre,
FlagTextoLibre,
Cantidad,
FlagCantidad,
Zona,
Orden,
ISNULL(e.ColorFondo, '') ColorFondo,
ISNULL(e.FlagEstrella, 0) FlagEstrella,
mc.CodigoSAP,
mc.IdMatrizComercial,
e.EsOfertaIndependiente,
e.PrecioPublico,
e.Ganancia
FROM dbo.Estrategia e
INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
WHERE
((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
AND
((@CUV2 = '') OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
AND
((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
AND
((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));
END
go 



USE BelcorpVenezuela 
GO
ALTER PROCEDURE [dbo].[FiltrarEstrategia]
@EstrategiaID INT = 0,
@CUV2 varchar(50),
@TipoEstrategiaID INT = 0,
@CampaniaID INT
AS
BEGIN
SELECT
EstrategiaID,
TipoEstrategiaID,
e.CampaniaID,
CampaniaIDFin,
NumeroPedido,
e.Activo,
ImagenURL,
LimiteVenta,
DescripcionCUV2,
FlagDescripcion,
e.CUV,
EtiquetaID,
Precio,
FlagCEP,
CUV2,
EtiquetaID2,
Precio2,
FlagCEP2,
TextoLibre,
FlagTextoLibre,
Cantidad,
FlagCantidad,
Zona,
Orden,
ISNULL(e.ColorFondo, '') ColorFondo,
ISNULL(e.FlagEstrella, 0) FlagEstrella,
mc.CodigoSAP,
mc.IdMatrizComercial,
e.EsOfertaIndependiente,
e.PrecioPublico,
e.Ganancia
FROM dbo.Estrategia e
INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
WHERE
((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
AND
((@CUV2 = '') OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
AND
((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
AND
((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));
END
go 


 