USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'DescripcionComercial'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
    ALTER TABLE MatrizComercialImagen DROP DescripcionComercial;
END



USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'DescripcionComercial'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
    ALTER TABLE MatrizComercialImagen DROP DescripcionComercial;
END

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'DescripcionComercial'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
    ALTER TABLE MatrizComercialImagen DROP DescripcionComercial;
END

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'DescripcionComercial'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
    ALTER TABLE MatrizComercialImagen DROP DescripcionComercial;
END

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'DescripcionComercial'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
    ALTER TABLE MatrizComercialImagen DROP DescripcionComercial;
END

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'DescripcionComercial'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
    ALTER TABLE MatrizComercialImagen DROP DescripcionComercial;
END

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'DescripcionComercial'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
    ALTER TABLE MatrizComercialImagen DROP DescripcionComercial;
END

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'DescripcionComercial'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
    ALTER TABLE MatrizComercialImagen DROP DescripcionComercial;
END

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'DescripcionComercial'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
    ALTER TABLE MatrizComercialImagen DROP DescripcionComercial;
END

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'DescripcionComercial'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
    ALTER TABLE MatrizComercialImagen DROP DescripcionComercial;
END

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'DescripcionComercial'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
    ALTER TABLE MatrizComercialImagen DROP DescripcionComercial;
END

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'DescripcionComercial'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
    ALTER TABLE MatrizComercialImagen DROP DescripcionComercial;
END

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'DescripcionComercial'
          AND Object_ID = Object_ID(N'MatrizComercialImagen'))
BEGIN
    ALTER TABLE MatrizComercialImagen DROP DescripcionComercial;
END


