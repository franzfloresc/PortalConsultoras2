USE BelcorpBolivia
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarFijo]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarFijo]
GO

USE BelcorpChile
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarFijo]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarFijo]
GO

USE BelcorpColombia
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarFijo]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarFijo]
GO

USE BelcorpCostaRica
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarFijo]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarFijo]
GO

USE BelcorpDominicana
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarFijo]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarFijo]
GO

USE BelcorpEcuador
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarFijo]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarFijo]
GO

USE BelcorpGuatemala
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarFijo]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarFijo]
GO

USE BelcorpMexico
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarFijo]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarFijo]
GO

USE BelcorpPanama
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarFijo]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarFijo]
GO

USE BelcorpPeru
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarFijo]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarFijo]
GO

USE BelcorpPuertoRico
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarFijo]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarFijo]
GO

USE BelcorpSalvador
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetActualizarFijo]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetActualizarFijo]
GO