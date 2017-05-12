USE BelcorpBolivia
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	DROP COLUMN TienePersonalizacion;
END

GO
USE BelcorpCostaRica
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	DROP COLUMN TienePersonalizacion;
END

GO
USE BelcorpChile
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	DROP COLUMN TienePersonalizacion;
END

GO
USE BelcorpColombia
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	DROP COLUMN TienePersonalizacion;
END

GO
USE BelcorpDominicana
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	DROP COLUMN TienePersonalizacion;
END

GO
USE BelcorpEcuador
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	DROP COLUMN TienePersonalizacion;
END

GO
USE BelcorpGuatemala
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	DROP COLUMN TienePersonalizacion;
END

GO
USE BelcorpMexico
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	DROP COLUMN TienePersonalizacion;
END

GO
USE BelcorpPanama
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	DROP COLUMN TienePersonalizacion;
END

GO
USE BelcorpPeru
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	DROP COLUMN TienePersonalizacion;
END

GO
USE BelcorpPuertoRico
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	DROP COLUMN TienePersonalizacion;
END

GO
USE BelcorpSalvador
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	DROP COLUMN TienePersonalizacion;
END

GO
USE BelcorpVenezuela
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	DROP COLUMN TienePersonalizacion;
END

GO
