USE BelcorpChile
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'interfaces')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA interfaces';
END
------------------------------------------------------
GO
IF OBJECT_ID('interfaces.ProcesoJetloreConfiguracion') IS NOT NULL
	DROP TABLE interfaces.ProcesoJetloreConfiguracion
GO
CREATE TABLE interfaces.ProcesoJetloreConfiguracion(
	ProcesoJetloreConfiguracionId int NOT NULL,
	CodigoProceso varchar(6) NULL,
	Activo bit NULL,
	RestriccionEjecucion bit NULL,
	HoraInicioRestriccion time(0) NULL,
	HoraFinRestriccion time(0) NULL,
	CreacionLog bit NULL,
	EnvioCorreoTodo bit NULL,
	EnvioCorreoError bit NULL
	CONSTRAINT PK_ProcesoJetloreConfiguracion PRIMARY KEY CLUSTERED 
	(
		ProcesoJetloreConfiguracionId ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY];
------------------------------------------------------
GO
IF NOT EXISTS(SELECT 1 FROM interfaces.ProcesoJetloreConfiguracion WHERE CodigoProceso = 'PRF-01')
BEGIN
	INSERT interfaces.ProcesoJetloreConfiguracion(ProcesoJetloreConfiguracionId,CodigoProceso,Activo,RestriccionEjecucion,HoraInicioRestriccion,HoraFinRestriccion,CreacionLog,EnvioCorreoTodo,EnvioCorreoError)
	VALUES (1, 'PRF-01', 1, 1, '08:00:00', '20:00:00',1,1,1);
END
GO
IF NOT EXISTS(SELECT 1 FROM interfaces.ProcesoJetloreConfiguracion WHERE CodigoProceso = 'HID-01')
BEGIN
	INSERT interfaces.ProcesoJetloreConfiguracion(ProcesoJetloreConfiguracionId,CodigoProceso,Activo,RestriccionEjecucion,HoraInicioRestriccion,HoraFinRestriccion,CreacionLog,EnvioCorreoTodo,EnvioCorreoError)
	VALUES (2, 'HID-01', 1, 1, '08:00:00', '20:00:00',1,1,1);
END
------------------------------------------------------
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoJetloreConfiguracion' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.GetProcesoJetloreConfiguracion
END
GO
CREATE PROCEDURE interfaces.GetProcesoJetloreConfiguracion
	@CodigoProceso varchar(20)
AS
BEGIN
	select top 1
		ProcesoJetloreConfiguracionId,
		CodigoProceso,
		Activo,
		RestriccionEjecucion,
		HoraInicioRestriccion,
		HoraFinRestriccion,
		CreacionLog,
		EnvioCorreoTodo,
		EnvioCorreoError
	from interfaces.ProcesoJetloreConfiguracion
	where CodigoProceso = @CodigoProceso
END
------------------------------------------------------
GO
IF OBJECT_ID('interfaces.ProcesoJetlore') IS NOT NULL
	DROP TABLE interfaces.ProcesoJetlore
GO
CREATE TABLE interfaces.ProcesoJetlore(
	ProcesoJetloreId bigint IDENTITY(1,1) NOT NULL,
	CodigoProceso varchar(20) NULL,
	FechaHoraInicio datetime NULL,
	FechaHoraFin datetime NULL,
	Estado int NULL,
	ErrorProceso varchar(1000) NULL,
	ErrorLog varchar(2000) NULL,
	CONSTRAINT PK_ProcesoJetlore PRIMARY KEY CLUSTERED 
	(
		ProcesoJetloreId ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY];
------------------------------------------------------
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoJetlore' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.GetProcesoJetlore
END
GO
CREATE PROCEDURE interfaces.GetProcesoJetlore
	@CodigoProceso varchar(20)
AS
BEGIN
	DECLARE @Activo bit;
	DECLARE @RestriccionEjecucion bit;
	DECLARE @HoraInicioRestriccion time;
	DECLARE @HoraFinRestriccion time;

	select
		@Activo = Activo,
		@RestriccionEjecucion = RestriccionEjecucion,
		@HoraInicioRestriccion = HoraInicioRestriccion,
		@HoraFinRestriccion = HoraFinRestriccion
	from interfaces.ProcesoJetloreConfiguracion
	where CodigoProceso = @CodigoProceso
	
	DECLARE @Valido int;
	IF ISNULL(@Activo,0) = 0
		SET @Valido = 0;
	ELSE IF ISNULL(@RestriccionEjecucion,0) = 0
		SET @Valido = 1;
	ELSE
	BEGIN
		DECLARE @HoraPais time = cast(dbo.fnObtenerFechaHoraPais() as time);
		IF (@HoraInicioRestriccion <= @HoraPais and @HoraPais <= @HoraFinRestriccion)
			SET @Valido = 1;
		ELSE
			SET @Valido = 0;
	END
	
	DECLARE @Estado int = NULL;
	IF (@Valido = 1)
	BEGIN
		select top 1 @Estado = Estado
		from interfaces.ProcesoJetlore (nolock)
		where
			CodigoProceso = @CodigoProceso
			and
			cast(FechaHoraInicio as date) = cast(getdate() as date)
		order by ProcesoJetloreId desc;
	END
	ELSE
		set @Estado = -1;

	select ISNULL(@Estado,0) AS Estado;
END
------------------------------------------------------
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsProcesoJetlore' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.InsProcesoJetlore
END
GO
CREATE PROCEDURE interfaces.InsProcesoJetlore
	@CodigoProceso varchar(20)
AS
BEGIN
	INSERT INTO interfaces.ProcesoJetlore(CodigoProceso,FechaHoraInicio,Estado)
	VALUES(@CodigoProceso,getdate(),1);

	select SCOPE_IDENTITY();
END
------------------------------------------------------
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdProcesoJetlore' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.UpdProcesoJetlore
END
GO
CREATE PROCEDURE interfaces.UpdProcesoJetlore
	@ProcesoJetloreId bigint,
	@Estado int,
	@ErrorProceso varchar(1000),
	@ErrorLog varchar(1500)
as
BEGIN
	UPDATE interfaces.ProcesoJetlore
	SET	
		Estado = @Estado,
		FechaHoraFin = GETDATE(),
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog
	WHERE ProcesoJetloreId = @ProcesoJetloreId
END
------------------------------------------------------
GO
IF OBJECT_ID('ods.SAP_SUBCATEGORIA') IS NULL
BEGIN
	CREATE SYNONYM ods.SAP_SUBCATEGORIA
	FOR ODS_PE.dbo.SAP_SUBCATEGORIA;
END
GO
IF OBJECT_ID('ods.SAP_TIPO') IS NULL
BEGIN
	CREATE SYNONYM ods.SAP_TIPO
	FOR ODS_PE.dbo.SAP_TIPO;  
END
GO
IF OBJECT_ID('ods.SAP_SUBTIPO') IS NULL
BEGIN
	CREATE SYNONYM ods.SAP_SUBTIPO
	FOR ODS_PE.dbo.SAP_SUBTIPO;  
END
------------------------------------------------------
GO
IF OBJECT_ID('interfaces.JetloreTipoOferta') IS NOT NULL
	DROP TABLE interfaces.JetloreTipoOferta
GO
CREATE TABLE interfaces.JetloreTipoOferta(
	TipoOfertaId VARCHAR(3) NOT NULL
	CONSTRAINT PK_JetloreTipoOferta PRIMARY KEY CLUSTERED
	(
		TipoOfertaId ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY];
------------------------------------------------------
GO
IF NOT EXISTS(SELECT 1 FROM interfaces.JetloreTipoOferta WHERE TipoOfertaId = '004')
BEGIN
	INSERT interfaces.JetloreTipoOferta(TipoOfertaId) VALUES ('004');
END
GO
IF NOT EXISTS(SELECT 1 FROM interfaces.JetloreTipoOferta WHERE TipoOfertaId = '011')
BEGIN
	INSERT interfaces.JetloreTipoOferta(TipoOfertaId) VALUES ('011');
END
GO
IF NOT EXISTS(SELECT 1 FROM interfaces.JetloreTipoOferta WHERE TipoOfertaId = '013')
BEGIN
	INSERT interfaces.JetloreTipoOferta(TipoOfertaId) VALUES ('013');
END
GO
IF NOT EXISTS(SELECT 1 FROM interfaces.JetloreTipoOferta WHERE TipoOfertaId = '014')
BEGIN
	INSERT interfaces.JetloreTipoOferta(TipoOfertaId) VALUES ('014');
END
GO
IF NOT EXISTS(SELECT 1 FROM interfaces.JetloreTipoOferta WHERE TipoOfertaId = '015')
BEGIN
	INSERT interfaces.JetloreTipoOferta(TipoOfertaId) VALUES ('015');
END
GO
IF NOT EXISTS(SELECT 1 FROM interfaces.JetloreTipoOferta WHERE TipoOfertaId = '017')
BEGIN
	INSERT interfaces.JetloreTipoOferta(TipoOfertaId) VALUES ('017');
END
GO
IF NOT EXISTS(SELECT 1 FROM interfaces.JetloreTipoOferta WHERE TipoOfertaId = '018')
BEGIN
	INSERT interfaces.JetloreTipoOferta(TipoOfertaId) VALUES ('018');
END
GO
IF NOT EXISTS(SELECT 1 FROM interfaces.JetloreTipoOferta WHERE TipoOfertaId = '033')
BEGIN
	INSERT interfaces.JetloreTipoOferta(TipoOfertaId) VALUES ('033');
END
GO
IF NOT EXISTS(SELECT 1 FROM interfaces.JetloreTipoOferta WHERE TipoOfertaId = '106')
BEGIN
	INSERT interfaces.JetloreTipoOferta(TipoOfertaId) VALUES ('106');
END
GO
IF NOT EXISTS(SELECT 1 FROM interfaces.JetloreTipoOferta WHERE TipoOfertaId = '116')
BEGIN
	INSERT interfaces.JetloreTipoOferta(TipoOfertaId) VALUES ('116');
END
------------------------------------------------------
GO
IF OBJECT_ID('interfaces.JetloreTaxonomia') IS NOT NULL
	DROP TABLE interfaces.JetloreTaxonomia
GO
CREATE TABLE interfaces.JetloreTaxonomia(
	JetloreTaxonomiaId INT IDENTITY(1,1) NOT NULL,
	Categoria VARCHAR(50) NOT NULL,
	SubCategoria VARCHAR(50) NULL,
	Tipo VARCHAR(50) NULL,
	SubTipo VARCHAR(50) NULL,
	CONSTRAINT PK_JetloreTaxonomia PRIMARY KEY CLUSTERED
	(
		JetloreTaxonomiaId ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY];
------------------------------------------------------
GO
IF NOT EXISTS(
	SELECT 1
	FROM interfaces.JetloreTaxonomia
	WHERE Categoria = 'Cuidado Personal' AND SubCategoria IS NULL AND Tipo IS NULL AND SubTipo IS NULL
)
BEGIN
	INSERT interfaces.JetloreTaxonomia(Categoria,SubCategoria,Tipo,SubTipo)
	VALUES ('Cuidado Personal',NULL,NULL,NULL);
END
GO
IF NOT EXISTS(
	SELECT 1
	FROM interfaces.JetloreTaxonomia
	WHERE Categoria = 'Fragancias' AND SubCategoria IS NULL AND Tipo IS NULL AND SubTipo IS NULL
)
BEGIN
	INSERT interfaces.JetloreTaxonomia(Categoria,SubCategoria,Tipo,SubTipo)
	VALUES ('Fragancias',NULL,NULL,NULL);
END
GO
IF NOT EXISTS(
	SELECT 1
	FROM interfaces.JetloreTaxonomia
	WHERE Categoria = 'Maquillaje' AND SubCategoria IS NULL AND Tipo IS NULL AND SubTipo IS NULL
)
BEGIN
	INSERT interfaces.JetloreTaxonomia(Categoria,SubCategoria,Tipo,SubTipo)
	VALUES ('Maquillaje',NULL,NULL,NULL);
END
GO
IF NOT EXISTS(
	SELECT 1
	FROM interfaces.JetloreTaxonomia
	WHERE Categoria = 'Tratamiento Facial' AND SubCategoria IS NULL AND Tipo IS NULL AND SubTipo IS NULL
)
BEGIN
	INSERT interfaces.JetloreTaxonomia(Categoria,SubCategoria,Tipo,SubTipo)
	VALUES ('Tratamiento Facial',NULL,NULL,NULL);
END
GO
IF NOT EXISTS(
	SELECT 1
	FROM interfaces.JetloreTaxonomia
	WHERE Categoria = 'Tratamiento Corporal' AND SubCategoria IS NULL AND Tipo IS NULL AND SubTipo IS NULL
)
BEGIN
	INSERT interfaces.JetloreTaxonomia(Categoria,SubCategoria,Tipo,SubTipo)
	VALUES ('Tratamiento Corporal',NULL,NULL,NULL);
END
------------------------------------------------------
GO
IF OBJECT_ID('dbo.fnGetCampaniaActualPais') IS NOT NULL
	DROP FUNCTION dbo.fnGetCampaniaActualPais
GO
GO
CREATE FUNCTION dbo.fnGetCampaniaActualPais()
RETURNS INT
AS
BEGIN
	DECLARE @CampaniaActual INT;
	SELECT TOP 1 @CampaniaActual = Ca.Codigo
	FROM ods.cronograma Cr WITH(NOLOCK)
	INNER JOIN ods.campania Ca WITH(NOLOCK) on Cr.CampaniaID = Ca.CampaniaID
	WHERE Cr.fechainiciorefacturacion >= CAST(GETDATE() AS DATE)
	ORDER BY Cr.campaniaid;

	RETURN @CampaniaActual;
END
------------------------------------------------------
GO
IF OBJECT_ID('dbo.fnAddCampaniaAndNumero') IS NOT NULL
	DROP FUNCTION dbo.fnAddCampaniaAndNumero
GO
GO
CREATE FUNCTION dbo.fnAddCampaniaAndNumero(
	@CodigoISO CHAR(2),
	@CampaniaActual INT,
	@AddNro INT
)
RETURNS INT
AS
BEGIN
	DECLARE @NroCampanias INT;
	SELECT @NroCampanias = NroCampanias
	FROM Pais
	WHERE CodigoISO = @CodigoISO;
	
	DECLARE @AnioCampaniaActual INT = @CampaniaActual/100;
	DECLARE @NroCampaniaActual INT = @CampaniaActual%100;
	DECLARE @SumNroCampania INT = (@NroCampaniaActual + @AddNro) - 1;
	DECLARE @AnioCampaniaSiguiente INT = @AnioCampaniaActual + @SumNroCampania/@NroCampanias;
	DECLARE @NroCampaniaSiguiente INT = @SumNroCampania%@NroCampanias + 1;
	
	IF @NroCampaniaSiguiente < 1
	BEGIN
		SET @AnioCampaniaSiguiente = @AnioCampaniaSiguiente - 1;
		SET @NroCampaniaSiguiente = @NroCampaniaSiguiente + @NroCampanias;
	END
	DECLARE @CampaniaSiguiente INT = @AnioCampaniaSiguiente*100 + @NroCampaniaSiguiente;
	RETURN @CampaniaSiguiente;
END
------------------------------------------------------
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetJetloreProductFeed' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.GetJetloreProductFeed
END
GO
CREATE PROCEDURE interfaces.GetJetloreProductFeed
	@CodigoISO CHAR(2),
	@OffsetRows INT,
	@NumberRows INT
AS
BEGIN
	DECLARE @CampaniaActual INT = dbo.fnGetCampaniaActualPais();
	DECLARE @CampaniaSiguiente INT = dbo.fnAddCampaniaAndNumero(@CodigoISO,@CampaniaActual,1);
	
	SELECT
		PC.AnoCampania AS Campania,
		PC.CUV,
		PC.CodigoProducto,
		PC.CodigoTipoOferta,
		PC.PrecioUnitario AS Precio,
		PC.Descripcion,
		SC.DescripcionCategoria AS Categoria,
		SSC.DescripcionSubCategoria AS SubCategoria,
		ST.DescripcionTipo AS Tipo,
		SST.DescripcionSubTipo AS SubTipo,
		PC.CodigoMarca AS Marca,
		CASE 
			WHEN 
				PC.IndicadorDigitable = 1 AND JTO.TipoOfertaId IS NOT NULL
				AND
				EXISTS(
					SELECT 1
					FROM interfaces.JetloreTaxonomia JTx
					WHERE
						JTx.Categoria = SC.DescripcionCategoria AND (
							JTx.SubCategoria IS NULL OR (
								JTx.SubCategoria = SSC.DescripcionSubCategoria AND (
									JTx.Tipo IS NULL OR (
										JTx.Tipo = ST.DescripcionTipo AND (
											JTx.SubTipo IS NULL OR JTx.SubTipo = SST.DescripcionSubTipo
										)
									)
								)
							)
						)
				)
				THEN 1
			ELSE 0
		END AS EsRecomendable
	FROM ods.ProductoComercial PC WITH(NOLOCK)
	INNER JOIN ods.SAP_PRODUCTO SP WITH(NOLOCK) ON PC.CodigoProducto = SP.CodigoSap
	INNER JOIN ods.SAP_CATEGORIA SC WITH(NOLOCK) ON SP.CodigoCategoria = SC.CodigoCategoria
	INNER JOIN ods.SAP_SUBCATEGORIA SSC WITH(NOLOCK) ON SP.CodigoSubCategoria = SSC.CodigoSubCategoria
	INNER JOIN ods.SAP_TIPO ST WITH(NOLOCK) ON SP.CodigoTipo = ST.CodigoTipo
	INNER JOIN ods.SAP_SUBTIPO SST WITH(NOLOCK) ON SP.CodigoSubTipo = SST.CodigoSubTipo
	LEFT JOIN interfaces.JetloreTipoOferta JTO WITH(NOLOCK) ON PC.CodigoTipoOferta = JTO.TipoOfertaId
	WHERE PC.AnoCampania IN (@CampaniaActual,@CampaniaSiguiente)
	ORDER BY
		PC.AnoCampania,
		PC.Cuv
	OFFSET @OffsetRows ROWS 
	FETCH NEXT @NumberRows ROWS ONLY;
END
------------------------------------------------------
GO
IF OBJECT_ID('interfaces.LogPJProductFeed') IS NOT NULL
	DROP TABLE interfaces.LogPJProductFeed
GO
CREATE TABLE interfaces.LogPJProductFeed(
	LogPJProductFeedId bigint IDENTITY(1,1) NOT NULL,
	PJProductFeedId bigint NOT NULL,
	Campaign varchar(6) NOT NULL,
	SalesCode varchar(5) NOT NULL,
	SKU varchar(15) NOT NULL,
	PromotionCode varchar(3) NOT NULL,
	Price decimal(17,2) NOT NULL,
	OriginalPrice decimal(17,2) NOT NULL,
	Currency varchar(3) NOT NULL,
	Title varchar(100) NOT NULL,	
	ProductURL varchar(100) NOT NULL,
	ProductImgURL varchar(100) NOT NULL,
	ProductTaxonomy varchar(100) NOT NULL,
	Brand varchar(4) NOT NULL,
	IsRecommendable bit NOT NULL,
	ProductAttributes varchar(100) NOT NULL
	CONSTRAINT PK_LogPJProductFeed PRIMARY KEY CLUSTERED 
	(
		LogPJProductFeedId ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY];
------------------------------------------------------
GO
IF TYPE_ID('interfaces.JetloreProductFeedType') IS NOT NULL
	DROP TYPE interfaces.JetloreProductFeedType
GO
CREATE TYPE interfaces.JetloreProductFeedType AS TABLE(
	Campaign varchar(6) NOT NULL,
	SalesCode varchar(5) NOT NULL,
	SKU varchar(15) NOT NULL,
	PromotionCode varchar(3) NOT NULL,
	Price decimal(17,2) NOT NULL,
	OriginalPrice decimal(17,2) NOT NULL,
	Currency varchar(3) NOT NULL,
	Title varchar(100) NOT NULL,	
	ProductURL varchar(100) NOT NULL,
	ProductImgURL varchar(100) NOT NULL,
	ProductTaxonomy varchar(100) NOT NULL,
	Brand varchar(4) NOT NULL,
	IsRecommendable bit NOT NULL,
	ProductAttributes varchar(100) NOT NULL
);
------------------------------------------------------
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsLogPJProductFeed' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.InsLogPJProductFeed
END
GO
CREATE PROCEDURE interfaces.InsLogPJProductFeed
	@PJProductFeedId bigint,
	@ListadoProductFeed interfaces.JetloreProductFeedType readonly
AS
BEGIN
	INSERT INTO interfaces.LogPJProductFeed(
		PJProductFeedId,
		Campaign,
		SalesCode,
		SKU,
		PromotionCode,
		Price,
		OriginalPrice,
		Currency,
		Title,
		ProductURL,
		ProductImgURL,
		ProductTaxonomy,
		Brand,
		IsRecommendable,
		ProductAttributes
	)
	SELECT
		@PJProductFeedId,
		Campaign,
		SalesCode,
		SKU,
		PromotionCode,
		Price,
		OriginalPrice,
		Currency,
		Title,
		ProductURL,
		ProductImgURL,
		ProductTaxonomy,
		Brand,
		IsRecommendable,
		ProductAttributes
	FROM @ListadoProductFeed;
END
------------------------------------------------------
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetJetloreHistoricalData' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.GetJetloreHistoricalData
END
GO
CREATE PROCEDURE interfaces.GetJetloreHistoricalData
	@OffsetRows INT,
	@NumberRows INT
AS
BEGIN
	DECLARE @hoy DATE = CAST(GETDATE() AS DATE);
	--DECLARE @hoy DATE = CAST('2016-06-25' AS DATE);	
	DECLARE @ayer DATE = DATEADD(day, -1, @hoy);
	
	SELECT
		Ca.Codigo AS Campania,
		P.FechaFacturado,
		Co.Codigo AS CodigoConsultora,
		PD.CUV,
		PC.CodigoProducto,
		PC.CodigoTipoOferta,
		PD.PrecioUnidad AS Precio,
		PD.Cantidad AS UnidadesVendidas,
		PD.MontoPagar,
		PC.Descripcion,
		SC.DescripcionCategoria AS Categoria,
		SSC.DescripcionSubCategoria AS SubCategoria,
		ST.DescripcionTipo AS Tipo,
		SST.DescripcionSubTipo AS SubTipo,
		PC.CodigoMarca AS Marca
	FROM ods.PedidoDetalle PD
	INNER JOIN ods.Pedido P WITH(NOLOCK) ON PD.PedidoID = P.PedidoID
	INNER JOIN ods.Campania Ca WITH(NOLOCK) ON PD.CampaniaID = Ca.CampaniaID
	INNER JOIN ods.Consultora Co WITH(NOLOCK) ON P.ConsultoraID = Co.ConsultoraID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PD.CampaniaID = PC.CampaniaID AND PD.CUV = PC.CUV
	INNER JOIN ods.SAP_PRODUCTO SP WITH(NOLOCK) ON PC.CodigoProducto = SP.CodigoSap
	INNER JOIN ods.SAP_CATEGORIA SC WITH(NOLOCK) ON SP.CodigoCategoria = SC.CodigoCategoria
	INNER JOIN ods.SAP_SUBCATEGORIA SSC WITH(NOLOCK) ON SP.CodigoSubCategoria = SSC.CodigoSubCategoria
	INNER JOIN ods.SAP_TIPO ST WITH(NOLOCK) ON SP.CodigoTipo = ST.CodigoTipo
	INNER JOIN ods.SAP_SUBTIPO SST WITH(NOLOCK) ON SP.CodigoSubTipo = SST.CodigoSubTipo
	WHERE 
		P.MontoFacturado IS NOT NULL AND PD.Estado = '4'
		AND
		CAST(P.FechaFacturado AS DATE) = @ayer
	ORDER BY PD.PedidoDetalleId
	OFFSET @OffsetRows ROWS 
	FETCH NEXT @NumberRows ROWS ONLY;
END
------------------------------------------------------
GO
IF OBJECT_ID('interfaces.LogPJHistoricalData') IS NOT NULL
	DROP TABLE interfaces.LogPJHistoricalData
GO
CREATE TABLE interfaces.LogPJHistoricalData(
	LogPJHistoricalDataId bigint IDENTITY(1,1) NOT NULL,
	PJProductFeedId bigint NOT NULL,
	Campaign varchar(6) NOT NULL,
	BillingDate varchar(10) NOT NULL,
	PartyCode varchar(15) NOT NULL,
	SalesCode varchar(5) NOT NULL,
	SKU varchar(15) NOT NULL,
	PromotionCode varchar(3) NOT NULL,
	Price decimal(17,2) NOT NULL,
	Currency varchar(3) NOT NULL,
	SaleUnits bigint NOT NULL,
	SaleDemandUnits bigint NOT NULL,
	SaleNetAmont decimal(17,2) NOT NULL,
	Title varchar(100) NOT NULL,
	ProductTaxonomy varchar(100) NOT NULL,
	Brand varchar(15) NOT NULL,
	ProductAttributes varchar(100) NOT NULL
	CONSTRAINT PK_LogPJHistoricalData PRIMARY KEY CLUSTERED 
	(
		LogPJHistoricalDataId ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY];
------------------------------------------------------
GO
IF TYPE_ID('interfaces.JetloreHistoricalDataType') IS NOT NULL
	DROP TYPE interfaces.JetloreHistoricalDataType
GO
CREATE TYPE interfaces.JetloreHistoricalDataType AS TABLE(
	Campaign varchar(6) NOT NULL,
	BillingDate varchar(10) NOT NULL,
	PartyCode varchar(15) NOT NULL,
	SalesCode varchar(5) NOT NULL,
	SKU varchar(15) NOT NULL,
	PromotionCode varchar(3) NOT NULL,
	Price decimal(17,2) NOT NULL,
	Currency varchar(3) NOT NULL,
	SaleUnits bigint NOT NULL,
	SaleDemandUnits bigint NOT NULL,
	SaleNetAmont decimal(17,2) NOT NULL,
	Title varchar(100) NOT NULL,
	ProductTaxonomy varchar(100) NOT NULL,
	Brand varchar(15) NOT NULL,
	ProductAttributes varchar(100) NOT NULL
);
------------------------------------------------------
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsLogPJHistoricalData' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.InsLogPJHistoricalData
END
GO
CREATE PROCEDURE interfaces.InsLogPJHistoricalData
	@PJHistoricalDataId bigint,
	@ListadoHistoricalData interfaces.JetloreHistoricalDataType readonly
AS
BEGIN
	INSERT INTO interfaces.LogPJHistoricalData(
		PJProductFeedId,
		Campaign,
		BillingDate,
		PartyCode,
		SalesCode,
		SKU,
		PromotionCode,
		Price,
		Currency,
		SaleUnits,
		SaleDemandUnits,
		SaleNetAmont,
		Title,
		ProductTaxonomy,
		Brand,
		ProductAttributes
	)
	SELECT
		@PJHistoricalDataId,
		Campaign,
		BillingDate,
		PartyCode,
		SalesCode,
		SKU,
		PromotionCode,
		Price,
		Currency,
		SaleUnits,
		SaleDemandUnits,
		SaleNetAmont,
		Title,
		ProductTaxonomy,
		Brand,
		ProductAttributes
	FROM @ListadoHistoricalData;
END
GO