USE [BelcorpBolivia];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
USE [BelcorpChile];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
USE [BelcorpColombia];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
USE [BelcorpCostaRica];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
USE [BelcorpDominicana];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
USE [BelcorpEcuador];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
USE [BelcorpGuatemala];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
USE [BelcorpMexico];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
USE [BelcorpPanama];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
USE [BelcorpPeru];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
USE [BelcorpPuertoRico];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
USE [BelcorpSalvador];
GO
IF (OBJECT_ID(N'PK_ResultadosID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Resultados  
	DROP CONSTRAINT PK_ResultadosID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
	DROP TABLE [chatbot].[Resultados]
GO
