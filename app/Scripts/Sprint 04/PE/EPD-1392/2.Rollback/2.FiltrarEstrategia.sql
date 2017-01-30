USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FiltrarEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[FiltrarEstrategia]
GO

CREATE PROCEDURE FiltrarEstrategia --11
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
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END

GO
-------------------------------------------------------------------------------------------

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FiltrarEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[FiltrarEstrategia]
GO

CREATE PROCEDURE FiltrarEstrategia --11
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
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END

GO
-------------------------------------------------------------------------------------------

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FiltrarEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[FiltrarEstrategia]
GO

CREATE PROCEDURE FiltrarEstrategia --11
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
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END

GO
-------------------------------------------------------------------------------------------

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FiltrarEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[FiltrarEstrategia]
GO

CREATE PROCEDURE FiltrarEstrategia --11
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
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END

GO
-------------------------------------------------------------------------------------------

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FiltrarEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[FiltrarEstrategia]
GO

CREATE PROCEDURE FiltrarEstrategia --11
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
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END

GO
-------------------------------------------------------------------------------------------

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FiltrarEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[FiltrarEstrategia]
GO

CREATE PROCEDURE FiltrarEstrategia --11
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
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END

GO
-------------------------------------------------------------------------------------------

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FiltrarEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[FiltrarEstrategia]
GO

CREATE PROCEDURE FiltrarEstrategia --11
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
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END

GO
-------------------------------------------------------------------------------------------

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FiltrarEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[FiltrarEstrategia]
GO

CREATE PROCEDURE FiltrarEstrategia --11
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
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END

GO
-------------------------------------------------------------------------------------------

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FiltrarEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[FiltrarEstrategia]
GO

CREATE PROCEDURE FiltrarEstrategia --11
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
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END

GO
-------------------------------------------------------------------------------------------

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FiltrarEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[FiltrarEstrategia]
GO

CREATE PROCEDURE FiltrarEstrategia --11
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
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END

GO
-------------------------------------------------------------------------------------------

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FiltrarEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[FiltrarEstrategia]
GO

CREATE PROCEDURE FiltrarEstrategia --11
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
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END

GO
-------------------------------------------------------------------------------------------

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FiltrarEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[FiltrarEstrategia]
GO

CREATE PROCEDURE FiltrarEstrategia --11
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
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END

GO
-------------------------------------------------------------------------------------------

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FiltrarEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[FiltrarEstrategia]
GO

CREATE PROCEDURE FiltrarEstrategia --11
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
		ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;
END

GO
-------------------------------------------------------------------------------------------

