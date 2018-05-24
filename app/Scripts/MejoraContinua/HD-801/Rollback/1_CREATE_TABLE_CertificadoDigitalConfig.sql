

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CertificadoDigitalConfig')
BEGIN
	DROP TABLE dbo.CertificadoDigitalConfig
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CertificadoDigitalConfig')
BEGIN
	DROP TABLE dbo.CertificadoDigitalConfig
END
GO

