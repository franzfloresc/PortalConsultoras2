GO
USE BelcorpPeru
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProductoTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaProductoTemporal')
)
begin
	DROP INDEX [EstrategiaProductoTemporal_Index_NroLote] ON [dbo].[EstrategiaProductoTemporal];
end
GO
CREATE NONCLUSTERED INDEX [EstrategiaProductoTemporal_Index_NroLote]
ON [dbo].[EstrategiaProductoTemporal] ([NumeroLote])
INCLUDE ([Campania],[Cuv],[CuvPadre],[CodigoEstrategia],[Grupo],[CodigoSap],[Cantidad],[PrecioUnitario],[PrecioValorizado],[Orden],[Digitable],[FactorCuadre],[Descripcion],[IdMarca])

GO

GO
USE BelcorpMexico
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProductoTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaProductoTemporal')
)
begin
	DROP INDEX [EstrategiaProductoTemporal_Index_NroLote] ON [dbo].[EstrategiaProductoTemporal];
end
GO
CREATE NONCLUSTERED INDEX [EstrategiaProductoTemporal_Index_NroLote]
ON [dbo].[EstrategiaProductoTemporal] ([NumeroLote])
INCLUDE ([Campania],[Cuv],[CuvPadre],[CodigoEstrategia],[Grupo],[CodigoSap],[Cantidad],[PrecioUnitario],[PrecioValorizado],[Orden],[Digitable],[FactorCuadre],[Descripcion],[IdMarca])

GO

GO
USE BelcorpColombia
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProductoTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaProductoTemporal')
)
begin
	DROP INDEX [EstrategiaProductoTemporal_Index_NroLote] ON [dbo].[EstrategiaProductoTemporal];
end
GO
CREATE NONCLUSTERED INDEX [EstrategiaProductoTemporal_Index_NroLote]
ON [dbo].[EstrategiaProductoTemporal] ([NumeroLote])
INCLUDE ([Campania],[Cuv],[CuvPadre],[CodigoEstrategia],[Grupo],[CodigoSap],[Cantidad],[PrecioUnitario],[PrecioValorizado],[Orden],[Digitable],[FactorCuadre],[Descripcion],[IdMarca])

GO

GO
USE BelcorpSalvador
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProductoTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaProductoTemporal')
)
begin
	DROP INDEX [EstrategiaProductoTemporal_Index_NroLote] ON [dbo].[EstrategiaProductoTemporal];
end
GO
CREATE NONCLUSTERED INDEX [EstrategiaProductoTemporal_Index_NroLote]
ON [dbo].[EstrategiaProductoTemporal] ([NumeroLote])
INCLUDE ([Campania],[Cuv],[CuvPadre],[CodigoEstrategia],[Grupo],[CodigoSap],[Cantidad],[PrecioUnitario],[PrecioValorizado],[Orden],[Digitable],[FactorCuadre],[Descripcion],[IdMarca])

GO

GO
USE BelcorpPuertoRico
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProductoTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaProductoTemporal')
)
begin
	DROP INDEX [EstrategiaProductoTemporal_Index_NroLote] ON [dbo].[EstrategiaProductoTemporal];
end
GO
CREATE NONCLUSTERED INDEX [EstrategiaProductoTemporal_Index_NroLote]
ON [dbo].[EstrategiaProductoTemporal] ([NumeroLote])
INCLUDE ([Campania],[Cuv],[CuvPadre],[CodigoEstrategia],[Grupo],[CodigoSap],[Cantidad],[PrecioUnitario],[PrecioValorizado],[Orden],[Digitable],[FactorCuadre],[Descripcion],[IdMarca])

GO

GO
USE BelcorpPanama
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProductoTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaProductoTemporal')
)
begin
	DROP INDEX [EstrategiaProductoTemporal_Index_NroLote] ON [dbo].[EstrategiaProductoTemporal];
end
GO
CREATE NONCLUSTERED INDEX [EstrategiaProductoTemporal_Index_NroLote]
ON [dbo].[EstrategiaProductoTemporal] ([NumeroLote])
INCLUDE ([Campania],[Cuv],[CuvPadre],[CodigoEstrategia],[Grupo],[CodigoSap],[Cantidad],[PrecioUnitario],[PrecioValorizado],[Orden],[Digitable],[FactorCuadre],[Descripcion],[IdMarca])

GO

