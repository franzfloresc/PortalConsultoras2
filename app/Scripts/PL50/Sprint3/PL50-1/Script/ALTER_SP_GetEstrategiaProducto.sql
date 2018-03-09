USE BelcorpBolivia
GO
  IF OBJECT_ID('dbo.GetEstrategiaProducto', 'P') IS NOT NULL
	DROP PROC dbo.GetEstrategiaProducto
GO
CREATE PROCEDURE dbo.GetEstrategiaProducto
@EstrategiaId int
AS
begin
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
FROM EstrategiaProducto AS ep INNER JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
WHERE EstrategiaId = @EstrategiaId
end
GO
USE BelcorpChile
GO
  IF OBJECT_ID('dbo.GetEstrategiaProducto', 'P') IS NOT NULL
	DROP PROC dbo.GetEstrategiaProducto
GO
CREATE PROCEDURE dbo.GetEstrategiaProducto
@EstrategiaId int
AS
begin
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
FROM EstrategiaProducto AS ep INNER JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
WHERE EstrategiaId = @EstrategiaId
end
GO
USE BelcorpColombia
GO
  IF OBJECT_ID('dbo.GetEstrategiaProducto', 'P') IS NOT NULL
	DROP PROC dbo.GetEstrategiaProducto
GO
CREATE PROCEDURE dbo.GetEstrategiaProducto
@EstrategiaId int
AS
begin
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
FROM EstrategiaProducto AS ep INNER JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
WHERE EstrategiaId = @EstrategiaId
end
GO

USE BelcorpCostaRica
GO
  IF OBJECT_ID('dbo.GetEstrategiaProducto', 'P') IS NOT NULL
	DROP PROC dbo.GetEstrategiaProducto
GO
CREATE PROCEDURE dbo.GetEstrategiaProducto
@EstrategiaId int
AS
begin
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
FROM EstrategiaProducto AS ep INNER JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
WHERE EstrategiaId = @EstrategiaId
end
GO

USE BelcorpDominicana
GO
  IF OBJECT_ID('dbo.GetEstrategiaProducto', 'P') IS NOT NULL
	DROP PROC dbo.GetEstrategiaProducto
GO
CREATE PROCEDURE dbo.GetEstrategiaProducto
@EstrategiaId int
AS
begin
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
FROM EstrategiaProducto AS ep INNER JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
WHERE EstrategiaId = @EstrategiaId
end
GO

USE BelcorpEcuador
GO
  IF OBJECT_ID('dbo.GetEstrategiaProducto', 'P') IS NOT NULL
	DROP PROC dbo.GetEstrategiaProducto
GO
CREATE PROCEDURE dbo.GetEstrategiaProducto
@EstrategiaId int
AS
begin
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
FROM EstrategiaProducto AS ep INNER JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
WHERE EstrategiaId = @EstrategiaId
end
GO

USE BelcorpGuatemala
GO
  IF OBJECT_ID('dbo.GetEstrategiaProducto', 'P') IS NOT NULL
	DROP PROC dbo.GetEstrategiaProducto
GO
CREATE PROCEDURE dbo.GetEstrategiaProducto
@EstrategiaId int
AS
begin
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
FROM EstrategiaProducto AS ep INNER JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
WHERE EstrategiaId = @EstrategiaId
end
GO

USE BelcorpMexico
GO
  IF OBJECT_ID('dbo.GetEstrategiaProducto', 'P') IS NOT NULL
	DROP PROC dbo.GetEstrategiaProducto
GO
CREATE PROCEDURE dbo.GetEstrategiaProducto
@EstrategiaId int
AS
begin
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
FROM EstrategiaProducto AS ep INNER JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
WHERE EstrategiaId = @EstrategiaId
end
GO

USE BelcorpPanama
GO
  IF OBJECT_ID('dbo.GetEstrategiaProducto', 'P') IS NOT NULL
	DROP PROC dbo.GetEstrategiaProducto
GO
CREATE PROCEDURE dbo.GetEstrategiaProducto
@EstrategiaId int
AS
begin
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
FROM EstrategiaProducto AS ep INNER JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
WHERE EstrategiaId = @EstrategiaId
end
GO

USE BelcorpPeru
GO
  IF OBJECT_ID('dbo.GetEstrategiaProducto', 'P') IS NOT NULL
	DROP PROC dbo.GetEstrategiaProducto
GO
CREATE PROCEDURE dbo.GetEstrategiaProducto
@EstrategiaId int
AS
begin
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
FROM EstrategiaProducto AS ep INNER JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
WHERE EstrategiaId = @EstrategiaId
end
GO

USE BelcorpPuertoRico
GO
  IF OBJECT_ID('dbo.GetEstrategiaProducto', 'P') IS NOT NULL
	DROP PROC dbo.GetEstrategiaProducto
GO
CREATE PROCEDURE dbo.GetEstrategiaProducto
@EstrategiaId int
AS
begin
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
FROM EstrategiaProducto AS ep INNER JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
WHERE EstrategiaId = @EstrategiaId
end
GO

USE BelcorpSalvador
GO
  IF OBJECT_ID('dbo.GetEstrategiaProducto', 'P') IS NOT NULL
	DROP PROC dbo.GetEstrategiaProducto
GO
CREATE PROCEDURE dbo.GetEstrategiaProducto
@EstrategiaId int
AS
begin
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
FROM EstrategiaProducto AS ep INNER JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
WHERE EstrategiaId = @EstrategiaId
end
GO

USE BelcorpVenezuela
GO
  IF OBJECT_ID('dbo.GetEstrategiaProducto', 'P') IS NOT NULL
	DROP PROC dbo.GetEstrategiaProducto
GO
CREATE PROCEDURE dbo.GetEstrategiaProducto
@EstrategiaId int
AS
begin
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
FROM EstrategiaProducto AS ep INNER JOIN dbo.Marca AS m ON ep.IdMarca = m.MarcaID
WHERE EstrategiaId = @EstrategiaId
end
GO