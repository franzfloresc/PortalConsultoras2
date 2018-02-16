USE [BelcorpPeru_BPT]
GO

IF NOT  EXISTS(SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'HV')
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
           ,'HERRAMIENTAS DE VENTA'
           ,1
           ,1
           ,'201801'
           ,'MobileTituloMenu... Preguntar Dana'
           ,'DesktopTituloMenu ... Preguntar Dana'
           ,NULL
           ,9
           ,'DesktopTituloBanner... Preguntar Dana'
           ,'MobileTituloBanner... Preguntar Dana'
           ,'DesktopSubTituloBanner ... Preguntar Dana'
           ,'MobileSubTituloBanner... Preguntar Dana'
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

IF NOT EXISTS (SELECT 1 FROM ConfiguracionOfertasHome 
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
           ,'Herramienta Venta - Preguntar dana'
           ,'Herramienta Venta - Preguntar dana'
           ,'Herramienta Venta - Preguntar dana'
           ,'Herramienta Venta - Preguntar dana'
           ,3
           ,4
           ,'011'
           ,'011'
           ,3
           ,0
           ,1
           ,1
           ,'HerramientasVenta/Index'
           ,9
           ,9)
GO

IF NOT EXISTS (SELECT 1 FROM TipoEstrategia WHERE Codigo = '011')
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
           ,'Herramienta Venta')
END
GO

delete from EstrategiaProducto where Campania = '201802' 

select ep.cuv2 from EstrategiaProducto ep
inner join Estrategia e on ep.EstrategiaId = e.EstrategiaId
where Campania = '201802' and e.Tipoestrategiaid = 3009
group by ep.cuv2

select * from estrategiaproducto where estrategiaid = 0

select * from TipoEstrategia

select * from ConfiguracionPais

select * from [ConfiguracionOfertasHome]

select * from estrategia where tipoestrategiaid = 3009 and campaniaid = '201717'

select top 100 * from ods.ofertaspersonalizadas where AnioCampanaVenta = '201718'

DELETE TOP(20)  FROM Estrategia where tipoestrategiaid = 3009 and campaniaid = '201802' and CUV2 in (
'95320',
'95321',
'95322',
'95364',
'95365',
'95387',
'95388',
'95395')

DELETE FROM EstrategiaProducto WHERE Campania = '201802' and CUV2 in (
'95320',
'95321',
'95322',
'95364',
'95365',
'95387',
'95388',
'95395')