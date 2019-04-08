USE BelcorpPeru
GO

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado
go

USE BelcorpMexico
GO

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado
go

USE BelcorpColombia
GO

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado
go

USE BelcorpSalvador
GO

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado
go

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado
go

USE BelcorpPanama
GO

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado
go

USE BelcorpGuatemala
GO

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado
go

USE BelcorpEcuador
GO

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado
go

USE BelcorpDominicana
GO

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado
go

USE BelcorpCostaRica
GO

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado
go

USE BelcorpChile
GO

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado
go

USE BelcorpBolivia
GO

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado
go

