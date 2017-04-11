
USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'InsUsuarioExterno')
BEGIN
  DROP TABLE dbo.InsUsuarioExterno
END
GO

