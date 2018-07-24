USE belcorpBolivia
GO

IF (OBJECT_ID('dbo.GetEstrategiaProductoList', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetEstrategiaProductoList AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE dbo.GetEstrategiaProductoList @EstrategiaListId VARCHAR(max)
AS
BEGIN
	SELECT ep.EstrategiaProductoId
		,ep.EstrategiaId
		,ep.Campania
		,ep.CUV
		,ep.CodigoEstrategia
		,ep.Grupo
		,ep.Orden
		,ep.CUV2
		,ep.SAP
		,ep.Cantidad
		,ep.Precio
		,ep.PrecioValorizado
		,ep.Digitable
		,ep.CodigoError
		,ep.CodigoErrorObs
		,ep.FactorCuadre
		,ep.NombreProducto
		,ep.Descripcion1
		,ep.ImagenProducto
		,ep.IdMarca
		,m.Descripcion AS 'NombreMarca'
		,ep.Activo
	FROM EstrategiaProducto AS ep
	LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId IN (
			SELECT splitdata
			FROM [dbo].fnSplitString(@EstrategiaListId, ',')
			)
END
GO
USE belcorpChile
GO

IF (OBJECT_ID('dbo.GetEstrategiaProductoList', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetEstrategiaProductoList AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE dbo.GetEstrategiaProductoList @EstrategiaListId VARCHAR(max)
AS
BEGIN
	SELECT ep.EstrategiaProductoId
		,ep.EstrategiaId
		,ep.Campania
		,ep.CUV
		,ep.CodigoEstrategia
		,ep.Grupo
		,ep.Orden
		,ep.CUV2
		,ep.SAP
		,ep.Cantidad
		,ep.Precio
		,ep.PrecioValorizado
		,ep.Digitable
		,ep.CodigoError
		,ep.CodigoErrorObs
		,ep.FactorCuadre
		,ep.NombreProducto
		,ep.Descripcion1
		,ep.ImagenProducto
		,ep.IdMarca
		,m.Descripcion AS 'NombreMarca'
		,ep.Activo
	FROM EstrategiaProducto AS ep
	LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId IN (
			SELECT splitdata
			FROM [dbo].fnSplitString(@EstrategiaListId, ',')
			)
END
GO
USE belcorpColombia
GO

IF (OBJECT_ID('dbo.GetEstrategiaProductoList', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetEstrategiaProductoList AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE dbo.GetEstrategiaProductoList @EstrategiaListId VARCHAR(max)
AS
BEGIN
	SELECT ep.EstrategiaProductoId
		,ep.EstrategiaId
		,ep.Campania
		,ep.CUV
		,ep.CodigoEstrategia
		,ep.Grupo
		,ep.Orden
		,ep.CUV2
		,ep.SAP
		,ep.Cantidad
		,ep.Precio
		,ep.PrecioValorizado
		,ep.Digitable
		,ep.CodigoError
		,ep.CodigoErrorObs
		,ep.FactorCuadre
		,ep.NombreProducto
		,ep.Descripcion1
		,ep.ImagenProducto
		,ep.IdMarca
		,m.Descripcion AS 'NombreMarca'
		,ep.Activo
	FROM EstrategiaProducto AS ep
	LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId IN (
			SELECT splitdata
			FROM [dbo].fnSplitString(@EstrategiaListId, ',')
			)
END
GO
USE belcorpCostaRica
GO

IF (OBJECT_ID('dbo.GetEstrategiaProductoList', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetEstrategiaProductoList AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE dbo.GetEstrategiaProductoList @EstrategiaListId VARCHAR(max)
AS
BEGIN
	SELECT ep.EstrategiaProductoId
		,ep.EstrategiaId
		,ep.Campania
		,ep.CUV
		,ep.CodigoEstrategia
		,ep.Grupo
		,ep.Orden
		,ep.CUV2
		,ep.SAP
		,ep.Cantidad
		,ep.Precio
		,ep.PrecioValorizado
		,ep.Digitable
		,ep.CodigoError
		,ep.CodigoErrorObs
		,ep.FactorCuadre
		,ep.NombreProducto
		,ep.Descripcion1
		,ep.ImagenProducto
		,ep.IdMarca
		,m.Descripcion AS 'NombreMarca'
		,ep.Activo
	FROM EstrategiaProducto AS ep
	LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId IN (
			SELECT splitdata
			FROM [dbo].fnSplitString(@EstrategiaListId, ',')
			)
END
GO
USE belcorpEcuador
GO

IF (OBJECT_ID('dbo.GetEstrategiaProductoList', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetEstrategiaProductoList AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE dbo.GetEstrategiaProductoList @EstrategiaListId VARCHAR(max)
AS
BEGIN
	SELECT ep.EstrategiaProductoId
		,ep.EstrategiaId
		,ep.Campania
		,ep.CUV
		,ep.CodigoEstrategia
		,ep.Grupo
		,ep.Orden
		,ep.CUV2
		,ep.SAP
		,ep.Cantidad
		,ep.Precio
		,ep.PrecioValorizado
		,ep.Digitable
		,ep.CodigoError
		,ep.CodigoErrorObs
		,ep.FactorCuadre
		,ep.NombreProducto
		,ep.Descripcion1
		,ep.ImagenProducto
		,ep.IdMarca
		,m.Descripcion AS 'NombreMarca'
		,ep.Activo
	FROM EstrategiaProducto AS ep
	LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId IN (
			SELECT splitdata
			FROM [dbo].fnSplitString(@EstrategiaListId, ',')
			)
END
GO
USE belcorpGuatemala
GO

IF (OBJECT_ID('dbo.GetEstrategiaProductoList', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetEstrategiaProductoList AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE dbo.GetEstrategiaProductoList @EstrategiaListId VARCHAR(max)
AS
BEGIN
	SELECT ep.EstrategiaProductoId
		,ep.EstrategiaId
		,ep.Campania
		,ep.CUV
		,ep.CodigoEstrategia
		,ep.Grupo
		,ep.Orden
		,ep.CUV2
		,ep.SAP
		,ep.Cantidad
		,ep.Precio
		,ep.PrecioValorizado
		,ep.Digitable
		,ep.CodigoError
		,ep.CodigoErrorObs
		,ep.FactorCuadre
		,ep.NombreProducto
		,ep.Descripcion1
		,ep.ImagenProducto
		,ep.IdMarca
		,m.Descripcion AS 'NombreMarca'
		,ep.Activo
	FROM EstrategiaProducto AS ep
	LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId IN (
			SELECT splitdata
			FROM [dbo].fnSplitString(@EstrategiaListId, ',')
			)
END
GO
USE belcorpMexico
GO

IF (OBJECT_ID('dbo.GetEstrategiaProductoList', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetEstrategiaProductoList AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE dbo.GetEstrategiaProductoList @EstrategiaListId VARCHAR(max)
AS
BEGIN
	SELECT ep.EstrategiaProductoId
		,ep.EstrategiaId
		,ep.Campania
		,ep.CUV
		,ep.CodigoEstrategia
		,ep.Grupo
		,ep.Orden
		,ep.CUV2
		,ep.SAP
		,ep.Cantidad
		,ep.Precio
		,ep.PrecioValorizado
		,ep.Digitable
		,ep.CodigoError
		,ep.CodigoErrorObs
		,ep.FactorCuadre
		,ep.NombreProducto
		,ep.Descripcion1
		,ep.ImagenProducto
		,ep.IdMarca
		,m.Descripcion AS 'NombreMarca'
		,ep.Activo
	FROM EstrategiaProducto AS ep
	LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId IN (
			SELECT splitdata
			FROM [dbo].fnSplitString(@EstrategiaListId, ',')
			)
END
GO
USE belcorpPanama
GO

IF (OBJECT_ID('dbo.GetEstrategiaProductoList', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetEstrategiaProductoList AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE dbo.GetEstrategiaProductoList @EstrategiaListId VARCHAR(max)
AS
BEGIN
	SELECT ep.EstrategiaProductoId
		,ep.EstrategiaId
		,ep.Campania
		,ep.CUV
		,ep.CodigoEstrategia
		,ep.Grupo
		,ep.Orden
		,ep.CUV2
		,ep.SAP
		,ep.Cantidad
		,ep.Precio
		,ep.PrecioValorizado
		,ep.Digitable
		,ep.CodigoError
		,ep.CodigoErrorObs
		,ep.FactorCuadre
		,ep.NombreProducto
		,ep.Descripcion1
		,ep.ImagenProducto
		,ep.IdMarca
		,m.Descripcion AS 'NombreMarca'
		,ep.Activo
	FROM EstrategiaProducto AS ep
	LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId IN (
			SELECT splitdata
			FROM [dbo].fnSplitString(@EstrategiaListId, ',')
			)
END
GO
USE belcorpPeru
GO

IF (OBJECT_ID('dbo.GetEstrategiaProductoList', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetEstrategiaProductoList AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE dbo.GetEstrategiaProductoList @EstrategiaListId VARCHAR(max)
AS
BEGIN
	SELECT ep.EstrategiaProductoId
		,ep.EstrategiaId
		,ep.Campania
		,ep.CUV
		,ep.CodigoEstrategia
		,ep.Grupo
		,ep.Orden
		,ep.CUV2
		,ep.SAP
		,ep.Cantidad
		,ep.Precio
		,ep.PrecioValorizado
		,ep.Digitable
		,ep.CodigoError
		,ep.CodigoErrorObs
		,ep.FactorCuadre
		,ep.NombreProducto
		,ep.Descripcion1
		,ep.ImagenProducto
		,ep.IdMarca
		,m.Descripcion AS 'NombreMarca'
		,ep.Activo
	FROM EstrategiaProducto AS ep
	LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId IN (
			SELECT splitdata
			FROM [dbo].fnSplitString(@EstrategiaListId, ',')
			)
END
GO
USE belcorpPuertoRico
GO

IF (OBJECT_ID('dbo.GetEstrategiaProductoList', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetEstrategiaProductoList AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE dbo.GetEstrategiaProductoList @EstrategiaListId VARCHAR(max)
AS
BEGIN
	SELECT ep.EstrategiaProductoId
		,ep.EstrategiaId
		,ep.Campania
		,ep.CUV
		,ep.CodigoEstrategia
		,ep.Grupo
		,ep.Orden
		,ep.CUV2
		,ep.SAP
		,ep.Cantidad
		,ep.Precio
		,ep.PrecioValorizado
		,ep.Digitable
		,ep.CodigoError
		,ep.CodigoErrorObs
		,ep.FactorCuadre
		,ep.NombreProducto
		,ep.Descripcion1
		,ep.ImagenProducto
		,ep.IdMarca
		,m.Descripcion AS 'NombreMarca'
		,ep.Activo
	FROM EstrategiaProducto AS ep
	LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId IN (
			SELECT splitdata
			FROM [dbo].fnSplitString(@EstrategiaListId, ',')
			)
END
GO
USE belcorpSalvador
GO

IF (OBJECT_ID('dbo.GetEstrategiaProductoList', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetEstrategiaProductoList AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE dbo.GetEstrategiaProductoList @EstrategiaListId VARCHAR(max)
AS
BEGIN
	SELECT ep.EstrategiaProductoId
		,ep.EstrategiaId
		,ep.Campania
		,ep.CUV
		,ep.CodigoEstrategia
		,ep.Grupo
		,ep.Orden
		,ep.CUV2
		,ep.SAP
		,ep.Cantidad
		,ep.Precio
		,ep.PrecioValorizado
		,ep.Digitable
		,ep.CodigoError
		,ep.CodigoErrorObs
		,ep.FactorCuadre
		,ep.NombreProducto
		,ep.Descripcion1
		,ep.ImagenProducto
		,ep.IdMarca
		,m.Descripcion AS 'NombreMarca'
		,ep.Activo
	FROM EstrategiaProducto AS ep
	LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId IN (
			SELECT splitdata
			FROM [dbo].fnSplitString(@EstrategiaListId, ',')
			)
END
GO
