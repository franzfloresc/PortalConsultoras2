USE ODS_BO
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas' AND object_id = OBJECT_ID('OfertasPersonalizadas'))
BEGIN
  DROP INDEX dbo.OfertasPersonalizadas.INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
END
CREATE NONCLUSTERED INDEX INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
ON dbo.OfertasPersonalizadas (TipoPersonalizacion,AnioCampanaVenta)
INCLUDE (CUV,LimUnidades,FlagUltMinuto)
GO
USE ODS_CL
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas' AND object_id = OBJECT_ID('OfertasPersonalizadas'))
BEGIN
  DROP INDEX dbo.OfertasPersonalizadas.INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
END
CREATE NONCLUSTERED INDEX INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
ON dbo.OfertasPersonalizadas (TipoPersonalizacion,AnioCampanaVenta)
INCLUDE (CUV,LimUnidades,FlagUltMinuto)
GO
USE ODS_CO
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas' AND object_id = OBJECT_ID('OfertasPersonalizadas'))
BEGIN
  DROP INDEX dbo.OfertasPersonalizadas.INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
END
CREATE NONCLUSTERED INDEX INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
ON dbo.OfertasPersonalizadas (TipoPersonalizacion,AnioCampanaVenta)
INCLUDE (CUV,LimUnidades,FlagUltMinuto)
GO
USE ODS_CR
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas' AND object_id = OBJECT_ID('OfertasPersonalizadas'))
BEGIN
  DROP INDEX dbo.OfertasPersonalizadas.INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
END
CREATE NONCLUSTERED INDEX INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
ON dbo.OfertasPersonalizadas (TipoPersonalizacion,AnioCampanaVenta)
INCLUDE (CUV,LimUnidades,FlagUltMinuto)
GO
USE ODS_DO
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas' AND object_id = OBJECT_ID('OfertasPersonalizadas'))
BEGIN
  DROP INDEX dbo.OfertasPersonalizadas.INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
END
CREATE NONCLUSTERED INDEX INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
ON dbo.OfertasPersonalizadas (TipoPersonalizacion,AnioCampanaVenta)
INCLUDE (CUV,LimUnidades,FlagUltMinuto)
GO
USE ODS_EC
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas' AND object_id = OBJECT_ID('OfertasPersonalizadas'))
BEGIN
  DROP INDEX dbo.OfertasPersonalizadas.INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
END
CREATE NONCLUSTERED INDEX INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
ON dbo.OfertasPersonalizadas (TipoPersonalizacion,AnioCampanaVenta)
INCLUDE (CUV,LimUnidades,FlagUltMinuto)
GO
USE ODS_GT
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas' AND object_id = OBJECT_ID('OfertasPersonalizadas'))
BEGIN
  DROP INDEX dbo.OfertasPersonalizadas.INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
END
CREATE NONCLUSTERED INDEX INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
ON dbo.OfertasPersonalizadas (TipoPersonalizacion,AnioCampanaVenta)
INCLUDE (CUV,LimUnidades,FlagUltMinuto)
GO
USE ODS_MX
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas' AND object_id = OBJECT_ID('OfertasPersonalizadas'))
BEGIN
  DROP INDEX dbo.OfertasPersonalizadas.INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
END
CREATE NONCLUSTERED INDEX INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
ON dbo.OfertasPersonalizadas (TipoPersonalizacion,AnioCampanaVenta)
INCLUDE (CUV,LimUnidades,FlagUltMinuto)
GO
USE ODS_PA
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas' AND object_id = OBJECT_ID('OfertasPersonalizadas'))
BEGIN
  DROP INDEX dbo.OfertasPersonalizadas.INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
END
CREATE NONCLUSTERED INDEX INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
ON dbo.OfertasPersonalizadas (TipoPersonalizacion,AnioCampanaVenta)
INCLUDE (CUV,LimUnidades,FlagUltMinuto)
GO
USE ODS_PE
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas' AND object_id = OBJECT_ID('OfertasPersonalizadas'))
BEGIN
  DROP INDEX dbo.OfertasPersonalizadas.INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
END
CREATE NONCLUSTERED INDEX INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
ON dbo.OfertasPersonalizadas (TipoPersonalizacion,AnioCampanaVenta)
INCLUDE (CUV,LimUnidades,FlagUltMinuto)
GO
USE ODS_PR
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas' AND object_id = OBJECT_ID('OfertasPersonalizadas'))
BEGIN
  DROP INDEX dbo.OfertasPersonalizadas.INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
END
CREATE NONCLUSTERED INDEX INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
ON dbo.OfertasPersonalizadas (TipoPersonalizacion,AnioCampanaVenta)
INCLUDE (CUV,LimUnidades,FlagUltMinuto)
GO
USE ODS_SV
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas' AND object_id = OBJECT_ID('OfertasPersonalizadas'))
BEGIN
  DROP INDEX dbo.OfertasPersonalizadas.INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
END
CREATE NONCLUSTERED INDEX INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
ON dbo.OfertasPersonalizadas (TipoPersonalizacion,AnioCampanaVenta)
INCLUDE (CUV,LimUnidades,FlagUltMinuto)
GO
USE ODS_VE
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas' AND object_id = OBJECT_ID('OfertasPersonalizadas'))
BEGIN
  DROP INDEX dbo.OfertasPersonalizadas.INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
END
CREATE NONCLUSTERED INDEX INDEX_GetOfertasParaTiByTipoConfigurado_OfertasPersonalizadas
ON dbo.OfertasPersonalizadas (TipoPersonalizacion,AnioCampanaVenta)
INCLUDE (CUV,LimUnidades,FlagUltMinuto)
GO













