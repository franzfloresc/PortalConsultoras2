USE BelcorpPeru
GO

if  exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
DROP INDEX [IX_Estrategia_TipoEstrategiaIDActivo] ON [dbo].[Estrategia]

GO

if exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		DROP INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle
go
 if not exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
	CREATE NONCLUSTERED INDEX [IX_Estrategia_TipoEstrategiaIDActivo]
	ON [dbo].[Estrategia] ([TipoEstrategiaID],[Activo])
	INCLUDE ([EstrategiaID],[CampaniaID],[ImagenURL],[LimiteVenta],[DescripcionCUV2],[EtiquetaID],[Precio],[CUV2],[EtiquetaID2],[Precio2],[TextoLibre],[ColorFondo],[FlagEstrella],[CodigoEstrategia],[TieneVariedad])

GO

GO
if not exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		CREATE NONCLUSTERED INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosId) 
		INCLUDE (Valor)

go

USE BelcorpMexico
GO

if  exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
DROP INDEX [IX_Estrategia_TipoEstrategiaIDActivo] ON [dbo].[Estrategia]

GO

if exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		DROP INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle
go
 if not exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
	CREATE NONCLUSTERED INDEX [IX_Estrategia_TipoEstrategiaIDActivo]
	ON [dbo].[Estrategia] ([TipoEstrategiaID],[Activo])
	INCLUDE ([EstrategiaID],[CampaniaID],[ImagenURL],[LimiteVenta],[DescripcionCUV2],[EtiquetaID],[Precio],[CUV2],[EtiquetaID2],[Precio2],[TextoLibre],[ColorFondo],[FlagEstrella],[CodigoEstrategia],[TieneVariedad])

GO

GO
if not exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		CREATE NONCLUSTERED INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosId) 
		INCLUDE (Valor)

go

USE BelcorpColombia
GO

if  exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
DROP INDEX [IX_Estrategia_TipoEstrategiaIDActivo] ON [dbo].[Estrategia]

GO

if exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		DROP INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle
go
 if not exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
	CREATE NONCLUSTERED INDEX [IX_Estrategia_TipoEstrategiaIDActivo]
	ON [dbo].[Estrategia] ([TipoEstrategiaID],[Activo])
	INCLUDE ([EstrategiaID],[CampaniaID],[ImagenURL],[LimiteVenta],[DescripcionCUV2],[EtiquetaID],[Precio],[CUV2],[EtiquetaID2],[Precio2],[TextoLibre],[ColorFondo],[FlagEstrella],[CodigoEstrategia],[TieneVariedad])

GO

GO
if not exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		CREATE NONCLUSTERED INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosId) 
		INCLUDE (Valor)

go

USE BelcorpVenezuela
GO

if  exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
DROP INDEX [IX_Estrategia_TipoEstrategiaIDActivo] ON [dbo].[Estrategia]

GO

if exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		DROP INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle
go
 if not exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
	CREATE NONCLUSTERED INDEX [IX_Estrategia_TipoEstrategiaIDActivo]
	ON [dbo].[Estrategia] ([TipoEstrategiaID],[Activo])
	INCLUDE ([EstrategiaID],[CampaniaID],[ImagenURL],[LimiteVenta],[DescripcionCUV2],[EtiquetaID],[Precio],[CUV2],[EtiquetaID2],[Precio2],[TextoLibre],[ColorFondo],[FlagEstrella],[CodigoEstrategia],[TieneVariedad])

GO

GO
if not exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		CREATE NONCLUSTERED INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosId) 
		INCLUDE (Valor)

go

USE BelcorpSalvador
GO

if  exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
DROP INDEX [IX_Estrategia_TipoEstrategiaIDActivo] ON [dbo].[Estrategia]

GO

if exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		DROP INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle
go
 if not exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
	CREATE NONCLUSTERED INDEX [IX_Estrategia_TipoEstrategiaIDActivo]
	ON [dbo].[Estrategia] ([TipoEstrategiaID],[Activo])
	INCLUDE ([EstrategiaID],[CampaniaID],[ImagenURL],[LimiteVenta],[DescripcionCUV2],[EtiquetaID],[Precio],[CUV2],[EtiquetaID2],[Precio2],[TextoLibre],[ColorFondo],[FlagEstrella],[CodigoEstrategia],[TieneVariedad])

GO

GO
if not exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		CREATE NONCLUSTERED INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosId) 
		INCLUDE (Valor)

go

USE BelcorpPuertoRico
GO

if  exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
DROP INDEX [IX_Estrategia_TipoEstrategiaIDActivo] ON [dbo].[Estrategia]

GO

if exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		DROP INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle
go
 if not exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
	CREATE NONCLUSTERED INDEX [IX_Estrategia_TipoEstrategiaIDActivo]
	ON [dbo].[Estrategia] ([TipoEstrategiaID],[Activo])
	INCLUDE ([EstrategiaID],[CampaniaID],[ImagenURL],[LimiteVenta],[DescripcionCUV2],[EtiquetaID],[Precio],[CUV2],[EtiquetaID2],[Precio2],[TextoLibre],[ColorFondo],[FlagEstrella],[CodigoEstrategia],[TieneVariedad])

GO

GO
if not exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		CREATE NONCLUSTERED INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosId) 
		INCLUDE (Valor)

go

USE BelcorpPanama
GO

if  exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
DROP INDEX [IX_Estrategia_TipoEstrategiaIDActivo] ON [dbo].[Estrategia]

GO

if exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		DROP INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle
go
 if not exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
	CREATE NONCLUSTERED INDEX [IX_Estrategia_TipoEstrategiaIDActivo]
	ON [dbo].[Estrategia] ([TipoEstrategiaID],[Activo])
	INCLUDE ([EstrategiaID],[CampaniaID],[ImagenURL],[LimiteVenta],[DescripcionCUV2],[EtiquetaID],[Precio],[CUV2],[EtiquetaID2],[Precio2],[TextoLibre],[ColorFondo],[FlagEstrella],[CodigoEstrategia],[TieneVariedad])

GO

GO
if not exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		CREATE NONCLUSTERED INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosId) 
		INCLUDE (Valor)

go

USE BelcorpGuatemala
GO

if  exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
DROP INDEX [IX_Estrategia_TipoEstrategiaIDActivo] ON [dbo].[Estrategia]

GO

if exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		DROP INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle
go
 if not exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
	CREATE NONCLUSTERED INDEX [IX_Estrategia_TipoEstrategiaIDActivo]
	ON [dbo].[Estrategia] ([TipoEstrategiaID],[Activo])
	INCLUDE ([EstrategiaID],[CampaniaID],[ImagenURL],[LimiteVenta],[DescripcionCUV2],[EtiquetaID],[Precio],[CUV2],[EtiquetaID2],[Precio2],[TextoLibre],[ColorFondo],[FlagEstrella],[CodigoEstrategia],[TieneVariedad])

GO

GO
if not exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		CREATE NONCLUSTERED INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosId) 
		INCLUDE (Valor)

go

USE BelcorpEcuador
GO

if  exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
DROP INDEX [IX_Estrategia_TipoEstrategiaIDActivo] ON [dbo].[Estrategia]

GO

if exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		DROP INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle
go
 if not exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
	CREATE NONCLUSTERED INDEX [IX_Estrategia_TipoEstrategiaIDActivo]
	ON [dbo].[Estrategia] ([TipoEstrategiaID],[Activo])
	INCLUDE ([EstrategiaID],[CampaniaID],[ImagenURL],[LimiteVenta],[DescripcionCUV2],[EtiquetaID],[Precio],[CUV2],[EtiquetaID2],[Precio2],[TextoLibre],[ColorFondo],[FlagEstrella],[CodigoEstrategia],[TieneVariedad])

GO

GO
if not exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		CREATE NONCLUSTERED INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosId) 
		INCLUDE (Valor)

