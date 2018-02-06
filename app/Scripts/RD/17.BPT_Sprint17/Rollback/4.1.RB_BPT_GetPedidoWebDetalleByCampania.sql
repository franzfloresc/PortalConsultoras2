USE BelcorpPeru
GO

GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByCampania 
	@CampaniaID	INT,
	@ConsultoraID	BIGINT,
	@CodigoPrograma varchar(15) = NULL,
	@NumeroPedido int = 0 
 AS 
 /* 
 GetPedidoWebDetalleByCampania 201716, 33901, '043', 4 
 GetPedidoWebDetalleByCampania_SB2 201716, 339 01 
 */ 
BEGIN 
SET NOCOUNT ON

SET @CodigoPrograma = CASE WHEN @CodigoPrograma = '' THEN NULL ELSE @CodigoPrograma END 
SET @NumeroPedido = CASE WHEN @NumeroPedido > 0 THEN @NumeroPedido + 1 ELSE 0 END 

DECLARE @PedidoDetalle AS TABLE (
	CampaniaID int,
	PedidoID int,
	PedidoDetalleID int,
	MarcaID tinyint,
	ConsultoraID bigint,
	ClienteID smallint,
	OrdenPedidoWD int,
	Cantidad int,
	PrecioUnidad money,
	ImporteTotal money,
	CUV varchar(20),
	EsKitNueva bit,
	DescripcionProd varchar(800),
	ClienteNombre varchar(200),
	OfertaWeb bit,
	IndicadorMontoMinimo int,
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	TipoPedido char(1),
	DescripcionOferta varchar(200),
	MarcaDescripcion varchar(20),
	CategoriaNombre varchar(50),
	DescripcionEstrategia varchar(200),
	TipoEstrategiaID int,
	IndicadorOfertaCUV bit,
	FlagConsultoraOnline int,
	DescuentoProl money,
	MontoEscala money,
	MontoAhorroCatalogo money,
	MontoAhorroRevista money,
	OrigenPedidoWeb int,
	EsBackOrder bit,
	AceptoBackOrder bit,
	CodigoCatalago char(6),
	TipoEstrategiaCodigo varchar(100),
	EsOfertaIndependiente bit,
	CodigoTipoOferta char(6),
PRIMARY KEY (CampaniaID, PedidoID, PedidoDetalleID) 
) 

INSERT INTO @PedidoDetalle 
SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(MC.Descripcion,
		OP.Descripcion,
		PD.Descripcion,
		PC.Descripcion) AS DescripcionProd, -- FALTA 
	C.Nombre AS ClienteNombre,
	PWD.OfertaWeb,
	PC.IndicadorMontoMinimo,
	PWD.ConfiguracionOfertaID,
	PWD.TipoOfertaSisID,
	PWD.TipoPedido,
	'' AS DescripcionOferta,
	M.Descripcion AS MarcaDescripcion,
	'NO DISPONIBLE' AS Categoria,
	'' AS DescripcionEstrategia,
	0 AS TipoEstrategiaID,
	PC.IndicadorOferta AS IndicadorOfertaCUV,
	0 AS FlagConsultoraOnline,
	PW.DescuentoProl,
	PW.MontoEscala,
	PW.MontoAhorroCatalogo,
	PW.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PC.CodigoCatalago,
	'' AS TipoEstrategiaCodigo,
	0 AS EsOfertaIndependiente,
	PC.CodigoTipoOferta 
FROM dbo.PedidoWebDetalle PWD WITH (NOLOCK) 
INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) 
	ON PW.CampaniaID = PWD.CampaniaID 
	AND PW.PedidoID = PWD.PedidoID 
	and PW.ConsultoraID = PWD.ConsultoraID 
INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) 
	ON PWD.CampaniaID = PC.AnoCampania 
	AND PWD.CUV = PC.CUV 
LEFT JOIN dbo.Cliente C WITH (NOLOCK) 
	ON PWD.ClienteID = C.ClienteID 
	AND PWD.ConsultoraID = C.ConsultoraID 
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) 
	ON PWD.CampaniaID = PD.CampaniaID 
	AND PWD.CUV = PD.CUV 
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) 
	ON OP.CampaniaID = PC.CampaniaID 
	AND OP.CUV = PC.CUV 
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) 
	on PC.CodigoProducto = MC.CodigoSAP 
LEFT JOIN dbo.Marca M WITH (NOLOCK) 
	ON PWD.MarcaId = M.MarcaId 
WHERE	pwd.CampaniaID = @CampaniaID 
	AND pwd.ConsultoraID = @ConsultoraID 
	AND pwd.CUVPadre IS NULL 
	
DECLARE @Estrategia AS TABLE( 
	EstrategiaID int,
	TipoEstrategiaID int,
	Activo bit,
	CampaniaID int,
	CampaniaIDFin int,
	CUV2 varchar(20),
	Numeropedido int,
	DescripcionEstrategia varchar(800),
	EsOfertaIndependiente bit,
	FlagNueva bit,
	DescripcionTipoEstrategia varchar(200),
	TipoEstrategiaCodigo varchar(100),
	CodigoPrograma varchar(3),
PRIMARY KEY (EstrategiaID) 
) 
 
INSERT INTO @Estrategia 
SELECT DISTINCT 
	E.EstrategiaID,
	E.TipoEstrategiaID,
	E.Activo,
	E.CampaniaID,
	E.CampaniaIDFin,
	E.CUV2,
	E.Numeropedido,
	E.DescripcionCUV2 AS DescripcionEstrategia,
	E.EsOfertaIndependiente,
	TE.FlagNueva,
	TE.DescripcionEstrategia AS DescripcionTipoEstrategia,
	TE.Codigo AS TipoEstrategiaCodigo,
	TE.CodigoPrograma 
FROM dbo.Estrategia E WITH (NOLOCK) 
INNER JOIN TipoEstrategia TE WITH (NOLOCK) 
	ON TE.TipoEstrategiaID = E.TipoEstrategiaID 
INNER JOIN @PedidoDetalle PWD 
	ON PWD.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END 
	AND E.CUV2 = PWD.CUV 
	AND E.Activo = 1 
WHERE TE.FlagActivo = 1 


IF @CodigoPrograma IS NOT NULL 
BEGIN 
	DELETE FROM @Estrategia 
	WHERE isnull(CodigoPrograma, '') <> '' 
	AND (
		(CodigoPrograma <> @CodigoPrograma AND Numeropedido <> @NumeroPedido) 
		OR (CodigoPrograma = @CodigoPrograma AND Numeropedido <> @NumeroPedido)
	) 

END 


SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(EST.DescripcionEstrategia,
		PWD.DescripcionProd) AS DescripcionProd,
	PWD.ClienteNombre AS Nombre,
	PWD.OfertaWeb,
	PWD.IndicadorMontoMinimo,
	ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID,
	ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID,
	ISNULL(PWD.TipoPedido, 'W') TipoPedido,
	EST.DescripcionTipoEstrategia AS DescripcionOferta,
	PWD.MarcaDescripcion AS DescripcionLarga,
	'NO DISPONIBLE' AS Categoria,
	EST.DescripcionTipoEstrategia AS DescripcionEstrategia,
	CASE WHEN EST.FlagNueva = 1 AND @CodigoPrograma IS NOT NULL THEN 1 
		ELSE 0 END AS FlagNueva,
	PWD.IndicadorOfertaCUV,
	PWD.FlagConsultoraOnline,
	PWD.DescuentoProl,
	PWD.MontoEscala,
	PWD.MontoAhorroCatalogo,
	PWD.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PWD.CodigoCatalago,
	EST.TipoEstrategiaCodigo,
	EST.EsOfertaIndependiente,
	EST.EstrategiaID,
	EST.TipoEstrategiaID,
	EST.Numeropedido
FROM @PedidoDetalle PWD 
LEFT JOIN @Estrategia EST 
	ON EST.CUV2 = PWD.CUV 
ORDER BY PWD.OrdenPedidoWD DESC,
PWD.PedidoDetalleID DESC 

END

GO

USE BelcorpMexico
GO

GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByCampania 
	@CampaniaID	INT,
	@ConsultoraID	BIGINT,
	@CodigoPrograma varchar(15) = NULL,
	@NumeroPedido int = 0 
 AS 
 /* 
 GetPedidoWebDetalleByCampania 201716, 33901, '043', 4 
 GetPedidoWebDetalleByCampania_SB2 201716, 339 01 
 */ 
BEGIN 
SET NOCOUNT ON

SET @CodigoPrograma = CASE WHEN @CodigoPrograma = '' THEN NULL ELSE @CodigoPrograma END 
SET @NumeroPedido = CASE WHEN @NumeroPedido > 0 THEN @NumeroPedido + 1 ELSE 0 END 

DECLARE @PedidoDetalle AS TABLE (
	CampaniaID int,
	PedidoID int,
	PedidoDetalleID int,
	MarcaID tinyint,
	ConsultoraID bigint,
	ClienteID smallint,
	OrdenPedidoWD int,
	Cantidad int,
	PrecioUnidad money,
	ImporteTotal money,
	CUV varchar(20),
	EsKitNueva bit,
	DescripcionProd varchar(800),
	ClienteNombre varchar(200),
	OfertaWeb bit,
	IndicadorMontoMinimo int,
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	TipoPedido char(1),
	DescripcionOferta varchar(200),
	MarcaDescripcion varchar(20),
	CategoriaNombre varchar(50),
	DescripcionEstrategia varchar(200),
	TipoEstrategiaID int,
	IndicadorOfertaCUV bit,
	FlagConsultoraOnline int,
	DescuentoProl money,
	MontoEscala money,
	MontoAhorroCatalogo money,
	MontoAhorroRevista money,
	OrigenPedidoWeb int,
	EsBackOrder bit,
	AceptoBackOrder bit,
	CodigoCatalago char(6),
	TipoEstrategiaCodigo varchar(100),
	EsOfertaIndependiente bit,
	CodigoTipoOferta char(6),
PRIMARY KEY (CampaniaID, PedidoID, PedidoDetalleID) 
) 

INSERT INTO @PedidoDetalle 
SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(MC.Descripcion,
		OP.Descripcion,
		PD.Descripcion,
		PC.Descripcion) AS DescripcionProd, -- FALTA 
	C.Nombre AS ClienteNombre,
	PWD.OfertaWeb,
	PC.IndicadorMontoMinimo,
	PWD.ConfiguracionOfertaID,
	PWD.TipoOfertaSisID,
	PWD.TipoPedido,
	'' AS DescripcionOferta,
	M.Descripcion AS MarcaDescripcion,
	'NO DISPONIBLE' AS Categoria,
	'' AS DescripcionEstrategia,
	0 AS TipoEstrategiaID,
	PC.IndicadorOferta AS IndicadorOfertaCUV,
	0 AS FlagConsultoraOnline,
	PW.DescuentoProl,
	PW.MontoEscala,
	PW.MontoAhorroCatalogo,
	PW.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PC.CodigoCatalago,
	'' AS TipoEstrategiaCodigo,
	0 AS EsOfertaIndependiente,
	PC.CodigoTipoOferta 
FROM dbo.PedidoWebDetalle PWD WITH (NOLOCK) 
INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) 
	ON PW.CampaniaID = PWD.CampaniaID 
	AND PW.PedidoID = PWD.PedidoID 
	and PW.ConsultoraID = PWD.ConsultoraID 
INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) 
	ON PWD.CampaniaID = PC.AnoCampania 
	AND PWD.CUV = PC.CUV 
LEFT JOIN dbo.Cliente C WITH (NOLOCK) 
	ON PWD.ClienteID = C.ClienteID 
	AND PWD.ConsultoraID = C.ConsultoraID 
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) 
	ON PWD.CampaniaID = PD.CampaniaID 
	AND PWD.CUV = PD.CUV 
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) 
	ON OP.CampaniaID = PC.CampaniaID 
	AND OP.CUV = PC.CUV 
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) 
	on PC.CodigoProducto = MC.CodigoSAP 
LEFT JOIN dbo.Marca M WITH (NOLOCK) 
	ON PWD.MarcaId = M.MarcaId 
WHERE	pwd.CampaniaID = @CampaniaID 
	AND pwd.ConsultoraID = @ConsultoraID 
	AND pwd.CUVPadre IS NULL 
	
DECLARE @Estrategia AS TABLE( 
	EstrategiaID int,
	TipoEstrategiaID int,
	Activo bit,
	CampaniaID int,
	CampaniaIDFin int,
	CUV2 varchar(20),
	Numeropedido int,
	DescripcionEstrategia varchar(800),
	EsOfertaIndependiente bit,
	FlagNueva bit,
	DescripcionTipoEstrategia varchar(200),
	TipoEstrategiaCodigo varchar(100),
	CodigoPrograma varchar(3),
PRIMARY KEY (EstrategiaID) 
) 
 
