USE BelcorpPeru
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_PrecioPublico DEFAULT(0.0) 
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_PrecioPublico DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_Ganancia DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_Ganancia DEFAULT(0.0) 
END
GO

USE BelcorpMexico
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_PrecioPublico DEFAULT(0.0) 
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_PrecioPublico DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_Ganancia DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_Ganancia DEFAULT(0.0) 
END
GO

USE BelcorpColombia
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_PrecioPublico DEFAULT(0.0) 
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_PrecioPublico DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_Ganancia DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_Ganancia DEFAULT(0.0) 
END
GO

USE BelcorpVenezuela
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_PrecioPublico DEFAULT(0.0) 
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_PrecioPublico DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_Ganancia DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_Ganancia DEFAULT(0.0) 
END
GO

USE BelcorpSalvador
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_PrecioPublico DEFAULT(0.0) 
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_PrecioPublico DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_Ganancia DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_Ganancia DEFAULT(0.0) 
END
GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_PrecioPublico DEFAULT(0.0) 
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_PrecioPublico DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_Ganancia DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_Ganancia DEFAULT(0.0) 
END
GO

USE BelcorpPanama
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_PrecioPublico DEFAULT(0.0) 
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_PrecioPublico DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_Ganancia DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_Ganancia DEFAULT(0.0) 
END
GO

USE BelcorpGuatemala
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_PrecioPublico DEFAULT(0.0) 
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_PrecioPublico DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_Ganancia DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_Ganancia DEFAULT(0.0) 
END
GO

USE BelcorpEcuador
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_PrecioPublico DEFAULT(0.0) 
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_PrecioPublico DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_Ganancia DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_Ganancia DEFAULT(0.0) 
END
GO

USE BelcorpDominicana
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_PrecioPublico DEFAULT(0.0) 
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_PrecioPublico DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_Ganancia DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_Ganancia DEFAULT(0.0) 
END
GO

USE BelcorpCostaRica
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_PrecioPublico DEFAULT(0.0) 
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_PrecioPublico DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_Ganancia DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_Ganancia DEFAULT(0.0) 
END
GO

USE BelcorpChile
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_PrecioPublico DEFAULT(0.0) 
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_PrecioPublico DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_Ganancia DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_Ganancia DEFAULT(0.0) 
END
GO

USE BelcorpBolivia
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_PrecioPublico DEFAULT(0.0) 
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD PrecioPublico decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_PrecioPublico DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_Estrategia_Ganancia DEFAULT(0.0) 
END
GO


IF NOT EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Ganancia decimal(18, 2) NOT NULL CONSTRAINT CONS_EstrategiaTemp_Ganancia DEFAULT(0.0) 
END
GO

