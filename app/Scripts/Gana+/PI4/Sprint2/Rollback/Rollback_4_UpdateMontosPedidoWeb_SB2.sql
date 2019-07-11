

USE BelcorpPeru
GO

ALTER PROCEDURE UpdateMontosPedidoWeb_SB2 @CampaniaID INT
	,@ConsultoraID INT
	,@MontoAhorroCatalogo MONEY
	,@MontoAhorroRevista MONEY
	,@MontoDescuento MONEY
	,@MontoEscala MONEY
	,@VersionProl TINYINT = 0
	,@PedidoSapId BIGINT = 0
AS
BEGIN
	UPDATE PedidoWeb
	SET MontoAhorroCatalogo = @MontoAhorroCatalogo
		,MontoAhorroRevista = @MontoAhorroRevista
		,DescuentoProl = @MontoDescuento
		,MontoEscala = @MontoEscala
		,VersionProl = iif(@VersionProl = 0, VersionProl, @VersionProl)
		,PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId)
	WHERE CampaniaID = @CampaniaID
		AND ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE UpdateMontosPedidoWeb_SB2 @CampaniaID INT
	,@ConsultoraID INT
	,@MontoAhorroCatalogo MONEY
	,@MontoAhorroRevista MONEY
	,@MontoDescuento MONEY
	,@MontoEscala MONEY
	,@VersionProl TINYINT = 0
	,@PedidoSapId BIGINT = 0
AS
BEGIN
	UPDATE PedidoWeb
	SET MontoAhorroCatalogo = @MontoAhorroCatalogo
		,MontoAhorroRevista = @MontoAhorroRevista
		,DescuentoProl = @MontoDescuento
		,MontoEscala = @MontoEscala
		,VersionProl = iif(@VersionProl = 0, VersionProl, @VersionProl)
		,PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId)
	WHERE CampaniaID = @CampaniaID
		AND ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE UpdateMontosPedidoWeb_SB2 @CampaniaID INT
	,@ConsultoraID INT
	,@MontoAhorroCatalogo MONEY
	,@MontoAhorroRevista MONEY
	,@MontoDescuento MONEY
	,@MontoEscala MONEY
	,@VersionProl TINYINT = 0
	,@PedidoSapId BIGINT = 0
AS
BEGIN
	UPDATE PedidoWeb
	SET MontoAhorroCatalogo = @MontoAhorroCatalogo
		,MontoAhorroRevista = @MontoAhorroRevista
		,DescuentoProl = @MontoDescuento
		,MontoEscala = @MontoEscala
		,VersionProl = iif(@VersionProl = 0, VersionProl, @VersionProl)
		,PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId)
	WHERE CampaniaID = @CampaniaID
		AND ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE UpdateMontosPedidoWeb_SB2 @CampaniaID INT
	,@ConsultoraID INT
	,@MontoAhorroCatalogo MONEY
	,@MontoAhorroRevista MONEY
	,@MontoDescuento MONEY
	,@MontoEscala MONEY
	,@VersionProl TINYINT = 0
	,@PedidoSapId BIGINT = 0
AS
BEGIN
	UPDATE PedidoWeb
	SET MontoAhorroCatalogo = @MontoAhorroCatalogo
		,MontoAhorroRevista = @MontoAhorroRevista
		,DescuentoProl = @MontoDescuento
		,MontoEscala = @MontoEscala
		,VersionProl = iif(@VersionProl = 0, VersionProl, @VersionProl)
		,PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId)
	WHERE CampaniaID = @CampaniaID
		AND ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE UpdateMontosPedidoWeb_SB2 @CampaniaID INT
	,@ConsultoraID INT
	,@MontoAhorroCatalogo MONEY
	,@MontoAhorroRevista MONEY
	,@MontoDescuento MONEY
	,@MontoEscala MONEY
	,@VersionProl TINYINT = 0
	,@PedidoSapId BIGINT = 0
AS
BEGIN
	UPDATE PedidoWeb
	SET MontoAhorroCatalogo = @MontoAhorroCatalogo
		,MontoAhorroRevista = @MontoAhorroRevista
		,DescuentoProl = @MontoDescuento
		,MontoEscala = @MontoEscala
		,VersionProl = iif(@VersionProl = 0, VersionProl, @VersionProl)
		,PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId)
	WHERE CampaniaID = @CampaniaID
		AND ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE UpdateMontosPedidoWeb_SB2 @CampaniaID INT
	,@ConsultoraID INT
	,@MontoAhorroCatalogo MONEY
	,@MontoAhorroRevista MONEY
	,@MontoDescuento MONEY
	,@MontoEscala MONEY
	,@VersionProl TINYINT = 0
	,@PedidoSapId BIGINT = 0