INSERT INTO @Estrategia 
SELECT DISTINCT 
	E.EstrategiaID,
	E.TipoEstrategiaID,
	E.Activo,
	E.CampaniaID,
	E.CampaniaIDFin,
	E.CUV2,
	E.Numeropedido,
	E.DescripcionCUV2 AS DescripcionEstrategia,
	E.EsOfertaIndependiente,
	TE.FlagNueva,
	TE.DescripcionEstrategia AS DescripcionTipoEstrategia,
	TE.Codigo AS TipoEstrategiaCodigo,
	TE.CodigoPrograma 
FROM dbo.Estrategia E WITH (NOLOCK) 
INNER JOIN TipoEstrategia TE WITH (NOLOCK) 
	ON TE.TipoEstrategiaID = E.TipoEstrategiaID 
INNER JOIN @PedidoDetalle PWD 
	ON PWD.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END 
	AND E.CUV2 = PWD.CUV 
	AND E.Activo = 1 
WHERE TE.FlagActivo = 1 


IF @CodigoPrograma IS NOT NULL 
BEGIN 
	DELETE FROM @Estrategia 
	WHERE isnull(CodigoPrograma, '') <> '' 
	AND (
		(CodigoPrograma <> @CodigoPrograma AND Numeropedido <> @NumeroPedido) 
		OR (CodigoPrograma = @CodigoPrograma AND Numeropedido <> @NumeroPedido)
	) 

END 


SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(EST.DescripcionEstrategia,
		PWD.DescripcionProd) AS DescripcionProd,
	PWD.ClienteNombre AS Nombre,
	PWD.OfertaWeb,
	PWD.IndicadorMontoMinimo,
	ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID,
	ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID,
	ISNULL(PWD.TipoPedido, 'W') TipoPedido,
	EST.DescripcionTipoEstrategia AS DescripcionOferta,
	PWD.MarcaDescripcion AS DescripcionLarga,
	'NO DISPONIBLE' AS Categoria,
	EST.DescripcionTipoEstrategia AS DescripcionEstrategia,
	CASE WHEN EST.FlagNueva = 1 AND @CodigoPrograma IS NOT NULL THEN 1 
		ELSE 0 END AS FlagNueva,
	PWD.IndicadorOfertaCUV,
	PWD.FlagConsultoraOnline,
	PWD.DescuentoProl,
	PWD.MontoEscala,
	PWD.MontoAhorroCatalogo,
	PWD.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PWD.CodigoCatalago,
	EST.TipoEstrategiaCodigo,
	EST.EsOfertaIndependiente,
	EST.EstrategiaID,
	EST.TipoEstrategiaID,
	EST.Numeropedido
FROM @PedidoDetalle PWD 
LEFT JOIN @Estrategia EST 
	ON EST.CUV2 = PWD.CUV 
ORDER BY PWD.OrdenPedidoWD DESC,
PWD.PedidoDetalleID DESC 

END

GO

USE BelcorpColombia
GO

GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByCampania 
	@CampaniaID	INT,
	@ConsultoraID	BIGINT,
	@CodigoPrograma varchar(15) = NULL,
	@NumeroPedido int = 0 
 AS 
 /* 
 GetPedidoWebDetalleByCampania 201716, 33901, '043', 4 
 GetPedidoWebDetalleByCampania_SB2 201716, 339 01 
 */ 
BEGIN 
SET NOCOUNT ON

SET @CodigoPrograma = CASE WHEN @CodigoPrograma = '' THEN NULL ELSE @CodigoPrograma END 
SET @NumeroPedido = CASE WHEN @NumeroPedido > 0 THEN @NumeroPedido + 1 ELSE 0 END 

DECLARE @PedidoDetalle AS TABLE (
	CampaniaID int,
	PedidoID int,
	PedidoDetalleID int,
	MarcaID tinyint,
	ConsultoraID bigint,
	ClienteID smallint,
	OrdenPedidoWD int,
	Cantidad int,
	PrecioUnidad money,
	ImporteTotal money,
	CUV varchar(20),
	EsKitNueva bit,
	DescripcionProd varchar(800),
	ClienteNombre varchar(200),
	OfertaWeb bit,
	IndicadorMontoMinimo int,
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	TipoPedido char(1),
	DescripcionOferta varchar(200),
	MarcaDescripcion varchar(20),
	CategoriaNombre varchar(50),
	DescripcionEstrategia varchar(200),
	TipoEstrategiaID int,
	IndicadorOfertaCUV bit,
	FlagConsultoraOnline int,
	DescuentoProl money,
	MontoEscala money,
	MontoAhorroCatalogo money,
	MontoAhorroRevista money,
	OrigenPedidoWeb int,
	EsBackOrder bit,
	AceptoBackOrder bit,
	CodigoCatalago char(6),
	TipoEstrategiaCodigo varchar(100),
	EsOfertaIndependiente bit,
	CodigoTipoOferta char(6),
PRIMARY KEY (CampaniaID, PedidoID, PedidoDetalleID) 
) 

INSERT INTO @PedidoDetalle 
SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(MC.Descripcion,
		OP.Descripcion,
		PD.Descripcion,
		PC.Descripcion) AS DescripcionProd, -- FALTA 
	C.Nombre AS ClienteNombre,
	PWD.OfertaWeb,
	PC.IndicadorMontoMinimo,
	PWD.ConfiguracionOfertaID,
	PWD.TipoOfertaSisID,
	PWD.TipoPedido,
	'' AS DescripcionOferta,
	M.Descripcion AS MarcaDescripcion,
	'NO DISPONIBLE' AS Categoria,
	'' AS DescripcionEstrategia,
	0 AS TipoEstrategiaID,
	PC.IndicadorOferta AS IndicadorOfertaCUV,
	0 AS FlagConsultoraOnline,
	PW.DescuentoProl,
	PW.MontoEscala,
	PW.MontoAhorroCatalogo,
	PW.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PC.CodigoCatalago,
	'' AS TipoEstrategiaCodigo,
	0 AS EsOfertaIndependiente,
	PC.CodigoTipoOferta 
FROM dbo.PedidoWebDetalle PWD WITH (NOLOCK) 
INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) 
	ON PW.CampaniaID = PWD.CampaniaID 
	AND PW.PedidoID = PWD.PedidoID 
	and PW.ConsultoraID = PWD.ConsultoraID 
INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) 
	ON PWD.CampaniaID = PC.AnoCampania 
	AND PWD.CUV = PC.CUV 
LEFT JOIN dbo.Cliente C WITH (NOLOCK) 
	ON PWD.ClienteID = C.ClienteID 
	AND PWD.ConsultoraID = C.ConsultoraID 
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) 
	ON PWD.CampaniaID = PD.CampaniaID 
	AND PWD.CUV = PD.CUV 
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) 
	ON OP.CampaniaID = PC.CampaniaID 
	AND OP.CUV = PC.CUV 
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) 
	on PC.CodigoProducto = MC.CodigoSAP 
LEFT JOIN dbo.Marca M WITH (NOLOCK) 
	ON PWD.MarcaId = M.MarcaId 
WHERE	pwd.CampaniaID = @CampaniaID 
	AND pwd.ConsultoraID = @ConsultoraID 
	AND pwd.CUVPadre IS NULL 
	
DECLARE @Estrategia AS TABLE( 
	EstrategiaID int,
	TipoEstrategiaID int,
	Activo bit,
	CampaniaID int,
	CampaniaIDFin int,
	CUV2 varchar(20),
	Numeropedido int,
	DescripcionEstrategia varchar(800),
	EsOfertaIndependiente bit,
	FlagNueva bit,
	DescripcionTipoEstrategia varchar(200),
	TipoEstrategiaCodigo varchar(100),
	CodigoPrograma varchar(3),
PRIMARY KEY (EstrategiaID) 
) 
 
INSERT INTO @Estrategia 
SELECT DISTINCT 
	E.EstrategiaID,
	E.TipoEstrategiaID,
	E.Activo,
	E.CampaniaID,
	E.CampaniaIDFin,
	E.CUV2,
	E.Numeropedido,
	E.DescripcionCUV2 AS DescripcionEstrategia,
	E.EsOfertaIndependiente,
	TE.FlagNueva,
	TE.DescripcionEstrategia AS DescripcionTipoEstrategia,
	TE.Codigo AS TipoEstrategiaCodigo,
	TE.CodigoPrograma 
FROM dbo.Estrategia E WITH (NOLOCK) 
INNER JOIN TipoEstrategia TE WITH (NOLOCK) 
	ON TE.TipoEstrategiaID = E.TipoEstrategiaID 
INNER JOIN @PedidoDetalle PWD 
	ON PWD.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END 
	AND E.CUV2 = PWD.CUV 
	AND E.Activo = 1 
WHERE TE.FlagActivo = 1 


IF @CodigoPrograma IS NOT NULL 
BEGIN 
	DELETE FROM @Estrategia 
	WHERE isnull(CodigoPrograma, '') <> '' 
	AND (
		(CodigoPrograma <> @CodigoPrograma AND Numeropedido <> @NumeroPedido) 
		OR (CodigoPrograma = @CodigoPrograma AND Numeropedido <> @NumeroPedido)
	) 

END 


SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(EST.DescripcionEstrategia,
		PWD.DescripcionProd) AS DescripcionProd,
	PWD.ClienteNombre AS Nombre,
	PWD.OfertaWeb,
	PWD.IndicadorMontoMinimo,
	ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID,
	ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID,
	ISNULL(PWD.TipoPedido, 'W') TipoPedido,
	EST.DescripcionTipoEstrategia AS DescripcionOferta,
	PWD.MarcaDescripcion AS DescripcionLarga,
	'NO DISPONIBLE' AS Categoria,
	EST.DescripcionTipoEstrategia AS DescripcionEstrategia,
	CASE WHEN EST.FlagNueva = 1 AND @CodigoPrograma IS NOT NULL THEN 1 
		ELSE 0 END AS FlagNueva,
	PWD.IndicadorOfertaCUV,
	PWD.FlagConsultoraOnline,
	PWD.DescuentoProl,
	PWD.MontoEscala,
	PWD.MontoAhorroCatalogo,
	PWD.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PWD.CodigoCatalago,
	EST.TipoEstrategiaCodigo,
	EST.EsOfertaIndependiente,
	EST.EstrategiaID,
	EST.TipoEstrategiaID,
	EST.Numeropedido
FROM @PedidoDetalle PWD 
LEFT JOIN @Estrategia EST 
	ON EST.CUV2 = PWD.CUV 
ORDER BY PWD.OrdenPedidoWD DESC,
PWD.PedidoDetalleID DESC 

END

GO

USE BelcorpVenezuela
GO

GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByCampania 
	@CampaniaID	INT,
	@ConsultoraID	BIGINT,
	@CodigoPrograma varchar(15) = NULL,
	@NumeroPedido int = 0 
 AS 
 /* 
 GetPedidoWebDetalleByCampania 201716, 33901, '043', 4 
 GetPedidoWebDetalleByCampania_SB2 201716, 339 01 
 */ 
BEGIN 
SET NOCOUNT ON

SET @CodigoPrograma = CASE WHEN @CodigoPrograma = '' THEN NULL ELSE @CodigoPrograma END 
SET @NumeroPedido = CASE WHEN @NumeroPedido > 0 THEN @NumeroPedido + 1 ELSE 0 END 

DECLARE @PedidoDetalle AS TABLE (
	CampaniaID int,
	PedidoID int,
	PedidoDetalleID int,
	MarcaID tinyint,
	ConsultoraID bigint,
	ClienteID smallint,
	OrdenPedidoWD int,
	Cantidad int,
	PrecioUnidad money,
	ImporteTotal money,
	CUV varchar(20),
	EsKitNueva bit,
	DescripcionProd varchar(800),
	ClienteNombre varchar(200),
	OfertaWeb bit,
	IndicadorMontoMinimo int,
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	TipoPedido char(1),
	DescripcionOferta varchar(200),
	MarcaDescripcion varchar(20),
	CategoriaNombre varchar(50),
	DescripcionEstrategia varchar(200),
	TipoEstrategiaID int,
	IndicadorOfertaCUV bit,
	FlagConsultoraOnline int,
	DescuentoProl money,
	MontoEscala money,
	MontoAhorroCatalogo money,
	MontoAhorroRevista money,
	OrigenPedidoWeb int,
	EsBackOrder bit,
	AceptoBackOrder bit,
	CodigoCatalago char(6),
	TipoEstrategiaCodigo varchar(100),
	EsOfertaIndependiente bit,
	CodigoTipoOferta char(6),
PRIMARY KEY (CampaniaID, PedidoID, PedidoDetalleID) 
) 

