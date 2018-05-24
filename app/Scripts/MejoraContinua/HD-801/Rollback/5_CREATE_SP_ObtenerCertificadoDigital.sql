
USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'ObtenerCertificadoDigital')
BEGIN
    DROP PROCEDURE dbo.ObtenerCertificadoDigital
END
GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'ObtenerCertificadoDigital')
BEGIN
    DROP PROCEDURE dbo.ObtenerCertificadoDigital
END
GO
