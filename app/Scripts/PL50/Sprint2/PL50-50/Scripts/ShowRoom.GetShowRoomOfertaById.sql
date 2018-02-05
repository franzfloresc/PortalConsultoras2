
GO

IF (OBJECT_ID('ShowRoom.GetShowRoomOfertaById', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetShowRoomOfertaById AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById @OfertaShowRoomID INT
AS
/*
ShowRoom.GetShowRoomOfertaById 5004
*/
BEGIN
	SET NOCOUNT ON;

	SELECT e.EstrategiaID AS OfertaShowRoomID
		,c.CampaniaID
		,e.CUV2 AS CUV		
		,e.DescripcionCUV2 AS Descripcion
		,e.PrecioPublico AS PrecioValorizado
		,e.Cantidad AS Stock		
		,e.ImagenURL AS ImagenProducto
		,e.LimiteVenta AS UnidadesPermitidas
		,e.Activo AS FlagHabilitarProducto		
		,e.UsuarioCreacion AS UsuarioRegistro
		,e.FechaCreacion AS FechaRegistro
		,UsuarioModificacion
		,FechaModificacion
		,e.ImagenMiniaturaURL AS ImagenMini
		,Orden		
		,e.TextoLibre AS TipNegocio
		,e.Precio2 AS PrecioOferta
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON e.CampaniaID = c.Codigo	
	WHERE e.EstrategiaID = @OfertaShowRoomID
END
