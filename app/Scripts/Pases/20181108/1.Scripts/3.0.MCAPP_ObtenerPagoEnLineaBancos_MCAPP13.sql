USE BelcorpPeru
GO

/* ObtenerPagoEnLineaBancos */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaBancos', 'P' ) IS NOT NULL)
    DROP PROCEDURE dbo.ObtenerPagoEnLineaBancos;
GO

CREATE PROCEDURE [dbo].[ObtenerPagoEnLineaBancos]
AS
BEGIN
	SELECT [Id] AS Id
      ,[Banco] AS Banco
      ,[URlPaginaWeb] AS URlPaginaWeb
      ,[URLIcono] AS URLIcono
	  ,[URIExternalApp] AS URIExternalApp
      ,[Estado] AS Estado
	FROM [dbo].[PagoEnLineaBancos]
	WHERE EXISTS(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)
	AND [Estado] = 1
END
GO

USE BelcorpMexico
GO

/* ObtenerPagoEnLineaBancos */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaBancos', 'P' ) IS NOT NULL)
    DROP PROCEDURE dbo.ObtenerPagoEnLineaBancos;
GO

CREATE PROCEDURE [dbo].[ObtenerPagoEnLineaBancos]
AS
BEGIN
	SELECT [Id] AS Id
      ,[Banco] AS Banco
      ,[URlPaginaWeb] AS URlPaginaWeb
      ,[URLIcono] AS URLIcono
	  ,[URIExternalApp] AS URIExternalApp
      ,[Estado] AS Estado
	FROM [dbo].[PagoEnLineaBancos]
	WHERE EXISTS(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)
	AND [Estado] = 1
END
GO

USE BelcorpColombia
GO

/* ObtenerPagoEnLineaBancos */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaBancos', 'P' ) IS NOT NULL)
    DROP PROCEDURE dbo.ObtenerPagoEnLineaBancos;
GO

CREATE PROCEDURE [dbo].[ObtenerPagoEnLineaBancos]
AS
BEGIN
	SELECT [Id] AS Id
      ,[Banco] AS Banco
      ,[URlPaginaWeb] AS URlPaginaWeb
      ,[URLIcono] AS URLIcono
	  ,[URIExternalApp] AS URIExternalApp
      ,[Estado] AS Estado
	FROM [dbo].[PagoEnLineaBancos]
	WHERE EXISTS(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)
	AND [Estado] = 1
END
GO

USE BelcorpSalvador
GO

/* ObtenerPagoEnLineaBancos */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaBancos', 'P' ) IS NOT NULL)
    DROP PROCEDURE dbo.ObtenerPagoEnLineaBancos;
GO

CREATE PROCEDURE [dbo].[ObtenerPagoEnLineaBancos]
AS
BEGIN
	SELECT [Id] AS Id
      ,[Banco] AS Banco
      ,[URlPaginaWeb] AS URlPaginaWeb
      ,[URLIcono] AS URLIcono
	  ,[URIExternalApp] AS URIExternalApp
      ,[Estado] AS Estado
	FROM [dbo].[PagoEnLineaBancos]
	WHERE EXISTS(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)
	AND [Estado] = 1
END
GO

USE BelcorpPuertoRico
GO

/* ObtenerPagoEnLineaBancos */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaBancos', 'P' ) IS NOT NULL)
    DROP PROCEDURE dbo.ObtenerPagoEnLineaBancos;
GO

CREATE PROCEDURE [dbo].[ObtenerPagoEnLineaBancos]
AS
BEGIN
	SELECT [Id] AS Id
      ,[Banco] AS Banco
      ,[URlPaginaWeb] AS URlPaginaWeb
      ,[URLIcono] AS URLIcono
	  ,[URIExternalApp] AS URIExternalApp
      ,[Estado] AS Estado
	FROM [dbo].[PagoEnLineaBancos]
	WHERE EXISTS(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)
	AND [Estado] = 1
END
GO

USE BelcorpPanama
GO

/* ObtenerPagoEnLineaBancos */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaBancos', 'P' ) IS NOT NULL)
    DROP PROCEDURE dbo.ObtenerPagoEnLineaBancos;
GO

CREATE PROCEDURE [dbo].[ObtenerPagoEnLineaBancos]
AS
BEGIN
	SELECT [Id] AS Id
      ,[Banco] AS Banco
      ,[URlPaginaWeb] AS URlPaginaWeb
      ,[URLIcono] AS URLIcono
	  ,[URIExternalApp] AS URIExternalApp
      ,[Estado] AS Estado
	FROM [dbo].[PagoEnLineaBancos]
	WHERE EXISTS(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)
	AND [Estado] = 1
