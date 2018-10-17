GO
USE BelcorpPeru
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaOfertaParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO
CREATE PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
		@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
		@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @TipoEstrategiaID INT = 0
	DECLARE @EtiquetaID2 INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	IF @TipoEstrategia = 9
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '005'
	END
	IF @TipoEstrategia = 10
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '007'
	END
	IF @TipoEstrategia = 11
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '008'
	END
	IF @TipoEstrategia = 12
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '010'
	END
	IF @TipoEstrategia = 13
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '011'
	END
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END
	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	IF @TipoEstrategia = 30
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '030'
	END

	INSERT INTO Estrategia
	(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
	FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
	Cantidad,FlagCantidad,Zona,Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
	FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles)
	SELECT
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
	FROM @EstrategiaTemporal

	IF (ISNULL(@TipoEstrategia,0) != 0)
	BEGIN
		DECLARE @CampaniaIdx INT
		SELECT TOP 1 @CampaniaIdx = CampaniaId FROM @EstrategiaTemporal
		UPDATE EP SET EP.EstrategiaID = E.EstrategiaID
		FROM Estrategia E
		INNER JOIN EstrategiaProducto EP ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		WHERE E.TipoEstrategiaID = @TipoEstrategiaID
			AND E.CampaniaId = @CampaniaIdx
			AND ISNULL(EP.EstrategiaID,0) = 0
	END
END

GO

GO
USE BelcorpMexico
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaOfertaParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO
CREATE PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
		@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
		@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @TipoEstrategiaID INT = 0
	DECLARE @EtiquetaID2 INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	IF @TipoEstrategia = 9
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '005'
	END
	IF @TipoEstrategia = 10
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '007'
	END
	IF @TipoEstrategia = 11
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '008'
	END
	IF @TipoEstrategia = 12
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '010'
	END
	IF @TipoEstrategia = 13
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '011'
	END
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END
	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	IF @TipoEstrategia = 30
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '030'
	END

	INSERT INTO Estrategia
	(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
	FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
	Cantidad,FlagCantidad,Zona,Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
	FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles)
	SELECT
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
	FROM @EstrategiaTemporal

	IF (ISNULL(@TipoEstrategia,0) != 0)
	BEGIN
		DECLARE @CampaniaIdx INT
		SELECT TOP 1 @CampaniaIdx = CampaniaId FROM @EstrategiaTemporal
		UPDATE EP SET EP.EstrategiaID = E.EstrategiaID
		FROM Estrategia E
		INNER JOIN EstrategiaProducto EP ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		WHERE E.TipoEstrategiaID = @TipoEstrategiaID
			AND E.CampaniaId = @CampaniaIdx
			AND ISNULL(EP.EstrategiaID,0) = 0
	END
END

GO

GO
USE BelcorpColombia
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaOfertaParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO
CREATE PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
		@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
		@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @TipoEstrategiaID INT = 0
	DECLARE @EtiquetaID2 INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	IF @TipoEstrategia = 9
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '005'
	END
	IF @TipoEstrategia = 10
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '007'
	END
	IF @TipoEstrategia = 11
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '008'
	END
	IF @TipoEstrategia = 12
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '010'
	END
	IF @TipoEstrategia = 13
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '011'
	END
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END
	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	IF @TipoEstrategia = 30
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '030'
	END

	INSERT INTO Estrategia
	(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
	FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
	Cantidad,FlagCantidad,Zona,Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
	FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles)
	SELECT
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
	FROM @EstrategiaTemporal

	IF (ISNULL(@TipoEstrategia,0) != 0)
	BEGIN
		DECLARE @CampaniaIdx INT
		SELECT TOP 1 @CampaniaIdx = CampaniaId FROM @EstrategiaTemporal
		UPDATE EP SET EP.EstrategiaID = E.EstrategiaID
		FROM Estrategia E
		INNER JOIN EstrategiaProducto EP ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		WHERE E.TipoEstrategiaID = @TipoEstrategiaID
			AND E.CampaniaId = @CampaniaIdx
			AND ISNULL(EP.EstrategiaID,0) = 0
	END
END

GO

