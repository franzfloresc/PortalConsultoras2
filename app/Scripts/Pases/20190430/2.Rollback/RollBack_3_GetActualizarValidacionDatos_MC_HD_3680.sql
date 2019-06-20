USE BelcorpBolivia
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarValidacionDatos]
GO

USE BelcorpChile
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarValidacionDatos]
GO

USE BelcorpColombia
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarValidacionDatos]
GO

USE BelcorpCostaRica
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarValidacionDatos]
GO

USE BelcorpDominicana
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarValidacionDatos]
GO

USE BelcorpEcuador
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarValidacionDatos]
GO

USE BelcorpGuatemala
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarValidacionDatos]
GO

USE BelcorpMexico
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarValidacionDatos]
GO

USE BelcorpPanama
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarValidacionDatos]
GO

USE BelcorpPeru
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarValidacionDatos]
GO

USE BelcorpPuertoRico
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarValidacionDatos]
GO

USE BelcorpSalvador
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarValidacionDatos]
GO