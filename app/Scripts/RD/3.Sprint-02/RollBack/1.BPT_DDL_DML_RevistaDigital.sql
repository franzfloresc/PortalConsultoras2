USE BelcorpPeru
GO

BEGIN
	delete from MenuMobile where Codigo = 'RevistaDigital'
END
GO

BEGIN 
	declare @Aux int = 0

	select @Aux = PermisoID from Permiso where Codigo = 'RevistaDigital'
	delete from RolPermiso where PermisoID = @Aux
	delete from Permiso where PermisoID = @Aux
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------
IF EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
BEGIN
	delete FROM PopupPais where CodigoPopup = 9
	UPDATE PopupPais SET Orden = Orden - 1 WHERE Orden > 4; 
END
GO

/*end*/

USE BelcorpMexico
GO

BEGIN
	delete from MenuMobile where Codigo = 'RevistaDigital'
END
GO

BEGIN 
	declare @Aux int = 0

	select @Aux = PermisoID from Permiso where Codigo = 'RevistaDigital'
	delete from RolPermiso where PermisoID = @Aux
	delete from Permiso where PermisoID = @Aux
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------
IF EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
BEGIN
	delete FROM PopupPais where CodigoPopup = 9
	UPDATE PopupPais SET Orden = Orden - 1 WHERE Orden > 4; 
END
GO

/*end*/

USE BelcorpColombia
GO

BEGIN
	delete from MenuMobile where Codigo = 'RevistaDigital'
END
GO

BEGIN 
	declare @Aux int = 0

	select @Aux = PermisoID from Permiso where Codigo = 'RevistaDigital'
	delete from RolPermiso where PermisoID = @Aux
	delete from Permiso where PermisoID = @Aux
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------
IF EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
BEGIN
	delete FROM PopupPais where CodigoPopup = 9
	UPDATE PopupPais SET Orden = Orden - 1 WHERE Orden > 4; 
END
GO

/*end*/

USE BelcorpVenezuela
GO

BEGIN
	delete from MenuMobile where Codigo = 'RevistaDigital'
END
GO

BEGIN 
	declare @Aux int = 0

	select @Aux = PermisoID from Permiso where Codigo = 'RevistaDigital'
	delete from RolPermiso where PermisoID = @Aux
	delete from Permiso where PermisoID = @Aux
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------
IF EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
BEGIN
	delete FROM PopupPais where CodigoPopup = 9
	UPDATE PopupPais SET Orden = Orden - 1 WHERE Orden > 4; 
END
GO

/*end*/

USE BelcorpSalvador
GO

BEGIN
	delete from MenuMobile where Codigo = 'RevistaDigital'
END
GO

BEGIN 
	declare @Aux int = 0

	select @Aux = PermisoID from Permiso where Codigo = 'RevistaDigital'
	delete from RolPermiso where PermisoID = @Aux
	delete from Permiso where PermisoID = @Aux
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------
IF EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
BEGIN
	delete FROM PopupPais where CodigoPopup = 9
	UPDATE PopupPais SET Orden = Orden - 1 WHERE Orden > 4; 
END
GO

/*end*/

USE BelcorpPuertoRico
GO

BEGIN
	delete from MenuMobile where Codigo = 'RevistaDigital'
END
GO

BEGIN 
	declare @Aux int = 0

	select @Aux = PermisoID from Permiso where Codigo = 'RevistaDigital'
	delete from RolPermiso where PermisoID = @Aux
	delete from Permiso where PermisoID = @Aux
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------
IF EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
BEGIN
	delete FROM PopupPais where CodigoPopup = 9
	UPDATE PopupPais SET Orden = Orden - 1 WHERE Orden > 4; 
END
GO

/*end*/

USE BelcorpPanama
GO

BEGIN
	delete from MenuMobile where Codigo = 'RevistaDigital'
END
GO

