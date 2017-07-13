USE BelcorpBolivia
GO
IF NOT EXISTS(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' AND IdPadre = 1003
)
BEGIN
	INSERT INTO Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
	VALUES(1019, 'Consultora Online', 1003, 8, 'ConsultoraOnline/Index', 0, 'Header', NULL, 0, 0, 0, 1);
END
GO
IF NOT EXISTS(
	select 1
	from MenuMobile
	where Descripcion = 'Consultora Online' AND MenuPadreID = 1001
)
BEGIN
	INSERT INTO MenuMobile(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2)
	VALUES(1007, 'Consultora Online', 1001, 7, 'Mobile/ConsultoraOnline', '',	0, 'Menu', 'Mobile', 1)
END
GO
/*end*/

USE BelcorpChile
GO
IF NOT EXISTS(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' AND IdPadre = 1003
)
BEGIN
	INSERT INTO Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
	VALUES(1019, 'Consultora Online', 1003, 8, 'ConsultoraOnline/Index', 0, 'Header', NULL, 0, 0, 0, 1);
END
GO
IF NOT EXISTS(
	select 1
	from MenuMobile
	where Descripcion = 'Consultora Online' AND MenuPadreID = 1001
)
BEGIN
	INSERT INTO MenuMobile(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2)
	VALUES(1007, 'Consultora Online', 1001, 7, 'Mobile/ConsultoraOnline', '',	0, 'Menu', 'Mobile', 1)
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF NOT EXISTS(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' AND IdPadre = 1003
)
BEGIN
	INSERT INTO Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
	VALUES(1019, 'Consultora Online', 1003, 8, 'ConsultoraOnline/Index', 0, 'Header', NULL, 0, 0, 0, 1);
END
GO
IF NOT EXISTS(
	select 1
	from MenuMobile
	where Descripcion = 'Consultora Online' AND MenuPadreID = 1001
)
BEGIN
	INSERT INTO MenuMobile(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2)
	VALUES(1007, 'Consultora Online', 1001, 7, 'Mobile/ConsultoraOnline', '',	0, 'Menu', 'Mobile', 1)
END
GO
/*end*/

USE BelcorpEcuador
GO
IF NOT EXISTS(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' AND IdPadre = 1003
)
BEGIN
	INSERT INTO Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
	VALUES(1019, 'Consultora Online', 1003, 8, 'ConsultoraOnline/Index', 0, 'Header', NULL, 0, 0, 0, 1);
END
GO
IF NOT EXISTS(
	select 1
	from MenuMobile
	where Descripcion = 'Consultora Online' AND MenuPadreID = 1001
)
BEGIN
	INSERT INTO MenuMobile(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2)
	VALUES(1007, 'Consultora Online', 1001, 7, 'Mobile/ConsultoraOnline', '',	0, 'Menu', 'Mobile', 1)
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF NOT EXISTS(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' AND IdPadre = 1003
)
BEGIN
	INSERT INTO Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
	VALUES(1019, 'Consultora Online', 1003, 8, 'ConsultoraOnline/Index', 0, 'Header', NULL, 0, 0, 0, 1);
END
GO
IF NOT EXISTS(
	select 1
	from MenuMobile
	where Descripcion = 'Consultora Online' AND MenuPadreID = 1001
)
BEGIN
	INSERT INTO MenuMobile(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2)
	VALUES(1007, 'Consultora Online', 1001, 7, 'Mobile/ConsultoraOnline', '',	0, 'Menu', 'Mobile', 1)
END
GO
/*end*/

USE BelcorpColombia
GO
IF NOT EXISTS(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' AND IdPadre = 1003
)
BEGIN
	INSERT INTO Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
	VALUES(1019, 'Consultora Online', 1003, 8, 'ConsultoraOnline/Index', 0, 'Header', NULL, 0, 0, 0, 1);
END
GO
IF NOT EXISTS(
	select 1
	from MenuMobile
	where Descripcion = 'Consultora Online' AND MenuPadreID = 1001
)
BEGIN
	INSERT INTO MenuMobile(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2)
	VALUES(1007, 'Consultora Online', 1001, 7, 'Mobile/ConsultoraOnline', '',	0, 'Menu', 'Mobile', 1)
END
GO
/*end*/

USE BelcorpMexico
GO
IF NOT EXISTS(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' AND IdPadre = 1003
)
BEGIN
	INSERT INTO Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
	VALUES(1019, 'Consultora Online', 1003, 8, 'ConsultoraOnline/Index', 0, 'Header', NULL, 0, 0, 0, 1);
END
GO
IF NOT EXISTS(
	select 1
	from MenuMobile
	where Descripcion = 'Consultora Online' AND MenuPadreID = 1001
)
BEGIN
	INSERT INTO MenuMobile(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2)
	VALUES(1007, 'Consultora Online', 1001, 7, 'Mobile/ConsultoraOnline', '',	0, 'Menu', 'Mobile', 1)
END
GO
/*end*/

USE BelcorpPeru
GO
IF NOT EXISTS(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' AND IdPadre = 1003
)
BEGIN
	INSERT INTO Permiso(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
	VALUES(1019, 'Consultora Online', 1003, 8, 'ConsultoraOnline/Index', 0, 'Header', NULL, 0, 0, 0, 1);
END
GO
IF NOT EXISTS(
	select 1
	from MenuMobile
	where Descripcion = 'Consultora Online' AND MenuPadreID = 1001
)
BEGIN
	INSERT INTO MenuMobile(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version], EsSB2)
	VALUES(1007, 'Consultora Online', 1001, 7, 'Mobile/ConsultoraOnline', '',	0, 'Menu', 'Mobile', 1)
END
GO