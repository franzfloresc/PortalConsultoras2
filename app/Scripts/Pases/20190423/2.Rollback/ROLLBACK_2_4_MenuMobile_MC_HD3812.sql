/*Men� SV*/
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
/*Men� CR*/
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
/*Men� GT*/
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
/*Men� PA*/
USE [BelcorpPanama]
GO
BEGIN

	/*** Eliminar "Mis certificado" en MenuMobile ***/
	IF EXISTS(select 1 from MenuMobile where Descripcion='Mis Certificados')
	BEGIN
			
		DELETE FROM MenuMobile WHERE Descripcion='Mis Certificados'

	END


END



