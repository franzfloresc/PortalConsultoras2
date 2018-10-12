USE BelcorpPeru
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom
(
	@CampaniaID INT,
	@CUV varchar(10),
	@ConsultoraID bigint
)
AS
/*
ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom 201607, '99001', 8828
*/
DECLARE @Cantidad int
DECLARE @ItemsPedido int = 0
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	-- Verificamos si el cuv a validar es una talla o color
	IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	BEGIN
		SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	END
	PRINT '@CUVPadre'
	PRINT @CUVPadre
	SET @Cantidad = (select isnull(op.UnidadesPermitidas,0) 
						from ShowRoom.OfertaShowRoom op 
							 inner join ods.campania ca
							 on op.campaniaid = ca.campaniaid
						where ca.codigo = @CampaniaID and cuv = @CUVPadre
							  and tipoofertasisID = 1707)
	PRINT '@Cantidad'
	PRINT @Cantidad
	If @Cantidad is not null
	BEGIN

		IF NOT EXISTS (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
		BEGIN
			PRINT 'NO EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select isnull(cantidad,0) from pedidowebdetalle
														   where cuv = @CUVPadre
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))
		END
		ELSE
		BEGIN
			PRINT 'EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select SUM(Cantidad) from pedidowebdetalle
														   where cuv IN (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))


		END
	END
	
	SELECT @ItemsPedido
END


GO

USE BelcorpMexico
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom
(
	@CampaniaID INT,
	@CUV varchar(10),
	@ConsultoraID bigint
)
AS
/*
ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom 201607, '99001', 8828
*/
DECLARE @Cantidad int
DECLARE @ItemsPedido int = 0
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	-- Verificamos si el cuv a validar es una talla o color
	IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	BEGIN
		SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	END
	PRINT '@CUVPadre'
	PRINT @CUVPadre
	SET @Cantidad = (select isnull(op.UnidadesPermitidas,0) 
						from ShowRoom.OfertaShowRoom op 
							 inner join ods.campania ca
							 on op.campaniaid = ca.campaniaid
						where ca.codigo = @CampaniaID and cuv = @CUVPadre
							  and tipoofertasisID = 1707)
	PRINT '@Cantidad'
	PRINT @Cantidad
	If @Cantidad is not null
	BEGIN

		IF NOT EXISTS (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
		BEGIN
			PRINT 'NO EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select isnull(cantidad,0) from pedidowebdetalle
														   where cuv = @CUVPadre
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))
		END
		ELSE
		BEGIN
			PRINT 'EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select SUM(Cantidad) from pedidowebdetalle
														   where cuv IN (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))


		END
	END
	
	SELECT @ItemsPedido
END


GO

USE BelcorpColombia
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom
(
	@CampaniaID INT,
	@CUV varchar(10),
	@ConsultoraID bigint
)
AS
/*
ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom 201607, '99001', 8828
*/
DECLARE @Cantidad int
DECLARE @ItemsPedido int = 0
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	-- Verificamos si el cuv a validar es una talla o color
	IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	BEGIN
		SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	END
	PRINT '@CUVPadre'
	PRINT @CUVPadre
	SET @Cantidad = (select isnull(op.UnidadesPermitidas,0) 
						from ShowRoom.OfertaShowRoom op 
							 inner join ods.campania ca
							 on op.campaniaid = ca.campaniaid
						where ca.codigo = @CampaniaID and cuv = @CUVPadre
							  and tipoofertasisID = 1707)
	PRINT '@Cantidad'
	PRINT @Cantidad
	If @Cantidad is not null
	BEGIN

		IF NOT EXISTS (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
		BEGIN
			PRINT 'NO EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select isnull(cantidad,0) from pedidowebdetalle
														   where cuv = @CUVPadre
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))
		END
		ELSE
		BEGIN
			PRINT 'EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select SUM(Cantidad) from pedidowebdetalle
														   where cuv IN (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))


		END
	END
	
	SELECT @ItemsPedido
END


GO

