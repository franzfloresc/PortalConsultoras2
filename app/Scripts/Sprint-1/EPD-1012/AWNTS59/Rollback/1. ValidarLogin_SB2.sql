

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarLogin_SB2'))
BEGIN
    DROP PROCEDURE ValidarLogin_SB2
END

GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarLogin_SB2'))
BEGIN
    DROP PROCEDURE ValidarLogin_SB2
END

GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarLogin_SB2'))
BEGIN
    DROP PROCEDURE ValidarLogin_SB2
END

GO
