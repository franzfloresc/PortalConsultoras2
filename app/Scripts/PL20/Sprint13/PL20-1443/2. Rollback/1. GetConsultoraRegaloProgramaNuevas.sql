
USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetConsultoraRegaloProgramaNuevas'))
BEGIN
    DROP PROCEDURE dbo.GetConsultoraRegaloProgramaNuevas
END
GO