GO
USE BelcorpGuatemala
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProductoTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaProductoTemporal')
)
begin
	DROP INDEX [EstrategiaProductoTemporal_Index_NroLote] ON [dbo].[EstrategiaProductoTemporal];
end
GO
CREATE NONCLUSTERED INDEX [EstrategiaProductoTemporal_Index_NroLote]
ON [dbo].[EstrategiaProductoTemporal] ([NumeroLote])
INCLUDE ([Campania],[Cuv],[CuvPadre],[CodigoEstrategia],[Grupo],[CodigoSap],[Cantidad],[PrecioUnitario],[PrecioValorizado],[Orden],[Digitable],[FactorCuadre],[Descripcion],[IdMarca])

GO

GO
USE BelcorpEcuador
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProductoTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaProductoTemporal')
)
begin
	DROP INDEX [EstrategiaProductoTemporal_Index_NroLote] ON [dbo].[EstrategiaProductoTemporal];
end
GO
CREATE NONCLUSTERED INDEX [EstrategiaProductoTemporal_Index_NroLote]
ON [dbo].[EstrategiaProductoTemporal] ([NumeroLote])
INCLUDE ([Campania],[Cuv],[CuvPadre],[CodigoEstrategia],[Grupo],[CodigoSap],[Cantidad],[PrecioUnitario],[PrecioValorizado],[Orden],[Digitable],[FactorCuadre],[Descripcion],[IdMarca])

GO

GO
USE BelcorpDominicana
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProductoTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaProductoTemporal')
)
begin
	DROP INDEX [EstrategiaProductoTemporal_Index_NroLote] ON [dbo].[EstrategiaProductoTemporal];
end
GO
CREATE NONCLUSTERED INDEX [EstrategiaProductoTemporal_Index_NroLote]
ON [dbo].[EstrategiaProductoTemporal] ([NumeroLote])
INCLUDE ([Campania],[Cuv],[CuvPadre],[CodigoEstrategia],[Grupo],[CodigoSap],[Cantidad],[PrecioUnitario],[PrecioValorizado],[Orden],[Digitable],[FactorCuadre],[Descripcion],[IdMarca])

GO

GO
USE BelcorpCostaRica
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProductoTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaProductoTemporal')
)
begin
	DROP INDEX [EstrategiaProductoTemporal_Index_NroLote] ON [dbo].[EstrategiaProductoTemporal];
end
GO
CREATE NONCLUSTERED INDEX [EstrategiaProductoTemporal_Index_NroLote]
ON [dbo].[EstrategiaProductoTemporal] ([NumeroLote])
INCLUDE ([Campania],[Cuv],[CuvPadre],[CodigoEstrategia],[Grupo],[CodigoSap],[Cantidad],[PrecioUnitario],[PrecioValorizado],[Orden],[Digitable],[FactorCuadre],[Descripcion],[IdMarca])

GO

GO
USE BelcorpChile
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProductoTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaProductoTemporal')
)
begin
	DROP INDEX [EstrategiaProductoTemporal_Index_NroLote] ON [dbo].[EstrategiaProductoTemporal];
end
GO
CREATE NONCLUSTERED INDEX [EstrategiaProductoTemporal_Index_NroLote]
ON [dbo].[EstrategiaProductoTemporal] ([NumeroLote])
INCLUDE ([Campania],[Cuv],[CuvPadre],[CodigoEstrategia],[Grupo],[CodigoSap],[Cantidad],[PrecioUnitario],[PrecioValorizado],[Orden],[Digitable],[FactorCuadre],[Descripcion],[IdMarca])

GO

GO
USE BelcorpBolivia
GO

GO
IF EXISTS (  SELECT *
FROM sys.indexes
WHERE name='EstrategiaProductoTemporal_Index_NroLote' AND object_id = OBJECT_ID('EstrategiaProductoTemporal')
)
begin
	DROP INDEX [EstrategiaProductoTemporal_Index_NroLote] ON [dbo].[EstrategiaProductoTemporal];
end
GO
CREATE NONCLUSTERED INDEX [EstrategiaProductoTemporal_Index_NroLote]
ON [dbo].[EstrategiaProductoTemporal] ([NumeroLote])
INCLUDE ([Campania],[Cuv],[CuvPadre],[CodigoEstrategia],[Grupo],[CodigoSap],[Cantidad],[PrecioUnitario],[PrecioValorizado],[Orden],[Digitable],[FactorCuadre],[Descripcion],[IdMarca])

GO

GO
