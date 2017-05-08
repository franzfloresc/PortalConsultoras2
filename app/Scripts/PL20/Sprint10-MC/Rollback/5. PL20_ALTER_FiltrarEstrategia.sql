
USE BelcorpBolivia
GO


BEGIN
ALTER PROCEDURE FiltrarEstrategia 

	@EstrategiaID INT

AS

BEGIN

	SET NOCOUNT ON;



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

		mc.FotoProducto01,

		mc.FotoProducto02,

		mc.FotoProducto03,

		mc.FotoProducto04,

		mc.FotoProducto05,

		mc.FotoProducto06,

		mc.FotoProducto07,

		mc.FotoProducto08,

		mc.FotoProducto09,

		mc.FotoProducto10,

		ISNULL(e.ColorFondo, '') ColorFondo,

		ISNULL(e.FlagEstrella, 0) FlagEstrella,

		mc.CodigoSAP

	FROM dbo.Estrategia e

	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv

	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto

	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID

	WHERE EstrategiaID = @EstrategiaID;

END

END

/*end*/

USE BelcorpChile
GO

BEGIN
	ALTER PROCEDURE FiltrarEstrategia 

	@EstrategiaID INT

AS

BEGIN

	SET NOCOUNT ON;



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

		mc.FotoProducto01,

		mc.FotoProducto02,

		mc.FotoProducto03,

		mc.FotoProducto04,

		mc.FotoProducto05,

		mc.FotoProducto06,

		mc.FotoProducto07,

		mc.FotoProducto08,

		mc.FotoProducto09,

		mc.FotoProducto10,

		ISNULL(e.ColorFondo, '') ColorFondo,

		ISNULL(e.FlagEstrella, 0) FlagEstrella,

		mc.CodigoSAP

	FROM dbo.Estrategia e

	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv

	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto

	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID

	WHERE EstrategiaID = @EstrategiaID;

END
END

END
/*end*/

USE BelcorpColombia
GO

BEGIN
	
ALTER PROCEDURE FiltrarEstrategia 

	@EstrategiaID INT

AS

BEGIN

	SET NOCOUNT ON;



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

		mc.FotoProducto01,

		mc.FotoProducto02,

		mc.FotoProducto03,

		mc.FotoProducto04,

		mc.FotoProducto05,

		mc.FotoProducto06,

		mc.FotoProducto07,

		mc.FotoProducto08,

		mc.FotoProducto09,

		mc.FotoProducto10,

		ISNULL(e.ColorFondo, '') ColorFondo,

		ISNULL(e.FlagEstrella, 0) FlagEstrella,

		mc.CodigoSAP

	FROM dbo.Estrategia e

	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv

	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto

	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID

	WHERE EstrategiaID = @EstrategiaID;

END
END

END
/*end*/

USE BelcorpCostaRica
GO

BEGIN
	ALTER PROCEDURE FiltrarEstrategia 

	@EstrategiaID INT

AS

BEGIN

	SET NOCOUNT ON;



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

		mc.FotoProducto01,

		mc.FotoProducto02,

		mc.FotoProducto03,

		mc.FotoProducto04,

		mc.FotoProducto05,

		mc.FotoProducto06,

		mc.FotoProducto07,

		mc.FotoProducto08,

		mc.FotoProducto09,

		mc.FotoProducto10,

		ISNULL(e.ColorFondo, '') ColorFondo,

		ISNULL(e.FlagEstrella, 0) FlagEstrella,

		mc.CodigoSAP

	FROM dbo.Estrategia e

	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv

	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto

	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID

	WHERE EstrategiaID = @EstrategiaID;

END
END


USE BelcorpDominicana
GO

BEGIN
	
ALTER PROCEDURE FiltrarEstrategia 

	@EstrategiaID INT

AS

BEGIN

	SET NOCOUNT ON;



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

		mc.FotoProducto01,

		mc.FotoProducto02,

		mc.FotoProducto03,

		mc.FotoProducto04,

		mc.FotoProducto05,

		mc.FotoProducto06,

		mc.FotoProducto07,

		mc.FotoProducto08,

		mc.FotoProducto09,

		mc.FotoProducto10,

		ISNULL(e.ColorFondo, '') ColorFondo,

		ISNULL(e.FlagEstrella, 0) FlagEstrella,

		mc.CodigoSAP

	FROM dbo.Estrategia e

	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv

	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto

	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID

	WHERE EstrategiaID = @EstrategiaID;

END
END
/*end*/

USE BelcorpEcuador
GO

BEGIN
	ALTER PROCEDURE FiltrarEstrategia 

	@EstrategiaID INT

AS

BEGIN

	SET NOCOUNT ON;



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

		mc.FotoProducto01,

		mc.FotoProducto02,

		mc.FotoProducto03,

		mc.FotoProducto04,

		mc.FotoProducto05,

		mc.FotoProducto06,

		mc.FotoProducto07,

		mc.FotoProducto08,

		mc.FotoProducto09,

		mc.FotoProducto10,

		ISNULL(e.ColorFondo, '') ColorFondo,

		ISNULL(e.FlagEstrella, 0) FlagEstrella,

		mc.CodigoSAP

	FROM dbo.Estrategia e

	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv

	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto

	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID

	WHERE EstrategiaID = @EstrategiaID;

END


END
/*end*/

USE BelcorpGuatemala
GO

BEGIN

ALTER PROCEDURE FiltrarEstrategia 

	@EstrategiaID INT

AS

