USE [BelcorpBolivia];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
	DROP TABLE [chatbot].[TipoCalificacion]
GO
USE [BelcorpChile];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
	DROP TABLE [chatbot].[TipoCalificacion]
GO
USE [BelcorpColombia];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
	DROP TABLE [chatbot].[TipoCalificacion]
GO
USE [BelcorpCostaRica];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
	DROP TABLE [chatbot].[TipoCalificacion]
GO
USE [BelcorpDominicana];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
	DROP TABLE [chatbot].[TipoCalificacion]
GO
USE [BelcorpEcuador];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
	DROP TABLE [chatbot].[TipoCalificacion]
GO
USE [BelcorpGuatemala];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
	DROP TABLE [chatbot].[TipoCalificacion]
GO
USE [BelcorpMexico];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
	DROP TABLE [chatbot].[TipoCalificacion]
GO
USE [BelcorpPanama];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
	DROP TABLE [chatbot].[TipoCalificacion]
GO
USE [BelcorpPeru];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
	DROP TABLE [chatbot].[TipoCalificacion]
GO
USE [BelcorpPuertoRico];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
	DROP TABLE [chatbot].[TipoCalificacion]
GO
USE [BelcorpSalvador];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
GO

IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
	DROP TABLE [chatbot].[TipoCalificacion]
GO
