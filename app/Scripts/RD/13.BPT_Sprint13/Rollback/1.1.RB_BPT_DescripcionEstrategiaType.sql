USE BelcorpPeru
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

USE BelcorpMexico
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

USE BelcorpColombia
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

USE BelcorpVenezuela
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

USE BelcorpSalvador
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

USE BelcorpPuertoRico
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

USE BelcorpPanama
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

USE BelcorpGuatemala
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

USE BelcorpEcuador
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

USE BelcorpDominicana
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

USE BelcorpCostaRica
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

USE BelcorpChile
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

USE BelcorpBolivia
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarDescripcionEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarDescripcionEstrategia
GO

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'DescripcionEstrategiaType')
DROP TYPE [dbo].[DescripcionEstrategiaType]
GO

