USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetCuvSuscripcionSE]

GO
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetCuvSuscripcionSE]

GO
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetCuvSuscripcionSE]

GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetCuvSuscripcionSE]

GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetCuvSuscripcionSE]

GO
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetCuvSuscripcionSE]

GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetCuvSuscripcionSE]

GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetCuvSuscripcionSE]

GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetCuvSuscripcionSE]

GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetCuvSuscripcionSE]

GO
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetCuvSuscripcionSE]

GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCuvSuscripcionSE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetCuvSuscripcionSE]

GO