GO
USE BelcorpSalvador
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaOfertaParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO
CREATE PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
		@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
		@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @TipoEstrategiaID INT = 0
	DECLARE @EtiquetaID2 INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	IF @TipoEstrategia = 9
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '005'
	END
	IF @TipoEstrategia = 10
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '007'
	END
	IF @TipoEstrategia = 11
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '008'
	END
	IF @TipoEstrategia = 12
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '010'
	END
	IF @TipoEstrategia = 13
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '011'
	END
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END
	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	IF @TipoEstrategia = 30
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '030'
	END

	INSERT INTO Estrategia
	(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
	FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
	Cantidad,FlagCantidad,Zona,Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
	FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles)
	SELECT
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
	FROM @EstrategiaTemporal

	IF (ISNULL(@TipoEstrategia,0) != 0)
	BEGIN
		DECLARE @CampaniaIdx INT
		SELECT TOP 1 @CampaniaIdx = CampaniaId FROM @EstrategiaTemporal
		UPDATE EP SET EP.EstrategiaID = E.EstrategiaID
		FROM Estrategia E
		INNER JOIN EstrategiaProducto EP ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		WHERE E.TipoEstrategiaID = @TipoEstrategiaID
			AND E.CampaniaId = @CampaniaIdx
			AND ISNULL(EP.EstrategiaID,0) = 0
	END
END

GO

GO
USE BelcorpPuertoRico
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaOfertaParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO
CREATE PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
		@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
		@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @TipoEstrategiaID INT = 0
	DECLARE @EtiquetaID2 INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	IF @TipoEstrategia = 9
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '005'
	END
	IF @TipoEstrategia = 10
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '007'
	END
	IF @TipoEstrategia = 11
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '008'
	END
	IF @TipoEstrategia = 12
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '010'
	END
	IF @TipoEstrategia = 13
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '011'
	END
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END
	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	IF @TipoEstrategia = 30
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '030'
	END

	INSERT INTO Estrategia
	(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
	FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
	Cantidad,FlagCantidad,Zona,Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
	FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles)
	SELECT
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
	FROM @EstrategiaTemporal

	IF (ISNULL(@TipoEstrategia,0) != 0)
	BEGIN
		DECLARE @CampaniaIdx INT
		SELECT TOP 1 @CampaniaIdx = CampaniaId FROM @EstrategiaTemporal
		UPDATE EP SET EP.EstrategiaID = E.EstrategiaID
		FROM Estrategia E
		INNER JOIN EstrategiaProducto EP ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		WHERE E.TipoEstrategiaID = @TipoEstrategiaID
			AND E.CampaniaId = @CampaniaIdx
			AND ISNULL(EP.EstrategiaID,0) = 0
	END
END

GO

GO
USE BelcorpPanama
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaOfertaParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO
CREATE PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
		@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
		@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @TipoEstrategiaID INT = 0
	DECLARE @EtiquetaID2 INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	IF @TipoEstrategia = 9
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '005'
	END
	IF @TipoEstrategia = 10
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '007'
	END
	IF @TipoEstrategia = 11
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '008'
	END
	IF @TipoEstrategia = 12
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '010'
	END
	IF @TipoEstrategia = 13
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '011'
	END
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END
	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	IF @TipoEstrategia = 30
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '030'
	END

	INSERT INTO Estrategia
	(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
	FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
	Cantidad,FlagCantidad,Zona,Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
	FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles)
	SELECT
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
	FROM @EstrategiaTemporal

	IF (ISNULL(@TipoEstrategia,0) != 0)
	BEGIN
		DECLARE @CampaniaIdx INT
		SELECT TOP 1 @CampaniaIdx = CampaniaId FROM @EstrategiaTemporal
		UPDATE EP SET EP.EstrategiaID = E.EstrategiaID
		FROM Estrategia E
		INNER JOIN EstrategiaProducto EP ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		WHERE E.TipoEstrategiaID = @TipoEstrategiaID
			AND E.CampaniaId = @CampaniaIdx
			AND ISNULL(EP.EstrategiaID,0) = 0
	END
END

GO

