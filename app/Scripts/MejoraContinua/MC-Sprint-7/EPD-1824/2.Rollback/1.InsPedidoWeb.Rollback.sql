USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsPedidoWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsPedidoWeb]
GO

CREATE PROCEDURE [dbo].[InsPedidoWeb]
	@CampaniaID int,
	@ConsultoraID int,
	@PaisID int,
	@IPUsuario varchar(25) =null,
	@PedidoID int output,
	@CodigoUsuarioCreacion varchar(25) = null
AS
SET @PedidoID = 0
SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID
	
IF(@PedidoID = 0)
BEGIN

	DECLARE @FechaGeneral DATETIME        
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	SET @PedidoID = NEXT VALUE FOR dbo.SecuenciaPedido
	--SET @PedidoID = (SELECT ISNULL(MAX(PedidoID),0) + 1 FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID)
	INSERT INTO dbo.PedidoWeb (CampaniaID, PedidoID, ConsultoraID, FechaRegistro, Clientes, ImporteTotal, ImporteCredito, 
	                           EstadoPedido, ModificaPedidoReservado, PaisID, IPUsuario, CodigoUsuarioCreacion)
	VALUES (@CampaniaID, @PedidoID, @ConsultoraID, @FechaGeneral, 0, 0, 0, 201, 0, @PaisID, @IPUsuario, @CodigoUsuarioCreacion)
END


GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsPedidoWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsPedidoWeb]
GO

CREATE PROCEDURE [dbo].[InsPedidoWeb]
	@CampaniaID int,
	@ConsultoraID int,
	@PaisID int,
	@IPUsuario varchar(25) =null,
	@PedidoID int output,
	@CodigoUsuarioCreacion varchar(25) = null
AS
SET @PedidoID = 0
SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID
	
IF(@PedidoID = 0)
BEGIN

	DECLARE @FechaGeneral DATETIME        
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	SET @PedidoID = NEXT VALUE FOR dbo.SecuenciaPedido
	--SET @PedidoID = (SELECT ISNULL(MAX(PedidoID),0) + 1 FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID)
	INSERT INTO dbo.PedidoWeb (CampaniaID, PedidoID, ConsultoraID, FechaRegistro, Clientes, ImporteTotal, ImporteCredito, 
	                           EstadoPedido, ModificaPedidoReservado, PaisID, IPUsuario, CodigoUsuarioCreacion)
	VALUES (@CampaniaID, @PedidoID, @ConsultoraID, @FechaGeneral, 0, 0, 0, 201, 0, @PaisID, @IPUsuario, @CodigoUsuarioCreacion)
END


GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsPedidoWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsPedidoWeb]
GO

CREATE PROCEDURE [dbo].[InsPedidoWeb]
	@CampaniaID int,
	@ConsultoraID int,
	@PaisID int,
	@IPUsuario varchar(25) =null,
	@PedidoID int output,
	@CodigoUsuarioCreacion varchar(25) = null
AS
SET @PedidoID = 0
SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID
	
IF(@PedidoID = 0)
BEGIN

	DECLARE @FechaGeneral DATETIME        
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	SET @PedidoID = NEXT VALUE FOR dbo.SecuenciaPedido
	--SET @PedidoID = (SELECT ISNULL(MAX(PedidoID),0) + 1 FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID)
	INSERT INTO dbo.PedidoWeb (CampaniaID, PedidoID, ConsultoraID, FechaRegistro, Clientes, ImporteTotal, ImporteCredito, 
	                           EstadoPedido, ModificaPedidoReservado, PaisID, IPUsuario, CodigoUsuarioCreacion)
	VALUES (@CampaniaID, @PedidoID, @ConsultoraID, @FechaGeneral, 0, 0, 0, 201, 0, @PaisID, @IPUsuario, @CodigoUsuarioCreacion)
END


GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsPedidoWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsPedidoWeb]
GO

