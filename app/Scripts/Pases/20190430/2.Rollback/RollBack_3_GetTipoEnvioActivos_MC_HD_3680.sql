USE BelcorpBolivia
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetTipoEnvioActivos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetTipoEnvioActivos]
GO

USE BelcorpChile
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetTipoEnvioActivos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetTipoEnvioActivos]
GO

USE BelcorpColombia
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetTipoEnvioActivos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetTipoEnvioActivos]
GO

USE BelcorpCostaRica
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetTipoEnvioActivos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetTipoEnvioActivos]
GO

USE BelcorpDominicana
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetTipoEnvioActivos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetTipoEnvioActivos]
GO

USE BelcorpEcuador
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetTipoEnvioActivos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetTipoEnvioActivos]
GO

USE BelcorpGuatemala
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetTipoEnvioActivos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetTipoEnvioActivos]
GO

USE BelcorpMexico
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetTipoEnvioActivos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetTipoEnvioActivos]
GO

USE BelcorpPanama
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetTipoEnvioActivos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetTipoEnvioActivos]
GO

USE BelcorpPeru
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetTipoEnvioActivos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetTipoEnvioActivos]
GO

USE BelcorpPuertoRico
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetTipoEnvioActivos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetTipoEnvioActivos]
GO

USE BelcorpSalvador
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetTipoEnvioActivos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetTipoEnvioActivos]
GO