USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Usuario' and column_name='VerificacionEstadoActividad')
BEGIN
	ALTER TABLE Usuario drop column VerificacionEstadoActividad
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Usuario' and column_name='VerificacionEstadoActividad')
BEGIN
	ALTER TABLE Usuario drop column VerificacionEstadoActividad
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Usuario' and column_name='VerificacionEstadoActividad')
BEGIN
	ALTER TABLE Usuario drop column VerificacionEstadoActividad
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Usuario' and column_name='VerificacionEstadoActividad')
BEGIN
	ALTER TABLE Usuario drop column VerificacionEstadoActividad
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Usuario' and column_name='VerificacionEstadoActividad')
BEGIN
	ALTER TABLE Usuario drop column VerificacionEstadoActividad
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Usuario' and column_name='VerificacionEstadoActividad')
BEGIN
	ALTER TABLE Usuario drop column VerificacionEstadoActividad
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Usuario' and column_name='VerificacionEstadoActividad')
BEGIN
	ALTER TABLE Usuario drop column VerificacionEstadoActividad
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Usuario' and column_name='VerificacionEstadoActividad')
BEGIN
	ALTER TABLE Usuario drop column VerificacionEstadoActividad
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Usuario' and column_name='VerificacionEstadoActividad')
BEGIN
	ALTER TABLE Usuario drop column VerificacionEstadoActividad
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Usuario' and column_name='VerificacionEstadoActividad')
BEGIN
	ALTER TABLE Usuario drop column VerificacionEstadoActividad
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Usuario' and column_name='VerificacionEstadoActividad')
BEGIN
	ALTER TABLE Usuario drop column VerificacionEstadoActividad
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='dbo' and table_name='Usuario' and column_name='VerificacionEstadoActividad')
BEGIN
	ALTER TABLE Usuario drop column VerificacionEstadoActividad
END
GO