CREATE PROCEDURE [dbo].[InsPedidoWeb]
	@CampaniaID int,
	@ConsultoraID int,
	@PaisID int,
	@IPUsuario varchar(25) =null,
	@PedidoID int output,
	@CodigoUsuarioCreacion varchar(25) = null
AS
SET @PedidoID = 0
SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID
	
IF(@PedidoID = 0)
BEGIN

	DECLARE @FechaGeneral DATETIME        
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	SET @PedidoID = NEXT VALUE FOR dbo.SecuenciaPedido
	--SET @PedidoID = (SELECT ISNULL(MAX(PedidoID),0) + 1 FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID)
	INSERT INTO dbo.PedidoWeb (CampaniaID, PedidoID, ConsultoraID, FechaRegistro, Clientes, ImporteTotal, ImporteCredito, 
	                           EstadoPedido, ModificaPedidoReservado, PaisID, IPUsuario, CodigoUsuarioCreacion)
	VALUES (@CampaniaID, @PedidoID, @ConsultoraID, @FechaGeneral, 0, 0, 0, 201, 0, @PaisID, @IPUsuario, @CodigoUsuarioCreacion)
END


GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsPedidoWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsPedidoWeb]
GO

CREATE PROCEDURE [dbo].[InsPedidoWeb]
	@CampaniaID int,
	@ConsultoraID int,
	@PaisID int,
	@IPUsuario varchar(25) =null,
	@PedidoID int output,
	@CodigoUsuarioCreacion varchar(25) = null
AS
SET @PedidoID = 0
SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID
	
IF(@PedidoID = 0)
BEGIN

	DECLARE @FechaGeneral DATETIME        
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	SET @PedidoID = NEXT VALUE FOR dbo.SecuenciaPedido
	--SET @PedidoID = (SELECT ISNULL(MAX(PedidoID),0) + 1 FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID)
	INSERT INTO dbo.PedidoWeb (CampaniaID, PedidoID, ConsultoraID, FechaRegistro, Clientes, ImporteTotal, ImporteCredito, 
	                           EstadoPedido, ModificaPedidoReservado, PaisID, IPUsuario, CodigoUsuarioCreacion)
	VALUES (@CampaniaID, @PedidoID, @ConsultoraID, @FechaGeneral, 0, 0, 0, 201, 0, @PaisID, @IPUsuario, @CodigoUsuarioCreacion)
END


GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsPedidoWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsPedidoWeb]
GO

CREATE PROCEDURE [dbo].[InsPedidoWeb]
	@CampaniaID int,
	@ConsultoraID int,
	@PaisID int,
	@IPUsuario varchar(25) =null,
	@PedidoID int output,
	@CodigoUsuarioCreacion varchar(25) = null
AS
SET @PedidoID = 0
SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID
	
IF(@PedidoID = 0)
BEGIN

	DECLARE @FechaGeneral DATETIME        
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	SET @PedidoID = NEXT VALUE FOR dbo.SecuenciaPedido
	--SET @PedidoID = (SELECT ISNULL(MAX(PedidoID),0) + 1 FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID)
	INSERT INTO dbo.PedidoWeb (CampaniaID, PedidoID, ConsultoraID, FechaRegistro, Clientes, ImporteTotal, ImporteCredito, 
	                           EstadoPedido, ModificaPedidoReservado, PaisID, IPUsuario, CodigoUsuarioCreacion)
	VALUES (@CampaniaID, @PedidoID, @ConsultoraID, @FechaGeneral, 0, 0, 0, 201, 0, @PaisID, @IPUsuario, @CodigoUsuarioCreacion)
END


GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsPedidoWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsPedidoWeb]
GO

CREATE PROCEDURE [dbo].[InsPedidoWeb]
	@CampaniaID int,
	@ConsultoraID int,
	@PaisID int,
	@IPUsuario varchar(25) =null,
	@PedidoID int output,
	@CodigoUsuarioCreacion varchar(25) = null
AS
SET @PedidoID = 0
SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID
	
