USE BelcorpBolivia
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	ADD TienePersonalizacion bit;
END

GO
USE BelcorpCostaRica
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	ADD TienePersonalizacion bit;
END

GO
USE BelcorpChile
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	ADD TienePersonalizacion bit;
END

GO
USE BelcorpColombia
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	ADD TienePersonalizacion bit;
END

GO
USE BelcorpDominicana
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	ADD TienePersonalizacion bit;
END

GO
USE BelcorpEcuador
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	ADD TienePersonalizacion bit;
END

GO
USE BelcorpGuatemala
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	ADD TienePersonalizacion bit;
END

GO
USE BelcorpMexico
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	ADD TienePersonalizacion bit;
END

GO
USE BelcorpPanama
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	ADD TienePersonalizacion bit;
END

GO
USE BelcorpPeru
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	ADD TienePersonalizacion bit;
END

GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	ADD TienePersonalizacion bit;
END

GO
USE BelcorpSalvador
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	ADD TienePersonalizacion bit;
END

GO
USE BelcorpVenezuela
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TienePersonalizacion'
          AND Object_ID = Object_ID(N'ShowRoom.Evento'))
BEGIN
	ALTER TABLE ShowRoom.Evento
	ADD TienePersonalizacion bit;
END

GO
