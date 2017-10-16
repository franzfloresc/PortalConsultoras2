USE BelcorpPeru_BPT
GO


IF NOT EXISTS(
		SELECT 1
		FROM Permiso P
		WHERE P.Codigo = 'GND'
	)
BEGIN
	DECLARE @PermisoId INT = 0,@MenuGestionContenidosId INT = 0,@MenuOpcionesId INT = 0,@OrdenItem INT = 0
	DECLARE @RolAdmContenidoId INT = 0

	SELECT @PermisoId = MAX(P.[PermisoID]) + 1
	FROM Permiso P

	SELECT @MenuGestionContenidosId = p.[PermisoID]
	FROM [Permiso] P
	WHERE P.[Descripcion] = 'Gestión de Contenidos'

	SELECT  @MenuOpcionesId = p.[PermisoID]
	FROM [Permiso] P
	WHERE P.[Descripcion] = 'Opciones'
	and p.IdPadre = @MenuGestionContenidosId

	SELECT  @OrdenItem =Max(p.[OrdenItem]) + 1
	FROM [Permiso] P
	WHERE p.IdPadre = @MenuOpcionesId

	PRINT 'Inserting option ''Configurar Guía de Negocio Digitalizada'' into Permiso table'
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
	(
	@PermisoId
	,'Configurar Guía de Negocio Digitalizada'
	,@MenuOpcionesId
	,@OrdenItem
	,'AdministrarGuiaNegocioDigitalizada/Index'
	,0
	,'Header'
	,''
	,0
	,0
	,0
	,0
	,'GND'
	)

	SELECT @RolAdmContenidoId = R.RolId
	FROM Rol R
	WHERE  R.DESCRIPCION = 'Adm Contenido'
	
	INSERT INTO ROLPERMISO
	(
	RolID
	,PermisoID
	,Activo
	,Mostrar
	)
	VALUES
	(
	@RolAdmContenidoId
	,@PermisoId
	,1
	,1
	)

END