USE BelcorpVenezuela
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom
(
	@CampaniaID INT,
	@CUV varchar(10),
	@ConsultoraID bigint
)
AS
/*
ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom 201607, '99001', 8828
*/
DECLARE @Cantidad int
DECLARE @ItemsPedido int = 0
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	-- Verificamos si el cuv a validar es una talla o color
	IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	BEGIN
		SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	END
	PRINT '@CUVPadre'
	PRINT @CUVPadre
	SET @Cantidad = (select isnull(op.UnidadesPermitidas,0) 
						from ShowRoom.OfertaShowRoom op 
							 inner join ods.campania ca
							 on op.campaniaid = ca.campaniaid
						where ca.codigo = @CampaniaID and cuv = @CUVPadre
							  and tipoofertasisID = 1707)
	PRINT '@Cantidad'
	PRINT @Cantidad
	If @Cantidad is not null
	BEGIN

		IF NOT EXISTS (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
		BEGIN
			PRINT 'NO EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select isnull(cantidad,0) from pedidowebdetalle
														   where cuv = @CUVPadre
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))
		END
		ELSE
		BEGIN
			PRINT 'EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select SUM(Cantidad) from pedidowebdetalle
														   where cuv IN (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))


		END
	END
	
	SELECT @ItemsPedido
END


GO

USE BelcorpSalvador
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom
(
	@CampaniaID INT,
	@CUV varchar(10),
	@ConsultoraID bigint
)
AS
/*
ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom 201607, '99001', 8828
*/
DECLARE @Cantidad int
DECLARE @ItemsPedido int = 0
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	-- Verificamos si el cuv a validar es una talla o color
	IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	BEGIN
		SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	END
	PRINT '@CUVPadre'
	PRINT @CUVPadre
	SET @Cantidad = (select isnull(op.UnidadesPermitidas,0) 
						from ShowRoom.OfertaShowRoom op 
							 inner join ods.campania ca
							 on op.campaniaid = ca.campaniaid
						where ca.codigo = @CampaniaID and cuv = @CUVPadre
							  and tipoofertasisID = 1707)
	PRINT '@Cantidad'
	PRINT @Cantidad
	If @Cantidad is not null
	BEGIN

		IF NOT EXISTS (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
		BEGIN
			PRINT 'NO EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select isnull(cantidad,0) from pedidowebdetalle
														   where cuv = @CUVPadre
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))
		END
		ELSE
		BEGIN
			PRINT 'EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select SUM(Cantidad) from pedidowebdetalle
														   where cuv IN (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))


		END
	END
	
	SELECT @ItemsPedido
END


GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom
(
	@CampaniaID INT,
	@CUV varchar(10),
	@ConsultoraID bigint
)
AS
/*
ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom 201607, '99001', 8828
*/
DECLARE @Cantidad int
DECLARE @ItemsPedido int = 0
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	-- Verificamos si el cuv a validar es una talla o color
	IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	BEGIN
		SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	END
	PRINT '@CUVPadre'
	PRINT @CUVPadre
	SET @Cantidad = (select isnull(op.UnidadesPermitidas,0) 
						from ShowRoom.OfertaShowRoom op 
							 inner join ods.campania ca
							 on op.campaniaid = ca.campaniaid
						where ca.codigo = @CampaniaID and cuv = @CUVPadre
							  and tipoofertasisID = 1707)
	PRINT '@Cantidad'
	PRINT @Cantidad
	If @Cantidad is not null
	BEGIN

		IF NOT EXISTS (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
		BEGIN
			PRINT 'NO EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select isnull(cantidad,0) from pedidowebdetalle
														   where cuv = @CUVPadre
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))
		END
		ELSE
		BEGIN
			PRINT 'EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select SUM(Cantidad) from pedidowebdetalle
														   where cuv IN (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))


		END
	END
	
	SELECT @ItemsPedido
END


GO

USE BelcorpPanama
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom
(
	@CampaniaID INT,
	@CUV varchar(10),
	@ConsultoraID bigint
)
AS
/*
ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom 201607, '99001', 8828
*/
DECLARE @Cantidad int
DECLARE @ItemsPedido int = 0
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	-- Verificamos si el cuv a validar es una talla o color
	IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	BEGIN
		SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	END
	PRINT '@CUVPadre'
	PRINT @CUVPadre
	SET @Cantidad = (select isnull(op.UnidadesPermitidas,0) 
						from ShowRoom.OfertaShowRoom op 
							 inner join ods.campania ca
							 on op.campaniaid = ca.campaniaid
						where ca.codigo = @CampaniaID and cuv = @CUVPadre
							  and tipoofertasisID = 1707)
	PRINT '@Cantidad'
	PRINT @Cantidad
	If @Cantidad is not null
	BEGIN

		IF NOT EXISTS (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
		BEGIN
			PRINT 'NO EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select isnull(cantidad,0) from pedidowebdetalle
														   where cuv = @CUVPadre
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))
		END
		ELSE
		BEGIN
			PRINT 'EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select SUM(Cantidad) from pedidowebdetalle
														   where cuv IN (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))


		END
	END
	
	SELECT @ItemsPedido
