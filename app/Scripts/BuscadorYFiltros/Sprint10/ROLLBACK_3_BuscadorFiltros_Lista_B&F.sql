GO
USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO

GO
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO

GO
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO

GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO

GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO

GO
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO

GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO

GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO

GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO

GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO

GO
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO

GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO