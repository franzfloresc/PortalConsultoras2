

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetExisteEmailActivo'))
BEGIN
    DROP PROCEDURE dbo.GetExisteEmailActivo
END
GO

CREATE PROCEDURE GetExisteEmailActivo
( @Email VARCHAR(50) )
AS
BEGIN
	DECLARE @f AS BIT
	SELECT TOP 1 @f = 1 FROM Usuario WHERE Email = @Email AND Activo = 1 AND EmailActivo = 1

	IF (ISNULL(@f,0) = 0)
		SET @f = 0

	SELECT @f AS flag
END
GO

/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetExisteEmailActivo'))
BEGIN
    DROP PROCEDURE dbo.GetExisteEmailActivo
END
GO

CREATE PROCEDURE GetExisteEmailActivo
( @Email VARCHAR(50) )
AS
BEGIN
	DECLARE @f AS BIT
	SELECT TOP 1 @f = 1 FROM Usuario WHERE Email = @Email AND Activo = 1 AND EmailActivo = 1

	IF (ISNULL(@f,0) = 0)
		SET @f = 0

	SELECT @f AS flag
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetExisteEmailActivo'))
BEGIN
    DROP PROCEDURE dbo.GetExisteEmailActivo
END
GO

CREATE PROCEDURE GetExisteEmailActivo
( @Email VARCHAR(50) )
AS
BEGIN
	DECLARE @f AS BIT
	SELECT TOP 1 @f = 1 FROM Usuario WHERE Email = @Email AND Activo = 1 AND EmailActivo = 1

	IF (ISNULL(@f,0) = 0)
		SET @f = 0

	SELECT @f AS flag
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetExisteEmailActivo'))
BEGIN
    DROP PROCEDURE dbo.GetExisteEmailActivo
END
GO

CREATE PROCEDURE GetExisteEmailActivo
( @Email VARCHAR(50) )
AS
BEGIN
	DECLARE @f AS BIT
	SELECT TOP 1 @f = 1 FROM Usuario WHERE Email = @Email AND Activo = 1 AND EmailActivo = 1

	IF (ISNULL(@f,0) = 0)
		SET @f = 0

	SELECT @f AS flag
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetExisteEmailActivo'))
BEGIN
    DROP PROCEDURE dbo.GetExisteEmailActivo
END
GO

CREATE PROCEDURE GetExisteEmailActivo
( @Email VARCHAR(50) )
AS
BEGIN
	DECLARE @f AS BIT
	SELECT TOP 1 @f = 1 FROM Usuario WHERE Email = @Email AND Activo = 1 AND EmailActivo = 1

	IF (ISNULL(@f,0) = 0)
		SET @f = 0

	SELECT @f AS flag
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetExisteEmailActivo'))
BEGIN
    DROP PROCEDURE dbo.GetExisteEmailActivo
END
GO

CREATE PROCEDURE GetExisteEmailActivo
( @Email VARCHAR(50) )
AS
BEGIN
	DECLARE @f AS BIT
	SELECT TOP 1 @f = 1 FROM Usuario WHERE Email = @Email AND Activo = 1 AND EmailActivo = 1

	IF (ISNULL(@f,0) = 0)
		SET @f = 0

	SELECT @f AS flag
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetExisteEmailActivo'))
BEGIN
    DROP PROCEDURE dbo.GetExisteEmailActivo
END
GO

CREATE PROCEDURE GetExisteEmailActivo
( @Email VARCHAR(50) )
AS
BEGIN
	DECLARE @f AS BIT
	SELECT TOP 1 @f = 1 FROM Usuario WHERE Email = @Email AND Activo = 1 AND EmailActivo = 1

	IF (ISNULL(@f,0) = 0)
		SET @f = 0

	SELECT @f AS flag
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetExisteEmailActivo'))
BEGIN
    DROP PROCEDURE dbo.GetExisteEmailActivo
END
GO

CREATE PROCEDURE GetExisteEmailActivo
( @Email VARCHAR(50) )
AS
BEGIN
	DECLARE @f AS BIT
	SELECT TOP 1 @f = 1 FROM Usuario WHERE Email = @Email AND Activo = 1 AND EmailActivo = 1

	IF (ISNULL(@f,0) = 0)
		SET @f = 0

	SELECT @f AS flag
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetExisteEmailActivo'))
BEGIN
    DROP PROCEDURE dbo.GetExisteEmailActivo
END
GO

CREATE PROCEDURE GetExisteEmailActivo
( @Email VARCHAR(50) )
AS
BEGIN
	DECLARE @f AS BIT
	SELECT TOP 1 @f = 1 FROM Usuario WHERE Email = @Email AND Activo = 1 AND EmailActivo = 1

	IF (ISNULL(@f,0) = 0)
		SET @f = 0

	SELECT @f AS flag
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetExisteEmailActivo'))
BEGIN
    DROP PROCEDURE dbo.GetExisteEmailActivo
END
GO

CREATE PROCEDURE GetExisteEmailActivo
( @Email VARCHAR(50) )
AS
BEGIN
	DECLARE @f AS BIT
	SELECT TOP 1 @f = 1 FROM Usuario WHERE Email = @Email AND Activo = 1 AND EmailActivo = 1

	IF (ISNULL(@f,0) = 0)
		SET @f = 0

	SELECT @f AS flag
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetExisteEmailActivo'))
BEGIN
    DROP PROCEDURE dbo.GetExisteEmailActivo
END
GO

CREATE PROCEDURE GetExisteEmailActivo
( @Email VARCHAR(50) )
AS
BEGIN
	DECLARE @f AS BIT
	SELECT TOP 1 @f = 1 FROM Usuario WHERE Email = @Email AND Activo = 1 AND EmailActivo = 1

	IF (ISNULL(@f,0) = 0)
		SET @f = 0

	SELECT @f AS flag
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetExisteEmailActivo'))
BEGIN
    DROP PROCEDURE dbo.GetExisteEmailActivo
END
GO

CREATE PROCEDURE GetExisteEmailActivo
( @Email VARCHAR(50) )
AS
BEGIN
	DECLARE @f AS BIT
	SELECT TOP 1 @f = 1 FROM Usuario WHERE Email = @Email AND Activo = 1 AND EmailActivo = 1

	IF (ISNULL(@f,0) = 0)
		SET @f = 0

	SELECT @f AS flag
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetExisteEmailActivo'))
BEGIN
    DROP PROCEDURE dbo.GetExisteEmailActivo
END
GO

CREATE PROCEDURE GetExisteEmailActivo
( @Email VARCHAR(50) )
AS
BEGIN
	DECLARE @f AS BIT
	SELECT TOP 1 @f = 1 FROM Usuario WHERE Email = @Email AND Activo = 1 AND EmailActivo = 1

	IF (ISNULL(@f,0) = 0)
		SET @f = 0

	SELECT @f AS flag
END
GO


