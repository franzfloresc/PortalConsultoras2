
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetTokenIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.GetTokenIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE GetTokenIndicadorPedidoAutentico
(
	@ISOPais CHAR(2),
	@CodigoRegion CHAR(2),
	@CodigoZona CHAR(4)
)
AS
BEGIN
	DECLARE @input VARCHAR(50)
	SET @input = @ISOPais + '_' + @CodigoRegion + '_' + @CodigoZona + '_' + CAST(NEXT VALUE FOR dbo.SecuenciaTokenPedido AS VARCHAR)
	
	--SELECT dbo.EncriptarClaveSHA1(@input)
	SELECT @input
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetTokenIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.GetTokenIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE GetTokenIndicadorPedidoAutentico
(
	@ISOPais CHAR(2),
	@CodigoRegion CHAR(2),
	@CodigoZona CHAR(4)
)
AS
BEGIN
	DECLARE @input VARCHAR(50)
	SET @input = @ISOPais + '_' + @CodigoRegion + '_' + @CodigoZona + '_' + CAST(NEXT VALUE FOR dbo.SecuenciaTokenPedido AS VARCHAR)
	
	--SELECT dbo.EncriptarClaveSHA1(@input)
	SELECT @input
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetTokenIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.GetTokenIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE GetTokenIndicadorPedidoAutentico
(
	@ISOPais CHAR(2),
	@CodigoRegion CHAR(2),
	@CodigoZona CHAR(4)
)
AS
BEGIN
	DECLARE @input VARCHAR(50)
	SET @input = @ISOPais + '_' + @CodigoRegion + '_' + @CodigoZona + '_' + CAST(NEXT VALUE FOR dbo.SecuenciaTokenPedido AS VARCHAR)
	
	--SELECT dbo.EncriptarClaveSHA1(@input)
	SELECT @input
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetTokenIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.GetTokenIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE GetTokenIndicadorPedidoAutentico
(
	@ISOPais CHAR(2),
	@CodigoRegion CHAR(2),
	@CodigoZona CHAR(4)
)
AS
BEGIN
	DECLARE @input VARCHAR(50)
	SET @input = @ISOPais + '_' + @CodigoRegion + '_' + @CodigoZona + '_' + CAST(NEXT VALUE FOR dbo.SecuenciaTokenPedido AS VARCHAR)
	
	--SELECT dbo.EncriptarClaveSHA1(@input)
	SELECT @input
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetTokenIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.GetTokenIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE GetTokenIndicadorPedidoAutentico
(
	@ISOPais CHAR(2),
	@CodigoRegion CHAR(2),
	@CodigoZona CHAR(4)
)
AS
BEGIN
	DECLARE @input VARCHAR(50)
	SET @input = @ISOPais + '_' + @CodigoRegion + '_' + @CodigoZona + '_' + CAST(NEXT VALUE FOR dbo.SecuenciaTokenPedido AS VARCHAR)
	
	--SELECT dbo.EncriptarClaveSHA1(@input)
	SELECT @input
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetTokenIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.GetTokenIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE GetTokenIndicadorPedidoAutentico
(
	@ISOPais CHAR(2),
	@CodigoRegion CHAR(2),
	@CodigoZona CHAR(4)
)
AS
BEGIN
	DECLARE @input VARCHAR(50)
	SET @input = @ISOPais + '_' + @CodigoRegion + '_' + @CodigoZona + '_' + CAST(NEXT VALUE FOR dbo.SecuenciaTokenPedido AS VARCHAR)
	
	--SELECT dbo.EncriptarClaveSHA1(@input)
	SELECT @input
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetTokenIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.GetTokenIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE GetTokenIndicadorPedidoAutentico
(
	@ISOPais CHAR(2),
	@CodigoRegion CHAR(2),
	@CodigoZona CHAR(4)
)
AS
BEGIN
	DECLARE @input VARCHAR(50)
	SET @input = @ISOPais + '_' + @CodigoRegion + '_' + @CodigoZona + '_' + CAST(NEXT VALUE FOR dbo.SecuenciaTokenPedido AS VARCHAR)
	
	--SELECT dbo.EncriptarClaveSHA1(@input)
	SELECT @input
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetTokenIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.GetTokenIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE GetTokenIndicadorPedidoAutentico
(
	@ISOPais CHAR(2),
	@CodigoRegion CHAR(2),
	@CodigoZona CHAR(4)
)
AS
BEGIN
	DECLARE @input VARCHAR(50)
	SET @input = @ISOPais + '_' + @CodigoRegion + '_' + @CodigoZona + '_' + CAST(NEXT VALUE FOR dbo.SecuenciaTokenPedido AS VARCHAR)
	
	--SELECT dbo.EncriptarClaveSHA1(@input)
	SELECT @input
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetTokenIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.GetTokenIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE GetTokenIndicadorPedidoAutentico
(
	@ISOPais CHAR(2),
	@CodigoRegion CHAR(2),
	@CodigoZona CHAR(4)
)
AS
BEGIN
	DECLARE @input VARCHAR(50)
	SET @input = @ISOPais + '_' + @CodigoRegion + '_' + @CodigoZona + '_' + CAST(NEXT VALUE FOR dbo.SecuenciaTokenPedido AS VARCHAR)
	
	--SELECT dbo.EncriptarClaveSHA1(@input)
	SELECT @input
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetTokenIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.GetTokenIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE GetTokenIndicadorPedidoAutentico
(
	@ISOPais CHAR(2),
	@CodigoRegion CHAR(2),
	@CodigoZona CHAR(4)
)
AS
BEGIN
	DECLARE @input VARCHAR(50)
	SET @input = @ISOPais + '_' + @CodigoRegion + '_' + @CodigoZona + '_' + CAST(NEXT VALUE FOR dbo.SecuenciaTokenPedido AS VARCHAR)
	
	--SELECT dbo.EncriptarClaveSHA1(@input)
	SELECT @input
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetTokenIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.GetTokenIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE GetTokenIndicadorPedidoAutentico
(
	@ISOPais CHAR(2),
	@CodigoRegion CHAR(2),
	@CodigoZona CHAR(4)
)
AS
BEGIN
	DECLARE @input VARCHAR(50)
	SET @input = @ISOPais + '_' + @CodigoRegion + '_' + @CodigoZona + '_' + CAST(NEXT VALUE FOR dbo.SecuenciaTokenPedido AS VARCHAR)
	
	--SELECT dbo.EncriptarClaveSHA1(@input)
	SELECT @input
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetTokenIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.GetTokenIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE GetTokenIndicadorPedidoAutentico
(
	@ISOPais CHAR(2),
	@CodigoRegion CHAR(2),
	@CodigoZona CHAR(4)
)
AS
BEGIN
	DECLARE @input VARCHAR(50)
	SET @input = @ISOPais + '_' + @CodigoRegion + '_' + @CodigoZona + '_' + CAST(NEXT VALUE FOR dbo.SecuenciaTokenPedido AS VARCHAR)
	
	--SELECT dbo.EncriptarClaveSHA1(@input)
	SELECT @input
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetTokenIndicadorPedidoAutentico'))
BEGIN
    DROP PROCEDURE dbo.GetTokenIndicadorPedidoAutentico
END
GO

CREATE PROCEDURE GetTokenIndicadorPedidoAutentico
(
	@ISOPais CHAR(2),
	@CodigoRegion CHAR(2),
	@CodigoZona CHAR(4)
)
AS
BEGIN
	DECLARE @input VARCHAR(50)
	SET @input = @ISOPais + '_' + @CodigoRegion + '_' + @CodigoZona + '_' + CAST(NEXT VALUE FOR dbo.SecuenciaTokenPedido AS VARCHAR)
	
	--SELECT dbo.EncriptarClaveSHA1(@input)
	SELECT @input
END
GO
