GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarEstrategiaMasivo') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarEstrategiaMasivo
GO

CREATE PROCEDURE EstrategiaTemporalInsertarEstrategiaMasivo
(
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
BEGIN
	
	set @NroLote = isnull(@NroLote, 0)

	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	
	INSERT INTO EstrategiaProducto
	( 
		 EstrategiaId
		, Campania
		, CUV
		, CUV2
		, CodigoEstrategia
		, Grupo
		, Orden
		, SAP
		, Cantidad
		, Precio
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, NombreProducto
		, IdMarca
	)
	SELECT 
		0
		, Campania
		, Cuv
		, CuvPadre
		, CodigoEstrategia
		, Grupo
		, Orden
		, CodigoSap
		, Cantidad
		, PrecioUnitario
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, Descripcion
		, IdMarca
	FROM EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	
	INSERT INTO Estrategia
	(
		TipoEstrategiaID
		,CampaniaID
		,ImagenURL
		,LimiteVenta
		,DescripcionCUV2
		,CUV2 
		
		,FlagCEP, FlagCEP2 ,TextoLibre ,FlagTextoLibre
		,CampaniaIDFin, NumeroPedido, Activo
		,FlagDescripcion, CUV
		, EtiquetaID, EtiquetaID2 
		,Cantidad, FlagCantidad, Zona, Limite, Orden, ColorFondo
		
		,FlagEstrella, CodigoEstrategia, TieneVariedad
		
		,Precio, Precio2, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion, FechaCreacion, UsuarioModIFicacion, FechaModIFicacion
	)
	SELECT 
		dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as TipoEstrategiaID
		,CampaniaId
		,FotoProducto01
		,LimiteVenta
		,Descripcion
		,CUV
		
		,0, 1,'',0
		,0, 0, 0
		,1, ''
		, 0, dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as EtiquetaID2
		,0, 0, '', NULL, 0 , ''
		
		,OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		
		,PrecioTachado, PrecioOferta, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion,@FechaGeneral,UsuarioCreacion, @FechaGeneral
	FROM EstrategiaTemporal
	where NumeroLote = @NroLote

	UPDATE EP 
	SET EP.EstrategiaID = E.EstrategiaID
	FROM Estrategia E 
		INNER JOIN EstrategiaProducto EP 
			ON E.CampaniaId = EP.Campania 
			AND E.CUV2 = EP.CUV2
	WHERE EXISTS(SELECT CampaniaId FROM EstrategiaTemporal ET WHERE ET.CampaniaId = E.CampaniaId AND ET.NumeroLote = @NroLote)
		AND ISNULL(EP.EstrategiaID, 0) = 0

	set @NroLoteFinal = @NroLote

END
GO