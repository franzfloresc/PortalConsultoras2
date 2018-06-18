USE [BelcorpPeru] 
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GETCATEGORIA]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GETCATEGORIA
GO
CREATE PROCEDURE dbo.GETCATEGORIA
AS
BEGIN
	SELECT DISTINCT CodigoCategoria	,DescripcionCategoria	,Eliminado   FROM  ods.SAP_CATEGORIA ORDER BY  DescripcionCategoria ASC 
END
GO

USE [BelcorpBolivia]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GETCATEGORIA]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GETCATEGORIA
GO
CREATE PROCEDURE dbo.GETCATEGORIA
AS
BEGIN
	SELECT DISTINCT CodigoCategoria	,DescripcionCategoria	,Eliminado   FROM  ods.SAP_CATEGORIA ORDER BY  DescripcionCategoria ASC 
END
GO

USE [BelcorpChile]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GETCATEGORIA]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GETCATEGORIA
GO
CREATE PROCEDURE dbo.GETCATEGORIA
AS
BEGIN
	SELECT DISTINCT CodigoCategoria	,DescripcionCategoria	,Eliminado   FROM  ods.SAP_CATEGORIA ORDER BY  DescripcionCategoria ASC 
END
GO

USE [BelcorpColombia]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GETCATEGORIA]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GETCATEGORIA
GO
CREATE PROCEDURE dbo.GETCATEGORIA
AS
BEGIN
	SELECT DISTINCT CodigoCategoria	,DescripcionCategoria	,Eliminado   FROM  ods.SAP_CATEGORIA ORDER BY  DescripcionCategoria ASC 
END
GO

USE [BelcorpCostaRica]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GETCATEGORIA]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GETCATEGORIA
GO
CREATE PROCEDURE dbo.GETCATEGORIA
AS
BEGIN
	SELECT DISTINCT CodigoCategoria	,DescripcionCategoria	,Eliminado   FROM  ods.SAP_CATEGORIA ORDER BY  DescripcionCategoria ASC 
END
GO

USE [BelcorpDominicana]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GETCATEGORIA]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GETCATEGORIA
GO
CREATE PROCEDURE dbo.GETCATEGORIA
AS
BEGIN
	SELECT DISTINCT CodigoCategoria	,DescripcionCategoria	,Eliminado   FROM  ods.SAP_CATEGORIA ORDER BY  DescripcionCategoria ASC 
END
GO

USE [BelcorpEcuador]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GETCATEGORIA]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GETCATEGORIA
GO
CREATE PROCEDURE dbo.GETCATEGORIA
AS
BEGIN
	SELECT DISTINCT CodigoCategoria	,DescripcionCategoria	,Eliminado   FROM  ods.SAP_CATEGORIA ORDER BY  DescripcionCategoria ASC 
END
GO

USE [BelcorpGuatemala]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GETCATEGORIA]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GETCATEGORIA
GO
CREATE PROCEDURE dbo.GETCATEGORIA
AS
BEGIN
	SELECT DISTINCT CodigoCategoria	,DescripcionCategoria	,Eliminado   FROM  ods.SAP_CATEGORIA ORDER BY  DescripcionCategoria ASC 
END
GO

USE [BelcorpMexico]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GETCATEGORIA]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GETCATEGORIA
GO
CREATE PROCEDURE dbo.GETCATEGORIA
AS
BEGIN
	SELECT DISTINCT CodigoCategoria	,DescripcionCategoria	,Eliminado   FROM  ods.SAP_CATEGORIA ORDER BY  DescripcionCategoria ASC 
END
GO

USE [BelcorpPanama]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GETCATEGORIA]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GETCATEGORIA
GO
CREATE PROCEDURE dbo.GETCATEGORIA
AS
BEGIN
	SELECT DISTINCT CodigoCategoria	,DescripcionCategoria	,Eliminado   FROM  ods.SAP_CATEGORIA ORDER BY  DescripcionCategoria ASC 
END
GO

USE [BelcorpPuertoRico]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GETCATEGORIA]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GETCATEGORIA
GO
CREATE PROCEDURE dbo.GETCATEGORIA
AS
BEGIN
	SELECT DISTINCT CodigoCategoria	,DescripcionCategoria	,Eliminado   FROM  ods.SAP_CATEGORIA ORDER BY  DescripcionCategoria ASC 
END
GO

USE [BelcorpSalvador]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GETCATEGORIA]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GETCATEGORIA
GO
CREATE PROCEDURE dbo.GETCATEGORIA
AS
BEGIN
	SELECT DISTINCT CodigoCategoria	,DescripcionCategoria	,Eliminado   FROM  ods.SAP_CATEGORIA ORDER BY  DescripcionCategoria ASC 
END
GO

USE [BelcorpVenezuela]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GETCATEGORIA]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GETCATEGORIA
GO
CREATE PROCEDURE dbo.GETCATEGORIA
AS
BEGIN
	SELECT DISTINCT CodigoCategoria	,DescripcionCategoria	,Eliminado   FROM  ods.SAP_CATEGORIA ORDER BY  DescripcionCategoria ASC 
END
GO