END


GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom
(
	@CampaniaID INT,
	@CUV varchar(10),
	@ConsultoraID bigint
)
AS
/*
ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom 201607, '99001', 8828
*/
DECLARE @Cantidad int
DECLARE @ItemsPedido int = 0
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	-- Verificamos si el cuv a validar es una talla o color
	IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	BEGIN
		SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	END
	PRINT '@CUVPadre'
	PRINT @CUVPadre
	SET @Cantidad = (select isnull(op.UnidadesPermitidas,0) 
						from ShowRoom.OfertaShowRoom op 
							 inner join ods.campania ca
							 on op.campaniaid = ca.campaniaid
						where ca.codigo = @CampaniaID and cuv = @CUVPadre
							  and tipoofertasisID = 1707)
	PRINT '@Cantidad'
	PRINT @Cantidad
	If @Cantidad is not null
	BEGIN

		IF NOT EXISTS (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
		BEGIN
			PRINT 'NO EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select isnull(cantidad,0) from pedidowebdetalle
														   where cuv = @CUVPadre
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))
		END
		ELSE
		BEGIN
			PRINT 'EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select SUM(Cantidad) from pedidowebdetalle
														   where cuv IN (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))


		END
	END
	
	SELECT @ItemsPedido
END


GO

USE BelcorpEcuador
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom
(
	@CampaniaID INT,
	@CUV varchar(10),
	@ConsultoraID bigint
)
AS
/*
ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom 201607, '99001', 8828
*/
DECLARE @Cantidad int
DECLARE @ItemsPedido int = 0
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	-- Verificamos si el cuv a validar es una talla o color
	IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	BEGIN
		SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	END
	PRINT '@CUVPadre'
	PRINT @CUVPadre
	SET @Cantidad = (select isnull(op.UnidadesPermitidas,0) 
						from ShowRoom.OfertaShowRoom op 
							 inner join ods.campania ca
							 on op.campaniaid = ca.campaniaid
						where ca.codigo = @CampaniaID and cuv = @CUVPadre
							  and tipoofertasisID = 1707)
	PRINT '@Cantidad'
	PRINT @Cantidad
	If @Cantidad is not null
	BEGIN

		IF NOT EXISTS (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
		BEGIN
			PRINT 'NO EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select isnull(cantidad,0) from pedidowebdetalle
														   where cuv = @CUVPadre
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))
		END
		ELSE
		BEGIN
			PRINT 'EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select SUM(Cantidad) from pedidowebdetalle
														   where cuv IN (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))


		END
	END
	
	SELECT @ItemsPedido
END


GO

USE BelcorpDominicana
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom
(
	@CampaniaID INT,
	@CUV varchar(10),
	@ConsultoraID bigint
)
AS
/*
ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom 201607, '99001', 8828
*/
DECLARE @Cantidad int
DECLARE @ItemsPedido int = 0
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	-- Verificamos si el cuv a validar es una talla o color
	IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	BEGIN
		SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	END
	PRINT '@CUVPadre'
	PRINT @CUVPadre
	SET @Cantidad = (select isnull(op.UnidadesPermitidas,0) 
						from ShowRoom.OfertaShowRoom op 
							 inner join ods.campania ca
							 on op.campaniaid = ca.campaniaid
						where ca.codigo = @CampaniaID and cuv = @CUVPadre
							  and tipoofertasisID = 1707)
	PRINT '@Cantidad'
	PRINT @Cantidad
	If @Cantidad is not null
	BEGIN

		IF NOT EXISTS (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
		BEGIN
			PRINT 'NO EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select isnull(cantidad,0) from pedidowebdetalle
														   where cuv = @CUVPadre
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))
		END
		ELSE
		BEGIN
			PRINT 'EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select SUM(Cantidad) from pedidowebdetalle
														   where cuv IN (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))


		END
	END
	
	SELECT @ItemsPedido