go

USE BelcorpDominicana
GO

if  exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
DROP INDEX [IX_Estrategia_TipoEstrategiaIDActivo] ON [dbo].[Estrategia]

GO

if exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		DROP INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle
go
 if not exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
	CREATE NONCLUSTERED INDEX [IX_Estrategia_TipoEstrategiaIDActivo]
	ON [dbo].[Estrategia] ([TipoEstrategiaID],[Activo])
	INCLUDE ([EstrategiaID],[CampaniaID],[ImagenURL],[LimiteVenta],[DescripcionCUV2],[EtiquetaID],[Precio],[CUV2],[EtiquetaID2],[Precio2],[TextoLibre],[ColorFondo],[FlagEstrella],[CodigoEstrategia],[TieneVariedad])

GO

GO
if not exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		CREATE NONCLUSTERED INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosId) 
		INCLUDE (Valor)

go

USE BelcorpCostaRica
GO

if  exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
DROP INDEX [IX_Estrategia_TipoEstrategiaIDActivo] ON [dbo].[Estrategia]

GO

if exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		DROP INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle
go
 if not exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
	CREATE NONCLUSTERED INDEX [IX_Estrategia_TipoEstrategiaIDActivo]
	ON [dbo].[Estrategia] ([TipoEstrategiaID],[Activo])
	INCLUDE ([EstrategiaID],[CampaniaID],[ImagenURL],[LimiteVenta],[DescripcionCUV2],[EtiquetaID],[Precio],[CUV2],[EtiquetaID2],[Precio2],[TextoLibre],[ColorFondo],[FlagEstrella],[CodigoEstrategia],[TieneVariedad])

GO

GO
if not exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		CREATE NONCLUSTERED INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosId) 
		INCLUDE (Valor)

go

USE BelcorpChile
GO

if  exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
DROP INDEX [IX_Estrategia_TipoEstrategiaIDActivo] ON [dbo].[Estrategia]

GO

if exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		DROP INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle
go
 if not exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
	CREATE NONCLUSTERED INDEX [IX_Estrategia_TipoEstrategiaIDActivo]
	ON [dbo].[Estrategia] ([TipoEstrategiaID],[Activo])
	INCLUDE ([EstrategiaID],[CampaniaID],[ImagenURL],[LimiteVenta],[DescripcionCUV2],[EtiquetaID],[Precio],[CUV2],[EtiquetaID2],[Precio2],[TextoLibre],[ColorFondo],[FlagEstrella],[CodigoEstrategia],[TieneVariedad])

GO

GO
if not exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		CREATE NONCLUSTERED INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosId) 
		INCLUDE (Valor)

go

USE BelcorpBolivia
GO

if  exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
DROP INDEX [IX_Estrategia_TipoEstrategiaIDActivo] ON [dbo].[Estrategia]

GO

if exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		DROP INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle
go
 if not exists (
select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'Estrategia')
	and name = 'IX_Estrategia_TipoEstrategiaIDActivo'
)
	CREATE NONCLUSTERED INDEX [IX_Estrategia_TipoEstrategiaIDActivo]
	ON [dbo].[Estrategia] ([TipoEstrategiaID],[Activo])
	INCLUDE ([EstrategiaID],[CampaniaID],[ImagenURL],[LimiteVenta],[DescripcionCUV2],[EtiquetaID],[Precio],[CUV2],[EtiquetaID2],[Precio2],[TextoLibre],[ColorFondo],[FlagEstrella],[CodigoEstrategia],[TieneVariedad])

GO

GO
if not exists (
	select * from sys.indexes
	where object_id = (select object_id from sys.objects where name = 'EstrategiaDetalle')
	and name = 'IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId')
		CREATE NONCLUSTERED INDEX IX_EstrategiaDetalle_EstrategiaIDTablaLogicaDatosId 
		ON dbo.EstrategiaDetalle (EstrategiaID, TablaLogicaDatosId) 
		INCLUDE (Valor)

go

