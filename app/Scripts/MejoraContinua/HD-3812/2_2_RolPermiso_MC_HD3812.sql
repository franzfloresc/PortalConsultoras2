/*Menú SV*/
USE [BelcorpSalvador]
GO
BEGIN

	/*** Agregar "Mis certificado" en RolPermiso ***/	
	DECLARE @ID INT
	SET @ID=(SELECT PermisoID FROM Permiso P  WHERE P.descripcion='Mis Certificados')
	
	IF @ID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ROLPERMISO WHERE PermisoID=@ID)
	BEGIN
			
		
			INSERT INTO ROLPERMISO
			(RolID,
			 PermisoID,
			 Activo,
			 Mostrar)
			 VALUES(1,
			 @ID,
			 1,
			 1)

	END

END
GO
/*Menú CR*/
USE [BelcorpCostaRica]
GO
BEGIN

	/*** Agregar "Mis certificado" en RolPermiso ***/	
	DECLARE @ID INT
	SET @ID=(SELECT PermisoID FROM Permiso P  WHERE P.descripcion='Mis Certificados')
	
	IF @ID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ROLPERMISO WHERE PermisoID=@ID)
	BEGIN
			
		
			INSERT INTO ROLPERMISO
			(RolID,
			 PermisoID,
			 Activo,
			 Mostrar)
			 VALUES(1,
			 @ID,
			 1,
			 1)

	END
	
END
GO
/*Menú GT*/
USE [BelcorpGuatemala]
GO
BEGIN

	/*** Agregar "Mis certificado" en RolPermiso ***/	
	DECLARE @ID INT
	SET @ID=(SELECT PermisoID FROM Permiso P  WHERE P.descripcion='Mis Certificados')
	
	IF @ID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ROLPERMISO WHERE PermisoID=@ID)
	BEGIN
			
		
			INSERT INTO ROLPERMISO
			(RolID,
			 PermisoID,
			 Activo,
			 Mostrar)
			 VALUES(1,
			 @ID,
			 1,
			 1)

	END


END
GO
/*Menú PA*/
USE [BelcorpPanama]
GO
BEGIN
	/*** Agregar "Mis certificado" en RolPermiso ***/	
	DECLARE @ID INT
	SET @ID=(SELECT PermisoID FROM Permiso P  WHERE P.descripcion='Mis Certificados')
	
	IF @ID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ROLPERMISO WHERE PermisoID=@ID)
	BEGIN
			
		
			INSERT INTO ROLPERMISO
			(RolID,
			 PermisoID,
			 Activo,
			 Mostrar)
			 VALUES(1,
			 @ID,
			 1,
			 1)

	END
END



