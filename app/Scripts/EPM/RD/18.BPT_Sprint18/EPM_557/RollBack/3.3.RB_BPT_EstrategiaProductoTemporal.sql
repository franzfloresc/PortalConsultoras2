USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	DROP INDEX EstrategiaProductoTemporaIndex1 
END
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[EstrategiaProductoTemporal]
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	DROP INDEX EstrategiaProductoTemporaIndex1 
END
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[EstrategiaProductoTemporal]
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	DROP INDEX EstrategiaProductoTemporaIndex1 
END
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[EstrategiaProductoTemporal]
END
GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	DROP INDEX EstrategiaProductoTemporaIndex1 
END
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[EstrategiaProductoTemporal]
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	DROP INDEX EstrategiaProductoTemporaIndex1 
END
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[EstrategiaProductoTemporal]
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	DROP INDEX EstrategiaProductoTemporaIndex1 
END
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[EstrategiaProductoTemporal]
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	DROP INDEX EstrategiaProductoTemporaIndex1 
END
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[EstrategiaProductoTemporal]
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	DROP INDEX EstrategiaProductoTemporaIndex1 
END
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[EstrategiaProductoTemporal]
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	DROP INDEX EstrategiaProductoTemporaIndex1 
END
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[EstrategiaProductoTemporal]
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	DROP INDEX EstrategiaProductoTemporaIndex1 
END
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[EstrategiaProductoTemporal]
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	DROP INDEX EstrategiaProductoTemporaIndex1 
END
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[EstrategiaProductoTemporal]
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	DROP INDEX EstrategiaProductoTemporaIndex1 
END
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[EstrategiaProductoTemporal]
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.indexes WHERE name='EstrategiaProductoTemporaIndex1' AND object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]'))
BEGIN
	DROP INDEX EstrategiaProductoTemporaIndex1 
END
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaProductoTemporal]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[EstrategiaProductoTemporal]
END
GO