GO
USE BelcorpGuatemala
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaOfertaParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO
CREATE PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
		@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
		@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @TipoEstrategiaID INT = 0
	DECLARE @EtiquetaID2 INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	IF @TipoEstrategia = 9
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '005'
	END
	IF @TipoEstrategia = 10
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '007'
	END
	IF @TipoEstrategia = 11
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '008'
	END
	IF @TipoEstrategia = 12
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '010'
	END
	IF @TipoEstrategia = 13
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '011'
	END
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END
	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	IF @TipoEstrategia = 30
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '030'
	END

	INSERT INTO Estrategia
	(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
	FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
	Cantidad,FlagCantidad,Zona,Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
	FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles)
	SELECT
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
	FROM @EstrategiaTemporal

	IF (ISNULL(@TipoEstrategia,0) != 0)
	BEGIN
		DECLARE @CampaniaIdx INT
		SELECT TOP 1 @CampaniaIdx = CampaniaId FROM @EstrategiaTemporal
		UPDATE EP SET EP.EstrategiaID = E.EstrategiaID
		FROM Estrategia E
		INNER JOIN EstrategiaProducto EP ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		WHERE E.TipoEstrategiaID = @TipoEstrategiaID
			AND E.CampaniaId = @CampaniaIdx
			AND ISNULL(EP.EstrategiaID,0) = 0
	END
END

GO

GO
USE BelcorpEcuador
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaOfertaParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO
CREATE PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
		@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
		@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @TipoEstrategiaID INT = 0
	DECLARE @EtiquetaID2 INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	IF @TipoEstrategia = 9
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '005'
	END
	IF @TipoEstrategia = 10
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '007'
	END
	IF @TipoEstrategia = 11
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '008'
	END
	IF @TipoEstrategia = 12
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '010'
	END
	IF @TipoEstrategia = 13
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '011'
	END
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END
	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	IF @TipoEstrategia = 30
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '030'
	END

	INSERT INTO Estrategia
	(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
	FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
	Cantidad,FlagCantidad,Zona,Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
	FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles)
	SELECT
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
	FROM @EstrategiaTemporal

	IF (ISNULL(@TipoEstrategia,0) != 0)
	BEGIN
		DECLARE @CampaniaIdx INT
		SELECT TOP 1 @CampaniaIdx = CampaniaId FROM @EstrategiaTemporal
		UPDATE EP SET EP.EstrategiaID = E.EstrategiaID
		FROM Estrategia E
		INNER JOIN EstrategiaProducto EP ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		WHERE E.TipoEstrategiaID = @TipoEstrategiaID
			AND E.CampaniaId = @CampaniaIdx
			AND ISNULL(EP.EstrategiaID,0) = 0
	END
END

GO

GO
USE BelcorpDominicana
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaOfertaParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO
CREATE PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
		@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
		@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @TipoEstrategiaID INT = 0
	DECLARE @EtiquetaID2 INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	IF @TipoEstrategia = 9
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '005'
	END
	IF @TipoEstrategia = 10
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '007'
	END
	IF @TipoEstrategia = 11
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '008'
	END
	IF @TipoEstrategia = 12
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '010'
	END
	IF @TipoEstrategia = 13
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '011'
	END
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END
	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	IF @TipoEstrategia = 30
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '030'
	END

	INSERT INTO Estrategia
	(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
	FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
	Cantidad,FlagCantidad,Zona,Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
	FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles)
	SELECT
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
	FROM @EstrategiaTemporal

	IF (ISNULL(@TipoEstrategia,0) != 0)
	BEGIN
		DECLARE @CampaniaIdx INT
		SELECT TOP 1 @CampaniaIdx = CampaniaId FROM @EstrategiaTemporal
		UPDATE EP SET EP.EstrategiaID = E.EstrategiaID
		FROM Estrategia E
		INNER JOIN EstrategiaProducto EP ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		WHERE E.TipoEstrategiaID = @TipoEstrategiaID
			AND E.CampaniaId = @CampaniaIdx
			AND ISNULL(EP.EstrategiaID,0) = 0
	END
END

GO

