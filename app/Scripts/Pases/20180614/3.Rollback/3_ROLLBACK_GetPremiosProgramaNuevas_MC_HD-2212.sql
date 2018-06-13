USE [BelcorpPeru]  
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO

USE [BelcorpBolivia]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO

USE [BelcorpChile]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO

USE [BelcorpColombia]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO

USE [BelcorpCostaRica]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO

USE [BelcorpDominicana]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO

USE [BelcorpEcuador]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO

USE [BelcorpGuatemala]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO

USE [BelcorpMexico]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO

USE [BelcorpPanama]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO

USE [BelcorpPuertoRico]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO

USE [BelcorpSalvador]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.GetPremiosProgramaNuevas') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetPremiosProgramaNuevas
GO
