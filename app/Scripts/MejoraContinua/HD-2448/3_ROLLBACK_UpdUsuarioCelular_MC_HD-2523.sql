USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular

GO
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular

GO
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular

GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular

GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular

GO
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular

GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular

GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular

GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular

GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular

GO
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular

GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular

GO