USE [BelcorpBolivia];
GO
IF (NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
    EXEC ('CREATE SCHEMA chatbot');
GO
USE [BelcorpChile];
GO
IF (NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
    EXEC ('CREATE SCHEMA chatbot');
GO
USE [BelcorpColombia];
GO
IF (NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
    EXEC ('CREATE SCHEMA chatbot');
GO
USE [BelcorpCostaRica];
GO
IF (NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
    EXEC ('CREATE SCHEMA chatbot');
GO
USE [BelcorpDominicana];
GO
IF (NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
    EXEC ('CREATE SCHEMA chatbot');
GO
USE [BelcorpEcuador];
GO
IF (NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
    EXEC ('CREATE SCHEMA chatbot');
GO
USE [BelcorpGuatemala];
GO
IF (NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
    EXEC ('CREATE SCHEMA chatbot');
GO
USE [BelcorpMexico];
GO
IF (NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
    EXEC ('CREATE SCHEMA chatbot');
GO
USE [BelcorpPanama];
GO
IF (NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
    EXEC ('CREATE SCHEMA chatbot');
GO
USE [BelcorpPeru];
GO
IF (NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
    EXEC ('CREATE SCHEMA chatbot');
GO
USE [BelcorpPuertoRico];
GO
IF (NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
    EXEC ('CREATE SCHEMA chatbot');
GO
USE [BelcorpSalvador];
GO
IF (NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
    EXEC ('CREATE SCHEMA chatbot');
GO
