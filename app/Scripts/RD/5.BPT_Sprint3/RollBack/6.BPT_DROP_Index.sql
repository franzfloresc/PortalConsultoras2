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

