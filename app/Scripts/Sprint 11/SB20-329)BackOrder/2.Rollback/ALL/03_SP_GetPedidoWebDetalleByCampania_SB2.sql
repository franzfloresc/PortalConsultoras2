USE BelcorpBolivia
GO
ALTER PROCEDURE GetPedidoWebDetalleByCampania_SB2
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
/*
 GetPedidoWebDetalleByCampania_SB2 201611, 49627031
*/
BEGIN
 SET NOCOUNT ON
  -- Depuramos las tallas y colores
   EXEC DepurarTallaColorCUV @CampaniaID
   EXEC DepurarTallaColorLiquidacion @CampaniaID
 /*Para Nuevas obtener el numero de pedido de la consultora.*/
 DECLARE @NumeroPedido  INT
 SELECT @NumeroPedido = consecutivonueva + 1
 FROM ods.Consultora
 WHERE ConsultoraID=@ConsultoraID
 /*Revisar si la consultora pertenece al programa Nuevas.*/
 DECLARE @ProgramaNuevoActivado INT
 DECLARE @CodigoPrograma  VARCHAR(3)

 SELECT @ProgramaNuevoActivado = COUNT(C.ConsultoraID),
   @CodigoPrograma = CP.CodigoPrograma
 FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
 WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
 GROUP BY C.ConsultoraID, CP.CodigoPrograma

  /* Consultora Online */
 DECLARE @SolicitudClienteDetalle table (
	PedidoWebID int,
	PedidoWebDetalleID int
 )

 INSERT INTO @SolicitudClienteDetalle
 SELECT d.PedidoWebID, d.PedidoWebDetalleID FROM dbo.SolicitudCliente c INNER JOIN SolicitudClienteDetalle d
 ON c.SolicitudClienteID = d.SolicitudClienteID
 WHERE
 LTRIM(RTRIM(c.Estado)) = 'A'
 AND c.Campania = @CampaniaID
 AND c.ConsultoraID = @ConsultoraID
 AND ISNULL(d.PedidoWebID,0) <> 0
 AND ISNULL(d.PedidoWebDetalleID,0) <> 0
 /* Consultora Online */

  SELECT pwd.CampaniaID,
      pwd.PedidoID,
      pwd.PedidoDetalleID,
      isnull(pwd.MarcaID,0) as MarcaID,
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
			  SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
			  INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
			  INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
			  INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
			  INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
			  WHERE
			  TE.FLAGACTIVO = 1
			 AND O.CODIGOOFERTA = pc.codigotipooferta
			 AND T.CUV = pwd.CUV
		)
		ELSE
		(
			 -- SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
			 -- INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
			 -- INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
			 -- INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
			 -- WHERE
			 -- TE.FLAGACTIVO = 1
			 --AND O.CODIGOOFERTA = pc.codigotipooferta
			 --AND E.CUV2 = pwd.CUV
			 SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
			  INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
			  INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
			  INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.Activo=1
			  WHERE
			  (E.CampaniaID = PWD.CAMPANIAID OR PWD.CAMPANIAID between E.CampaniaID and E.CampaniaIDFin)
			  AND TE.FLAGACTIVO = 1
			 AND O.CODIGOOFERTA = pc.codigotipooferta
			 AND E.CUV2 = pwd.CUV
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
 CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline,
 PW.DescuentoProl,
 PW.MontoEscala,
 PW.MontoAhorroCatalogo,
 PW.MontoAhorroRevista,
 PWD.OrigenPedidoWeb
 FROM dbo.PedidoWebDetalle pwd
	 INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	 LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	 LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
	 LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
	 LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
			AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
			AND EST.Activo=1
			AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
	 LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
	 LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
	 LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
	 LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
 WHERE pwd.CampaniaID = @CampaniaID
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
 ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
 SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpChile
GO
ALTER PROCEDURE GetPedidoWebDetalleByCampania_SB2
 @CampaniaID INT,
 @ConsultoraID BIGINT
AS
/*
 GetPedidoWebDetalleByCampania_SB2 201611, 49627031
*/
BEGIN
 SET NOCOUNT ON
  -- Depuramos las tallas y colores
   EXEC DepurarTallaColorCUV @CampaniaID
   EXEC DepurarTallaColorLiquidacion @CampaniaID
 /*Para Nuevas obtener el numero de pedido de la consultora.*/
 DECLARE @NumeroPedido  INT
 SELECT @NumeroPedido = consecutivonueva + 1
 FROM ods.Consultora
 WHERE ConsultoraID=@ConsultoraID
 /*Revisar si la consultora pertenece al programa Nuevas.*/
 DECLARE @ProgramaNuevoActivado INT
 DECLARE @CodigoPrograma  VARCHAR(3)

 SELECT @ProgramaNuevoActivado = COUNT(C.ConsultoraID),
   @CodigoPrograma = CP.CodigoPrograma
 FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
 WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
 GROUP BY C.ConsultoraID, CP.CodigoPrograma

  /* Consultora Online */
 DECLARE @SolicitudClienteDetalle table (
	PedidoWebID int,
	PedidoWebDetalleID int
 )

 INSERT INTO @SolicitudClienteDetalle
 SELECT d.PedidoWebID, d.PedidoWebDetalleID FROM dbo.SolicitudCliente c INNER JOIN SolicitudClienteDetalle d
 ON c.SolicitudClienteID = d.SolicitudClienteID
 WHERE
 LTRIM(RTRIM(c.Estado)) = 'A'
 AND c.Campania = @CampaniaID
 AND c.ConsultoraID = @ConsultoraID
 AND ISNULL(d.PedidoWebID,0) <> 0
 AND ISNULL(d.PedidoWebDetalleID,0) <> 0
 /* Consultora Online */

  SELECT pwd.CampaniaID,
      pwd.PedidoID,
      pwd.PedidoDetalleID,
      isnull(pwd.MarcaID,0) as MarcaID,
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
     SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
     INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
     WHERE
     TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND T.CUV = pwd.CUV
  )
  ELSE
  (
    SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.Activo=1
     WHERE
     (E.CampaniaID = PWD.CAMPANIAID OR PWD.CAMPANIAID between E.CampaniaID and E.CampaniaIDFin)
     AND TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND E.CUV2 = pwd.CUV
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
 CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline,
 PW.DescuentoProl,
 PW.MontoEscala,
 PW.MontoAhorroCatalogo,
 PW.MontoAhorroRevista,
 PWD.OrigenPedidoWeb
 FROM dbo.PedidoWebDetalle pwd
  INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
  JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
  LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
  LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
  LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
  LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
  LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
  LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
   AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
   AND EST.Activo=1
  -- AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
   AND EST.Numeropedido = (CASE WHEN EST.Numeropedido = 0 THEN 0 ELSE @NumeroPedido END)
  LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
  LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
  LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
  LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
 WHERE pwd.CampaniaID = @CampaniaID
 AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
 ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
 SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpCostaRica
GO
ALTER PROCEDURE GetPedidoWebDetalleByCampania_SB2
 @CampaniaID INT,
 @ConsultoraID BIGINT
AS
/*
 GetPedidoWebDetalleByCampania_SB2 201611, 49627031
*/
BEGIN
 SET NOCOUNT ON
  -- Depuramos las tallas y colores
   EXEC DepurarTallaColorCUV @CampaniaID
   EXEC DepurarTallaColorLiquidacion @CampaniaID
 /*Para Nuevas obtener el numero de pedido de la consultora.*/
 DECLARE @NumeroPedido  INT
 SELECT @NumeroPedido = consecutivonueva + 1
 FROM ods.Consultora
 WHERE ConsultoraID=@ConsultoraID
 /*Revisar si la consultora pertenece al programa Nuevas.*/
 DECLARE @ProgramaNuevoActivado INT
 DECLARE @CodigoPrograma  VARCHAR(3)

 SELECT @ProgramaNuevoActivado = COUNT(C.ConsultoraID),
   @CodigoPrograma = CP.CodigoPrograma
 FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
 WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
 GROUP BY C.ConsultoraID, CP.CodigoPrograma

  /* Consultora Online */
 DECLARE @SolicitudClienteDetalle table (
	PedidoWebID int,
	PedidoWebDetalleID int
 )

 INSERT INTO @SolicitudClienteDetalle
 SELECT d.PedidoWebID, d.PedidoWebDetalleID FROM dbo.SolicitudCliente c INNER JOIN SolicitudClienteDetalle d
 ON c.SolicitudClienteID = d.SolicitudClienteID
 WHERE
 LTRIM(RTRIM(c.Estado)) = 'A'
 AND c.Campania = @CampaniaID
 AND c.ConsultoraID = @ConsultoraID
 AND ISNULL(d.PedidoWebID,0) <> 0
 AND ISNULL(d.PedidoWebDetalleID,0) <> 0
 /* Consultora Online */

  SELECT pwd.CampaniaID,
      pwd.PedidoID,
      pwd.PedidoDetalleID,
      isnull(pwd.MarcaID,0) as MarcaID,
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
			  SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
			  INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
			  INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
			  INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
			  INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
			  WHERE
			  TE.FLAGACTIVO = 1
			 AND O.CODIGOOFERTA = pc.codigotipooferta
			 AND T.CUV = pwd.CUV
		)
		ELSE
		(
			 -- SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
			 -- INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
			 -- INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
			 -- INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
			 -- WHERE
			 -- TE.FLAGACTIVO = 1
			 --AND O.CODIGOOFERTA = pc.codigotipooferta
			 --AND E.CUV2 = pwd.CUV
			 SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
			  INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
			  INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
			  INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.Activo=1
			  WHERE
			  (E.CampaniaID = PWD.CAMPANIAID OR PWD.CAMPANIAID between E.CampaniaID and E.CampaniaIDFin)
			  AND TE.FLAGACTIVO = 1
			 AND O.CODIGOOFERTA = pc.codigotipooferta
			 AND E.CUV2 = pwd.CUV
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
 CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline,
 PW.DescuentoProl,
 PW.MontoEscala,
 PW.MontoAhorroCatalogo,
 PW.MontoAhorroRevista,
 PWD.OrigenPedidoWeb
 FROM dbo.PedidoWebDetalle pwd
	 INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	 LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	 LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
	 LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
	 LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
			AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
			AND EST.Activo=1
			AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
	 LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
	 LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
	 LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
	 LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
 WHERE pwd.CampaniaID = @CampaniaID
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
 ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
 SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpDominicana
GO
ALTER PROCEDURE GetPedidoWebDetalleByCampania_SB2
 @CampaniaID INT,
 @ConsultoraID BIGINT
AS
/*
 GetPedidoWebDetalleByCampania_SB2 201611, 49627031
*/
BEGIN
 SET NOCOUNT ON
  -- Depuramos las tallas y colores
   EXEC DepurarTallaColorCUV @CampaniaID
   EXEC DepurarTallaColorLiquidacion @CampaniaID
 /*Para Nuevas obtener el numero de pedido de la consultora.*/
 DECLARE @NumeroPedido  INT
 SELECT @NumeroPedido = consecutivonueva + 1
 FROM ods.Consultora
 WHERE ConsultoraID=@ConsultoraID
 /*Revisar si la consultora pertenece al programa Nuevas.*/
 DECLARE @ProgramaNuevoActivado INT
 DECLARE @CodigoPrograma  VARCHAR(3)

 SELECT @ProgramaNuevoActivado = COUNT(C.ConsultoraID),
   @CodigoPrograma = CP.CodigoPrograma
 FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
 WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
 GROUP BY C.ConsultoraID, CP.CodigoPrograma

  /* Consultora Online */
 DECLARE @SolicitudClienteDetalle table (
	PedidoWebID int,
	PedidoWebDetalleID int
 )

 INSERT INTO @SolicitudClienteDetalle
 SELECT d.PedidoWebID, d.PedidoWebDetalleID FROM dbo.SolicitudCliente c INNER JOIN SolicitudClienteDetalle d
 ON c.SolicitudClienteID = d.SolicitudClienteID
 WHERE
 LTRIM(RTRIM(c.Estado)) = 'A'
 AND c.Campania = @CampaniaID
 AND c.ConsultoraID = @ConsultoraID
 AND ISNULL(d.PedidoWebID,0) <> 0
 AND ISNULL(d.PedidoWebDetalleID,0) <> 0
 /* Consultora Online */

  SELECT pwd.CampaniaID,
      pwd.PedidoID,
      pwd.PedidoDetalleID,
      isnull(pwd.MarcaID,0) as MarcaID,
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
     SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
     INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
     WHERE
     TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND T.CUV = pwd.CUV
  )
  ELSE
  (
    SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.Activo=1
     WHERE
     (E.CampaniaID = PWD.CAMPANIAID OR PWD.CAMPANIAID between E.CampaniaID and E.CampaniaIDFin)
     AND TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND E.CUV2 = pwd.CUV
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
 CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline,
 PW.DescuentoProl,
 PW.MontoEscala,
 PW.MontoAhorroCatalogo,
 PW.MontoAhorroRevista,
 PWD.OrigenPedidoWeb
 FROM dbo.PedidoWebDetalle pwd
  INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
  JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
  LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
  LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
  LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
  LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
  LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
  LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
   AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
   AND EST.Activo=1
  -- AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
   AND EST.Numeropedido = (CASE WHEN EST.Numeropedido = 0 THEN 0 ELSE @NumeroPedido END)
  LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
  LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
  LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
  LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
 WHERE pwd.CampaniaID = @CampaniaID
 AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
 ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
 SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpEcuador
GO
ALTER PROCEDURE GetPedidoWebDetalleByCampania_SB2
 @CampaniaID INT,
 @ConsultoraID BIGINT
AS
/*
 GetPedidoWebDetalleByCampania_SB2 201611, 49627031
*/
BEGIN
 SET NOCOUNT ON
  -- Depuramos las tallas y colores
   EXEC DepurarTallaColorCUV @CampaniaID
   EXEC DepurarTallaColorLiquidacion @CampaniaID
 /*Para Nuevas obtener el numero de pedido de la consultora.*/
 DECLARE @NumeroPedido  INT
 SELECT @NumeroPedido = consecutivonueva + 1
 FROM ods.Consultora
 WHERE ConsultoraID=@ConsultoraID
 /*Revisar si la consultora pertenece al programa Nuevas.*/
 DECLARE @ProgramaNuevoActivado INT
 DECLARE @CodigoPrograma  VARCHAR(3)

 SELECT @ProgramaNuevoActivado = COUNT(C.ConsultoraID),
   @CodigoPrograma = CP.CodigoPrograma
 FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
 WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
 GROUP BY C.ConsultoraID, CP.CodigoPrograma

 /* Consultora Online */
 DECLARE @SolicitudClienteDetalle table (
	PedidoWebID int,
	PedidoWebDetalleID int
 )

 INSERT INTO @SolicitudClienteDetalle
 SELECT d.PedidoWebID, d.PedidoWebDetalleID FROM dbo.SolicitudCliente c INNER JOIN SolicitudClienteDetalle d
 ON c.SolicitudClienteID = d.SolicitudClienteID
 WHERE
 LTRIM(RTRIM(c.Estado)) = 'A'
 AND c.Campania = @CampaniaID
 AND c.ConsultoraID = @ConsultoraID
 AND ISNULL(d.PedidoWebID,0) <> 0
 AND ISNULL(d.PedidoWebDetalleID,0) <> 0
 /* Consultora Online */

  SELECT pwd.CampaniaID,
      pwd.PedidoID,
      pwd.PedidoDetalleID,
      isnull(pwd.MarcaID,0) as MarcaID,
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
     SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
     INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
     WHERE
     TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND T.CUV = pwd.CUV
  )
  ELSE
  (
    SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.Activo=1
     WHERE
     (E.CampaniaID = PWD.CAMPANIAID OR PWD.CAMPANIAID between E.CampaniaID and E.CampaniaIDFin)
     AND TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND E.CUV2 = pwd.CUV
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
 CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline,
 PW.DescuentoProl,
 PW.MontoEscala,
 PW.MontoAhorroCatalogo,
 PW.MontoAhorroRevista,
 PWD.OrigenPedidoWeb
 FROM dbo.PedidoWebDetalle pwd
  INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
  JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
  LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
  LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
  LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
  LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
  LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
  LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
   AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
   AND EST.Activo=1
  -- AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
   AND EST.Numeropedido = (CASE WHEN EST.Numeropedido = 0 THEN 0 ELSE @NumeroPedido END)
  LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
  LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
  LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
  LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
 WHERE pwd.CampaniaID = @CampaniaID
 AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
 ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
 SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpGuatemala
GO
ALTER PROCEDURE GetPedidoWebDetalleByCampania_SB2
 @CampaniaID INT,
 @ConsultoraID BIGINT
AS
/*
 GetPedidoWebDetalleByCampania_SB2 201611, 49627031
*/
BEGIN
 SET NOCOUNT ON
  -- Depuramos las tallas y colores
   EXEC DepurarTallaColorCUV @CampaniaID
   EXEC DepurarTallaColorLiquidacion @CampaniaID
 /*Para Nuevas obtener el numero de pedido de la consultora.*/
 DECLARE @NumeroPedido  INT
 SELECT @NumeroPedido = consecutivonueva + 1
 FROM ods.Consultora
 WHERE ConsultoraID=@ConsultoraID
 /*Revisar si la consultora pertenece al programa Nuevas.*/
 DECLARE @ProgramaNuevoActivado INT
 DECLARE @CodigoPrograma  VARCHAR(3)

 SELECT @ProgramaNuevoActivado = COUNT(C.ConsultoraID),
   @CodigoPrograma = CP.CodigoPrograma
 FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
 WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
 GROUP BY C.ConsultoraID, CP.CodigoPrograma

  /* Consultora Online */
 DECLARE @SolicitudClienteDetalle table (
	PedidoWebID int,
	PedidoWebDetalleID int
 )

 INSERT INTO @SolicitudClienteDetalle
 SELECT d.PedidoWebID, d.PedidoWebDetalleID FROM dbo.SolicitudCliente c INNER JOIN SolicitudClienteDetalle d
 ON c.SolicitudClienteID = d.SolicitudClienteID
 WHERE
 LTRIM(RTRIM(c.Estado)) = 'A'
 AND c.Campania = @CampaniaID
 AND c.ConsultoraID = @ConsultoraID
 AND ISNULL(d.PedidoWebID,0) <> 0
 AND ISNULL(d.PedidoWebDetalleID,0) <> 0
 /* Consultora Online */

  SELECT pwd.CampaniaID,
      pwd.PedidoID,
      pwd.PedidoDetalleID,
      isnull(pwd.MarcaID,0) as MarcaID,
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
     SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
     INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
     WHERE
     TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND T.CUV = pwd.CUV
  )
  ELSE
  (
    SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.Activo=1
     WHERE
     (E.CampaniaID = PWD.CAMPANIAID OR PWD.CAMPANIAID between E.CampaniaID and E.CampaniaIDFin)
     AND TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND E.CUV2 = pwd.CUV
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
 CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline,
 PW.DescuentoProl,
 PW.MontoEscala,
 PW.MontoAhorroCatalogo,
 PW.MontoAhorroRevista,
 PWD.OrigenPedidoWeb
 FROM dbo.PedidoWebDetalle pwd
  INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
  JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
  LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
  LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
  LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
  LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
  LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
  LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
   AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
   AND EST.Activo=1
  -- AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
   AND EST.Numeropedido = (CASE WHEN EST.Numeropedido = 0 THEN 0 ELSE @NumeroPedido END)
  LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
  LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
  LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
  LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
 WHERE pwd.CampaniaID = @CampaniaID
 AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
 ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
 SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpPanama
GO
ALTER PROCEDURE GetPedidoWebDetalleByCampania_SB2
 @CampaniaID INT,
 @ConsultoraID BIGINT
AS
/*
 GetPedidoWebDetalleByCampania_SB2 201611, 49627031
*/
BEGIN
 SET NOCOUNT ON
  -- Depuramos las tallas y colores
   EXEC DepurarTallaColorCUV @CampaniaID
   EXEC DepurarTallaColorLiquidacion @CampaniaID
 /*Para Nuevas obtener el numero de pedido de la consultora.*/
 DECLARE @NumeroPedido  INT
 SELECT @NumeroPedido = consecutivonueva + 1
 FROM ods.Consultora
 WHERE ConsultoraID=@ConsultoraID
 /*Revisar si la consultora pertenece al programa Nuevas.*/
 DECLARE @ProgramaNuevoActivado INT
 DECLARE @CodigoPrograma  VARCHAR(3)

 SELECT @ProgramaNuevoActivado = COUNT(C.ConsultoraID),
   @CodigoPrograma = CP.CodigoPrograma
 FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
 WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
 GROUP BY C.ConsultoraID, CP.CodigoPrograma

  /* Consultora Online */
 DECLARE @SolicitudClienteDetalle table (
	PedidoWebID int,
	PedidoWebDetalleID int
 )

 INSERT INTO @SolicitudClienteDetalle
 SELECT d.PedidoWebID, d.PedidoWebDetalleID FROM dbo.SolicitudCliente c INNER JOIN SolicitudClienteDetalle d
 ON c.SolicitudClienteID = d.SolicitudClienteID
 WHERE
 LTRIM(RTRIM(c.Estado)) = 'A'
 AND c.Campania = @CampaniaID
 AND c.ConsultoraID = @ConsultoraID
 AND ISNULL(d.PedidoWebID,0) <> 0
 AND ISNULL(d.PedidoWebDetalleID,0) <> 0
 /* Consultora Online */

  SELECT pwd.CampaniaID,
      pwd.PedidoID,
      pwd.PedidoDetalleID,
      isnull(pwd.MarcaID,0) as MarcaID,
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
     SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
     INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
     WHERE
     TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND T.CUV = pwd.CUV
  )
  ELSE
  (
    SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.Activo=1
     WHERE
     (E.CampaniaID = PWD.CAMPANIAID OR PWD.CAMPANIAID between E.CampaniaID and E.CampaniaIDFin)
     AND TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND E.CUV2 = pwd.CUV
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
 CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline,
 PW.DescuentoProl,
 PW.MontoEscala,
 PW.MontoAhorroCatalogo,
 PW.MontoAhorroRevista,
 PWD.OrigenPedidoWeb
 FROM dbo.PedidoWebDetalle pwd
  INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
  JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
  LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
  LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
  LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
  LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
  LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
  LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
   AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
   AND EST.Activo=1
  -- AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
   AND EST.Numeropedido = (CASE WHEN EST.Numeropedido = 0 THEN 0 ELSE @NumeroPedido END)
  LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
  LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
  LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
  LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
 WHERE pwd.CampaniaID = @CampaniaID
 AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
 ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
 SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpPuertoRico
GO
ALTER PROCEDURE GetPedidoWebDetalleByCampania_SB2
 @CampaniaID INT,
 @ConsultoraID BIGINT
AS
/*
 GetPedidoWebDetalleByCampania_SB2 201611, 49627031
*/
BEGIN
 SET NOCOUNT ON
  -- Depuramos las tallas y colores
   EXEC DepurarTallaColorCUV @CampaniaID
   EXEC DepurarTallaColorLiquidacion @CampaniaID
 /*Para Nuevas obtener el numero de pedido de la consultora.*/
 DECLARE @NumeroPedido  INT
 SELECT @NumeroPedido = consecutivonueva + 1
 FROM ods.Consultora
 WHERE ConsultoraID=@ConsultoraID
 /*Revisar si la consultora pertenece al programa Nuevas.*/
 DECLARE @ProgramaNuevoActivado INT
 DECLARE @CodigoPrograma  VARCHAR(3)

 SELECT @ProgramaNuevoActivado = COUNT(C.ConsultoraID),
   @CodigoPrograma = CP.CodigoPrograma
 FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
 WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
 GROUP BY C.ConsultoraID, CP.CodigoPrograma


  /* Consultora Online */
 DECLARE @SolicitudClienteDetalle table (
	PedidoWebID int,
	PedidoWebDetalleID int
 )

 INSERT INTO @SolicitudClienteDetalle
 SELECT d.PedidoWebID, d.PedidoWebDetalleID FROM dbo.SolicitudCliente c INNER JOIN SolicitudClienteDetalle d
 ON c.SolicitudClienteID = d.SolicitudClienteID
 WHERE
 LTRIM(RTRIM(c.Estado)) = 'A'
 AND c.Campania = @CampaniaID
 AND c.ConsultoraID = @ConsultoraID
 AND ISNULL(d.PedidoWebID,0) <> 0
 AND ISNULL(d.PedidoWebDetalleID,0) <> 0
 /* Consultora Online */

  SELECT pwd.CampaniaID,
      pwd.PedidoID,
      pwd.PedidoDetalleID,
      isnull(pwd.MarcaID,0) as MarcaID,
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
     SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
     INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
     WHERE
     TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND T.CUV = pwd.CUV
  )
  ELSE
  (
    SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.Activo=1
     WHERE
     (E.CampaniaID = PWD.CAMPANIAID OR PWD.CAMPANIAID between E.CampaniaID and E.CampaniaIDFin)
     AND TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND E.CUV2 = pwd.CUV
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
 CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline,
 PW.DescuentoProl,
 PW.MontoEscala,
 PW.MontoAhorroCatalogo,
 PW.MontoAhorroRevista,
 PWD.OrigenPedidoWeb
 FROM dbo.PedidoWebDetalle pwd
  INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
  JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
  LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
  LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
  LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
  LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
  LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
  LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
   AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
   AND EST.Activo=1
  -- AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
   AND EST.Numeropedido = (CASE WHEN EST.Numeropedido = 0 THEN 0 ELSE @NumeroPedido END)
  LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
  LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
  LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
  LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
 WHERE pwd.CampaniaID = @CampaniaID
 AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
 ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
 SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpSalvador
GO
ALTER PROCEDURE GetPedidoWebDetalleByCampania_SB2
 @CampaniaID INT,
 @ConsultoraID BIGINT
AS
/*
 GetPedidoWebDetalleByCampania_SB2 201611, 49627031
*/
BEGIN
 SET NOCOUNT ON
  -- Depuramos las tallas y colores
   EXEC DepurarTallaColorCUV @CampaniaID
   EXEC DepurarTallaColorLiquidacion @CampaniaID
 /*Para Nuevas obtener el numero de pedido de la consultora.*/
 DECLARE @NumeroPedido  INT
 SELECT @NumeroPedido = consecutivonueva + 1
 FROM ods.Consultora
 WHERE ConsultoraID=@ConsultoraID
 /*Revisar si la consultora pertenece al programa Nuevas.*/
 DECLARE @ProgramaNuevoActivado INT
 DECLARE @CodigoPrograma  VARCHAR(3)

 SELECT @ProgramaNuevoActivado = COUNT(C.ConsultoraID),
   @CodigoPrograma = CP.CodigoPrograma
 FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
 WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
 GROUP BY C.ConsultoraID, CP.CodigoPrograma

  /* Consultora Online */
 DECLARE @SolicitudClienteDetalle table (
	PedidoWebID int,
	PedidoWebDetalleID int
 )

 INSERT INTO @SolicitudClienteDetalle
 SELECT d.PedidoWebID, d.PedidoWebDetalleID FROM dbo.SolicitudCliente c INNER JOIN SolicitudClienteDetalle d
 ON c.SolicitudClienteID = d.SolicitudClienteID
 WHERE
 LTRIM(RTRIM(c.Estado)) = 'A'
 AND c.Campania = @CampaniaID
 AND c.ConsultoraID = @ConsultoraID
 AND ISNULL(d.PedidoWebID,0) <> 0
 AND ISNULL(d.PedidoWebDetalleID,0) <> 0
 /* Consultora Online */

  SELECT pwd.CampaniaID,
      pwd.PedidoID,
      pwd.PedidoDetalleID,
      isnull(pwd.MarcaID,0) as MarcaID,
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
     SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
     INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
     WHERE
     TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND T.CUV = pwd.CUV
  )
  ELSE
  (
    SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.Activo=1
     WHERE
     (E.CampaniaID = PWD.CAMPANIAID OR PWD.CAMPANIAID between E.CampaniaID and E.CampaniaIDFin)
     AND TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND E.CUV2 = pwd.CUV
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
 CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline,
 PW.DescuentoProl,
 PW.MontoEscala,
 PW.MontoAhorroCatalogo,
 PW.MontoAhorroRevista,
 PWD.OrigenPedidoWeb
 FROM dbo.PedidoWebDetalle pwd
  INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
  JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
  LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
  LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
  LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
  LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
  LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
  LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
   AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
   AND EST.Activo=1
  -- AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
   AND EST.Numeropedido = (CASE WHEN EST.Numeropedido = 0 THEN 0 ELSE @NumeroPedido END)
  LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
  LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
  LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
  LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
 WHERE pwd.CampaniaID = @CampaniaID
 AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
 ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
 SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpVenezuela
GO
ALTER PROCEDURE GetPedidoWebDetalleByCampania_SB2
 @CampaniaID INT,
 @ConsultoraID BIGINT
AS
/*
 GetPedidoWebDetalleByCampania_SB2 201611, 49627031
*/
BEGIN
 SET NOCOUNT ON
  -- Depuramos las tallas y colores
   EXEC DepurarTallaColorCUV @CampaniaID
   EXEC DepurarTallaColorLiquidacion @CampaniaID
 /*Para Nuevas obtener el numero de pedido de la consultora.*/
 DECLARE @NumeroPedido  INT
 SELECT @NumeroPedido = consecutivonueva + 1
 FROM ods.Consultora
 WHERE ConsultoraID=@ConsultoraID
 /*Revisar si la consultora pertenece al programa Nuevas.*/
 DECLARE @ProgramaNuevoActivado INT
 DECLARE @CodigoPrograma  VARCHAR(3)

 SELECT @ProgramaNuevoActivado = COUNT(C.ConsultoraID),
   @CodigoPrograma = CP.CodigoPrograma
 FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
 WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
 GROUP BY C.ConsultoraID, CP.CodigoPrograma

  /* Consultora Online */
 DECLARE @SolicitudClienteDetalle table (
	PedidoWebID int,
	PedidoWebDetalleID int
 )

 INSERT INTO @SolicitudClienteDetalle
 SELECT d.PedidoWebID, d.PedidoWebDetalleID FROM dbo.SolicitudCliente c INNER JOIN SolicitudClienteDetalle d
 ON c.SolicitudClienteID = d.SolicitudClienteID
 WHERE
 LTRIM(RTRIM(c.Estado)) = 'A'
 AND c.Campania = @CampaniaID
 AND c.ConsultoraID = @ConsultoraID
 AND ISNULL(d.PedidoWebID,0) <> 0
 AND ISNULL(d.PedidoWebDetalleID,0) <> 0
 /* Consultora Online */


  SELECT pwd.CampaniaID,
      pwd.PedidoID,
      pwd.PedidoDetalleID,
      isnull(pwd.MarcaID,0) as MarcaID,
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
     SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
     INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
     WHERE
     TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND T.CUV = pwd.CUV
  )
  ELSE
  (
    SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.Activo=1
     WHERE
     (E.CampaniaID = PWD.CAMPANIAID OR PWD.CAMPANIAID between E.CampaniaID and E.CampaniaIDFin)
     AND TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND E.CUV2 = pwd.CUV
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
 CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline,
 PW.DescuentoProl,
 PW.MontoEscala,
 PW.MontoAhorroCatalogo,
 PW.MontoAhorroRevista,
 PWD.OrigenPedidoWeb
 FROM dbo.PedidoWebDetalle pwd
  INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
  JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
  LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
  LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
  LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
  LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
  LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
  LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
   AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
   AND EST.Activo=1
  -- AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
   AND EST.Numeropedido = (CASE WHEN EST.Numeropedido = 0 THEN 0 ELSE @NumeroPedido END)
  LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
  LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
  LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
  LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
 WHERE pwd.CampaniaID = @CampaniaID
 AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
 ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
 SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpColombia
GO
ALTER PROCEDURE GetPedidoWebDetalleByCampania_SB2
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
/*
 GetPedidoWebDetalleByCampania_SB2 201611, 49627031
*/
BEGIN
 SET NOCOUNT ON
  -- Depuramos las tallas y colores
   EXEC DepurarTallaColorCUV @CampaniaID
   EXEC DepurarTallaColorLiquidacion @CampaniaID
 /*Para Nuevas obtener el numero de pedido de la consultora.*/
 DECLARE @NumeroPedido  INT
 SELECT @NumeroPedido = consecutivonueva + 1
 FROM ods.Consultora
 WHERE ConsultoraID=@ConsultoraID
 /*Revisar si la consultora pertenece al programa Nuevas.*/
 DECLARE @ProgramaNuevoActivado INT
 DECLARE @CodigoPrograma  VARCHAR(3)

 SELECT @ProgramaNuevoActivado = COUNT(C.ConsultoraID),
   @CodigoPrograma = CP.CodigoPrograma
 FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
 WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
 GROUP BY C.ConsultoraID, CP.CodigoPrograma

 /* Consultora Online */
 DECLARE @SolicitudClienteDetalle table (
	PedidoWebID int,
	PedidoWebDetalleID int
 )

 INSERT INTO @SolicitudClienteDetalle
 SELECT d.PedidoWebID, d.PedidoWebDetalleID FROM dbo.SolicitudCliente c INNER JOIN SolicitudClienteDetalle d
 ON c.SolicitudClienteID = d.SolicitudClienteID
 WHERE
 LTRIM(RTRIM(c.Estado)) = 'A'
 AND c.Campania = @CampaniaID
 AND c.ConsultoraID = @ConsultoraID
 AND ISNULL(d.PedidoWebID,0) <> 0
 AND ISNULL(d.PedidoWebDetalleID,0) <> 0
 /* Consultora Online */

  SELECT pwd.CampaniaID,
      pwd.PedidoID,
      pwd.PedidoDetalleID,
      isnull(pwd.MarcaID,0) as MarcaID,
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
     SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
     INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
     WHERE
     TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND T.CUV = pwd.CUV
  )
  ELSE
  (
    SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.Activo=1
     WHERE
     (E.CampaniaID = PWD.CAMPANIAID OR PWD.CAMPANIAID between E.CampaniaID and E.CampaniaIDFin)
     AND TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND E.CUV2 = pwd.CUV
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
 CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline,
 PW.DescuentoProl,
 PW.MontoEscala,
 PW.MontoAhorroCatalogo,
 PW.MontoAhorroRevista,
 PWD.OrigenPedidoWeb
 FROM dbo.PedidoWebDetalle pwd
  INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
  JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
  LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
  LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
  LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
  LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
  LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
  LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
   AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
   AND EST.Activo=1
  -- AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
   AND EST.Numeropedido = (CASE WHEN EST.Numeropedido = 0 THEN 0 ELSE @NumeroPedido END)
  LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
  LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
  LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
  LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
 WHERE pwd.CampaniaID = @CampaniaID
 AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
 ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
 SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpMexico
GO
ALTER PROCEDURE GetPedidoWebDetalleByCampania_SB2
	@CampaniaID INT,
	@ConsultoraID BIGINT
AS
/*
 GetPedidoWebDetalleByCampania_SB2 201611, 49627031
*/
BEGIN
 SET NOCOUNT ON
  -- Depuramos las tallas y colores
   EXEC DepurarTallaColorCUV @CampaniaID
   EXEC DepurarTallaColorLiquidacion @CampaniaID
 /*Para Nuevas obtener el numero de pedido de la consultora.*/
 DECLARE @NumeroPedido  INT
 SELECT @NumeroPedido = consecutivonueva + 1
 FROM ods.Consultora
 WHERE ConsultoraID=@ConsultoraID
 /*Revisar si la consultora pertenece al programa Nuevas.*/
 DECLARE @ProgramaNuevoActivado INT
 DECLARE @CodigoPrograma  VARCHAR(3)

 SELECT @ProgramaNuevoActivado = COUNT(C.ConsultoraID),
   @CodigoPrograma = CP.CodigoPrograma
 FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
 WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
 GROUP BY C.ConsultoraID, CP.CodigoPrograma

 /* Consultora Online */
 DECLARE @SolicitudClienteDetalle table (
	PedidoWebID int,
	PedidoWebDetalleID int
 )

 INSERT INTO @SolicitudClienteDetalle
 SELECT d.PedidoWebID, d.PedidoWebDetalleID FROM dbo.SolicitudCliente c INNER JOIN SolicitudClienteDetalle d
 ON c.SolicitudClienteID = d.SolicitudClienteID
 WHERE
 LTRIM(RTRIM(c.Estado)) = 'A'
 AND c.Campania = @CampaniaID
 AND c.ConsultoraID = @ConsultoraID
 AND ISNULL(d.PedidoWebID,0) <> 0
 AND ISNULL(d.PedidoWebDetalleID,0) <> 0
 /* Consultora Online */

  SELECT pwd.CampaniaID,
      pwd.PedidoID,
      pwd.PedidoDetalleID,
      isnull(pwd.MarcaID,0) as MarcaID,
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
     SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
     INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
     WHERE
     TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND T.CUV = pwd.CUV
  )
  ELSE
  (
    SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
     INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
     INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
     INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.Activo=1
     WHERE
     (E.CampaniaID = PWD.CAMPANIAID OR PWD.CAMPANIAID between E.CampaniaID and E.CampaniaIDFin)
     AND TE.FLAGACTIVO = 1
    AND O.CODIGOOFERTA = pc.codigotipooferta
    AND E.CUV2 = pwd.CUV
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
 CASE WHEN ISNULL(scd.PedidoWebDetalleID,0) <> 0 THEN 1 ELSE 0 END FlagConsultoraOnline,
 PW.DescuentoProl,
 PW.MontoEscala,
 PW.MontoAhorroCatalogo,
 PW.MontoAhorroRevista,
 PWD.OrigenPedidoWeb
 FROM dbo.PedidoWebDetalle pwd
  INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
  JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
  LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
  LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
  LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
  LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
  LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
  LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
   AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
   AND EST.Activo=1
  -- AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
   AND EST.Numeropedido = (CASE WHEN EST.Numeropedido = 0 THEN 0 ELSE @NumeroPedido END)
  LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
  LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
  LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
  LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
 WHERE pwd.CampaniaID = @CampaniaID
 AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
 ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
 SET NOCOUNT OFF
END
GO
/*end*/

USE BelcorpPeru
GO
ALTER PROCEDURE GetPedidoWebDetalleByCampania_SB2
 @CampaniaID INT,
 @ConsultoraID BIGINT
AS
/*
 GetPedidoWebDetalleByCampania_SB2 201611, 49627031
*/
BEGIN
 SET NOCOUNT ON
  -- Depuramos las tallas y colores
   EXEC DepurarTallaColorCUV @CampaniaID
   EXEC DepurarTallaColorLiquidacion @CampaniaID
 /*Para Nuevas obtener el numero de pedido de la consultora.*/
 DECLARE @NumeroPedido  INT
 SELECT @NumeroPedido = consecutivonueva + 1
 FROM ods.Consultora
 WHERE ConsultoraID=@ConsultoraID
 /*Revisar si la consultora pertenece al programa Nuevas.*/
 DECLARE @ProgramaNuevoActivado INT
 DECLARE @CodigoPrograma  VARCHAR(3)

 SELECT @ProgramaNuevoActivado = COUNT(C.ConsultoraID),
   @CodigoPrograma = CP.CodigoPrograma
 FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
 WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1
 GROUP BY C.ConsultoraID, CP.CodigoPrograma

 /* Consultora Online */
 DECLARE @SolicitudClienteDetalle table (
	PedidoWebID int,
	PedidoWebDetalleID int
 )

 INSERT INTO @SolicitudClienteDetalle
 SELECT DISTINCT d.PedidoWebID, d.PedidoWebDetalleID
 FROM dbo.SolicitudCliente c
 INNER JOIN SolicitudClienteDetalle d ON c.SolicitudClienteID = d.SolicitudClienteID
 WHERE
 LTRIM(RTRIM(c.Estado)) = 'A'
 AND c.Campania = @CampaniaID
 AND c.ConsultoraID = @ConsultoraID
 AND ISNULL(d.PedidoWebID,0) <> 0
 AND ISNULL(d.PedidoWebDetalleID,0) <> 0
 /* Consultora Online */

  SELECT pwd.CampaniaID,
      pwd.PedidoID,
      pwd.PedidoDetalleID,
      isnull(pwd.MarcaID,0) as MarcaID,
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
			  SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O
			  INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
			  INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
			  INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
			  INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID
			  WHERE
			  TE.FLAGACTIVO = 1
			 AND O.CODIGOOFERTA = pc.codigotipooferta
			 AND T.CUV = pwd.CUV
		)
		ELSE
		(
			 -- SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
			 -- INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
			 -- INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
			 -- INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1
			 -- WHERE
			 -- TE.FLAGACTIVO = 1
			 --AND O.CODIGOOFERTA = pc.codigotipooferta
			 --AND E.CUV2 = pwd.CUV
			 SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O
			  INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID
			  INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID
			  INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.Activo=1
			  WHERE
			  (E.CampaniaID = PWD.CAMPANIAID OR PWD.CAMPANIAID between E.CampaniaID and E.CampaniaIDFin)
			  AND TE.FLAGACTIVO = 1
			 AND O.CODIGOOFERTA = pc.codigotipooferta
			 AND E.CUV2 = pwd.CUV
		)
		END DescripcionOferta,
   M.Descripcion AS DescripcionLarga, --R2469
   'NO DISPONIBLE' AS Categoria, --R2469
   TE.DescripcionEstrategia as DescripcionEstrategia, --R2469
	CASE WHEN TE.FlagNueva =1 THEN
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
 FROM dbo.PedidoWebDetalle pwd
	 INNER JOIN dbo.PedidoWeb PW ON PW.PedidoID = pwd.PedidoID and pw.consultoraid=pwd.consultoraid and pw.CampaniaID=pwd.CampaniaID
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV
	 LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV
	 LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP
	 LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID
	 LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin
			AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV))
			AND EST.Activo=1
			AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
	 LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID
	 LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL)
	 LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId
	 LEFT JOIN @SolicitudClienteDetalle scd on pwd.PedidoID = scd.PedidoWebID and pwd.PedidoDetalleID = scd.PedidoWebDetalleID
 WHERE pwd.CampaniaID = @CampaniaID
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL
 ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC
 SET NOCOUNT OFF
END
GO