USE [BelcorpPeru_GANA]
GO

ALTER PROCEDURE [dbo].[InsertPedidoWebSet2] (@Campaniaid int
, @PedidoID int
, @CantidadSet int
, @CuvSet varchar(20)
, @ConsultoraId bigint
, @CodigoUsuario varchar(25)
, @ClienteID int
, @EstrategiaID int
, @TipoEstrategiaID int
, @CuvsStringList xml
)
AS
BEGIN

	-------
	DECLARE @NuevoSetID int
	DECLARE @ActualSetID int
	DECLARE @NombreSet nvarchar(800)
	DECLARE @Precio2 money
	DECLARE @CantidadCuvs int
	DECLARE @SetExiste bit = 0
	DECLARE @SetParecidosIdList AS TABLE (
	SetId int
	)
	DECLARE @CuvsAgregar AS TABLE (
	Cuv varchar(20),
	Digitable int,
	Grupo int,
	Cantidad int
	)
	DECLARE @OrdenSet int
	DECLARE @CantidadItemsaAgregar int
	DECLARE @CodigoEstrategia varchar(20) = ''
	------------------------------------------
	IF(@EstrategiaID = 0)
	BEGIN
	SELECT TOP 1 @EstrategiaID = ISNULL(EstrategiaID,0), @Precio2 = Precio2, @CodigoEstrategia = CodigoEstrategia FROM Estrategia WHERE CUV2 = @CuvSet AND TipoEstrategiaId = @TipoEstrategiaId 
			AND @Campaniaid BETWEEN CampaniaID AND CASE 
						WHEN ISNULL(CampaniaIDFin, 0) = 0
							THEN CampaniaID
						ELSE CampaniaIDFin
						END ORDER BY EstrategiaID DESC
	END
	ELSE
	BEGIN
	SELECT @Precio2 = Precio2, @CodigoEstrategia = CodigoEstrategia FROM Estrategia WHERE EstrategiaID = @EstrategiaID
	END

	IF(@EstrategiaID <> 0)
	BEGIN
		
		IF(@ClienteID = 0)
		SET @ClienteID = NULL

		IF (@PedidoID = 0)
		BEGIN
		SELECT
			@PedidoID = PedidoID
		FROM PedidoWeb
		WHERE CampaniaID = @Campaniaid
		AND ConsultoraID = @ConsultoraId
		END

		IF(@CodigoEstrategia = '2002')
		BEGIN
			INSERT INTO @CuvsAgregar (Cuv
			, Digitable
			, Grupo
			, Cantidad)
			SELECT
			Cuv,
			Digitable,
			Grupo,
			Cantidad
			FROM
			EstrategiaProducto WHERE EstrategiaId = @EstrategiaId
		END
		ELSE
		BEGIN
			INSERT INTO @CuvsAgregar (Cuv
			, Digitable
			, Grupo
			, Cantidad)
			SELECT
			componente.value('(CUV/text())[1]','VARCHAR(20)') AS Cuv,
			componente.value('(Digitable/text())[1]','integer') AS Digitable,
			componente.value('(Grupo/text())[1]','integer') AS Grupo,
			componente.value('(Cantidad/text())[1]','integer') AS Cantidad
			FROM
			@CuvsStringList.nodes('/ArrayOfEstrategiaComponente/EstrategiaComponente')AS TEMPTABLE(componente)
		END


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
		AND Campania = @campaniaid
		AND ISNULL(ClienteID,0) = ISNULL(@ClienteID,0))
		)
		BEGIN
		INSERT INTO @SetParecidosIdList (SetId)
			(SELECT
			setid
			FROM PedidoWebSet
			WHERE cuvset = @CuvSet
			AND consultoraid = @ConsultoraId
			AND Campania = @campaniaid
			AND ISNULL(ClienteID,0) = ISNULL(@ClienteID,0))
		END

		SELECT @CantidadItemsaAgregar = count(0) FROM @CuvsAgregar

		WHILE EXISTS (SELECT
			setid
		FROM @SetParecidosIdList)
		BEGIN
		DECLARE @CantidadItemsYaAgregados integer

		SELECT TOP 1
			@ActualSetID = setid
		FROM @SetParecidosIdList

		SELECT @CantidadItemsYaAgregados = COUNT(0) FROM @CuvsAgregar CA
		INNER JOIN (
			SELECT 
				CuvProducto as Cuv, 
				FactorRepeticion,
				Digitable,
				Grupo
			FROM PedidoWebSetDetalle
			WHERE SetID = @ActualSetID ) PWS
			ON CA.Cuv = PWS.Cuv 
			AND CA.Digitable = PWS.Digitable
			AND CA.Grupo = PWS.Grupo 
			AND CA.Cantidad = PWS.FactorRepeticion

		IF (@CantidadItemsaAgregar = @CantidadItemsYaAgregados)
		BEGIN
			SET @SetExiste = 1

			DELETE FROM @SetParecidosIdList
		END

		DELETE FROM @SetParecidosIdList
		WHERE SetId = @ActualSetID
		END
	
		IF (@SetExiste = '0')
		BEGIN
			INSERT INTO [dbo].[PedidoWebSet] ([PedidoID]
			, [CuvSet]
			, [EstrategiaId]
			--, [NombreSet]
			, [Cantidad]
			, [PrecioUnidad]
			, [ImporteTotal]
			--, [TipoEstrategiaId]
			, [Campania]
			, [ConsultoraID]
			, [ClienteID]
			, [OrdenPedido]
			, [CodigoUsuarioCreacion]
			, [CodigoUsuarioModificacion]
			, [FechaCreacion]
			, [FechaModificacion])
			VALUES (@PedidoID, @CuvSet, @EstrategiaID, @CantidadSet, @Precio2, @Precio2 * @CantidadSet, @Campaniaid, @ConsultoraId, @ClienteID, @OrdenSet, @CodigoUsuario, NULL, SYSDATETIME(), NULL)

			SET @NuevoSetID = @@IDENTITY


			INSERT INTO [dbo].[PedidoWebSetDetalle] ([SetID]
			, [CuvProducto]
			, [FactorRepeticion]
			, [Cantidad]
			, [PedidoDetalleID]
			, [PrecioUnidad]
			, [EstrategiaProductoId]
			, [Digitable]
			, [Grupo])
			(
			SELECT
				@NuevoSetID,
				ca.cuv,
				ca.cantidad,
				ca.cantidad
				* @CantidadSet,
				(select top 1 pwd.PedidoDetalleID from pedidowebdetalle pwd where pwd.cuv = ca.cuv
				and pwd.CampaniaID = @CampaniaID and pwd.pedidoid = @PedidoID and ISNULL(pwd.ClienteID,0) = ISNULL(@ClienteID,0)),
				--(select top 1 pwd.PrecioUnidad from pedidowebdetalle pwd where pwd.cuv = ca.cuv
				--and pwd.CampaniaID = @CampaniaID and pwd.pedidoid = @PedidoID and ISNULL(pwd.ClienteID,0) = ISNULL(@ClienteID,0)),
				ep.Precio,
				ep.EstrategiaProductoId,
				ca.Digitable,
				ca.Grupo
			FROM @CuvsAgregar ca
			LEFT JOIN estrategiaproducto ep ON ca.cuv = ep.cuv
			AND ep.Campania = @CampaniaID
			AND ep.CUV2 = @CuvSet
			AND ep.EstrategiaID = @EstrategiaID
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