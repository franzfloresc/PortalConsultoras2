
USE BelcorpPeru
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

if not exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12005, 120, 5, 'Showroom')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12006, 120, 6, 'Oferta del día')


end

go

-- Agregar campo del menu para configuracion del perfil de la estrategia

DECLARE @PermisoID INT
DECLARE @OrdenItem INT

if not exists (select 1 from Permiso where Descripcion = 'Configurar Contenedor')
begin

	SELECT @PermisoID=MAX(PermisoID), @OrdenItem=MAX(OrdenItem) FROM Permiso
	SELECT @PermisoID, @OrdenItem

	INSERT INTO Permiso
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
	(@PermisoID+1
	,'Configurar Contenedor'
	,111
	,@OrdenItem+1
	,'AdministrarPalanca/Index'
	,0
	,'Header'
	,''
	,0
	,0
	,0
	,0
	, null)

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(4,@PermisoID+1,1,1)

end

GO

/*end*/

USE BelcorpMexico
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

if not exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12005, 120, 5, 'Showroom')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12006, 120, 6, 'Oferta del día')


end

go

-- Agregar campo del menu para configuracion del perfil de la estrategia

DECLARE @PermisoID INT
DECLARE @OrdenItem INT

if not exists (select 1 from Permiso where Descripcion = 'Configurar Contenedor')
begin

	SELECT @PermisoID=MAX(PermisoID), @OrdenItem=MAX(OrdenItem) FROM Permiso
	SELECT @PermisoID, @OrdenItem

	INSERT INTO Permiso
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
	(@PermisoID+1
	,'Configurar Contenedor'
	,111
	,@OrdenItem+1
	,'AdministrarPalanca/Index'
	,0
	,'Header'
	,''
	,0
	,0
	,0
	,0
	, null)

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(4,@PermisoID+1,1,1)

end

GO

/*end*/

USE BelcorpColombia
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

if not exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12005, 120, 5, 'Showroom')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12006, 120, 6, 'Oferta del día')


end

go

-- Agregar campo del menu para configuracion del perfil de la estrategia

DECLARE @PermisoID INT
DECLARE @OrdenItem INT

if not exists (select 1 from Permiso where Descripcion = 'Configurar Contenedor')
begin

	SELECT @PermisoID=MAX(PermisoID), @OrdenItem=MAX(OrdenItem) FROM Permiso
	SELECT @PermisoID, @OrdenItem

	INSERT INTO Permiso
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
	(@PermisoID+1
	,'Configurar Contenedor'
	,111
	,@OrdenItem+1
	,'AdministrarPalanca/Index'
	,0
	,'Header'
	,''
	,0
	,0
	,0
	,0
	, null)

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(4,@PermisoID+1,1,1)

end

GO

/*end*/

USE BelcorpVenezuela
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

if not exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12005, 120, 5, 'Showroom')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12006, 120, 6, 'Oferta del día')


end

go

-- Agregar campo del menu para configuracion del perfil de la estrategia

DECLARE @PermisoID INT
DECLARE @OrdenItem INT

if not exists (select 1 from Permiso where Descripcion = 'Configurar Contenedor')
begin

	SELECT @PermisoID=MAX(PermisoID), @OrdenItem=MAX(OrdenItem) FROM Permiso
	SELECT @PermisoID, @OrdenItem

	INSERT INTO Permiso
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
	(@PermisoID+1
	,'Configurar Contenedor'
	,111
	,@OrdenItem+1
	,'AdministrarPalanca/Index'
	,0
	,'Header'
	,''
	,0
	,0
	,0
	,0
	, null)

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(4,@PermisoID+1,1,1)

end

GO

/*end*/

USE BelcorpSalvador
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

if not exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12005, 120, 5, 'Showroom')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12006, 120, 6, 'Oferta del día')


end

go

-- Agregar campo del menu para configuracion del perfil de la estrategia

DECLARE @PermisoID INT
DECLARE @OrdenItem INT