INSERT INTO @PedidoDetalle 
SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(MC.Descripcion,
		OP.Descripcion,
		PD.Descripcion,
		PC.Descripcion) AS DescripcionProd, -- FALTA 
	C.Nombre AS ClienteNombre,
	PWD.OfertaWeb,
	PC.IndicadorMontoMinimo,
	PWD.ConfiguracionOfertaID,
	PWD.TipoOfertaSisID,
	PWD.TipoPedido,
	'' AS DescripcionOferta,
	M.Descripcion AS MarcaDescripcion,
	'NO DISPONIBLE' AS Categoria,
	'' AS DescripcionEstrategia,
	0 AS TipoEstrategiaID,
	PC.IndicadorOferta AS IndicadorOfertaCUV,
	0 AS FlagConsultoraOnline,
	PW.DescuentoProl,
	PW.MontoEscala,
	PW.MontoAhorroCatalogo,
	PW.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PC.CodigoCatalago,
	'' AS TipoEstrategiaCodigo,
	0 AS EsOfertaIndependiente,
	PC.CodigoTipoOferta 
FROM dbo.PedidoWebDetalle PWD WITH (NOLOCK) 
INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) 
	ON PW.CampaniaID = PWD.CampaniaID 
	AND PW.PedidoID = PWD.PedidoID 
	and PW.ConsultoraID = PWD.ConsultoraID 
INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) 
	ON PWD.CampaniaID = PC.AnoCampania 
	AND PWD.CUV = PC.CUV 
LEFT JOIN dbo.Cliente C WITH (NOLOCK) 
	ON PWD.ClienteID = C.ClienteID 
	AND PWD.ConsultoraID = C.ConsultoraID 
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) 
	ON PWD.CampaniaID = PD.CampaniaID 
	AND PWD.CUV = PD.CUV 
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) 
	ON OP.CampaniaID = PC.CampaniaID 
	AND OP.CUV = PC.CUV 
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) 
	on PC.CodigoProducto = MC.CodigoSAP 
LEFT JOIN dbo.Marca M WITH (NOLOCK) 
	ON PWD.MarcaId = M.MarcaId 
WHERE	pwd.CampaniaID = @CampaniaID 
	AND pwd.ConsultoraID = @ConsultoraID 
	AND pwd.CUVPadre IS NULL 
	
DECLARE @Estrategia AS TABLE( 
	EstrategiaID int,
	TipoEstrategiaID int,
	Activo bit,
	CampaniaID int,
	CampaniaIDFin int,
	CUV2 varchar(20),
	Numeropedido int,
	DescripcionEstrategia varchar(800),
	EsOfertaIndependiente bit,
	FlagNueva bit,
	DescripcionTipoEstrategia varchar(200),
	TipoEstrategiaCodigo varchar(100),
	CodigoPrograma varchar(3),
PRIMARY KEY (EstrategiaID) 
) 
 
INSERT INTO @Estrategia 
SELECT DISTINCT 
	E.EstrategiaID,
	E.TipoEstrategiaID,
	E.Activo,
	E.CampaniaID,
	E.CampaniaIDFin,
	E.CUV2,
	E.Numeropedido,
	E.DescripcionCUV2 AS DescripcionEstrategia,
	E.EsOfertaIndependiente,
	TE.FlagNueva,
	TE.DescripcionEstrategia AS DescripcionTipoEstrategia,
	TE.Codigo AS TipoEstrategiaCodigo,
	TE.CodigoPrograma 
FROM dbo.Estrategia E WITH (NOLOCK) 
INNER JOIN TipoEstrategia TE WITH (NOLOCK) 
	ON TE.TipoEstrategiaID = E.TipoEstrategiaID 
INNER JOIN @PedidoDetalle PWD 
	ON PWD.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END 
	AND E.CUV2 = PWD.CUV 
	AND E.Activo = 1 
WHERE TE.FlagActivo = 1 


IF @CodigoPrograma IS NOT NULL 
BEGIN 
	DELETE FROM @Estrategia 
	WHERE isnull(CodigoPrograma, '') <> '' 
	AND (
		(CodigoPrograma <> @CodigoPrograma AND Numeropedido <> @NumeroPedido) 
		OR (CodigoPrograma = @CodigoPrograma AND Numeropedido <> @NumeroPedido)
	) 

END 


SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(EST.DescripcionEstrategia,
		PWD.DescripcionProd) AS DescripcionProd,
	PWD.ClienteNombre AS Nombre,
	PWD.OfertaWeb,
	PWD.IndicadorMontoMinimo,
	ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID,
	ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID,
	ISNULL(PWD.TipoPedido, 'W') TipoPedido,
	EST.DescripcionTipoEstrategia AS DescripcionOferta,
	PWD.MarcaDescripcion AS DescripcionLarga,
	'NO DISPONIBLE' AS Categoria,
	EST.DescripcionTipoEstrategia AS DescripcionEstrategia,
	CASE WHEN EST.FlagNueva = 1 AND @CodigoPrograma IS NOT NULL THEN 1 
		ELSE 0 END AS FlagNueva,
	PWD.IndicadorOfertaCUV,
	PWD.FlagConsultoraOnline,
	PWD.DescuentoProl,
	PWD.MontoEscala,
	PWD.MontoAhorroCatalogo,
	PWD.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PWD.CodigoCatalago,
	EST.TipoEstrategiaCodigo,
	EST.EsOfertaIndependiente,
	EST.EstrategiaID,
	EST.TipoEstrategiaID,
	EST.Numeropedido
FROM @PedidoDetalle PWD 
LEFT JOIN @Estrategia EST 
	ON EST.CUV2 = PWD.CUV 
ORDER BY PWD.OrdenPedidoWD DESC,
PWD.PedidoDetalleID DESC 

END

GO

USE BelcorpSalvador
GO

GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByCampania 
	@CampaniaID	INT,
	@ConsultoraID	BIGINT,
	@CodigoPrograma varchar(15) = NULL,
	@NumeroPedido int = 0 
 AS 
 /* 
 GetPedidoWebDetalleByCampania 201716, 33901, '043', 4 
 GetPedidoWebDetalleByCampania_SB2 201716, 339 01 
 */ 
BEGIN 
SET NOCOUNT ON

SET @CodigoPrograma = CASE WHEN @CodigoPrograma = '' THEN NULL ELSE @CodigoPrograma END 
SET @NumeroPedido = CASE WHEN @NumeroPedido > 0 THEN @NumeroPedido + 1 ELSE 0 END 

DECLARE @PedidoDetalle AS TABLE (
	CampaniaID int,
	PedidoID int,
	PedidoDetalleID int,
	MarcaID tinyint,
	ConsultoraID bigint,
	ClienteID smallint,
	OrdenPedidoWD int,
	Cantidad int,
	PrecioUnidad money,
	ImporteTotal money,
	CUV varchar(20),
	EsKitNueva bit,
	DescripcionProd varchar(800),
	ClienteNombre varchar(200),
	OfertaWeb bit,
	IndicadorMontoMinimo int,
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	TipoPedido char(1),
	DescripcionOferta varchar(200),
	MarcaDescripcion varchar(20),
	CategoriaNombre varchar(50),
	DescripcionEstrategia varchar(200),
	TipoEstrategiaID int,
	IndicadorOfertaCUV bit,
	FlagConsultoraOnline int,
	DescuentoProl money,
	MontoEscala money,
	MontoAhorroCatalogo money,
	MontoAhorroRevista money,
	OrigenPedidoWeb int,
	EsBackOrder bit,
	AceptoBackOrder bit,
	CodigoCatalago char(6),
	TipoEstrategiaCodigo varchar(100),
	EsOfertaIndependiente bit,
	CodigoTipoOferta char(6),
PRIMARY KEY (CampaniaID, PedidoID, PedidoDetalleID) 
) 

INSERT INTO @PedidoDetalle 
SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(MC.Descripcion,
		OP.Descripcion,
		PD.Descripcion,
		PC.Descripcion) AS DescripcionProd, -- FALTA 
	C.Nombre AS ClienteNombre,
	PWD.OfertaWeb,
	PC.IndicadorMontoMinimo,
	PWD.ConfiguracionOfertaID,
	PWD.TipoOfertaSisID,
	PWD.TipoPedido,
	'' AS DescripcionOferta,
	M.Descripcion AS MarcaDescripcion,
	'NO DISPONIBLE' AS Categoria,
	'' AS DescripcionEstrategia,
	0 AS TipoEstrategiaID,
	PC.IndicadorOferta AS IndicadorOfertaCUV,
	0 AS FlagConsultoraOnline,
	PW.DescuentoProl,
	PW.MontoEscala,
	PW.MontoAhorroCatalogo,
	PW.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PC.CodigoCatalago,
	'' AS TipoEstrategiaCodigo,
	0 AS EsOfertaIndependiente,
	PC.CodigoTipoOferta 
FROM dbo.PedidoWebDetalle PWD WITH (NOLOCK) 
INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) 
	ON PW.CampaniaID = PWD.CampaniaID 
	AND PW.PedidoID = PWD.PedidoID 
	and PW.ConsultoraID = PWD.ConsultoraID 
INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) 
	ON PWD.CampaniaID = PC.AnoCampania 
	AND PWD.CUV = PC.CUV 
LEFT JOIN dbo.Cliente C WITH (NOLOCK) 
	ON PWD.ClienteID = C.ClienteID 
	AND PWD.ConsultoraID = C.ConsultoraID 
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) 
	ON PWD.CampaniaID = PD.CampaniaID 
	AND PWD.CUV = PD.CUV 
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) 
	ON OP.CampaniaID = PC.CampaniaID 
	AND OP.CUV = PC.CUV 
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) 
	on PC.CodigoProducto = MC.CodigoSAP 
LEFT JOIN dbo.Marca M WITH (NOLOCK) 
	ON PWD.MarcaId = M.MarcaId 
WHERE	pwd.CampaniaID = @CampaniaID 
	AND pwd.ConsultoraID = @ConsultoraID 
	AND pwd.CUVPadre IS NULL 
	
DECLARE @Estrategia AS TABLE( 
	EstrategiaID int,
	TipoEstrategiaID int,
	Activo bit,
	CampaniaID int,
	CampaniaIDFin int,
	CUV2 varchar(20),
	Numeropedido int,
	DescripcionEstrategia varchar(800),
	EsOfertaIndependiente bit,
	FlagNueva bit,
	DescripcionTipoEstrategia varchar(200),
	TipoEstrategiaCodigo varchar(100),
	CodigoPrograma varchar(3),
PRIMARY KEY (EstrategiaID) 
) 
 
INSERT INTO @Estrategia 
SELECT DISTINCT 
	E.EstrategiaID,
	E.TipoEstrategiaID,
	E.Activo,
	E.CampaniaID,
	E.CampaniaIDFin,
	E.CUV2,
	E.Numeropedido,
	E.DescripcionCUV2 AS DescripcionEstrategia,
	E.EsOfertaIndependiente,
	TE.FlagNueva,
	TE.DescripcionEstrategia AS DescripcionTipoEstrategia,
	TE.Codigo AS TipoEstrategiaCodigo,
	TE.CodigoPrograma 
FROM dbo.Estrategia E WITH (NOLOCK) 
INNER JOIN TipoEstrategia TE WITH (NOLOCK) 
	ON TE.TipoEstrategiaID = E.TipoEstrategiaID 
INNER JOIN @PedidoDetalle PWD 
	ON PWD.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END 
	AND E.CUV2 = PWD.CUV 
	AND E.Activo = 1 
WHERE TE.FlagActivo = 1 


IF @CodigoPrograma IS NOT NULL 
BEGIN 
	DELETE FROM @Estrategia 
	WHERE isnull(CodigoPrograma, '') <> '' 
	AND (
		(CodigoPrograma <> @CodigoPrograma AND Numeropedido <> @NumeroPedido) 
		OR (CodigoPrograma = @CodigoPrograma AND Numeropedido <> @NumeroPedido)
	) 

END 


SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(EST.DescripcionEstrategia,
		PWD.DescripcionProd) AS DescripcionProd,
	PWD.ClienteNombre AS Nombre,
	PWD.OfertaWeb,
	PWD.IndicadorMontoMinimo,
	ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID,
	ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID,
	ISNULL(PWD.TipoPedido, 'W') TipoPedido,
	EST.DescripcionTipoEstrategia AS DescripcionOferta,
	PWD.MarcaDescripcion AS DescripcionLarga,
	'NO DISPONIBLE' AS Categoria,
	EST.DescripcionTipoEstrategia AS DescripcionEstrategia,
	CASE WHEN EST.FlagNueva = 1 AND @CodigoPrograma IS NOT NULL THEN 1 
		ELSE 0 END AS FlagNueva,
	PWD.IndicadorOfertaCUV,
	PWD.FlagConsultoraOnline,
	PWD.DescuentoProl,
	PWD.MontoEscala,
	PWD.MontoAhorroCatalogo,
	PWD.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PWD.CodigoCatalago,
	EST.TipoEstrategiaCodigo,
	EST.EsOfertaIndependiente,
	EST.EstrategiaID,
	EST.TipoEstrategiaID,
	EST.Numeropedido
FROM @PedidoDetalle PWD 
LEFT JOIN @Estrategia EST 
	ON EST.CUV2 = PWD.CUV 
ORDER BY PWD.OrdenPedidoWD DESC,
PWD.PedidoDetalleID DESC 

END

GO

USE BelcorpPuertoRico
GO

GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByCampania 
	@CampaniaID	INT,
	@ConsultoraID	BIGINT,
	@CodigoPrograma varchar(15) = NULL,
	@NumeroPedido int = 0 
 AS 
 /* 
 GetPedidoWebDetalleByCampania 201716, 33901, '043', 4 
 GetPedidoWebDetalleByCampania_SB2 201716, 339 01 
 */ 
BEGIN 
SET NOCOUNT ON

SET @CodigoPrograma = CASE WHEN @CodigoPrograma = '' THEN NULL ELSE @CodigoPrograma END 
SET @NumeroPedido = CASE WHEN @NumeroPedido > 0 THEN @NumeroPedido + 1 ELSE 0 END 

DECLARE @PedidoDetalle AS TABLE (
	CampaniaID int,
	PedidoID int,
	PedidoDetalleID int,
	MarcaID tinyint,
	ConsultoraID bigint,
	ClienteID smallint,
	OrdenPedidoWD int,
	Cantidad int,
	PrecioUnidad money,
	ImporteTotal money,
	CUV varchar(20),
	EsKitNueva bit,
	DescripcionProd varchar(800),
	ClienteNombre varchar(200),
	OfertaWeb bit,
	IndicadorMontoMinimo int,
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	TipoPedido char(1),
	DescripcionOferta varchar(200),
	MarcaDescripcion varchar(20),
	CategoriaNombre varchar(50),
	DescripcionEstrategia varchar(200),
	TipoEstrategiaID int,
	IndicadorOfertaCUV bit,
	FlagConsultoraOnline int,
	DescuentoProl money,
	MontoEscala money,
	MontoAhorroCatalogo money,
	MontoAhorroRevista money,
	OrigenPedidoWeb int,
	EsBackOrder bit,
	AceptoBackOrder bit,
	CodigoCatalago char(6),
	TipoEstrategiaCodigo varchar(100),
	EsOfertaIndependiente bit,
	CodigoTipoOferta char(6),
PRIMARY KEY (CampaniaID, PedidoID, PedidoDetalleID) 
) 

INSERT INTO @PedidoDetalle 
SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(MC.Descripcion,
		OP.Descripcion,
		PD.Descripcion,
		PC.Descripcion) AS DescripcionProd, -- FALTA 
	C.Nombre AS ClienteNombre,
	PWD.OfertaWeb,
	PC.IndicadorMontoMinimo,
	PWD.ConfiguracionOfertaID,
	PWD.TipoOfertaSisID,
	PWD.TipoPedido,
	'' AS DescripcionOferta,
	M.Descripcion AS MarcaDescripcion,
	'NO DISPONIBLE' AS Categoria,
	'' AS DescripcionEstrategia,
	0 AS TipoEstrategiaID,
	PC.IndicadorOferta AS IndicadorOfertaCUV,
	0 AS FlagConsultoraOnline,
	PW.DescuentoProl,
	PW.MontoEscala,
	PW.MontoAhorroCatalogo,
	PW.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PC.CodigoCatalago,
	'' AS TipoEstrategiaCodigo,
	0 AS EsOfertaIndependiente,
	PC.CodigoTipoOferta 
FROM dbo.PedidoWebDetalle PWD WITH (NOLOCK) 
INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) 
	ON PW.CampaniaID = PWD.CampaniaID 
	AND PW.PedidoID = PWD.PedidoID 
	and PW.ConsultoraID = PWD.ConsultoraID 
INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) 
	ON PWD.CampaniaID = PC.AnoCampania 
	AND PWD.CUV = PC.CUV 
LEFT JOIN dbo.Cliente C WITH (NOLOCK) 
	ON PWD.ClienteID = C.ClienteID 
	AND PWD.ConsultoraID = C.ConsultoraID 
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) 
	ON PWD.CampaniaID = PD.CampaniaID 
	AND PWD.CUV = PD.CUV 
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) 
	ON OP.CampaniaID = PC.CampaniaID 
	AND OP.CUV = PC.CUV 
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) 
	on PC.CodigoProducto = MC.CodigoSAP 
LEFT JOIN dbo.Marca M WITH (NOLOCK) 
	ON PWD.MarcaId = M.MarcaId 
WHERE	pwd.CampaniaID = @CampaniaID 
	AND pwd.ConsultoraID = @ConsultoraID 
	AND pwd.CUVPadre IS NULL 
	
DECLARE @Estrategia AS TABLE( 
	EstrategiaID int,
	TipoEstrategiaID int,
	Activo bit,
	CampaniaID int,
	CampaniaIDFin int,
	CUV2 varchar(20),
	Numeropedido int,
	DescripcionEstrategia varchar(800),
	EsOfertaIndependiente bit,
	FlagNueva bit,
	DescripcionTipoEstrategia varchar(200),
	TipoEstrategiaCodigo varchar(100),
	CodigoPrograma varchar(3),
PRIMARY KEY (EstrategiaID) 
) 
 
INSERT INTO @Estrategia 
SELECT DISTINCT 
	E.EstrategiaID,
	E.TipoEstrategiaID,
	E.Activo,
	E.CampaniaID,
	E.CampaniaIDFin,
	E.CUV2,
	E.Numeropedido,
	E.DescripcionCUV2 AS DescripcionEstrategia,
	E.EsOfertaIndependiente,
	TE.FlagNueva,
	TE.DescripcionEstrategia AS DescripcionTipoEstrategia,
	TE.Codigo AS TipoEstrategiaCodigo,
	TE.CodigoPrograma 
FROM dbo.Estrategia E WITH (NOLOCK) 
INNER JOIN TipoEstrategia TE WITH (NOLOCK) 
	ON TE.TipoEstrategiaID = E.TipoEstrategiaID 
INNER JOIN @PedidoDetalle PWD 
	ON PWD.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END 
	AND E.CUV2 = PWD.CUV 
	AND E.Activo = 1 
WHERE TE.FlagActivo = 1 


IF @CodigoPrograma IS NOT NULL 
BEGIN 
	DELETE FROM @Estrategia 
	WHERE isnull(CodigoPrograma, '') <> '' 
	AND (
		(CodigoPrograma <> @CodigoPrograma AND Numeropedido <> @NumeroPedido) 
		OR (CodigoPrograma = @CodigoPrograma AND Numeropedido <> @NumeroPedido)
	) 

END 


SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(EST.DescripcionEstrategia,
		PWD.DescripcionProd) AS DescripcionProd,
	PWD.ClienteNombre AS Nombre,
	PWD.OfertaWeb,
	PWD.IndicadorMontoMinimo,
	ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID,
	ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID,
	ISNULL(PWD.TipoPedido, 'W') TipoPedido,
	EST.DescripcionTipoEstrategia AS DescripcionOferta,
	PWD.MarcaDescripcion AS DescripcionLarga,
	'NO DISPONIBLE' AS Categoria,
	EST.DescripcionTipoEstrategia AS DescripcionEstrategia,
	CASE WHEN EST.FlagNueva = 1 AND @CodigoPrograma IS NOT NULL THEN 1 
		ELSE 0 END AS FlagNueva,
	PWD.IndicadorOfertaCUV,
	PWD.FlagConsultoraOnline,
	PWD.DescuentoProl,
	PWD.MontoEscala,
	PWD.MontoAhorroCatalogo,
	PWD.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PWD.CodigoCatalago,
	EST.TipoEstrategiaCodigo,
	EST.EsOfertaIndependiente,
	EST.EstrategiaID,
	EST.TipoEstrategiaID,
	EST.Numeropedido
FROM @PedidoDetalle PWD 
LEFT JOIN @Estrategia EST 
	ON EST.CUV2 = PWD.CUV 
ORDER BY PWD.OrdenPedidoWD DESC,
PWD.PedidoDetalleID DESC 

END

GO

USE BelcorpPanama
GO

GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByCampania 
	@CampaniaID	INT,
	@ConsultoraID	BIGINT,
	@CodigoPrograma varchar(15) = NULL,
	@NumeroPedido int = 0 
 AS 
 /* 
 GetPedidoWebDetalleByCampania 201716, 33901, '043', 4 
 GetPedidoWebDetalleByCampania_SB2 201716, 339 01 
 */ 
BEGIN 
SET NOCOUNT ON

SET @CodigoPrograma = CASE WHEN @CodigoPrograma = '' THEN NULL ELSE @CodigoPrograma END 
SET @NumeroPedido = CASE WHEN @NumeroPedido > 0 THEN @NumeroPedido + 1 ELSE 0 END 

DECLARE @PedidoDetalle AS TABLE (
	CampaniaID int,
	PedidoID int,
	PedidoDetalleID int,
	MarcaID tinyint,
	ConsultoraID bigint,
	ClienteID smallint,
	OrdenPedidoWD int,
	Cantidad int,
	PrecioUnidad money,
	ImporteTotal money,
	CUV varchar(20),
	EsKitNueva bit,
	DescripcionProd varchar(800),
	ClienteNombre varchar(200),
	OfertaWeb bit,
	IndicadorMontoMinimo int,
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	TipoPedido char(1),
	DescripcionOferta varchar(200),
	MarcaDescripcion varchar(20),
	CategoriaNombre varchar(50),
	DescripcionEstrategia varchar(200),
	TipoEstrategiaID int,
	IndicadorOfertaCUV bit,
	FlagConsultoraOnline int,
	DescuentoProl money,
	MontoEscala money,
	MontoAhorroCatalogo money,
	MontoAhorroRevista money,
	OrigenPedidoWeb int,
	EsBackOrder bit,
	AceptoBackOrder bit,
	CodigoCatalago char(6),
	TipoEstrategiaCodigo varchar(100),
	EsOfertaIndependiente bit,
	CodigoTipoOferta char(6),
PRIMARY KEY (CampaniaID, PedidoID, PedidoDetalleID) 
) 

INSERT INTO @PedidoDetalle 
SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(MC.Descripcion,
		OP.Descripcion,
		PD.Descripcion,
		PC.Descripcion) AS DescripcionProd, -- FALTA 
	C.Nombre AS ClienteNombre,
	PWD.OfertaWeb,
	PC.IndicadorMontoMinimo,
	PWD.ConfiguracionOfertaID,
	PWD.TipoOfertaSisID,
	PWD.TipoPedido,
	'' AS DescripcionOferta,
	M.Descripcion AS MarcaDescripcion,
	'NO DISPONIBLE' AS Categoria,
	'' AS DescripcionEstrategia,
	0 AS TipoEstrategiaID,
	PC.IndicadorOferta AS IndicadorOfertaCUV,
	0 AS FlagConsultoraOnline,
	PW.DescuentoProl,
	PW.MontoEscala,
	PW.MontoAhorroCatalogo,
	PW.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PC.CodigoCatalago,
	'' AS TipoEstrategiaCodigo,
	0 AS EsOfertaIndependiente,
	PC.CodigoTipoOferta 
FROM dbo.PedidoWebDetalle PWD WITH (NOLOCK) 
INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) 
	ON PW.CampaniaID = PWD.CampaniaID 
	AND PW.PedidoID = PWD.PedidoID 
	and PW.ConsultoraID = PWD.ConsultoraID 
INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) 
	ON PWD.CampaniaID = PC.AnoCampania 
	AND PWD.CUV = PC.CUV 
LEFT JOIN dbo.Cliente C WITH (NOLOCK) 
	ON PWD.ClienteID = C.ClienteID 
	AND PWD.ConsultoraID = C.ConsultoraID 
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) 
	ON PWD.CampaniaID = PD.CampaniaID 
	AND PWD.CUV = PD.CUV 
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) 
	ON OP.CampaniaID = PC.CampaniaID 
	AND OP.CUV = PC.CUV 
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) 
	on PC.CodigoProducto = MC.CodigoSAP 
