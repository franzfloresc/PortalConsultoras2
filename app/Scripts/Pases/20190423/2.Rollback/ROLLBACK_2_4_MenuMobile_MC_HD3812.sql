/*Menú SV*/
USE [BelcorpSalvador]
GO
BEGIN

	/*** Eliminar "Mis certificado" en MenuMobile ***/
	IF EXISTS(select 1 from MenuMobile where Descripcion='Mis Certificados')
	BEGIN
			
		DELETE FROM MenuMobile WHERE Descripcion='Mis Certificados'

	END

END
GO
/*Menú CR*/
USE [BelcorpCostaRica]
GO
BEGIN
    
	/*** Eliminar "Mis certificado" en MenuMobile ***/
	IF EXISTS(select 1 from MenuMobile where Descripcion='Mis Certificados')
	BEGIN
			
		DELETE FROM MenuMobile WHERE Descripcion='Mis Certificados'

	END

END
GO
/*Menú GT*/
USE [BelcorpGuatemala]
GO

BEGIN

	/*** Eliminar "Mis certificado" en MenuMobile ***/
	IF EXISTS(select 1 from MenuMobile where Descripcion='Mis Certificados')
	BEGIN
			
		DELETE FROM MenuMobile WHERE Descripcion='Mis Certificados'

	END

END
GO
/*Menú PA*/
USE [BelcorpPanama]
GO
BEGIN

	/*** Eliminar "Mis certificado" en MenuMobile ***/
	IF EXISTS(select 1 from MenuMobile where Descripcion='Mis Certificados')
	BEGIN
			
		DELETE FROM MenuMobile WHERE Descripcion='Mis Certificados'

	END


END



