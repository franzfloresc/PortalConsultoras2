USE [BelcorpBolivia];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
USE [BelcorpChile];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
USE [BelcorpColombia];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
USE [BelcorpCostaRica];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
USE [BelcorpDominicana];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
USE [BelcorpEcuador];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
USE [BelcorpGuatemala];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
USE [BelcorpMexico];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
USE [BelcorpPanama];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
USE [BelcorpPeru];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
USE [BelcorpPuertoRico];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
USE [BelcorpSalvador];
GO
IF (OBJECT_ID(N'PK_DetalleResultadoID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.DetalleResultados  
	DROP CONSTRAINT PK_DetalleResultadoID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
	DROP TABLE [chatbot].[DetalleResultados]
GO
