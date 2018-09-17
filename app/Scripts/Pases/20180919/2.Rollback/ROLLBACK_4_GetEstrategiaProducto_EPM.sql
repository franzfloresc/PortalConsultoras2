
USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[GetEstrategiaProducto]
@EstrategiaId int
AS
BEGIN
	SELECT
	  ep.EstrategiaProductoId
	, ep.EstrategiaId
	, ep.Campania
	, ep.CUV
	, ep.CodigoEstrategia
	, ep.Grupo
	, ep.Orden
	, ep.CUV2
	, ep.SAP
	, ep.Cantidad
	, ep.Precio
	, ep.PrecioValorizado
	, ep.Digitable
	, ep.CodigoError
	, ep.CodigoErrorObs
	, ep.FactorCuadre
	, ep.NombreProducto
	, ep.Descripcion1
	, ep.ImagenProducto
	, ep.IdMarca
	, m.Descripcion AS 'NombreMarca'
	, ep.Activo
	FROM EstrategiaProducto AS ep LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId = @EstrategiaId
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[GetEstrategiaProducto]
@EstrategiaId int
AS
BEGIN
	SELECT
	  ep.EstrategiaProductoId
	, ep.EstrategiaId
	, ep.Campania
	, ep.CUV
	, ep.CodigoEstrategia
	, ep.Grupo
	, ep.Orden
	, ep.CUV2
	, ep.SAP
	, ep.Cantidad
	, ep.Precio
	, ep.PrecioValorizado
	, ep.Digitable
	, ep.CodigoError
	, ep.CodigoErrorObs
	, ep.FactorCuadre
	, ep.NombreProducto
	, ep.Descripcion1
	, ep.ImagenProducto
	, ep.IdMarca
	, m.Descripcion AS 'NombreMarca'
	, ep.Activo
	FROM EstrategiaProducto AS ep LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId = @EstrategiaId
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[GetEstrategiaProducto]
@EstrategiaId int
AS
BEGIN
	SELECT
	  ep.EstrategiaProductoId
	, ep.EstrategiaId
	, ep.Campania
	, ep.CUV
	, ep.CodigoEstrategia
	, ep.Grupo
	, ep.Orden
	, ep.CUV2
	, ep.SAP
	, ep.Cantidad
	, ep.Precio
	, ep.PrecioValorizado
	, ep.Digitable
	, ep.CodigoError
	, ep.CodigoErrorObs
	, ep.FactorCuadre
	, ep.NombreProducto
	, ep.Descripcion1
	, ep.ImagenProducto
	, ep.IdMarca
	, m.Descripcion AS 'NombreMarca'
	, ep.Activo
	FROM EstrategiaProducto AS ep LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId = @EstrategiaId
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetEstrategiaProducto]
@EstrategiaId int
AS
BEGIN
	SELECT
	  ep.EstrategiaProductoId
	, ep.EstrategiaId
	, ep.Campania
	, ep.CUV
	, ep.CodigoEstrategia
	, ep.Grupo
	, ep.Orden
	, ep.CUV2
	, ep.SAP
	, ep.Cantidad
	, ep.Precio
	, ep.PrecioValorizado
	, ep.Digitable
	, ep.CodigoError
	, ep.CodigoErrorObs
	, ep.FactorCuadre
	, ep.NombreProducto
	, ep.Descripcion1
	, ep.ImagenProducto
	, ep.IdMarca
	, m.Descripcion AS 'NombreMarca'
	, ep.Activo
	FROM EstrategiaProducto AS ep LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId = @EstrategiaId
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[GetEstrategiaProducto]
@EstrategiaId int
AS
BEGIN
	SELECT
	  ep.EstrategiaProductoId
	, ep.EstrategiaId
	, ep.Campania
	, ep.CUV
	, ep.CodigoEstrategia
	, ep.Grupo
	, ep.Orden
	, ep.CUV2
	, ep.SAP
	, ep.Cantidad
	, ep.Precio
	, ep.PrecioValorizado
	, ep.Digitable
	, ep.CodigoError
	, ep.CodigoErrorObs
	, ep.FactorCuadre
	, ep.NombreProducto
	, ep.Descripcion1
	, ep.ImagenProducto
	, ep.IdMarca
	, m.Descripcion AS 'NombreMarca'
	, ep.Activo
	FROM EstrategiaProducto AS ep LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId = @EstrategiaId
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[GetEstrategiaProducto]
@EstrategiaId int
AS
BEGIN
	SELECT
	  ep.EstrategiaProductoId
	, ep.EstrategiaId
	, ep.Campania
	, ep.CUV
	, ep.CodigoEstrategia
	, ep.Grupo
	, ep.Orden
	, ep.CUV2
	, ep.SAP
	, ep.Cantidad
	, ep.Precio
	, ep.PrecioValorizado
	, ep.Digitable
	, ep.CodigoError
	, ep.CodigoErrorObs
	, ep.FactorCuadre
	, ep.NombreProducto
	, ep.Descripcion1
	, ep.ImagenProducto
	, ep.IdMarca
	, m.Descripcion AS 'NombreMarca'
	, ep.Activo
	FROM EstrategiaProducto AS ep LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId = @EstrategiaId
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[GetEstrategiaProducto]
@EstrategiaId int
AS
BEGIN
	SELECT
	  ep.EstrategiaProductoId
	, ep.EstrategiaId
	, ep.Campania
	, ep.CUV
	, ep.CodigoEstrategia
	, ep.Grupo
	, ep.Orden
	, ep.CUV2
	, ep.SAP
	, ep.Cantidad
	, ep.Precio
	, ep.PrecioValorizado
	, ep.Digitable
	, ep.CodigoError
	, ep.CodigoErrorObs
	, ep.FactorCuadre
	, ep.NombreProducto
	, ep.Descripcion1
	, ep.ImagenProducto
	, ep.IdMarca
	, m.Descripcion AS 'NombreMarca'
	, ep.Activo
	FROM EstrategiaProducto AS ep LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId = @EstrategiaId
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[GetEstrategiaProducto]
@EstrategiaId int
AS
BEGIN
	SELECT
	  ep.EstrategiaProductoId
	, ep.EstrategiaId
	, ep.Campania
	, ep.CUV
	, ep.CodigoEstrategia
	, ep.Grupo
	, ep.Orden
	, ep.CUV2
	, ep.SAP
	, ep.Cantidad
	, ep.Precio
	, ep.PrecioValorizado
	, ep.Digitable
	, ep.CodigoError
	, ep.CodigoErrorObs
	, ep.FactorCuadre
	, ep.NombreProducto
	, ep.Descripcion1
	, ep.ImagenProducto
	, ep.IdMarca
	, m.Descripcion AS 'NombreMarca'
	, ep.Activo
	FROM EstrategiaProducto AS ep LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId = @EstrategiaId
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[GetEstrategiaProducto]
@EstrategiaId int
AS
BEGIN
	SELECT
	  ep.EstrategiaProductoId
	, ep.EstrategiaId
	, ep.Campania
	, ep.CUV
	, ep.CodigoEstrategia
	, ep.Grupo
	, ep.Orden
	, ep.CUV2
	, ep.SAP
	, ep.Cantidad
	, ep.Precio
	, ep.PrecioValorizado
	, ep.Digitable
	, ep.CodigoError
	, ep.CodigoErrorObs
	, ep.FactorCuadre
	, ep.NombreProducto
	, ep.Descripcion1
	, ep.ImagenProducto
	, ep.IdMarca
	, m.Descripcion AS 'NombreMarca'
	, ep.Activo
	FROM EstrategiaProducto AS ep LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId = @EstrategiaId
