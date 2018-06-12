GO
USE BelcorpPeru
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLote] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLote]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CUV],[Descripcion],[PrecioOferta],[PrecioTachado],[OfertaUltimoMinuto],[LimiteVenta],[UsuarioCreacion],[FotoProducto01],[CodigoEstrategia],[TieneVariedad],[PrecioPublico],[Ganancia],[Niveles],[CodigoTipoEstrategia])

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CodigoTipoEstrategia])
GO


GO
USE BelcorpMexico
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLote] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLote]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CUV],[Descripcion],[PrecioOferta],[PrecioTachado],[OfertaUltimoMinuto],[LimiteVenta],[UsuarioCreacion],[FotoProducto01],[CodigoEstrategia],[TieneVariedad],[PrecioPublico],[Ganancia],[Niveles],[CodigoTipoEstrategia])

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CodigoTipoEstrategia])
GO


GO
USE BelcorpColombia
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLote] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLote]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CUV],[Descripcion],[PrecioOferta],[PrecioTachado],[OfertaUltimoMinuto],[LimiteVenta],[UsuarioCreacion],[FotoProducto01],[CodigoEstrategia],[TieneVariedad],[PrecioPublico],[Ganancia],[Niveles],[CodigoTipoEstrategia])

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CodigoTipoEstrategia])
GO


GO
USE BelcorpSalvador
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLote] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLote]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CUV],[Descripcion],[PrecioOferta],[PrecioTachado],[OfertaUltimoMinuto],[LimiteVenta],[UsuarioCreacion],[FotoProducto01],[CodigoEstrategia],[TieneVariedad],[PrecioPublico],[Ganancia],[Niveles],[CodigoTipoEstrategia])

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CodigoTipoEstrategia])
GO


GO
USE BelcorpPuertoRico
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLote] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLote]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CUV],[Descripcion],[PrecioOferta],[PrecioTachado],[OfertaUltimoMinuto],[LimiteVenta],[UsuarioCreacion],[FotoProducto01],[CodigoEstrategia],[TieneVariedad],[PrecioPublico],[Ganancia],[Niveles],[CodigoTipoEstrategia])

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CodigoTipoEstrategia])
GO


GO
USE BelcorpPanama
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLote] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLote]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CUV],[Descripcion],[PrecioOferta],[PrecioTachado],[OfertaUltimoMinuto],[LimiteVenta],[UsuarioCreacion],[FotoProducto01],[CodigoEstrategia],[TieneVariedad],[PrecioPublico],[Ganancia],[Niveles],[CodigoTipoEstrategia])

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CodigoTipoEstrategia])
GO


GO
USE BelcorpGuatemala
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLote] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLote]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CUV],[Descripcion],[PrecioOferta],[PrecioTachado],[OfertaUltimoMinuto],[LimiteVenta],[UsuarioCreacion],[FotoProducto01],[CodigoEstrategia],[TieneVariedad],[PrecioPublico],[Ganancia],[Niveles],[CodigoTipoEstrategia])

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CodigoTipoEstrategia])
GO


GO
USE BelcorpEcuador
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLote] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLote]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CUV],[Descripcion],[PrecioOferta],[PrecioTachado],[OfertaUltimoMinuto],[LimiteVenta],[UsuarioCreacion],[FotoProducto01],[CodigoEstrategia],[TieneVariedad],[PrecioPublico],[Ganancia],[Niveles],[CodigoTipoEstrategia])

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CodigoTipoEstrategia])
GO


GO
USE BelcorpDominicana
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLote] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLote]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CUV],[Descripcion],[PrecioOferta],[PrecioTachado],[OfertaUltimoMinuto],[LimiteVenta],[UsuarioCreacion],[FotoProducto01],[CodigoEstrategia],[TieneVariedad],[PrecioPublico],[Ganancia],[Niveles],[CodigoTipoEstrategia])

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CodigoTipoEstrategia])
GO


GO
USE BelcorpCostaRica
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLote] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLote]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CUV],[Descripcion],[PrecioOferta],[PrecioTachado],[OfertaUltimoMinuto],[LimiteVenta],[UsuarioCreacion],[FotoProducto01],[CodigoEstrategia],[TieneVariedad],[PrecioPublico],[Ganancia],[Niveles],[CodigoTipoEstrategia])

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CodigoTipoEstrategia])
GO


GO
USE BelcorpChile
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLote] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLote]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CUV],[Descripcion],[PrecioOferta],[PrecioTachado],[OfertaUltimoMinuto],[LimiteVenta],[UsuarioCreacion],[FotoProducto01],[CodigoEstrategia],[TieneVariedad],[PrecioPublico],[Ganancia],[Niveles],[CodigoTipoEstrategia])

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CodigoTipoEstrategia])
GO


GO
USE BelcorpBolivia
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLote] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLote]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CUV],[Descripcion],[PrecioOferta],[PrecioTachado],[OfertaUltimoMinuto],[LimiteVenta],[UsuarioCreacion],[FotoProducto01],[CodigoEstrategia],[TieneVariedad],[PrecioPublico],[Ganancia],[Niveles],[CodigoTipoEstrategia])

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia' AND object_id = OBJECT_ID('EstrategiaTemporal')
)
begin
	DROP INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia] ON [dbo].[EstrategiaTemporal];
end
GO

CREATE NONCLUSTERED INDEX [EstrategiaTemporal_Index_NroLoteCampaniaTipoEstrategia]
ON [dbo].[EstrategiaTemporal] ([NumeroLote])
INCLUDE ([CampaniaId],[CodigoTipoEstrategia])
GO


GO