IF(@PedidoID = 0)
BEGIN

	DECLARE @FechaGeneral DATETIME        
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	SET @PedidoID = NEXT VALUE FOR dbo.SecuenciaPedido
	--SET @PedidoID = (SELECT ISNULL(MAX(PedidoID),0) + 1 FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID)
	INSERT INTO dbo.PedidoWeb (CampaniaID, PedidoID, ConsultoraID, FechaRegistro, Clientes, ImporteTotal, ImporteCredito, 
	                           EstadoPedido, ModificaPedidoReservado, PaisID, IPUsuario, CodigoUsuarioCreacion)
	VALUES (@CampaniaID, @PedidoID, @ConsultoraID, @FechaGeneral, 0, 0, 0, 201, 0, @PaisID, @IPUsuario, @CodigoUsuarioCreacion)
END


GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsPedidoWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsPedidoWeb]
GO

CREATE PROCEDURE [dbo].[InsPedidoWeb]
	@CampaniaID int,
	@ConsultoraID int,
	@PaisID int,
	@IPUsuario varchar(25) =null,
	@PedidoID int output,
	@CodigoUsuarioCreacion varchar(25) = null
AS
SET @PedidoID = 0
SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID
	
IF(@PedidoID = 0)
BEGIN

	DECLARE @FechaGeneral DATETIME        
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	SET @PedidoID = NEXT VALUE FOR dbo.SecuenciaPedido
	--SET @PedidoID = (SELECT ISNULL(MAX(PedidoID),0) + 1 FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID)
	INSERT INTO dbo.PedidoWeb (CampaniaID, PedidoID, ConsultoraID, FechaRegistro, Clientes, ImporteTotal, ImporteCredito, 
	                           EstadoPedido, ModificaPedidoReservado, PaisID, IPUsuario, CodigoUsuarioCreacion)
	VALUES (@CampaniaID, @PedidoID, @ConsultoraID, @FechaGeneral, 0, 0, 0, 201, 0, @PaisID, @IPUsuario, @CodigoUsuarioCreacion)
END


GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsPedidoWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsPedidoWeb]
GO

CREATE PROCEDURE [dbo].[InsPedidoWeb]
	@CampaniaID int,
	@ConsultoraID int,
	@PaisID int,
	@IPUsuario varchar(25) =null,
	@PedidoID int output,
	@CodigoUsuarioCreacion varchar(25) = null
AS
SET @PedidoID = 0
SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID
	
IF(@PedidoID = 0)
BEGIN

	DECLARE @FechaGeneral DATETIME        
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	SET @PedidoID = NEXT VALUE FOR dbo.SecuenciaPedido
	--SET @PedidoID = (SELECT ISNULL(MAX(PedidoID),0) + 1 FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID)
	INSERT INTO dbo.PedidoWeb (CampaniaID, PedidoID, ConsultoraID, FechaRegistro, Clientes, ImporteTotal, ImporteCredito, 
	                           EstadoPedido, ModificaPedidoReservado, PaisID, IPUsuario, CodigoUsuarioCreacion)
	VALUES (@CampaniaID, @PedidoID, @ConsultoraID, @FechaGeneral, 0, 0, 0, 201, 0, @PaisID, @IPUsuario, @CodigoUsuarioCreacion)
END


GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsPedidoWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsPedidoWeb]
GO

CREATE PROCEDURE [dbo].[InsPedidoWeb]
	@CampaniaID int,
	@ConsultoraID int,
	@PaisID int,
	@IPUsuario varchar(25) =null,
	@PedidoID int output,
	@CodigoUsuarioCreacion varchar(25) = null
AS
SET @PedidoID = 0
SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID
	
IF(@PedidoID = 0)
BEGIN

	DECLARE @FechaGeneral DATETIME        
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	SET @PedidoID = NEXT VALUE FOR dbo.SecuenciaPedido
	--SET @PedidoID = (SELECT ISNULL(MAX(PedidoID),0) + 1 FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID)
	INSERT INTO dbo.PedidoWeb (CampaniaID, PedidoID, ConsultoraID, FechaRegistro, Clientes, ImporteTotal, ImporteCredito, 
	                           EstadoPedido, ModificaPedidoReservado, PaisID, IPUsuario, CodigoUsuarioCreacion)
	VALUES (@CampaniaID, @PedidoID, @ConsultoraID, @FechaGeneral, 0, 0, 0, 201, 0, @PaisID, @IPUsuario, @CodigoUsuarioCreacion)
