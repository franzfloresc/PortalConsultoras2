USE BelcorpBolivia
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	DROP COLUMN NemoTecnico;
END

GO
USE BelcorpCostaRica
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	DROP COLUMN NemoTecnico;
END

GO
USE BelcorpChile
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	DROP COLUMN NemoTecnico;
END

GO
USE BelcorpColombia
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	DROP COLUMN NemoTecnico;
END

GO
USE BelcorpDominicana
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	DROP COLUMN NemoTecnico;
END

GO
USE BelcorpEcuador
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	DROP COLUMN NemoTecnico;
END

GO
USE BelcorpGuatemala
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	DROP COLUMN NemoTecnico;
END

GO
USE BelcorpMexico
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	DROP COLUMN NemoTecnico;
END

GO
USE BelcorpPanama
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	DROP COLUMN NemoTecnico;
END

GO
USE BelcorpPeru
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	DROP COLUMN NemoTecnico;
END

GO
USE BelcorpPuertoRico
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	DROP COLUMN NemoTecnico;
END

GO
USE BelcorpSalvador
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	DROP COLUMN NemoTecnico;
END

GO
USE BelcorpVenezuela
GO
IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'NemoTecnico'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
	ALTER TABLE MatrizComercialImagen
	DROP COLUMN NemoTecnico;
END

GO
