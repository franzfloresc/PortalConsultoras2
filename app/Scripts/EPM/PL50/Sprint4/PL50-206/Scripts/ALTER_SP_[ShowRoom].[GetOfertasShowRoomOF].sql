USE BelcorpBolivia
GO

IF (OBJECT_ID('ShowRoom.GetOfertasShowRoomOF', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetOfertasShowRoomOF AS SET NOCOUNT ON;')
GO
alter PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*

ShowRoom.GetOfertasShowRoomOF 201804
*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada bit

	select @CategoriaApoyada = CategoriaApoyada from upselling where codigocampana = @CampaniaID

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

		SELECT distinct e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		inner join estrategiaproducto ep on e.EstrategiaId = ep.EstrategiaId
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID = s.CodigoMarca and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
END
ELSE
BEGIN

	SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
	FROM estrategia e
	INNER JOIN ods.campania c ON e.campaniaid = c.codigo
	INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
		AND e.cuv2 = o.cuv
	INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
	WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
		AND e.campaniaid = @CampaniaID
		AND e.activo = 1
END
 

END

go

USE BelcorpChile
GO

IF (OBJECT_ID('ShowRoom.GetOfertasShowRoomOF', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetOfertasShowRoomOF AS SET NOCOUNT ON;')
GO
alter PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*

ShowRoom.GetOfertasShowRoomOF 201804
*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada bit

	select @CategoriaApoyada = CategoriaApoyada from upselling where codigocampana = @CampaniaID

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
 
		SELECT distinct e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		inner join estrategiaproducto ep on e.EstrategiaId = ep.EstrategiaId
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID = s.CodigoMarca and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
END
ELSE
BEGIN

	SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
	FROM estrategia e
	INNER JOIN ods.campania c ON e.campaniaid = c.codigo
	INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
		AND e.cuv2 = o.cuv
	INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
	WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
		AND e.campaniaid = @CampaniaID
		AND e.activo = 1
END
 

END

go
USE BelcorpColombia
GO

IF (OBJECT_ID('ShowRoom.GetOfertasShowRoomOF', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetOfertasShowRoomOF AS SET NOCOUNT ON;')
GO
alter PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*

ShowRoom.GetOfertasShowRoomOF 201804
*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada bit

	select @CategoriaApoyada = CategoriaApoyada from upselling where codigocampana = @CampaniaID

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
 
		SELECT distinct e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		inner join estrategiaproducto ep on e.EstrategiaId = ep.EstrategiaId
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID = s.CodigoMarca and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
END
ELSE
BEGIN

	SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
	FROM estrategia e
	INNER JOIN ods.campania c ON e.campaniaid = c.codigo
	INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
		AND e.cuv2 = o.cuv
	INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
	WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
		AND e.campaniaid = @CampaniaID
		AND e.activo = 1
END
 

END

go
USE BelcorpCostaRica
GO

IF (OBJECT_ID('ShowRoom.GetOfertasShowRoomOF', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetOfertasShowRoomOF AS SET NOCOUNT ON;')
GO
alter PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*

ShowRoom.GetOfertasShowRoomOF 201804
*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada bit

	select @CategoriaApoyada = CategoriaApoyada from upselling where codigocampana = @CampaniaID

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

		SELECT distinct e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		inner join estrategiaproducto ep on e.EstrategiaId = ep.EstrategiaId
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID = s.CodigoMarca and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
END
ELSE
BEGIN

	SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
	FROM estrategia e
	INNER JOIN ods.campania c ON e.campaniaid = c.codigo
	INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
		AND e.cuv2 = o.cuv
	INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
	WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
		AND e.campaniaid = @CampaniaID
		AND e.activo = 1
END
 

END

go
USE BelcorpDominicana
GO

IF (OBJECT_ID('ShowRoom.GetOfertasShowRoomOF', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetOfertasShowRoomOF AS SET NOCOUNT ON;')
GO
alter PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*

ShowRoom.GetOfertasShowRoomOF 201804
*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada bit

	select @CategoriaApoyada = CategoriaApoyada from upselling where codigocampana = @CampaniaID

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

		SELECT distinct e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		inner join estrategiaproducto ep on e.EstrategiaId = ep.EstrategiaId
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID = s.CodigoMarca and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
END
ELSE
BEGIN

	SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
	FROM estrategia e
	INNER JOIN ods.campania c ON e.campaniaid = c.codigo
	INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
		AND e.cuv2 = o.cuv
	INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
	WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
		AND e.campaniaid = @CampaniaID
		AND e.activo = 1
END
 

END

go
USE BelcorpEcuador
GO

IF (OBJECT_ID('ShowRoom.GetOfertasShowRoomOF', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetOfertasShowRoomOF AS SET NOCOUNT ON;')
GO
alter PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*

ShowRoom.GetOfertasShowRoomOF 201804
*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada bit

	select @CategoriaApoyada = CategoriaApoyada from upselling where codigocampana = @CampaniaID

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

		SELECT distinct e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		inner join estrategiaproducto ep on e.EstrategiaId = ep.EstrategiaId
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID = s.CodigoMarca and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
END
ELSE
BEGIN

	SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
	FROM estrategia e
	INNER JOIN ods.campania c ON e.campaniaid = c.codigo
	INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
		AND e.cuv2 = o.cuv
	INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
	WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
		AND e.campaniaid = @CampaniaID
		AND e.activo = 1
END
 

END

go

USE BelcorpGuatemala
GO

IF (OBJECT_ID('ShowRoom.GetOfertasShowRoomOF', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetOfertasShowRoomOF AS SET NOCOUNT ON;')
GO
alter PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*

ShowRoom.GetOfertasShowRoomOF 201804
*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada bit

	select @CategoriaApoyada = CategoriaApoyada from upselling where codigocampana = @CampaniaID

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

		SELECT distinct e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		inner join estrategiaproducto ep on e.EstrategiaId = ep.EstrategiaId
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID = s.CodigoMarca and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
END
ELSE
BEGIN

	SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
	FROM estrategia e
	INNER JOIN ods.campania c ON e.campaniaid = c.codigo
	INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
		AND e.cuv2 = o.cuv
	INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
	WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
		AND e.campaniaid = @CampaniaID
		AND e.activo = 1
END
 

END

go
USE BelcorpMexico
GO

IF (OBJECT_ID('ShowRoom.GetOfertasShowRoomOF', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetOfertasShowRoomOF AS SET NOCOUNT ON;')
GO
alter PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*

ShowRoom.GetOfertasShowRoomOF 201804
*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada bit

	select @CategoriaApoyada = CategoriaApoyada from upselling where codigocampana = @CampaniaID

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

		SELECT distinct e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		inner join estrategiaproducto ep on e.EstrategiaId = ep.EstrategiaId
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID = s.CodigoMarca and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
END
ELSE
BEGIN

	SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
	FROM estrategia e
	INNER JOIN ods.campania c ON e.campaniaid = c.codigo
	INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
		AND e.cuv2 = o.cuv
	INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
	WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
		AND e.campaniaid = @CampaniaID
		AND e.activo = 1
END
 

END

go
USE BelcorpPanama
GO

IF (OBJECT_ID('ShowRoom.GetOfertasShowRoomOF', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetOfertasShowRoomOF AS SET NOCOUNT ON;')
GO
alter PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*

ShowRoom.GetOfertasShowRoomOF 201804
*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada bit

	select @CategoriaApoyada = CategoriaApoyada from upselling where codigocampana = @CampaniaID

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

		SELECT distinct e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		inner join estrategiaproducto ep on e.EstrategiaId = ep.EstrategiaId
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID = s.CodigoMarca and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
END
ELSE
BEGIN

	SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
	FROM estrategia e
	INNER JOIN ods.campania c ON e.campaniaid = c.codigo
	INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
		AND e.cuv2 = o.cuv
	INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
	WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
		AND e.campaniaid = @CampaniaID
		AND e.activo = 1
END
 

END

go
USE BelcorpPeru
GO

IF (OBJECT_ID('ShowRoom.GetOfertasShowRoomOF', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetOfertasShowRoomOF AS SET NOCOUNT ON;')
GO
alter PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*

ShowRoom.GetOfertasShowRoomOF 201804
*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada bit

	select @CategoriaApoyada = CategoriaApoyada from upselling where codigocampana = @CampaniaID

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
 
		SELECT distinct e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		inner join estrategiaproducto ep on e.EstrategiaId = ep.EstrategiaId
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID = s.CodigoMarca and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
END
ELSE
BEGIN

	SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
	FROM estrategia e
	INNER JOIN ods.campania c ON e.campaniaid = c.codigo
	INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
		AND e.cuv2 = o.cuv
	INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
	WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
		AND e.campaniaid = @CampaniaID
		AND e.activo = 1
END
 

END

go
USE BelcorpPuertoRico
GO

IF (OBJECT_ID('ShowRoom.GetOfertasShowRoomOF', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetOfertasShowRoomOF AS SET NOCOUNT ON;')
GO
alter PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*

ShowRoom.GetOfertasShowRoomOF 201804
*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada bit

	select @CategoriaApoyada = CategoriaApoyada from upselling where codigocampana = @CampaniaID

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

		SELECT distinct e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		inner join estrategiaproducto ep on e.EstrategiaId = ep.EstrategiaId
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID = s.CodigoMarca and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
END
ELSE
BEGIN

	SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
	FROM estrategia e
	INNER JOIN ods.campania c ON e.campaniaid = c.codigo
	INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
		AND e.cuv2 = o.cuv
	INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
	WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
		AND e.campaniaid = @CampaniaID
		AND e.activo = 1
END
 

END

go
USE BelcorpSalvador
GO

IF (OBJECT_ID('ShowRoom.GetOfertasShowRoomOF', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetOfertasShowRoomOF AS SET NOCOUNT ON;')
GO
alter PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*

ShowRoom.GetOfertasShowRoomOF 201804
*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada bit

	select @CategoriaApoyada = CategoriaApoyada from upselling where codigocampana = @CampaniaID

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
 
		SELECT distinct e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
		FROM estrategia e
		INNER JOIN ods.campania c ON e.campaniaid = c.codigo
		INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
			AND e.cuv2 = o.cuv
		inner join estrategiaproducto ep on e.EstrategiaId = ep.EstrategiaId
		INNER JOIN  ods.sap_producto s ON s.CodigoSAP = ep.SAP
		INNER JOIN Upselling_Marca_Categoria umc ON umc.MarcaID = s.CodigoMarca and umc.CategoriaID = s.CodigoCategoria
		WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
			AND e.campaniaid = @CampaniaID
			AND e.activo = 1
END
ELSE
BEGIN

	SELECT e.cuv2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, o.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			, s.CodigoMarca ,s.CodigoCategoria
	FROM estrategia e
	INNER JOIN ods.campania c ON e.campaniaid = c.codigo
	INNER JOIN ods.productocomercial o ON c.campaniaid = o.campaniaid
		AND e.cuv2 = o.cuv
	INNER JOIN ods.sap_producto s ON o.CodigoProducto = s.CodigoSAP
	WHERE e.tipoestrategiaid = (SELECT TOP 1 TIPOESTRATEGIAID FROM TIPOESTRATEGIA WHERE descripcionEstrategia ='ShowRoom')
		AND e.campaniaid = @CampaniaID
		AND e.activo = 1
END
 

END

go
