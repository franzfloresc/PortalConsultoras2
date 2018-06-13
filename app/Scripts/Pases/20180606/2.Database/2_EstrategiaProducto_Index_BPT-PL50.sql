GO
USE BelcorpPeru
GO
GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2' AND object_id = OBJECT_ID('EstrategiaProducto')
)
begin
	DROP INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2] ON [dbo].[EstrategiaProducto];
end
GO

GO
CREATE NONCLUSTERED INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2]
ON [dbo].[EstrategiaProducto] ([EstrategiaId],[Campania],[CUV2])

GO


GO
USE BelcorpMexico
GO
GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2' AND object_id = OBJECT_ID('EstrategiaProducto')
)
begin
	DROP INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2] ON [dbo].[EstrategiaProducto];
end
GO

GO
CREATE NONCLUSTERED INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2]
ON [dbo].[EstrategiaProducto] ([EstrategiaId],[Campania],[CUV2])

GO


GO
USE BelcorpColombia
GO
GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2' AND object_id = OBJECT_ID('EstrategiaProducto')
)
begin
	DROP INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2] ON [dbo].[EstrategiaProducto];
end
GO

GO
CREATE NONCLUSTERED INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2]
ON [dbo].[EstrategiaProducto] ([EstrategiaId],[Campania],[CUV2])

GO


GO
USE BelcorpSalvador
GO
GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2' AND object_id = OBJECT_ID('EstrategiaProducto')
)
begin
	DROP INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2] ON [dbo].[EstrategiaProducto];
end
GO

GO
CREATE NONCLUSTERED INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2]
ON [dbo].[EstrategiaProducto] ([EstrategiaId],[Campania],[CUV2])

GO


GO
USE BelcorpPuertoRico
GO
GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2' AND object_id = OBJECT_ID('EstrategiaProducto')
)
begin
	DROP INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2] ON [dbo].[EstrategiaProducto];
end
GO

GO
CREATE NONCLUSTERED INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2]
ON [dbo].[EstrategiaProducto] ([EstrategiaId],[Campania],[CUV2])

GO


GO
USE BelcorpPanama
GO
GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2' AND object_id = OBJECT_ID('EstrategiaProducto')
)
begin
	DROP INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2] ON [dbo].[EstrategiaProducto];
end
GO

GO
CREATE NONCLUSTERED INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2]
ON [dbo].[EstrategiaProducto] ([EstrategiaId],[Campania],[CUV2])

GO


GO
USE BelcorpGuatemala
GO
GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2' AND object_id = OBJECT_ID('EstrategiaProducto')
)
begin
	DROP INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2] ON [dbo].[EstrategiaProducto];
end
GO

GO
CREATE NONCLUSTERED INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2]
ON [dbo].[EstrategiaProducto] ([EstrategiaId],[Campania],[CUV2])

GO


GO
USE BelcorpEcuador
GO
GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2' AND object_id = OBJECT_ID('EstrategiaProducto')
)
begin
	DROP INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2] ON [dbo].[EstrategiaProducto];
end
GO

GO
CREATE NONCLUSTERED INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2]
ON [dbo].[EstrategiaProducto] ([EstrategiaId],[Campania],[CUV2])

GO


GO
USE BelcorpDominicana
GO
GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2' AND object_id = OBJECT_ID('EstrategiaProducto')
)
begin
	DROP INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2] ON [dbo].[EstrategiaProducto];
end
GO

GO
CREATE NONCLUSTERED INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2]
ON [dbo].[EstrategiaProducto] ([EstrategiaId],[Campania],[CUV2])

GO


GO
USE BelcorpCostaRica
GO
GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2' AND object_id = OBJECT_ID('EstrategiaProducto')
)
begin
	DROP INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2] ON [dbo].[EstrategiaProducto];
end
GO

GO
CREATE NONCLUSTERED INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2]
ON [dbo].[EstrategiaProducto] ([EstrategiaId],[Campania],[CUV2])

GO


GO
USE BelcorpChile
GO
GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2' AND object_id = OBJECT_ID('EstrategiaProducto')
)
begin
	DROP INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2] ON [dbo].[EstrategiaProducto];
end
GO

GO
CREATE NONCLUSTERED INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2]
ON [dbo].[EstrategiaProducto] ([EstrategiaId],[Campania],[CUV2])

GO


GO
USE BelcorpBolivia
GO
GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2' AND object_id = OBJECT_ID('EstrategiaProducto')
)
begin
	DROP INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2] ON [dbo].[EstrategiaProducto];
end
GO

GO
CREATE NONCLUSTERED INDEX [EstrategiaProducto_Index_EstrategiaIdCampaniaCUV2]
ON [dbo].[EstrategiaProducto] ([EstrategiaId],[Campania],[CUV2])

GO


GO
