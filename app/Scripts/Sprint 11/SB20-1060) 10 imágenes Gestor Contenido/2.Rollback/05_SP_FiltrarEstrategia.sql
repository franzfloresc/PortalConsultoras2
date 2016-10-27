GO
ALTER PROCEDURE FiltrarEstrategia --11
	@EstrategiaID INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		EstrategiaID
		,TipoEstrategiaID
		,e.CampaniaID
		,CampaniaIDFin
		,NumeroPedido
		,e.Activo
		,ImagenURL
		,LimiteVenta
		,DescripcionCUV2
		,FlagDescripcion
		,e.CUV
		,EtiquetaID
		,Precio
		,FlagCEP
		,CUV2
		,EtiquetaID2
		,Precio2
		,FlagCEP2
		,TextoLibre
		,FlagTextoLibre
		,Cantidad
		,FlagCantidad
		,Zona
		,Orden
		,mc.FotoProducto01
		,mc.FotoProducto02
		,mc.FotoProducto03			  
		,ISNULL(e.ColorFondo, '') ColorFondo
		,ISNULL(e.FlagEstrella, 0) FlagEstrella
	FROM dbo.Estrategia e 
	INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv 
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
	WHERE EstrategiaID = @EstrategiaID;

	SET NOCOUNT OFF;
END
GO