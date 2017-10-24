USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetPedidoWebDetalleByCampania_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByCampania_SB2
END
GO


CREATE PROCEDURE [dbo].[GetPedidoWebDetalleByCampania_SB2]
	@CampaniaID		INT,
	@ConsultoraID	BIGINT,
  	@EsOpt int = 0
AS
BEGIN
	SET NOCOUNT ON

	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID
	EXEC DepurarTallaColorLiquidacion @CampaniaID

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	/* Consultora Online */
	DECLARE @SolicitudClienteDetalle TABLE (
		PedidoWebID			INT,
		PedidoWebDetalleID	INT
	)

	INSERT INTO @SolicitudClienteDetalle
	SELECT DISTINCT d.PedidoWebID, d.PedidoWebDetalleID
	FROM	dbo.SolicitudCliente c WITH (NOLOCK)
	INNER JOIN SolicitudClienteDetalle d WITH (NOLOCK) ON c.SolicitudClienteID = d.SolicitudClienteID
	WHERE	LTRIM(RTRIM(c.Estado)) = 'A'
			AND c.Campania = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND ISNULL(d.PedidoWebID,0) <> 0
			AND ISNULL(d.PedidoWebDetalleID,0) <> 0
	/* Consultora Online */

	declare @idTipoEstra int = 0
	
	if	@EsOpt <> 1 and @EsOpt <> 2
		set @idTipoEstra = 0
	else
	begin
		select @idTipoEstra = TEE.TipoEstrategiaID 
		from TipoEstrategia TEE WITH (NOLOCK) 
		where (@EsOpt = 1 AND TEE.Codigo = '007') or (@EsOpt = 2 and TEE.Codigo = '001') 
	end
		
	set @idTipoEstra = isnull(@idTipoEstra, 0)

	SELECT	pwd.CampaniaID,
			pwd.PedidoID,
			pwd.PedidoDetalleID,
			ISNULL(pwd.MarcaID,0) AS MarcaID,
			pwd.ConsultoraID,
			pwd.ClienteID,
			pwd.OrdenPedidoWD,
			pwd.Cantidad,
			pwd.PrecioUnidad,
			pwd.ImporteTotal,
			pwd.CUV,
			pwd.EsKitNueva,
			CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion) END DescripcionProd,
			c.Nombre,
			pwd.OfertaWeb,
			pc.IndicadorMontoMinimo,
			ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
			ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
			ISNULL(pwd.TipoPedido, 'W') TipoPedido,
			CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) THEN
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	OFERTA O WITH (NOLOCK)
						INNER JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON O.OfertaID = TEO.OfertaID
						INNER JOIN TIPOESTRATEGIA TE WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
						INNER JOIN TallaColorCUV T WITH (NOLOCK) ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE	TE.FLAGACTIVO = 1
						AND O.CODIGOOFERTA = pc.codigotipooferta
						AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	TIPOESTRATEGIA TE WITH (NOLOCK)
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = E.TIPOESTRATEGIAID AND E.Activo = 1
						LEFT JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						LEFT JOIN OFERTA O WITH (NOLOCK) ON TEO.OFERTAID = O.OFERTAID AND O.CODIGOOFERTA = pc.CodigoTipoOferta
				WHERE	(E.CampaniaID = pwd.CampaniaID OR pwd.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END)
						AND TE.FlagActivo = 1
						AND E.CUV2 = pwd.CUV
			)
			END DescripcionOferta,
			M.Descripcion AS DescripcionLarga, --R2469
			'NO DISPONIBLE' AS Categoria, --R2469
			TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
			CASE WHEN TE.FlagNueva = 1 THEN
			CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
			END
				ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
				PC.IndicadorOferta AS IndicadorOfertaCUV  /*R20150701LR*/
				, CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline
				, PW.DescuentoProl
				, PW.MontoEscala
				, PW.MontoAhorroCatalogo
				, PW.MontoAhorroRevista
				, PWD.OrigenPedidoWeb
				, PWD.EsBackOrder
				, PWD.AceptoBackOrder
				, PC.CodigoCatalago
				, TE.Codigo TipoEstrategiaCodigo
				, EST.EsOfertaIndependiente
		FROM	dbo.PedidoWebDetalle pwd WITH (NOLOCK)
				INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
				JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
				LEFT JOIN dbo.Cliente c WITH (NOLOCK) ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
				LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
				LEFT JOIN OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
				LEFT JOIN MatrizComercial mc WITH (NOLOCK) on pc.CodigoProducto = mc.CodigoSAP
				LEFT JOIN TallaColorLiquidacion tcl WITH (NOLOCK) on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
				LEFT JOIN Estrategia EST WITH (NOLOCK)
					ON PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
					AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
					AND EST.Activo=1
					AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
					AND (
						@EsOpt = 0
						or 
						EST.TipoEstrategiaID not in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') )
						or
						@idTipoEstra = 0
						or 
						(
							EST.TipoEstrategiaID in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') ) 
							and EST.TipoEstrategiaID = @idTipoEstra	
						)
					)
				LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
				LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
					ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
					AND (
						TE.CodigoPrograma = @CodigoPrograma 
						OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
					)
				LEFT JOIN Marca M WITH (NOLOCK) ON pc.MarcaId = M.MarcaId
				LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
		WHERE	pwd.CampaniaID = @CampaniaID
				AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
		ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
	
		SET NOCOUNT OFF
	END

GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetPedidoWebDetalleByCampania_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByCampania_SB2
END
GO


CREATE PROCEDURE [dbo].[GetPedidoWebDetalleByCampania_SB2]
	@CampaniaID		INT,
	@ConsultoraID	BIGINT,
  	@EsOpt int = 0
AS
BEGIN
	SET NOCOUNT ON

	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID
	EXEC DepurarTallaColorLiquidacion @CampaniaID

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	/* Consultora Online */
	DECLARE @SolicitudClienteDetalle TABLE (
		PedidoWebID			INT,
		PedidoWebDetalleID	INT
	)

	INSERT INTO @SolicitudClienteDetalle
	SELECT DISTINCT d.PedidoWebID, d.PedidoWebDetalleID
	FROM	dbo.SolicitudCliente c WITH (NOLOCK)
	INNER JOIN SolicitudClienteDetalle d WITH (NOLOCK) ON c.SolicitudClienteID = d.SolicitudClienteID
	WHERE	LTRIM(RTRIM(c.Estado)) = 'A'
			AND c.Campania = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND ISNULL(d.PedidoWebID,0) <> 0
			AND ISNULL(d.PedidoWebDetalleID,0) <> 0
	/* Consultora Online */

	declare @idTipoEstra int = 0
	
	if	@EsOpt <> 1 and @EsOpt <> 2
		set @idTipoEstra = 0
	else
	begin
		select @idTipoEstra = TEE.TipoEstrategiaID 
		from TipoEstrategia TEE WITH (NOLOCK) 
		where (@EsOpt = 1 AND TEE.Codigo = '007') or (@EsOpt = 2 and TEE.Codigo = '001') 
	end
		
	set @idTipoEstra = isnull(@idTipoEstra, 0)

	SELECT	pwd.CampaniaID,
			pwd.PedidoID,
			pwd.PedidoDetalleID,
			ISNULL(pwd.MarcaID,0) AS MarcaID,
			pwd.ConsultoraID,
			pwd.ClienteID,
			pwd.OrdenPedidoWD,
			pwd.Cantidad,
			pwd.PrecioUnidad,
			pwd.ImporteTotal,
			pwd.CUV,
			pwd.EsKitNueva,
			CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion) END DescripcionProd,
			c.Nombre,
			pwd.OfertaWeb,
			pc.IndicadorMontoMinimo,
			ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
			ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
			ISNULL(pwd.TipoPedido, 'W') TipoPedido,
			CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) THEN
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	OFERTA O WITH (NOLOCK)
						INNER JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON O.OfertaID = TEO.OfertaID
						INNER JOIN TIPOESTRATEGIA TE WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
						INNER JOIN TallaColorCUV T WITH (NOLOCK) ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE	TE.FLAGACTIVO = 1
						AND O.CODIGOOFERTA = pc.codigotipooferta
						AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	TIPOESTRATEGIA TE WITH (NOLOCK)
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = E.TIPOESTRATEGIAID AND E.Activo = 1
						LEFT JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						LEFT JOIN OFERTA O WITH (NOLOCK) ON TEO.OFERTAID = O.OFERTAID AND O.CODIGOOFERTA = pc.CodigoTipoOferta
				WHERE	(E.CampaniaID = pwd.CampaniaID OR pwd.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END)
						AND TE.FlagActivo = 1
						AND E.CUV2 = pwd.CUV
			)
			END DescripcionOferta,
			M.Descripcion AS DescripcionLarga, --R2469
			'NO DISPONIBLE' AS Categoria, --R2469
			TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
			CASE WHEN TE.FlagNueva = 1 THEN
			CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
			END
				ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
				PC.IndicadorOferta AS IndicadorOfertaCUV  /*R20150701LR*/
				, CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline
				, PW.DescuentoProl
				, PW.MontoEscala
				, PW.MontoAhorroCatalogo
				, PW.MontoAhorroRevista
				, PWD.OrigenPedidoWeb
				, PWD.EsBackOrder
				, PWD.AceptoBackOrder
				, PC.CodigoCatalago
				, TE.Codigo TipoEstrategiaCodigo
				, EST.EsOfertaIndependiente
		FROM	dbo.PedidoWebDetalle pwd WITH (NOLOCK)
				INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
				JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
				LEFT JOIN dbo.Cliente c WITH (NOLOCK) ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
				LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
				LEFT JOIN OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
				LEFT JOIN MatrizComercial mc WITH (NOLOCK) on pc.CodigoProducto = mc.CodigoSAP
				LEFT JOIN TallaColorLiquidacion tcl WITH (NOLOCK) on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
				LEFT JOIN Estrategia EST WITH (NOLOCK)
					ON PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
					AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
					AND EST.Activo=1
					AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
					AND (
						@EsOpt = 0
						or 
						EST.TipoEstrategiaID not in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') )
						or
						@idTipoEstra = 0
						or 
						(
							EST.TipoEstrategiaID in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') ) 
							and EST.TipoEstrategiaID = @idTipoEstra	
						)
					)
				LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
				LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
					ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
					AND (
						TE.CodigoPrograma = @CodigoPrograma 
						OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
					)
				LEFT JOIN Marca M WITH (NOLOCK) ON pc.MarcaId = M.MarcaId
				LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
		WHERE	pwd.CampaniaID = @CampaniaID
				AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
		ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
	
		SET NOCOUNT OFF
	END

GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetPedidoWebDetalleByCampania_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByCampania_SB2
END
GO


CREATE PROCEDURE [dbo].[GetPedidoWebDetalleByCampania_SB2]
	@CampaniaID		INT,
	@ConsultoraID	BIGINT,
  	@EsOpt int = 0
AS
BEGIN
	SET NOCOUNT ON

	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID
	EXEC DepurarTallaColorLiquidacion @CampaniaID

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	/* Consultora Online */
	DECLARE @SolicitudClienteDetalle TABLE (
		PedidoWebID			INT,
		PedidoWebDetalleID	INT
	)

	INSERT INTO @SolicitudClienteDetalle
	SELECT DISTINCT d.PedidoWebID, d.PedidoWebDetalleID
	FROM	dbo.SolicitudCliente c WITH (NOLOCK)
	INNER JOIN SolicitudClienteDetalle d WITH (NOLOCK) ON c.SolicitudClienteID = d.SolicitudClienteID
	WHERE	LTRIM(RTRIM(c.Estado)) = 'A'
			AND c.Campania = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND ISNULL(d.PedidoWebID,0) <> 0
			AND ISNULL(d.PedidoWebDetalleID,0) <> 0
	/* Consultora Online */

	declare @idTipoEstra int = 0
	
	if	@EsOpt <> 1 and @EsOpt <> 2
		set @idTipoEstra = 0
	else
	begin
		select @idTipoEstra = TEE.TipoEstrategiaID 
		from TipoEstrategia TEE WITH (NOLOCK) 
		where (@EsOpt = 1 AND TEE.Codigo = '007') or (@EsOpt = 2 and TEE.Codigo = '001') 
	end
		
	set @idTipoEstra = isnull(@idTipoEstra, 0)

	SELECT	pwd.CampaniaID,
			pwd.PedidoID,
			pwd.PedidoDetalleID,
			ISNULL(pwd.MarcaID,0) AS MarcaID,
			pwd.ConsultoraID,
			pwd.ClienteID,
			pwd.OrdenPedidoWD,
			pwd.Cantidad,
			pwd.PrecioUnidad,
			pwd.ImporteTotal,
			pwd.CUV,
			pwd.EsKitNueva,
			CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion) END DescripcionProd,
			c.Nombre,
			pwd.OfertaWeb,
			pc.IndicadorMontoMinimo,
			ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
			ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
			ISNULL(pwd.TipoPedido, 'W') TipoPedido,
			CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) THEN
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	OFERTA O WITH (NOLOCK)
						INNER JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON O.OfertaID = TEO.OfertaID
						INNER JOIN TIPOESTRATEGIA TE WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
						INNER JOIN TallaColorCUV T WITH (NOLOCK) ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE	TE.FLAGACTIVO = 1
						AND O.CODIGOOFERTA = pc.codigotipooferta
						AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	TIPOESTRATEGIA TE WITH (NOLOCK)
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = E.TIPOESTRATEGIAID AND E.Activo = 1
						LEFT JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						LEFT JOIN OFERTA O WITH (NOLOCK) ON TEO.OFERTAID = O.OFERTAID AND O.CODIGOOFERTA = pc.CodigoTipoOferta
				WHERE	(E.CampaniaID = pwd.CampaniaID OR pwd.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END)
						AND TE.FlagActivo = 1
						AND E.CUV2 = pwd.CUV
			)
			END DescripcionOferta,
			M.Descripcion AS DescripcionLarga, --R2469
			'NO DISPONIBLE' AS Categoria, --R2469
			TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
			CASE WHEN TE.FlagNueva = 1 THEN
			CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
			END
				ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
				PC.IndicadorOferta AS IndicadorOfertaCUV  /*R20150701LR*/
				, CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline
				, PW.DescuentoProl
				, PW.MontoEscala
				, PW.MontoAhorroCatalogo
				, PW.MontoAhorroRevista
				, PWD.OrigenPedidoWeb
				, PWD.EsBackOrder
				, PWD.AceptoBackOrder
				, PC.CodigoCatalago
				, TE.Codigo TipoEstrategiaCodigo
				, EST.EsOfertaIndependiente
		FROM	dbo.PedidoWebDetalle pwd WITH (NOLOCK)
				INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
				JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
				LEFT JOIN dbo.Cliente c WITH (NOLOCK) ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
				LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
				LEFT JOIN OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
				LEFT JOIN MatrizComercial mc WITH (NOLOCK) on pc.CodigoProducto = mc.CodigoSAP
				LEFT JOIN TallaColorLiquidacion tcl WITH (NOLOCK) on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
				LEFT JOIN Estrategia EST WITH (NOLOCK)
					ON PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
					AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
					AND EST.Activo=1
					AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
					AND (
						@EsOpt = 0
						or 
						EST.TipoEstrategiaID not in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') )
						or
						@idTipoEstra = 0
						or 
						(
							EST.TipoEstrategiaID in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') ) 
							and EST.TipoEstrategiaID = @idTipoEstra	
						)
					)
				LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
				LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
					ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
					AND (
						TE.CodigoPrograma = @CodigoPrograma 
						OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
					)
				LEFT JOIN Marca M WITH (NOLOCK) ON pc.MarcaId = M.MarcaId
				LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
		WHERE	pwd.CampaniaID = @CampaniaID
				AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
		ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
	
		SET NOCOUNT OFF
	END

GO

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetPedidoWebDetalleByCampania_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByCampania_SB2
END
GO


CREATE PROCEDURE [dbo].[GetPedidoWebDetalleByCampania_SB2]
	@CampaniaID		INT,
	@ConsultoraID	BIGINT,
  	@EsOpt int = 0
