/*Men� SV*/
USE [BelcorpSalvador]
GO
BEGIN
	/*** Actualizar config ***/
	UPDATE dbo.CertificadoDigitalConfig
	SET Ciudad='San Salvador',
	Responsable='Ana Beatriz Menjivar',
	RazonSocial='Belcorp El Salvador S.A de C.V.',
	DescripcionEstado='no registra deuda',
	UrlFirma='http://S3.amazonaws.com/somosbelcorpprd/Matriz/SV/FirmaABMenjivar.png'
	WHERE ConfigId=1

END
GO
/*Men� CR*/
USE [BelcorpCostaRica]
GO
BEGIN

	/*** Actualizar config ***/
	UPDATE dbo.CertificadoDigitalConfig
	SET Ciudad='San Jos�',
	Responsable='Paola Pineda',
	RazonSocial='Dirbel Inversiones S.A.',
	DescripcionEstado='no registra deuda',
	UrlFirma='http://S3.amazonaws.com/somosbelcorpprd/Matriz/CR/FirmaPPineda.png'
	WHERE ConfigId=1
END
GO
/*Men� GT*/
USE [BelcorpGuatemala]
GO

BEGIN

	/*** Actualizar config ***/
	UPDATE dbo.CertificadoDigitalConfig
	SET Ciudad='Guatemala',
	Responsable='Hugo Leonel Pineda',
	RazonSocial='Belcorp Guatemala, S.A.',
	DescripcionEstado='no registra deuda',
    UrlFirma='http://S3.amazonaws.com/somosbelcorpprd/Matriz/GT/FirmaHLPineda.png'
	WHERE ConfigId=1
END
GO
/*Men� PA*/
USE [BelcorpPanama]
GO
BEGIN

	/*** Actualizar config ***/
	UPDATE dbo.CertificadoDigitalConfig
	SET Ciudad='Panam�',
	Responsable='Paola Pineda',
	RazonSocial='L''bel Paris, S.A.',
	DescripcionEstado='no registra deuda',
	UrlFirma='http://S3.amazonaws.com/somosbelcorpprd/Matriz/PA/FirmaPPineda.png'
	WHERE ConfigId=1
END



