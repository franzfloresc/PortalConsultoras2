USE BelcorpPeru
GO

IF (OBJECT_ID ( '[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] AS SET NOCOUNT ON;')
GO
--[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] 201802, '000758604'
ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]
@CampaniaID INT,
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	DECLARE @tablaEventoConsultora TABLE 
	(
		EventoConsultoraID INT,
		EventoID INT,
		CampaniaID INT,
		CodigoConsultora VARCHAR(20),
		Segmento VARCHAR(50),
		MostrarPopup BIT,
		MostrarPopupVenta BIT,
		FechaCreacion DATETIME,
		UsuarioCreacion VARCHAR(20), 
		FechaModificacion DATETIME,
		UsuarioModificacion VARCHAR(20)
	)

	INSERT INTO @tablaEventoConsultora
	SELECT TOP 1
	EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
	FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID AND CodigoConsultora = @CodigoConsultora
	ORDER BY EventoConsultoraID DESC

	DECLARE @tablaCuvsPersonalizadas TABLE (CUV VARCHAR(10), Orden INT, AnioCampanaVenta INT)

	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Existe en ofertas personalizadas'
		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END
	ELSE 
	BEGIN
		--PRINT 'NO Existe en ofertas personalizadas, buscar generico'
		--Buscar el valor generico
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END

	--select * from @tablaCuvsPersonalizadas

	/*Validacion FaltanteAnunciado y ProductoFaltante*/
	DECLARE @ZonaID INT
	DECLARE @CodigoRegion VARCHAR(2)
	DECLARE @CodigoZona VARCHAR(4)

	SELECT TOP 1 
	@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	FROM ods.Consultora c
	INNER JOIN ods.Zona z ON
		c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r on
		c.RegionID = r.RegionID
	WHERE c.Codigo = @CodigoConsultora

	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT 
		DISTINCT LTRIM(RTRIM(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE 
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	SELECT 
		DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa (NOLOCK)
	INNER JOIN ods.Campania c (NOLOCK) ON 
		fa.CampaniaID = c.CampaniaID
	WHERE 
		c.Codigo = @CampaniaID 
		AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
		AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

	SELECT
	o.OfertaShowRoomID,
	o.CampaniaID,o.CUV,
	o.TipoOfertaSisID,
	o.ConfiguracionOfertaID,
	o.Descripcion,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
	o.Stock,
	o.StockInicial,
	o.ImagenProducto,
	o.UnidadesPermitidas,
	o.FlagHabilitarProducto,
	o.DescripcionLegal,
	o.UsuarioRegistro,
	o.FechaRegistro,
	o.UsuarioModificacion,
	o.FechaModificacion,
	o.ImagenMini,
	pc.MarcaID, 
	op.Orden, 
	o.CodigoCategoria, 
	o.TipNegocio,
	pc.CodigoProducto, 
	cat.Descripcion AS DescripcionCategoria, 
	o.EsSubCampania

	FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.ProductoComercial pc ON o.CUV = pc.CUV AND o.CampaniaID = pc.CampaniaID
		INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
		INNER JOIN @tablaEventoConsultora ec ON c.Codigo = ec.CampaniaID	
		INNER JOIN @tablaCuvsPersonalizadas op ON op.AnioCampanaVenta= ec.CampaniaID AND op.CUV = o.CUV
		LEFT JOIN ShowRoom.Categoria cat ON
			ec.EventoID = cat.EventoID
			AND o.CodigoCategoria = cat.Codigo
	WHERE 
		c.Codigo = @CampaniaID
		AND ec.CodigoConsultora = @CodigoConsultora
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV FROM @tablaFaltante
		)
	ORDER BY op.Orden
END

GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( '[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] AS SET NOCOUNT ON;')
GO
--[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] 201802, '000758604'
ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]
@CampaniaID INT,
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	DECLARE @tablaEventoConsultora TABLE 
	(
		EventoConsultoraID INT,
		EventoID INT,
		CampaniaID INT,
		CodigoConsultora VARCHAR(20),
		Segmento VARCHAR(50),
		MostrarPopup BIT,
		MostrarPopupVenta BIT,
		FechaCreacion DATETIME,
		UsuarioCreacion VARCHAR(20), 
		FechaModificacion DATETIME,
		UsuarioModificacion VARCHAR(20)
	)

	INSERT INTO @tablaEventoConsultora
	SELECT TOP 1
	EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
	FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID AND CodigoConsultora = @CodigoConsultora
	ORDER BY EventoConsultoraID DESC

	DECLARE @tablaCuvsPersonalizadas TABLE (CUV VARCHAR(10), Orden INT, AnioCampanaVenta INT)

	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Existe en ofertas personalizadas'
		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END
	ELSE 
	BEGIN
		--PRINT 'NO Existe en ofertas personalizadas, buscar generico'
		--Buscar el valor generico
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END

	--select * from @tablaCuvsPersonalizadas

	/*Validacion FaltanteAnunciado y ProductoFaltante*/
	DECLARE @ZonaID INT
	DECLARE @CodigoRegion VARCHAR(2)
	DECLARE @CodigoZona VARCHAR(4)

	SELECT TOP 1 
	@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	FROM ods.Consultora c
	INNER JOIN ods.Zona z ON
		c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r on
		c.RegionID = r.RegionID
	WHERE c.Codigo = @CodigoConsultora

	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT 
		DISTINCT LTRIM(RTRIM(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE 
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	SELECT 
		DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa (NOLOCK)
	INNER JOIN ods.Campania c (NOLOCK) ON 
		fa.CampaniaID = c.CampaniaID
	WHERE 
		c.Codigo = @CampaniaID 
		AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
		AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

	SELECT
	o.OfertaShowRoomID,
	o.CampaniaID,o.CUV,
	o.TipoOfertaSisID,
	o.ConfiguracionOfertaID,
	o.Descripcion,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
	o.Stock,
	o.StockInicial,
	o.ImagenProducto,
	o.UnidadesPermitidas,
	o.FlagHabilitarProducto,
	o.DescripcionLegal,
	o.UsuarioRegistro,
	o.FechaRegistro,
	o.UsuarioModificacion,
	o.FechaModificacion,
	o.ImagenMini,
	pc.MarcaID, 
	op.Orden, 
	o.CodigoCategoria, 
	o.TipNegocio,
	pc.CodigoProducto, 
	cat.Descripcion AS DescripcionCategoria, 
	o.EsSubCampania

	FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.ProductoComercial pc ON o.CUV = pc.CUV AND o.CampaniaID = pc.CampaniaID
		INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
		INNER JOIN @tablaEventoConsultora ec ON c.Codigo = ec.CampaniaID	
		INNER JOIN @tablaCuvsPersonalizadas op ON op.AnioCampanaVenta= ec.CampaniaID AND op.CUV = o.CUV
		LEFT JOIN ShowRoom.Categoria cat ON
			ec.EventoID = cat.EventoID
			AND o.CodigoCategoria = cat.Codigo
	WHERE 
		c.Codigo = @CampaniaID
		AND ec.CodigoConsultora = @CodigoConsultora
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV FROM @tablaFaltante
		)
	ORDER BY op.Orden
END

GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( '[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] AS SET NOCOUNT ON;')
GO
--[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] 201802, '000758604'
ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]
@CampaniaID INT,
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	DECLARE @tablaEventoConsultora TABLE 
	(
		EventoConsultoraID INT,
		EventoID INT,
		CampaniaID INT,
		CodigoConsultora VARCHAR(20),
		Segmento VARCHAR(50),
		MostrarPopup BIT,
		MostrarPopupVenta BIT,
		FechaCreacion DATETIME,
		UsuarioCreacion VARCHAR(20), 
		FechaModificacion DATETIME,
		UsuarioModificacion VARCHAR(20)
	)

	INSERT INTO @tablaEventoConsultora
	SELECT TOP 1
	EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
	FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID AND CodigoConsultora = @CodigoConsultora
	ORDER BY EventoConsultoraID DESC

	DECLARE @tablaCuvsPersonalizadas TABLE (CUV VARCHAR(10), Orden INT, AnioCampanaVenta INT)

	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Existe en ofertas personalizadas'
		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END
	ELSE 
	BEGIN
		--PRINT 'NO Existe en ofertas personalizadas, buscar generico'
		--Buscar el valor generico
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END

	--select * from @tablaCuvsPersonalizadas

	/*Validacion FaltanteAnunciado y ProductoFaltante*/
	DECLARE @ZonaID INT
	DECLARE @CodigoRegion VARCHAR(2)
	DECLARE @CodigoZona VARCHAR(4)

	SELECT TOP 1 
	@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	FROM ods.Consultora c
	INNER JOIN ods.Zona z ON
		c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r on
		c.RegionID = r.RegionID
	WHERE c.Codigo = @CodigoConsultora

	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT 
		DISTINCT LTRIM(RTRIM(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE 
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	SELECT 
		DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa (NOLOCK)
	INNER JOIN ods.Campania c (NOLOCK) ON 
		fa.CampaniaID = c.CampaniaID
	WHERE 
		c.Codigo = @CampaniaID 
		AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
		AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

	SELECT
	o.OfertaShowRoomID,
	o.CampaniaID,o.CUV,
	o.TipoOfertaSisID,
	o.ConfiguracionOfertaID,
	o.Descripcion,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
	o.Stock,
	o.StockInicial,
	o.ImagenProducto,
	o.UnidadesPermitidas,
	o.FlagHabilitarProducto,
	o.DescripcionLegal,
	o.UsuarioRegistro,
	o.FechaRegistro,
	o.UsuarioModificacion,
	o.FechaModificacion,
	o.ImagenMini,
	pc.MarcaID, 
	op.Orden, 
	o.CodigoCategoria, 
	o.TipNegocio,
	pc.CodigoProducto, 
	cat.Descripcion AS DescripcionCategoria, 
	o.EsSubCampania

	FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.ProductoComercial pc ON o.CUV = pc.CUV AND o.CampaniaID = pc.CampaniaID
		INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
		INNER JOIN @tablaEventoConsultora ec ON c.Codigo = ec.CampaniaID	
		INNER JOIN @tablaCuvsPersonalizadas op ON op.AnioCampanaVenta= ec.CampaniaID AND op.CUV = o.CUV
		LEFT JOIN ShowRoom.Categoria cat ON
			ec.EventoID = cat.EventoID
			AND o.CodigoCategoria = cat.Codigo
	WHERE 
		c.Codigo = @CampaniaID
		AND ec.CodigoConsultora = @CodigoConsultora
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV FROM @tablaFaltante
		)
	ORDER BY op.Orden
END

GO

USE BelcorpVenezuela
GO

IF (OBJECT_ID ( '[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] AS SET NOCOUNT ON;')
GO
--[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] 201802, '000758604'
ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]
@CampaniaID INT,
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	DECLARE @tablaEventoConsultora TABLE 
	(
		EventoConsultoraID INT,
		EventoID INT,
		CampaniaID INT,
		CodigoConsultora VARCHAR(20),
		Segmento VARCHAR(50),
		MostrarPopup BIT,
		MostrarPopupVenta BIT,
		FechaCreacion DATETIME,
		UsuarioCreacion VARCHAR(20), 
		FechaModificacion DATETIME,
		UsuarioModificacion VARCHAR(20)
	)

	INSERT INTO @tablaEventoConsultora
	SELECT TOP 1
	EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
	FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID AND CodigoConsultora = @CodigoConsultora
	ORDER BY EventoConsultoraID DESC

	DECLARE @tablaCuvsPersonalizadas TABLE (CUV VARCHAR(10), Orden INT, AnioCampanaVenta INT)

	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Existe en ofertas personalizadas'
		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END
	ELSE 
	BEGIN
		--PRINT 'NO Existe en ofertas personalizadas, buscar generico'
		--Buscar el valor generico
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END

	--select * from @tablaCuvsPersonalizadas

	/*Validacion FaltanteAnunciado y ProductoFaltante*/
	DECLARE @ZonaID INT
	DECLARE @CodigoRegion VARCHAR(2)
	DECLARE @CodigoZona VARCHAR(4)

	SELECT TOP 1 
	@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	FROM ods.Consultora c
	INNER JOIN ods.Zona z ON
		c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r on
		c.RegionID = r.RegionID
	WHERE c.Codigo = @CodigoConsultora

	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT 
		DISTINCT LTRIM(RTRIM(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE 
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	SELECT 
		DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa (NOLOCK)
	INNER JOIN ods.Campania c (NOLOCK) ON 
		fa.CampaniaID = c.CampaniaID
	WHERE 
		c.Codigo = @CampaniaID 
		AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
		AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

	SELECT
	o.OfertaShowRoomID,
	o.CampaniaID,o.CUV,
	o.TipoOfertaSisID,
	o.ConfiguracionOfertaID,
	o.Descripcion,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
	o.Stock,
	o.StockInicial,
	o.ImagenProducto,
	o.UnidadesPermitidas,
	o.FlagHabilitarProducto,
	o.DescripcionLegal,
	o.UsuarioRegistro,
	o.FechaRegistro,
	o.UsuarioModificacion,
	o.FechaModificacion,
	o.ImagenMini,
	pc.MarcaID, 
	op.Orden, 
	o.CodigoCategoria, 
	o.TipNegocio,
	pc.CodigoProducto, 
	cat.Descripcion AS DescripcionCategoria, 
	o.EsSubCampania

	FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.ProductoComercial pc ON o.CUV = pc.CUV AND o.CampaniaID = pc.CampaniaID
		INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
		INNER JOIN @tablaEventoConsultora ec ON c.Codigo = ec.CampaniaID	
		INNER JOIN @tablaCuvsPersonalizadas op ON op.AnioCampanaVenta= ec.CampaniaID AND op.CUV = o.CUV
		LEFT JOIN ShowRoom.Categoria cat ON
			ec.EventoID = cat.EventoID
			AND o.CodigoCategoria = cat.Codigo
	WHERE 
		c.Codigo = @CampaniaID
		AND ec.CodigoConsultora = @CodigoConsultora
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV FROM @tablaFaltante
		)
	ORDER BY op.Orden
END

GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( '[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] AS SET NOCOUNT ON;')
GO
--[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] 201802, '000758604'
ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]
@CampaniaID INT,
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	DECLARE @tablaEventoConsultora TABLE 
	(
		EventoConsultoraID INT,
		EventoID INT,
		CampaniaID INT,
		CodigoConsultora VARCHAR(20),
		Segmento VARCHAR(50),
		MostrarPopup BIT,
		MostrarPopupVenta BIT,
		FechaCreacion DATETIME,
		UsuarioCreacion VARCHAR(20), 
		FechaModificacion DATETIME,
		UsuarioModificacion VARCHAR(20)
	)

	INSERT INTO @tablaEventoConsultora
	SELECT TOP 1
	EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
	FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID AND CodigoConsultora = @CodigoConsultora
	ORDER BY EventoConsultoraID DESC

	DECLARE @tablaCuvsPersonalizadas TABLE (CUV VARCHAR(10), Orden INT, AnioCampanaVenta INT)

	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Existe en ofertas personalizadas'
		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END
	ELSE 
	BEGIN
		--PRINT 'NO Existe en ofertas personalizadas, buscar generico'
		--Buscar el valor generico
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END

	--select * from @tablaCuvsPersonalizadas

	/*Validacion FaltanteAnunciado y ProductoFaltante*/
	DECLARE @ZonaID INT
	DECLARE @CodigoRegion VARCHAR(2)
	DECLARE @CodigoZona VARCHAR(4)

	SELECT TOP 1 
	@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	FROM ods.Consultora c
	INNER JOIN ods.Zona z ON
		c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r on
		c.RegionID = r.RegionID
	WHERE c.Codigo = @CodigoConsultora

	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT 
		DISTINCT LTRIM(RTRIM(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE 
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	SELECT 
		DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa (NOLOCK)
	INNER JOIN ods.Campania c (NOLOCK) ON 
		fa.CampaniaID = c.CampaniaID
	WHERE 
		c.Codigo = @CampaniaID 
		AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
		AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

	SELECT
	o.OfertaShowRoomID,
	o.CampaniaID,o.CUV,
	o.TipoOfertaSisID,
	o.ConfiguracionOfertaID,
	o.Descripcion,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
	o.Stock,
	o.StockInicial,
	o.ImagenProducto,
	o.UnidadesPermitidas,
	o.FlagHabilitarProducto,
	o.DescripcionLegal,
	o.UsuarioRegistro,
	o.FechaRegistro,
	o.UsuarioModificacion,
	o.FechaModificacion,
	o.ImagenMini,
	pc.MarcaID, 
	op.Orden, 
	o.CodigoCategoria, 
	o.TipNegocio,
	pc.CodigoProducto, 
	cat.Descripcion AS DescripcionCategoria, 
	o.EsSubCampania

	FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.ProductoComercial pc ON o.CUV = pc.CUV AND o.CampaniaID = pc.CampaniaID
		INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
		INNER JOIN @tablaEventoConsultora ec ON c.Codigo = ec.CampaniaID	
		INNER JOIN @tablaCuvsPersonalizadas op ON op.AnioCampanaVenta= ec.CampaniaID AND op.CUV = o.CUV
		LEFT JOIN ShowRoom.Categoria cat ON
			ec.EventoID = cat.EventoID
			AND o.CodigoCategoria = cat.Codigo
	WHERE 
		c.Codigo = @CampaniaID
		AND ec.CodigoConsultora = @CodigoConsultora
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV FROM @tablaFaltante
		)
	ORDER BY op.Orden
END

GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( '[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] AS SET NOCOUNT ON;')
GO
--[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] 201802, '000758604'
ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]
@CampaniaID INT,
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	DECLARE @tablaEventoConsultora TABLE 
	(
		EventoConsultoraID INT,
		EventoID INT,
		CampaniaID INT,
		CodigoConsultora VARCHAR(20),
		Segmento VARCHAR(50),
		MostrarPopup BIT,
		MostrarPopupVenta BIT,
		FechaCreacion DATETIME,
		UsuarioCreacion VARCHAR(20), 
		FechaModificacion DATETIME,
		UsuarioModificacion VARCHAR(20)
	)

	INSERT INTO @tablaEventoConsultora
	SELECT TOP 1
	EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
	FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID AND CodigoConsultora = @CodigoConsultora
	ORDER BY EventoConsultoraID DESC

	DECLARE @tablaCuvsPersonalizadas TABLE (CUV VARCHAR(10), Orden INT, AnioCampanaVenta INT)

	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Existe en ofertas personalizadas'
		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END
	ELSE 
	BEGIN
		--PRINT 'NO Existe en ofertas personalizadas, buscar generico'
		--Buscar el valor generico
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END

	--select * from @tablaCuvsPersonalizadas

	/*Validacion FaltanteAnunciado y ProductoFaltante*/
	DECLARE @ZonaID INT
	DECLARE @CodigoRegion VARCHAR(2)
	DECLARE @CodigoZona VARCHAR(4)

	SELECT TOP 1 
	@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	FROM ods.Consultora c
	INNER JOIN ods.Zona z ON
		c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r on
		c.RegionID = r.RegionID
	WHERE c.Codigo = @CodigoConsultora

	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT 
		DISTINCT LTRIM(RTRIM(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE 
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	SELECT 
		DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa (NOLOCK)
	INNER JOIN ods.Campania c (NOLOCK) ON 
		fa.CampaniaID = c.CampaniaID
	WHERE 
		c.Codigo = @CampaniaID 
		AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
		AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

	SELECT
	o.OfertaShowRoomID,
	o.CampaniaID,o.CUV,
	o.TipoOfertaSisID,
	o.ConfiguracionOfertaID,
	o.Descripcion,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
	o.Stock,
	o.StockInicial,
	o.ImagenProducto,
	o.UnidadesPermitidas,
	o.FlagHabilitarProducto,
	o.DescripcionLegal,
	o.UsuarioRegistro,
	o.FechaRegistro,
	o.UsuarioModificacion,
	o.FechaModificacion,
	o.ImagenMini,
	pc.MarcaID, 
	op.Orden, 
	o.CodigoCategoria, 
	o.TipNegocio,
	pc.CodigoProducto, 
	cat.Descripcion AS DescripcionCategoria, 
	o.EsSubCampania

	FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.ProductoComercial pc ON o.CUV = pc.CUV AND o.CampaniaID = pc.CampaniaID
		INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
		INNER JOIN @tablaEventoConsultora ec ON c.Codigo = ec.CampaniaID	
		INNER JOIN @tablaCuvsPersonalizadas op ON op.AnioCampanaVenta= ec.CampaniaID AND op.CUV = o.CUV
		LEFT JOIN ShowRoom.Categoria cat ON
			ec.EventoID = cat.EventoID
			AND o.CodigoCategoria = cat.Codigo
	WHERE 
		c.Codigo = @CampaniaID
		AND ec.CodigoConsultora = @CodigoConsultora
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV FROM @tablaFaltante
		)
	ORDER BY op.Orden
END

GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( '[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] AS SET NOCOUNT ON;')
GO
--[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] 201802, '000758604'
ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]
@CampaniaID INT,
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	DECLARE @tablaEventoConsultora TABLE 
	(
		EventoConsultoraID INT,
		EventoID INT,
		CampaniaID INT,
		CodigoConsultora VARCHAR(20),
		Segmento VARCHAR(50),
		MostrarPopup BIT,
		MostrarPopupVenta BIT,
		FechaCreacion DATETIME,
		UsuarioCreacion VARCHAR(20), 
		FechaModificacion DATETIME,
		UsuarioModificacion VARCHAR(20)
	)

	INSERT INTO @tablaEventoConsultora
	SELECT TOP 1
	EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
	FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID AND CodigoConsultora = @CodigoConsultora
	ORDER BY EventoConsultoraID DESC

	DECLARE @tablaCuvsPersonalizadas TABLE (CUV VARCHAR(10), Orden INT, AnioCampanaVenta INT)

	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Existe en ofertas personalizadas'
		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END
	ELSE 
	BEGIN
		--PRINT 'NO Existe en ofertas personalizadas, buscar generico'
		--Buscar el valor generico
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END

	--select * from @tablaCuvsPersonalizadas

	/*Validacion FaltanteAnunciado y ProductoFaltante*/
	DECLARE @ZonaID INT
	DECLARE @CodigoRegion VARCHAR(2)
	DECLARE @CodigoZona VARCHAR(4)

	SELECT TOP 1 
	@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	FROM ods.Consultora c
	INNER JOIN ods.Zona z ON
		c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r on
		c.RegionID = r.RegionID
	WHERE c.Codigo = @CodigoConsultora

	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT 
		DISTINCT LTRIM(RTRIM(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE 
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	SELECT 
		DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa (NOLOCK)
	INNER JOIN ods.Campania c (NOLOCK) ON 
		fa.CampaniaID = c.CampaniaID
	WHERE 
		c.Codigo = @CampaniaID 
		AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
		AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

	SELECT
	o.OfertaShowRoomID,
	o.CampaniaID,o.CUV,
	o.TipoOfertaSisID,
	o.ConfiguracionOfertaID,
	o.Descripcion,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
	o.Stock,
	o.StockInicial,
	o.ImagenProducto,
	o.UnidadesPermitidas,
	o.FlagHabilitarProducto,
	o.DescripcionLegal,
	o.UsuarioRegistro,
	o.FechaRegistro,
	o.UsuarioModificacion,
	o.FechaModificacion,
	o.ImagenMini,
	pc.MarcaID, 
	op.Orden, 
	o.CodigoCategoria, 
	o.TipNegocio,
	pc.CodigoProducto, 
	cat.Descripcion AS DescripcionCategoria, 
	o.EsSubCampania

	FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.ProductoComercial pc ON o.CUV = pc.CUV AND o.CampaniaID = pc.CampaniaID
		INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
		INNER JOIN @tablaEventoConsultora ec ON c.Codigo = ec.CampaniaID	
		INNER JOIN @tablaCuvsPersonalizadas op ON op.AnioCampanaVenta= ec.CampaniaID AND op.CUV = o.CUV
		LEFT JOIN ShowRoom.Categoria cat ON
			ec.EventoID = cat.EventoID
			AND o.CodigoCategoria = cat.Codigo
	WHERE 
		c.Codigo = @CampaniaID
		AND ec.CodigoConsultora = @CodigoConsultora
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV FROM @tablaFaltante
		)
	ORDER BY op.Orden
END

GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( '[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] AS SET NOCOUNT ON;')
GO
--[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] 201802, '000758604'
ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]
@CampaniaID INT,
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	DECLARE @tablaEventoConsultora TABLE 
	(
		EventoConsultoraID INT,
		EventoID INT,
		CampaniaID INT,
		CodigoConsultora VARCHAR(20),
		Segmento VARCHAR(50),
		MostrarPopup BIT,
		MostrarPopupVenta BIT,
		FechaCreacion DATETIME,
		UsuarioCreacion VARCHAR(20), 
		FechaModificacion DATETIME,
		UsuarioModificacion VARCHAR(20)
	)

	INSERT INTO @tablaEventoConsultora
	SELECT TOP 1
	EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
	FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID AND CodigoConsultora = @CodigoConsultora
	ORDER BY EventoConsultoraID DESC

	DECLARE @tablaCuvsPersonalizadas TABLE (CUV VARCHAR(10), Orden INT, AnioCampanaVenta INT)

	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Existe en ofertas personalizadas'
		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END
	ELSE 
	BEGIN
		--PRINT 'NO Existe en ofertas personalizadas, buscar generico'
		--Buscar el valor generico
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END

	--select * from @tablaCuvsPersonalizadas

	/*Validacion FaltanteAnunciado y ProductoFaltante*/
	DECLARE @ZonaID INT
	DECLARE @CodigoRegion VARCHAR(2)
	DECLARE @CodigoZona VARCHAR(4)

	SELECT TOP 1 
	@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	FROM ods.Consultora c
	INNER JOIN ods.Zona z ON
		c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r on
		c.RegionID = r.RegionID
	WHERE c.Codigo = @CodigoConsultora

	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT 
		DISTINCT LTRIM(RTRIM(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE 
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	SELECT 
		DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa (NOLOCK)
	INNER JOIN ods.Campania c (NOLOCK) ON 
		fa.CampaniaID = c.CampaniaID
	WHERE 
		c.Codigo = @CampaniaID 
		AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
		AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

	SELECT
	o.OfertaShowRoomID,
	o.CampaniaID,o.CUV,
	o.TipoOfertaSisID,
	o.ConfiguracionOfertaID,
	o.Descripcion,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
	o.Stock,
	o.StockInicial,
	o.ImagenProducto,
	o.UnidadesPermitidas,
	o.FlagHabilitarProducto,
	o.DescripcionLegal,
	o.UsuarioRegistro,
	o.FechaRegistro,
	o.UsuarioModificacion,
	o.FechaModificacion,
	o.ImagenMini,
	pc.MarcaID, 
	op.Orden, 
	o.CodigoCategoria, 
	o.TipNegocio,
	pc.CodigoProducto, 
	cat.Descripcion AS DescripcionCategoria, 
	o.EsSubCampania

	FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.ProductoComercial pc ON o.CUV = pc.CUV AND o.CampaniaID = pc.CampaniaID
		INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
		INNER JOIN @tablaEventoConsultora ec ON c.Codigo = ec.CampaniaID	
		INNER JOIN @tablaCuvsPersonalizadas op ON op.AnioCampanaVenta= ec.CampaniaID AND op.CUV = o.CUV
		LEFT JOIN ShowRoom.Categoria cat ON
			ec.EventoID = cat.EventoID
			AND o.CodigoCategoria = cat.Codigo
	WHERE 
		c.Codigo = @CampaniaID
		AND ec.CodigoConsultora = @CodigoConsultora
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV FROM @tablaFaltante
		)
	ORDER BY op.Orden
END

GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( '[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] AS SET NOCOUNT ON;')
GO
--[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] 201802, '000758604'
ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]
@CampaniaID INT,
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	DECLARE @tablaEventoConsultora TABLE 
	(
		EventoConsultoraID INT,
		EventoID INT,
		CampaniaID INT,
		CodigoConsultora VARCHAR(20),
		Segmento VARCHAR(50),
		MostrarPopup BIT,
		MostrarPopupVenta BIT,
		FechaCreacion DATETIME,
		UsuarioCreacion VARCHAR(20), 
		FechaModificacion DATETIME,
		UsuarioModificacion VARCHAR(20)
	)

	INSERT INTO @tablaEventoConsultora
	SELECT TOP 1
	EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
	FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID AND CodigoConsultora = @CodigoConsultora
	ORDER BY EventoConsultoraID DESC

	DECLARE @tablaCuvsPersonalizadas TABLE (CUV VARCHAR(10), Orden INT, AnioCampanaVenta INT)

	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Existe en ofertas personalizadas'
		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END
	ELSE 
	BEGIN
		--PRINT 'NO Existe en ofertas personalizadas, buscar generico'
		--Buscar el valor generico
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END

	--select * from @tablaCuvsPersonalizadas

	/*Validacion FaltanteAnunciado y ProductoFaltante*/
	DECLARE @ZonaID INT
	DECLARE @CodigoRegion VARCHAR(2)
	DECLARE @CodigoZona VARCHAR(4)

	SELECT TOP 1 
	@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	FROM ods.Consultora c
	INNER JOIN ods.Zona z ON
		c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r on
		c.RegionID = r.RegionID
	WHERE c.Codigo = @CodigoConsultora

	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT 
		DISTINCT LTRIM(RTRIM(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE 
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	SELECT 
		DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa (NOLOCK)
	INNER JOIN ods.Campania c (NOLOCK) ON 
		fa.CampaniaID = c.CampaniaID
	WHERE 
		c.Codigo = @CampaniaID 
		AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
		AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

	SELECT
	o.OfertaShowRoomID,
	o.CampaniaID,o.CUV,
	o.TipoOfertaSisID,
	o.ConfiguracionOfertaID,
	o.Descripcion,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
	o.Stock,
	o.StockInicial,
	o.ImagenProducto,
	o.UnidadesPermitidas,
	o.FlagHabilitarProducto,
	o.DescripcionLegal,
	o.UsuarioRegistro,
	o.FechaRegistro,
	o.UsuarioModificacion,
	o.FechaModificacion,
	o.ImagenMini,
	pc.MarcaID, 
	op.Orden, 
	o.CodigoCategoria, 
	o.TipNegocio,
	pc.CodigoProducto, 
	cat.Descripcion AS DescripcionCategoria, 
	o.EsSubCampania

	FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.ProductoComercial pc ON o.CUV = pc.CUV AND o.CampaniaID = pc.CampaniaID
		INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
		INNER JOIN @tablaEventoConsultora ec ON c.Codigo = ec.CampaniaID	
		INNER JOIN @tablaCuvsPersonalizadas op ON op.AnioCampanaVenta= ec.CampaniaID AND op.CUV = o.CUV
		LEFT JOIN ShowRoom.Categoria cat ON
			ec.EventoID = cat.EventoID
			AND o.CodigoCategoria = cat.Codigo
	WHERE 
		c.Codigo = @CampaniaID
		AND ec.CodigoConsultora = @CodigoConsultora
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV FROM @tablaFaltante
		)
	ORDER BY op.Orden
END

GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( '[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] AS SET NOCOUNT ON;')
GO
--[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] 201802, '000758604'
ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]
@CampaniaID INT,
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	DECLARE @tablaEventoConsultora TABLE 
	(
		EventoConsultoraID INT,
		EventoID INT,
		CampaniaID INT,
		CodigoConsultora VARCHAR(20),
		Segmento VARCHAR(50),
		MostrarPopup BIT,
		MostrarPopupVenta BIT,
		FechaCreacion DATETIME,
		UsuarioCreacion VARCHAR(20), 
		FechaModificacion DATETIME,
		UsuarioModificacion VARCHAR(20)
	)

	INSERT INTO @tablaEventoConsultora
	SELECT TOP 1
	EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
	FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID AND CodigoConsultora = @CodigoConsultora
	ORDER BY EventoConsultoraID DESC

	DECLARE @tablaCuvsPersonalizadas TABLE (CUV VARCHAR(10), Orden INT, AnioCampanaVenta INT)

	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Existe en ofertas personalizadas'
		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END
	ELSE 
	BEGIN
		--PRINT 'NO Existe en ofertas personalizadas, buscar generico'
		--Buscar el valor generico
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END

	--select * from @tablaCuvsPersonalizadas

	/*Validacion FaltanteAnunciado y ProductoFaltante*/
	DECLARE @ZonaID INT
	DECLARE @CodigoRegion VARCHAR(2)
	DECLARE @CodigoZona VARCHAR(4)

	SELECT TOP 1 
	@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	FROM ods.Consultora c
	INNER JOIN ods.Zona z ON
		c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r on
		c.RegionID = r.RegionID
	WHERE c.Codigo = @CodigoConsultora

	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT 
		DISTINCT LTRIM(RTRIM(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE 
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	SELECT 
		DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa (NOLOCK)
	INNER JOIN ods.Campania c (NOLOCK) ON 
		fa.CampaniaID = c.CampaniaID
	WHERE 
		c.Codigo = @CampaniaID 
		AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
		AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

	SELECT
	o.OfertaShowRoomID,
	o.CampaniaID,o.CUV,
	o.TipoOfertaSisID,
	o.ConfiguracionOfertaID,
	o.Descripcion,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
	o.Stock,
	o.StockInicial,
	o.ImagenProducto,
	o.UnidadesPermitidas,
	o.FlagHabilitarProducto,
	o.DescripcionLegal,
	o.UsuarioRegistro,
	o.FechaRegistro,
	o.UsuarioModificacion,
	o.FechaModificacion,
	o.ImagenMini,
	pc.MarcaID, 
	op.Orden, 
	o.CodigoCategoria, 
	o.TipNegocio,
	pc.CodigoProducto, 
	cat.Descripcion AS DescripcionCategoria, 
	o.EsSubCampania

	FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.ProductoComercial pc ON o.CUV = pc.CUV AND o.CampaniaID = pc.CampaniaID
		INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
		INNER JOIN @tablaEventoConsultora ec ON c.Codigo = ec.CampaniaID	
		INNER JOIN @tablaCuvsPersonalizadas op ON op.AnioCampanaVenta= ec.CampaniaID AND op.CUV = o.CUV
		LEFT JOIN ShowRoom.Categoria cat ON
			ec.EventoID = cat.EventoID
			AND o.CodigoCategoria = cat.Codigo
	WHERE 
		c.Codigo = @CampaniaID
		AND ec.CodigoConsultora = @CodigoConsultora
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV FROM @tablaFaltante
		)
	ORDER BY op.Orden
END

GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( '[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] AS SET NOCOUNT ON;')
GO
--[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] 201802, '000758604'
ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]
@CampaniaID INT,
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	DECLARE @tablaEventoConsultora TABLE 
	(
		EventoConsultoraID INT,
		EventoID INT,
		CampaniaID INT,
		CodigoConsultora VARCHAR(20),
		Segmento VARCHAR(50),
		MostrarPopup BIT,
		MostrarPopupVenta BIT,
		FechaCreacion DATETIME,
		UsuarioCreacion VARCHAR(20), 
		FechaModificacion DATETIME,
		UsuarioModificacion VARCHAR(20)
	)

	INSERT INTO @tablaEventoConsultora
	SELECT TOP 1
	EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
	FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID AND CodigoConsultora = @CodigoConsultora
	ORDER BY EventoConsultoraID DESC

	DECLARE @tablaCuvsPersonalizadas TABLE (CUV VARCHAR(10), Orden INT, AnioCampanaVenta INT)

	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Existe en ofertas personalizadas'
		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END
	ELSE 
	BEGIN
		--PRINT 'NO Existe en ofertas personalizadas, buscar generico'
		--Buscar el valor generico
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END

	--select * from @tablaCuvsPersonalizadas

	/*Validacion FaltanteAnunciado y ProductoFaltante*/
	DECLARE @ZonaID INT
	DECLARE @CodigoRegion VARCHAR(2)
	DECLARE @CodigoZona VARCHAR(4)

	SELECT TOP 1 
	@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	FROM ods.Consultora c
	INNER JOIN ods.Zona z ON
		c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r on
		c.RegionID = r.RegionID
	WHERE c.Codigo = @CodigoConsultora

	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT 
		DISTINCT LTRIM(RTRIM(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE 
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	SELECT 
		DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa (NOLOCK)
	INNER JOIN ods.Campania c (NOLOCK) ON 
		fa.CampaniaID = c.CampaniaID
	WHERE 
		c.Codigo = @CampaniaID 
		AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
		AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

	SELECT
	o.OfertaShowRoomID,
	o.CampaniaID,o.CUV,
	o.TipoOfertaSisID,
	o.ConfiguracionOfertaID,
	o.Descripcion,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
	o.Stock,
	o.StockInicial,
	o.ImagenProducto,
	o.UnidadesPermitidas,
	o.FlagHabilitarProducto,
	o.DescripcionLegal,
	o.UsuarioRegistro,
	o.FechaRegistro,
	o.UsuarioModificacion,
	o.FechaModificacion,
	o.ImagenMini,
	pc.MarcaID, 
	op.Orden, 
	o.CodigoCategoria, 
	o.TipNegocio,
	pc.CodigoProducto, 
	cat.Descripcion AS DescripcionCategoria, 
	o.EsSubCampania

	FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.ProductoComercial pc ON o.CUV = pc.CUV AND o.CampaniaID = pc.CampaniaID
		INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
		INNER JOIN @tablaEventoConsultora ec ON c.Codigo = ec.CampaniaID	
		INNER JOIN @tablaCuvsPersonalizadas op ON op.AnioCampanaVenta= ec.CampaniaID AND op.CUV = o.CUV
		LEFT JOIN ShowRoom.Categoria cat ON
			ec.EventoID = cat.EventoID
			AND o.CodigoCategoria = cat.Codigo
	WHERE 
		c.Codigo = @CampaniaID
		AND ec.CodigoConsultora = @CodigoConsultora
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV FROM @tablaFaltante
		)
	ORDER BY op.Orden
END

GO

USE BelcorpChile
GO

IF (OBJECT_ID ( '[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] AS SET NOCOUNT ON;')
GO
--[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] 201802, '000758604'
ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]
@CampaniaID INT,
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	DECLARE @tablaEventoConsultora TABLE 
	(
		EventoConsultoraID INT,
		EventoID INT,
		CampaniaID INT,
		CodigoConsultora VARCHAR(20),
		Segmento VARCHAR(50),
		MostrarPopup BIT,
		MostrarPopupVenta BIT,
		FechaCreacion DATETIME,
		UsuarioCreacion VARCHAR(20), 
		FechaModificacion DATETIME,
		UsuarioModificacion VARCHAR(20)
	)

	INSERT INTO @tablaEventoConsultora
	SELECT TOP 1
	EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
	FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID AND CodigoConsultora = @CodigoConsultora
	ORDER BY EventoConsultoraID DESC

	DECLARE @tablaCuvsPersonalizadas TABLE (CUV VARCHAR(10), Orden INT, AnioCampanaVenta INT)

	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Existe en ofertas personalizadas'
		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END
	ELSE 
	BEGIN
		--PRINT 'NO Existe en ofertas personalizadas, buscar generico'
		--Buscar el valor generico
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END

	--select * from @tablaCuvsPersonalizadas

	/*Validacion FaltanteAnunciado y ProductoFaltante*/
	DECLARE @ZonaID INT
	DECLARE @CodigoRegion VARCHAR(2)
	DECLARE @CodigoZona VARCHAR(4)

	SELECT TOP 1 
	@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	FROM ods.Consultora c
	INNER JOIN ods.Zona z ON
		c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r on
		c.RegionID = r.RegionID
	WHERE c.Codigo = @CodigoConsultora

	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT 
		DISTINCT LTRIM(RTRIM(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE 
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	SELECT 
		DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa (NOLOCK)
	INNER JOIN ods.Campania c (NOLOCK) ON 
		fa.CampaniaID = c.CampaniaID
	WHERE 
		c.Codigo = @CampaniaID 
		AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
		AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

	SELECT
	o.OfertaShowRoomID,
	o.CampaniaID,o.CUV,
	o.TipoOfertaSisID,
	o.ConfiguracionOfertaID,
	o.Descripcion,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
	o.Stock,
	o.StockInicial,
	o.ImagenProducto,
	o.UnidadesPermitidas,
	o.FlagHabilitarProducto,
	o.DescripcionLegal,
	o.UsuarioRegistro,
	o.FechaRegistro,
	o.UsuarioModificacion,
	o.FechaModificacion,
	o.ImagenMini,
	pc.MarcaID, 
	op.Orden, 
	o.CodigoCategoria, 
	o.TipNegocio,
	pc.CodigoProducto, 
	cat.Descripcion AS DescripcionCategoria, 
	o.EsSubCampania

	FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.ProductoComercial pc ON o.CUV = pc.CUV AND o.CampaniaID = pc.CampaniaID
		INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
		INNER JOIN @tablaEventoConsultora ec ON c.Codigo = ec.CampaniaID	
		INNER JOIN @tablaCuvsPersonalizadas op ON op.AnioCampanaVenta= ec.CampaniaID AND op.CUV = o.CUV
		LEFT JOIN ShowRoom.Categoria cat ON
			ec.EventoID = cat.EventoID
			AND o.CodigoCategoria = cat.Codigo
	WHERE 
		c.Codigo = @CampaniaID
		AND ec.CodigoConsultora = @CodigoConsultora
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV FROM @tablaFaltante
		)
	ORDER BY op.Orden
END

GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( '[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] AS SET NOCOUNT ON;')
GO
--[ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada] 201802, '000758604'
ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultoraPersonalizada]
@CampaniaID INT,
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	DECLARE @tablaEventoConsultora TABLE 
	(
		EventoConsultoraID INT,
		EventoID INT,
		CampaniaID INT,
		CodigoConsultora VARCHAR(20),
		Segmento VARCHAR(50),
		MostrarPopup BIT,
		MostrarPopupVenta BIT,
		FechaCreacion DATETIME,
		UsuarioCreacion VARCHAR(20), 
		FechaModificacion DATETIME,
		UsuarioModificacion VARCHAR(20)
	)

	INSERT INTO @tablaEventoConsultora
	SELECT TOP 1
	EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
	FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID AND CodigoConsultora = @CodigoConsultora
	ORDER BY EventoConsultoraID DESC

	DECLARE @tablaCuvsPersonalizadas TABLE (CUV VARCHAR(10), Orden INT, AnioCampanaVenta INT)

	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Existe en ofertas personalizadas'
		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END
	ELSE 
	BEGIN
		--PRINT 'NO Existe en ofertas personalizadas, buscar generico'
		--Buscar el valor generico
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @tablaCuvsPersonalizadas
		SELECT CUV, Orden, AnioCampanaVenta FROM ods.ofertaspersonalizadas op 
		WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'SR'
	END

	--select * from @tablaCuvsPersonalizadas

	/*Validacion FaltanteAnunciado y ProductoFaltante*/
	DECLARE @ZonaID INT
	DECLARE @CodigoRegion VARCHAR(2)
	DECLARE @CodigoZona VARCHAR(4)

	SELECT TOP 1 
	@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	FROM ods.Consultora c
	INNER JOIN ods.Zona z ON
		c.ZonaID = z.ZonaID
	INNER JOIN ods.Region r on
		c.RegionID = r.RegionID
	WHERE c.Codigo = @CodigoConsultora

	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaFaltante
	SELECT 
		DISTINCT LTRIM(RTRIM(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE 
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	SELECT 
		DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa (NOLOCK)
	INNER JOIN ods.Campania c (NOLOCK) ON 
		fa.CampaniaID = c.CampaniaID
	WHERE 
		c.Codigo = @CampaniaID 
		AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
		AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

	SELECT
	o.OfertaShowRoomID,
	o.CampaniaID,o.CUV,
	o.TipoOfertaSisID,
	o.ConfiguracionOfertaID,
	o.Descripcion,
	o.PrecioValorizado,
	COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
	o.Stock,
	o.StockInicial,
	o.ImagenProducto,
	o.UnidadesPermitidas,
	o.FlagHabilitarProducto,
	o.DescripcionLegal,
	o.UsuarioRegistro,
	o.FechaRegistro,
	o.UsuarioModificacion,
	o.FechaModificacion,
	o.ImagenMini,
	pc.MarcaID, 
	op.Orden, 
	o.CodigoCategoria, 
	o.TipNegocio,
	pc.CodigoProducto, 
	cat.Descripcion AS DescripcionCategoria, 
	o.EsSubCampania

	FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.ProductoComercial pc ON o.CUV = pc.CUV AND o.CampaniaID = pc.CampaniaID
		INNER JOIN ods.Campania c ON o.CampaniaID = c.CampaniaID
		INNER JOIN @tablaEventoConsultora ec ON c.Codigo = ec.CampaniaID	
		INNER JOIN @tablaCuvsPersonalizadas op ON op.AnioCampanaVenta= ec.CampaniaID AND op.CUV = o.CUV
		LEFT JOIN ShowRoom.Categoria cat ON
			ec.EventoID = cat.EventoID
			AND o.CodigoCategoria = cat.Codigo
	WHERE 
		c.Codigo = @CampaniaID
		AND ec.CodigoConsultora = @CodigoConsultora
		AND o.FlagHabilitarProducto = 1
		AND o.CUV NOT IN (
			SELECT CUV FROM @tablaFaltante
		)
	ORDER BY op.Orden
END

GO

