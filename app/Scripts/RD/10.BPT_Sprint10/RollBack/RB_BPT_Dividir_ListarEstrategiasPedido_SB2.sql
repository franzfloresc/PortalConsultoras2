go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasPackNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasLanzamiento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
GO
go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOPT]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOPT]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasRevistaDigital]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOfertaWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
GO
