USE [BelcorpPeru_BPT]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaOfertaParaTi]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaOfertaParaTi]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaTemporal]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertEstrategiaTemporal]

IF EXISTS (select * from sys.types where name = 'EstrategiaTemporalType') 
	DROP TYPE [dbo].[EstrategiaTemporalType]

CREATE TYPE [dbo].[EstrategiaTemporalType] AS TABLE(
	[CampaniaId] [int] NULL,
	[CUV] [varchar](5) NULL,
	[Descripcion] [varchar](100) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[PrecioTachado] [decimal](18, 2) NULL,
	[CodigoSap] [varchar](20) NULL,	[OfertaUltimoMinuto] [int] NULL,
	[LimiteVenta] [int] NULL,
	[UsuarioCreacion] [varchar](50) NULL,
	[FotoProducto01] [varchar](150) NULL,
	[CodigoEstrategia] [varchar](150) NULL,
	[TieneVariedad] [int] NULL,
	[PrecioPublico] [decimal](18, 2) NULL,
	[Ganancia] [decimal](18, 2) NULL,
	[Niveles] [varchar](250) NULL
)
GO

CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	DECLARE @NumeroLote INT = 0

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	SELECT @NumeroLote = isnull(max(NumeroLote),0) FROM EstrategiaTemporal
	SET @NumeroLote = @NumeroLote + 1

	INSERT INTO EstrategiaTemporal 
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01, 
		CodigoEstrategia, 
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles
	FROM @EstrategiaTemporal
END
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
		WHERE DescripcionEstrategia like '%'+ UPPER('OFERTA DEL D�A')+'%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT  @TipoEstrategiaID = TipoEstrategiaID 
		FROM TipoEstrategia 
		WHERE DescripcionEstrategia like '%'+ UPPER('Los m�s vendidos')+'%'
	END
	
	IF @TipoEstrategia = 4
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
	END

	IF @TipoEstrategia = 7
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('OFERTA DEL D�A') + '%'
	END

	IF @TipoEstrategia = 20
	BEGIN
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Los m�s vendidos') + '%'
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
END
GO