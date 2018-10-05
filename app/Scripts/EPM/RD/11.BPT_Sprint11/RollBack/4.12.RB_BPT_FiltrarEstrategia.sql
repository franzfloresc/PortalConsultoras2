USE BelcorpPeru
GO

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
		e.EsOfertaIndependiente
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));

END
GO

USE BelcorpMexico
GO

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
		e.EsOfertaIndependiente
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));

END
GO

USE BelcorpColombia
GO

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
		e.EsOfertaIndependiente
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));

END
GO

USE BelcorpVenezuela
GO

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
		e.EsOfertaIndependiente
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));

END
GO

USE BelcorpSalvador
GO

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
		e.EsOfertaIndependiente
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));

END
GO

USE BelcorpPuertoRico
GO

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
		e.EsOfertaIndependiente
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));

END
GO

USE BelcorpPanama
GO

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
		e.EsOfertaIndependiente
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));

END
GO

USE BelcorpGuatemala
GO

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
		e.EsOfertaIndependiente
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));

END
GO

USE BelcorpEcuador
GO

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
		e.EsOfertaIndependiente
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));

END
GO

USE BelcorpDominicana
GO

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
		e.EsOfertaIndependiente
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));

END
GO

USE BelcorpCostaRica
GO

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
		e.EsOfertaIndependiente
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));

END
GO

USE BelcorpChile
GO

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
		e.EsOfertaIndependiente
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));

END
GO

USE BelcorpBolivia
GO

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
		e.EsOfertaIndependiente
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID));

END
GO
