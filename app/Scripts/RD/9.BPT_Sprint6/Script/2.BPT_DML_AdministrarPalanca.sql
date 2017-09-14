
USE BelcorpPeru
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 5, 'Showroom')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 6, 'Oferta del día')
GO

-- Agregar campo del menu para configuracion del perfil de la estrategia

IF NOT EXISTS (
  SELECT [PermisoID] 
  FROM   [dbo].[Permiso] 
  WHERE  PermisoID = 141
)
BEGIN
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
     VALUES
           ( 141
           , 'Configurar Palanca'
           , 111
           , 28
           , 'AdministrarPalanca/Index'
           , 0
           , 'Header'
           , ''
           , 0
           , 0
           , 0
           , 0
           , null )

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar)
	VALUES (4, 141, 1, 1)
END
GO
/*end*/

USE BelcorpMexico
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 5, 'Showroom')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 6, 'Oferta del día')
GO

-- Agregar campo del menu para configuracion del perfil de la estrategia

IF NOT EXISTS (
  SELECT [PermisoID] 
  FROM   [dbo].[Permiso] 
  WHERE  PermisoID = 141
)
BEGIN
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
     VALUES
           ( 141
           , 'Configurar Palanca'
           , 111
           , 28
           , 'AdministrarPalanca/Index'
           , 0
           , 'Header'
           , ''
           , 0
           , 0
           , 0
           , 0
           , null )

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar)
	VALUES (4, 141, 1, 1)
END
GO
/*end*/

USE BelcorpColombia
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 5, 'Showroom')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 6, 'Oferta del día')
GO

-- Agregar campo del menu para configuracion del perfil de la estrategia

IF NOT EXISTS (
  SELECT [PermisoID] 
  FROM   [dbo].[Permiso] 
  WHERE  PermisoID = 141
)
BEGIN
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
     VALUES
           ( 141
           , 'Configurar Palanca'
           , 111
           , 28
           , 'AdministrarPalanca/Index'
           , 0
           , 'Header'
           , ''
           , 0
           , 0
           , 0
           , 0
           , null )

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar)
	VALUES (4, 141, 1, 1)
END
GO
/*end*/

USE BelcorpVenezuela
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 5, 'Showroom')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 6, 'Oferta del día')
GO

-- Agregar campo del menu para configuracion del perfil de la estrategia

IF NOT EXISTS (
  SELECT [PermisoID] 
  FROM   [dbo].[Permiso] 
  WHERE  PermisoID = 141
)
BEGIN
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
     VALUES
           ( 141
           , 'Configurar Palanca'
           , 111
           , 28
           , 'AdministrarPalanca/Index'
           , 0
           , 'Header'
           , ''
           , 0
           , 0
           , 0
           , 0
           , null )

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar)
	VALUES (4, 141, 1, 1)
END
GO
/*end*/

USE BelcorpSalvador
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 5, 'Showroom')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 6, 'Oferta del día')
GO

-- Agregar campo del menu para configuracion del perfil de la estrategia

IF NOT EXISTS (
  SELECT [PermisoID] 
  FROM   [dbo].[Permiso] 
  WHERE  PermisoID = 141
)
BEGIN
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
     VALUES
           ( 141
           , 'Configurar Palanca'
           , 111
           , 28
           , 'AdministrarPalanca/Index'
           , 0
           , 'Header'
           , ''
           , 0
           , 0
           , 0
           , 0
           , null )

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar)
	VALUES (4, 141, 1, 1)
END
GO
/*end*/

USE BelcorpPuertoRico
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 5, 'Showroom')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 6, 'Oferta del día')
GO

-- Agregar campo del menu para configuracion del perfil de la estrategia

IF NOT EXISTS (
  SELECT [PermisoID] 
  FROM   [dbo].[Permiso] 
  WHERE  PermisoID = 141
)
BEGIN
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
     VALUES
           ( 141
           , 'Configurar Palanca'
           , 111
           , 28
           , 'AdministrarPalanca/Index'
           , 0
           , 'Header'
           , ''
           , 0
           , 0
           , 0
           , 0
           , null )

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar)
	VALUES (4, 141, 1, 1)
END
GO
/*end*/

USE BelcorpPanama
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 5, 'Showroom')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 6, 'Oferta del día')
GO

-- Agregar campo del menu para configuracion del perfil de la estrategia