END


GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsPedidoWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsPedidoWeb]
GO

CREATE PROCEDURE [dbo].[InsPedidoWeb]
	@CampaniaID int,
	@ConsultoraID int,
	@PaisID int,
	@IPUsuario varchar(25) =null,
	@PedidoID int output,
	@CodigoUsuarioCreacion varchar(25) = null
AS
SET @PedidoID = 0
SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID
	
IF(@PedidoID = 0)
BEGIN

	DECLARE @FechaGeneral DATETIME        
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	SET @PedidoID = NEXT VALUE FOR dbo.SecuenciaPedido
	--SET @PedidoID = (SELECT ISNULL(MAX(PedidoID),0) + 1 FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID)
	INSERT INTO dbo.PedidoWeb (CampaniaID, PedidoID, ConsultoraID, FechaRegistro, Clientes, ImporteTotal, ImporteCredito, 
	                           EstadoPedido, ModificaPedidoReservado, PaisID, IPUsuario, CodigoUsuarioCreacion)
	VALUES (@CampaniaID, @PedidoID, @ConsultoraID, @FechaGeneral, 0, 0, 0, 201, 0, @PaisID, @IPUsuario, @CodigoUsuarioCreacion)
END


GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsPedidoWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsPedidoWeb]
GO

CREATE PROCEDURE [dbo].[InsPedidoWeb]
	@CampaniaID int,
	@ConsultoraID int,
	@PaisID int,
	@IPUsuario varchar(25) =null,
	@PedidoID int output,
	@CodigoUsuarioCreacion varchar(25) = null
AS
SET @PedidoID = 0
SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID
	
IF(@PedidoID = 0)
BEGIN

	DECLARE @FechaGeneral DATETIME        
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	SET @PedidoID = NEXT VALUE FOR dbo.SecuenciaPedido
	--SET @PedidoID = (SELECT ISNULL(MAX(PedidoID),0) + 1 FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID)
	INSERT INTO dbo.PedidoWeb (CampaniaID, PedidoID, ConsultoraID, FechaRegistro, Clientes, ImporteTotal, ImporteCredito, 
	                           EstadoPedido, ModificaPedidoReservado, PaisID, IPUsuario, CodigoUsuarioCreacion)
	VALUES (@CampaniaID, @PedidoID, @ConsultoraID, @FechaGeneral, 0, 0, 0, 201, 0, @PaisID, @IPUsuario, @CodigoUsuarioCreacion)
END


GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsPedidoWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsPedidoWeb]
GO

CREATE PROCEDURE [dbo].[InsPedidoWeb]
	@CampaniaID int,
	@ConsultoraID int,
	@PaisID int,
	@IPUsuario varchar(25) =null,
	@PedidoID int output,
	@CodigoUsuarioCreacion varchar(25) = null
AS
SET @PedidoID = 0
SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID
	
IF(@PedidoID = 0)
BEGIN

	DECLARE @FechaGeneral DATETIME        
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	SET @PedidoID = NEXT VALUE FOR dbo.SecuenciaPedido
	--SET @PedidoID = (SELECT ISNULL(MAX(PedidoID),0) + 1 FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID)
	INSERT INTO dbo.PedidoWeb (CampaniaID, PedidoID, ConsultoraID, FechaRegistro, Clientes, ImporteTotal, ImporteCredito, 
	                           EstadoPedido, ModificaPedidoReservado, PaisID, IPUsuario, CodigoUsuarioCreacion)
	VALUES (@CampaniaID, @PedidoID, @ConsultoraID, @FechaGeneral, 0, 0, 0, 201, 0, @PaisID, @IPUsuario, @CodigoUsuarioCreacion)
END


GO