AS
BEGIN
	SET NOCOUNT ON

	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID
	EXEC DepurarTallaColorLiquidacion @CampaniaID

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	/* Consultora Online */
	DECLARE @SolicitudClienteDetalle TABLE (
		PedidoWebID			INT,
		PedidoWebDetalleID	INT
	)

	INSERT INTO @SolicitudClienteDetalle
	SELECT DISTINCT d.PedidoWebID, d.PedidoWebDetalleID
	FROM	dbo.SolicitudCliente c WITH (NOLOCK)
	INNER JOIN SolicitudClienteDetalle d WITH (NOLOCK) ON c.SolicitudClienteID = d.SolicitudClienteID
	WHERE	LTRIM(RTRIM(c.Estado)) = 'A'
			AND c.Campania = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND ISNULL(d.PedidoWebID,0) <> 0
			AND ISNULL(d.PedidoWebDetalleID,0) <> 0
	/* Consultora Online */

	declare @idTipoEstra int = 0
	
	if	@EsOpt <> 1 and @EsOpt <> 2
		set @idTipoEstra = 0
	else
	begin
		select @idTipoEstra = TEE.TipoEstrategiaID 
		from TipoEstrategia TEE WITH (NOLOCK) 
		where (@EsOpt = 1 AND TEE.Codigo = '007') or (@EsOpt = 2 and TEE.Codigo = '001') 
	end
		
	set @idTipoEstra = isnull(@idTipoEstra, 0)

	SELECT	pwd.CampaniaID,
			pwd.PedidoID,
			pwd.PedidoDetalleID,
			ISNULL(pwd.MarcaID,0) AS MarcaID,
			pwd.ConsultoraID,
			pwd.ClienteID,
			pwd.OrdenPedidoWD,
			pwd.Cantidad,
			pwd.PrecioUnidad,
			pwd.ImporteTotal,
			pwd.CUV,
			pwd.EsKitNueva,
			CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion) END DescripcionProd,
			c.Nombre,
			pwd.OfertaWeb,
			pc.IndicadorMontoMinimo,
			ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
			ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
			ISNULL(pwd.TipoPedido, 'W') TipoPedido,
			CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) THEN
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	OFERTA O WITH (NOLOCK)
						INNER JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON O.OfertaID = TEO.OfertaID
						INNER JOIN TIPOESTRATEGIA TE WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
						INNER JOIN TallaColorCUV T WITH (NOLOCK) ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE	TE.FLAGACTIVO = 1
						AND O.CODIGOOFERTA = pc.codigotipooferta
						AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	TIPOESTRATEGIA TE WITH (NOLOCK)
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = E.TIPOESTRATEGIAID AND E.Activo = 1
						LEFT JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						LEFT JOIN OFERTA O WITH (NOLOCK) ON TEO.OFERTAID = O.OFERTAID AND O.CODIGOOFERTA = pc.CodigoTipoOferta
				WHERE	(E.CampaniaID = pwd.CampaniaID OR pwd.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END)
						AND TE.FlagActivo = 1
						AND E.CUV2 = pwd.CUV
			)
			END DescripcionOferta,
			M.Descripcion AS DescripcionLarga, --R2469
			'NO DISPONIBLE' AS Categoria, --R2469
			TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
			CASE WHEN TE.FlagNueva = 1 THEN
			CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
			END
				ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
				PC.IndicadorOferta AS IndicadorOfertaCUV  /*R20150701LR*/
				, CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline
				, PW.DescuentoProl
				, PW.MontoEscala
				, PW.MontoAhorroCatalogo
				, PW.MontoAhorroRevista
				, PWD.OrigenPedidoWeb
				, PWD.EsBackOrder
				, PWD.AceptoBackOrder
				, PC.CodigoCatalago
				, TE.Codigo TipoEstrategiaCodigo
				, EST.EsOfertaIndependiente
		FROM	dbo.PedidoWebDetalle pwd WITH (NOLOCK)
				INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
				JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
				LEFT JOIN dbo.Cliente c WITH (NOLOCK) ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
				LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
				LEFT JOIN OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
				LEFT JOIN MatrizComercial mc WITH (NOLOCK) on pc.CodigoProducto = mc.CodigoSAP
				LEFT JOIN TallaColorLiquidacion tcl WITH (NOLOCK) on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
				LEFT JOIN Estrategia EST WITH (NOLOCK)
					ON PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
					AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
					AND EST.Activo=1
					AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
					AND (
						@EsOpt = 0
						or 
						EST.TipoEstrategiaID not in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') )
						or
						@idTipoEstra = 0
						or 
						(
							EST.TipoEstrategiaID in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') ) 
							and EST.TipoEstrategiaID = @idTipoEstra	
						)
					)
				LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
				LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
					ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
					AND (
						TE.CodigoPrograma = @CodigoPrograma 
						OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
					)
				LEFT JOIN Marca M WITH (NOLOCK) ON pc.MarcaId = M.MarcaId
				LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
		WHERE	pwd.CampaniaID = @CampaniaID
				AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
		ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
	
		SET NOCOUNT OFF
	END

GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetPedidoWebDetalleByCampania_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByCampania_SB2
END
GO


CREATE PROCEDURE [dbo].[GetPedidoWebDetalleByCampania_SB2]
	@CampaniaID		INT,
	@ConsultoraID	BIGINT,
  	@EsOpt int = 0
AS
BEGIN
	SET NOCOUNT ON

	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID
	EXEC DepurarTallaColorLiquidacion @CampaniaID

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	/* Consultora Online */
	DECLARE @SolicitudClienteDetalle TABLE (
		PedidoWebID			INT,
		PedidoWebDetalleID	INT
	)

	INSERT INTO @SolicitudClienteDetalle
	SELECT DISTINCT d.PedidoWebID, d.PedidoWebDetalleID
	FROM	dbo.SolicitudCliente c WITH (NOLOCK)
	INNER JOIN SolicitudClienteDetalle d WITH (NOLOCK) ON c.SolicitudClienteID = d.SolicitudClienteID
	WHERE	LTRIM(RTRIM(c.Estado)) = 'A'
			AND c.Campania = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND ISNULL(d.PedidoWebID,0) <> 0
			AND ISNULL(d.PedidoWebDetalleID,0) <> 0
	/* Consultora Online */

	declare @idTipoEstra int = 0
	
	if	@EsOpt <> 1 and @EsOpt <> 2
		set @idTipoEstra = 0
	else
	begin
		select @idTipoEstra = TEE.TipoEstrategiaID 
		from TipoEstrategia TEE WITH (NOLOCK) 
		where (@EsOpt = 1 AND TEE.Codigo = '007') or (@EsOpt = 2 and TEE.Codigo = '001') 
	end
		
	set @idTipoEstra = isnull(@idTipoEstra, 0)

	SELECT	pwd.CampaniaID,
			pwd.PedidoID,
			pwd.PedidoDetalleID,
			ISNULL(pwd.MarcaID,0) AS MarcaID,
			pwd.ConsultoraID,
			pwd.ClienteID,
			pwd.OrdenPedidoWD,
			pwd.Cantidad,
			pwd.PrecioUnidad,
			pwd.ImporteTotal,
			pwd.CUV,
			pwd.EsKitNueva,
			CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion) END DescripcionProd,
			c.Nombre,
			pwd.OfertaWeb,
			pc.IndicadorMontoMinimo,
			ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
			ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
			ISNULL(pwd.TipoPedido, 'W') TipoPedido,
			CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) THEN
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	OFERTA O WITH (NOLOCK)
						INNER JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON O.OfertaID = TEO.OfertaID
						INNER JOIN TIPOESTRATEGIA TE WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
						INNER JOIN TallaColorCUV T WITH (NOLOCK) ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE	TE.FLAGACTIVO = 1
						AND O.CODIGOOFERTA = pc.codigotipooferta
						AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	TIPOESTRATEGIA TE WITH (NOLOCK)
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = E.TIPOESTRATEGIAID AND E.Activo = 1
						LEFT JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						LEFT JOIN OFERTA O WITH (NOLOCK) ON TEO.OFERTAID = O.OFERTAID AND O.CODIGOOFERTA = pc.CodigoTipoOferta
				WHERE	(E.CampaniaID = pwd.CampaniaID OR pwd.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END)
						AND TE.FlagActivo = 1
						AND E.CUV2 = pwd.CUV
			)
			END DescripcionOferta,
			M.Descripcion AS DescripcionLarga, --R2469
			'NO DISPONIBLE' AS Categoria, --R2469
			TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
			CASE WHEN TE.FlagNueva = 1 THEN
			CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
			END
				ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
				PC.IndicadorOferta AS IndicadorOfertaCUV  /*R20150701LR*/
				, CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline
				, PW.DescuentoProl
				, PW.MontoEscala
				, PW.MontoAhorroCatalogo
				, PW.MontoAhorroRevista
				, PWD.OrigenPedidoWeb
				, PWD.EsBackOrder
				, PWD.AceptoBackOrder
				, PC.CodigoCatalago
				, TE.Codigo TipoEstrategiaCodigo
				, EST.EsOfertaIndependiente
		FROM	dbo.PedidoWebDetalle pwd WITH (NOLOCK)
				INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
				JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
				LEFT JOIN dbo.Cliente c WITH (NOLOCK) ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
				LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
				LEFT JOIN OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
				LEFT JOIN MatrizComercial mc WITH (NOLOCK) on pc.CodigoProducto = mc.CodigoSAP
				LEFT JOIN TallaColorLiquidacion tcl WITH (NOLOCK) on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
				LEFT JOIN Estrategia EST WITH (NOLOCK)
					ON PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
					AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
					AND EST.Activo=1
					AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
					AND (
						@EsOpt = 0
						or 
						EST.TipoEstrategiaID not in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') )
						or
						@idTipoEstra = 0
						or 
						(
							EST.TipoEstrategiaID in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') ) 
							and EST.TipoEstrategiaID = @idTipoEstra	
						)
					)
				LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
				LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
					ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
					AND (
						TE.CodigoPrograma = @CodigoPrograma 
						OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
					)
				LEFT JOIN Marca M WITH (NOLOCK) ON pc.MarcaId = M.MarcaId
				LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
		WHERE	pwd.CampaniaID = @CampaniaID
				AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
		ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
	
		SET NOCOUNT OFF
	END

GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetPedidoWebDetalleByCampania_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByCampania_SB2
END
GO


CREATE PROCEDURE [dbo].[GetPedidoWebDetalleByCampania_SB2]
	@CampaniaID		INT,
	@ConsultoraID	BIGINT,
  	@EsOpt int = 0
AS
BEGIN
	SET NOCOUNT ON

	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID
	EXEC DepurarTallaColorLiquidacion @CampaniaID

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	/* Consultora Online */
	DECLARE @SolicitudClienteDetalle TABLE (
		PedidoWebID			INT,
		PedidoWebDetalleID	INT
	)

	INSERT INTO @SolicitudClienteDetalle
	SELECT DISTINCT d.PedidoWebID, d.PedidoWebDetalleID
	FROM	dbo.SolicitudCliente c WITH (NOLOCK)
	INNER JOIN SolicitudClienteDetalle d WITH (NOLOCK) ON c.SolicitudClienteID = d.SolicitudClienteID
	WHERE	LTRIM(RTRIM(c.Estado)) = 'A'
			AND c.Campania = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND ISNULL(d.PedidoWebID,0) <> 0
			AND ISNULL(d.PedidoWebDetalleID,0) <> 0
	/* Consultora Online */

	declare @idTipoEstra int = 0
	
	if	@EsOpt <> 1 and @EsOpt <> 2
		set @idTipoEstra = 0
	else
	begin
		select @idTipoEstra = TEE.TipoEstrategiaID 
		from TipoEstrategia TEE WITH (NOLOCK) 
		where (@EsOpt = 1 AND TEE.Codigo = '007') or (@EsOpt = 2 and TEE.Codigo = '001') 
	end
		
	set @idTipoEstra = isnull(@idTipoEstra, 0)

	SELECT	pwd.CampaniaID,
			pwd.PedidoID,
			pwd.PedidoDetalleID,
			ISNULL(pwd.MarcaID,0) AS MarcaID,
			pwd.ConsultoraID,
			pwd.ClienteID,
			pwd.OrdenPedidoWD,
			pwd.Cantidad,
			pwd.PrecioUnidad,
			pwd.ImporteTotal,
			pwd.CUV,
			pwd.EsKitNueva,
			CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion) END DescripcionProd,
			c.Nombre,
			pwd.OfertaWeb,
			pc.IndicadorMontoMinimo,
			ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
			ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
			ISNULL(pwd.TipoPedido, 'W') TipoPedido,
			CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) THEN
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	OFERTA O WITH (NOLOCK)
						INNER JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON O.OfertaID = TEO.OfertaID
						INNER JOIN TIPOESTRATEGIA TE WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
						INNER JOIN TallaColorCUV T WITH (NOLOCK) ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE	TE.FLAGACTIVO = 1
						AND O.CODIGOOFERTA = pc.codigotipooferta
						AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	TIPOESTRATEGIA TE WITH (NOLOCK)
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = E.TIPOESTRATEGIAID AND E.Activo = 1
						LEFT JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						LEFT JOIN OFERTA O WITH (NOLOCK) ON TEO.OFERTAID = O.OFERTAID AND O.CODIGOOFERTA = pc.CodigoTipoOferta
				WHERE	(E.CampaniaID = pwd.CampaniaID OR pwd.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END)
						AND TE.FlagActivo = 1
						AND E.CUV2 = pwd.CUV
			)
			END DescripcionOferta,
			M.Descripcion AS DescripcionLarga, --R2469
			'NO DISPONIBLE' AS Categoria, --R2469
			TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
			CASE WHEN TE.FlagNueva = 1 THEN
			CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
			END
				ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
				PC.IndicadorOferta AS IndicadorOfertaCUV  /*R20150701LR*/
				, CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline
				, PW.DescuentoProl
				, PW.MontoEscala
				, PW.MontoAhorroCatalogo
				, PW.MontoAhorroRevista
				, PWD.OrigenPedidoWeb
				, PWD.EsBackOrder
				, PWD.AceptoBackOrder
				, PC.CodigoCatalago
				, TE.Codigo TipoEstrategiaCodigo
				, EST.EsOfertaIndependiente
		FROM	dbo.PedidoWebDetalle pwd WITH (NOLOCK)
				INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
				JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
				LEFT JOIN dbo.Cliente c WITH (NOLOCK) ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
				LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
				LEFT JOIN OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
				LEFT JOIN MatrizComercial mc WITH (NOLOCK) on pc.CodigoProducto = mc.CodigoSAP
				LEFT JOIN TallaColorLiquidacion tcl WITH (NOLOCK) on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
				LEFT JOIN Estrategia EST WITH (NOLOCK)
					ON PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
					AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
					AND EST.Activo=1
					AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
					AND (
						@EsOpt = 0
						or 
						EST.TipoEstrategiaID not in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') )
						or
						@idTipoEstra = 0
						or 
						(
							EST.TipoEstrategiaID in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') ) 
							and EST.TipoEstrategiaID = @idTipoEstra	
						)
					)
				LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
				LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
					ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
					AND (
						TE.CodigoPrograma = @CodigoPrograma 
						OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
					)
				LEFT JOIN Marca M WITH (NOLOCK) ON pc.MarcaId = M.MarcaId
				LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
		WHERE	pwd.CampaniaID = @CampaniaID
				AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
		ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
	
		SET NOCOUNT OFF
	END

GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetPedidoWebDetalleByCampania_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByCampania_SB2
END
GO


CREATE PROCEDURE [dbo].[GetPedidoWebDetalleByCampania_SB2]
	@CampaniaID		INT,
	@ConsultoraID	BIGINT,
  	@EsOpt int = 0
AS
BEGIN
	SET NOCOUNT ON

	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID
	EXEC DepurarTallaColorLiquidacion @CampaniaID

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	/* Consultora Online */
	DECLARE @SolicitudClienteDetalle TABLE (
		PedidoWebID			INT,
		PedidoWebDetalleID	INT
	)

	INSERT INTO @SolicitudClienteDetalle
	SELECT DISTINCT d.PedidoWebID, d.PedidoWebDetalleID
	FROM	dbo.SolicitudCliente c WITH (NOLOCK)
	INNER JOIN SolicitudClienteDetalle d WITH (NOLOCK) ON c.SolicitudClienteID = d.SolicitudClienteID
	WHERE	LTRIM(RTRIM(c.Estado)) = 'A'
			AND c.Campania = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND ISNULL(d.PedidoWebID,0) <> 0
			AND ISNULL(d.PedidoWebDetalleID,0) <> 0
	/* Consultora Online */

	declare @idTipoEstra int = 0
	
	if	@EsOpt <> 1 and @EsOpt <> 2
		set @idTipoEstra = 0
	else
	begin
		select @idTipoEstra = TEE.TipoEstrategiaID 
		from TipoEstrategia TEE WITH (NOLOCK) 
		where (@EsOpt = 1 AND TEE.Codigo = '007') or (@EsOpt = 2 and TEE.Codigo = '001') 
	end
		
	set @idTipoEstra = isnull(@idTipoEstra, 0)

	SELECT	pwd.CampaniaID,
			pwd.PedidoID,
			pwd.PedidoDetalleID,
			ISNULL(pwd.MarcaID,0) AS MarcaID,
			pwd.ConsultoraID,
			pwd.ClienteID,
			pwd.OrdenPedidoWD,
			pwd.Cantidad,
			pwd.PrecioUnidad,
			pwd.ImporteTotal,
			pwd.CUV,
			pwd.EsKitNueva,
			CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion) END DescripcionProd,
			c.Nombre,
			pwd.OfertaWeb,
			pc.IndicadorMontoMinimo,
			ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
			ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
			ISNULL(pwd.TipoPedido, 'W') TipoPedido,
			CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) THEN
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	OFERTA O WITH (NOLOCK)
						INNER JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON O.OfertaID = TEO.OfertaID
						INNER JOIN TIPOESTRATEGIA TE WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
						INNER JOIN TallaColorCUV T WITH (NOLOCK) ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE	TE.FLAGACTIVO = 1
						AND O.CODIGOOFERTA = pc.codigotipooferta
						AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	TIPOESTRATEGIA TE WITH (NOLOCK)
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = E.TIPOESTRATEGIAID AND E.Activo = 1
						LEFT JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						LEFT JOIN OFERTA O WITH (NOLOCK) ON TEO.OFERTAID = O.OFERTAID AND O.CODIGOOFERTA = pc.CodigoTipoOferta
				WHERE	(E.CampaniaID = pwd.CampaniaID OR pwd.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END)
						AND TE.FlagActivo = 1
						AND E.CUV2 = pwd.CUV
			)
			END DescripcionOferta,
			M.Descripcion AS DescripcionLarga, --R2469
			'NO DISPONIBLE' AS Categoria, --R2469
			TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
			CASE WHEN TE.FlagNueva = 1 THEN
			CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
			END
				ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
				PC.IndicadorOferta AS IndicadorOfertaCUV  /*R20150701LR*/
				, CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline
				, PW.DescuentoProl
				, PW.MontoEscala
				, PW.MontoAhorroCatalogo
				, PW.MontoAhorroRevista
				, PWD.OrigenPedidoWeb
				, PWD.EsBackOrder
				, PWD.AceptoBackOrder
				, PC.CodigoCatalago
				, TE.Codigo TipoEstrategiaCodigo
				, EST.EsOfertaIndependiente
		FROM	dbo.PedidoWebDetalle pwd WITH (NOLOCK)
				INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
				JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
				LEFT JOIN dbo.Cliente c WITH (NOLOCK) ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
				LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
				LEFT JOIN OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
				LEFT JOIN MatrizComercial mc WITH (NOLOCK) on pc.CodigoProducto = mc.CodigoSAP
				LEFT JOIN TallaColorLiquidacion tcl WITH (NOLOCK) on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
				LEFT JOIN Estrategia EST WITH (NOLOCK)
					ON PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
					AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
					AND EST.Activo=1
					AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
					AND (
						@EsOpt = 0
						or 
						EST.TipoEstrategiaID not in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') )
						or
						@idTipoEstra = 0
						or 
						(
							EST.TipoEstrategiaID in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') ) 
							and EST.TipoEstrategiaID = @idTipoEstra	
						)
					)
				LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
				LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
					ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
					AND (
						TE.CodigoPrograma = @CodigoPrograma 
						OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
					)
				LEFT JOIN Marca M WITH (NOLOCK) ON pc.MarcaId = M.MarcaId
				LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
		WHERE	pwd.CampaniaID = @CampaniaID
				AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
		ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
	
		SET NOCOUNT OFF
	END

GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetPedidoWebDetalleByCampania_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByCampania_SB2
END
GO


CREATE PROCEDURE [dbo].[GetPedidoWebDetalleByCampania_SB2]
	@CampaniaID		INT,
	@ConsultoraID	BIGINT,
  	@EsOpt int = 0
AS
BEGIN
	SET NOCOUNT ON

	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID
	EXEC DepurarTallaColorLiquidacion @CampaniaID

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	/* Consultora Online */
	DECLARE @SolicitudClienteDetalle TABLE (
		PedidoWebID			INT,
		PedidoWebDetalleID	INT
	)

	INSERT INTO @SolicitudClienteDetalle
	SELECT DISTINCT d.PedidoWebID, d.PedidoWebDetalleID
	FROM	dbo.SolicitudCliente c WITH (NOLOCK)
	INNER JOIN SolicitudClienteDetalle d WITH (NOLOCK) ON c.SolicitudClienteID = d.SolicitudClienteID
	WHERE	LTRIM(RTRIM(c.Estado)) = 'A'
			AND c.Campania = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND ISNULL(d.PedidoWebID,0) <> 0
			AND ISNULL(d.PedidoWebDetalleID,0) <> 0
	/* Consultora Online */

	declare @idTipoEstra int = 0
	
	if	@EsOpt <> 1 and @EsOpt <> 2
		set @idTipoEstra = 0
	else
	begin
		select @idTipoEstra = TEE.TipoEstrategiaID 
		from TipoEstrategia TEE WITH (NOLOCK) 
		where (@EsOpt = 1 AND TEE.Codigo = '007') or (@EsOpt = 2 and TEE.Codigo = '001') 
	end
		
	set @idTipoEstra = isnull(@idTipoEstra, 0)

	SELECT	pwd.CampaniaID,
			pwd.PedidoID,
			pwd.PedidoDetalleID,
			ISNULL(pwd.MarcaID,0) AS MarcaID,
			pwd.ConsultoraID,
			pwd.ClienteID,
			pwd.OrdenPedidoWD,
			pwd.Cantidad,
			pwd.PrecioUnidad,
			pwd.ImporteTotal,
			pwd.CUV,
			pwd.EsKitNueva,
			CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion) END DescripcionProd,
			c.Nombre,
			pwd.OfertaWeb,
			pc.IndicadorMontoMinimo,
			ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
			ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
			ISNULL(pwd.TipoPedido, 'W') TipoPedido,
			CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) THEN
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	OFERTA O WITH (NOLOCK)
						INNER JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON O.OfertaID = TEO.OfertaID
						INNER JOIN TIPOESTRATEGIA TE WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
						INNER JOIN TallaColorCUV T WITH (NOLOCK) ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE	TE.FLAGACTIVO = 1
						AND O.CODIGOOFERTA = pc.codigotipooferta
						AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	TIPOESTRATEGIA TE WITH (NOLOCK)
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = E.TIPOESTRATEGIAID AND E.Activo = 1
						LEFT JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						LEFT JOIN OFERTA O WITH (NOLOCK) ON TEO.OFERTAID = O.OFERTAID AND O.CODIGOOFERTA = pc.CodigoTipoOferta
				WHERE	(E.CampaniaID = pwd.CampaniaID OR pwd.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END)
						AND TE.FlagActivo = 1
						AND E.CUV2 = pwd.CUV
			)
			END DescripcionOferta,
			M.Descripcion AS DescripcionLarga, --R2469
			'NO DISPONIBLE' AS Categoria, --R2469
			TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
			CASE WHEN TE.FlagNueva = 1 THEN
			CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
			END
				ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
				PC.IndicadorOferta AS IndicadorOfertaCUV  /*R20150701LR*/
				, CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline
				, PW.DescuentoProl
				, PW.MontoEscala
				, PW.MontoAhorroCatalogo
				, PW.MontoAhorroRevista
				, PWD.OrigenPedidoWeb
				, PWD.EsBackOrder
				, PWD.AceptoBackOrder
				, PC.CodigoCatalago
				, TE.Codigo TipoEstrategiaCodigo
				, EST.EsOfertaIndependiente
		FROM	dbo.PedidoWebDetalle pwd WITH (NOLOCK)
				INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
				JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
				LEFT JOIN dbo.Cliente c WITH (NOLOCK) ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
				LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
				LEFT JOIN OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
				LEFT JOIN MatrizComercial mc WITH (NOLOCK) on pc.CodigoProducto = mc.CodigoSAP
				LEFT JOIN TallaColorLiquidacion tcl WITH (NOLOCK) on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
				LEFT JOIN Estrategia EST WITH (NOLOCK)
					ON PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
					AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
					AND EST.Activo=1
					AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
					AND (
						@EsOpt = 0
						or 
						EST.TipoEstrategiaID not in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') )
						or
						@idTipoEstra = 0
						or 
						(
							EST.TipoEstrategiaID in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') ) 
							and EST.TipoEstrategiaID = @idTipoEstra	
						)
					)
				LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
				LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
					ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
					AND (
						TE.CodigoPrograma = @CodigoPrograma 
						OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
					)
				LEFT JOIN Marca M WITH (NOLOCK) ON pc.MarcaId = M.MarcaId
				LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
		WHERE	pwd.CampaniaID = @CampaniaID
				AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
		ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
	
		SET NOCOUNT OFF
	END

GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetPedidoWebDetalleByCampania_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByCampania_SB2
END
GO


CREATE PROCEDURE [dbo].[GetPedidoWebDetalleByCampania_SB2]
	@CampaniaID		INT,
	@ConsultoraID	BIGINT,
  	@EsOpt int = 0
