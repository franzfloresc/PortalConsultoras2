

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetEsOfertaDelDia'))
BEGIN
    DROP PROCEDURE dbo.GetEsOfertaDelDia
END

GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetEsOfertaDelDia'))
BEGIN
    DROP PROCEDURE dbo.GetEsOfertaDelDia
END

GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetEsOfertaDelDia'))
BEGIN
    DROP PROCEDURE dbo.GetEsOfertaDelDia
END

GO

