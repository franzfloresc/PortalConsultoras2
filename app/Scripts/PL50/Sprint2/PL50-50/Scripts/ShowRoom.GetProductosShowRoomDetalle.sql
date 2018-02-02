
GO

IF (OBJECT_ID('ShowRoom.GetProductosShowRoomDetalle', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetProductosShowRoomDetalle AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE ShowRoom.GetProductosShowRoomDetalle @CampaniaID INT
	,@CUV VARCHAR(5)
AS
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201802,'95416'
*/
BEGIN
	SELECT e.EstrategiaProductoID as  OfertaShowRoomDetalleID
		,e.Campania as CampaniaID
		,e.CUV
		,isnull(e.NombreProducto, '') AS NombreProducto
		,isnull(e.Descripcion1, '') AS Descripcion1
		,'' AS Descripcion2
		,'' AS Descripcion3
		,isnull(e.ImagenProducto, '') AS Imagen
		,e.FechaCreacion
		,e.UsuarioCreacion
		,e.FechaModificacion
		,e.UsuarioModificacion
		,e.Orden as Posicion
		,e.IdMarca as MarcaProducto
	FROM EstrategiaProducto e
	WHERE Campania = @CampaniaID
		AND CUV = @CUV
END
