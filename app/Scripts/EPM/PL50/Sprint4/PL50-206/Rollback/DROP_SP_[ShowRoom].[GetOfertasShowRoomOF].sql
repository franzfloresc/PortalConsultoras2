USE BelcorpBolivia
GO

IF (OBJECT_ID('ShowRoom.GetOfertasShowRoomOF', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetOfertasShowRoomOF AS SET NOCOUNT ON;')
GO

alter PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*

ShowRoom.GetShowRoomOfertasConsultora 201709

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	SELECT
		--o.OfertaShowRoomID,
		--o.CampaniaID,
		o.CUV
		,
		--o.TipoOfertaSisID,
		--o.ConfiguracionOfertaID,
		o.Descripcion AS NombreComercial
		,o.PrecioValorizado
		,COALESCE(o.PrecioOferta, pc.PrecioCatalogo) AS PrecioCatalogo
		,
		--o.Stock,
		--o.StockInicial,
		o.ImagenProducto AS Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	FROM ShowRoom.OfertaShowRoom o
	INNER JOIN ods.ProductoComercial pc ON o.CampaniaID = pc.CampaniaID
		AND o.CUV = pc.CUV
	INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	WHERE c.Codigo = @CampaniaID
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV
			FROM @tablaFaltante
			)

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

ShowRoom.GetShowRoomOfertasConsultora 201709

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	SELECT
		--o.OfertaShowRoomID,
		--o.CampaniaID,
		o.CUV
		,
		--o.TipoOfertaSisID,
		--o.ConfiguracionOfertaID,
		o.Descripcion AS NombreComercial
		,o.PrecioValorizado
		,COALESCE(o.PrecioOferta, pc.PrecioCatalogo) AS PrecioCatalogo
		,
		--o.Stock,
		--o.StockInicial,
		o.ImagenProducto AS Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	FROM ShowRoom.OfertaShowRoom o
	INNER JOIN ods.ProductoComercial pc ON o.CampaniaID = pc.CampaniaID
		AND o.CUV = pc.CUV
	INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	WHERE c.Codigo = @CampaniaID
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV
			FROM @tablaFaltante
			)

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

ShowRoom.GetShowRoomOfertasConsultora 201709

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	SELECT
		--o.OfertaShowRoomID,
		--o.CampaniaID,
		o.CUV
		,
		--o.TipoOfertaSisID,
		--o.ConfiguracionOfertaID,
		o.Descripcion AS NombreComercial
		,o.PrecioValorizado
		,COALESCE(o.PrecioOferta, pc.PrecioCatalogo) AS PrecioCatalogo
		,
		--o.Stock,
		--o.StockInicial,
		o.ImagenProducto AS Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	FROM ShowRoom.OfertaShowRoom o
	INNER JOIN ods.ProductoComercial pc ON o.CampaniaID = pc.CampaniaID
		AND o.CUV = pc.CUV
	INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	WHERE c.Codigo = @CampaniaID
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV
			FROM @tablaFaltante
			)

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

ShowRoom.GetShowRoomOfertasConsultora 201709

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	SELECT
		--o.OfertaShowRoomID,
		--o.CampaniaID,
		o.CUV
		,
		--o.TipoOfertaSisID,
		--o.ConfiguracionOfertaID,
		o.Descripcion AS NombreComercial
		,o.PrecioValorizado
		,COALESCE(o.PrecioOferta, pc.PrecioCatalogo) AS PrecioCatalogo
		,
		--o.Stock,
		--o.StockInicial,
		o.ImagenProducto AS Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	FROM ShowRoom.OfertaShowRoom o
	INNER JOIN ods.ProductoComercial pc ON o.CampaniaID = pc.CampaniaID
		AND o.CUV = pc.CUV
	INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	WHERE c.Codigo = @CampaniaID
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV
			FROM @tablaFaltante
			)

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