END
GO

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[GetEstrategiaProducto]
@EstrategiaId int
AS
BEGIN
	SELECT
	  ep.EstrategiaProductoId
	, ep.EstrategiaId
	, ep.Campania
	, ep.CUV
	, ep.CodigoEstrategia
	, ep.Grupo
	, ep.Orden
	, ep.CUV2
	, ep.SAP
	, ep.Cantidad
	, ep.Precio
	, ep.PrecioValorizado
	, ep.Digitable
	, ep.CodigoError
	, ep.CodigoErrorObs
	, ep.FactorCuadre
	, ep.NombreProducto
	, ep.Descripcion1
	, ep.ImagenProducto
	, ep.IdMarca
	, m.Descripcion AS 'NombreMarca'
	, ep.Activo
	FROM EstrategiaProducto AS ep LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId = @EstrategiaId
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[GetEstrategiaProducto]
@EstrategiaId int
AS
BEGIN
	SELECT
	  ep.EstrategiaProductoId
	, ep.EstrategiaId
	, ep.Campania
	, ep.CUV
	, ep.CodigoEstrategia
	, ep.Grupo
	, ep.Orden
	, ep.CUV2
	, ep.SAP
	, ep.Cantidad
	, ep.Precio
	, ep.PrecioValorizado
	, ep.Digitable
	, ep.CodigoError
	, ep.CodigoErrorObs
	, ep.FactorCuadre
	, ep.NombreProducto
	, ep.Descripcion1
	, ep.ImagenProducto
	, ep.IdMarca
	, m.Descripcion AS 'NombreMarca'
	, ep.Activo
	FROM EstrategiaProducto AS ep LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId = @EstrategiaId
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[GetEstrategiaProducto]
@EstrategiaId int
AS
BEGIN
	SELECT
	  ep.EstrategiaProductoId
	, ep.EstrategiaId
	, ep.Campania
	, ep.CUV
	, ep.CodigoEstrategia
	, ep.Grupo
	, ep.Orden
	, ep.CUV2
	, ep.SAP
	, ep.Cantidad
	, ep.Precio
	, ep.PrecioValorizado
	, ep.Digitable
	, ep.CodigoError
	, ep.CodigoErrorObs
	, ep.FactorCuadre
	, ep.NombreProducto
	, ep.Descripcion1
	, ep.ImagenProducto
	, ep.IdMarca
	, m.Descripcion AS 'NombreMarca'
	, ep.Activo
	FROM EstrategiaProducto AS ep LEFT JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId = @EstrategiaId
END
GO