LEFT JOIN dbo.Marca M WITH (NOLOCK) 
	ON PWD.MarcaId = M.MarcaId 
WHERE	pwd.CampaniaID = @CampaniaID 
	AND pwd.ConsultoraID = @ConsultoraID 
	AND pwd.CUVPadre IS NULL 
	
DECLARE @Estrategia AS TABLE( 
	EstrategiaID int,
	TipoEstrategiaID int,
	Activo bit,
	CampaniaID int,
	CampaniaIDFin int,
	CUV2 varchar(20),
	Numeropedido int,
	DescripcionEstrategia varchar(800),
	EsOfertaIndependiente bit,
	FlagNueva bit,
	DescripcionTipoEstrategia varchar(200),
	TipoEstrategiaCodigo varchar(100),
	CodigoPrograma varchar(3),
PRIMARY KEY (EstrategiaID) 
) 
 
INSERT INTO @Estrategia 
SELECT DISTINCT 
	E.EstrategiaID,
	E.TipoEstrategiaID,
	E.Activo,
	E.CampaniaID,
	E.CampaniaIDFin,
	E.CUV2,
	E.Numeropedido,
	E.DescripcionCUV2 AS DescripcionEstrategia,
	E.EsOfertaIndependiente,
	TE.FlagNueva,
	TE.DescripcionEstrategia AS DescripcionTipoEstrategia,
	TE.Codigo AS TipoEstrategiaCodigo,
	TE.CodigoPrograma 
FROM dbo.Estrategia E WITH (NOLOCK) 
INNER JOIN TipoEstrategia TE WITH (NOLOCK) 
	ON TE.TipoEstrategiaID = E.TipoEstrategiaID 
INNER JOIN @PedidoDetalle PWD 
	ON PWD.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END 
	AND E.CUV2 = PWD.CUV 
	AND E.Activo = 1 
WHERE TE.FlagActivo = 1 


IF @CodigoPrograma IS NOT NULL 
BEGIN 
	DELETE FROM @Estrategia 
	WHERE isnull(CodigoPrograma, '') <> '' 
	AND (
		(CodigoPrograma <> @CodigoPrograma AND Numeropedido <> @NumeroPedido) 
		OR (CodigoPrograma = @CodigoPrograma AND Numeropedido <> @NumeroPedido)
	) 

END 


SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(EST.DescripcionEstrategia,
		PWD.DescripcionProd) AS DescripcionProd,
	PWD.ClienteNombre AS Nombre,
	PWD.OfertaWeb,
	PWD.IndicadorMontoMinimo,
	ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID,
	ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID,
	ISNULL(PWD.TipoPedido, 'W') TipoPedido,
	EST.DescripcionTipoEstrategia AS DescripcionOferta,
	PWD.MarcaDescripcion AS DescripcionLarga,
	'NO DISPONIBLE' AS Categoria,
	EST.DescripcionTipoEstrategia AS DescripcionEstrategia,
	CASE WHEN EST.FlagNueva = 1 AND @CodigoPrograma IS NOT NULL THEN 1 
		ELSE 0 END AS FlagNueva,
	PWD.IndicadorOfertaCUV,
	PWD.FlagConsultoraOnline,
	PWD.DescuentoProl,
	PWD.MontoEscala,
	PWD.MontoAhorroCatalogo,
	PWD.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PWD.CodigoCatalago,
	EST.TipoEstrategiaCodigo,
	EST.EsOfertaIndependiente,
	EST.EstrategiaID,
	EST.TipoEstrategiaID,
	EST.Numeropedido
FROM @PedidoDetalle PWD 
LEFT JOIN @Estrategia EST 
	ON EST.CUV2 = PWD.CUV 
ORDER BY PWD.OrdenPedidoWD DESC,
PWD.PedidoDetalleID DESC 

END

GO

USE BelcorpGuatemala
GO

GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByCampania 
	@CampaniaID	INT,
	@ConsultoraID	BIGINT,
	@CodigoPrograma varchar(15) = NULL,
	@NumeroPedido int = 0 
 AS 
 /* 
 GetPedidoWebDetalleByCampania 201716, 33901, '043', 4 
 GetPedidoWebDetalleByCampania_SB2 201716, 339 01 
 */ 
BEGIN 
SET NOCOUNT ON

SET @CodigoPrograma = CASE WHEN @CodigoPrograma = '' THEN NULL ELSE @CodigoPrograma END 
SET @NumeroPedido = CASE WHEN @NumeroPedido > 0 THEN @NumeroPedido + 1 ELSE 0 END 

DECLARE @PedidoDetalle AS TABLE (
	CampaniaID int,
	PedidoID int,
	PedidoDetalleID int,
	MarcaID tinyint,
	ConsultoraID bigint,
	ClienteID smallint,
	OrdenPedidoWD int,
	Cantidad int,
	PrecioUnidad money,
	ImporteTotal money,
	CUV varchar(20),
	EsKitNueva bit,
	DescripcionProd varchar(800),
	ClienteNombre varchar(200),
	OfertaWeb bit,
	IndicadorMontoMinimo int,
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	TipoPedido char(1),
	DescripcionOferta varchar(200),
	MarcaDescripcion varchar(20),
	CategoriaNombre varchar(50),
	DescripcionEstrategia varchar(200),
	TipoEstrategiaID int,
	IndicadorOfertaCUV bit,
	FlagConsultoraOnline int,
	DescuentoProl money,
	MontoEscala money,
	MontoAhorroCatalogo money,
	MontoAhorroRevista money,
	OrigenPedidoWeb int,
	EsBackOrder bit,
	AceptoBackOrder bit,
	CodigoCatalago char(6),
	TipoEstrategiaCodigo varchar(100),
	EsOfertaIndependiente bit,
	CodigoTipoOferta char(6),
PRIMARY KEY (CampaniaID, PedidoID, PedidoDetalleID) 
) 

INSERT INTO @PedidoDetalle 
SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(MC.Descripcion,
		OP.Descripcion,
		PD.Descripcion,
		PC.Descripcion) AS DescripcionProd, -- FALTA 
	C.Nombre AS ClienteNombre,
	PWD.OfertaWeb,
	PC.IndicadorMontoMinimo,
	PWD.ConfiguracionOfertaID,
	PWD.TipoOfertaSisID,
	PWD.TipoPedido,
	'' AS DescripcionOferta,
	M.Descripcion AS MarcaDescripcion,
	'NO DISPONIBLE' AS Categoria,
	'' AS DescripcionEstrategia,
	0 AS TipoEstrategiaID,
	PC.IndicadorOferta AS IndicadorOfertaCUV,
	0 AS FlagConsultoraOnline,
	PW.DescuentoProl,
	PW.MontoEscala,
	PW.MontoAhorroCatalogo,
	PW.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PC.CodigoCatalago,
	'' AS TipoEstrategiaCodigo,
	0 AS EsOfertaIndependiente,
	PC.CodigoTipoOferta 
FROM dbo.PedidoWebDetalle PWD WITH (NOLOCK) 
INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) 
	ON PW.CampaniaID = PWD.CampaniaID 
	AND PW.PedidoID = PWD.PedidoID 
	and PW.ConsultoraID = PWD.ConsultoraID 
INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) 
	ON PWD.CampaniaID = PC.AnoCampania 
	AND PWD.CUV = PC.CUV 
LEFT JOIN dbo.Cliente C WITH (NOLOCK) 
	ON PWD.ClienteID = C.ClienteID 
	AND PWD.ConsultoraID = C.ConsultoraID 
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) 
	ON PWD.CampaniaID = PD.CampaniaID 
	AND PWD.CUV = PD.CUV 
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) 
	ON OP.CampaniaID = PC.CampaniaID 
	AND OP.CUV = PC.CUV 
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) 
	on PC.CodigoProducto = MC.CodigoSAP 
LEFT JOIN dbo.Marca M WITH (NOLOCK) 
	ON PWD.MarcaId = M.MarcaId 
WHERE	pwd.CampaniaID = @CampaniaID 
	AND pwd.ConsultoraID = @ConsultoraID 
	AND pwd.CUVPadre IS NULL 
	
DECLARE @Estrategia AS TABLE( 
	EstrategiaID int,
	TipoEstrategiaID int,
	Activo bit,
	CampaniaID int,
	CampaniaIDFin int,
	CUV2 varchar(20),
	Numeropedido int,
	DescripcionEstrategia varchar(800),
	EsOfertaIndependiente bit,
	FlagNueva bit,
	DescripcionTipoEstrategia varchar(200),
	TipoEstrategiaCodigo varchar(100),
	CodigoPrograma varchar(3),
PRIMARY KEY (EstrategiaID) 
) 
 
INSERT INTO @Estrategia 
SELECT DISTINCT 
	E.EstrategiaID,
	E.TipoEstrategiaID,
	E.Activo,
	E.CampaniaID,
	E.CampaniaIDFin,
	E.CUV2,
	E.Numeropedido,
	E.DescripcionCUV2 AS DescripcionEstrategia,
	E.EsOfertaIndependiente,
	TE.FlagNueva,
	TE.DescripcionEstrategia AS DescripcionTipoEstrategia,
	TE.Codigo AS TipoEstrategiaCodigo,
	TE.CodigoPrograma 
FROM dbo.Estrategia E WITH (NOLOCK) 
INNER JOIN TipoEstrategia TE WITH (NOLOCK) 
	ON TE.TipoEstrategiaID = E.TipoEstrategiaID 
INNER JOIN @PedidoDetalle PWD 
	ON PWD.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END 
	AND E.CUV2 = PWD.CUV 
	AND E.Activo = 1 
WHERE TE.FlagActivo = 1 


IF @CodigoPrograma IS NOT NULL 
BEGIN 
	DELETE FROM @Estrategia 
	WHERE isnull(CodigoPrograma, '') <> '' 
	AND (
		(CodigoPrograma <> @CodigoPrograma AND Numeropedido <> @NumeroPedido) 
		OR (CodigoPrograma = @CodigoPrograma AND Numeropedido <> @NumeroPedido)
	) 

END 


SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(EST.DescripcionEstrategia,
		PWD.DescripcionProd) AS DescripcionProd,
	PWD.ClienteNombre AS Nombre,
	PWD.OfertaWeb,
	PWD.IndicadorMontoMinimo,
	ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID,
	ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID,
	ISNULL(PWD.TipoPedido, 'W') TipoPedido,
	EST.DescripcionTipoEstrategia AS DescripcionOferta,
	PWD.MarcaDescripcion AS DescripcionLarga,
	'NO DISPONIBLE' AS Categoria,
	EST.DescripcionTipoEstrategia AS DescripcionEstrategia,
	CASE WHEN EST.FlagNueva = 1 AND @CodigoPrograma IS NOT NULL THEN 1 
		ELSE 0 END AS FlagNueva,
	PWD.IndicadorOfertaCUV,
	PWD.FlagConsultoraOnline,
	PWD.DescuentoProl,
	PWD.MontoEscala,
	PWD.MontoAhorroCatalogo,
	PWD.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PWD.CodigoCatalago,
	EST.TipoEstrategiaCodigo,
	EST.EsOfertaIndependiente,
	EST.EstrategiaID,
	EST.TipoEstrategiaID,
	EST.Numeropedido
FROM @PedidoDetalle PWD 
LEFT JOIN @Estrategia EST 
	ON EST.CUV2 = PWD.CUV 
ORDER BY PWD.OrdenPedidoWD DESC,
PWD.PedidoDetalleID DESC 

END

GO

USE BelcorpEcuador
GO

GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByCampania 
	@CampaniaID	INT,
	@ConsultoraID	BIGINT,
	@CodigoPrograma varchar(15) = NULL,
	@NumeroPedido int = 0 
 AS 
 /* 
 GetPedidoWebDetalleByCampania 201716, 33901, '043', 4 
 GetPedidoWebDetalleByCampania_SB2 201716, 339 01 
 */ 
BEGIN 
SET NOCOUNT ON

SET @CodigoPrograma = CASE WHEN @CodigoPrograma = '' THEN NULL ELSE @CodigoPrograma END 
SET @NumeroPedido = CASE WHEN @NumeroPedido > 0 THEN @NumeroPedido + 1 ELSE 0 END 

