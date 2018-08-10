USE BelcorpPeru
GO 

BEGIN
	UPDATE
		RevistaDigitalSuscripcion
	SET
		Origen = 'NUEVA', 
		SubOrigen = 'RDR',
		EstadoRegistro = 1,
		EstadoEnvio = 0
	WHERE RevistaDigitalSuscripcionID in (
		SELECT MAX(RS.RevistaDigitalSuscripcionID) AS ID
		FROM RevistaDigitalSuscripcion RS
		WHERE Origen = 'RD' and CodigoZona in 
		('5011', '5012', '5013', '5014', '5031', '5032', '5033', '5034', '5035', '5036', '5042', '5043', '5044',
		'5045', '5046', '5051', '5052', '5053', '5054',
		'8012', '8015', '8016', '8021', '8022', '8026', '8029', '8030')
		GROUP BY RS.CodigoConsultora) 
END 
GO

USE BelcorpColombia
GO

BEGIN
	UPDATE
		RevistaDigitalSuscripcion
	SET
		Origen = 'NUEVA', 
		SubOrigen = 'RDR',
		EstadoRegistro = 1,
		EstadoEnvio = 0
	WHERE RevistaDigitalSuscripcionID in (
		SELECT MAX(RS.RevistaDigitalSuscripcionID) AS ID
		FROM RevistaDigitalSuscripcion RS
		WHERE Origen = 'RD' and CodigoZona in 
		('0101', '0102', '0103', '0104', '0108', '0123', '0125')
		GROUP BY RS.CodigoConsultora) 
END
GO