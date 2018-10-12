

USE BelcorpChile
GO

IF NOT EXISTS (
		SELECT 1
		FROM Permiso
		WHERE Codigo = 'UpSelling'
		)
BEGIN
	DECLARE @IdPadre INT = 111
	DECLARE @RolId INT = 4
	DECLARE @PermisoId INT
	DECLARE @OrdenItem INT

	SELECT @PermisoId = MAX(PermisoId)
	FROM Permiso

	SET @PermisoId = ISNULL(@PermisoId, 0) + 1

	SELECT @OrdenItem = MAX(OrdenItem)
	FROM Permiso
	WHERE IdPadre = @IdPadre

	SET @OrdenItem = ISNULL(@OrdenItem, 0) + 1

	INSERT INTO Permiso (
		PermisoID
		,Descripcion
		,IdPadre
		,OrdenItem
		,UrlItem
		,PaginaNueva
		,Posicion
		,UrlImagen
		,EsSoloImagen
		,EsMenuEspecial
		,EsServicios
		,EsPrincipal
		,Codigo
		)
	VALUES (
		@PermisoId
		,'UpSelling'
		,@IdPadre
		,@OrdenItem
		,'Upselling/Index'
		,0
		,'Header'
		,''
		,0
		,0
		,0
		,0
		,'UpSelling'
		)

	INSERT INTO RolPermiso (
		RolID
		,PermisoID
		,Activo
		,Mostrar
		)
	VALUES (
		@RolId
		,@PermisoId
		,1
		,1
		)
END
GO
