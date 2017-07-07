USE BelcorpBolivia
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	ADD NemoTecnico VARCHAR(100);
END
GO
USE BelcorpCostaRica
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	ADD NemoTecnico VARCHAR(100);
END
GO
USE BelcorpChile
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	ADD NemoTecnico VARCHAR(100);
END
GO
USE BelcorpColombia
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	ADD NemoTecnico VARCHAR(100);
END
GO
USE BelcorpDominicana
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	ADD NemoTecnico VARCHAR(100);
END
GO
USE BelcorpEcuador
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	ADD NemoTecnico VARCHAR(100);
END
GO
USE BelcorpGuatemala
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	ADD NemoTecnico VARCHAR(100);
END
GO
USE BelcorpMexico
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	ADD NemoTecnico VARCHAR(100);
END
GO
USE BelcorpPanama
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	ADD NemoTecnico VARCHAR(100);
END
GO
USE BelcorpPeru
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	ADD NemoTecnico VARCHAR(100);
END
GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	ADD NemoTecnico VARCHAR(100);
END
GO
USE BelcorpSalvador
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	ADD NemoTecnico VARCHAR(100);
END
GO
USE BelcorpVenezuela
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	ADD NemoTecnico VARCHAR(100);
END
GO
