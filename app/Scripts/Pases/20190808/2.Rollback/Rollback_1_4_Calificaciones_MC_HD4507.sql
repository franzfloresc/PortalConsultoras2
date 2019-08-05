USE [BelcorpBolivia];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
USE [BelcorpChile];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
USE [BelcorpColombia];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
USE [BelcorpCostaRica];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
USE [BelcorpDominicana];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
USE [BelcorpEcuador];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
USE [BelcorpGuatemala];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
USE [BelcorpMexico];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
USE [BelcorpPanama];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
USE [BelcorpPeru];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
USE [BelcorpPuertoRico];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
USE [BelcorpSalvador];
GO
IF (OBJECT_ID(N'PK_CalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Calificaciones  
	DROP CONSTRAINT PK_CalificacionID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
	DROP TABLE [chatbot].[Calificaciones]
GO