BEGIN

	SET NOCOUNT ON;



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

		mc.FotoProducto01,

		mc.FotoProducto02,

		mc.FotoProducto03,

		mc.FotoProducto04,

		mc.FotoProducto05,

		mc.FotoProducto06,

		mc.FotoProducto07,

		mc.FotoProducto08,

		mc.FotoProducto09,

		mc.FotoProducto10,

		ISNULL(e.ColorFondo, '') ColorFondo,

		ISNULL(e.FlagEstrella, 0) FlagEstrella,

		mc.CodigoSAP

	FROM dbo.Estrategia e

	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv

	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto

	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID

	WHERE EstrategiaID = @EstrategiaID;

END
END
/*end*/

USE BelcorpMexico
GO

BEGIN
	
ALTER PROCEDURE FiltrarEstrategia 

	@EstrategiaID INT

AS

BEGIN

	SET NOCOUNT ON;



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

		mc.FotoProducto01,

		mc.FotoProducto02,

		mc.FotoProducto03,

		mc.FotoProducto04,

		mc.FotoProducto05,

		mc.FotoProducto06,

		mc.FotoProducto07,

		mc.FotoProducto08,

		mc.FotoProducto09,

		mc.FotoProducto10,

		ISNULL(e.ColorFondo, '') ColorFondo,

		ISNULL(e.FlagEstrella, 0) FlagEstrella,

		mc.CodigoSAP

	FROM dbo.Estrategia e

	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv

	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto

	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID

	WHERE EstrategiaID = @EstrategiaID;

END
END
/*end*/

USE BelcorpPanama

GO

BEGIN
	ALTER PROCEDURE FiltrarEstrategia 

	@EstrategiaID INT

AS

BEGIN

	SET NOCOUNT ON;



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

		mc.FotoProducto01,

		mc.FotoProducto02,

		mc.FotoProducto03,

		mc.FotoProducto04,

		mc.FotoProducto05,

		mc.FotoProducto06,

		mc.FotoProducto07,

		mc.FotoProducto08,

		mc.FotoProducto09,

		mc.FotoProducto10,

		ISNULL(e.ColorFondo, '') ColorFondo,

		ISNULL(e.FlagEstrella, 0) FlagEstrella,

		mc.CodigoSAP

	FROM dbo.Estrategia e

	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv

	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto

	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID

	WHERE EstrategiaID = @EstrategiaID;

END

END
/*end*/

USE BelcorpPeru

GO

BEGIN
	ALTER PROCEDURE FiltrarEstrategia 

	@EstrategiaID INT

AS

BEGIN

	SET NOCOUNT ON;



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

		mc.FotoProducto01,

		mc.FotoProducto02,

		mc.FotoProducto03,

		mc.FotoProducto04,

		mc.FotoProducto05,

		mc.FotoProducto06,

		mc.FotoProducto07,

		mc.FotoProducto08,

		mc.FotoProducto09,

		mc.FotoProducto10,

		ISNULL(e.ColorFondo, '') ColorFondo,

		ISNULL(e.FlagEstrella, 0) FlagEstrella,

		mc.CodigoSAP

	FROM dbo.Estrategia e

	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv

	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto

	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID

	WHERE EstrategiaID = @EstrategiaID;

END

END
/*end*/

USE BelcorpPuertoRico

GO

BEGIN
ALTER PROCEDURE FiltrarEstrategia 

	@EstrategiaID INT

AS

BEGIN

	SET NOCOUNT ON;



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

		mc.FotoProducto01,

		mc.FotoProducto02,

		mc.FotoProducto03,

		mc.FotoProducto04,

		mc.FotoProducto05,

		mc.FotoProducto06,

		mc.FotoProducto07,

		mc.FotoProducto08,

		mc.FotoProducto09,

		mc.FotoProducto10,

		ISNULL(e.ColorFondo, '') ColorFondo,

		ISNULL(e.FlagEstrella, 0) FlagEstrella,

		mc.CodigoSAP

	FROM dbo.Estrategia e

	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv

	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto

	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID

	WHERE EstrategiaID = @EstrategiaID;

END
END
/*end*/

USE BelcorpSalvador

GO

BEGIN
	ALTER PROCEDURE FiltrarEstrategia 

	@EstrategiaID INT

AS

BEGIN

	SET NOCOUNT ON;



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

		mc.FotoProducto01,

		mc.FotoProducto02,

		mc.FotoProducto03,

		mc.FotoProducto04,

		mc.FotoProducto05,

		mc.FotoProducto06,

		mc.FotoProducto07,

		mc.FotoProducto08,

		mc.FotoProducto09,

		mc.FotoProducto10,

		ISNULL(e.ColorFondo, '') ColorFondo,

		ISNULL(e.FlagEstrella, 0) FlagEstrella,

		mc.CodigoSAP

	FROM dbo.Estrategia e

	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv

	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto

	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID

	WHERE EstrategiaID = @EstrategiaID;

END
END
/*end*/

USE BelcorpVenezuela
GO

BEGIN

	ALTER PROCEDURE FiltrarEstrategia 

	@EstrategiaID INT

AS

BEGIN

	SET NOCOUNT ON;



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

		mc.FotoProducto01,

		mc.FotoProducto02,

		mc.FotoProducto03,

		mc.FotoProducto04,

		mc.FotoProducto05,

		mc.FotoProducto06,

		mc.FotoProducto07,

		mc.FotoProducto08,

		mc.FotoProducto09,

		mc.FotoProducto10,

		ISNULL(e.ColorFondo, '') ColorFondo,

		ISNULL(e.FlagEstrella, 0) FlagEstrella,

		mc.CodigoSAP

	FROM dbo.Estrategia e

	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv

	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto

	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID

	WHERE EstrategiaID = @EstrategiaID;

END
END











