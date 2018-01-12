USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSolicitudesPedidoDetalleByCampaniaByConsultoraId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetSolicitudesPedidoDetalleByCampaniaByConsultoraId
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultoraProgramaNueva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetConsultoraProgramaNueva
GO

ALTER PROCEDURE GetPedidoWebDetalleByCampania
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	EXEC DepurarTallaColorCUV @CampaniaID;
	EXEC DepurarTallaColorLiquidacion @CampaniaID;
	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT @NumeroPedido = consecutivonueva + 1
	FROM ods.Consultora
	WHERE ConsultoraID=@ConsultoraID
	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT
		@ProgramaNuevoActivado = COUNT(C.ConsultoraID),
		@CodigoPrograma = CP.CodigoPrograma
	FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
	WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma

	SELECT
		pwd.CampaniaID,
		pwd.PedidoID,
		pwd.PedidoDetalleID,
		isnull(pwd.MarcaID,0) as MarcaID,
		pwd.ConsultoraID,
		pwd.ClienteID,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.CUV,
		CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion)
		END DescripcionProd,
		c.Nombre,
		pwd.OfertaWeb,
		pc.IndicadorMontoMinimo,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(pwd.TipoPedido, 'W') TipoPedido,
		CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) 
			THEN (
				SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND E.CUV2 = pwd.CUV
			)
		END DescripcionOferta,
		M.Descripcion AS DescripcionLarga, --R2469
		'NO DISPONIBLE' AS Categoria, --R2469
		TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
		CASE WHEN TE.FlagNueva =1 THEN
		CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
		END
		ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
		PC.IndicadorOferta AS IndicadorOfertaCUV,  /*R20150701LR*/
		pwd.ObservacionPROL,
		PW.DescuentoProl
	FROM dbo.PedidoWebDetalle pwd
	INNER JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
	LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
	LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin  AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV)) AND EST.Activo=1 AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
	LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
	LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
	WHERE pwd.CampaniaID = @CampaniaID AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	ORDER BY pwd.PedidoDetalleID DESC;
END

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSolicitudesPedidoDetalleByCampaniaByConsultoraId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetSolicitudesPedidoDetalleByCampaniaByConsultoraId
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultoraProgramaNueva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetConsultoraProgramaNueva
GO

ALTER PROCEDURE GetPedidoWebDetalleByCampania
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	EXEC DepurarTallaColorCUV @CampaniaID;
	EXEC DepurarTallaColorLiquidacion @CampaniaID;
	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT @NumeroPedido = consecutivonueva + 1
	FROM ods.Consultora
	WHERE ConsultoraID=@ConsultoraID
	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT
		@ProgramaNuevoActivado = COUNT(C.ConsultoraID),
		@CodigoPrograma = CP.CodigoPrograma
	FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
	WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma

	SELECT
		pwd.CampaniaID,
		pwd.PedidoID,
		pwd.PedidoDetalleID,
		isnull(pwd.MarcaID,0) as MarcaID,
		pwd.ConsultoraID,
		pwd.ClienteID,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.CUV,
		CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion)
		END DescripcionProd,
		c.Nombre,
		pwd.OfertaWeb,
		pc.IndicadorMontoMinimo,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(pwd.TipoPedido, 'W') TipoPedido,
		CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) 
			THEN (
				SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND E.CUV2 = pwd.CUV
			)
		END DescripcionOferta,
		M.Descripcion AS DescripcionLarga, --R2469
		'NO DISPONIBLE' AS Categoria, --R2469
		TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
		CASE WHEN TE.FlagNueva =1 THEN
		CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
		END
		ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
		PC.IndicadorOferta AS IndicadorOfertaCUV,  /*R20150701LR*/
		pwd.ObservacionPROL,
		PW.DescuentoProl
	FROM dbo.PedidoWebDetalle pwd
	INNER JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
	LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
	LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin  AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV)) AND EST.Activo=1 AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
	LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
	LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
	WHERE pwd.CampaniaID = @CampaniaID AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	ORDER BY pwd.PedidoDetalleID DESC;
END

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSolicitudesPedidoDetalleByCampaniaByConsultoraId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetSolicitudesPedidoDetalleByCampaniaByConsultoraId
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultoraProgramaNueva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetConsultoraProgramaNueva
GO

