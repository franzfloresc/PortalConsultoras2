

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetExisteClienteConsultora'))
BEGIN
    DROP PROCEDURE dbo.GetExisteClienteConsultora
END
GO

CREATE PROCEDURE [dbo].[GetExisteClienteConsultora]
(
	@ConsultoraID BIGINT,
	@Nombre VARCHAR(50),
	@Telefono VARCHAR(50),
	@Email VARCHAR(50)
)
AS
BEGIN
	DECLARE @ClienteId INT

	SELECT @ClienteId = ClienteId FROM Cliente
	WHERE UPPER(RTRIM(Nombre)) = UPPER(RTRIM(@Nombre))
	AND ConsultoraID = @ConsultoraID
	AND Activo = 1

	SELECT ISNULL(@ClienteId,0) AS ClienteId
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetExisteClienteConsultora'))
BEGIN
    DROP PROCEDURE dbo.GetExisteClienteConsultora
END
GO

CREATE PROCEDURE [dbo].[GetExisteClienteConsultora]
(
	@ConsultoraID BIGINT,
	@Nombre VARCHAR(50),
	@Telefono VARCHAR(50),
	@Email VARCHAR(50)
)
AS
BEGIN
	DECLARE @ClienteId INT

	SELECT @ClienteId = ClienteId FROM Cliente
	WHERE UPPER(RTRIM(Nombre)) = UPPER(RTRIM(@Nombre))
	AND ConsultoraID = @ConsultoraID
	AND Activo = 1

	SELECT ISNULL(@ClienteId,0) AS ClienteId
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetExisteClienteConsultora'))
BEGIN
    DROP PROCEDURE dbo.GetExisteClienteConsultora
END
GO

CREATE PROCEDURE [dbo].[GetExisteClienteConsultora]
(
	@ConsultoraID BIGINT,
	@Nombre VARCHAR(50),
	@Telefono VARCHAR(50),
	@Email VARCHAR(50)
)
AS
BEGIN
	DECLARE @ClienteId INT

	SELECT @ClienteId = ClienteId FROM Cliente
	WHERE UPPER(RTRIM(Nombre)) = UPPER(RTRIM(@Nombre))
	AND ConsultoraID = @ConsultoraID
	AND Activo = 1

	SELECT ISNULL(@ClienteId,0) AS ClienteId
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetExisteClienteConsultora'))
BEGIN
    DROP PROCEDURE dbo.GetExisteClienteConsultora
END
GO

CREATE PROCEDURE [dbo].[GetExisteClienteConsultora]
(
	@ConsultoraID BIGINT,
	@Nombre VARCHAR(50),
	@Telefono VARCHAR(50),
	@Email VARCHAR(50)
)
AS
BEGIN
	DECLARE @ClienteId INT

	SELECT @ClienteId = ClienteId FROM Cliente
	WHERE UPPER(RTRIM(Nombre)) = UPPER(RTRIM(@Nombre))
	AND ConsultoraID = @ConsultoraID
	AND Activo = 1

	SELECT ISNULL(@ClienteId,0) AS ClienteId
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetExisteClienteConsultora'))
BEGIN
    DROP PROCEDURE dbo.GetExisteClienteConsultora
END
GO

CREATE PROCEDURE [dbo].[GetExisteClienteConsultora]
(
	@ConsultoraID BIGINT,
	@Nombre VARCHAR(50),
	@Telefono VARCHAR(50),
	@Email VARCHAR(50)
)
AS
BEGIN
	DECLARE @ClienteId INT

	SELECT @ClienteId = ClienteId FROM Cliente
	WHERE UPPER(RTRIM(Nombre)) = UPPER(RTRIM(@Nombre))
	AND ConsultoraID = @ConsultoraID
	AND Activo = 1

	SELECT ISNULL(@ClienteId,0) AS ClienteId
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetExisteClienteConsultora'))
BEGIN
    DROP PROCEDURE dbo.GetExisteClienteConsultora
END
GO

CREATE PROCEDURE [dbo].[GetExisteClienteConsultora]
(
	@ConsultoraID BIGINT,
	@Nombre VARCHAR(50),
	@Telefono VARCHAR(50),
	@Email VARCHAR(50)
)
AS
BEGIN
	DECLARE @ClienteId INT

	SELECT @ClienteId = ClienteId FROM Cliente
	WHERE UPPER(RTRIM(Nombre)) = UPPER(RTRIM(@Nombre))
	AND ConsultoraID = @ConsultoraID
	AND Activo = 1

	SELECT ISNULL(@ClienteId,0) AS ClienteId
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetExisteClienteConsultora'))
BEGIN
    DROP PROCEDURE dbo.GetExisteClienteConsultora
END
GO