ShowRoom.GetShowRoomOfertasConsultora 201709

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	SELECT
		--o.OfertaShowRoomID,
		--o.CampaniaID,
		o.CUV
		,
		--o.TipoOfertaSisID,
		--o.ConfiguracionOfertaID,
		o.Descripcion AS NombreComercial
		,o.PrecioValorizado
		,COALESCE(o.PrecioOferta, pc.PrecioCatalogo) AS PrecioCatalogo
		,
		--o.Stock,
		--o.StockInicial,
		o.ImagenProducto AS Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	FROM ShowRoom.OfertaShowRoom o
	INNER JOIN ods.ProductoComercial pc ON o.CampaniaID = pc.CampaniaID
		AND o.CUV = pc.CUV
	INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	WHERE c.Codigo = @CampaniaID
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV
			FROM @tablaFaltante
			)

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

ShowRoom.GetShowRoomOfertasConsultora 201709

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	SELECT
		--o.OfertaShowRoomID,
		--o.CampaniaID,
		o.CUV
		,
		--o.TipoOfertaSisID,
		--o.ConfiguracionOfertaID,
		o.Descripcion AS NombreComercial
		,o.PrecioValorizado
		,COALESCE(o.PrecioOferta, pc.PrecioCatalogo) AS PrecioCatalogo
		,
		--o.Stock,
		--o.StockInicial,
		o.ImagenProducto AS Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	FROM ShowRoom.OfertaShowRoom o
	INNER JOIN ods.ProductoComercial pc ON o.CampaniaID = pc.CampaniaID
		AND o.CUV = pc.CUV
	INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	WHERE c.Codigo = @CampaniaID
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV
			FROM @tablaFaltante
			)

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

ShowRoom.GetShowRoomOfertasConsultora 201709

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	SELECT
		--o.OfertaShowRoomID,
		--o.CampaniaID,
		o.CUV
		,
		--o.TipoOfertaSisID,
		--o.ConfiguracionOfertaID,
		o.Descripcion AS NombreComercial
		,o.PrecioValorizado
		,COALESCE(o.PrecioOferta, pc.PrecioCatalogo) AS PrecioCatalogo
		,
		--o.Stock,
		--o.StockInicial,
		o.ImagenProducto AS Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	FROM ShowRoom.OfertaShowRoom o
	INNER JOIN ods.ProductoComercial pc ON o.CampaniaID = pc.CampaniaID
		AND o.CUV = pc.CUV
	INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	WHERE c.Codigo = @CampaniaID
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV
			FROM @tablaFaltante
			)

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

ShowRoom.GetShowRoomOfertasConsultora 201709

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	SELECT
		--o.OfertaShowRoomID,
		--o.CampaniaID,
		o.CUV
		,
		--o.TipoOfertaSisID,
		--o.ConfiguracionOfertaID,
		o.Descripcion AS NombreComercial
		,o.PrecioValorizado
		,COALESCE(o.PrecioOferta, pc.PrecioCatalogo) AS PrecioCatalogo
		,
		--o.Stock,
		--o.StockInicial,
		o.ImagenProducto AS Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	FROM ShowRoom.OfertaShowRoom o
	INNER JOIN ods.ProductoComercial pc ON o.CampaniaID = pc.CampaniaID
		AND o.CUV = pc.CUV
	INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	WHERE c.Codigo = @CampaniaID
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV
			FROM @tablaFaltante
			)

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

ShowRoom.GetShowRoomOfertasConsultora 201709

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	SELECT
		--o.OfertaShowRoomID,
		--o.CampaniaID,
		o.CUV
		,
		--o.TipoOfertaSisID,
		--o.ConfiguracionOfertaID,
		o.Descripcion AS NombreComercial
		,o.PrecioValorizado
		,COALESCE(o.PrecioOferta, pc.PrecioCatalogo) AS PrecioCatalogo
		,
		--o.Stock,
		--o.StockInicial,
		o.ImagenProducto AS Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	FROM ShowRoom.OfertaShowRoom o
	INNER JOIN ods.ProductoComercial pc ON o.CampaniaID = pc.CampaniaID
		AND o.CUV = pc.CUV
	INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	WHERE c.Codigo = @CampaniaID
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV
			FROM @tablaFaltante
			)

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

