﻿USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoPorPais'))
	DROP PROC dbo.GetMontoMinimoPorPais
GO
CREATE PROC [dbo].[GetMontoMinimoPorPais]
AS
BEGIN
	SELECT max(MontoMinimoPedido) MontoMinimo 
	FROM ods.consultora WITH(NOLOCK) WHERE autorizapedido = 1
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoPorPais'))
	DROP PROC dbo.GetMontoMinimoPorPais
GO
CREATE PROC [dbo].[GetMontoMinimoPorPais]
AS
BEGIN
	SELECT max(MontoMinimoPedido) MontoMinimo 
	FROM ods.consultora WITH(NOLOCK) WHERE autorizapedido = 1
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoPorPais'))
	DROP PROC dbo.GetMontoMinimoPorPais
GO
CREATE PROC [dbo].[GetMontoMinimoPorPais]
AS
BEGIN
	SELECT max(MontoMinimoPedido) MontoMinimo 
	FROM ods.consultora WITH(NOLOCK) WHERE autorizapedido = 1
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoPorPais'))
	DROP PROC dbo.GetMontoMinimoPorPais
GO
CREATE PROC [dbo].[GetMontoMinimoPorPais]
AS
BEGIN
	SELECT max(MontoMinimoPedido) MontoMinimo 
	FROM ods.consultora WITH(NOLOCK) WHERE autorizapedido = 1
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoPorPais'))
	DROP PROC dbo.GetMontoMinimoPorPais
GO
CREATE PROC [dbo].[GetMontoMinimoPorPais]
AS
BEGIN
	SELECT max(MontoMinimoPedido) MontoMinimo 
	FROM ods.consultora WITH(NOLOCK) WHERE autorizapedido = 1
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoPorPais'))
	DROP PROC dbo.GetMontoMinimoPorPais
GO
CREATE PROC [dbo].[GetMontoMinimoPorPais]
AS
BEGIN
	SELECT max(MontoMinimoPedido) MontoMinimo 
	FROM ods.consultora WITH(NOLOCK) WHERE autorizapedido = 1
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoPorPais'))
	DROP PROC dbo.GetMontoMinimoPorPais
GO
CREATE PROC [dbo].[GetMontoMinimoPorPais]
AS
BEGIN
	SELECT max(MontoMinimoPedido) MontoMinimo 
	FROM ods.consultora WITH(NOLOCK) WHERE autorizapedido = 1
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoPorPais'))
	DROP PROC dbo.GetMontoMinimoPorPais
GO
CREATE PROC [dbo].[GetMontoMinimoPorPais]
AS
BEGIN
	SELECT max(MontoMinimoPedido) MontoMinimo 
	FROM ods.consultora WITH(NOLOCK) WHERE autorizapedido = 1
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoPorPais'))
	DROP PROC dbo.GetMontoMinimoPorPais
GO
CREATE PROC [dbo].[GetMontoMinimoPorPais]
AS
BEGIN
	SELECT max(MontoMinimoPedido) MontoMinimo 
	FROM ods.consultora WITH(NOLOCK) WHERE autorizapedido = 1
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoPorPais'))
	DROP PROC dbo.GetMontoMinimoPorPais
GO
CREATE PROC [dbo].[GetMontoMinimoPorPais]
AS
BEGIN
	SELECT max(MontoMinimoPedido) MontoMinimo 
	FROM ods.consultora WITH(NOLOCK) WHERE autorizapedido = 1
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoPorPais'))
	DROP PROC dbo.GetMontoMinimoPorPais
GO
CREATE PROC [dbo].[GetMontoMinimoPorPais]
AS
BEGIN
	SELECT max(MontoMinimoPedido) MontoMinimo 
	FROM ods.consultora WITH(NOLOCK) WHERE autorizapedido = 1
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'P' and id = OBJECT_ID('dbo.GetMontoMinimoPorPais'))
	DROP PROC dbo.GetMontoMinimoPorPais
GO
CREATE PROC [dbo].[GetMontoMinimoPorPais]
AS
BEGIN
	SELECT max(MontoMinimoPedido) MontoMinimo 
	FROM ods.consultora WITH(NOLOCK) WHERE autorizapedido = 1
END
GO

