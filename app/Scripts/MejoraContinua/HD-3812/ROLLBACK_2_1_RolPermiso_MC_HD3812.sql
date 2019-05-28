/*Men� SV*/
USE [BelcorpSalvador]
GO
BEGIN

	/*** Eliminar "Mis certificado" en RolPermiso ***/	
	DECLARE @ID INT
	SET @ID=(SELECT PermisoID FROM Permiso P  WHERE P.descripcion='Mis Certificados')
	
	IF @ID IS NOT NULL AND EXISTS (SELECT 1 FROM ROLPERMISO WHERE PermisoID=@ID)
	BEGIN
			
		    DELETE FROM ROLPERMISO WHERE RolID=1 AND PermisoID=@ID

	END

END
GO
/*Men� CR*/
USE [BelcorpCostaRica]
GO
BEGIN

	/*** Eliminar "Mis certificado" en RolPermiso ***/	
	DECLARE @ID INT
	SET @ID=(SELECT PermisoID FROM Permiso P  WHERE P.descripcion='Mis Certificados')
	
	IF @ID IS NOT NULL AND EXISTS (SELECT 1 FROM ROLPERMISO WHERE PermisoID=@ID)
	BEGIN
			
		    DELETE FROM ROLPERMISO WHERE RolID=1 AND PermisoID=@ID

	END
	
END
GO
/*Men� GT*/
USE [BelcorpGuatemala]
GO
BEGIN

	/*** Eliminar "Mis certificado" en RolPermiso ***/	
	DECLARE @ID INT
	SET @ID=(SELECT PermisoID FROM Permiso P  WHERE P.descripcion='Mis Certificados')
	
	IF @ID IS NOT NULL AND EXISTS (SELECT 1 FROM ROLPERMISO WHERE PermisoID=@ID)
	BEGIN
			
		    DELETE FROM ROLPERMISO WHERE RolID=1 AND PermisoID=@ID

	END


END
GO
/*Men� PA*/
USE [BelcorpPanama]
GO
BEGIN
	/*** Eliminar "Mis certificado" en RolPermiso ***/	
	DECLARE @ID INT
	SET @ID=(SELECT PermisoID FROM Permiso P  WHERE P.descripcion='Mis Certificados')
	
	IF @ID IS NOT NULL AND EXISTS (SELECT 1 FROM ROLPERMISO WHERE PermisoID=@ID)
	BEGIN
			
		    DELETE FROM ROLPERMISO WHERE RolID=1 AND PermisoID=@ID

	END
END



