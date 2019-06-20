/*Menú SV*/
USE [BelcorpSalvador]
GO
BEGIN
	/*** Actualizar config ***/
	UPDATE dbo.CertificadoDigitalConfig
	SET Ciudad='Lima',
	Responsable='Franco Jaime Lizarraga',
	RazonSocial='CETCO S.A.',
	DescripcionEstado='no mantiene deuda',
	URLFirma='http://S3.amazonaws.com/somosbelcorpprd/Matriz/PE/FirmaFJLizarraga.png'
	WHERE ConfigId=1

END
GO
/*Menú CR*/
USE [BelcorpCostaRica]
GO
BEGIN

	/*** Actualizar config ***/
	UPDATE dbo.CertificadoDigitalConfig
	SET Ciudad='Lima',
	Responsable='Franco Jaime Lizarraga',
	RazonSocial='CETCO S.A.',
	DescripcionEstado='no mantiene deuda',
	URLFirma='http://S3.amazonaws.com/somosbelcorpprd/Matriz/PE/FirmaFJLizarraga.png'
	WHERE ConfigId=1
END
GO
/*Menú GT*/
USE [BelcorpGuatemala]
GO

BEGIN

	/*** Actualizar config ***/
	UPDATE dbo.CertificadoDigitalConfig
	SET Ciudad='Lima',
	Responsable='Franco Jaime Lizarraga',
	RazonSocial='CETCO S.A.',
	DescripcionEstado='no mantiene deuda',
	URLFirma='http://S3.amazonaws.com/somosbelcorpprd/Matriz/PE/FirmaFJLizarraga.png'
	WHERE ConfigId=1
END
GO
/*Menú PA*/
USE [BelcorpPanama]
GO
BEGIN

	/*** Actualizar config ***/
	UPDATE dbo.CertificadoDigitalConfig
	SET Ciudad='Lima',
	Responsable='Franco Jaime Lizarraga',
	RazonSocial='CETCO S.A.',
	DescripcionEstado='no mantiene deuda',
	URLFirma='http://S3.amazonaws.com/somosbelcorpprd/Matriz/PE/FirmaFJLizarraga.png'
	WHERE ConfigId=1
END



