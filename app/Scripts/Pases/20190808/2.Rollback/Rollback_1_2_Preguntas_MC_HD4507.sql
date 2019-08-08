USE [BelcorpBolivia];
GO
IF (OBJECT_ID(N'PK_PreguntaID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Preguntas  
	DROP CONSTRAINT PK_PreguntaID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
    DROP TABLE [chatbot].[Preguntas]

GO
USE [BelcorpChile];
GO
IF (OBJECT_ID(N'PK_PreguntaID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Preguntas  
	DROP CONSTRAINT PK_PreguntaID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
    DROP TABLE [chatbot].[Preguntas]

GO
USE [BelcorpColombia];
GO
IF (OBJECT_ID(N'PK_PreguntaID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Preguntas  
	DROP CONSTRAINT PK_PreguntaID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
    DROP TABLE [chatbot].[Preguntas]

GO
USE [BelcorpCostaRica];
GO
IF (OBJECT_ID(N'PK_PreguntaID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Preguntas  
	DROP CONSTRAINT PK_PreguntaID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
    DROP TABLE [chatbot].[Preguntas]

GO
USE [BelcorpDominicana];
GO
IF (OBJECT_ID(N'PK_PreguntaID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Preguntas  
	DROP CONSTRAINT PK_PreguntaID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
    DROP TABLE [chatbot].[Preguntas]

GO
USE [BelcorpEcuador];
GO
IF (OBJECT_ID(N'PK_PreguntaID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Preguntas  
	DROP CONSTRAINT PK_PreguntaID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
    DROP TABLE [chatbot].[Preguntas]

GO
USE [BelcorpGuatemala];
GO
IF (OBJECT_ID(N'PK_PreguntaID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Preguntas  
	DROP CONSTRAINT PK_PreguntaID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
    DROP TABLE [chatbot].[Preguntas]

GO
USE [BelcorpMexico];
GO
IF (OBJECT_ID(N'PK_PreguntaID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Preguntas  
	DROP CONSTRAINT PK_PreguntaID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
    DROP TABLE [chatbot].[Preguntas]

GO
USE [BelcorpPanama];
GO
IF (OBJECT_ID(N'PK_PreguntaID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Preguntas  
	DROP CONSTRAINT PK_PreguntaID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
    DROP TABLE [chatbot].[Preguntas]

GO
USE [BelcorpPeru];
GO
IF (OBJECT_ID(N'PK_PreguntaID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Preguntas  
	DROP CONSTRAINT PK_PreguntaID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
    DROP TABLE [chatbot].[Preguntas]

GO
USE [BelcorpPuertoRico];
GO
IF (OBJECT_ID(N'PK_PreguntaID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Preguntas  
	DROP CONSTRAINT PK_PreguntaID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
    DROP TABLE [chatbot].[Preguntas]

GO
USE [BelcorpSalvador];
GO
IF (OBJECT_ID(N'PK_PreguntaID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.Preguntas  
	DROP CONSTRAINT PK_PreguntaID;
GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
    DROP TABLE [chatbot].[Preguntas]

GO
