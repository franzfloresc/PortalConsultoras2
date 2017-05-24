------------------------------------------------------------------
-- OBTENER DATOS DE LA TABLA ESTRATEGIA DETALLE (TODOS LOS PAISES)
------------------------------------------------------------------
USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetEstrategiaDetalle]
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetEstrategiaDetalle]
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetEstrategiaDetalle]
GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetEstrategiaDetalle]
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetEstrategiaDetalle]
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetEstrategiaDetalle]
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetEstrategiaDetalle]
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetEstrategiaDetalle]
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetEstrategiaDetalle]
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetEstrategiaDetalle]
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetEstrategiaDetalle]
GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetEstrategiaDetalle]
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetEstrategiaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetEstrategiaDetalle]
GO