DECLARE @PedidoDetalle AS TABLE (
	CampaniaID int,
	PedidoID int,
	PedidoDetalleID int,
	MarcaID tinyint,
	ConsultoraID bigint,
	ClienteID smallint,
	OrdenPedidoWD int,
	Cantidad int,
	PrecioUnidad money,
	ImporteTotal money,
	CUV varchar(20),
	EsKitNueva bit,
	DescripcionProd varchar(800),
	ClienteNombre varchar(200),
	OfertaWeb bit,
	IndicadorMontoMinimo int,
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	TipoPedido char(1),
	DescripcionOferta varchar(200),
	MarcaDescripcion varchar(20),
	CategoriaNombre varchar(50),
	DescripcionEstrategia varchar(200),
	TipoEstrategiaID int,
	IndicadorOfertaCUV bit,
	FlagConsultoraOnline int,
	DescuentoProl money,
	MontoEscala money,
	MontoAhorroCatalogo money,
	MontoAhorroRevista money,
	OrigenPedidoWeb int,
	EsBackOrder bit,
	AceptoBackOrder bit,
	CodigoCatalago char(6),
	TipoEstrategiaCodigo varchar(100),
	EsOfertaIndependiente bit,
	CodigoTipoOferta char(6),
PRIMARY KEY (CampaniaID, PedidoID, PedidoDetalleID) 
) 

INSERT INTO @PedidoDetalle 
SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(MC.Descripcion,
		OP.Descripcion,
		PD.Descripcion,
		PC.Descripcion) AS DescripcionProd, -- FALTA 
	C.Nombre AS ClienteNombre,
	PWD.OfertaWeb,
	PC.IndicadorMontoMinimo,
	PWD.ConfiguracionOfertaID,
	PWD.TipoOfertaSisID,
	PWD.TipoPedido,
	'' AS DescripcionOferta,
	M.Descripcion AS MarcaDescripcion,
	'NO DISPONIBLE' AS Categoria,
	'' AS DescripcionEstrategia,
	0 AS TipoEstrategiaID,
	PC.IndicadorOferta AS IndicadorOfertaCUV,
	0 AS FlagConsultoraOnline,
	PW.DescuentoProl,
	PW.MontoEscala,
	PW.MontoAhorroCatalogo,
	PW.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PC.CodigoCatalago,
	'' AS TipoEstrategiaCodigo,
	0 AS EsOfertaIndependiente,
	PC.CodigoTipoOferta 
FROM dbo.PedidoWebDetalle PWD WITH (NOLOCK) 
INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) 
	ON PW.CampaniaID = PWD.CampaniaID 
	AND PW.PedidoID = PWD.PedidoID 
	and PW.ConsultoraID = PWD.ConsultoraID 
INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) 
	ON PWD.CampaniaID = PC.AnoCampania 
	AND PWD.CUV = PC.CUV 
LEFT JOIN dbo.Cliente C WITH (NOLOCK) 
	ON PWD.ClienteID = C.ClienteID 
	AND PWD.ConsultoraID = C.ConsultoraID 
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) 
	ON PWD.CampaniaID = PD.CampaniaID 
	AND PWD.CUV = PD.CUV 
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) 
	ON OP.CampaniaID = PC.CampaniaID 
	AND OP.CUV = PC.CUV 
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) 
	on PC.CodigoProducto = MC.CodigoSAP 
LEFT JOIN dbo.Marca M WITH (NOLOCK) 
	ON PWD.MarcaId = M.MarcaId 
WHERE	pwd.CampaniaID = @CampaniaID 
	AND pwd.ConsultoraID = @ConsultoraID 
	AND pwd.CUVPadre IS NULL 
	
DECLARE @Estrategia AS TABLE( 
	EstrategiaID int,
	TipoEstrategiaID int,
	Activo bit,
	CampaniaID int,
	CampaniaIDFin int,
	CUV2 varchar(20),
	Numeropedido int,
	DescripcionEstrategia varchar(800),
	EsOfertaIndependiente bit,
	FlagNueva bit,
	DescripcionTipoEstrategia varchar(200),
	TipoEstrategiaCodigo varchar(100),
	CodigoPrograma varchar(3),
PRIMARY KEY (EstrategiaID) 
) 
 
INSERT INTO @Estrategia 
SELECT DISTINCT 
	E.EstrategiaID,
	E.TipoEstrategiaID,
	E.Activo,
	E.CampaniaID,
	E.CampaniaIDFin,
	E.CUV2,
	E.Numeropedido,
	E.DescripcionCUV2 AS DescripcionEstrategia,
	E.EsOfertaIndependiente,
	TE.FlagNueva,
	TE.DescripcionEstrategia AS DescripcionTipoEstrategia,
	TE.Codigo AS TipoEstrategiaCodigo,
	TE.CodigoPrograma 
FROM dbo.Estrategia E WITH (NOLOCK) 
INNER JOIN TipoEstrategia TE WITH (NOLOCK) 
	ON TE.TipoEstrategiaID = E.TipoEstrategiaID 
INNER JOIN @PedidoDetalle PWD 
	ON PWD.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END 
	AND E.CUV2 = PWD.CUV 
	AND E.Activo = 1 
WHERE TE.FlagActivo = 1 


IF @CodigoPrograma IS NOT NULL 
BEGIN 
	DELETE FROM @Estrategia 
	WHERE isnull(CodigoPrograma, '') <> '' 
	AND (
		(CodigoPrograma <> @CodigoPrograma AND Numeropedido <> @NumeroPedido) 
		OR (CodigoPrograma = @CodigoPrograma AND Numeropedido <> @NumeroPedido)
	) 

END 


SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(EST.DescripcionEstrategia,
		PWD.DescripcionProd) AS DescripcionProd,
	PWD.ClienteNombre AS Nombre,
	PWD.OfertaWeb,
	PWD.IndicadorMontoMinimo,
	ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID,
	ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID,
	ISNULL(PWD.TipoPedido, 'W') TipoPedido,
	EST.DescripcionTipoEstrategia AS DescripcionOferta,
	PWD.MarcaDescripcion AS DescripcionLarga,
	'NO DISPONIBLE' AS Categoria,
	EST.DescripcionTipoEstrategia AS DescripcionEstrategia,
	CASE WHEN EST.FlagNueva = 1 AND @CodigoPrograma IS NOT NULL THEN 1 
		ELSE 0 END AS FlagNueva,
	PWD.IndicadorOfertaCUV,
	PWD.FlagConsultoraOnline,
	PWD.DescuentoProl,
	PWD.MontoEscala,
	PWD.MontoAhorroCatalogo,
	PWD.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PWD.CodigoCatalago,
	EST.TipoEstrategiaCodigo,
	EST.EsOfertaIndependiente,
	EST.EstrategiaID,
	EST.TipoEstrategiaID,
	EST.Numeropedido
FROM @PedidoDetalle PWD 
LEFT JOIN @Estrategia EST 
	ON EST.CUV2 = PWD.CUV 
ORDER BY PWD.OrdenPedidoWD DESC,
PWD.PedidoDetalleID DESC 

END

GO

USE BelcorpDominicana
GO

GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByCampania 
	@CampaniaID	INT,
	@ConsultoraID	BIGINT,
	@CodigoPrograma varchar(15) = NULL,
	@NumeroPedido int = 0 
 AS 
 /* 
 GetPedidoWebDetalleByCampania 201716, 33901, '043', 4 
 GetPedidoWebDetalleByCampania_SB2 201716, 339 01 
 */ 
BEGIN 
SET NOCOUNT ON

SET @CodigoPrograma = CASE WHEN @CodigoPrograma = '' THEN NULL ELSE @CodigoPrograma END 
SET @NumeroPedido = CASE WHEN @NumeroPedido > 0 THEN @NumeroPedido + 1 ELSE 0 END 

DECLARE @PedidoDetalle AS TABLE (
	CampaniaID int,
	PedidoID int,
	PedidoDetalleID int,
	MarcaID tinyint,
	ConsultoraID bigint,
	ClienteID smallint,
	OrdenPedidoWD int,
	Cantidad int,
	PrecioUnidad money,
	ImporteTotal money,
	CUV varchar(20),
	EsKitNueva bit,
	DescripcionProd varchar(800),
	ClienteNombre varchar(200),
	OfertaWeb bit,
	IndicadorMontoMinimo int,
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	TipoPedido char(1),
	DescripcionOferta varchar(200),
	MarcaDescripcion varchar(20),
	CategoriaNombre varchar(50),
	DescripcionEstrategia varchar(200),
	TipoEstrategiaID int,
	IndicadorOfertaCUV bit,
	FlagConsultoraOnline int,
	DescuentoProl money,
	MontoEscala money,
	MontoAhorroCatalogo money,
	MontoAhorroRevista money,
	OrigenPedidoWeb int,
	EsBackOrder bit,
	AceptoBackOrder bit,
	CodigoCatalago char(6),
	TipoEstrategiaCodigo varchar(100),
	EsOfertaIndependiente bit,
	CodigoTipoOferta char(6),
PRIMARY KEY (CampaniaID, PedidoID, PedidoDetalleID) 
) 

INSERT INTO @PedidoDetalle 
SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(MC.Descripcion,
		OP.Descripcion,
		PD.Descripcion,
		PC.Descripcion) AS DescripcionProd, -- FALTA 
	C.Nombre AS ClienteNombre,
	PWD.OfertaWeb,
	PC.IndicadorMontoMinimo,
	PWD.ConfiguracionOfertaID,
	PWD.TipoOfertaSisID,
	PWD.TipoPedido,
	'' AS DescripcionOferta,
	M.Descripcion AS MarcaDescripcion,
	'NO DISPONIBLE' AS Categoria,
	'' AS DescripcionEstrategia,
	0 AS TipoEstrategiaID,
	PC.IndicadorOferta AS IndicadorOfertaCUV,
	0 AS FlagConsultoraOnline,
	PW.DescuentoProl,
	PW.MontoEscala,
	PW.MontoAhorroCatalogo,
	PW.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PC.CodigoCatalago,
	'' AS TipoEstrategiaCodigo,
	0 AS EsOfertaIndependiente,
	PC.CodigoTipoOferta 
FROM dbo.PedidoWebDetalle PWD WITH (NOLOCK) 
INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) 
	ON PW.CampaniaID = PWD.CampaniaID 
	AND PW.PedidoID = PWD.PedidoID 
	and PW.ConsultoraID = PWD.ConsultoraID 
INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) 
	ON PWD.CampaniaID = PC.AnoCampania 
	AND PWD.CUV = PC.CUV 
LEFT JOIN dbo.Cliente C WITH (NOLOCK) 
	ON PWD.ClienteID = C.ClienteID 
	AND PWD.ConsultoraID = C.ConsultoraID 
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) 
	ON PWD.CampaniaID = PD.CampaniaID 
	AND PWD.CUV = PD.CUV 
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) 
	ON OP.CampaniaID = PC.CampaniaID 
	AND OP.CUV = PC.CUV 
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) 
	on PC.CodigoProducto = MC.CodigoSAP 
LEFT JOIN dbo.Marca M WITH (NOLOCK) 
	ON PWD.MarcaId = M.MarcaId 
WHERE	pwd.CampaniaID = @CampaniaID 
	AND pwd.ConsultoraID = @ConsultoraID 
	AND pwd.CUVPadre IS NULL 
	
DECLARE @Estrategia AS TABLE( 
	EstrategiaID int,
	TipoEstrategiaID int,
	Activo bit,
	CampaniaID int,
	CampaniaIDFin int,
	CUV2 varchar(20),
	Numeropedido int,
	DescripcionEstrategia varchar(800),
	EsOfertaIndependiente bit,
	FlagNueva bit,
	DescripcionTipoEstrategia varchar(200),
	TipoEstrategiaCodigo varchar(100),
	CodigoPrograma varchar(3),
PRIMARY KEY (EstrategiaID) 
) 
 
INSERT INTO @Estrategia 
SELECT DISTINCT 
	E.EstrategiaID,
	E.TipoEstrategiaID,
	E.Activo,
	E.CampaniaID,
	E.CampaniaIDFin,
	E.CUV2,
	E.Numeropedido,
	E.DescripcionCUV2 AS DescripcionEstrategia,
	E.EsOfertaIndependiente,
	TE.FlagNueva,
	TE.DescripcionEstrategia AS DescripcionTipoEstrategia,
	TE.Codigo AS TipoEstrategiaCodigo,
	TE.CodigoPrograma 
FROM dbo.Estrategia E WITH (NOLOCK) 
INNER JOIN TipoEstrategia TE WITH (NOLOCK) 
	ON TE.TipoEstrategiaID = E.TipoEstrategiaID 
INNER JOIN @PedidoDetalle PWD 
	ON PWD.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END 
	AND E.CUV2 = PWD.CUV 
	AND E.Activo = 1 
WHERE TE.FlagActivo = 1 


IF @CodigoPrograma IS NOT NULL 
BEGIN 
	DELETE FROM @Estrategia 
	WHERE isnull(CodigoPrograma, '') <> '' 
	AND (
		(CodigoPrograma <> @CodigoPrograma AND Numeropedido <> @NumeroPedido) 
		OR (CodigoPrograma = @CodigoPrograma AND Numeropedido <> @NumeroPedido)
	) 