END


GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom
(
	@CampaniaID INT,
	@CUV varchar(10),
	@ConsultoraID bigint
)
AS
/*
ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom 201607, '99001', 8828
*/
DECLARE @Cantidad int
DECLARE @ItemsPedido int = 0
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	-- Verificamos si el cuv a validar es una talla o color
	IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	BEGIN
		SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	END
	PRINT '@CUVPadre'
	PRINT @CUVPadre
	SET @Cantidad = (select isnull(op.UnidadesPermitidas,0) 
						from ShowRoom.OfertaShowRoom op 
							 inner join ods.campania ca
							 on op.campaniaid = ca.campaniaid
						where ca.codigo = @CampaniaID and cuv = @CUVPadre
							  and tipoofertasisID = 1707)
	PRINT '@Cantidad'
	PRINT @Cantidad
	If @Cantidad is not null
	BEGIN

		IF NOT EXISTS (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
		BEGIN
			PRINT 'NO EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select isnull(cantidad,0) from pedidowebdetalle
														   where cuv = @CUVPadre
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))
		END
		ELSE
		BEGIN
			PRINT 'EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select SUM(Cantidad) from pedidowebdetalle
														   where cuv IN (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))


		END
	END
	
	SELECT @ItemsPedido
END


GO

USE BelcorpChile
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom
(
	@CampaniaID INT,
	@CUV varchar(10),
	@ConsultoraID bigint
)
AS
/*
ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom 201607, '99001', 8828
*/
DECLARE @Cantidad int
DECLARE @ItemsPedido int = 0
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	-- Verificamos si el cuv a validar es una talla o color
	IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	BEGIN
		SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	END
	PRINT '@CUVPadre'
	PRINT @CUVPadre
	SET @Cantidad = (select isnull(op.UnidadesPermitidas,0) 
						from ShowRoom.OfertaShowRoom op 
							 inner join ods.campania ca
							 on op.campaniaid = ca.campaniaid
						where ca.codigo = @CampaniaID and cuv = @CUVPadre
							  and tipoofertasisID = 1707)
	PRINT '@Cantidad'
	PRINT @Cantidad
	If @Cantidad is not null
	BEGIN

		IF NOT EXISTS (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
		BEGIN
			PRINT 'NO EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select isnull(cantidad,0) from pedidowebdetalle
														   where cuv = @CUVPadre
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))
		END
		ELSE
		BEGIN
			PRINT 'EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select SUM(Cantidad) from pedidowebdetalle
														   where cuv IN (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))


		END
	END
	
	SELECT @ItemsPedido
END


GO

USE BelcorpBolivia
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom
(
	@CampaniaID INT,
	@CUV varchar(10),
	@ConsultoraID bigint
)
AS
/*
ShowRoom.ValidarUnidadesPermitidaPedidoShowRoom 201607, '99001', 8828
*/
DECLARE @Cantidad int
DECLARE @ItemsPedido int = 0
BEGIN

	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	-- Verificamos si el cuv a validar es una talla o color
	IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	BEGIN
		SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
	END
	PRINT '@CUVPadre'
	PRINT @CUVPadre
	SET @Cantidad = (select isnull(op.UnidadesPermitidas,0) 
						from ShowRoom.OfertaShowRoom op 
							 inner join ods.campania ca
							 on op.campaniaid = ca.campaniaid
						where ca.codigo = @CampaniaID and cuv = @CUVPadre
							  and tipoofertasisID = 1707)
	PRINT '@Cantidad'
	PRINT @Cantidad
	If @Cantidad is not null
	BEGIN

		IF NOT EXISTS (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
		BEGIN
			PRINT 'NO EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select isnull(cantidad,0) from pedidowebdetalle
														   where cuv = @CUVPadre
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))
		END
		ELSE
		BEGIN
			PRINT 'EXISTE'
			SET @ItemsPedido = @Cantidad - (select isnull((select SUM(Cantidad) from pedidowebdetalle
														   where cuv IN (SELECT CUV FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUVPadre = @CUVPadre)
														   and campaniaid = @campaniaid
														   and consultoraid = @consultoraid),0))


		END
	END
	
	SELECT @ItemsPedido
END


GO

