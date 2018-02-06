DECLARE @MaxEstrategiaID INT;

SELECT @MaxEstrategiaID = max(EstrategiaID)
FROM Estrategia
	--DECLARE @Temp_Estrategia TABLE(
	--)
	TipoEstrategia

INSERT INTO Estrategia (
	--EstrategiaID	
	TipoEstrategiaID
	,CampaniaID
	,CUV2
	,DescripcionCUV2
	,Precio
	,PrecioPublico
	,Cantidad
	,ImagenURL
	,LimiteVenta
	,Activo
	,ImagenMiniaturaURL
	,Orden
	,TextoLibre
	,Precio2
	,EsSubCampania
	)
SELECT --ROW_NUMBER() OVER(ORDER BY OfertaShowRoomID DESC) + @MaxEstrategiaID AS EstrategiaID
	 ves.TipoEstrategiaId --showRoom
	,c.codigo
	,osr.CUV
	,osr.Descripcion
	,osr.PrecioValorizado
	,osr.PrecioValorizado
	,osr.Stock
	,osr.ImagenProducto
	,osr.UnidadesPermitidas
	,osr.FlagHabilitarProducto
	,osr.ImagenMini
	,osr.Orden
	,osr.TipNegocio
	,osr.PrecioOferta
	,osr.EsSubCampania
FROM ShowRoom.OfertaShowRoom osr
INNER JOIN ods.Campania c ON osr.CampaniaID = c.CampaniaID
INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON osr.TipoOfertaSisID = ves.TipoOfertaSisID
	AND osr.ConfiguracionOfertaID = ves.ConfiguracionOfertaID
WHERE c.Codigo = '201804'
	OR c.Codigo = '201805'


	--select * from #Temp_Estrategia
	--If(OBJECT_ID('tempdb..##temp_Estrategia') Is Not Null)
	--Begin
	--    Drop Table #temp_Estrategia
	--End


	--EstrategiaProducto
	--OfertaShowRoomDetalle
