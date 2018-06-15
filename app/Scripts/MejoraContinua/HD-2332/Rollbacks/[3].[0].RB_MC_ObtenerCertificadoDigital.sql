USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'ObtenerCertificadoDigital')
BEGIN
    DROP PROCEDURE dbo.ObtenerCertificadoDigital
END
GO