if not exists (select 1 from Permiso where Descripcion = 'Configurar Contenedor')
begin

	SELECT @PermisoID=MAX(PermisoID), @OrdenItem=MAX(OrdenItem) FROM Permiso
	SELECT @PermisoID, @OrdenItem

	INSERT INTO Permiso
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
	(@PermisoID+1
	,'Configurar Contenedor'
	,111
	,@OrdenItem+1
	,'AdministrarPalanca/Index'
	,0
	,'Header'
	,''
	,0
	,0
	,0
	,0
	, null)

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(4,@PermisoID+1,1,1)

end

GO

/*end*/

USE BelcorpPuertoRico
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

if not exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12005, 120, 5, 'Showroom')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12006, 120, 6, 'Oferta del día')


end

go

-- Agregar campo del menu para configuracion del perfil de la estrategia

DECLARE @PermisoID INT
DECLARE @OrdenItem INT

if not exists (select 1 from Permiso where Descripcion = 'Configurar Contenedor')
begin

	SELECT @PermisoID=MAX(PermisoID), @OrdenItem=MAX(OrdenItem) FROM Permiso
	SELECT @PermisoID, @OrdenItem

	INSERT INTO Permiso
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
	(@PermisoID+1
	,'Configurar Contenedor'
	,111
	,@OrdenItem+1
	,'AdministrarPalanca/Index'
	,0
	,'Header'
	,''
	,0
	,0
	,0
	,0
	, null)

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(4,@PermisoID+1,1,1)

end

GO

/*end*/

USE BelcorpPanama
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

if not exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12005, 120, 5, 'Showroom')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12006, 120, 6, 'Oferta del día')


end

go

-- Agregar campo del menu para configuracion del perfil de la estrategia

DECLARE @PermisoID INT
DECLARE @OrdenItem INT

if not exists (select 1 from Permiso where Descripcion = 'Configurar Contenedor')
begin

	SELECT @PermisoID=MAX(PermisoID), @OrdenItem=MAX(OrdenItem) FROM Permiso
	SELECT @PermisoID, @OrdenItem

	INSERT INTO Permiso
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
	(@PermisoID+1
	,'Configurar Contenedor'
	,111
	,@OrdenItem+1
	,'AdministrarPalanca/Index'
	,0
	,'Header'
	,''
	,0
	,0
	,0
	,0
	, null)

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(4,@PermisoID+1,1,1)

end

GO

/*end*/

USE BelcorpGuatemala
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

if not exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12005, 120, 5, 'Showroom')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12006, 120, 6, 'Oferta del día')


end

go

-- Agregar campo del menu para configuracion del perfil de la estrategia

DECLARE @PermisoID INT
DECLARE @OrdenItem INT

if not exists (select 1 from Permiso where Descripcion = 'Configurar Contenedor')
begin

	SELECT @PermisoID=MAX(PermisoID), @OrdenItem=MAX(OrdenItem) FROM Permiso
	SELECT @PermisoID, @OrdenItem

	INSERT INTO Permiso
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
	(@PermisoID+1
	,'Configurar Contenedor'
	,111
	,@OrdenItem+1
	,'AdministrarPalanca/Index'
	,0
	,'Header'
	,''
	,0
	,0
	,0
	,0
	, null)

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(4,@PermisoID+1,1,1)

end

GO

/*end*/

USE BelcorpEcuador
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

if not exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12005, 120, 5, 'Showroom')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12006, 120, 6, 'Oferta del día')


end

go

-- Agregar campo del menu para configuracion del perfil de la estrategia

DECLARE @PermisoID INT
DECLARE @OrdenItem INT

if not exists (select 1 from Permiso where Descripcion = 'Configurar Contenedor')
begin

	SELECT @PermisoID=MAX(PermisoID), @OrdenItem=MAX(OrdenItem) FROM Permiso
	SELECT @PermisoID, @OrdenItem

	INSERT INTO Permiso
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
	(@PermisoID+1
	,'Configurar Contenedor'
	,111
	,@OrdenItem+1
	,'AdministrarPalanca/Index'
	,0
	,'Header'
	,''
	,0
	,0
	,0
	,0
	, null)

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(4,@PermisoID+1,1,1)

end

GO

/*end*/

USE BelcorpDominicana
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

if not exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12005, 120, 5, 'Showroom')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12006, 120, 6, 'Oferta del día')


