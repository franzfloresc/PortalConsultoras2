USE [BelcorpBolivia];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
USE [BelcorpChile];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
USE [BelcorpColombia];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
USE [BelcorpCostaRica];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
USE [BelcorpDominicana];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
USE [BelcorpEcuador];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
USE [BelcorpGuatemala];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
USE [BelcorpMexico];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
USE [BelcorpPanama];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
USE [BelcorpPeru];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
USE [BelcorpPuertoRico];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
USE [BelcorpSalvador];
GO
IF (OBJECT_ID(N'PK_CanalID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Canal  
	DROP CONSTRAINT PK_CanalID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
	DROP TABLE [chatbot].[Canal]
GO
