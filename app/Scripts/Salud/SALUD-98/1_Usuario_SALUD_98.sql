USE BelcorpPeru
GO

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int default(0);

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit default(0);
go

USE BelcorpMexico
GO

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int default(0);

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit default(0);
go

USE BelcorpColombia
GO

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int default(0);

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit default(0);
go

USE BelcorpSalvador
GO

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int default(0);

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit default(0);
go

USE BelcorpPuertoRico
GO

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int default(0);

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit default(0);
go

USE BelcorpPanama
GO

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int default(0);

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit default(0);
go

USE BelcorpGuatemala
GO

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int default(0);

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit default(0);
go

USE BelcorpEcuador
GO

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int default(0);

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit default(0);
go

USE BelcorpDominicana
GO

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int default(0);

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit default(0);
go

USE BelcorpCostaRica
GO

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int default(0);

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit default(0);
go

USE BelcorpChile
GO

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int default(0);

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit default(0);
go

USE BelcorpBolivia
GO

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int default(0);

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF not EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit default(0);
go