ALTER PROCEDURE GetPedidoWebDetalleByCampania
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	EXEC DepurarTallaColorCUV @CampaniaID;
	EXEC DepurarTallaColorLiquidacion @CampaniaID;
	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT @NumeroPedido = consecutivonueva + 1
	FROM ods.Consultora
	WHERE ConsultoraID=@ConsultoraID
	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT
		@ProgramaNuevoActivado = COUNT(C.ConsultoraID),
		@CodigoPrograma = CP.CodigoPrograma
	FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
	WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma

	SELECT
		pwd.CampaniaID,
		pwd.PedidoID,
		pwd.PedidoDetalleID,
		isnull(pwd.MarcaID,0) as MarcaID,
		pwd.ConsultoraID,
		pwd.ClienteID,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.CUV,
		CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion)
		END DescripcionProd,
		c.Nombre,
		pwd.OfertaWeb,
		pc.IndicadorMontoMinimo,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(pwd.TipoPedido, 'W') TipoPedido,
		CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) 
			THEN (
				SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND E.CUV2 = pwd.CUV
			)
		END DescripcionOferta,
		M.Descripcion AS DescripcionLarga, --R2469
		'NO DISPONIBLE' AS Categoria, --R2469
		TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
		CASE WHEN TE.FlagNueva =1 THEN
		CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
		END
		ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
		PC.IndicadorOferta AS IndicadorOfertaCUV,  /*R20150701LR*/
		pwd.ObservacionPROL,
		PW.DescuentoProl
	FROM dbo.PedidoWebDetalle pwd
	INNER JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
	LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
	LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin  AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV)) AND EST.Activo=1 AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
	LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
	LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
	WHERE pwd.CampaniaID = @CampaniaID AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	ORDER BY pwd.PedidoDetalleID DESC;
END

GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSolicitudesPedidoDetalleByCampaniaByConsultoraId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetSolicitudesPedidoDetalleByCampaniaByConsultoraId
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultoraProgramaNueva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetConsultoraProgramaNueva
GO

ALTER PROCEDURE GetPedidoWebDetalleByCampania
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	EXEC DepurarTallaColorCUV @CampaniaID;
	EXEC DepurarTallaColorLiquidacion @CampaniaID;
	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT @NumeroPedido = consecutivonueva + 1
	FROM ods.Consultora
	WHERE ConsultoraID=@ConsultoraID
	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT
		@ProgramaNuevoActivado = COUNT(C.ConsultoraID),
		@CodigoPrograma = CP.CodigoPrograma
	FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
	WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma

	SELECT
		pwd.CampaniaID,
		pwd.PedidoID,
		pwd.PedidoDetalleID,
		isnull(pwd.MarcaID,0) as MarcaID,
		pwd.ConsultoraID,
		pwd.ClienteID,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.CUV,
		CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion)
		END DescripcionProd,
		c.Nombre,
		pwd.OfertaWeb,
		pc.IndicadorMontoMinimo,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(pwd.TipoPedido, 'W') TipoPedido,
		CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) 
			THEN (
				SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND E.CUV2 = pwd.CUV
			)
		END DescripcionOferta,
		M.Descripcion AS DescripcionLarga, --R2469
		'NO DISPONIBLE' AS Categoria, --R2469
		TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
		CASE WHEN TE.FlagNueva =1 THEN
		CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
		END
		ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
		PC.IndicadorOferta AS IndicadorOfertaCUV,  /*R20150701LR*/
		pwd.ObservacionPROL,
		PW.DescuentoProl
	FROM dbo.PedidoWebDetalle pwd
	INNER JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
	LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
	LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin  AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV)) AND EST.Activo=1 AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
	LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
	LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
	WHERE pwd.CampaniaID = @CampaniaID AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	ORDER BY pwd.PedidoDetalleID DESC;
END

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSolicitudesPedidoDetalleByCampaniaByConsultoraId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetSolicitudesPedidoDetalleByCampaniaByConsultoraId
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultoraProgramaNueva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetConsultoraProgramaNueva
GO