AS
BEGIN
	SET NOCOUNT ON

	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID
	EXEC DepurarTallaColorLiquidacion @CampaniaID

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	/* Consultora Online */
	DECLARE @SolicitudClienteDetalle TABLE (
		PedidoWebID			INT,
		PedidoWebDetalleID	INT
	)

	INSERT INTO @SolicitudClienteDetalle
	SELECT DISTINCT d.PedidoWebID, d.PedidoWebDetalleID
	FROM	dbo.SolicitudCliente c WITH (NOLOCK)
	INNER JOIN SolicitudClienteDetalle d WITH (NOLOCK) ON c.SolicitudClienteID = d.SolicitudClienteID
	WHERE	LTRIM(RTRIM(c.Estado)) = 'A'
			AND c.Campania = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND ISNULL(d.PedidoWebID,0) <> 0
			AND ISNULL(d.PedidoWebDetalleID,0) <> 0
	/* Consultora Online */

	declare @idTipoEstra int = 0
	
	if	@EsOpt <> 1 and @EsOpt <> 2
		set @idTipoEstra = 0
	else
	begin
		select @idTipoEstra = TEE.TipoEstrategiaID 
		from TipoEstrategia TEE WITH (NOLOCK) 
		where (@EsOpt = 1 AND TEE.Codigo = '007') or (@EsOpt = 2 and TEE.Codigo = '001') 
	end
		
	set @idTipoEstra = isnull(@idTipoEstra, 0)

	SELECT	pwd.CampaniaID,
			pwd.PedidoID,
			pwd.PedidoDetalleID,
			ISNULL(pwd.MarcaID,0) AS MarcaID,
			pwd.ConsultoraID,
			pwd.ClienteID,
			pwd.OrdenPedidoWD,
			pwd.Cantidad,
			pwd.PrecioUnidad,
			pwd.ImporteTotal,
			pwd.CUV,
			pwd.EsKitNueva,
			CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion) END DescripcionProd,
			c.Nombre,
			pwd.OfertaWeb,
			pc.IndicadorMontoMinimo,
			ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
			ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
			ISNULL(pwd.TipoPedido, 'W') TipoPedido,
			CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) THEN
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	OFERTA O WITH (NOLOCK)
						INNER JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON O.OfertaID = TEO.OfertaID
						INNER JOIN TIPOESTRATEGIA TE WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
						INNER JOIN TallaColorCUV T WITH (NOLOCK) ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE	TE.FLAGACTIVO = 1
						AND O.CODIGOOFERTA = pc.codigotipooferta
						AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	TIPOESTRATEGIA TE WITH (NOLOCK)
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = E.TIPOESTRATEGIAID AND E.Activo = 1
						LEFT JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						LEFT JOIN OFERTA O WITH (NOLOCK) ON TEO.OFERTAID = O.OFERTAID AND O.CODIGOOFERTA = pc.CodigoTipoOferta
				WHERE	(E.CampaniaID = pwd.CampaniaID OR pwd.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END)
						AND TE.FlagActivo = 1
						AND E.CUV2 = pwd.CUV
			)
			END DescripcionOferta,
			M.Descripcion AS DescripcionLarga, --R2469
			'NO DISPONIBLE' AS Categoria, --R2469
			TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
			CASE WHEN TE.FlagNueva = 1 THEN
			CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
			END
				ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
				PC.IndicadorOferta AS IndicadorOfertaCUV  /*R20150701LR*/
				, CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline
				, PW.DescuentoProl
				, PW.MontoEscala
				, PW.MontoAhorroCatalogo
				, PW.MontoAhorroRevista
				, PWD.OrigenPedidoWeb
				, PWD.EsBackOrder
				, PWD.AceptoBackOrder
				, PC.CodigoCatalago
				, TE.Codigo TipoEstrategiaCodigo
				, EST.EsOfertaIndependiente
		FROM	dbo.PedidoWebDetalle pwd WITH (NOLOCK)
				INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
				JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
				LEFT JOIN dbo.Cliente c WITH (NOLOCK) ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
				LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
				LEFT JOIN OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
				LEFT JOIN MatrizComercial mc WITH (NOLOCK) on pc.CodigoProducto = mc.CodigoSAP
				LEFT JOIN TallaColorLiquidacion tcl WITH (NOLOCK) on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
				LEFT JOIN Estrategia EST WITH (NOLOCK)
					ON PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
					AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
					AND EST.Activo=1
					AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
					AND (
						@EsOpt = 0
						or 
						EST.TipoEstrategiaID not in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') )
						or
						@idTipoEstra = 0
						or 
						(
							EST.TipoEstrategiaID in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') ) 
							and EST.TipoEstrategiaID = @idTipoEstra	
						)
					)
				LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
				LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
					ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
					AND (
						TE.CodigoPrograma = @CodigoPrograma 
						OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
					)
				LEFT JOIN Marca M WITH (NOLOCK) ON pc.MarcaId = M.MarcaId
				LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
		WHERE	pwd.CampaniaID = @CampaniaID
				AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
		ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
	
		SET NOCOUNT OFF
	END

GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetPedidoWebDetalleByCampania_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByCampania_SB2
END
GO


CREATE PROCEDURE [dbo].[GetPedidoWebDetalleByCampania_SB2]
	@CampaniaID		INT,
	@ConsultoraID	BIGINT,
  	@EsOpt int = 0
AS
BEGIN
	SET NOCOUNT ON

	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID
	EXEC DepurarTallaColorLiquidacion @CampaniaID

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	/* Consultora Online */
	DECLARE @SolicitudClienteDetalle TABLE (
		PedidoWebID			INT,
		PedidoWebDetalleID	INT
	)

	INSERT INTO @SolicitudClienteDetalle
	SELECT DISTINCT d.PedidoWebID, d.PedidoWebDetalleID
	FROM	dbo.SolicitudCliente c WITH (NOLOCK)
	INNER JOIN SolicitudClienteDetalle d WITH (NOLOCK) ON c.SolicitudClienteID = d.SolicitudClienteID
	WHERE	LTRIM(RTRIM(c.Estado)) = 'A'
			AND c.Campania = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND ISNULL(d.PedidoWebID,0) <> 0
			AND ISNULL(d.PedidoWebDetalleID,0) <> 0
	/* Consultora Online */

	declare @idTipoEstra int = 0
	
	if	@EsOpt <> 1 and @EsOpt <> 2
		set @idTipoEstra = 0
	else
	begin
		select @idTipoEstra = TEE.TipoEstrategiaID 
		from TipoEstrategia TEE WITH (NOLOCK) 
		where (@EsOpt = 1 AND TEE.Codigo = '007') or (@EsOpt = 2 and TEE.Codigo = '001') 
	end
		
	set @idTipoEstra = isnull(@idTipoEstra, 0)

	SELECT	pwd.CampaniaID,
			pwd.PedidoID,
			pwd.PedidoDetalleID,
			ISNULL(pwd.MarcaID,0) AS MarcaID,
			pwd.ConsultoraID,
			pwd.ClienteID,
			pwd.OrdenPedidoWD,
			pwd.Cantidad,
			pwd.PrecioUnidad,
			pwd.ImporteTotal,
			pwd.CUV,
			pwd.EsKitNueva,
			CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion) END DescripcionProd,
			c.Nombre,
			pwd.OfertaWeb,
			pc.IndicadorMontoMinimo,
			ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
			ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
			ISNULL(pwd.TipoPedido, 'W') TipoPedido,
			CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) THEN
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	OFERTA O WITH (NOLOCK)
						INNER JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON O.OfertaID = TEO.OfertaID
						INNER JOIN TIPOESTRATEGIA TE WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
						INNER JOIN TallaColorCUV T WITH (NOLOCK) ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE	TE.FLAGACTIVO = 1
						AND O.CODIGOOFERTA = pc.codigotipooferta
						AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	TIPOESTRATEGIA TE WITH (NOLOCK)
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = E.TIPOESTRATEGIAID AND E.Activo = 1
						LEFT JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						LEFT JOIN OFERTA O WITH (NOLOCK) ON TEO.OFERTAID = O.OFERTAID AND O.CODIGOOFERTA = pc.CodigoTipoOferta
				WHERE	(E.CampaniaID = pwd.CampaniaID OR pwd.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END)
						AND TE.FlagActivo = 1
						AND E.CUV2 = pwd.CUV
			)
			END DescripcionOferta,
			M.Descripcion AS DescripcionLarga, --R2469
			'NO DISPONIBLE' AS Categoria, --R2469
			TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
			CASE WHEN TE.FlagNueva = 1 THEN
			CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
			END
				ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
				PC.IndicadorOferta AS IndicadorOfertaCUV  /*R20150701LR*/
				, CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline
				, PW.DescuentoProl
				, PW.MontoEscala
				, PW.MontoAhorroCatalogo
				, PW.MontoAhorroRevista
				, PWD.OrigenPedidoWeb
				, PWD.EsBackOrder
				, PWD.AceptoBackOrder
				, PC.CodigoCatalago
				, TE.Codigo TipoEstrategiaCodigo
				, EST.EsOfertaIndependiente
		FROM	dbo.PedidoWebDetalle pwd WITH (NOLOCK)
				INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
				JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
				LEFT JOIN dbo.Cliente c WITH (NOLOCK) ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
				LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
				LEFT JOIN OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
				LEFT JOIN MatrizComercial mc WITH (NOLOCK) on pc.CodigoProducto = mc.CodigoSAP
				LEFT JOIN TallaColorLiquidacion tcl WITH (NOLOCK) on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
				LEFT JOIN Estrategia EST WITH (NOLOCK)
					ON PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
					AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
					AND EST.Activo=1
					AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
					AND (
						@EsOpt = 0
						or 
						EST.TipoEstrategiaID not in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') )
						or
						@idTipoEstra = 0
						or 
						(
							EST.TipoEstrategiaID in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') ) 
							and EST.TipoEstrategiaID = @idTipoEstra	
						)
					)
				LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
				LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
					ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
					AND (
						TE.CodigoPrograma = @CodigoPrograma 
						OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
					)
				LEFT JOIN Marca M WITH (NOLOCK) ON pc.MarcaId = M.MarcaId
				LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
		WHERE	pwd.CampaniaID = @CampaniaID
				AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
		ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
	
		SET NOCOUNT OFF
	END

GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetPedidoWebDetalleByCampania_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByCampania_SB2
END
GO