AS
BEGIN
	UPDATE PedidoWeb
	SET MontoAhorroCatalogo = @MontoAhorroCatalogo
		,MontoAhorroRevista = @MontoAhorroRevista
		,DescuentoProl = @MontoDescuento
		,MontoEscala = @MontoEscala
		,VersionProl = iif(@VersionProl = 0, VersionProl, @VersionProl)
		,PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId)
	WHERE CampaniaID = @CampaniaID
		AND ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE UpdateMontosPedidoWeb_SB2 @CampaniaID INT
	,@ConsultoraID INT
	,@MontoAhorroCatalogo MONEY
	,@MontoAhorroRevista MONEY
	,@MontoDescuento MONEY
	,@MontoEscala MONEY
	,@VersionProl TINYINT = 0
	,@PedidoSapId BIGINT = 0
AS
BEGIN
	UPDATE PedidoWeb
	SET MontoAhorroCatalogo = @MontoAhorroCatalogo
		,MontoAhorroRevista = @MontoAhorroRevista
		,DescuentoProl = @MontoDescuento
		,MontoEscala = @MontoEscala
		,VersionProl = iif(@VersionProl = 0, VersionProl, @VersionProl)
		,PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId)
	WHERE CampaniaID = @CampaniaID
		AND ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE UpdateMontosPedidoWeb_SB2 @CampaniaID INT
	,@ConsultoraID INT
	,@MontoAhorroCatalogo MONEY
	,@MontoAhorroRevista MONEY
	,@MontoDescuento MONEY
	,@MontoEscala MONEY
	,@VersionProl TINYINT = 0
	,@PedidoSapId BIGINT = 0
AS
BEGIN
	UPDATE PedidoWeb
	SET MontoAhorroCatalogo = @MontoAhorroCatalogo
		,MontoAhorroRevista = @MontoAhorroRevista
		,DescuentoProl = @MontoDescuento
		,MontoEscala = @MontoEscala
		,VersionProl = iif(@VersionProl = 0, VersionProl, @VersionProl)
		,PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId)
	WHERE CampaniaID = @CampaniaID
		AND ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE UpdateMontosPedidoWeb_SB2 @CampaniaID INT
	,@ConsultoraID INT
	,@MontoAhorroCatalogo MONEY
	,@MontoAhorroRevista MONEY
	,@MontoDescuento MONEY
	,@MontoEscala MONEY
	,@VersionProl TINYINT = 0
	,@PedidoSapId BIGINT = 0
AS
BEGIN
	UPDATE PedidoWeb
	SET MontoAhorroCatalogo = @MontoAhorroCatalogo
		,MontoAhorroRevista = @MontoAhorroRevista
		,DescuentoProl = @MontoDescuento
		,MontoEscala = @MontoEscala
		,VersionProl = iif(@VersionProl = 0, VersionProl, @VersionProl)
		,PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId)
	WHERE CampaniaID = @CampaniaID
		AND ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE UpdateMontosPedidoWeb_SB2 @CampaniaID INT
	,@ConsultoraID INT
	,@MontoAhorroCatalogo MONEY
	,@MontoAhorroRevista MONEY
	,@MontoDescuento MONEY
	,@MontoEscala MONEY
	,@VersionProl TINYINT = 0
	,@PedidoSapId BIGINT = 0
AS
BEGIN
	UPDATE PedidoWeb
	SET MontoAhorroCatalogo = @MontoAhorroCatalogo
		,MontoAhorroRevista = @MontoAhorroRevista
		,DescuentoProl = @MontoDescuento
		,MontoEscala = @MontoEscala
		,VersionProl = iif(@VersionProl = 0, VersionProl, @VersionProl)
		,PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId)
	WHERE CampaniaID = @CampaniaID
		AND ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE UpdateMontosPedidoWeb_SB2 @CampaniaID INT
	,@ConsultoraID INT
	,@MontoAhorroCatalogo MONEY
	,@MontoAhorroRevista MONEY
	,@MontoDescuento MONEY
	,@MontoEscala MONEY
	,@VersionProl TINYINT = 0
	,@PedidoSapId BIGINT = 0
AS
BEGIN
	UPDATE PedidoWeb
	SET MontoAhorroCatalogo = @MontoAhorroCatalogo
		,MontoAhorroRevista = @MontoAhorroRevista
		,DescuentoProl = @MontoDescuento
		,MontoEscala = @MontoEscala
		,VersionProl = iif(@VersionProl = 0, VersionProl, @VersionProl)
		,PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId)
	WHERE CampaniaID = @CampaniaID
		AND ConsultoraID = @ConsultoraID;
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE UpdateMontosPedidoWeb_SB2 @CampaniaID INT
	,@ConsultoraID INT
	,@MontoAhorroCatalogo MONEY
	,@MontoAhorroRevista MONEY
	,@MontoDescuento MONEY
	,@MontoEscala MONEY
	,@VersionProl TINYINT = 0
	,@PedidoSapId BIGINT = 0
AS
BEGIN
	UPDATE PedidoWeb
	SET MontoAhorroCatalogo = @MontoAhorroCatalogo
		,MontoAhorroRevista = @MontoAhorroRevista
		,DescuentoProl = @MontoDescuento
		,MontoEscala = @MontoEscala
		,VersionProl = iif(@VersionProl = 0, VersionProl, @VersionProl)
		,PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId)
	WHERE CampaniaID = @CampaniaID
		AND ConsultoraID = @ConsultoraID;
END
GO

