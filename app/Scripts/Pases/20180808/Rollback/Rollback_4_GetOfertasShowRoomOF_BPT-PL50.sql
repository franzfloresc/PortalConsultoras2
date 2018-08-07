
GO
USE BelcorpBolivia
GO

ALTER PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*
ShowRoom.GetOfertasShowRoomOF 201804

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada BIT

	SELECT @CategoriaApoyada = CategoriaApoyada
	FROM upselling
	WHERE codigocampana = @CampaniaID

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	IF (@CategoriaApoyada = '1')
	BEGIN
		SELECT DISTINCT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN estrategiaproducto ep ON e.EstrategiaId = ep.EstrategiaId
		inner join ods.marca m on m.marcaid=ep.IdMarca
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID =m.marcaid and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1  and ep.activo=1
	END
	ELSE
	BEGIN
		SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
	END
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*
ShowRoom.GetOfertasShowRoomOF 201804

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada BIT

	SELECT @CategoriaApoyada = CategoriaApoyada
	FROM upselling
	WHERE codigocampana = @CampaniaID

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	IF (@CategoriaApoyada = '1')
	BEGIN
		SELECT DISTINCT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN estrategiaproducto ep ON e.EstrategiaId = ep.EstrategiaId
		inner join ods.marca m on m.marcaid=ep.IdMarca
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID =m.marcaid and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1  and ep.activo=1
	END
	ELSE
	BEGIN
		SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
	END
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*
ShowRoom.GetOfertasShowRoomOF 201804

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada BIT

	SELECT @CategoriaApoyada = CategoriaApoyada
	FROM upselling
	WHERE codigocampana = @CampaniaID

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	IF (@CategoriaApoyada = '1')
	BEGIN
		SELECT DISTINCT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN estrategiaproducto ep ON e.EstrategiaId = ep.EstrategiaId
		inner join ods.marca m on m.marcaid=ep.IdMarca
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID =m.marcaid and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1  and ep.activo=1
	END
	ELSE
	BEGIN
		SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
	END
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*
ShowRoom.GetOfertasShowRoomOF 201804

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada BIT

	SELECT @CategoriaApoyada = CategoriaApoyada
	FROM upselling
	WHERE codigocampana = @CampaniaID

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	IF (@CategoriaApoyada = '1')
	BEGIN
		SELECT DISTINCT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN estrategiaproducto ep ON e.EstrategiaId = ep.EstrategiaId
		inner join ods.marca m on m.marcaid=ep.IdMarca
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID =m.marcaid and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1  and ep.activo=1
	END
	ELSE
	BEGIN
		SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
	END
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*
ShowRoom.GetOfertasShowRoomOF 201804

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada BIT

	SELECT @CategoriaApoyada = CategoriaApoyada
	FROM upselling
	WHERE codigocampana = @CampaniaID

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	IF (@CategoriaApoyada = '1')
	BEGIN
		SELECT DISTINCT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN estrategiaproducto ep ON e.EstrategiaId = ep.EstrategiaId
		inner join ods.marca m on m.marcaid=ep.IdMarca
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID =m.marcaid and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1  and ep.activo=1
	END
	ELSE
	BEGIN
		SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
	END
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*
ShowRoom.GetOfertasShowRoomOF 201804

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada BIT

	SELECT @CategoriaApoyada = CategoriaApoyada
	FROM upselling
	WHERE codigocampana = @CampaniaID

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	IF (@CategoriaApoyada = '1')
	BEGIN
		SELECT DISTINCT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN estrategiaproducto ep ON e.EstrategiaId = ep.EstrategiaId
		inner join ods.marca m on m.marcaid=ep.IdMarca
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID =m.marcaid and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1  and ep.activo=1
	END
	ELSE
	BEGIN
		SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
	END
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*
ShowRoom.GetOfertasShowRoomOF 201804

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada BIT

	SELECT @CategoriaApoyada = CategoriaApoyada
	FROM upselling
	WHERE codigocampana = @CampaniaID

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	IF (@CategoriaApoyada = '1')
	BEGIN
		SELECT DISTINCT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN estrategiaproducto ep ON e.EstrategiaId = ep.EstrategiaId
		inner join ods.marca m on m.marcaid=ep.IdMarca
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID =m.marcaid and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1  and ep.activo=1
	END
	ELSE
	BEGIN
		SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
	END
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*
ShowRoom.GetOfertasShowRoomOF 201804

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada BIT

	SELECT @CategoriaApoyada = CategoriaApoyada
	FROM upselling
	WHERE codigocampana = @CampaniaID

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	IF (@CategoriaApoyada = '1')
	BEGIN
		SELECT DISTINCT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN estrategiaproducto ep ON e.EstrategiaId = ep.EstrategiaId
		inner join ods.marca m on m.marcaid=ep.IdMarca
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID =m.marcaid and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1  and ep.activo=1
	END
	ELSE
	BEGIN
		SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
	END
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*
ShowRoom.GetOfertasShowRoomOF 201804

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada BIT

	SELECT @CategoriaApoyada = CategoriaApoyada
	FROM upselling
	WHERE codigocampana = @CampaniaID

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	IF (@CategoriaApoyada = '1')
	BEGIN
		SELECT DISTINCT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN estrategiaproducto ep ON e.EstrategiaId = ep.EstrategiaId
		inner join ods.marca m on m.marcaid=ep.IdMarca
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID =m.marcaid and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1  and ep.activo=1
	END
	ELSE
	BEGIN
		SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
	END
END
GO

USE BelcorpPeru
GO

ALTER PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*
ShowRoom.GetOfertasShowRoomOF 201804

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada BIT

	SELECT @CategoriaApoyada = CategoriaApoyada
	FROM upselling
	WHERE codigocampana = @CampaniaID

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	IF (@CategoriaApoyada = '1')
	BEGIN
		SELECT DISTINCT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN estrategiaproducto ep ON e.EstrategiaId = ep.EstrategiaId
		inner join ods.marca m on m.marcaid=ep.IdMarca
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID =m.marcaid and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1  and ep.activo=1
	END
	ELSE
	BEGIN
		SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
	END
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*
ShowRoom.GetOfertasShowRoomOF 201804

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada BIT

	SELECT @CategoriaApoyada = CategoriaApoyada
	FROM upselling
	WHERE codigocampana = @CampaniaID

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	IF (@CategoriaApoyada = '1')
	BEGIN
		SELECT DISTINCT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN estrategiaproducto ep ON e.EstrategiaId = ep.EstrategiaId
		inner join ods.marca m on m.marcaid=ep.IdMarca
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID =m.marcaid and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1  and ep.activo=1
	END
	ELSE
	BEGIN
		SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
	END
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*
ShowRoom.GetOfertasShowRoomOF 201804

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada BIT

	SELECT @CategoriaApoyada = CategoriaApoyada
	FROM upselling
	WHERE codigocampana = @CampaniaID

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	IF (@CategoriaApoyada = '1')
	BEGIN
		SELECT DISTINCT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN estrategiaproducto ep ON e.EstrategiaId = ep.EstrategiaId
		inner join ods.marca m on m.marcaid=ep.IdMarca
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID =m.marcaid and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1  and ep.activo=1
	END
	ELSE
	BEGIN
		SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
		WHERE e.tipoestrategiaid = (
				SELECT TOP 1 TIPOESTRATEGIAID
				FROM TIPOESTRATEGIA
				WHERE descripcionEstrategia = 'ShowRoom'
				)
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
	END
END
GO