CREATE PROCEDURE [dbo].[GetPedidoWebDetalleByCampania_SB2]
	@CampaniaID		INT,
	@ConsultoraID	BIGINT,
  	@EsOpt int = 0
AS
BEGIN
	SET NOCOUNT ON

	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID
	EXEC DepurarTallaColorLiquidacion @CampaniaID

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	/* Consultora Online */
	DECLARE @SolicitudClienteDetalle TABLE (
		PedidoWebID			INT,
		PedidoWebDetalleID	INT
	)

	INSERT INTO @SolicitudClienteDetalle
	SELECT DISTINCT d.PedidoWebID, d.PedidoWebDetalleID
	FROM	dbo.SolicitudCliente c WITH (NOLOCK)
	INNER JOIN SolicitudClienteDetalle d WITH (NOLOCK) ON c.SolicitudClienteID = d.SolicitudClienteID
	WHERE	LTRIM(RTRIM(c.Estado)) = 'A'
			AND c.Campania = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND ISNULL(d.PedidoWebID,0) <> 0
			AND ISNULL(d.PedidoWebDetalleID,0) <> 0
	/* Consultora Online */

	declare @idTipoEstra int = 0
	
	if	@EsOpt <> 1 and @EsOpt <> 2
		set @idTipoEstra = 0
	else
	begin
		select @idTipoEstra = TEE.TipoEstrategiaID 
		from TipoEstrategia TEE WITH (NOLOCK) 
		where (@EsOpt = 1 AND TEE.Codigo = '007') or (@EsOpt = 2 and TEE.Codigo = '001') 
	end
		
	set @idTipoEstra = isnull(@idTipoEstra, 0)

	SELECT	pwd.CampaniaID,
			pwd.PedidoID,
			pwd.PedidoDetalleID,
			ISNULL(pwd.MarcaID,0) AS MarcaID,
			pwd.ConsultoraID,
			pwd.ClienteID,
			pwd.OrdenPedidoWD,
			pwd.Cantidad,
			pwd.PrecioUnidad,
			pwd.ImporteTotal,
			pwd.CUV,
			pwd.EsKitNueva,
			CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion) END DescripcionProd,
			c.Nombre,
			pwd.OfertaWeb,
			pc.IndicadorMontoMinimo,
			ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
			ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
			ISNULL(pwd.TipoPedido, 'W') TipoPedido,
			CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) THEN
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	OFERTA O WITH (NOLOCK)
						INNER JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON O.OfertaID = TEO.OfertaID
						INNER JOIN TIPOESTRATEGIA TE WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
						INNER JOIN TallaColorCUV T WITH (NOLOCK) ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE	TE.FLAGACTIVO = 1
						AND O.CODIGOOFERTA = pc.codigotipooferta
						AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	TIPOESTRATEGIA TE WITH (NOLOCK)
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = E.TIPOESTRATEGIAID AND E.Activo = 1
						LEFT JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						LEFT JOIN OFERTA O WITH (NOLOCK) ON TEO.OFERTAID = O.OFERTAID AND O.CODIGOOFERTA = pc.CodigoTipoOferta
				WHERE	(E.CampaniaID = pwd.CampaniaID OR pwd.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END)
						AND TE.FlagActivo = 1
						AND E.CUV2 = pwd.CUV
			)
			END DescripcionOferta,
			M.Descripcion AS DescripcionLarga, --R2469
			'NO DISPONIBLE' AS Categoria, --R2469
			TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
			CASE WHEN TE.FlagNueva = 1 THEN
			CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
			END
				ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
				PC.IndicadorOferta AS IndicadorOfertaCUV  /*R20150701LR*/
				, CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline
				, PW.DescuentoProl
				, PW.MontoEscala
				, PW.MontoAhorroCatalogo
				, PW.MontoAhorroRevista
				, PWD.OrigenPedidoWeb
				, PWD.EsBackOrder
				, PWD.AceptoBackOrder
				, PC.CodigoCatalago
				, TE.Codigo TipoEstrategiaCodigo
				, EST.EsOfertaIndependiente
		FROM	dbo.PedidoWebDetalle pwd WITH (NOLOCK)
				INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
				JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
				LEFT JOIN dbo.Cliente c WITH (NOLOCK) ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
				LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
				LEFT JOIN OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
				LEFT JOIN MatrizComercial mc WITH (NOLOCK) on pc.CodigoProducto = mc.CodigoSAP
				LEFT JOIN TallaColorLiquidacion tcl WITH (NOLOCK) on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
				LEFT JOIN Estrategia EST WITH (NOLOCK)
					ON PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
					AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
					AND EST.Activo=1
					AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
					AND (
						@EsOpt = 0
						or 
						EST.TipoEstrategiaID not in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') )
						or
						@idTipoEstra = 0
						or 
						(
							EST.TipoEstrategiaID in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') ) 
							and EST.TipoEstrategiaID = @idTipoEstra	
						)
					)
				LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
				LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
					ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
					AND (
						TE.CodigoPrograma = @CodigoPrograma 
						OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
					)
				LEFT JOIN Marca M WITH (NOLOCK) ON pc.MarcaId = M.MarcaId
				LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
		WHERE	pwd.CampaniaID = @CampaniaID
				AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
		ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
	
		SET NOCOUNT OFF
	END

GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetPedidoWebDetalleByCampania_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByCampania_SB2
END
GO


CREATE PROCEDURE [dbo].[GetPedidoWebDetalleByCampania_SB2]
	@CampaniaID		INT,
	@ConsultoraID	BIGINT,
  	@EsOpt int = 0
AS
BEGIN
	SET NOCOUNT ON

	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID
	EXEC DepurarTallaColorLiquidacion @CampaniaID

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	/* Consultora Online */
	DECLARE @SolicitudClienteDetalle TABLE (
		PedidoWebID			INT,
		PedidoWebDetalleID	INT
	)

	INSERT INTO @SolicitudClienteDetalle
	SELECT DISTINCT d.PedidoWebID, d.PedidoWebDetalleID
	FROM	dbo.SolicitudCliente c WITH (NOLOCK)
	INNER JOIN SolicitudClienteDetalle d WITH (NOLOCK) ON c.SolicitudClienteID = d.SolicitudClienteID
	WHERE	LTRIM(RTRIM(c.Estado)) = 'A'
			AND c.Campania = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND ISNULL(d.PedidoWebID,0) <> 0
			AND ISNULL(d.PedidoWebDetalleID,0) <> 0
	/* Consultora Online */

	declare @idTipoEstra int = 0
	
	if	@EsOpt <> 1 and @EsOpt <> 2
		set @idTipoEstra = 0
	else
	begin
		select @idTipoEstra = TEE.TipoEstrategiaID 
		from TipoEstrategia TEE WITH (NOLOCK) 
		where (@EsOpt = 1 AND TEE.Codigo = '007') or (@EsOpt = 2 and TEE.Codigo = '001') 
	end
		
	set @idTipoEstra = isnull(@idTipoEstra, 0)

	SELECT	pwd.CampaniaID,
			pwd.PedidoID,
			pwd.PedidoDetalleID,
			ISNULL(pwd.MarcaID,0) AS MarcaID,
			pwd.ConsultoraID,
			pwd.ClienteID,
			pwd.OrdenPedidoWD,
			pwd.Cantidad,
			pwd.PrecioUnidad,
			pwd.ImporteTotal,
			pwd.CUV,
			pwd.EsKitNueva,
			CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion) END DescripcionProd,
			c.Nombre,
			pwd.OfertaWeb,
			pc.IndicadorMontoMinimo,
			ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
			ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
			ISNULL(pwd.TipoPedido, 'W') TipoPedido,
			CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) THEN
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	OFERTA O WITH (NOLOCK)
						INNER JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON O.OfertaID = TEO.OfertaID
						INNER JOIN TIPOESTRATEGIA TE WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
						INNER JOIN TallaColorCUV T WITH (NOLOCK) ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE	TE.FLAGACTIVO = 1
						AND O.CODIGOOFERTA = pc.codigotipooferta
						AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	TIPOESTRATEGIA TE WITH (NOLOCK)
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = E.TIPOESTRATEGIAID AND E.Activo = 1
						LEFT JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						LEFT JOIN OFERTA O WITH (NOLOCK) ON TEO.OFERTAID = O.OFERTAID AND O.CODIGOOFERTA = pc.CodigoTipoOferta
				WHERE	(E.CampaniaID = pwd.CampaniaID OR pwd.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END)
						AND TE.FlagActivo = 1
						AND E.CUV2 = pwd.CUV
			)
			END DescripcionOferta,
			M.Descripcion AS DescripcionLarga, --R2469
			'NO DISPONIBLE' AS Categoria, --R2469
			TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
			CASE WHEN TE.FlagNueva = 1 THEN
			CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
			END
				ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
				PC.IndicadorOferta AS IndicadorOfertaCUV  /*R20150701LR*/
				, CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline
				, PW.DescuentoProl
				, PW.MontoEscala
				, PW.MontoAhorroCatalogo
				, PW.MontoAhorroRevista
				, PWD.OrigenPedidoWeb
				, PWD.EsBackOrder
				, PWD.AceptoBackOrder
				, PC.CodigoCatalago
				, TE.Codigo TipoEstrategiaCodigo
				, EST.EsOfertaIndependiente
		FROM	dbo.PedidoWebDetalle pwd WITH (NOLOCK)
				INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
				JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
				LEFT JOIN dbo.Cliente c WITH (NOLOCK) ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
				LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
				LEFT JOIN OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
				LEFT JOIN MatrizComercial mc WITH (NOLOCK) on pc.CodigoProducto = mc.CodigoSAP
				LEFT JOIN TallaColorLiquidacion tcl WITH (NOLOCK) on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
				LEFT JOIN Estrategia EST WITH (NOLOCK)
					ON PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
					AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
					AND EST.Activo=1
					AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
					AND (
						@EsOpt = 0
						or 
						EST.TipoEstrategiaID not in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') )
						or
						@idTipoEstra = 0
						or 
						(
							EST.TipoEstrategiaID in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') ) 
							and EST.TipoEstrategiaID = @idTipoEstra	
						)
					)
				LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
				LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
					ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
					AND (
						TE.CodigoPrograma = @CodigoPrograma 
						OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
					)
				LEFT JOIN Marca M WITH (NOLOCK) ON pc.MarcaId = M.MarcaId
				LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
		WHERE	pwd.CampaniaID = @CampaniaID
				AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
		ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
	
		SET NOCOUNT OFF
	END

