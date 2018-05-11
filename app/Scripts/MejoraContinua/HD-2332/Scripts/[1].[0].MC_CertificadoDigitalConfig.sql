USE BelcorpPeru
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
		'Lima', 
		'Certificado de No Adeudo',
		'no mantiene deuda',
		'',
		'',
		'',
		'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/EC/MVENEGAS.jpg',
		'Franco Jaime Lizarraga',
		'DNI 40593750',
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
		'Lima', 
		'',
		'',
		'CETCO S.A.',
		'RUC 20100123763',
		'023935900',
		'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/EC/MVENEGAS.jpg',
		'Franco Jaime Lizarraga',
		'DNI 40593750',
		2,
		'ADMSAC'
	)
END
GO

