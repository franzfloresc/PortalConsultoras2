USE [BelcorpPeru_BPT]
GO

IF NOT  EXISTS(SELECT * FROM ConfiguracionPais WHERE Codigo = 'HV')
BEGIN 
	INSERT INTO [dbo].[ConfiguracionPais]
           ([Codigo]
           ,[Excluyente]
           ,[Descripcion]
           ,[Estado]
           ,[TienePerfil]
           ,[DesdeCampania]
           ,[MobileTituloMenu]
           ,[DesktopTituloMenu]
           ,[Logo]
           ,[Orden]
           ,[DesktopTituloBanner]
           ,[MobileTituloBanner]
           ,[DesktopSubTituloBanner]
           ,[MobileSubTituloBanner]
           ,[DesktopFondoBanner]
           ,[MobileFondoBanner]
           ,[DesktopLogoBanner]
           ,[MobileLogoBanner]
           ,[UrlMenu]
           ,[OrdenBpt]
           ,[MobileOrden]
           ,[MobileOrdenBPT])
     VALUES
           ('HV'
           ,1
           ,'Herramientas de Venta'
           ,1
           ,1
           ,'201801'
           ,'Demostradores'
           ,'Demostradores y herramientas'
           ,NULL
           ,9
           ,'Utiliza demostradores y herramientas de venta'
           ,'Cierra una venta exitosa'
           ,''
           ,'Cierra una venta exitosa'
           ,'inicio-banner-navidad-desktop-default.jpg'
           ,'inicio-banner-navidad-mobile-default.jpg'
           ,'logo-ganamas-desktop.png'
           ,'logo-ganamas-mobile.png'
           ,'HerramientaVenta/Index'
           ,9
           ,9
           ,9)
END 
GO

IF NOT EXISTS (SELECT * FROM ConfiguracionOfertasHome 
			WHERE ConfiguracionPaisID = (SELECT ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'HV')
           AND CampaniaID = '201801' )
	INSERT INTO [dbo].[ConfiguracionOfertasHome]
           ([ConfiguracionPaisID]
           ,[CampaniaID]
           ,[DesktopOrden]
           ,[MobileOrden]
           ,[DesktopImagenFondo]
           ,[MobileImagenFondo]
           ,[DesktopTitulo]
           ,[MobileTitulo]
           ,[DesktopSubTitulo]
           ,[MobileSubTitulo]
           ,[DesktopTipoPresentacion]
           ,[MobileTipoPresentacion]
           ,[DesktopTipoEstrategia]
           ,[MobileTipoEstrategia]
           ,[DesktopCantidadProductos]
           ,[MobileCantidadProductos]
           ,[DesktopActivo]
           ,[MobileActivo]
           ,[UrlSeccion]
           ,[DesktopOrdenBpt]
           ,[MobileOrdenBpt])
     VALUES
           ((SELECT ConfiguracionPaisId FROM ConfiguracionPais WHERE Codigo = 'HV')
           ,'201801'
           ,9
           ,9
           ,'herramientas-venta-desktop.png'
           ,'herramientas-venta-mobile.jpg'
           ,'Herramientas de venta'
           ,'Herramientas de venta'
           ,''
           ,''
           ,3
           ,4
           ,'011'
           ,'011'
           ,3
           ,0
           ,1
           ,1
           ,'HerramientasVenta/Comprar'
           ,9
           ,9)
GO

IF NOT EXISTS (SELECT * FROM TipoEstrategia WHERE Codigo = '011')
BEGIN
	INSERT INTO [dbo].[TipoEstrategia]
           ([DescripcionEstrategia]
           ,[ImagenEstrategia]
           ,[Orden]
           ,[FlagActivo]
           ,[UsuarioRegistro]
           ,[FechaRegistro]
           ,[UsuarioModificacion]
           ,[FechaModificacion]
           ,[flagNueva]
           ,[flagRecoProduc]
           ,[flagRecoPerfil]
           ,[CodigoPrograma]
           ,[FlagMostrarImg]
           ,[Codigo]
           ,[MostrarImgOfertaIndependiente]
           ,[ImagenOfertaIndependiente]
           ,[FlagValidarImagen]
           ,[PesoMaximoImagen]
           ,[NombreComercial])
     VALUES
           ('Herramientas de Venta'
           ,''
           ,16
           ,1
           ,''
           ,GETDATE()
           ,''
           ,GETDATE()
           ,0
           ,0
           ,1
           ,''
           ,0
           ,'011'
           ,0
           ,''
           ,0
           ,0
           ,'Herramientas de venta Gana+')
END
GO