ALTER PROCEDURE GetPedidoWebDetalleByCampania
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	EXEC DepurarTallaColorCUV @CampaniaID;
	EXEC DepurarTallaColorLiquidacion @CampaniaID;
	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT @NumeroPedido = consecutivonueva + 1
	FROM ods.Consultora
	WHERE ConsultoraID=@ConsultoraID
	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT
		@ProgramaNuevoActivado = COUNT(C.ConsultoraID),
		@CodigoPrograma = CP.CodigoPrograma
	FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
	WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma

	SELECT
		pwd.CampaniaID,
		pwd.PedidoID,
		pwd.PedidoDetalleID,
		isnull(pwd.MarcaID,0) as MarcaID,
		pwd.ConsultoraID,
		pwd.ClienteID,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.CUV,
		CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion)
		END DescripcionProd,
		c.Nombre,
		pwd.OfertaWeb,
		pc.IndicadorMontoMinimo,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(pwd.TipoPedido, 'W') TipoPedido,
		CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) 
			THEN (
				SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND E.CUV2 = pwd.CUV
			)
		END DescripcionOferta,
		M.Descripcion AS DescripcionLarga, --R2469
		'NO DISPONIBLE' AS Categoria, --R2469
		TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
		CASE WHEN TE.FlagNueva =1 THEN
		CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
		END
		ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
		PC.IndicadorOferta AS IndicadorOfertaCUV,  /*R20150701LR*/
		pwd.ObservacionPROL,
		PW.DescuentoProl
	FROM dbo.PedidoWebDetalle pwd
	INNER JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
	LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
	LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin  AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV)) AND EST.Activo=1 AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
	LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
	LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
	WHERE pwd.CampaniaID = @CampaniaID AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	ORDER BY pwd.PedidoDetalleID DESC;
END

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSolicitudesPedidoDetalleByCampaniaByConsultoraId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetSolicitudesPedidoDetalleByCampaniaByConsultoraId
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultoraProgramaNueva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetConsultoraProgramaNueva
GO

ALTER PROCEDURE GetPedidoWebDetalleByCampania
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	EXEC DepurarTallaColorCUV @CampaniaID;
	EXEC DepurarTallaColorLiquidacion @CampaniaID;
	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT @NumeroPedido = consecutivonueva + 1
	FROM ods.Consultora
	WHERE ConsultoraID=@ConsultoraID
	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT
		@ProgramaNuevoActivado = COUNT(C.ConsultoraID),
		@CodigoPrograma = CP.CodigoPrograma
	FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
	WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma

	SELECT
		pwd.CampaniaID,
		pwd.PedidoID,
		pwd.PedidoDetalleID,
		isnull(pwd.MarcaID,0) as MarcaID,
		pwd.ConsultoraID,
		pwd.ClienteID,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.CUV,
		CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion)
		END DescripcionProd,
		c.Nombre,
		pwd.OfertaWeb,
		pc.IndicadorMontoMinimo,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(pwd.TipoPedido, 'W') TipoPedido,
		CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) 
			THEN (
				SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND E.CUV2 = pwd.CUV
			)
		END DescripcionOferta,
		M.Descripcion AS DescripcionLarga, --R2469
		'NO DISPONIBLE' AS Categoria, --R2469
		TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
		CASE WHEN TE.FlagNueva =1 THEN
		CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
		END
		ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
		PC.IndicadorOferta AS IndicadorOfertaCUV,  /*R20150701LR*/
		pwd.ObservacionPROL,
		PW.DescuentoProl
	FROM dbo.PedidoWebDetalle pwd
	INNER JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
	LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
	LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin  AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV)) AND EST.Activo=1 AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
	LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
	LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
	WHERE pwd.CampaniaID = @CampaniaID AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	ORDER BY pwd.PedidoDetalleID DESC;
END

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSolicitudesPedidoDetalleByCampaniaByConsultoraId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetSolicitudesPedidoDetalleByCampaniaByConsultoraId
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultoraProgramaNueva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetConsultoraProgramaNueva
GO

ALTER PROCEDURE GetPedidoWebDetalleByCampania
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	EXEC DepurarTallaColorCUV @CampaniaID;
	EXEC DepurarTallaColorLiquidacion @CampaniaID;
	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT @NumeroPedido = consecutivonueva + 1
	FROM ods.Consultora
	WHERE ConsultoraID=@ConsultoraID
	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT
		@ProgramaNuevoActivado = COUNT(C.ConsultoraID),
		@CodigoPrograma = CP.CodigoPrograma
	FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
	WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma

	SELECT
		pwd.CampaniaID,
		pwd.PedidoID,
		pwd.PedidoDetalleID,
		isnull(pwd.MarcaID,0) as MarcaID,
		pwd.ConsultoraID,
		pwd.ClienteID,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.CUV,
		CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion)
		END DescripcionProd,
		c.Nombre,
		pwd.OfertaWeb,
		pc.IndicadorMontoMinimo,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(pwd.TipoPedido, 'W') TipoPedido,
		CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) 
			THEN (
				SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND E.CUV2 = pwd.CUV
			)
		END DescripcionOferta,
		M.Descripcion AS DescripcionLarga, --R2469
		'NO DISPONIBLE' AS Categoria, --R2469
		TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
		CASE WHEN TE.FlagNueva =1 THEN
		CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
		END
		ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
		PC.IndicadorOferta AS IndicadorOfertaCUV,  /*R20150701LR*/
		pwd.ObservacionPROL,
		PW.DescuentoProl
	FROM dbo.PedidoWebDetalle pwd
	INNER JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
	LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
	LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin  AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV)) AND EST.Activo=1 AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
	LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
	LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
	WHERE pwd.CampaniaID = @CampaniaID AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	ORDER BY pwd.PedidoDetalleID DESC;
