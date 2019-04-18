/*Menú SV*/
USE [BelcorpSalvador]
GO
BEGIN

	/*** Agregar "Mis certificado" en Permiso ***/
	IF NOT EXISTS(SELECT 1 FROM Permiso P WHERE P.descripcion='Mis Certificados')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX(PERMISOID)) FROM Permiso)+1
			INSERT INTO [dbo].[Permiso]
			([PermisoID]
			,[Descripcion]
			,[IdPadre]
			,[OrdenItem]
			,[UrlItem]
			,[PaginaNueva]
			,[Posicion]
			,[UrlImagen]
			,[EsSoloImagen]
			,[EsMenuEspecial]
			,[EsServicios]
			,[EsPrincipal]
			,[Codigo])
			VALUES(@ID,
			'Mis certificados',
			1003,
			7,
			'MisCertificados/Index',
			0,
			'Header',
			'',
			0,
			0,
			0,
			1,
			'MisCertificados')

	END

END
GO
/*Menú CR*/
USE [BelcorpCostaRica]
GO
BEGIN
    
	/*** Agregar "Mis certificado" en Permiso ***/
	IF NOT EXISTS(SELECT 1 FROM Permiso P WHERE P.descripcion='Mis Certificados')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX(PERMISOID)) FROM Permiso)+1
			INSERT INTO [dbo].[Permiso]
			([PermisoID]
			,[Descripcion]
			,[IdPadre]
			,[OrdenItem]
			,[UrlItem]
			,[PaginaNueva]
			,[Posicion]
			,[UrlImagen]
			,[EsSoloImagen]
			,[EsMenuEspecial]
			,[EsServicios]
			,[EsPrincipal]
			,[Codigo])
			VALUES(@ID,
			'Mis certificados',
			1003,
			7,
			'MisCertificados/Index',
			0,
			'Header',
			'',
			0,
			0,
			0,
			1,
			'MisCertificados')

	END


END
GO
/*Menú GT*/
USE [BelcorpGuatemala]
GO

BEGIN

	/*** Agregar "Mis certificado" en Permiso ***/
	IF NOT EXISTS(SELECT 1 FROM Permiso P WHERE P.descripcion='Mis Certificados')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX(PERMISOID)) FROM Permiso)+1
			INSERT INTO [dbo].[Permiso]
			([PermisoID]
			,[Descripcion]
			,[IdPadre]
			,[OrdenItem]
			,[UrlItem]
			,[PaginaNueva]
			,[Posicion]
			,[UrlImagen]
			,[EsSoloImagen]
			,[EsMenuEspecial]
			,[EsServicios]
			,[EsPrincipal]
			,[Codigo])
			VALUES(@ID,
			'Mis certificados',
			1003,
			7,
			'MisCertificados/Index',
			0,
			'Header',
			'',
			0,
			0,
			0,
			1,
			'MisCertificados')


	END

END
GO
/*Menú PA*/
USE [BelcorpPanama]
GO
BEGIN

	/*** Agregar "Mis certificado" en Permiso ***/
	IF NOT EXISTS(SELECT 1 FROM Permiso P WHERE P.descripcion='Mis Certificados')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX(PERMISOID)) FROM Permiso)+1
			INSERT INTO [dbo].[Permiso]
			([PermisoID]
			,[Descripcion]
			,[IdPadre]
			,[OrdenItem]
			,[UrlItem]
			,[PaginaNueva]
			,[Posicion]
			,[UrlImagen]
			,[EsSoloImagen]
			,[EsMenuEspecial]
			,[EsServicios]
			,[EsPrincipal]
			,[Codigo])
			VALUES(@ID,
			'Mis certificados',
			1003,
			7,
			'MisCertificados/Index',
			0,
			'Header',
			'',
			0,
			0,
			0,
			1,
			'MisCertificados')

	END


END



