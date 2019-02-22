USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[InsertarDireccionEntrega]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[InsertarDireccionEntrega]
GO

