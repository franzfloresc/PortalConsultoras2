
use BelcorpBolivia
go

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



BEGIN

	DECLARE @CUVPadre VARCHAR(10)

	

	SET @CUVPadre = @CUV



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



			SET @ItemsPedido = @Cantidad - (

					SELECT isnull((

								SELECT isnull(cantidad, 0)

								FROM pedidowebdetalle

								WHERE cuv = @CUVPadre

									AND campaniaid = @campaniaid

									AND consultoraid = @consultoraid

								), 0)

					)

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

go



use BelcorpChile
go

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



BEGIN

	DECLARE @CUVPadre VARCHAR(10)

	

	SET @CUVPadre = @CUV



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



			SET @ItemsPedido = @Cantidad - (

					SELECT isnull((

								SELECT isnull(cantidad, 0)

								FROM pedidowebdetalle

								WHERE cuv = @CUVPadre

									AND campaniaid = @campaniaid

									AND consultoraid = @consultoraid

								), 0)

					)

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

go


use BelcorpColombia
go

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



BEGIN

	DECLARE @CUVPadre VARCHAR(10)

	

	SET @CUVPadre = @CUV



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



			SET @ItemsPedido = @Cantidad - (

					SELECT isnull((

								SELECT isnull(cantidad, 0)

								FROM pedidowebdetalle

								WHERE cuv = @CUVPadre

									AND campaniaid = @campaniaid

									AND consultoraid = @consultoraid

								), 0)

					)

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

go


use BelcorpCostaRica
go

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



BEGIN

	DECLARE @CUVPadre VARCHAR(10)

	

	SET @CUVPadre = @CUV



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



			SET @ItemsPedido = @Cantidad - (

					SELECT isnull((

								SELECT isnull(cantidad, 0)

								FROM pedidowebdetalle

								WHERE cuv = @CUVPadre

									AND campaniaid = @campaniaid

									AND consultoraid = @consultoraid

								), 0)

					)

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

go


use BelcorpDominicana
go

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



BEGIN

	DECLARE @CUVPadre VARCHAR(10)

	

	SET @CUVPadre = @CUV



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



			SET @ItemsPedido = @Cantidad - (

					SELECT isnull((

								SELECT isnull(cantidad, 0)

								FROM pedidowebdetalle

								WHERE cuv = @CUVPadre

									AND campaniaid = @campaniaid

									AND consultoraid = @consultoraid

								), 0)

					)

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

go


use BelcorpEcuador
go

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



BEGIN

	DECLARE @CUVPadre VARCHAR(10)

	

	SET @CUVPadre = @CUV



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



			SET @ItemsPedido = @Cantidad - (

					SELECT isnull((

								SELECT isnull(cantidad, 0)

								FROM pedidowebdetalle

								WHERE cuv = @CUVPadre

									AND campaniaid = @campaniaid

									AND consultoraid = @consultoraid

								), 0)

					)

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

go


use BelcorpGuatemala
go

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



BEGIN

	DECLARE @CUVPadre VARCHAR(10)

	

	SET @CUVPadre = @CUV



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



			SET @ItemsPedido = @Cantidad - (

					SELECT isnull((

								SELECT isnull(cantidad, 0)

								FROM pedidowebdetalle

								WHERE cuv = @CUVPadre

									AND campaniaid = @campaniaid

									AND consultoraid = @consultoraid

								), 0)

					)

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

go


use BelcorpSalvador
go

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



BEGIN

	DECLARE @CUVPadre VARCHAR(10)

	

	SET @CUVPadre = @CUV



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



			SET @ItemsPedido = @Cantidad - (

					SELECT isnull((

								SELECT isnull(cantidad, 0)

								FROM pedidowebdetalle

								WHERE cuv = @CUVPadre

									AND campaniaid = @campaniaid

									AND consultoraid = @consultoraid

								), 0)

					)

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

go


use BelcorpMexico
go

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



BEGIN

	DECLARE @CUVPadre VARCHAR(10)

	

	SET @CUVPadre = @CUV



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



			SET @ItemsPedido = @Cantidad - (

					SELECT isnull((

								SELECT isnull(cantidad, 0)

								FROM pedidowebdetalle

								WHERE cuv = @CUVPadre

									AND campaniaid = @campaniaid

									AND consultoraid = @consultoraid

								), 0)

					)

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

go


use BelcorpPanama
go

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



BEGIN

	DECLARE @CUVPadre VARCHAR(10)

	

	SET @CUVPadre = @CUV



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



			SET @ItemsPedido = @Cantidad - (

					SELECT isnull((

								SELECT isnull(cantidad, 0)

								FROM pedidowebdetalle

								WHERE cuv = @CUVPadre

									AND campaniaid = @campaniaid

									AND consultoraid = @consultoraid

								), 0)

					)

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

go


use BelcorpPeru
go

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



BEGIN

	DECLARE @CUVPadre VARCHAR(10)

	

	SET @CUVPadre = @CUV



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



			SET @ItemsPedido = @Cantidad - (

					SELECT isnull((

								SELECT isnull(cantidad, 0)

								FROM pedidowebdetalle

								WHERE cuv = @CUVPadre

									AND campaniaid = @campaniaid

									AND consultoraid = @consultoraid

								), 0)

					)

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

go


use BelcorpPuertoRico
go

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



BEGIN

	DECLARE @CUVPadre VARCHAR(10)

	

	SET @CUVPadre = @CUV



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



			SET @ItemsPedido = @Cantidad - (

					SELECT isnull((

								SELECT isnull(cantidad, 0)

								FROM pedidowebdetalle

								WHERE cuv = @CUVPadre

									AND campaniaid = @campaniaid

									AND consultoraid = @consultoraid

								), 0)

					)

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

go