END 


SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(EST.DescripcionEstrategia,
		PWD.DescripcionProd) AS DescripcionProd,
	PWD.ClienteNombre AS Nombre,
	PWD.OfertaWeb,
	PWD.IndicadorMontoMinimo,
	ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID,
	ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID,
	ISNULL(PWD.TipoPedido, 'W') TipoPedido,
	EST.DescripcionTipoEstrategia AS DescripcionOferta,
	PWD.MarcaDescripcion AS DescripcionLarga,
	'NO DISPONIBLE' AS Categoria,
	EST.DescripcionTipoEstrategia AS DescripcionEstrategia,
	CASE WHEN EST.FlagNueva = 1 AND @CodigoPrograma IS NOT NULL THEN 1 
		ELSE 0 END AS FlagNueva,
	PWD.IndicadorOfertaCUV,
	PWD.FlagConsultoraOnline,
	PWD.DescuentoProl,
	PWD.MontoEscala,
	PWD.MontoAhorroCatalogo,
	PWD.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PWD.CodigoCatalago,
	EST.TipoEstrategiaCodigo,
	EST.EsOfertaIndependiente,
	EST.EstrategiaID,
	EST.TipoEstrategiaID,
	EST.Numeropedido
FROM @PedidoDetalle PWD 
LEFT JOIN @Estrategia EST 
	ON EST.CUV2 = PWD.CUV 
ORDER BY PWD.OrdenPedidoWD DESC,
PWD.PedidoDetalleID DESC 

END

GO

USE BelcorpCostaRica
GO

GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByCampania 
	@CampaniaID	INT,
	@ConsultoraID	BIGINT,
	@CodigoPrograma varchar(15) = NULL,
	@NumeroPedido int = 0 
 AS 
 /* 
 GetPedidoWebDetalleByCampania 201716, 33901, '043', 4 
 GetPedidoWebDetalleByCampania_SB2 201716, 339 01 
 */ 
BEGIN 
SET NOCOUNT ON

SET @CodigoPrograma = CASE WHEN @CodigoPrograma = '' THEN NULL ELSE @CodigoPrograma END 
SET @NumeroPedido = CASE WHEN @NumeroPedido > 0 THEN @NumeroPedido + 1 ELSE 0 END 

DECLARE @PedidoDetalle AS TABLE (
	CampaniaID int,
	PedidoID int,
	PedidoDetalleID int,
	MarcaID tinyint,
	ConsultoraID bigint,
	ClienteID smallint,
	OrdenPedidoWD int,
	Cantidad int,
	PrecioUnidad money,
	ImporteTotal money,
	CUV varchar(20),
	EsKitNueva bit,
	DescripcionProd varchar(800),
	ClienteNombre varchar(200),
	OfertaWeb bit,
	IndicadorMontoMinimo int,
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	TipoPedido char(1),
	DescripcionOferta varchar(200),
	MarcaDescripcion varchar(20),
	CategoriaNombre varchar(50),
	DescripcionEstrategia varchar(200),
	TipoEstrategiaID int,
	IndicadorOfertaCUV bit,
	FlagConsultoraOnline int,
	DescuentoProl money,
	MontoEscala money,
	MontoAhorroCatalogo money,
	MontoAhorroRevista money,
	OrigenPedidoWeb int,
	EsBackOrder bit,
	AceptoBackOrder bit,
	CodigoCatalago char(6),
	TipoEstrategiaCodigo varchar(100),
	EsOfertaIndependiente bit,
	CodigoTipoOferta char(6),
PRIMARY KEY (CampaniaID, PedidoID, PedidoDetalleID) 
) 

INSERT INTO @PedidoDetalle 
SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(MC.Descripcion,
		OP.Descripcion,
		PD.Descripcion,
		PC.Descripcion) AS DescripcionProd, -- FALTA 
	C.Nombre AS ClienteNombre,
	PWD.OfertaWeb,
	PC.IndicadorMontoMinimo,
	PWD.ConfiguracionOfertaID,
	PWD.TipoOfertaSisID,
	PWD.TipoPedido,
	'' AS DescripcionOferta,
	M.Descripcion AS MarcaDescripcion,
	'NO DISPONIBLE' AS Categoria,
	'' AS DescripcionEstrategia,
	0 AS TipoEstrategiaID,
	PC.IndicadorOferta AS IndicadorOfertaCUV,
	0 AS FlagConsultoraOnline,
	PW.DescuentoProl,
	PW.MontoEscala,
	PW.MontoAhorroCatalogo,
	PW.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PC.CodigoCatalago,
	'' AS TipoEstrategiaCodigo,
	0 AS EsOfertaIndependiente,
	PC.CodigoTipoOferta 
FROM dbo.PedidoWebDetalle PWD WITH (NOLOCK) 
INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) 
	ON PW.CampaniaID = PWD.CampaniaID 
	AND PW.PedidoID = PWD.PedidoID 
	and PW.ConsultoraID = PWD.ConsultoraID 
INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) 
	ON PWD.CampaniaID = PC.AnoCampania 
	AND PWD.CUV = PC.CUV 
LEFT JOIN dbo.Cliente C WITH (NOLOCK) 
	ON PWD.ClienteID = C.ClienteID 
	AND PWD.ConsultoraID = C.ConsultoraID 
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) 
	ON PWD.CampaniaID = PD.CampaniaID 
	AND PWD.CUV = PD.CUV 
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) 
	ON OP.CampaniaID = PC.CampaniaID 
	AND OP.CUV = PC.CUV 
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) 
	on PC.CodigoProducto = MC.CodigoSAP 
LEFT JOIN dbo.Marca M WITH (NOLOCK) 
	ON PWD.MarcaId = M.MarcaId 
WHERE	pwd.CampaniaID = @CampaniaID 
	AND pwd.ConsultoraID = @ConsultoraID 
	AND pwd.CUVPadre IS NULL 
	
DECLARE @Estrategia AS TABLE( 
	EstrategiaID int,
	TipoEstrategiaID int,
	Activo bit,
	CampaniaID int,
	CampaniaIDFin int,
	CUV2 varchar(20),
	Numeropedido int,
	DescripcionEstrategia varchar(800),
	EsOfertaIndependiente bit,
	FlagNueva bit,
	DescripcionTipoEstrategia varchar(200),
	TipoEstrategiaCodigo varchar(100),
	CodigoPrograma varchar(3),
PRIMARY KEY (EstrategiaID) 
) 
 
INSERT INTO @Estrategia 
SELECT DISTINCT 
	E.EstrategiaID,
	E.TipoEstrategiaID,
	E.Activo,
	E.CampaniaID,
	E.CampaniaIDFin,
	E.CUV2,
	E.Numeropedido,
	E.DescripcionCUV2 AS DescripcionEstrategia,
	E.EsOfertaIndependiente,
	TE.FlagNueva,
	TE.DescripcionEstrategia AS DescripcionTipoEstrategia,
	TE.Codigo AS TipoEstrategiaCodigo,
	TE.CodigoPrograma 
FROM dbo.Estrategia E WITH (NOLOCK) 
INNER JOIN TipoEstrategia TE WITH (NOLOCK) 
	ON TE.TipoEstrategiaID = E.TipoEstrategiaID 
INNER JOIN @PedidoDetalle PWD 
	ON PWD.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END 
	AND E.CUV2 = PWD.CUV 
	AND E.Activo = 1 
WHERE TE.FlagActivo = 1 


IF @CodigoPrograma IS NOT NULL 
BEGIN 
	DELETE FROM @Estrategia 
	WHERE isnull(CodigoPrograma, '') <> '' 
	AND (
		(CodigoPrograma <> @CodigoPrograma AND Numeropedido <> @NumeroPedido) 
		OR (CodigoPrograma = @CodigoPrograma AND Numeropedido <> @NumeroPedido)
	) 

END 


SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(EST.DescripcionEstrategia,
		PWD.DescripcionProd) AS DescripcionProd,
	PWD.ClienteNombre AS Nombre,
	PWD.OfertaWeb,
	PWD.IndicadorMontoMinimo,
	ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID,
	ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID,
	ISNULL(PWD.TipoPedido, 'W') TipoPedido,
	EST.DescripcionTipoEstrategia AS DescripcionOferta,
	PWD.MarcaDescripcion AS DescripcionLarga,
	'NO DISPONIBLE' AS Categoria,
	EST.DescripcionTipoEstrategia AS DescripcionEstrategia,
	CASE WHEN EST.FlagNueva = 1 AND @CodigoPrograma IS NOT NULL THEN 1 
		ELSE 0 END AS FlagNueva,
	PWD.IndicadorOfertaCUV,
	PWD.FlagConsultoraOnline,
	PWD.DescuentoProl,
	PWD.MontoEscala,
	PWD.MontoAhorroCatalogo,
	PWD.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PWD.CodigoCatalago,
	EST.TipoEstrategiaCodigo,
	EST.EsOfertaIndependiente,
	EST.EstrategiaID,
	EST.TipoEstrategiaID,
	EST.Numeropedido
FROM @PedidoDetalle PWD 
LEFT JOIN @Estrategia EST 
	ON EST.CUV2 = PWD.CUV 
ORDER BY PWD.OrdenPedidoWD DESC,
PWD.PedidoDetalleID DESC 

END

GO

USE BelcorpChile
GO

GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByCampania 
	@CampaniaID	INT,
	@ConsultoraID	BIGINT,
	@CodigoPrograma varchar(15) = NULL,
	@NumeroPedido int = 0 
 AS 
 /* 
 GetPedidoWebDetalleByCampania 201716, 33901, '043', 4 
 GetPedidoWebDetalleByCampania_SB2 201716, 339 01 
 */ 
BEGIN 
SET NOCOUNT ON

SET @CodigoPrograma = CASE WHEN @CodigoPrograma = '' THEN NULL ELSE @CodigoPrograma END 
SET @NumeroPedido = CASE WHEN @NumeroPedido > 0 THEN @NumeroPedido + 1 ELSE 0 END 

DECLARE @PedidoDetalle AS TABLE (
	CampaniaID int,
	PedidoID int,
	PedidoDetalleID int,
	MarcaID tinyint,
	ConsultoraID bigint,
	ClienteID smallint,
	OrdenPedidoWD int,
	Cantidad int,
	PrecioUnidad money,
	ImporteTotal money,
	CUV varchar(20),
	EsKitNueva bit,
	DescripcionProd varchar(800),
	ClienteNombre varchar(200),
	OfertaWeb bit,
	IndicadorMontoMinimo int,
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	TipoPedido char(1),
	DescripcionOferta varchar(200),
	MarcaDescripcion varchar(20),
	CategoriaNombre varchar(50),
	DescripcionEstrategia varchar(200),
	TipoEstrategiaID int,
	IndicadorOfertaCUV bit,
	FlagConsultoraOnline int,
	DescuentoProl money,
	MontoEscala money,
	MontoAhorroCatalogo money,
	MontoAhorroRevista money,
	OrigenPedidoWeb int,
	EsBackOrder bit,
	AceptoBackOrder bit,
	CodigoCatalago char(6),
	TipoEstrategiaCodigo varchar(100),
	EsOfertaIndependiente bit,
	CodigoTipoOferta char(6),
PRIMARY KEY (CampaniaID, PedidoID, PedidoDetalleID) 
) 

INSERT INTO @PedidoDetalle 
SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(MC.Descripcion,
		OP.Descripcion,
		PD.Descripcion,
		PC.Descripcion) AS DescripcionProd, -- FALTA 
	C.Nombre AS ClienteNombre,
	PWD.OfertaWeb,
	PC.IndicadorMontoMinimo,
	PWD.ConfiguracionOfertaID,
	PWD.TipoOfertaSisID,
	PWD.TipoPedido,
	'' AS DescripcionOferta,
	M.Descripcion AS MarcaDescripcion,
	'NO DISPONIBLE' AS Categoria,
	'' AS DescripcionEstrategia,
	0 AS TipoEstrategiaID,
	PC.IndicadorOferta AS IndicadorOfertaCUV,
	0 AS FlagConsultoraOnline,
	PW.DescuentoProl,
	PW.MontoEscala,
	PW.MontoAhorroCatalogo,
	PW.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PC.CodigoCatalago,
	'' AS TipoEstrategiaCodigo,
	0 AS EsOfertaIndependiente,
	PC.CodigoTipoOferta 
FROM dbo.PedidoWebDetalle PWD WITH (NOLOCK) 
INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) 
	ON PW.CampaniaID = PWD.CampaniaID 
	AND PW.PedidoID = PWD.PedidoID 
	and PW.ConsultoraID = PWD.ConsultoraID 
INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) 
	ON PWD.CampaniaID = PC.AnoCampania 
	AND PWD.CUV = PC.CUV 
LEFT JOIN dbo.Cliente C WITH (NOLOCK) 
	ON PWD.ClienteID = C.ClienteID 
	AND PWD.ConsultoraID = C.ConsultoraID 
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) 
	ON PWD.CampaniaID = PD.CampaniaID 
	AND PWD.CUV = PD.CUV 
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) 
	ON OP.CampaniaID = PC.CampaniaID 
	AND OP.CUV = PC.CUV 
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) 
	on PC.CodigoProducto = MC.CodigoSAP 
LEFT JOIN dbo.Marca M WITH (NOLOCK) 
	ON PWD.MarcaId = M.MarcaId 
WHERE	pwd.CampaniaID = @CampaniaID 
	AND pwd.ConsultoraID = @ConsultoraID 
	AND pwd.CUVPadre IS NULL 
	
DECLARE @Estrategia AS TABLE( 
	EstrategiaID int,
	TipoEstrategiaID int,
	Activo bit,
	CampaniaID int,
	CampaniaIDFin int,
	CUV2 varchar(20),
	Numeropedido int,
	DescripcionEstrategia varchar(800),
	EsOfertaIndependiente bit,
	FlagNueva bit,
	DescripcionTipoEstrategia varchar(200),
	TipoEstrategiaCodigo varchar(100),
	CodigoPrograma varchar(3),
PRIMARY KEY (EstrategiaID) 
) 
 
INSERT INTO @Estrategia 
SELECT DISTINCT 
	E.EstrategiaID,
	E.TipoEstrategiaID,
	E.Activo,
	E.CampaniaID,
	E.CampaniaIDFin,
	E.CUV2,
	E.Numeropedido,
	E.DescripcionCUV2 AS DescripcionEstrategia,
	E.EsOfertaIndependiente,
	TE.FlagNueva,
	TE.DescripcionEstrategia AS DescripcionTipoEstrategia,
	TE.Codigo AS TipoEstrategiaCodigo,
	TE.CodigoPrograma 
FROM dbo.Estrategia E WITH (NOLOCK) 
INNER JOIN TipoEstrategia TE WITH (NOLOCK) 
	ON TE.TipoEstrategiaID = E.TipoEstrategiaID 
INNER JOIN @PedidoDetalle PWD 
	ON PWD.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END 
	AND E.CUV2 = PWD.CUV 
	AND E.Activo = 1 
WHERE TE.FlagActivo = 1 


IF @CodigoPrograma IS NOT NULL 
BEGIN 
	DELETE FROM @Estrategia 
	WHERE isnull(CodigoPrograma, '') <> '' 
	AND (
		(CodigoPrograma <> @CodigoPrograma AND Numeropedido <> @NumeroPedido) 
		OR (CodigoPrograma = @CodigoPrograma AND Numeropedido <> @NumeroPedido)
	) 

END 


SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(EST.DescripcionEstrategia,
		PWD.DescripcionProd) AS DescripcionProd,
	PWD.ClienteNombre AS Nombre,
	PWD.OfertaWeb,
	PWD.IndicadorMontoMinimo,
	ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID,
	ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID,
	ISNULL(PWD.TipoPedido, 'W') TipoPedido,
	EST.DescripcionTipoEstrategia AS DescripcionOferta,
	PWD.MarcaDescripcion AS DescripcionLarga,
	'NO DISPONIBLE' AS Categoria,
	EST.DescripcionTipoEstrategia AS DescripcionEstrategia,
	CASE WHEN EST.FlagNueva = 1 AND @CodigoPrograma IS NOT NULL THEN 1 
		ELSE 0 END AS FlagNueva,
	PWD.IndicadorOfertaCUV,
	PWD.FlagConsultoraOnline,
	PWD.DescuentoProl,
	PWD.MontoEscala,
	PWD.MontoAhorroCatalogo,
	PWD.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PWD.CodigoCatalago,
	EST.TipoEstrategiaCodigo,
	EST.EsOfertaIndependiente,
	EST.EstrategiaID,
	EST.TipoEstrategiaID,
	EST.Numeropedido
FROM @PedidoDetalle PWD 
LEFT JOIN @Estrategia EST 
	ON EST.CUV2 = PWD.CUV 
ORDER BY PWD.OrdenPedidoWD DESC,
PWD.PedidoDetalleID DESC 

END

GO

USE BelcorpBolivia
GO

GO

ALTER PROCEDURE dbo.GetPedidoWebDetalleByCampania 
	@CampaniaID	INT,
	@ConsultoraID	BIGINT,
	@CodigoPrograma varchar(15) = NULL,
	@NumeroPedido int = 0 
 AS 
 /* 
 GetPedidoWebDetalleByCampania 201716, 33901, '043', 4 
 GetPedidoWebDetalleByCampania_SB2 201716, 339 01 
 */ 
BEGIN 
SET NOCOUNT ON

SET @CodigoPrograma = CASE WHEN @CodigoPrograma = '' THEN NULL ELSE @CodigoPrograma END 
SET @NumeroPedido = CASE WHEN @NumeroPedido > 0 THEN @NumeroPedido + 1 ELSE 0 END 

DECLARE @PedidoDetalle AS TABLE (
	CampaniaID int,
	PedidoID int,
	PedidoDetalleID int,
	MarcaID tinyint,
	ConsultoraID bigint,
	ClienteID smallint,
	OrdenPedidoWD int,
	Cantidad int,
	PrecioUnidad money,
	ImporteTotal money,
	CUV varchar(20),
	EsKitNueva bit,
	DescripcionProd varchar(800),
	ClienteNombre varchar(200),
	OfertaWeb bit,
	IndicadorMontoMinimo int,
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	TipoPedido char(1),
	DescripcionOferta varchar(200),
	MarcaDescripcion varchar(20),
	CategoriaNombre varchar(50),
	DescripcionEstrategia varchar(200),
	TipoEstrategiaID int,
	IndicadorOfertaCUV bit,
	FlagConsultoraOnline int,
	DescuentoProl money,
	MontoEscala money,
	MontoAhorroCatalogo money,
	MontoAhorroRevista money,
	OrigenPedidoWeb int,
	EsBackOrder bit,
	AceptoBackOrder bit,
	CodigoCatalago char(6),
	TipoEstrategiaCodigo varchar(100),
	EsOfertaIndependiente bit,
	CodigoTipoOferta char(6),
PRIMARY KEY (CampaniaID, PedidoID, PedidoDetalleID) 
) 

INSERT INTO @PedidoDetalle 
SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(MC.Descripcion,
		OP.Descripcion,
		PD.Descripcion,
		PC.Descripcion) AS DescripcionProd, -- FALTA 
	C.Nombre AS ClienteNombre,
	PWD.OfertaWeb,
	PC.IndicadorMontoMinimo,
	PWD.ConfiguracionOfertaID,
	PWD.TipoOfertaSisID,
	PWD.TipoPedido,
	'' AS DescripcionOferta,
	M.Descripcion AS MarcaDescripcion,
	'NO DISPONIBLE' AS Categoria,
	'' AS DescripcionEstrategia,
	0 AS TipoEstrategiaID,
	PC.IndicadorOferta AS IndicadorOfertaCUV,
	0 AS FlagConsultoraOnline,
	PW.DescuentoProl,
	PW.MontoEscala,
	PW.MontoAhorroCatalogo,
	PW.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PC.CodigoCatalago,
	'' AS TipoEstrategiaCodigo,
	0 AS EsOfertaIndependiente,
	PC.CodigoTipoOferta 
FROM dbo.PedidoWebDetalle PWD WITH (NOLOCK) 
INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) 
	ON PW.CampaniaID = PWD.CampaniaID 
	AND PW.PedidoID = PWD.PedidoID 
	and PW.ConsultoraID = PWD.ConsultoraID 
INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) 
	ON PWD.CampaniaID = PC.AnoCampania 
	AND PWD.CUV = PC.CUV 
LEFT JOIN dbo.Cliente C WITH (NOLOCK) 
	ON PWD.ClienteID = C.ClienteID 
	AND PWD.ConsultoraID = C.ConsultoraID 
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) 
	ON PWD.CampaniaID = PD.CampaniaID 
	AND PWD.CUV = PD.CUV 
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) 
	ON OP.CampaniaID = PC.CampaniaID 
	AND OP.CUV = PC.CUV 
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) 
	on PC.CodigoProducto = MC.CodigoSAP 
LEFT JOIN dbo.Marca M WITH (NOLOCK) 
	ON PWD.MarcaId = M.MarcaId 
WHERE	pwd.CampaniaID = @CampaniaID 
	AND pwd.ConsultoraID = @ConsultoraID 
	AND pwd.CUVPadre IS NULL 
	
DECLARE @Estrategia AS TABLE( 
	EstrategiaID int,
	TipoEstrategiaID int,
	Activo bit,
	CampaniaID int,
	CampaniaIDFin int,
	CUV2 varchar(20),
	Numeropedido int,
	DescripcionEstrategia varchar(800),
	EsOfertaIndependiente bit,
	FlagNueva bit,
	DescripcionTipoEstrategia varchar(200),
	TipoEstrategiaCodigo varchar(100),
	CodigoPrograma varchar(3),
PRIMARY KEY (EstrategiaID) 
) 
 
INSERT INTO @Estrategia 
SELECT DISTINCT 
	E.EstrategiaID,
	E.TipoEstrategiaID,
	E.Activo,
	E.CampaniaID,
	E.CampaniaIDFin,
	E.CUV2,
	E.Numeropedido,
	E.DescripcionCUV2 AS DescripcionEstrategia,
	E.EsOfertaIndependiente,
	TE.FlagNueva,
	TE.DescripcionEstrategia AS DescripcionTipoEstrategia,
	TE.Codigo AS TipoEstrategiaCodigo,
	TE.CodigoPrograma 
FROM dbo.Estrategia E WITH (NOLOCK) 
INNER JOIN TipoEstrategia TE WITH (NOLOCK) 
	ON TE.TipoEstrategiaID = E.TipoEstrategiaID 
INNER JOIN @PedidoDetalle PWD 
	ON PWD.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END 
	AND E.CUV2 = PWD.CUV 
	AND E.Activo = 1 
WHERE TE.FlagActivo = 1 


IF @CodigoPrograma IS NOT NULL 
BEGIN 
	DELETE FROM @Estrategia 
	WHERE isnull(CodigoPrograma, '') <> '' 
	AND (
		(CodigoPrograma <> @CodigoPrograma AND Numeropedido <> @NumeroPedido) 
		OR (CodigoPrograma = @CodigoPrograma AND Numeropedido <> @NumeroPedido)
	) 

END 


SELECT 
	PWD.CampaniaID,
	PWD.PedidoID,
	PWD.PedidoDetalleID,
	PWD.MarcaID,
	PWD.ConsultoraID,
	PWD.ClienteID,
	PWD.OrdenPedidoWD,
	PWD.Cantidad,
	PWD.PrecioUnidad,
	PWD.ImporteTotal,
	PWD.CUV,
	PWD.EsKitNueva,
	COALESCE(EST.DescripcionEstrategia,
		PWD.DescripcionProd) AS DescripcionProd,
	PWD.ClienteNombre AS Nombre,
	PWD.OfertaWeb,
	PWD.IndicadorMontoMinimo,
	ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID,
	ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID,
	ISNULL(PWD.TipoPedido, 'W') TipoPedido,
	EST.DescripcionTipoEstrategia AS DescripcionOferta,
	PWD.MarcaDescripcion AS DescripcionLarga,
	'NO DISPONIBLE' AS Categoria,
	EST.DescripcionTipoEstrategia AS DescripcionEstrategia,
	CASE WHEN EST.FlagNueva = 1 AND @CodigoPrograma IS NOT NULL THEN 1 
		ELSE 0 END AS FlagNueva,
	PWD.IndicadorOfertaCUV,
	PWD.FlagConsultoraOnline,
	PWD.DescuentoProl,
	PWD.MontoEscala,
	PWD.MontoAhorroCatalogo,
	PWD.MontoAhorroRevista,
	PWD.OrigenPedidoWeb,
	PWD.EsBackOrder,
	PWD.AceptoBackOrder,
	PWD.CodigoCatalago,
	EST.TipoEstrategiaCodigo,
	EST.EsOfertaIndependiente,
	EST.EstrategiaID,
	EST.TipoEstrategiaID,
	EST.Numeropedido
FROM @PedidoDetalle PWD 
LEFT JOIN @Estrategia EST 
	ON EST.CUV2 = PWD.CUV 
ORDER BY PWD.OrdenPedidoWD DESC,
PWD.PedidoDetalleID DESC 

END

GO