CREATE PROCEDURE [dbo].[GetExisteClienteConsultora]
(
	@ConsultoraID BIGINT,
	@Nombre VARCHAR(50),
	@Telefono VARCHAR(50),
	@Email VARCHAR(50)
)
AS
BEGIN
	DECLARE @ClienteId INT

	SELECT @ClienteId = ClienteId FROM Cliente
	WHERE UPPER(RTRIM(Nombre)) = UPPER(RTRIM(@Nombre))
	AND ConsultoraID = @ConsultoraID
	AND Activo = 1

	SELECT ISNULL(@ClienteId,0) AS ClienteId
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetExisteClienteConsultora'))
BEGIN
    DROP PROCEDURE dbo.GetExisteClienteConsultora
END
GO

CREATE PROCEDURE [dbo].[GetExisteClienteConsultora]
(
	@ConsultoraID BIGINT,
	@Nombre VARCHAR(50),
	@Telefono VARCHAR(50),
	@Email VARCHAR(50)
)
AS
BEGIN
	DECLARE @ClienteId INT

	SELECT @ClienteId = ClienteId FROM Cliente
	WHERE UPPER(RTRIM(Nombre)) = UPPER(RTRIM(@Nombre))
	AND ConsultoraID = @ConsultoraID
	AND Activo = 1

	SELECT ISNULL(@ClienteId,0) AS ClienteId
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetExisteClienteConsultora'))
BEGIN
    DROP PROCEDURE dbo.GetExisteClienteConsultora
END
GO

CREATE PROCEDURE [dbo].[GetExisteClienteConsultora]
(
	@ConsultoraID BIGINT,
	@Nombre VARCHAR(50),
	@Telefono VARCHAR(50),
	@Email VARCHAR(50)
)
AS
BEGIN
	DECLARE @ClienteId INT

	SELECT @ClienteId = ClienteId FROM Cliente
	WHERE UPPER(RTRIM(Nombre)) = UPPER(RTRIM(@Nombre))
	AND ConsultoraID = @ConsultoraID
	AND Activo = 1

	SELECT ISNULL(@ClienteId,0) AS ClienteId
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetExisteClienteConsultora'))
BEGIN
    DROP PROCEDURE dbo.GetExisteClienteConsultora
END
GO

CREATE PROCEDURE [dbo].[GetExisteClienteConsultora]
(
	@ConsultoraID BIGINT,
	@Nombre VARCHAR(50),
	@Telefono VARCHAR(50),
	@Email VARCHAR(50)
)
AS
BEGIN
	DECLARE @ClienteId INT

	SELECT @ClienteId = ClienteId FROM Cliente
	WHERE UPPER(RTRIM(Nombre)) = UPPER(RTRIM(@Nombre))
	AND ConsultoraID = @ConsultoraID
	AND Activo = 1

	SELECT ISNULL(@ClienteId,0) AS ClienteId
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetExisteClienteConsultora'))
BEGIN
    DROP PROCEDURE dbo.GetExisteClienteConsultora
END
GO

CREATE PROCEDURE [dbo].[GetExisteClienteConsultora]
(
	@ConsultoraID BIGINT,
	@Nombre VARCHAR(50),
	@Telefono VARCHAR(50),
	@Email VARCHAR(50)
)
AS
BEGIN
	DECLARE @ClienteId INT

	SELECT @ClienteId = ClienteId FROM Cliente
	WHERE UPPER(RTRIM(Nombre)) = UPPER(RTRIM(@Nombre))
	AND ConsultoraID = @ConsultoraID
	AND Activo = 1

	SELECT ISNULL(@ClienteId,0) AS ClienteId
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetExisteClienteConsultora'))
BEGIN
    DROP PROCEDURE dbo.GetExisteClienteConsultora
END
GO

CREATE PROCEDURE [dbo].[GetExisteClienteConsultora]
(
	@ConsultoraID BIGINT,
	@Nombre VARCHAR(50),
	@Telefono VARCHAR(50),
	@Email VARCHAR(50)
)
AS
BEGIN
	DECLARE @ClienteId INT

	SELECT @ClienteId = ClienteId FROM Cliente
	WHERE UPPER(RTRIM(Nombre)) = UPPER(RTRIM(@Nombre))
	AND ConsultoraID = @ConsultoraID
	AND Activo = 1

	SELECT ISNULL(@ClienteId,0) AS ClienteId
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetExisteClienteConsultora'))
BEGIN
    DROP PROCEDURE dbo.GetExisteClienteConsultora
END
GO

CREATE PROCEDURE [dbo].[GetExisteClienteConsultora]
(
	@ConsultoraID BIGINT,
	@Nombre VARCHAR(50),
	@Telefono VARCHAR(50),
	@Email VARCHAR(50)
)
AS
BEGIN
	DECLARE @ClienteId INT

	SELECT @ClienteId = ClienteId FROM Cliente
	WHERE UPPER(RTRIM(Nombre)) = UPPER(RTRIM(@Nombre))
	AND ConsultoraID = @ConsultoraID
	AND Activo = 1

	SELECT ISNULL(@ClienteId,0) AS ClienteId
END
GO