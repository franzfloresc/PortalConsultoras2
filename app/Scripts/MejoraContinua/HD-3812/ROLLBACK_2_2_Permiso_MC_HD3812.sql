/*Menú SV*/
USE [BelcorpSalvador]
GO
BEGIN

	/*** Eliminar "Mis certificado" en Permiso ***/
	IF EXISTS (SELECT 1 FROM Permiso P  WHERE P.descripcion='Mis Certificados')
	BEGIN
			DELETE FROM Permiso  WHERE descripcion='Mis Certificados'	
	END

END
GO
/*Menú CR*/
USE [BelcorpCostaRica]
GO
BEGIN
    
	/*** Eliminar "Mis certificado" en Permiso ***/
	IF EXISTS (SELECT 1 FROM Permiso P  WHERE P.descripcion='Mis Certificados')
	BEGIN
			DELETE FROM Permiso  WHERE descripcion='Mis Certificados'	
	END


END
GO
/*Menú GT*/
USE [BelcorpGuatemala]
GO

BEGIN

	/*** Eliminar "Mis certificado" en Permiso ***/
	IF EXISTS (SELECT 1 FROM Permiso P  WHERE P.descripcion='Mis Certificados')
	BEGIN
			DELETE FROM Permiso  WHERE descripcion='Mis Certificados'	
	END

END
GO
/*Menú PA*/
USE [BelcorpPanama]
GO
BEGIN

	/*** Eliminar "Mis certificado" en Permiso ***/
	IF EXISTS (SELECT 1 FROM Permiso P  WHERE P.descripcion='Mis Certificados')
	BEGIN
			DELETE FROM Permiso  WHERE descripcion='Mis Certificados'	
	END


END



