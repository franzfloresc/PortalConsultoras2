
--

alter PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom (

	@CampaniaID INT

	,@CUV VARCHAR(10)

	,@ConsultoraID BIGINT

	)

AS

/*

ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom 201607, '99001', 8828

*/

DECLARE @Cantidad INT

DECLARE @ItemsPedido INT = 0

Declare @EstrategiaId INT =0


BEGIN

	DECLARE @CUVPadre VARCHAR(10)

	

	SET @CUVPadre = @CUV

	--es showroom con tono

	select   @EstrategiaId =  e.EstrategiaId from EstrategiaProducto ep
	inner join estrategia e on ep.EstrategiaId =  e.EstrategiaId
	where e.activo ='1' and ep.cuv= @CUV and ep.Campania = @CampaniaID and ep.activo='1'
	--

	-- Verificamos si el cuv a validar es una talla o color

	IF EXISTS (

			SELECT 1

			FROM TallaColorLiquidacion

			WHERE CampaniaID = @CampaniaID

				AND CUV = @CUV

			)

	BEGIN

		SET @CUVPadre = (

				SELECT CUVPadre

				FROM TallaColorLiquidacion

				WHERE CampaniaID = @CampaniaID

					AND CUV = @CUV

				)

	END



	PRINT '@CUVPadre'

	PRINT @CUVPadre



	SET @Cantidad = (

			SELECT isnull(e.LimiteVenta, 0)

			FROM dbo.Estrategia e

			INNER JOIN ods.campania c ON e.CampaniaID = c.Codigo

			INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID

			WHERE c.codigo = @CampaniaID

				AND e.cuv2 = @CUVPadre

			)



	PRINT '@Cantidad'

	PRINT @Cantidad



	IF @Cantidad IS NOT NULL

	BEGIN

		IF NOT EXISTS (

				SELECT CUV

				FROM TallaColorLiquidacion

				WHERE CampaniaID = @CampaniaID

					AND CUVPadre = @CUVPadre

				)

		BEGIN

			PRINT 'NO EXISTE'

			
			--si tiene tono
			if @EstrategiaId is not null
			begin
				SET @ItemsPedido = @Cantidad - (

					SELECT isnull((

								SELECT sum(isnull(cantidad, 0))

								FROM pedidowebdetalle

								 WHERE cuv in  (	select  cuv from EstrategiaProducto	where activo ='1' and estrategiaid =@EstrategiaId)
							 
									AND campaniaid = @campaniaid

									AND consultoraid = @consultoraid

								), 0)

					)
			end			
			---
			else
			begin

			SET @ItemsPedido = @Cantidad - (

					SELECT isnull((

								SELECT isnull(cantidad, 0)

								FROM pedidowebdetalle

								WHERE cuv = @CUVPadre

									AND campaniaid = @campaniaid

									AND consultoraid = @consultoraid

								), 0)

					)
			end

		END

		ELSE

		BEGIN

			PRINT 'EXISTE'



			SET @ItemsPedido = @Cantidad - (

					SELECT isnull((

								SELECT SUM(Cantidad)

								FROM pedidowebdetalle

								WHERE cuv IN (

										SELECT CUV

										FROM TallaColorLiquidacion

										WHERE CampaniaID = @CampaniaID

											AND CUVPadre = @CUVPadre

										)

									AND campaniaid = @campaniaid

									AND consultoraid = @consultoraid

								), 0)

					)

		END

	END



	SELECT @ItemsPedido

END