END

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSolicitudesPedidoDetalleByCampaniaByConsultoraId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetSolicitudesPedidoDetalleByCampaniaByConsultoraId
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultoraProgramaNueva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetConsultoraProgramaNueva
GO

ALTER PROCEDURE GetPedidoWebDetalleByCampania
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	EXEC DepurarTallaColorCUV @CampaniaID;
	EXEC DepurarTallaColorLiquidacion @CampaniaID;
	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT @NumeroPedido = consecutivonueva + 1
	FROM ods.Consultora
	WHERE ConsultoraID=@ConsultoraID
	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT
		@ProgramaNuevoActivado = COUNT(C.ConsultoraID),
		@CodigoPrograma = CP.CodigoPrograma
	FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
	WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma

	SELECT
		pwd.CampaniaID,
		pwd.PedidoID,
		pwd.PedidoDetalleID,
		isnull(pwd.MarcaID,0) as MarcaID,
		pwd.ConsultoraID,
		pwd.ClienteID,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.CUV,
		CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion)
		END DescripcionProd,
		c.Nombre,
		pwd.OfertaWeb,
		pc.IndicadorMontoMinimo,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(pwd.TipoPedido, 'W') TipoPedido,
		CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) 
			THEN (
				SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND E.CUV2 = pwd.CUV
			)
		END DescripcionOferta,
		M.Descripcion AS DescripcionLarga, --R2469
		'NO DISPONIBLE' AS Categoria, --R2469
		TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
		CASE WHEN TE.FlagNueva =1 THEN
		CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
		END
		ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
		PC.IndicadorOferta AS IndicadorOfertaCUV,  /*R20150701LR*/
		pwd.ObservacionPROL,
		PW.DescuentoProl
	FROM dbo.PedidoWebDetalle pwd
	INNER JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
	LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
	LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin  AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV)) AND EST.Activo=1 AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
	LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
	LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
	WHERE pwd.CampaniaID = @CampaniaID AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	ORDER BY pwd.PedidoDetalleID DESC;
END

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSolicitudesPedidoDetalleByCampaniaByConsultoraId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetSolicitudesPedidoDetalleByCampaniaByConsultoraId
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultoraProgramaNueva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetConsultoraProgramaNueva
GO

ALTER PROCEDURE GetPedidoWebDetalleByCampania
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	EXEC DepurarTallaColorCUV @CampaniaID;
	EXEC DepurarTallaColorLiquidacion @CampaniaID;
	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT @NumeroPedido = consecutivonueva + 1
	FROM ods.Consultora
	WHERE ConsultoraID=@ConsultoraID
	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT
		@ProgramaNuevoActivado = COUNT(C.ConsultoraID),
		@CodigoPrograma = CP.CodigoPrograma
	FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
	WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma

	SELECT
		pwd.CampaniaID,
		pwd.PedidoID,
		pwd.PedidoDetalleID,
		isnull(pwd.MarcaID,0) as MarcaID,
		pwd.ConsultoraID,
		pwd.ClienteID,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.CUV,
		CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion)
		END DescripcionProd,
		c.Nombre,
		pwd.OfertaWeb,
		pc.IndicadorMontoMinimo,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(pwd.TipoPedido, 'W') TipoPedido,
		CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) 
			THEN (
				SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND E.CUV2 = pwd.CUV
			)
		END DescripcionOferta,
		M.Descripcion AS DescripcionLarga, --R2469
		'NO DISPONIBLE' AS Categoria, --R2469
		TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
		CASE WHEN TE.FlagNueva =1 THEN
		CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
		END
		ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
		PC.IndicadorOferta AS IndicadorOfertaCUV,  /*R20150701LR*/
		pwd.ObservacionPROL,
		PW.DescuentoProl
	FROM dbo.PedidoWebDetalle pwd
	INNER JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
	LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
	LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin  AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV)) AND EST.Activo=1 AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
	LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
	LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
	WHERE pwd.CampaniaID = @CampaniaID AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	ORDER BY pwd.PedidoDetalleID DESC;
