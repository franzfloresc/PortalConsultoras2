USE [BelcorpPeru]  
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO

USE [BelcorpBolivia]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO

USE [BelcorpChile]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO

USE [BelcorpColombia]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO

USE [BelcorpCostaRica]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO

USE [BelcorpDominicana]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO

USE [BelcorpEcuador]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO

USE [BelcorpGuatemala]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO

USE [BelcorpMexico]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO

USE [BelcorpPanama]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO

USE [BelcorpPuertoRico]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO

USE [BelcorpSalvador]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetActivarPremioNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetActivarPremioNuevas
GO
