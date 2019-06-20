/*Menú SV*/
USE [BelcorpSalvador]
GO
BEGIN

	/*** Agregar "Mis certificado" en MenuMobile ***/
	IF NOT EXISTS(select 1 from MenuMobile where Descripcion='Mis Certificados')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX([MenuMobileID])) FROM MenuMobile)+1
			INSERT INTO [dbo].[MenuMobile]
			([MenuMobileID]
			  ,[Descripcion]
			  ,[MenuPadreID]
			  ,[OrdenItem]
			  ,[UrlItem]
			  ,[UrlImagen]
			  ,[PaginaNueva]
			  ,[Posicion]
			  ,[Version]
			  ,[EsSB2]
			  ,[Codigo])
			VALUES(@ID,
			'Mis certificados',
			1001,
			20,
			'Mobile/MisCertificados',
			'',
			0,
			'Menu',
			'Mobile',
			1,
			'')



	END

END
GO
/*Menú CR*/
USE [BelcorpCostaRica]
GO
BEGIN
    
	/*** Agregar "Mis certificado" en MenuMobile ***/
	IF NOT EXISTS(select 1 from MenuMobile where Descripcion='Mis Certificados')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX([MenuMobileID])) FROM MenuMobile)+1
			INSERT INTO [dbo].[MenuMobile]
			([MenuMobileID]
			  ,[Descripcion]
			  ,[MenuPadreID]
			  ,[OrdenItem]
			  ,[UrlItem]
			  ,[UrlImagen]
			  ,[PaginaNueva]
			  ,[Posicion]
			  ,[Version]
			  ,[EsSB2]
			  ,[Codigo])
			VALUES(@ID,
			'Mis certificados',
			1001,
			20,
			'Mobile/MisCertificados',
			'',
			0,
			'Menu',
			'Mobile',
			1,
			'')



	END

END
GO
/*Menú GT*/
USE [BelcorpGuatemala]
GO

BEGIN

	/*** Agregar "Mis certificado" en MenuMobile ***/
	IF NOT EXISTS(select 1 from MenuMobile where Descripcion='Mis Certificados')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX([MenuMobileID])) FROM MenuMobile)+1
			INSERT INTO [dbo].[MenuMobile]
			([MenuMobileID]
			  ,[Descripcion]
			  ,[MenuPadreID]
			  ,[OrdenItem]
			  ,[UrlItem]
			  ,[UrlImagen]
			  ,[PaginaNueva]
			  ,[Posicion]
			  ,[Version]
			  ,[EsSB2]
			  ,[Codigo])
			VALUES(@ID,
			'Mis certificados',
			1001,
			20,
			'Mobile/MisCertificados',
			'',
			0,
			'Menu',
			'Mobile',
			1,
			'')



	END

END
GO
/*Menú PA*/
USE [BelcorpPanama]
GO
BEGIN

	/*** Agregar "Mis certificado" en MenuMobile ***/
	IF NOT EXISTS(select 1 from MenuMobile where Descripcion='Mis Certificados')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX([MenuMobileID])) FROM MenuMobile)+1
			INSERT INTO [dbo].[MenuMobile]
			([MenuMobileID]
			  ,[Descripcion]
			  ,[MenuPadreID]
			  ,[OrdenItem]
			  ,[UrlItem]
			  ,[UrlImagen]
			  ,[PaginaNueva]
			  ,[Posicion]
			  ,[Version]
			  ,[EsSB2]
			  ,[Codigo])
			VALUES(@ID,
			'Mis certificados',
			1001,
			20,
			'Mobile/MisCertificados',
			'',
			0,
			'Menu',
			'Mobile',
			1,
			'')



	END


END



