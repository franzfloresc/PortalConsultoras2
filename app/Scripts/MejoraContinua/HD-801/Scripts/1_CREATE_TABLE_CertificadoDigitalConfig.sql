
USE BelcorpColombia
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CertificadoDigitalConfig')
BEGIN
	CREATE TABLE CertificadoDigitalConfig
	(
		ConfigId INT PRIMARY KEY IDENTITY(1,1),
		Ciudad VARCHAR(30),
		Asunto VARCHAR(100),
		DescripcionEstado VARCHAR(50),
		RazonSocial VARCHAR(100),
		Ruc VARCHAR(20),
		Telefono VARCHAR(50),
		UrlFirma VARCHAR(150),
		Responsable VARCHAR(50),
		Cargo VARCHAR(30),
		TipoCert TINYINT,
		UsuarioCreacion VARCHAR(20),
		FechaCreacion DATETIME DEFAULT GETDATE(),
		UsuarioModificacion VARCHAR(20),
		FechaModificacion DATETIME
	);

	INSERT INTO dbo.CertificadoDigitalConfig
	(
		Ciudad,
		Asunto,
		DescripcionEstado,
		RazonSocial,
		Ruc,
		Telefono,
		UrlFirma,
		Responsable,
		Cargo,
		TipoCert,
		UsuarioCreacion
	)
	VALUES
	(   
		'Bogota D.C.', 
		'Certificado de Paz y Salvo',
		'no mantiene deuda',
		'GRUPO TRANSBEL S.A.',
		'',
		'',
		'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/CO/JSDUQUE.jpg',
		'Xavier Garces Tomsih',
		'JEFE DE COBRANZAS',
		1,
		'ADMSAC'
	)

	INSERT INTO dbo.CertificadoDigitalConfig
	(
		Ciudad,
		Asunto,
		DescripcionEstado,
		RazonSocial,
		Ruc,
		Telefono,
		UrlFirma,
		Responsable,
		Cargo,
		TipoCert,
		UsuarioCreacion
	)
	VALUES
	(   
		'Bogota D.C.', 
		'',
		'',
		'GRUPO TRANSBEL S.A.',
		'1791412540001',
		'023935900',
		'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/CO/JSDUQUE.jpg',
		'Juan Sebastian Duque',
		'Jefe de Servicio al Cliente',
		2,
		'ADMSAC'
	)
END
GO

USE BelcorpEcuador
GO

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CertificadoDigitalConfig')
BEGIN
	CREATE TABLE CertificadoDigitalConfig
	(
		ConfigId INT PRIMARY KEY IDENTITY(1,1),
		Ciudad VARCHAR(30),
		Asunto VARCHAR(100),
		DescripcionEstado VARCHAR(50),
		RazonSocial VARCHAR(100),
		Ruc VARCHAR(20),
		Telefono VARCHAR(50),
		UrlFirma VARCHAR(150),
		Responsable VARCHAR(50),
		Cargo VARCHAR(30),
		TipoCert TINYINT,
		UsuarioCreacion VARCHAR(20),
		FechaCreacion DATETIME DEFAULT GETDATE(),
		UsuarioModificacion VARCHAR(20),
		FechaModificacion DATETIME
	);

	INSERT INTO dbo.CertificadoDigitalConfig
	(
		Ciudad,
		Asunto,
		DescripcionEstado,
		RazonSocial,
		Ruc,
		Telefono,
		UrlFirma,
		Responsable,
		Cargo,
		TipoCert,
		UsuarioCreacion
	)
	VALUES
	(   
		'Quito', 
		'Certificado de no adeudo',
		'no mantiene deuda',
		'GRUPO TRANSBEL S.A.',
		'',
		'',
		'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/EC/MVENEGAS.jpg',
		'Xavier Garces Tomsih',
		'JEFE DE COBRANZAS',
		1,
		'ADMSAC'
	)

	INSERT INTO dbo.CertificadoDigitalConfig
	(
		Ciudad,
		Asunto,
		DescripcionEstado,
		RazonSocial,
		Ruc,
		Telefono,
		UrlFirma,
		Responsable,
		Cargo,
		TipoCert,
		UsuarioCreacion
	)
	VALUES
	(   
		'Quito', 
		'',
		'',
		'GRUPO TRANSBEL S.A.',
		'1791412540001',
		'023935900',
		'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/EC/MVENEGAS.jpg',
		'Martin Venegas',
		'Gerente de Operaciones',
		2,
		'ADMSAC'
	)
END
GO

