USE BelcorpBolivia
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto' AND object_id = OBJECT_ID('EstrategiaProducto'))
BEGIN
  DROP INDEX dbo.EstrategiaProducto.INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
END
CREATE NONCLUSTERED INDEX INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
ON dbo.EstrategiaProducto (Campania)
INCLUDE (EstrategiaId,NombreProducto,Descripcion1,ImagenProducto)
GO
USE BelcorpChile
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto' AND object_id = OBJECT_ID('EstrategiaProducto'))
BEGIN
  DROP INDEX dbo.EstrategiaProducto.INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
END
CREATE NONCLUSTERED INDEX INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
ON dbo.EstrategiaProducto (Campania)
INCLUDE (EstrategiaId,NombreProducto,Descripcion1,ImagenProducto)
GO
USE BelcorpColombia
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto' AND object_id = OBJECT_ID('EstrategiaProducto'))
BEGIN
  DROP INDEX dbo.EstrategiaProducto.INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
END
CREATE NONCLUSTERED INDEX INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
ON dbo.EstrategiaProducto (Campania)
INCLUDE (EstrategiaId,NombreProducto,Descripcion1,ImagenProducto)
GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto' AND object_id = OBJECT_ID('EstrategiaProducto'))
BEGIN
  DROP INDEX dbo.EstrategiaProducto.INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
END
CREATE NONCLUSTERED INDEX INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
ON dbo.EstrategiaProducto (Campania)
INCLUDE (EstrategiaId,NombreProducto,Descripcion1,ImagenProducto)
GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto' AND object_id = OBJECT_ID('EstrategiaProducto'))
BEGIN
  DROP INDEX dbo.EstrategiaProducto.INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
END
CREATE NONCLUSTERED INDEX INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
ON dbo.EstrategiaProducto (Campania)
INCLUDE (EstrategiaId,NombreProducto,Descripcion1,ImagenProducto)
GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto' AND object_id = OBJECT_ID('EstrategiaProducto'))
BEGIN
  DROP INDEX dbo.EstrategiaProducto.INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
END
CREATE NONCLUSTERED INDEX INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
ON dbo.EstrategiaProducto (Campania)
INCLUDE (EstrategiaId,NombreProducto,Descripcion1,ImagenProducto)
GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto' AND object_id = OBJECT_ID('EstrategiaProducto'))
BEGIN
  DROP INDEX dbo.EstrategiaProducto.INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
END
CREATE NONCLUSTERED INDEX INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
ON dbo.EstrategiaProducto (Campania)
INCLUDE (EstrategiaId,NombreProducto,Descripcion1,ImagenProducto)
GO
USE BelcorpMexico
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto' AND object_id = OBJECT_ID('EstrategiaProducto'))
BEGIN
  DROP INDEX dbo.EstrategiaProducto.INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
END
CREATE NONCLUSTERED INDEX INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
ON dbo.EstrategiaProducto (Campania)
INCLUDE (EstrategiaId,NombreProducto,Descripcion1,ImagenProducto)
GO
USE BelcorpPanama
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto' AND object_id = OBJECT_ID('EstrategiaProducto'))
BEGIN
  DROP INDEX dbo.EstrategiaProducto.INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
END
CREATE NONCLUSTERED INDEX INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
ON dbo.EstrategiaProducto (Campania)
INCLUDE (EstrategiaId,NombreProducto,Descripcion1,ImagenProducto)
GO
USE BelcorpPeru
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto' AND object_id = OBJECT_ID('EstrategiaProducto'))
BEGIN
  DROP INDEX dbo.EstrategiaProducto.INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
END
CREATE NONCLUSTERED INDEX INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
ON dbo.EstrategiaProducto (Campania)
INCLUDE (EstrategiaId,NombreProducto,Descripcion1,ImagenProducto)
GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto' AND object_id = OBJECT_ID('EstrategiaProducto'))
BEGIN
  DROP INDEX dbo.EstrategiaProducto.INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
END
CREATE NONCLUSTERED INDEX INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
ON dbo.EstrategiaProducto (Campania)
INCLUDE (EstrategiaId,NombreProducto,Descripcion1,ImagenProducto)
GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto' AND object_id = OBJECT_ID('EstrategiaProducto'))
BEGIN
  DROP INDEX dbo.EstrategiaProducto.INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
END
CREATE NONCLUSTERED INDEX INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
ON dbo.EstrategiaProducto (Campania)
INCLUDE (EstrategiaId,NombreProducto,Descripcion1,ImagenProducto)
GO
USE BelcorpVenezuela
GO
IF EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto' AND object_id = OBJECT_ID('EstrategiaProducto'))
BEGIN
  DROP INDEX dbo.EstrategiaProducto.INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
END
CREATE NONCLUSTERED INDEX INDEX_GetReporteValidacionShowRoomComponentesV2_EstrategiaProducto
ON dbo.EstrategiaProducto (Campania)
INCLUDE (EstrategiaId,NombreProducto,Descripcion1,ImagenProducto)