GO
USE BelcorpCostaRica
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaOfertaParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO
CREATE PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
		@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
		@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @TipoEstrategiaID INT = 0
	DECLARE @EtiquetaID2 INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	IF @TipoEstrategia = 9
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '005'
	END
	IF @TipoEstrategia = 10
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '007'
	END
	IF @TipoEstrategia = 11
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '008'
	END
	IF @TipoEstrategia = 12
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '010'
	END
	IF @TipoEstrategia = 13
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '011'
	END
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END
	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	IF @TipoEstrategia = 30
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '030'
	END

	INSERT INTO Estrategia
	(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
	FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
	Cantidad,FlagCantidad,Zona,Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
	FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles)
	SELECT
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
	FROM @EstrategiaTemporal

	IF (ISNULL(@TipoEstrategia,0) != 0)
	BEGIN
		DECLARE @CampaniaIdx INT
		SELECT TOP 1 @CampaniaIdx = CampaniaId FROM @EstrategiaTemporal
		UPDATE EP SET EP.EstrategiaID = E.EstrategiaID
		FROM Estrategia E
		INNER JOIN EstrategiaProducto EP ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		WHERE E.TipoEstrategiaID = @TipoEstrategiaID
			AND E.CampaniaId = @CampaniaIdx
			AND ISNULL(EP.EstrategiaID,0) = 0
	END
END

GO

GO
USE BelcorpChile
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaOfertaParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO
CREATE PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
		@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
		@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @TipoEstrategiaID INT = 0
	DECLARE @EtiquetaID2 INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	IF @TipoEstrategia = 9
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '005'
	END
	IF @TipoEstrategia = 10
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '007'
	END
	IF @TipoEstrategia = 11
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '008'
	END
	IF @TipoEstrategia = 12
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '010'
	END
	IF @TipoEstrategia = 13
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '011'
	END
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END
	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	IF @TipoEstrategia = 30
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '030'
	END

	INSERT INTO Estrategia
	(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
	FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
	Cantidad,FlagCantidad,Zona,Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
	FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles)
	SELECT
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
	FROM @EstrategiaTemporal

	IF (ISNULL(@TipoEstrategia,0) != 0)
	BEGIN
		DECLARE @CampaniaIdx INT
		SELECT TOP 1 @CampaniaIdx = CampaniaId FROM @EstrategiaTemporal
		UPDATE EP SET EP.EstrategiaID = E.EstrategiaID
		FROM Estrategia E
		INNER JOIN EstrategiaProducto EP ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		WHERE E.TipoEstrategiaID = @TipoEstrategiaID
			AND E.CampaniaId = @CampaniaIdx
			AND ISNULL(EP.EstrategiaID,0) = 0
	END
END

GO

GO
USE BelcorpBolivia
GO
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaOfertaParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaOfertaParaTi
GO
CREATE PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]
		@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
		@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @TipoEstrategiaID INT = 0
	DECLARE @EtiquetaID2 INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	IF @TipoEstrategia = 9
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '005'
	END
	IF @TipoEstrategia = 10
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '007'
	END
	IF @TipoEstrategia = 11
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '008'
	END
	IF @TipoEstrategia = 12
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '010'
	END
	IF @TipoEstrategia = 13
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '011'
	END
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
	END
	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia
		WHERE DescripcionEstrategia like '%'+ UPPER('Los más vendidos')+'%'
	END

	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END
	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta
		WHERE Descripcion like '%' + UPPER('Los más vendidos') + '%'
	END
	IF @TipoEstrategia = 30
	BEGIN
		SELECT @TipoEstrategiaID = TipoEstrategiaID
		FROM TipoEstrategia WHERE Codigo = '030'
	END

	INSERT INTO Estrategia
	(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
	FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
	Cantidad,FlagCantidad,Zona,Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
	FechaModIFicacion,ColorFondo,FlagEstrella, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles)
	SELECT
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad, PrecioPublico, Ganancia, Niveles
	FROM @EstrategiaTemporal

	IF (ISNULL(@TipoEstrategia,0) != 0)
	BEGIN
		DECLARE @CampaniaIdx INT
		SELECT TOP 1 @CampaniaIdx = CampaniaId FROM @EstrategiaTemporal
		UPDATE EP SET EP.EstrategiaID = E.EstrategiaID
		FROM Estrategia E
		INNER JOIN EstrategiaProducto EP ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		WHERE E.TipoEstrategiaID = @TipoEstrategiaID
			AND E.CampaniaId = @CampaniaIdx
			AND ISNULL(EP.EstrategiaID,0) = 0
	END
END

GO

GO