IF NOT EXISTS (
  SELECT [PermisoID] 
  FROM   [dbo].[Permiso] 
  WHERE  PermisoID = 141
)
BEGIN
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
     VALUES
           ( 141
           , 'Configurar Palanca'
           , 111
           , 28
           , 'AdministrarPalanca/Index'
           , 0
           , 'Header'
           , ''
           , 0
           , 0
           , 0
           , 0
           , null )

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar)
	VALUES (4, 141, 1, 1)
END
GO
/*end*/

USE BelcorpGuatemala
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 5, 'Showroom')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 6, 'Oferta del día')
GO

-- Agregar campo del menu para configuracion del perfil de la estrategia

IF NOT EXISTS (
  SELECT [PermisoID] 
  FROM   [dbo].[Permiso] 
  WHERE  PermisoID = 141
)
BEGIN
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
     VALUES
           ( 141
           , 'Configurar Palanca'
           , 111
           , 28
           , 'AdministrarPalanca/Index'
           , 0
           , 'Header'
           , ''
           , 0
           , 0
           , 0
           , 0
           , null )

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar)
	VALUES (4, 141, 1, 1)
END
GO
/*end*/

USE BelcorpEcuador
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 5, 'Showroom')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 6, 'Oferta del día')
GO

-- Agregar campo del menu para configuracion del perfil de la estrategia

IF NOT EXISTS (
  SELECT [PermisoID] 
  FROM   [dbo].[Permiso] 
  WHERE  PermisoID = 141
)
BEGIN
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
     VALUES
           ( 141
           , 'Configurar Palanca'
           , 111
           , 28
           , 'AdministrarPalanca/Index'
           , 0
           , 'Header'
           , ''
           , 0
           , 0
           , 0
           , 0
           , null )

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar)
	VALUES (4, 141, 1, 1)
END
GO
/*end*/

USE BelcorpDominicana
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 5, 'Showroom')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 6, 'Oferta del día')
GO

-- Agregar campo del menu para configuracion del perfil de la estrategia

IF NOT EXISTS (
  SELECT [PermisoID] 
  FROM   [dbo].[Permiso] 
  WHERE  PermisoID = 141
)
BEGIN
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
     VALUES
           ( 141
           , 'Configurar Palanca'
           , 111
           , 28
           , 'AdministrarPalanca/Index'
           , 0
           , 'Header'
           , ''
           , 0
           , 0
           , 0
           , 0
           , null )

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar)
	VALUES (4, 141, 1, 1)
END
GO
/*end*/

USE BelcorpCostaRica
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 5, 'Showroom')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 6, 'Oferta del día')
GO

-- Agregar campo del menu para configuracion del perfil de la estrategia

IF NOT EXISTS (
  SELECT [PermisoID] 
  FROM   [dbo].[Permiso] 
  WHERE  PermisoID = 141
)
BEGIN
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
     VALUES
           ( 141
           , 'Configurar Palanca'
           , 111
           , 28
           , 'AdministrarPalanca/Index'
           , 0
           , 'Header'
           , ''
           , 0
           , 0
           , 0
           , 0
           , null )

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar)
	VALUES (4, 141, 1, 1)
END
GO
/*end*/

USE BelcorpChile
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 5, 'Showroom')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 6, 'Oferta del día')
GO

-- Agregar campo del menu para configuracion del perfil de la estrategia

IF NOT EXISTS (
  SELECT [PermisoID] 
  FROM   [dbo].[Permiso] 
  WHERE  PermisoID = 141
)
BEGIN
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
     VALUES
           ( 141
           , 'Configurar Palanca'
           , 111
           , 28
           , 'AdministrarPalanca/Index'
           , 0
           , 'Header'
           , ''
           , 0
           , 0
           , 0
           , 0
           , null )

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar)
	VALUES (4, 141, 1, 1)
END
GO
/*end*/

USE BelcorpBolivia
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 5, 'Showroom')
GO
INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 6, 'Oferta del día')
GO

-- Agregar campo del menu para configuracion del perfil de la estrategia

IF NOT EXISTS (
  SELECT [PermisoID] 
  FROM   [dbo].[Permiso] 
  WHERE  PermisoID = 141
)
BEGIN
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
     VALUES
           ( 141
           , 'Configurar Palanca'
           , 111
           , 28
           , 'AdministrarPalanca/Index'
           , 0
           , 'Header'
           , ''
           , 0
           , 0
           , 0
           , 0
           , null )

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar)
	VALUES (4, 141, 1, 1)
END
GO