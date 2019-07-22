﻿USE BelcorpBolivia
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ListarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ListarValidacionDatos]
GO

USE BelcorpChile
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ListarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ListarValidacionDatos]
GO

USE BelcorpColombia
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ListarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ListarValidacionDatos]
GO

USE BelcorpCostaRica
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ListarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ListarValidacionDatos]
GO

USE BelcorpDominicana
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ListarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ListarValidacionDatos]
GO

USE BelcorpEcuador
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ListarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ListarValidacionDatos]
GO

USE BelcorpGuatemala
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ListarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ListarValidacionDatos]
GO

USE BelcorpMexico
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ListarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ListarValidacionDatos]
GO

USE BelcorpPanama
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ListarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ListarValidacionDatos]
GO

USE BelcorpPeru
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ListarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ListarValidacionDatos]
GO

USE BelcorpPuertoRico
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ListarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ListarValidacionDatos]
GO

USE BelcorpSalvador
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ListarValidacionDatos]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[ListarValidacionDatos]
GO