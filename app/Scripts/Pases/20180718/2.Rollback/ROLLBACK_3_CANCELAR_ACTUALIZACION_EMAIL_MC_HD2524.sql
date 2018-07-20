USE BelcorpPeru
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO


USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO


USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO


USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[CancelarAtualizacionEmail]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[CancelarAtualizacionEmail]
GO
