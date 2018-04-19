USE belcorpMexico_pl50
GO
IF (OBJECT_ID('dbo.InsertPedidoWebSet', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertPedidoWebSet AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE InsertPedidoWebSet (
	@Campaniaid INT
	,@PedidoID INT
	,@CantidadSet INT
	,@CuvSet VARCHAR(20)
	,@ConsultoraId BIGINT
	,@CodigoUsuario VARCHAR(25)
	,@EstrategiaID int
	,@CuvsStringList VARCHAR(max)
	)
AS
BEGIN

	-------
	DECLARE @NuevoSetID INT
	DECLARE @ActualSetID INT
	DECLARE @NombreSet NVARCHAR(800)
	DECLARE @TipoEstrategiaId INT
	DECLARE @Precio2 MONEY
	DECLARE @CantidadCuvs INT
	DECLARE @SetExiste BIT = 0
	DECLARE @SetParecidosIdList AS TABLE (SetId INT)
	DECLARE @CuvsAgregar AS TABLE (
		Cuv NVARCHAR(50)
		,Cantidad INT
		)
	DECLARE @OrdenSet INT
	------------------------------------------

	if(@EstrategiaID=0)
	begin
		select @EstrategiaID = EstrategiaID from estrategia where campaniaid= @Campaniaid and  cuv2 =@CuvSet
	end

	if(@PedidoID=0)
	begin
		select @PedidoID = PedidoID from PedidoWeb where CampaniaID= @Campaniaid and  ConsultoraID =@ConsultoraId 
	end


	if(len(@CuvsStringList)>0)
	begin	

	if(substring(@CuvsStringList,len(@CuvsStringList),1)=',')
		set @CuvsStringList = substring(@CuvsStringList,0,len(@CuvsStringList))
	end

	

	INSERT INTO @CuvsAgregar (
		Cuv
		,Cantidad
		) (
		SELECT substring(item, 0, CHARINDEX(':', item))
		,substring(item, CHARINDEX(':', item) + 1, len(item)) FROM SplitString(@CuvsStringList, ',') where substring(item, CHARINDEX(':', item) + 1, len(item)) !=0
		)


		select @OrdenSet=max(OrdenPedidoWD) from pedidoWebDetalle where PedidoID=@PedidoID and cuv in ( select Cuv from @CuvsAgregar) and campaniaid = @campaniaid

	IF (
			EXISTS (
				SELECT setid
				FROM PedidoWebSet
				WHERE cuvset = @CuvSet  and consultoraid= @ConsultoraId and Campania= @campaniaid
				)
			)
	BEGIN
		INSERT INTO @SetParecidosIdList (SetId) (SELECT setid FROM PedidoWebSet WHERE cuvset = @CuvSet  and consultoraid= @ConsultoraId and Campania= @campaniaid)
	END

	WHILE EXISTS (
			SELECT setid
			FROM @SetParecidosIdList
			)
	BEGIN
		DECLARE @StrCuvCantidad NVARCHAR(max)

		SELECT TOP 1 @ActualSetID = setid
		FROM @SetParecidosIdList

		SET @StrCuvCantidad = (
				SELECT STUFF((
							SELECT ',' + cuvproducto + ':' + cast(CantidadOriginal AS VARCHAR(6))
							FROM PedidoWebSetDetalle
							WHERE setid = @ActualSetID order by cuvproducto desc
							FOR XML PATH('')
							), 1, 1, '')
				)

		IF (@StrCuvCantidad = @CuvsStringList)
		BEGIN
			SET @SetExiste = 1

			DELETE
			FROM @SetParecidosIdList
		END

		DELETE
		FROM @SetParecidosIdList
		WHERE SetId = @ActualSetID
	END
	 
	SELECT @NombreSet = DescripcionCUV2
		,@Precio2 = Precio2
		,@TipoEstrategiaId = TipoEstrategiaId
	FROM estrategia
	WHERE estrategiaID = @EstrategiaID 

	SET @CantidadCuvs = (
			SELECT count(Item)
			FROM SplitString(@CuvsStringList, ',')
			)
			 

	if(exists(select tipoestrategiaid from tipoestrategia where codigo in ('001','030','008','007','005','010') and tipoestrategiaid =@TipoEstrategiaID ))
	begin


				IF (@SetExiste = '0')
				BEGIN
					INSERT INTO [dbo].[PedidoWebSet] (
						[PedidoID]
						,[CuvSet]
						,EstrategiaId
						,[NombreSet]
						,[Cantidad]
						,[PrecioUnidad]
						,[ImporteTotal]
						,[TipoEstrategiaId]
						,[Campania]
						,[ConsultoraID]
						,[OrdenPedido]
						,[CodigoUsuarioCreacion]
						,[CodigoUsuarioModificacion]
						,[FechaCreacion]
						,[FechaModificacion]
						)
					VALUES (
						@PedidoID
						,@CuvSet
						,@EstrategiaID
						,@NombreSet
						,@CantidadSet
						,@Precio2
						,@Precio2*@CantidadSet
						,@TipoEstrategiaId
						,@Campaniaid
						,@ConsultoraId
						,@OrdenSet
						,@CodigoUsuario
						,NULL
						,sysdatetime()
						,NULL
						)

					SET @NuevoSetID = @@IDENTITY

					 
					INSERT INTO [dbo].[PedidoWebSetDetalle] (
						[SetID]
						,[CuvProducto]
						,[NombreProducto]
						,CantidadOriginal
						,[Cantidad]
						,[FactorRepeticion]
						,[PedidoDetalleID]
						,PrecioUnidad
						,TipoOfertaSisID) 
						(
						SELECT @NuevoSetID
						,CUV
						,null
						,(
							SELECT cantidad
							FROM @CuvsAgregar c1
							WHERE c1.cuv = pwd.cuv
							)
						,(
							SELECT cantidad
							FROM @CuvsAgregar c1
							WHERE c1.cuv = pwd.cuv
							)*@CantidadSet
						,(
							SELECT cantidad
							FROM @CuvsAgregar c1
							WHERE c1.cuv = pwd.cuv
							)
						,PedidoDetalleID
						,PrecioUnidad
						,TipoOfertaSisID FROM pedidowebdetalle pwd WHERE pwd.cuv IN (
							SELECT cuv
							FROM @CuvsAgregar
							)
						AND pwd.campaniaid = @Campaniaid
						AND pwd.pedidoid = @PedidoID
			
						)
				END
				ELSE
				BEGIN
					UPDATE PedidoWebSet
					SET cantidad = cantidad + @CantidadSet,ImporteTotal=(cantidad + @CantidadSet)*PrecioUnidad,OrdenPedido=@OrdenSet
					WHERE setid = @ActualSetID

					UPDATE PedidoWebSetdetalle
					SET cantidad = cantidad + FactorRepeticion * @CantidadSet
					WHERE setid = @ActualSetID
				END

	end
END
GO