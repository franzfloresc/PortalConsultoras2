﻿USE [BelcorpBolivia];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
GO
USE [BelcorpChile];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
GO
USE [BelcorpColombia];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
GO
USE [BelcorpCostaRica];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
GO
USE [BelcorpDominicana];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
GO
USE [BelcorpEcuador];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
GO
USE [BelcorpGuatemala];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
GO
USE [BelcorpMexico];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
GO
USE [BelcorpPanama];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
GO
USE [BelcorpPeru];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
GO
USE [BelcorpPuertoRico];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
GO
USE [BelcorpSalvador];
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarPopupsValidador]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarPopupsValidador]
GO
GO