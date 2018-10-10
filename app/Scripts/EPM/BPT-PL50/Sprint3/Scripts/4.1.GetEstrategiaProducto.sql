USE [BelcorpPeru_BPT]
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
	, ep.NombreComercial
	, ep.Descripcion
	, ep.Volumen
	, ep.ImagenBulk
	, ep.NombreBulk
	, ep.IdMarca
	, NombreMarca = m.Descripcion
	, ep.Activo
	FROM EstrategiaProducto AS ep 
		LEFT JOIN dbo.Marca AS m	ON ep.IdMarca = m.MarcaID
	WHERE EstrategiaId = @EstrategiaId
END