ShowRoom.GetShowRoomOfertasConsultora 201709

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	SELECT
		--o.OfertaShowRoomID,
		--o.CampaniaID,
		o.CUV
		,
		--o.TipoOfertaSisID,
		--o.ConfiguracionOfertaID,
		o.Descripcion AS NombreComercial
		,o.PrecioValorizado
		,COALESCE(o.PrecioOferta, pc.PrecioCatalogo) AS PrecioCatalogo
		,
		--o.Stock,
		--o.StockInicial,
		o.ImagenProducto AS Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	FROM ShowRoom.OfertaShowRoom o
	INNER JOIN ods.ProductoComercial pc ON o.CampaniaID = pc.CampaniaID
		AND o.CUV = pc.CUV
	INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	WHERE c.Codigo = @CampaniaID
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV
			FROM @tablaFaltante
			)

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

ShowRoom.GetShowRoomOfertasConsultora 201709

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	SELECT
		--o.OfertaShowRoomID,
		--o.CampaniaID,
		o.CUV
		,
		--o.TipoOfertaSisID,
		--o.ConfiguracionOfertaID,
		o.Descripcion AS NombreComercial
		,o.PrecioValorizado
		,COALESCE(o.PrecioOferta, pc.PrecioCatalogo) AS PrecioCatalogo
		,
		--o.Stock,
		--o.StockInicial,
		o.ImagenProducto AS Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	FROM ShowRoom.OfertaShowRoom o
	INNER JOIN ods.ProductoComercial pc ON o.CampaniaID = pc.CampaniaID
		AND o.CUV = pc.CUV
	INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	WHERE c.Codigo = @CampaniaID
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV
			FROM @tablaFaltante
			)

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

ShowRoom.GetShowRoomOfertasConsultora 201709

*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	SELECT
		--o.OfertaShowRoomID,
		--o.CampaniaID,
		o.CUV
		,
		--o.TipoOfertaSisID,
		--o.ConfiguracionOfertaID,
		o.Descripcion AS NombreComercial
		,o.PrecioValorizado
		,COALESCE(o.PrecioOferta, pc.PrecioCatalogo) AS PrecioCatalogo
		,
		--o.Stock,
		--o.StockInicial,
		o.ImagenProducto AS Imagen
	--o.UnidadesPermitidas,
	--o.FlagHabilitarProducto,
	--o.DescripcionLegal,
	--o.UsuarioRegistro,
	--o.FechaRegistro,
	--o.UsuarioModificacion,
	--o.FechaModificacion,
	--o.ImagenMini,
	--pc.MarcaID, 
	--pos.Orden, 
	--o.CodigoCategoria, 
	--o.TipNegocio,
	--pc.CodigoProducto, 
	--cat.Descripcion as DescripcionCategoria, 
	--o.EsSubCampania
	FROM ShowRoom.OfertaShowRoom o
	INNER JOIN ods.ProductoComercial pc ON o.CampaniaID = pc.CampaniaID
		AND o.CUV = pc.CUV
	INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
	--inner join @tablaEventoConsultora ec on c.Codigo = ec.CampaniaID
	--inner join ShowRoom.Perfil p on ec.Segmento = p.PerfilDescripcion
	--	and ec.EventoID = p.EventoID
	--inner join ShowRoom.PerfilOfertaShowRoom pos on p.PerfilID = pos.PerfilID
	--	and c.Codigo = pos.CampaniaID
	--	and p.EventoID = pos.EventoID	
	--	and o.CUV = pos.CUV
	--left join ShowRoom.Categoria cat on ec.EventoID = cat.EventoID
	--	and o.CodigoCategoria = cat.Codigo
	WHERE c.Codigo = @CampaniaID
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV
			FROM @tablaFaltante
			)

END
go

