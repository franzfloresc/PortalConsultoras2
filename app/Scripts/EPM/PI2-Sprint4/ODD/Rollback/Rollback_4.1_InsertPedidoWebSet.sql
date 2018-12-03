USE [BelcorpChile_BPT]
GO

--USE [BelcorpPeru_BPT]
--GO

--USE [BelcorpCostaRica_BPT]
--GO

ALTER PROCEDURE [dbo].[InsertPedidoWebSet] (
  @Campaniaid int
, @PedidoID int
, @CantidadSet int
, @CuvSet varchar(20)
, @ConsultoraId bigint
, @CodigoUsuario varchar(25)
, @EstrategiaID int
, @CuvsStringList varchar(max))
AS
BEGIN

  -------
  DECLARE @NuevoSetID int
  DECLARE @ActualSetID int
  DECLARE @NombreSet nvarchar(800)
  DECLARE @TipoEstrategiaId int
  DECLARE @Precio2 money
  DECLARE @CantidadCuvs int
  DECLARE @SetExiste bit = 0
  DECLARE @SetParecidosIdList AS TABLE (
    SetId int
  )
  DECLARE @CuvsAgregar AS TABLE (
    Cuv nvarchar(50),
    Cantidad int
  )
  DECLARE @OrdenSet int
  ------------------------------------------

  IF (@EstrategiaID = 0)
  BEGIN
    SELECT
      @EstrategiaID = EstrategiaID
    FROM estrategia
    WHERE campaniaid = @Campaniaid
    AND cuv2 = @CuvSet
  END

  IF (@PedidoID = 0)
  BEGIN
    SELECT
      @PedidoID = PedidoID
    FROM PedidoWeb
    WHERE CampaniaID = @Campaniaid
    AND ConsultoraID = @ConsultoraId
  END


  IF (LEN(@CuvsStringList) > 0)
  BEGIN

    IF (SUBSTRING(@CuvsStringList, LEN(@CuvsStringList), 1) = ',')
      SET @CuvsStringList = SUBSTRING(@CuvsStringList, 0, LEN(@CuvsStringList))
  END



  INSERT INTO @CuvsAgregar (Cuv
  , Cantidad)
    (
    SELECT
      SUBSTRING(item, 0, CHARINDEX(':', item)),
      SUBSTRING(item, CHARINDEX(':', item) + 1, LEN(item))
    FROM SplitString(@CuvsStringList, ',')
    WHERE SUBSTRING(item, CHARINDEX(':', item) + 1, LEN(item)) != 0
    )


  SELECT
    @OrdenSet = MAX(OrdenPedidoWD)
  FROM pedidoWebDetalle
  WHERE PedidoID = @PedidoID
  AND cuv IN (SELECT
    Cuv
  FROM @CuvsAgregar)
  AND campaniaid = @campaniaid

  IF (
    EXISTS (SELECT
      setid
    FROM PedidoWebSet
    WHERE cuvset = @CuvSet
    AND consultoraid = @ConsultoraId
    AND Campania = @campaniaid)
    )
  BEGIN
    INSERT INTO @SetParecidosIdList (SetId)
      (SELECT
        setid
      FROM PedidoWebSet
      WHERE cuvset = @CuvSet
      AND consultoraid = @ConsultoraId
      AND Campania = @campaniaid)
  END

  WHILE EXISTS (SELECT
      setid
    FROM @SetParecidosIdList)
  BEGIN
    DECLARE @StrCuvCantidad nvarchar(max)

    SELECT TOP 1
      @ActualSetID = setid
    FROM @SetParecidosIdList

    SET @StrCuvCantidad = (SELECT
      STUFF((SELECT
        ',' + cuvproducto + ':' + CAST(CantidadOriginal AS varchar(6))
      FROM PedidoWebSetDetalle
      WHERE setid = @ActualSetID
      ORDER BY cuvproducto DESC
      FOR xml PATH (''))
      , 1, 1, ''))

    IF (@StrCuvCantidad = @CuvsStringList)
    BEGIN
      SET @SetExiste = 1

      DELETE FROM @SetParecidosIdList
    END

    DELETE FROM @SetParecidosIdList
    WHERE SetId = @ActualSetID
  END

  SELECT
    @NombreSet = DescripcionCUV2,
    @Precio2 = Precio2,
    @TipoEstrategiaId = TipoEstrategiaId
  FROM estrategia
  WHERE estrategiaID = @EstrategiaID

  SET @CantidadCuvs = (SELECT
    COUNT(Item)
  FROM SplitString(@CuvsStringList, ','))


  IF (EXISTS (SELECT
      tipoestrategiaid
    FROM tipoestrategia
    WHERE codigo IN ('001', '030', '008', '007', '005', '010')
    AND tipoestrategiaid = @TipoEstrategiaID)
    )
  BEGIN


    IF (@SetExiste = '0')
    BEGIN
      INSERT INTO [dbo].[PedidoWebSet] ([PedidoID]
      , [CuvSet]
      , EstrategiaId
      , [NombreSet]
      , [Cantidad]
      , [PrecioUnidad]
      , [ImporteTotal]
      , [TipoEstrategiaId]
      , [Campania]
      , [ConsultoraID]
      , [OrdenPedido]
      , [CodigoUsuarioCreacion]
      , [CodigoUsuarioModificacion]
      , [FechaCreacion]
      , [FechaModificacion])
        VALUES (@PedidoID, @CuvSet, @EstrategiaID, @NombreSet, @CantidadSet, @Precio2, @Precio2 * @CantidadSet, @TipoEstrategiaId, @Campaniaid, @ConsultoraId, @OrdenSet, @CodigoUsuario, NULL, SYSDATETIME(), NULL)

      SET @NuevoSetID = @@IDENTITY


      INSERT INTO [dbo].[PedidoWebSetDetalle] ([SetID]
      , [CuvProducto]
      , [NombreProducto]
      , CantidadOriginal
      , [Cantidad]
      , [FactorRepeticion]
      , [PedidoDetalleID]
      , PrecioUnidad
      , TipoOfertaSisID)
        (
        SELECT
          @NuevoSetID,
          CUV,
          NULL,
          (SELECT
            cantidad
          FROM @CuvsAgregar c1
          WHERE c1.cuv = pwd.cuv),
          (SELECT
            cantidad
          FROM @CuvsAgregar c1
          WHERE c1.cuv = pwd.cuv)
          * @CantidadSet,
          (SELECT
            cantidad
          FROM @CuvsAgregar c1
          WHERE c1.cuv = pwd.cuv),
          PedidoDetalleID,
          PrecioUnidad,
          TipoOfertaSisID
        FROM pedidowebdetalle pwd
        WHERE pwd.cuv IN (SELECT
          cuv
        FROM @CuvsAgregar)
        AND pwd.campaniaid = @Campaniaid
        AND pwd.pedidoid = @PedidoID

        )
    END
    ELSE
    BEGIN
      UPDATE PedidoWebSet
      SET cantidad = cantidad + @CantidadSet,
          ImporteTotal = (cantidad + @CantidadSet) * PrecioUnidad,
          OrdenPedido = @OrdenSet
      WHERE setid = @ActualSetID

      UPDATE PedidoWebSetdetalle
      SET cantidad = cantidad + FactorRepeticion * @CantidadSet
      WHERE setid = @ActualSetID
    END

  END
END

