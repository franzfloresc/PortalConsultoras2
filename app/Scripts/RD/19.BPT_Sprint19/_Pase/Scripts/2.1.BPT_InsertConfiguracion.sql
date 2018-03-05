﻿USE BelcorpPeru
GO

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
           ,'PE_2017102380_iujbjjxdcm.png'
           ,'PE_20171023149_brxsonvgtg.png'
           ,'PE_20171023174_kjbcunahse.png'
           ,'PE_20171023200_plttupxvop.png'
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
           ,'PE_20171045539_xfwrimsvol.png'
           ,'PE_2018129890_hlumexyxne.png'
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

USE BelcorpMexico
GO

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
           ,'PE_2017102380_iujbjjxdcm.png'
           ,'PE_20171023149_brxsonvgtg.png'
           ,'PE_20171023174_kjbcunahse.png'
           ,'PE_20171023200_plttupxvop.png'
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
           ,'PE_20171045539_xfwrimsvol.png'
           ,'PE_2018129890_hlumexyxne.png'
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

USE BelcorpColombia
GO

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
           ,'PE_2017102380_iujbjjxdcm.png'
           ,'PE_20171023149_brxsonvgtg.png'
           ,'PE_20171023174_kjbcunahse.png'
           ,'PE_20171023200_plttupxvop.png'
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
           ,'PE_20171045539_xfwrimsvol.png'
           ,'PE_2018129890_hlumexyxne.png'
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

USE BelcorpVenezuela
GO

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
           ,'PE_2017102380_iujbjjxdcm.png'
           ,'PE_20171023149_brxsonvgtg.png'
           ,'PE_20171023174_kjbcunahse.png'
           ,'PE_20171023200_plttupxvop.png'
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
           ,'PE_20171045539_xfwrimsvol.png'
           ,'PE_2018129890_hlumexyxne.png'
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

USE BelcorpSalvador
GO

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
           ,'PE_2017102380_iujbjjxdcm.png'
           ,'PE_20171023149_brxsonvgtg.png'
           ,'PE_20171023174_kjbcunahse.png'
           ,'PE_20171023200_plttupxvop.png'
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
           ,'PE_20171045539_xfwrimsvol.png'
           ,'PE_2018129890_hlumexyxne.png'
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

USE BelcorpPuertoRico
GO

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
           ,'PE_2017102380_iujbjjxdcm.png'
           ,'PE_20171023149_brxsonvgtg.png'
           ,'PE_20171023174_kjbcunahse.png'
           ,'PE_20171023200_plttupxvop.png'
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
           ,'PE_20171045539_xfwrimsvol.png'
           ,'PE_2018129890_hlumexyxne.png'
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

USE BelcorpPanama
GO

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
           ,'PE_2017102380_iujbjjxdcm.png'
           ,'PE_20171023149_brxsonvgtg.png'
           ,'PE_20171023174_kjbcunahse.png'
           ,'PE_20171023200_plttupxvop.png'
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
           ,'PE_20171045539_xfwrimsvol.png'
           ,'PE_2018129890_hlumexyxne.png'
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

USE BelcorpGuatemala
GO

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
           ,'PE_2017102380_iujbjjxdcm.png'
           ,'PE_20171023149_brxsonvgtg.png'
           ,'PE_20171023174_kjbcunahse.png'
           ,'PE_20171023200_plttupxvop.png'
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
           ,'PE_20171045539_xfwrimsvol.png'
           ,'PE_2018129890_hlumexyxne.png'
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

USE BelcorpEcuador
GO

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
           ,'PE_2017102380_iujbjjxdcm.png'
           ,'PE_20171023149_brxsonvgtg.png'
           ,'PE_20171023174_kjbcunahse.png'
           ,'PE_20171023200_plttupxvop.png'
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
           ,'PE_20171045539_xfwrimsvol.png'
           ,'PE_2018129890_hlumexyxne.png'
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

USE BelcorpDominicana
GO

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
           ,'PE_2017102380_iujbjjxdcm.png'
           ,'PE_20171023149_brxsonvgtg.png'
           ,'PE_20171023174_kjbcunahse.png'
           ,'PE_20171023200_plttupxvop.png'
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
           ,'PE_20171045539_xfwrimsvol.png'
           ,'PE_2018129890_hlumexyxne.png'
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

USE BelcorpCostaRica
GO

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
           ,'PE_2017102380_iujbjjxdcm.png'
           ,'PE_20171023149_brxsonvgtg.png'
           ,'PE_20171023174_kjbcunahse.png'
           ,'PE_20171023200_plttupxvop.png'
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
           ,'PE_20171045539_xfwrimsvol.png'
           ,'PE_2018129890_hlumexyxne.png'
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

USE BelcorpChile
GO

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
           ,'PE_2017102380_iujbjjxdcm.png'
           ,'PE_20171023149_brxsonvgtg.png'
           ,'PE_20171023174_kjbcunahse.png'
           ,'PE_20171023200_plttupxvop.png'
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
           ,'PE_20171045539_xfwrimsvol.png'
           ,'PE_2018129890_hlumexyxne.png'
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

USE BelcorpBolivia
GO

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
           ,'PE_2017102380_iujbjjxdcm.png'
           ,'PE_20171023149_brxsonvgtg.png'
           ,'PE_20171023174_kjbcunahse.png'
           ,'PE_20171023200_plttupxvop.png'
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
           ,'PE_20171045539_xfwrimsvol.png'
           ,'PE_2018129890_hlumexyxne.png'
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
