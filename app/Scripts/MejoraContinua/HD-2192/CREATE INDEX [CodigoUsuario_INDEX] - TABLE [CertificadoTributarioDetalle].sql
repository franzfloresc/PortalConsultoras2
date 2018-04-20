USE BelcorpColombia
GO

CREATE INDEX Cedula_INDEX
ON CertificadoTributarioDetalle (cedula);

CREATE INDEX Codigo_INDEX
ON CertificadoTributarioDetalle (Codigo);