USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[EditarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[EditarDireccionEntrega]
GO

