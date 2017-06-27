USE BelcorpPeru
GO

GO
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

GO
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

GO
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

GO
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

GO
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

GO
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

GO
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

GO
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

GO
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

GO
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

GO
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

GO
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

GO
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

