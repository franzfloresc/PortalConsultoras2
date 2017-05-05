
USE BelcorpBolivia
GO


BEGIN
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
		mc.IdMatrizComercial
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


END

/*end*/

USE BelcorpChile
GO

BEGIN
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
		mc.IdMatrizComercial
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

END
/*end*/

USE BelcorpColombia
GO

BEGIN
	
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
		mc.IdMatrizComercial
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

END
/*end*/

USE BelcorpCostaRica
GO

BEGIN
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
		mc.IdMatrizComercial
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

END
/*end*/

USE BelcorpDominicana
GO

BEGIN
	
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
		mc.IdMatrizComercial
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

END
/*end*/

USE BelcorpEcuador
GO

BEGIN
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
		mc.IdMatrizComercial
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


END
/*end*/

USE BelcorpGuatemala
GO

BEGIN

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
		mc.IdMatrizComercial
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
	
END
/*end*/

USE BelcorpMexico
GO

BEGIN
	
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
		mc.IdMatrizComercial
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
END
/*end*/

USE BelcorpPanama

GO

BEGIN
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
		mc.IdMatrizComercial
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


END
/*end*/

USE BelcorpPeru

GO

BEGIN
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
		mc.IdMatrizComercial
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


END
/*end*/

USE BelcorpPuertoRico

GO

BEGIN
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
		mc.IdMatrizComercial
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

END
/*end*/

USE BelcorpSalvador

GO

BEGIN
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
		mc.IdMatrizComercial
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

END
/*end*/

USE BelcorpVenezuela
GO

BEGIN

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
		mc.IdMatrizComercial
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

END











