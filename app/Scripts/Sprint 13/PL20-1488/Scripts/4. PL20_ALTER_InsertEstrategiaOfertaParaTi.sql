USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaOfertaParaTi')
	DROP PROCEDURE InsertEstrategiaOfertaParaTi;
GO
CREATE PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto
		FROM @EstrategiaTemporal
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaOfertaParaTi')
	DROP PROCEDURE InsertEstrategiaOfertaParaTi;
GO
CREATE PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto
		FROM @EstrategiaTemporal
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaOfertaParaTi')
	DROP PROCEDURE InsertEstrategiaOfertaParaTi;
GO
CREATE PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto
		FROM @EstrategiaTemporal
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaOfertaParaTi')
	DROP PROCEDURE InsertEstrategiaOfertaParaTi;
GO
CREATE PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto
		FROM @EstrategiaTemporal
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaOfertaParaTi')
	DROP PROCEDURE InsertEstrategiaOfertaParaTi;
GO
CREATE PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto
		FROM @EstrategiaTemporal
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaOfertaParaTi')
	DROP PROCEDURE InsertEstrategiaOfertaParaTi;
GO
CREATE PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto
		FROM @EstrategiaTemporal
END
GO


USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaOfertaParaTi')
	DROP PROCEDURE InsertEstrategiaOfertaParaTi;
GO
CREATE PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto
		FROM @EstrategiaTemporal
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaOfertaParaTi')
	DROP PROCEDURE InsertEstrategiaOfertaParaTi;
GO
CREATE PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto
		FROM @EstrategiaTemporal
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaOfertaParaTi')
	DROP PROCEDURE InsertEstrategiaOfertaParaTi;
GO
CREATE PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto
		FROM @EstrategiaTemporal
END
GO


USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaOfertaParaTi')
	DROP PROCEDURE InsertEstrategiaOfertaParaTi;
GO
CREATE PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto
		FROM @EstrategiaTemporal
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaOfertaParaTi')
	DROP PROCEDURE InsertEstrategiaOfertaParaTi;
GO
CREATE PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto
		FROM @EstrategiaTemporal
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaOfertaParaTi')
	DROP PROCEDURE InsertEstrategiaOfertaParaTi;
GO
CREATE PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto
		FROM @EstrategiaTemporal
END
GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaOfertaParaTi')
	DROP PROCEDURE InsertEstrategiaOfertaParaTi;
GO
CREATE PROCEDURE dbo.InsertEstrategiaOfertaParaTi
	@EstrategiaTemporal dbo.EstrategiaTemporalType READONLY,
	@TipoEstrategia INT = 4
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @EtiquetaID2 INT = 0
	DECLARE @TipoEstrategiaID INT = 0
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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

	INSERT INTO Estrategia
		(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,
		FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,
		Cantidad,FlagCantidad,
		Zona,
		Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModIFicacion,
		FechaModIFicacion,ColorFondo,FlagEstrella)
	SELECT 
		@TipoEstrategiaID,CampaniaId,0,0,0,FotoProducto01,LimiteVenta,Descripcion,
		1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,
		0,0,
		'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',
		NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,
		@FechaGeneral,'',OfertaUltimoMinuto
		FROM @EstrategiaTemporal
END
GO