end

go

-- Agregar campo del menu para configuracion del perfil de la estrategia

DECLARE @PermisoID INT
DECLARE @OrdenItem INT

if not exists (select 1 from Permiso where Descripcion = 'Configurar Contenedor')
begin

	SELECT @PermisoID=MAX(PermisoID), @OrdenItem=MAX(OrdenItem) FROM Permiso
	SELECT @PermisoID, @OrdenItem

	INSERT INTO Permiso
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
	(@PermisoID+1
	,'Configurar Contenedor'
	,111
	,@OrdenItem+1
	,'AdministrarPalanca/Index'
	,0
	,'Header'
	,''
	,0
	,0
	,0
	,0
	, null)

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(4,@PermisoID+1,1,1)

end

GO

/*end*/

USE BelcorpCostaRica
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

if not exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12005, 120, 5, 'Showroom')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12006, 120, 6, 'Oferta del día')


end

go

-- Agregar campo del menu para configuracion del perfil de la estrategia

DECLARE @PermisoID INT
DECLARE @OrdenItem INT

if not exists (select 1 from Permiso where Descripcion = 'Configurar Contenedor')
begin

	SELECT @PermisoID=MAX(PermisoID), @OrdenItem=MAX(OrdenItem) FROM Permiso
	SELECT @PermisoID, @OrdenItem

	INSERT INTO Permiso
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
	(@PermisoID+1
	,'Configurar Contenedor'
	,111
	,@OrdenItem+1
	,'AdministrarPalanca/Index'
	,0
	,'Header'
	,''
	,0
	,0
	,0
	,0
	, null)

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(4,@PermisoID+1,1,1)

end

GO

/*end*/

USE BelcorpChile
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

if not exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12005, 120, 5, 'Showroom')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12006, 120, 6, 'Oferta del día')

end

go

-- Agregar campo del menu para configuracion del perfil de la estrategia

DECLARE @PermisoID INT
DECLARE @OrdenItem INT

if not exists (select 1 from Permiso where Descripcion = 'Configurar Contenedor')
begin

	SELECT @PermisoID=MAX(PermisoID), @OrdenItem=MAX(OrdenItem) FROM Permiso
	SELECT @PermisoID, @OrdenItem

	INSERT INTO Permiso
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
	(@PermisoID+1
	,'Configurar Contenedor'
	,111
	,@OrdenItem+1
	,'AdministrarPalanca/Index'
	,0
	,'Header'
	,''
	,0
	,0
	,0
	,0
	, null)

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(4,@PermisoID+1,1,1)

end

GO

/*end*/

USE BelcorpBolivia
GO

-- Agregar Tipo de presentacion en la Tabla logica datos

if not exists (select 1 from TablaLogica where Descripcion = 'Tipo Presentacion Carrusel')
begin

INSERT INTO TablaLogica (TablaLogicaID, Descripcion) 
VALUES (120, 'Tipo Presentacion Carrusel')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12001, 120, 1, 'Carrusel Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12002, 120, 2, 'Carrusel Con Previsuales')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12003, 120, 3, 'Seccion Simple')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12004, 120, 4, 'Banners')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12005, 120, 5, 'Showroom')

INSERT INTO [TablaLogicaDatos] ([TablaLogicaDatosID], [TablaLogicaID], [Codigo], [Descripcion])
VALUES (12006, 120, 6, 'Oferta del día')

end

go

-- Agregar campo del menu para configuracion del perfil de la estrategia

DECLARE @PermisoID INT
DECLARE @OrdenItem INT

if not exists (select 1 from Permiso where Descripcion = 'Configurar Contenedor')
begin

	SELECT @PermisoID=MAX(PermisoID), @OrdenItem=MAX(OrdenItem) FROM Permiso
	SELECT @PermisoID, @OrdenItem

	INSERT INTO Permiso
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
	(@PermisoID+1
	,'Configurar Contenedor'
	,111
	,@OrdenItem+1
	,'AdministrarPalanca/Index'
	,0
	,'Header'
	,''
	,0
	,0
	,0
	,0
	, null)

	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(4,@PermisoID+1,1,1)

end

GO

/*end*/