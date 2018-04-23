USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.indexes WHERE name='Cedula_INDEX' AND object_id = OBJECT_ID('CertificadoTributarioDetalle'))
BEGIN
	DROP INDEX Cedula_INDEX ON dbo.CertificadoTributarioDetalle; 
END

CREATE INDEX Cedula_INDEX
ON CertificadoTributarioDetalle (cedula);

/*******/

IF EXISTS (SELECT * FROM sys.indexes WHERE name='Codigo_INDEX' AND object_id = OBJECT_ID('CertificadoTributarioDetalle'))
BEGIN
	DROP INDEX Codigo_INDEX ON dbo.CertificadoTributarioDetalle; 
END

CREATE INDEX Codigo_INDEX
ON CertificadoTributarioDetalle (Codigo);



