USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado

GO
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado

GO
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado

GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado

GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado

GO
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado

GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado

GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado

GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado

GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado

GO
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado

GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.ValidarCodigoIngresado') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.ValidarCodigoIngresado

GO