IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ValidarStockEstrategia_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ValidarStockEstrategia_SB2
END
GO
CREATE PROCEDURE ValidarStockEstrategia_SB2
	@CUV VARCHAR(20),
	@CampaniaID INT,
	@CantidadPedida INT,
	@flagPedido INT,
	@ConsultoraID INT = NULL
AS
BEGIN
	DECLARE @NumeroPedido INT
	SELECT @NumeroPedido = consecutivonueva + 1
	FROM ods.Consultora
	WHERE ConsultoraID=@ConsultoraID
	
	DECLARE @ProgramaNuevoActivado INT
	SELECT @ProgramaNuevoActivado = COUNT(C.ConsultoraID)
	FROM ods.Consultora C
	INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora
	WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1	
	SET NOCOUNT ON;
	
	DECLARE @CantidadYaSolicitada INT, @CantidadSolicitante INT, @CantidadLimite INT, @mensaje VARCHAR(5000)
	IF EXISTS(SELECT 1 FROM Estrategia WHERE CampaniaID = @CampaniaID AND CUV2 = @CUV AND NumeroPedido = CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)
	BEGIN
		IF EXISTS(SELECT 1 FROM TALLACOLORCUV WHERE CUVPADRE = @CUV)
		BEGIN		
			SET @CantidadYaSolicitada = ISNULL((
				SELECT sum(Cantidad)
				FROM PEDIDOWEBDETALLE pwd
				inner join tallacolorcuv t on pwd.cuv = t.cuv and pwd.campaniaid = t.campaniaid
				WHERE t.cuvpadre = @CUV AND pwd.CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID
			),0)
		
			IF @flagPedido = 1
			BEGIN
				SET @CantidadYaSolicitada = ISNULL((
					SELECT sum(Cantidad)
					FROM PEDIDOWEBDETALLE pwd
					inner join tallacolorcuv t on pwd.cuv = t.cuv and pwd.campaniaid = t.campaniaid
					WHERE t.cuvpadre = @CUV AND pwd.CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID AND pwd.CUV <> @CUV
				),0)
				SET @CantidadSolicitante = @CantidadYaSolicitada + @CantidadPedida
			END
		END
		ELSE
		BEGIN
			SET @CantidadYaSolicitada = ISNULL((SELECT SUM(Cantidad) FROM PEDIDOWEBDETALLE WHERE CUV = @CUV AND CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID),0)
			IF @flagPedido = 1
			BEGIN
				SET @CantidadSolicitante = @CantidadPedida
			END
		END	
		
		SET @CantidadLimite = ISNULL((
			SELECT LimiteVenta FROM Estrategia
			WHERE
				CUV2 = @CUV AND CampaniaID = @CampaniaID 
				AND @flagPedido = (CASE WHEN @flagPedido = 0 THEN 0 ELSE TipoEstrategiaID END)   
				AND NumeroPedido = CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END
		), 0);	
		SET @CantidadSolicitante = isnull(@CantidadYaSolicitada, 0) + @CantidadPedida;
		SET @mensaje = '';
	
		IF  @flagPedido <> 0 AND isnull(@CantidadSolicitante, 0) > isnull(@CantidadLimite, 0)
		BEGIN			
			IF @CantidadYaSolicitada < @CantidadLimite
			BEGIN
				SET @mensaje = 'La cantidad solicitada sobrepasa las Unidades Permitidas de Venta (' + CONVERT(VARCHAR, @CantidadLimite) + ') del producto.'
				SET @mensaje = @mensaje + ' Usted solo puede adicionar ' + CONVERT(VARCHAR, @CantidadLimite - @CantidadYaSolicitada) + ' más, debido a que ya agregó este producto a su pedido, verifique.'
			END
			ELSE
			BEGIN
				SET @mensaje = 'Usted ya ingresó la cantidad total permitida para éste producto (' + CONVERT(VARCHAR, @CantidadLimite) + ').';
			END
			SELECT @mensaje;
		END
		ELSE
		BEGIN
			SELECT 'OK'
		END
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT 1 FROM TALLACOLORCUV WHERE CUV = @CUV AND CAMPANIAID = @CampaniaID)
		BEGIN		
			DECLARE @CUVPadre INT
			SELECT @CUVPadre = CUVPadre FROM TALLACOLORCUV WHERE CAMPANIAID = @CampaniaID AND CUV = @CUV;
		
			SET @CantidadYaSolicitada = ISNULL((
				SELECT sum(Cantidad) 
				FROM PEDIDOWEBDETALLE pwd
				inner join tallacolorcuv t ON pwd.cuv = t.cuv and pwd.campaniaid = t.campaniaid
				WHERE t.cuvpadre = @CUVPadre AND pwd.CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID
			),0)
		
			SET @CantidadLimite = ISNULL((
				SELECT LimiteVenta
				FROM Estrategia 
				WHERE CUV2 = @CUVPadre AND CampaniaID = @CampaniaID AND NumeroPedido = CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END
			), 0)
			SET @CantidadSolicitante = isnull(@CantidadYaSolicitada, 0) + @CantidadPedida;
			SET @mensaje = '';
		
			IF @flagPedido = 1
			BEGIN
				SET @CantidadYaSolicitada = ISNULL((
					SELECT sum(Cantidad)
					FROM PEDIDOWEBDETALLE pwd
					inner join tallacolorcuv t on pwd.cuv = t.cuv and pwd.campaniaid = t.campaniaid
					WHERE t.cuvpadre = @CUVPadre AND pwd.CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID AND pwd.CUV <> @CUV
				),0);
				SET @CantidadSolicitante = @CantidadYaSolicitada + @CantidadPedida;
			END
	
			IF @flagPedido <> 0 AND isnull(@CantidadSolicitante, 0) > isnull(@CantidadLimite, 0)
			BEGIN		
				IF @CantidadYaSolicitada < @CantidadLimite
				BEGIN
					SET @mensaje = 'La cantidad solicitada sobrepasa las Unidades Permitidas de Venta (' + CONVERT(VARCHAR, @CantidadLimite) + ') del producto.'
					SET @mensaje = @mensaje + ' Usted solo puede adicionar ' + CONVERT(VARCHAR, @CantidadLimite - @CantidadYaSolicitada) + ' más, debido a que ya agregó este producto a su pedido, verifique.'
				END
				ELSE
				BEGIN
					SET @mensaje = 'Usted ya ingresó la cantidad total permitida para éste producto (' + CONVERT(VARCHAR, @CantidadLimite) + ').';
				END
				SELECT @mensaje;
			END
			ELSE
			BEGIN
				SELECT 'OK'
			END
		END
		ELSE
		BEGIN
			SELECT 'OK'
		END
	END
	SET NOCOUNT OFF;
END