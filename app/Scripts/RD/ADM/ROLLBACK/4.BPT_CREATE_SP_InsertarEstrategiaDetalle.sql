----------------------------------------------------
-- INSERTAR DETALLE DE ESTRATEGIA (TODOS LOS PAISES)
----------------------------------------------------

USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[InsertarEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategiaDetalle]
GO

