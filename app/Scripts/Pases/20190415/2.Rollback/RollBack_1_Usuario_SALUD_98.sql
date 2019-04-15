USE BelcorpPeru
GO
IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo')
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_CantidadIntentoLogueo;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
BEGIN
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_Bloqueado;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado;
END
GO

USE BelcorpMexico
GO
IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo')
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_CantidadIntentoLogueo;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
BEGIN
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_Bloqueado;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado;
END
GO

USE BelcorpColombia
GO
IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo')
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_CantidadIntentoLogueo;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
BEGIN
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_Bloqueado;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado;
END
GO

USE BelcorpSalvador
GO
IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo')
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_CantidadIntentoLogueo;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
BEGIN
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_Bloqueado;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado;
END
GO

USE BelcorpPuertoRico
GO
IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo')
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_CantidadIntentoLogueo;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
BEGIN
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_Bloqueado;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado;
END
GO

USE BelcorpPanama
GO
IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo')
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_CantidadIntentoLogueo;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
BEGIN
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_Bloqueado;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado;
END
GO

USE BelcorpGuatemala
GO
IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo')
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_CantidadIntentoLogueo;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
BEGIN
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_Bloqueado;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado;
END
GO

USE BelcorpEcuador
GO
IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo')
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_CantidadIntentoLogueo;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
BEGIN
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_Bloqueado;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado;
END
GO

USE BelcorpDominicana
GO
IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo')
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_CantidadIntentoLogueo;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
BEGIN
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_Bloqueado;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado;
END
GO

USE BelcorpCostaRica
GO
IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo')
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_CantidadIntentoLogueo;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
BEGIN
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_Bloqueado;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado;
END
GO

USE BelcorpChile
GO
IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo')
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_CantidadIntentoLogueo;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
BEGIN
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_Bloqueado;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado;
END
GO

USE BelcorpBolivia
GO
IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='CantidadIntentoLogueo')
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_CantidadIntentoLogueo;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN CantidadIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='FechaUltimoIntentoLogueo') 
BEGIN
	ALTER TABLE [dbo].[Usuario] DROP COLUMN FechaUltimoIntentoLogueo;
END

IF EXISTS (SELECT column_name FROM information_schema.columns WHERE table_name='Usuario' and column_name='Bloqueado') 
BEGIN
	ALTER TABLE [dbo].[Usuario]	DROP CONSTRAINT DF_Usuario_Bloqueado;
	ALTER TABLE [dbo].[Usuario] DROP COLUMN Bloqueado;
END
GO