GO

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetPedidoWebDetalleByCampania_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByCampania_SB2
END
GO


CREATE PROCEDURE [dbo].[GetPedidoWebDetalleByCampania_SB2]
	@CampaniaID		INT,
	@ConsultoraID	BIGINT,
  	@EsOpt int = 0
AS
BEGIN
	SET NOCOUNT ON

	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID
	EXEC DepurarTallaColorLiquidacion @CampaniaID

	/*Para Nuevas obtener el numero de pedido de la consultora.*/
	DECLARE @NumeroPedido  INT
	SELECT	@NumeroPedido = consecutivonueva + 1
	FROM	ods.Consultora WITH (NOLOCK)
	WHERE	ConsultoraID=@ConsultoraID

	/*Revisar si la consultora pertenece al programa Nuevas.*/
	DECLARE @ProgramaNuevoActivado INT
	DECLARE @CodigoPrograma  VARCHAR(3)

	SELECT	@ProgramaNuevoActivado = COUNT(C.ConsultoraID), @CodigoPrograma = CP.CodigoPrograma
	FROM	ods.Consultora C WITH (NOLOCK) 
	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora
	WHERE	C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
	GROUP BY C.ConsultoraID, CP.CodigoPrograma
 
	IF (@ProgramaNuevoActivado IS NULL)
		SET @ProgramaNuevoActivado = 0

	/* Consultora Online */
	DECLARE @SolicitudClienteDetalle TABLE (
		PedidoWebID			INT,
		PedidoWebDetalleID	INT
	)

	INSERT INTO @SolicitudClienteDetalle
	SELECT DISTINCT d.PedidoWebID, d.PedidoWebDetalleID
	FROM	dbo.SolicitudCliente c WITH (NOLOCK)
	INNER JOIN SolicitudClienteDetalle d WITH (NOLOCK) ON c.SolicitudClienteID = d.SolicitudClienteID
	WHERE	LTRIM(RTRIM(c.Estado)) = 'A'
			AND c.Campania = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND ISNULL(d.PedidoWebID,0) <> 0
			AND ISNULL(d.PedidoWebDetalleID,0) <> 0
	/* Consultora Online */

	declare @idTipoEstra int = 0
	
	if	@EsOpt <> 1 and @EsOpt <> 2
		set @idTipoEstra = 0
	else
	begin
		select @idTipoEstra = TEE.TipoEstrategiaID 
		from TipoEstrategia TEE WITH (NOLOCK) 
		where (@EsOpt = 1 AND TEE.Codigo = '007') or (@EsOpt = 2 and TEE.Codigo = '001') 
	end
		
	set @idTipoEstra = isnull(@idTipoEstra, 0)

	SELECT	pwd.CampaniaID,
			pwd.PedidoID,
			pwd.PedidoDetalleID,
			ISNULL(pwd.MarcaID,0) AS MarcaID,
			pwd.ConsultoraID,
			pwd.ClienteID,
			pwd.OrdenPedidoWD,
			pwd.Cantidad,
			pwd.PrecioUnidad,
			pwd.ImporteTotal,
			pwd.CUV,
			pwd.EsKitNueva,
			CASE
			WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV
			ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion) END DescripcionProd,
			c.Nombre,
			pwd.OfertaWeb,
			pc.IndicadorMontoMinimo,
			ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
			ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,
			ISNULL(pwd.TipoPedido, 'W') TipoPedido,
			CASE
			WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) THEN
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	OFERTA O WITH (NOLOCK)
						INNER JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON O.OfertaID = TEO.OfertaID
						INNER JOIN TIPOESTRATEGIA TE WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
						INNER JOIN TallaColorCUV T WITH (NOLOCK) ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
				WHERE	TE.FLAGACTIVO = 1
						AND O.CODIGOOFERTA = pc.codigotipooferta
						AND T.CUV = pwd.CUV
			)
			ELSE
			(
				SELECT TOP 1 CASE WHEN TE.CODIGO IN ('005', '007', '008') THEN '[ �sika Para M� ]' ELSE  '[ ' + TE.DescripcionEstrategia + ' ]' END
				FROM	TIPOESTRATEGIA TE WITH (NOLOCK)
						INNER JOIN ESTRATEGIA E WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = E.TIPOESTRATEGIAID AND E.Activo = 1
						LEFT JOIN TIPOESTRATEGIAOFERTA TEO WITH (NOLOCK) ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
						LEFT JOIN OFERTA O WITH (NOLOCK) ON TEO.OFERTAID = O.OFERTAID AND O.CODIGOOFERTA = pc.CodigoTipoOferta
				WHERE	(E.CampaniaID = pwd.CampaniaID OR pwd.CampaniaID BETWEEN E.CampaniaID AND CASE WHEN E.CampaniaIDFin = 0 THEN E.CampaniaID ELSE E.CampaniaIDFin END)
						AND TE.FlagActivo = 1
						AND E.CUV2 = pwd.CUV
			)
			END DescripcionOferta,
			M.Descripcion AS DescripcionLarga, --R2469
			'NO DISPONIBLE' AS Categoria, --R2469
			TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
			CASE WHEN TE.FlagNueva = 1 THEN
			CASE WHEN @ProgramaNuevoActivado > 0 THEN 1
			END
				ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621
				PC.IndicadorOferta AS IndicadorOfertaCUV  /*R20150701LR*/
				, CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline
				, PW.DescuentoProl
				, PW.MontoEscala
				, PW.MontoAhorroCatalogo
				, PW.MontoAhorroRevista
				, PWD.OrigenPedidoWeb
				, PWD.EsBackOrder
				, PWD.AceptoBackOrder
				, PC.CodigoCatalago
				, TE.Codigo TipoEstrategiaCodigo
				, EST.EsOfertaIndependiente
		FROM	dbo.PedidoWebDetalle pwd WITH (NOLOCK)
				INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
				JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
				LEFT JOIN dbo.Cliente c WITH (NOLOCK) ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
				LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
				LEFT JOIN OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
				LEFT JOIN MatrizComercial mc WITH (NOLOCK) on pc.CodigoProducto = mc.CodigoSAP
				LEFT JOIN TallaColorLiquidacion tcl WITH (NOLOCK) on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
				LEFT JOIN Estrategia EST WITH (NOLOCK)
					ON PWD.CampaniaID BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
					AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
					AND EST.Activo=1
					AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
					AND (
						@EsOpt = 0
						or 
						EST.TipoEstrategiaID not in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') )
						or
						@idTipoEstra = 0
						or 
						(
							EST.TipoEstrategiaID in (select TEE.TipoEstrategiaID from TipoEstrategia TEE where TEE.Codigo in ('001', '007') ) 
							and EST.TipoEstrategiaID = @idTipoEstra	
						)
					)
				LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
				LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
					ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  
					AND (
						TE.CodigoPrograma = @CodigoPrograma 
						OR TE.CodigoPrograma IS NULL OR TE.CodigoPrograma = ''
					)
				LEFT JOIN Marca M WITH (NOLOCK) ON pc.MarcaId = M.MarcaId
				LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
		WHERE	pwd.CampaniaID = @CampaniaID
				AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
		ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
	
		SET NOCOUNT OFF
	END

GO
