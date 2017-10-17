USE BelcorpPeru_BPT
GO

IF EXISTS(
		SELECT 1
		FROM Permiso P
		WHERE P.Codigo = 'GND'
	)
BEGIN
	DECLARE @RolAdmContenidoId INT = 0, @MenuGuiaNegocioDigitalizadaId INT = 0
	
	SELECT @RolAdmContenidoId = RolId
	FROM Rol R
	WHERE R.Descripcion = 'Adm Contenido'

	SELECT @MenuGuiaNegocioDigitalizadaId = P.PermisoId
	FROM PERMISO P
	WHERE P.Codigo = 'GND'

	PRINT 'Deleting ''Guía de Negocio Digitalizada'' from RolPermiso table'
	DELETE RP
	FROM ROLPERMISO RP
	WHERE RP.RolID = @RolAdmContenidoId
	AND PermisoID =@MenuGuiaNegocioDigitalizadaId



	PRINT 'Deleting ''Guía de Negocio Digitalizada'' from Permiso table'
	DELETE P
	FROM PERMISO P
	WHERE P.PermisoID = @MenuGuiaNegocioDigitalizadaId
END