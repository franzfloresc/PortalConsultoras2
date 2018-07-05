USE BelcorpPeru
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CertificadoDigitalLog')
BEGIN
	CREATE TABLE CertificadoDigitalLog
	(
		LogId INT PRIMARY KEY IDENTITY(1,1),
		Campania INT,
		ConsultoraId INT,
		NumeroSecuencia VARCHAR(12),
		Ciudad VARCHAR(30),
		Asunto VARCHAR(100) NULL,
		NombreCompleto VARCHAR(50),
		TipoDocumento VARCHAR(20),
		NumeroDocumento VARCHAR(20),
		DescripcionEstado VARCHAR(50) NULL,
		FechaIngresoConsultora DATETIME NULL,
		PromedioVentas DECIMAL(18,2) NULL,
		RazonSocial VARCHAR(100),
		Ruc VARCHAR(20),
		Telefono VARCHAR(50) NULL,
		UrlFirma VARCHAR(150),
		Responsable VARCHAR(50),
		Cargo VARCHAR(30),
		TipoCert TINYINT,
		NumeroVeces SMALLINT DEFAULT 1,
		FechaCreacion DATETIME DEFAULT GETDATE()
	);
END
GO