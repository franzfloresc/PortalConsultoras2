USE BelcorpBolivia
GO
ALTER PROCEDURE FiltrarEstrategia 
	@EstrategiaID INT
AS
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

GO
USE BelcorpCostaRica
GO
ALTER PROCEDURE FiltrarEstrategia 
	@EstrategiaID INT
AS
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

GO
USE BelcorpChile
GO
ALTER PROCEDURE FiltrarEstrategia 
	@EstrategiaID INT
AS
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

GO
USE BelcorpColombia
GO
ALTER PROCEDURE FiltrarEstrategia 
	@EstrategiaID INT
AS
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

GO
USE BelcorpDominicana
GO
ALTER PROCEDURE FiltrarEstrategia 
	@EstrategiaID INT
AS
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

GO
USE BelcorpEcuador
GO
ALTER PROCEDURE FiltrarEstrategia 
	@EstrategiaID INT
AS
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

GO
USE BelcorpGuatemala
GO
ALTER PROCEDURE FiltrarEstrategia 
	@EstrategiaID INT
AS
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

GO
USE BelcorpMexico
GO
ALTER PROCEDURE FiltrarEstrategia 
	@EstrategiaID INT
AS
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

GO
USE BelcorpPanama
GO
ALTER PROCEDURE FiltrarEstrategia 
	@EstrategiaID INT
AS
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

GO
USE BelcorpPeru
GO
ALTER PROCEDURE FiltrarEstrategia 
	@EstrategiaID INT
AS
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

GO
USE BelcorpPuertoRico
GO
ALTER PROCEDURE FiltrarEstrategia 
	@EstrategiaID INT
AS
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

GO
USE BelcorpSalvador
GO
ALTER PROCEDURE FiltrarEstrategia 
	@EstrategiaID INT
AS
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

GO
USE BelcorpVenezuela
GO
ALTER PROCEDURE FiltrarEstrategia 
	@EstrategiaID INT
AS
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

GO
