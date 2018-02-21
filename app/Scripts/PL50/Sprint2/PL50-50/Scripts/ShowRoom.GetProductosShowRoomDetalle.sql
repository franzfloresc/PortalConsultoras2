--todos iguales
USE BelcorpPeru
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
		,m.Descripcion as MarcaProducto
	FROM EstrategiaProducto e
	INNER JOIN dbo.Marca m on e.IdMarca = m.MarcaId
	WHERE Campania = @CampaniaID
		AND CUV2 = @CUV
END

GO

USE BelcorpMexico
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
		,m.Descripcion as MarcaProducto
	FROM EstrategiaProducto e
	INNER JOIN dbo.Marca m on e.IdMarca = m.MarcaId
	WHERE Campania = @CampaniaID
		AND CUV2 = @CUV
END

GO

USE BelcorpColombia
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
		,m.Descripcion as MarcaProducto
	FROM EstrategiaProducto e
	INNER JOIN dbo.Marca m on e.IdMarca = m.MarcaId
	WHERE Campania = @CampaniaID
		AND CUV2 = @CUV
END

GO

USE BelcorpVenezuela
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
		,m.Descripcion as MarcaProducto
	FROM EstrategiaProducto e
	INNER JOIN dbo.Marca m on e.IdMarca = m.MarcaId
	WHERE Campania = @CampaniaID
		AND CUV2 = @CUV
END

GO

USE BelcorpSalvador
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
		,m.Descripcion as MarcaProducto
	FROM EstrategiaProducto e
	INNER JOIN dbo.Marca m on e.IdMarca = m.MarcaId
	WHERE Campania = @CampaniaID
		AND CUV2 = @CUV
END

GO

USE BelcorpPuertoRico
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
		,m.Descripcion as MarcaProducto
	FROM EstrategiaProducto e
	INNER JOIN dbo.Marca m on e.IdMarca = m.MarcaId
	WHERE Campania = @CampaniaID
		AND CUV2 = @CUV
END

GO

USE BelcorpPanama
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
		,m.Descripcion as MarcaProducto
	FROM EstrategiaProducto e
	INNER JOIN dbo.Marca m on e.IdMarca = m.MarcaId
	WHERE Campania = @CampaniaID
		AND CUV2 = @CUV
END

GO

USE BelcorpGuatemala
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
		,m.Descripcion as MarcaProducto
	FROM EstrategiaProducto e
	INNER JOIN dbo.Marca m on e.IdMarca = m.MarcaId
	WHERE Campania = @CampaniaID
		AND CUV2 = @CUV
END

GO

USE BelcorpEcuador
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
		,m.Descripcion as MarcaProducto
	FROM EstrategiaProducto e
	INNER JOIN dbo.Marca m on e.IdMarca = m.MarcaId
	WHERE Campania = @CampaniaID
		AND CUV2 = @CUV
END

GO

USE BelcorpDominicana
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
		,m.Descripcion as MarcaProducto
	FROM EstrategiaProducto e
	INNER JOIN dbo.Marca m on e.IdMarca = m.MarcaId
	WHERE Campania = @CampaniaID
		AND CUV2 = @CUV
END

GO

USE BelcorpCostaRica
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
		,m.Descripcion as MarcaProducto
	FROM EstrategiaProducto e
	INNER JOIN dbo.Marca m on e.IdMarca = m.MarcaId
	WHERE Campania = @CampaniaID
		AND CUV2 = @CUV
END

GO

USE BelcorpChile
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
		,m.Descripcion as MarcaProducto
	FROM EstrategiaProducto e
	INNER JOIN dbo.Marca m on e.IdMarca = m.MarcaId
	WHERE Campania = @CampaniaID
		AND CUV2 = @CUV
END

GO

USE BelcorpBolivia
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
		,m.Descripcion as MarcaProducto
	FROM EstrategiaProducto e
	INNER JOIN dbo.Marca m on e.IdMarca = m.MarcaId
	WHERE Campania = @CampaniaID
		AND CUV2 = @CUV
END

GO