END

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSolicitudesPedidoDetalleByCampaniaByConsultoraId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetSolicitudesPedidoDetalleByCampaniaByConsultoraId
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultoraProgramaNueva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetConsultoraProgramaNueva
GO

ALTER PROCEDURE GetPedidoWebDetalleByCampania
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	EXEC DepurarTallaColorCUV @CampaniaID;
	EXEC DepurarTallaColorLiquidacion @CampaniaID;
	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT @NumeroPedido = consecutivonueva + 1
	FROM ods.Consultora
	WHERE ConsultoraID=@ConsultoraID
	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT
		@ProgramaNuevoActivado = COUNT(C.ConsultoraID),
		@CodigoPrograma = CP.CodigoPrograma
	FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
	WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma

	SELECT
		pwd.CampaniaID,
		pwd.PedidoID,
		pwd.PedidoDetalleID,
		isnull(pwd.MarcaID,0) as MarcaID,
		pwd.ConsultoraID,
		pwd.ClienteID,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.CUV,
		CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion)
		END DescripcionProd,
		c.Nombre,
		pwd.OfertaWeb,
		pc.IndicadorMontoMinimo,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(pwd.TipoPedido, 'W') TipoPedido,
		CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) 
			THEN (
				SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND E.CUV2 = pwd.CUV
			)
		END DescripcionOferta,
		M.Descripcion AS DescripcionLarga, --R2469
		'NO DISPONIBLE' AS Categoria, --R2469
		TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
		CASE WHEN TE.FlagNueva =1 THEN
		CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
		END
		ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
		PC.IndicadorOferta AS IndicadorOfertaCUV,  /*R20150701LR*/
		pwd.ObservacionPROL,
		PW.DescuentoProl
	FROM dbo.PedidoWebDetalle pwd
	INNER JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
	LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
	LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin  AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV)) AND EST.Activo=1 AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
	LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
	LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
	WHERE pwd.CampaniaID = @CampaniaID AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	ORDER BY pwd.PedidoDetalleID DESC;
END

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSolicitudesPedidoDetalleByCampaniaByConsultoraId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetSolicitudesPedidoDetalleByCampaniaByConsultoraId
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultoraProgramaNueva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetConsultoraProgramaNueva
GO

ALTER PROCEDURE GetPedidoWebDetalleByCampania
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	EXEC DepurarTallaColorCUV @CampaniaID;
	EXEC DepurarTallaColorLiquidacion @CampaniaID;
	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT @NumeroPedido = consecutivonueva + 1
	FROM ods.Consultora
	WHERE ConsultoraID=@ConsultoraID
	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT
		@ProgramaNuevoActivado = COUNT(C.ConsultoraID),
		@CodigoPrograma = CP.CodigoPrograma
	FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
	WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma

	SELECT
		pwd.CampaniaID,
		pwd.PedidoID,
		pwd.PedidoDetalleID,
		isnull(pwd.MarcaID,0) as MarcaID,
		pwd.ConsultoraID,
		pwd.ClienteID,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.CUV,
		CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion)
		END DescripcionProd,
		c.Nombre,
		pwd.OfertaWeb,
		pc.IndicadorMontoMinimo,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(pwd.TipoPedido, 'W') TipoPedido,
		CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) 
			THEN (
				SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND E.CUV2 = pwd.CUV
			)
		END DescripcionOferta,
		M.Descripcion AS DescripcionLarga, --R2469
		'NO DISPONIBLE' AS Categoria, --R2469
		TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
		CASE WHEN TE.FlagNueva =1 THEN
		CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
		END
		ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
		PC.IndicadorOferta AS IndicadorOfertaCUV,  /*R20150701LR*/
		pwd.ObservacionPROL,
		PW.DescuentoProl
	FROM dbo.PedidoWebDetalle pwd
	INNER JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
	LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
	LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin  AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV)) AND EST.Activo=1 AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
	LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
	LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
	WHERE pwd.CampaniaID = @CampaniaID AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	ORDER BY pwd.PedidoDetalleID DESC;
