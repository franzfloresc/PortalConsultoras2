
 USE BelcorpPeru_PL50
 GO

 --exec GetPedidoWebDetalleByCampania 201807,1,'',0,1

IF (OBJECT_ID('dbo.GetPedidoWebDetalleByCampania', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetPedidoWebDetalleByCampania AS SET NOCOUNT ON;')
GO


ALTER PROCEDURE [dbo].[GetPedidoWebDetalleByCampania] @CampaniaID int
, @ConsultoraID bigint
, @CodigoPrograma varchar(15) = NULL
, @NumeroPedido int = 0
, @AgruparSet bit = 0
AS
BEGIN

  DECLARE @FechaRegistroPedido date
  DECLARE @FechaInicioSetAgrupado date
  SET @FechaInicioSetAgrupado = (SELECT
    datefromparts(valor1, valor2, valor3)
  FROM configuracionpaisdatos
  WHERE Codigo = 'InicioFechaSetAGrupados')

  SELECT
    @FechaRegistroPedido = FechaRegistro
  FROM PedidoWeb WITH (NOLOCK)
  WHERE CampaniaID = @CampaniaID
  AND ConsultoraID = @ConsultoraID


  IF ((@AgruparSet = 1)
    AND (CAST(@FechaRegistroPedido AS date) > CAST(@FechaInicioSetAgrupado AS date)))
  BEGIN

    SET NOCOUNT ON
    SET @CodigoPrograma =
                         CASE
                           WHEN @CodigoPrograma = '' THEN NULL
                           ELSE @CodigoPrograma
                         END
    SET @NumeroPedido =
                       CASE
                         WHEN @NumeroPedido > 0 THEN @NumeroPedido + 1
                         ELSE 0
                       END

    DECLARE @PedidoDetalle2 AS TABLE (
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
      CodigoTipoEstrategia char(3)
      PRIMARY KEY (
      CampaniaID, PedidoID, PedidoDetalleID
      )
    )

    INSERT INTO @PedidoDetalle2
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
        COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PC.Descripcion) AS DescripcionProd,
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
        PWD.TipoEstrategiaID,
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
        PC.CodigoTipoOferta,
        TE.Codigo
      FROM dbo.PedidoWebDetalle PWD WITH (NOLOCK)
      INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK)
        ON PW.CampaniaID = PWD.CampaniaID
        AND PW.PedidoID = PWD.PedidoID
        AND PW.ConsultoraID = PWD.ConsultoraID
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
        ON PC.CodigoProducto = MC.CodigoSAP
      LEFT JOIN dbo.Marca M WITH (NOLOCK)
        ON PWD.MarcaId = M.MarcaId
      LEFT JOIN TipoEstrategia TE
        ON PWD.TipoEstrategiaID = TE.TipoEstrategiaID
      WHERE pwd.CampaniaID = @CampaniaID
      AND pwd.ConsultoraID = @ConsultoraID
      AND pwd.CUVPadre IS NULL
    --AND PWD.TipoEstrategiaID NOT IN (SELECT
    --  tipoestrategiaid
    --FROM tipoestrategia
    --WHERE codigo IN ('001', '030', '008', '007', '005', '010', '002', '011'))

    DECLARE @Estrategia2 AS TABLE (
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

    INSERT INTO @Estrategia2
      SELECT DISTINCT
        E.EstrategiaID,
        TE.TipoEstrategiaID,
        E.Activo,
        E.CampaniaID,
        E.CampaniaIDFin,
        E.CUV2,
        E.Numeropedido,
        E.DescripcionCUV2,
        E.EsOfertaIndependiente,
        COALESCE(TEP.FlagNueva, TE.FlagNueva),
        COALESCE(TEP.NombreComercial, TE.NombreComercial),
        COALESCE(TEP.Codigo, TE.Codigo),
        COALESCE(TEP.CodigoPrograma, TE.CodigoPrograma)
      FROM dbo.Estrategia E WITH (NOLOCK)
      INNER JOIN TipoEstrategia TE WITH (NOLOCK)
        ON TE.TipoEstrategiaID = E.TipoEstrategiaID
      INNER JOIN @PedidoDetalle2 PWD
        ON PWD.CampaniaID BETWEEN E.CampaniaID
        AND CASE
          WHEN ISNULL(E.CampaniaIDFin, 0) = 0 THEN E.CampaniaID
          ELSE E.CampaniaIDFin
        END
        AND E.CUV2 = PWD.CUV
        AND E.Activo = 1
        AND PWD.CodigoTipoEstrategia NOT IN ('001', '030', '008', '007', '005', '010', '002', '011')
      LEFT JOIN TipoEstrategia TEP WITH (NOLOCK)
        ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
      WHERE TE.FlagActivo = 1

      UNION

      SELECT
        EP.EstrategiaProductoId,
        TE.TipoEstrategiaID,
        E.Activo,
        E.CampaniaID,
        E.CampaniaIDFin,
        EP.CUV,
        E.Numeropedido,
        NULL AS DescripcionEstrategia,
        E.EsOfertaIndependiente,
        COALESCE(TEP.FlagNueva, TE.FlagNueva),
        COALESCE(TEP.NombreComercial, TE.NombreComercial),
        COALESCE(TEP.Codigo, TE.Codigo),
        COALESCE(TEP.CodigoPrograma, TE.CodigoPrograma)
      FROM dbo.EstrategiaProducto EP
      INNER JOIN dbo.Estrategia E WITH (NOLOCK)
        ON EP.EstrategiaID = E.EstrategiaID
      INNER JOIN TipoEstrategia TE WITH (NOLOCK)
        ON TE.TipoEstrategiaID = E.TipoEstrategiaID
      INNER JOIN @PedidoDetalle2 PWD
        ON PWD.CampaniaID = EP.Campania
        AND EP.CUV = PWD.CUV
        AND EP.CUV2 != PWD.CUV
        AND PWD.CodigoTipoEstrategia NOT IN ('001', '030', '008', '007', '005', '010', '002', '011')
      LEFT JOIN TipoEstrategia TEP WITH (NOLOCK)
        ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
      WHERE TE.FlagActivo = 1

    IF @CodigoPrograma IS NOT NULL
    BEGIN
      DELETE FROM @Estrategia2
      WHERE ISNULL(CodigoPrograma, '') <> ''
        AND Numeropedido <> @NumeroPedido
    END
    SELECT
      *
    FROM (SELECT
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
      COALESCE(EST.DescripcionEstrategia, PWD.DescripcionProd) AS DescripcionProd,
      PWD.ClienteNombre AS Nombre,
      PWD.OfertaWeb,
      PWD.IndicadorMontoMinimo,
      ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID,
      ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID,
      ISNULL(PWD.TipoPedido, 'W') TipoPedido,
      PWD.MarcaDescripcion AS DescripcionLarga,
      'NO DISPONIBLE' AS Categoria,
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
      EST.DescripcionTipoEstrategia AS DescripcionOferta,
      EST.DescripcionTipoEstrategia AS DescripcionEstrategia,
      CASE
        WHEN EST.FlagNueva = 1 AND
          @CodigoPrograma IS NOT NULL THEN 1
        ELSE 0
      END AS FlagNueva,
      EST.TipoEstrategiaCodigo,
      EST.EsOfertaIndependiente,
      EST.EstrategiaID,
      EST.TipoEstrategiaID,
      EST.Numeropedido,
      0 AS SetID
    FROM @PedidoDetalle2 PWD
    LEFT JOIN @Estrategia2 EST
      ON EST.CUV2 = PWD.CUV
      AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
    WHERE PWD.CodigoTipoEstrategia NOT IN ('001', '030', '008', '007', '005', '010', '002', '011')
    --ORDER BY PWD.OrdenPedidoWD DESC
    --	,PWD.PedidoDetalleID DESC

    UNION

    SELECT
      PWS.Campania,
      PWS.PedidoID,
      0 AS PedidoDetalleID,
      0 AS MarcaID,
      PWS.ConsultoraId,
      NULL AS ClienteID,
      MAX(PWS.OrdenPedido) AS OrdenPedidoWD,
      PWS.Cantidad,
      PWS.PrecioUnidad,
      PWs.ImporteTotal,
      PWS.CuvSet AS CUV,
      0 AS EsKiNueva,
      PWS.NombreSet AS DescripcionProd,
      NULL AS Nombre,
      PWD.OfertaWeb,
      --PC.IndicadorMontoMinimo,
      PWD.IndicadorMontoMinimo,
      ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID,
      ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID
      --,M.Descripcion AS MarcaDescripcion
      ,
      ISNULL(PWD.TipoPedido, 'W') TipoPedido,
      NULL AS MarcaDescripcion,
      'NO DISPONIBLE' AS Categoria,
      --PC.IndicadorOferta AS IndicadorOfertaCUV,
      PWD.IndicadorOfertaCUV,
      0 AS FlagConsultoraOnline,
      --PW.DescuentoProl,
      --PW.MontoEscala,
      --PW.MontoAhorroCatalogo,
      --PW.MontoAhorroRevista,
      PWD.DescuentoProl,
      PWD.MontoEscala,
      PWD.MontoAhorroCatalogo,
      PWD.MontoAhorroRevista,
      PWD.OrigenPedidoWeb,
      ISNULL(PWD.EsBackOrder, 0) AS EsBackOrder,
      ISNULL(PWD.AceptoBackOrder, 0) AS AceptoBackOrder,
      --PC.CodigoCatalago,
      PWD.CodigoCatalago,
      '' AS DescripcionOferta,
      '' AS DescripcionEstrategia,
      CASE
        WHEN COALESCE(TEP.FlagNueva, TE.FlagNueva) = 1 AND
          @CodigoPrograma IS NOT NULL THEN 1
        ELSE 0
      END AS FlagNueva,
      COALESCE(TEP.Codigo, TE.Codigo) AS TipoEstrategiaCodigo,
      EST.EsOfertaIndependiente,
      EST.EstrategiaID,
      EST.TipoEstrategiaID,
      EST.Numeropedido,
      PWS.SetID
    FROM PedidoWebSet PWS

    --INNER JOIN PedidoWeb PW WITH (NOLOCK)
    --  ON PW.CampaniaId = PWS.Campania
    --  AND PWS.PedidoID = PW.PedidoID --PWS.PedidoID = PW.PedidoID
    INNER JOIN PedidoWebSetDetalle PWSD
      ON PWSD.SetID = PWS.SetID
    --INNER JOIN PedidoWebDetalle PWD WITH (NOLOCK)
    --  ON PW.CampaniaId = PWD.CampaniaId
    --  AND PWD.PedidoID = PW.PedidoID
    --  AND PWSD.CuvProducto = PWD.CUV --PWD.PedidoID = PW.PedidoID and PWSD.CuvProducto =PWD.CUV
    INNER JOIN @PedidoDetalle2 PWD
      ON PWS.Campania = PWD.CampaniaId
      AND PWS.PedidoID = PWD.PedidoID
      AND PWSD.CuvProducto = PWD.CUV --PWD.PedidoID = PW.PedidoID and PWSD.CuvProducto =PWD.CUV

    --INNER JOIN PedidoWeb PW ON  PWS.PedidoID = PW.PedidoID
    --inner join PedidoWebSetDetalle PWSD on PWSD.SetID=PWS.SetID
    --INNER JOIN PedidoWebDetalle PWD ON PWD.PedidoID = PW.PedidoID and PWSD.CuvProducto =PWD.CUV


    --INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
    --  ON PWD.CampaniaID = PC.AnoCampania
    --  AND PWD.CUV = PC.CUV
    INNER JOIN Estrategia EST WITH (NOLOCK)
      ON PWS.EstrategiaID = EST.EstrategiaID
    INNER JOIN TipoEstrategia TE WITH (NOLOCK)
      ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
    LEFT JOIN TipoEstrategia TEP WITH (NOLOCK)
      ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID

    WHERE PWS.Campania = @CampaniaID
    AND PWS.ConsultoraID = @ConsultoraID
    GROUP BY PWS.Campania,
             PWS.PedidoID,
             PWS.ConsultoraId,
             ClienteID,
             PWS.Cantidad,
             PWS.PrecioUnidad,
             PWs.ImporteTotal,
             PWD.OfertaWeb,
             --PC.IndicadorMontoMinimo,
             PWD.IndicadorMontoMinimo,
             PWS.CuvSet,
             PWS.NombreSet,
             PWD.ConfiguracionOfertaID,
             PWD.TipoOfertaSisID,
             PWD.TipoPedido,
             --PC.IndicadorOferta,
             PWD.IndicadorOfertaCUV,
             --PW.DescuentoProl,
             --PW.MontoEscala,
             --PW.MontoAhorroCatalogo,
             --PW.MontoAhorroRevista,
             PWD.DescuentoProl,
             PWD.MontoEscala,
             PWD.MontoAhorroCatalogo,
             PWD.MontoAhorroRevista,
             PWD.OrigenPedidoWeb,
             PWD.EsBackOrder,
             PWD.AceptoBackOrder,
             --PC.CodigoCatalago,
             PWD.CodigoCatalago,
             TEP.FlagNueva,
             TE.FlagNueva,
             TEP.Codigo,
             TE.Codigo,
             EST.EsOfertaIndependiente,
             EST.EstrategiaID,
             EST.TipoEstrategiaID,
             EST.Numeropedido,
             PWS.SetID) Agrupado
    ORDER BY Agrupado.OrdenPedidoWD DESC
    , Agrupado.PedidoDetalleID DESC

  END
  ELSE
  BEGIN

    SET NOCOUNT ON
    SET @CodigoPrograma =
                         CASE
                           WHEN @CodigoPrograma = '' THEN NULL
                           ELSE @CodigoPrograma
                         END
    SET @NumeroPedido =
                       CASE
                         WHEN @NumeroPedido > 0 THEN @NumeroPedido + 1
                         ELSE 0
                       END

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
      PRIMARY KEY (
      CampaniaID, PedidoID, PedidoDetalleID
      )
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
        COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PC.Descripcion) AS DescripcionProd,
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
        PWD.TipoEstrategiaID,
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
        AND PW.ConsultoraID = PWD.ConsultoraID
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
        ON PC.CodigoProducto = MC.CodigoSAP
      LEFT JOIN dbo.Marca M WITH (NOLOCK)
        ON PWD.MarcaId = M.MarcaId
      WHERE pwd.CampaniaID = @CampaniaID
      AND pwd.ConsultoraID = @ConsultoraID
      AND pwd.CUVPadre IS NULL

    DECLARE @Estrategia AS TABLE (
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
        TE.TipoEstrategiaID,
        E.Activo,
        E.CampaniaID,
        E.CampaniaIDFin,
        E.CUV2,
        E.Numeropedido,
        E.DescripcionCUV2,
        E.EsOfertaIndependiente,
        COALESCE(TEP.FlagNueva, TE.FlagNueva),
        COALESCE(TEP.NombreComercial, TE.NombreComercial),
        COALESCE(TEP.Codigo, TE.Codigo),
        COALESCE(TEP.CodigoPrograma, TE.CodigoPrograma)
      FROM dbo.Estrategia E WITH (NOLOCK)
      INNER JOIN TipoEstrategia TE WITH (NOLOCK)
        ON TE.TipoEstrategiaID = E.TipoEstrategiaID
      INNER JOIN @PedidoDetalle PWD
        ON PWD.CampaniaID BETWEEN E.CampaniaID
        AND CASE
          WHEN ISNULL(E.CampaniaIDFin, 0) = 0 THEN E.CampaniaID
          ELSE E.CampaniaIDFin
        END
        AND E.CUV2 = PWD.CUV
        AND E.Activo = 1
      LEFT JOIN TipoEstrategia TEP WITH (NOLOCK)
        ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
      WHERE TE.FlagActivo = 1

      UNION

      SELECT
        EP.EstrategiaProductoId,
        TE.TipoEstrategiaID,
        E.Activo,
        E.CampaniaID,
        E.CampaniaIDFin,
        EP.CUV,
        E.Numeropedido,
        NULL AS DescripcionEstrategia,
        E.EsOfertaIndependiente,
        COALESCE(TEP.FlagNueva, TE.FlagNueva),
        COALESCE(TEP.NombreComercial, TE.NombreComercial),
        COALESCE(TEP.Codigo, TE.Codigo),
        COALESCE(TEP.CodigoPrograma, TE.CodigoPrograma)
      FROM dbo.EstrategiaProducto EP
      INNER JOIN dbo.Estrategia E WITH (NOLOCK)
        ON EP.EstrategiaID = E.EstrategiaID
      INNER JOIN TipoEstrategia TE WITH (NOLOCK)
        ON TE.TipoEstrategiaID = E.TipoEstrategiaID
      INNER JOIN @PedidoDetalle PWD
        ON PWD.CampaniaID = EP.Campania
        AND EP.CUV = PWD.CUV
        AND EP.CUV2 != PWD.CUV
      LEFT JOIN TipoEstrategia TEP WITH (NOLOCK)
        ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
      WHERE TE.FlagActivo = 1

    IF @CodigoPrograma IS NOT NULL
    BEGIN
      DELETE FROM @Estrategia
      WHERE ISNULL(CodigoPrograma, '') <> ''
        AND Numeropedido <> @NumeroPedido
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
      COALESCE(EST.DescripcionEstrategia, PWD.DescripcionProd) AS DescripcionProd,
      PWD.ClienteNombre AS Nombre,
      PWD.OfertaWeb,
      PWD.IndicadorMontoMinimo,
      ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID,
      ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID,
      ISNULL(PWD.TipoPedido, 'W') TipoPedido,
      PWD.MarcaDescripcion AS DescripcionLarga,
      'NO DISPONIBLE' AS Categoria,
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
      EST.DescripcionTipoEstrategia AS DescripcionOferta,
      EST.DescripcionTipoEstrategia AS DescripcionEstrategia,
      CASE
        WHEN EST.FlagNueva = 1 AND
          @CodigoPrograma IS NOT NULL THEN 1
        ELSE 0
      END AS FlagNueva,
      EST.TipoEstrategiaCodigo,
      EST.EsOfertaIndependiente,
      EST.EstrategiaID,
      EST.TipoEstrategiaID,
      EST.Numeropedido,
      0 AS SetID
    FROM @PedidoDetalle PWD
    LEFT JOIN @Estrategia EST
      ON EST.CUV2 = PWD.CUV
      AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
    ORDER BY PWD.OrdenPedidoWD DESC
    , PWD.PedidoDetalleID DESC

  END


END
GO