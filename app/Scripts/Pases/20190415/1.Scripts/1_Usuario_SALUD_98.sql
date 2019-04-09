USE BelcorpPeru
GO
IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int CONSTRAINT DF_Usuario_CantidadIntentoLogueo default(0);

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit CONSTRAINT DF_Usuario_Bloqueado default(0);
GO

USE BelcorpMexico
GO
IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int CONSTRAINT DF_Usuario_CantidadIntentoLogueo default(0);

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit CONSTRAINT DF_Usuario_Bloqueado default(0);
GO

USE BelcorpColombia
GO
IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int CONSTRAINT DF_Usuario_CantidadIntentoLogueo default(0);

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit CONSTRAINT DF_Usuario_Bloqueado default(0);
GO

USE BelcorpSalvador
GO
IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int CONSTRAINT DF_Usuario_CantidadIntentoLogueo default(0);

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit CONSTRAINT DF_Usuario_Bloqueado default(0);
GO

USE BelcorpPuertoRico
GO
IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int CONSTRAINT DF_Usuario_CantidadIntentoLogueo default(0);

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit CONSTRAINT DF_Usuario_Bloqueado default(0);
GO

USE BelcorpPanama
GO
IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int CONSTRAINT DF_Usuario_CantidadIntentoLogueo default(0);

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit CONSTRAINT DF_Usuario_Bloqueado default(0);
GO

USE BelcorpGuatemala
GO
IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int CONSTRAINT DF_Usuario_CantidadIntentoLogueo default(0);

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit CONSTRAINT DF_Usuario_Bloqueado default(0);
GO

USE BelcorpEcuador
GO
IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int CONSTRAINT DF_Usuario_CantidadIntentoLogueo default(0);

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit CONSTRAINT DF_Usuario_Bloqueado default(0);
GO

USE BelcorpDominicana
GO
IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int CONSTRAINT DF_Usuario_CantidadIntentoLogueo default(0);

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit CONSTRAINT DF_Usuario_Bloqueado default(0);
GO

USE BelcorpCostaRica
GO
IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int CONSTRAINT DF_Usuario_CantidadIntentoLogueo default(0);

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit CONSTRAINT DF_Usuario_Bloqueado default(0);
GO

USE BelcorpChile
GO
IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int CONSTRAINT DF_Usuario_CantidadIntentoLogueo default(0);

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit CONSTRAINT DF_Usuario_Bloqueado default(0);
GO

USE BelcorpBolivia
GO
IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD CantidadIntentoLogueo int CONSTRAINT DF_Usuario_CantidadIntentoLogueo default(0);

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
	ALTER TABLE [dbo].[Usuario] ADD FechaUltimoIntentoLogueo datetime NULL;

IF NOT EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
	ALTER TABLE [dbo].[Usuario] ADD Bloqueado bit CONSTRAINT DF_Usuario_Bloqueado default(0);
GO