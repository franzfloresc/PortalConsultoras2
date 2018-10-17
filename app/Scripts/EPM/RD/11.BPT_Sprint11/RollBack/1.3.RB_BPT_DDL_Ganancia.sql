USE BelcorpPeru
GO

GO
IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_PrecioPublico
	
	ALTER TABLE Estrategia
	DROP COLUMN PrecioPublico
END
GO

IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_PrecioPublico
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN PrecioPublico 
END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_Ganancia
	
	ALTER TABLE Estrategia
	DROP COLUMN Ganancia 

END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_Ganancia
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN Ganancia 

END
GO

USE BelcorpMexico
GO

GO
IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_PrecioPublico
	
	ALTER TABLE Estrategia
	DROP COLUMN PrecioPublico
END
GO

IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_PrecioPublico
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN PrecioPublico 
END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_Ganancia
	
	ALTER TABLE Estrategia
	DROP COLUMN Ganancia 

END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_Ganancia
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN Ganancia 

END
GO

USE BelcorpColombia
GO

GO
IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_PrecioPublico
	
	ALTER TABLE Estrategia
	DROP COLUMN PrecioPublico
END
GO

IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_PrecioPublico
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN PrecioPublico 
END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_Ganancia
	
	ALTER TABLE Estrategia
	DROP COLUMN Ganancia 

END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_Ganancia
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN Ganancia 

END
GO

USE BelcorpVenezuela
GO

GO
IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_PrecioPublico
	
	ALTER TABLE Estrategia
	DROP COLUMN PrecioPublico
END
GO

IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_PrecioPublico
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN PrecioPublico 
END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_Ganancia
	
	ALTER TABLE Estrategia
	DROP COLUMN Ganancia 

END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_Ganancia
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN Ganancia 

END
GO

USE BelcorpSalvador
GO

GO
IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_PrecioPublico
	
	ALTER TABLE Estrategia
	DROP COLUMN PrecioPublico
END
GO

IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_PrecioPublico
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN PrecioPublico 
END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_Ganancia
	
	ALTER TABLE Estrategia
	DROP COLUMN Ganancia 

END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_Ganancia
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN Ganancia 

END
GO

USE BelcorpPuertoRico
GO

GO
IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_PrecioPublico
	
	ALTER TABLE Estrategia
	DROP COLUMN PrecioPublico
END
GO

IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_PrecioPublico
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN PrecioPublico 
END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_Ganancia
	
	ALTER TABLE Estrategia
	DROP COLUMN Ganancia 

END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_Ganancia
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN Ganancia 

END
GO

USE BelcorpPanama
GO

GO
IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_PrecioPublico
	
	ALTER TABLE Estrategia
	DROP COLUMN PrecioPublico
END
GO

IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_PrecioPublico
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN PrecioPublico 
END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_Ganancia
	
	ALTER TABLE Estrategia
	DROP COLUMN Ganancia 

END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_Ganancia
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN Ganancia 

END
GO

USE BelcorpGuatemala
GO

GO
IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_PrecioPublico
	
	ALTER TABLE Estrategia
	DROP COLUMN PrecioPublico
END
GO

IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_PrecioPublico
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN PrecioPublico 
END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_Ganancia
	
	ALTER TABLE Estrategia
	DROP COLUMN Ganancia 

END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_Ganancia
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN Ganancia 

END
GO

USE BelcorpEcuador
GO

GO
IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_PrecioPublico
	
	ALTER TABLE Estrategia
	DROP COLUMN PrecioPublico
END
GO

IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_PrecioPublico
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN PrecioPublico 
END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_Ganancia
	
	ALTER TABLE Estrategia
	DROP COLUMN Ganancia 

END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_Ganancia
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN Ganancia 

END
GO

USE BelcorpDominicana
GO

GO
IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_PrecioPublico
	
	ALTER TABLE Estrategia
	DROP COLUMN PrecioPublico
END
GO

IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_PrecioPublico
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN PrecioPublico 
END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_Ganancia
	
	ALTER TABLE Estrategia
	DROP COLUMN Ganancia 

END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_Ganancia
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN Ganancia 

END
GO

USE BelcorpCostaRica
GO

GO
IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_PrecioPublico
	
	ALTER TABLE Estrategia
	DROP COLUMN PrecioPublico
END
GO

IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_PrecioPublico
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN PrecioPublico 
END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_Ganancia
	
	ALTER TABLE Estrategia
	DROP COLUMN Ganancia 

END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_Ganancia
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN Ganancia 

END
GO

USE BelcorpChile
GO

GO
IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_PrecioPublico
	
	ALTER TABLE Estrategia
	DROP COLUMN PrecioPublico
END
GO

IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_PrecioPublico
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN PrecioPublico 
END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_Ganancia
	
	ALTER TABLE Estrategia
	DROP COLUMN Ganancia 

END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_Ganancia
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN Ganancia 

END
GO

USE BelcorpBolivia
GO

GO
IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'PrecioPublico')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_PrecioPublico
	
	ALTER TABLE Estrategia
	DROP COLUMN PrecioPublico
END
GO

IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'PrecioPublico')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_PrecioPublico
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN PrecioPublico 
END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[Estrategia]') AND name = 'Ganancia')
BEGIN
	ALTER TABLE Estrategia 
	DROP CONSTRAINT CONS_Estrategia_Ganancia
	
	ALTER TABLE Estrategia
	DROP COLUMN Ganancia 

END
GO


IF EXISTS (SELECT * FROM sys.columns 
WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaTemporal]') AND name = 'Ganancia')
BEGIN

	ALTER TABLE EstrategiaTemporal 
	DROP CONSTRAINT CONS_EstrategiaTemp_Ganancia
	
	ALTER TABLE EstrategiaTemporal
	DROP COLUMN Ganancia 

END
GO

