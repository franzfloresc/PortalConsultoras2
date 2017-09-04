USE BelcorpPeru
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'CodigoEstrategia'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD CodigoEstrategia VARCHAR(150) NULL;
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'TieneVariedad'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD TieneVariedad INT DEFAULT 0;
END
GO

/*end*/

USE BelcorpMexico
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'CodigoEstrategia'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD CodigoEstrategia VARCHAR(150) NULL;
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'TieneVariedad'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD TieneVariedad INT DEFAULT 0;
END
GO

/*end*/

USE BelcorpColombia
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'CodigoEstrategia'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD CodigoEstrategia VARCHAR(150) NULL;
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'TieneVariedad'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD TieneVariedad INT DEFAULT 0;
END
GO

/*end*/

USE BelcorpVenezuela
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'CodigoEstrategia'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD CodigoEstrategia VARCHAR(150) NULL;
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'TieneVariedad'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD TieneVariedad INT DEFAULT 0;
END
GO

/*end*/

USE BelcorpSalvador
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'CodigoEstrategia'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD CodigoEstrategia VARCHAR(150) NULL;
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'TieneVariedad'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD TieneVariedad INT DEFAULT 0;
END
GO

/*end*/

USE BelcorpPuertoRico
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'CodigoEstrategia'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD CodigoEstrategia VARCHAR(150) NULL;
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'TieneVariedad'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD TieneVariedad INT DEFAULT 0;
END
GO

/*end*/

USE BelcorpPanama
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'CodigoEstrategia'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD CodigoEstrategia VARCHAR(150) NULL;
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'TieneVariedad'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD TieneVariedad INT DEFAULT 0;
END
GO

/*end*/

USE BelcorpGuatemala
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'CodigoEstrategia'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD CodigoEstrategia VARCHAR(150) NULL;
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'TieneVariedad'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD TieneVariedad INT DEFAULT 0;
END
GO

/*end*/

USE BelcorpEcuador
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'CodigoEstrategia'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD CodigoEstrategia VARCHAR(150) NULL;
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'TieneVariedad'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD TieneVariedad INT DEFAULT 0;
END
GO

/*end*/

USE BelcorpDominicana
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'CodigoEstrategia'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD CodigoEstrategia VARCHAR(150) NULL;
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'TieneVariedad'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD TieneVariedad INT DEFAULT 0;
END
GO

/*end*/

USE BelcorpCostaRica
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'CodigoEstrategia'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD CodigoEstrategia VARCHAR(150) NULL;
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'TieneVariedad'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD TieneVariedad INT DEFAULT 0;
END
GO

/*end*/

USE BelcorpChile
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'CodigoEstrategia'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD CodigoEstrategia VARCHAR(150) NULL;
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'TieneVariedad'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD TieneVariedad INT DEFAULT 0;
END
GO

/*end*/

USE BelcorpBolivia
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'CodigoEstrategia'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD CodigoEstrategia VARCHAR(150) NULL;
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'EstrategiaTemporal'
          AND Object_ID = Object_ID(N'TieneVariedad'))
BEGIN
    ALTER TABLE EstrategiaTemporal ADD TieneVariedad INT DEFAULT 0;
END
GO