END

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSolicitudesPedidoDetalleByCampaniaByConsultoraId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetSolicitudesPedidoDetalleByCampaniaByConsultoraId
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultoraProgramaNueva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetConsultoraProgramaNueva
GO

ALTER PROCEDURE GetPedidoWebDetalleByCampania
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	EXEC DepurarTallaColorCUV @CampaniaID;
	EXEC DepurarTallaColorLiquidacion @CampaniaID;
	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT @NumeroPedido = consecutivonueva + 1
	FROM ods.Consultora
	WHERE ConsultoraID=@ConsultoraID
	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT
		@ProgramaNuevoActivado = COUNT(C.ConsultoraID),
		@CodigoPrograma = CP.CodigoPrograma
	FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
	WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma

	SELECT
		pwd.CampaniaID,
		pwd.PedidoID,
		pwd.PedidoDetalleID,
		isnull(pwd.MarcaID,0) as MarcaID,
		pwd.ConsultoraID,
		pwd.ClienteID,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.CUV,
		CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion)
		END DescripcionProd,
		c.Nombre,
		pwd.OfertaWeb,
		pc.IndicadorMontoMinimo,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(pwd.TipoPedido, 'W') TipoPedido,
		CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) 
			THEN (
				SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND E.CUV2 = pwd.CUV
			)
		END DescripcionOferta,
		M.Descripcion AS DescripcionLarga, --R2469
		'NO DISPONIBLE' AS Categoria, --R2469
		TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
		CASE WHEN TE.FlagNueva =1 THEN
		CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
		END
		ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
		PC.IndicadorOferta AS IndicadorOfertaCUV,  /*R20150701LR*/
		pwd.ObservacionPROL,
		PW.DescuentoProl
	FROM dbo.PedidoWebDetalle pwd
	INNER JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
	LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
	LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin  AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV)) AND EST.Activo=1 AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
	LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
	LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
	WHERE pwd.CampaniaID = @CampaniaID AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	ORDER BY pwd.PedidoDetalleID DESC;
END

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSolicitudesPedidoDetalleByCampaniaByConsultoraId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetSolicitudesPedidoDetalleByCampaniaByConsultoraId
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultoraProgramaNueva]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetConsultoraProgramaNueva
GO

ALTER PROCEDURE GetPedidoWebDetalleByCampania
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	EXEC DepurarTallaColorCUV @CampaniaID;
	EXEC DepurarTallaColorLiquidacion @CampaniaID;
	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT @NumeroPedido = consecutivonueva + 1
	FROM ods.Consultora
	WHERE ConsultoraID=@ConsultoraID
	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT
		@ProgramaNuevoActivado = COUNT(C.ConsultoraID),
		@CodigoPrograma = CP.CodigoPrograma
	FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
	WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma

	SELECT
		pwd.CampaniaID,
		pwd.PedidoID,
		pwd.PedidoDetalleID,
		isnull(pwd.MarcaID,0) as MarcaID,
		pwd.ConsultoraID,
		pwd.ClienteID,
		pwd.Cantidad,
		pwd.PrecioUnidad,
		pwd.ImporteTotal,
		pwd.CUV,
		CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion)
		END DescripcionProd,
		c.Nombre,
		pwd.OfertaWeb,
		pc.IndicadorMontoMinimo,
		ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(pwd.TipoPedido, 'W') TipoPedido,
		CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) 
			THEN (
				SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
				INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
				INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
				INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
				WHERE TE.FLAGACTIVO = 1 AND O.CODIGOOFERTA = pc.codigotipooferta AND E.CUV2 = pwd.CUV
			)
		END DescripcionOferta,
		M.Descripcion AS DescripcionLarga, --R2469
		'NO DISPONIBLE' AS Categoria, --R2469
		TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
		CASE WHEN TE.FlagNueva =1 THEN
		CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
		END
		ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
		PC.IndicadorOferta AS IndicadorOfertaCUV,  /*R20150701LR*/
		pwd.ObservacionPROL,
		PW.DescuentoProl
	FROM dbo.PedidoWebDetalle pwd
	INNER JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID AND PWD.PedidoID = PW.PedidoID
	LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
	LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
	LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin  AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV)) AND EST.Activo=1 AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
	LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
	LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
	WHERE pwd.CampaniaID = @CampaniaID AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
	ORDER BY pwd.PedidoDetalleID DESC;
END

GO