END
GO

USE BelcorpGuatemala
GO

/* ObtenerPagoEnLineaBancos */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaBancos', 'P' ) IS NOT NULL)
    DROP PROCEDURE dbo.ObtenerPagoEnLineaBancos;
GO

CREATE PROCEDURE [dbo].[ObtenerPagoEnLineaBancos]
AS
BEGIN
	SELECT [Id] AS Id
      ,[Banco] AS Banco
      ,[URlPaginaWeb] AS URlPaginaWeb
      ,[URLIcono] AS URLIcono
	  ,[URIExternalApp] AS URIExternalApp
      ,[Estado] AS Estado
	FROM [dbo].[PagoEnLineaBancos]
	WHERE EXISTS(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)
	AND [Estado] = 1
END
GO

USE BelcorpEcuador
GO

/* ObtenerPagoEnLineaBancos */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaBancos', 'P' ) IS NOT NULL)
    DROP PROCEDURE dbo.ObtenerPagoEnLineaBancos;
GO

CREATE PROCEDURE [dbo].[ObtenerPagoEnLineaBancos]
AS
BEGIN
	SELECT [Id] AS Id
      ,[Banco] AS Banco
      ,[URlPaginaWeb] AS URlPaginaWeb
      ,[URLIcono] AS URLIcono
	  ,[URIExternalApp] AS URIExternalApp
      ,[Estado] AS Estado
	FROM [dbo].[PagoEnLineaBancos]
	WHERE EXISTS(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)
	AND [Estado] = 1
END
GO

USE BelcorpDominicana
GO

/* ObtenerPagoEnLineaBancos */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaBancos', 'P' ) IS NOT NULL)
    DROP PROCEDURE dbo.ObtenerPagoEnLineaBancos;
GO

CREATE PROCEDURE [dbo].[ObtenerPagoEnLineaBancos]
AS
BEGIN
	SELECT [Id] AS Id
      ,[Banco] AS Banco
      ,[URlPaginaWeb] AS URlPaginaWeb
      ,[URLIcono] AS URLIcono
	  ,[URIExternalApp] AS URIExternalApp
      ,[Estado] AS Estado
	FROM [dbo].[PagoEnLineaBancos]
	WHERE EXISTS(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)
	AND [Estado] = 1
END
GO

USE BelcorpCostaRica
GO

/* ObtenerPagoEnLineaBancos */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaBancos', 'P' ) IS NOT NULL)
    DROP PROCEDURE dbo.ObtenerPagoEnLineaBancos;
GO

CREATE PROCEDURE [dbo].[ObtenerPagoEnLineaBancos]
AS
BEGIN
	SELECT [Id] AS Id
      ,[Banco] AS Banco
      ,[URlPaginaWeb] AS URlPaginaWeb
      ,[URLIcono] AS URLIcono
	  ,[URIExternalApp] AS URIExternalApp
      ,[Estado] AS Estado
	FROM [dbo].[PagoEnLineaBancos]
	WHERE EXISTS(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)
	AND [Estado] = 1
END
GO

USE BelcorpChile
GO

/* ObtenerPagoEnLineaBancos */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaBancos', 'P' ) IS NOT NULL)
    DROP PROCEDURE dbo.ObtenerPagoEnLineaBancos;
GO

CREATE PROCEDURE [dbo].[ObtenerPagoEnLineaBancos]
AS
BEGIN
	SELECT [Id] AS Id
      ,[Banco] AS Banco
      ,[URlPaginaWeb] AS URlPaginaWeb
      ,[URLIcono] AS URLIcono
	  ,[URIExternalApp] AS URIExternalApp
      ,[Estado] AS Estado
	FROM [dbo].[PagoEnLineaBancos]
	WHERE EXISTS(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)
	AND [Estado] = 1
END
GO

USE BelcorpBolivia
GO

/* ObtenerPagoEnLineaBancos */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaBancos', 'P' ) IS NOT NULL)
    DROP PROCEDURE dbo.ObtenerPagoEnLineaBancos;
GO

CREATE PROCEDURE [dbo].[ObtenerPagoEnLineaBancos]
AS
BEGIN
	SELECT [Id] AS Id
      ,[Banco] AS Banco
      ,[URlPaginaWeb] AS URlPaginaWeb
      ,[URLIcono] AS URLIcono
	  ,[URIExternalApp] AS URIExternalApp
      ,[Estado] AS Estado
	FROM [dbo].[PagoEnLineaBancos]
	WHERE EXISTS(SELECT COUNT(1) FROM PagoEnLineaMedioPago WHERE CODIGO='PBI' AND ESTADO =1)
	AND [Estado] = 1
END
GO