BEGIN 
	declare @Aux int = 0

	select @Aux = PermisoID from Permiso where Codigo = 'RevistaDigital'
	delete from RolPermiso where PermisoID = @Aux
	delete from Permiso where PermisoID = @Aux
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------
IF EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
BEGIN
	delete FROM PopupPais where CodigoPopup = 9
	UPDATE PopupPais SET Orden = Orden - 1 WHERE Orden > 4; 
END
GO

/*end*/

USE BelcorpGuatemala
GO

BEGIN
	delete from MenuMobile where Codigo = 'RevistaDigital'
END
GO

BEGIN 
	declare @Aux int = 0

	select @Aux = PermisoID from Permiso where Codigo = 'RevistaDigital'
	delete from RolPermiso where PermisoID = @Aux
	delete from Permiso where PermisoID = @Aux
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------
IF EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
BEGIN
	delete FROM PopupPais where CodigoPopup = 9
	UPDATE PopupPais SET Orden = Orden - 1 WHERE Orden > 4; 
END
GO

/*end*/

USE BelcorpEcuador
GO

BEGIN
	delete from MenuMobile where Codigo = 'RevistaDigital'
END
GO

BEGIN 
	declare @Aux int = 0

	select @Aux = PermisoID from Permiso where Codigo = 'RevistaDigital'
	delete from RolPermiso where PermisoID = @Aux
	delete from Permiso where PermisoID = @Aux
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------
IF EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
BEGIN
	delete FROM PopupPais where CodigoPopup = 9
	UPDATE PopupPais SET Orden = Orden - 1 WHERE Orden > 4; 
END
GO

/*end*/

USE BelcorpDominicana
GO

BEGIN
	delete from MenuMobile where Codigo = 'RevistaDigital'
END
GO

BEGIN 
	declare @Aux int = 0

	select @Aux = PermisoID from Permiso where Codigo = 'RevistaDigital'
	delete from RolPermiso where PermisoID = @Aux
	delete from Permiso where PermisoID = @Aux
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------
IF EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
BEGIN
	delete FROM PopupPais where CodigoPopup = 9
	UPDATE PopupPais SET Orden = Orden - 1 WHERE Orden > 4; 
END
GO

/*end*/

USE BelcorpCostaRica
GO

BEGIN
	delete from MenuMobile where Codigo = 'RevistaDigital'
END
GO

BEGIN 
	declare @Aux int = 0

	select @Aux = PermisoID from Permiso where Codigo = 'RevistaDigital'
	delete from RolPermiso where PermisoID = @Aux
	delete from Permiso where PermisoID = @Aux
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------
IF EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
BEGIN
	delete FROM PopupPais where CodigoPopup = 9
	UPDATE PopupPais SET Orden = Orden - 1 WHERE Orden > 4; 
END
GO

/*end*/

USE BelcorpChile
GO

BEGIN
	delete from MenuMobile where Codigo = 'RevistaDigital'
END
GO

BEGIN 
	declare @Aux int = 0

	select @Aux = PermisoID from Permiso where Codigo = 'RevistaDigital'
	delete from RolPermiso where PermisoID = @Aux
	delete from Permiso where PermisoID = @Aux
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------
IF EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
BEGIN
	delete FROM PopupPais where CodigoPopup = 9
	UPDATE PopupPais SET Orden = Orden - 1 WHERE Orden > 4; 
END
GO

/*end*/

USE BelcorpBolivia
GO

BEGIN
	delete from MenuMobile where Codigo = 'RevistaDigital'
END
GO

BEGIN 
	declare @Aux int = 0

	select @Aux = PermisoID from Permiso where Codigo = 'RevistaDigital'
	delete from RolPermiso where PermisoID = @Aux
	delete from Permiso where PermisoID = @Aux
END
GO

------------------------------------------------------------------------
-- ALTERAR EL ORDEN DE LOS POPUPS (PARA LA CONVIVENCIA CON OTROS POPUPS)
------------------------------------------------------------------------
IF EXISTS (SELECT * FROM PopupPais where CodigoPopup = 9) 
BEGIN
	delete FROM PopupPais where CodigoPopup = 9
	UPDATE PopupPais SET Orden = Orden - 1 WHERE Orden > 4; 
END
GO