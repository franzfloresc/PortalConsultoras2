USE BelcorpColombia 
GO

IF(SELECT COUNT(*) FROM  certificadodigitalconfig WHERE Asunto = 'Certificado Tributario') = 0
BEGIN
	INSERT INTO certificadodigitalconfig
	(
	  Ciudad
	, Asunto
	, DescripcionEstado
	, RazonSocial
	, Ruc
	, Telefono
	, UrlFirma
	, Responsable
	, Cargo
	, TipoCert
	, UsuarioCreacion
	, FechaCreacion
	) VALUES
	(
	  'Bogota'
	, 'Certificado Tributario'
	, ''
	, 'BEL STAR S.A.'
	, 'NIT 800.018.359-1'
	, '5948060 y 018000937452'
	, 'http://s3.amazonaws.com/consultorasQAS/SomosBelcorp/Matriz/CO/JSDUQUE.jpg'
	, 'Juan Sebastian Duque'
	, 'Departamento de Impuestos'
	, 3
	, 'ADMSAC'
	, GETDATE ( )
	)
END
