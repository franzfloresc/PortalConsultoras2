USE BelcorpPeru
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
		,e.Precio AS PrecioValorizado --tachado
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

GO

USE BelcorpMexico
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
		,e.Precio AS PrecioValorizado --tachado
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

GO

USE BelcorpColombia
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
		,e.Precio AS PrecioValorizado --tachado
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

GO

USE BelcorpVenezuela
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
		,e.Precio AS PrecioValorizado --tachado
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

GO

USE BelcorpSalvador
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
		,e.Precio AS PrecioValorizado --tachado
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

GO

USE BelcorpPuertoRico
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
		,e.Precio AS PrecioValorizado --tachado
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

GO

USE BelcorpPanama
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
		,e.Precio AS PrecioValorizado --tachado
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

GO

USE BelcorpGuatemala
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
		,e.Precio AS PrecioValorizado --tachado
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

GO

USE BelcorpEcuador
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
		,e.Precio AS PrecioValorizado --tachado
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

GO

USE BelcorpDominicana
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
		,e.Precio AS PrecioValorizado --tachado
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

GO

USE BelcorpCostaRica
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
		,e.Precio AS PrecioValorizado --tachado
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

GO

USE BelcorpChile
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
		,e.Precio AS PrecioValorizado --tachado
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

GO

USE BelcorpBolivia
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
		,e.Precio AS PrecioValorizado --tachado
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

GO

