USE BelcorpPeru
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO


USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO


USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO


USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[GetActualizacionEmail]
GO