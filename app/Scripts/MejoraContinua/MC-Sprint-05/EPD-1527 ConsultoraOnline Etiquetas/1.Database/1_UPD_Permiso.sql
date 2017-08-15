USE BelcorpBolivia
GO
if exists(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
)
begin
	update Permiso
	set	Descripcion = 'App de Catálogos'
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
end
else if not exists(
	select 1
	from Permiso
	where Descripcion = 'App de Catálogos' and EsPrincipal = 1
)
begin
	insert into Permiso(
		PermisoID,
		Descripcion,
		IdPadre,
		OrdenItem,
		UrlItem,
		PaginaNueva,
		Posicion,
		UrlImagen,
		EsSoloImagen,
		EsMenuEspecial,
		EsServicios,
		EsPrincipal
	)
	values(
		1019,
		'App de Catálogos',
		1003,
		8,
		'ConsultoraOnline/Index',
		0,
		'Header',
		'',
		0,
		0,
		0,
		1
	)
end
GO
/*end*/

USE BelcorpChile
GO
if exists(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
)
begin
	update Permiso
	set	Descripcion = 'App de Catálogos'
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
end
else if not exists(
	select 1
	from Permiso
	where Descripcion = 'App de Catálogos' and EsPrincipal = 1
)
begin
	insert into Permiso(
		PermisoID,
		Descripcion,
		IdPadre,
		OrdenItem,
		UrlItem,
		PaginaNueva,
		Posicion,
		UrlImagen,
		EsSoloImagen,
		EsMenuEspecial,
		EsServicios,
		EsPrincipal
	)
	values(
		1019,
		'App de Catálogos',
		1003,
		8,
		'ConsultoraOnline/Index',
		0,
		'Header',
		'',
		0,
		0,
		0,
		1
	)
end
GO
/*end*/

USE BelcorpCostaRica
GO
if exists(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
)
begin
	update Permiso
	set	Descripcion = 'App de Catálogos'
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
end
else if not exists(
	select 1
	from Permiso
	where Descripcion = 'App de Catálogos' and EsPrincipal = 1
)
begin
	insert into Permiso(
		PermisoID,
		Descripcion,
		IdPadre,
		OrdenItem,
		UrlItem,
		PaginaNueva,
		Posicion,
		UrlImagen,
		EsSoloImagen,
		EsMenuEspecial,
		EsServicios,
		EsPrincipal
	)
	values(
		1019,
		'App de Catálogos',
		1003,
		8,
		'ConsultoraOnline/Index',
		0,
		'Header',
		'',
		0,
		0,
		0,
		1
	)
end
GO
/*end*/

USE BelcorpDominicana
GO
if exists(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
)
begin
	update Permiso
	set	Descripcion = 'App de Catálogos'
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
end
else if not exists(
	select 1
	from Permiso
	where Descripcion = 'App de Catálogos' and EsPrincipal = 1
)
begin
	insert into Permiso(
		PermisoID,
		Descripcion,
		IdPadre,
		OrdenItem,
		UrlItem,
		PaginaNueva,
		Posicion,
		UrlImagen,
		EsSoloImagen,
		EsMenuEspecial,
		EsServicios,
		EsPrincipal
	)
	values(
		1019,
		'App de Catálogos',
		1003,
		8,
		'ConsultoraOnline/Index',
		0,
		'Header',
		'',
		0,
		0,
		0,
		1
	)
end
GO
/*end*/

USE BelcorpEcuador
GO
if exists(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
)
begin
	update Permiso
	set	Descripcion = 'App de Catálogos'
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
end
else if not exists(
	select 1
	from Permiso
	where Descripcion = 'App de Catálogos' and EsPrincipal = 1
)
begin
	insert into Permiso(
		PermisoID,
		Descripcion,
		IdPadre,
		OrdenItem,
		UrlItem,
		PaginaNueva,
		Posicion,
		UrlImagen,
		EsSoloImagen,
		EsMenuEspecial,
		EsServicios,
		EsPrincipal
	)
	values(
		1019,
		'App de Catálogos',
		1003,
		8,
		'ConsultoraOnline/Index',
		0,
		'Header',
		'',
		0,
		0,
		0,
		1
	)
end
GO
/*end*/

USE BelcorpGuatemala
GO
if exists(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
)
begin
	update Permiso
	set	Descripcion = 'App de Catálogos'
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
end
else if not exists(
	select 1
	from Permiso
	where Descripcion = 'App de Catálogos' and EsPrincipal = 1
)
begin
	insert into Permiso(
		PermisoID,
		Descripcion,
		IdPadre,
		OrdenItem,
		UrlItem,
		PaginaNueva,
		Posicion,
		UrlImagen,
		EsSoloImagen,
		EsMenuEspecial,
		EsServicios,
		EsPrincipal
	)
	values(
		1019,
		'App de Catálogos',
		1003,
		8,
		'ConsultoraOnline/Index',
		0,
		'Header',
		'',
		0,
		0,
		0,
		1
	)
end
GO
/*end*/

USE BelcorpPanama
GO
if exists(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
)
begin
	update Permiso
	set	Descripcion = 'App de Catálogos'
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
end
else if not exists(
	select 1
	from Permiso
	where Descripcion = 'App de Catálogos' and EsPrincipal = 1
)
begin
	insert into Permiso(
		PermisoID,
		Descripcion,
		IdPadre,
		OrdenItem,
		UrlItem,
		PaginaNueva,
		Posicion,
		UrlImagen,
		EsSoloImagen,
		EsMenuEspecial,
		EsServicios,
		EsPrincipal
	)
	values(
		1019,
		'App de Catálogos',
		1003,
		8,
		'ConsultoraOnline/Index',
		0,
		'Header',
		'',
		0,
		0,
		0,
		1
	)
end
GO
/*end*/

USE BelcorpPuertoRico
GO
if exists(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
)
begin
	update Permiso
	set	Descripcion = 'App de Catálogos'
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
end
else if not exists(
	select 1
	from Permiso
	where Descripcion = 'App de Catálogos' and EsPrincipal = 1
)
begin
	insert into Permiso(
		PermisoID,
		Descripcion,
		IdPadre,
		OrdenItem,
		UrlItem,
		PaginaNueva,
		Posicion,
		UrlImagen,
		EsSoloImagen,
		EsMenuEspecial,
		EsServicios,
		EsPrincipal
	)
	values(
		1019,
		'App de Catálogos',
		1003,
		8,
		'ConsultoraOnline/Index',
		0,
		'Header',
		'',
		0,
		0,
		0,
		1
	)
end
GO
/*end*/

USE BelcorpSalvador
GO
if exists(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
)
begin
	update Permiso
	set	Descripcion = 'App de Catálogos'
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
end
else if not exists(
	select 1
	from Permiso
	where Descripcion = 'App de Catálogos' and EsPrincipal = 1
)
begin
	insert into Permiso(
		PermisoID,
		Descripcion,
		IdPadre,
		OrdenItem,
		UrlItem,
		PaginaNueva,
		Posicion,
		UrlImagen,
		EsSoloImagen,
		EsMenuEspecial,
		EsServicios,
		EsPrincipal
	)
	values(
		1019,
		'App de Catálogos',
		1003,
		8,
		'ConsultoraOnline/Index',
		0,
		'Header',
		'',
		0,
		0,
		0,
		1
	)
end
GO
/*end*/

USE BelcorpVenezuela
GO
if exists(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
)
begin
	update Permiso
	set	Descripcion = 'App de Catálogos'
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
end
else if not exists(
	select 1
	from Permiso
	where Descripcion = 'App de Catálogos' and EsPrincipal = 1
)
begin
	insert into Permiso(
		PermisoID,
		Descripcion,
		IdPadre,
		OrdenItem,
		UrlItem,
		PaginaNueva,
		Posicion,
		UrlImagen,
		EsSoloImagen,
		EsMenuEspecial,
		EsServicios,
		EsPrincipal
	)
	values(
		1019,
		'App de Catálogos',
		1003,
		8,
		'ConsultoraOnline/Index',
		0,
		'Header',
		'',
		0,
		0,
		0,
		1
	)
end
GO
/*end*/

USE BelcorpColombia
GO
if exists(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
)
begin
	update Permiso
	set	Descripcion = 'App de Catálogos'
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
end
else if not exists(
	select 1
	from Permiso
	where Descripcion = 'App de Catálogos' and EsPrincipal = 1
)
begin
	insert into Permiso(
		PermisoID,
		Descripcion,
		IdPadre,
		OrdenItem,
		UrlItem,
		PaginaNueva,
		Posicion,
		UrlImagen,
		EsSoloImagen,
		EsMenuEspecial,
		EsServicios,
		EsPrincipal
	)
	values(
		1019,
		'App de Catálogos',
		1003,
		8,
		'ConsultoraOnline/Index',
		0,
		'Header',
		'',
		0,
		0,
		0,
		1
	)
end
GO
/*end*/

USE BelcorpMexico
GO
if exists(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
)
begin
	update Permiso
	set	Descripcion = 'App de Catálogos'
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
end
else if not exists(
	select 1
	from Permiso
	where Descripcion = 'App de Catálogos' and EsPrincipal = 1
)
begin
	insert into Permiso(
		PermisoID,
		Descripcion,
		IdPadre,
		OrdenItem,
		UrlItem,
		PaginaNueva,
		Posicion,
		UrlImagen,
		EsSoloImagen,
		EsMenuEspecial,
		EsServicios,
		EsPrincipal
	)
	values(
		1019,
		'App de Catálogos',
		1003,
		8,
		'ConsultoraOnline/Index',
		0,
		'Header',
		'',
		0,
		0,
		0,
		1
	)
end
GO
/*end*/

USE BelcorpPeru
GO
if exists(
	select 1
	from Permiso
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
)
begin
	update Permiso
	set	Descripcion = 'App de Catálogos'
	where Descripcion = 'Consultora Online' and EsPrincipal = 1
end
else if not exists(
	select 1
	from Permiso
	where Descripcion = 'App de Catálogos' and EsPrincipal = 1
)
begin
	insert into Permiso(
		PermisoID,
		Descripcion,
		IdPadre,
		OrdenItem,
		UrlItem,
		PaginaNueva,
		Posicion,
		UrlImagen,
		EsSoloImagen,
		EsMenuEspecial,
		EsServicios,
		EsPrincipal
	)
	values(
		1019,
		'App de Catálogos',
		1003,
		8,
		'ConsultoraOnline/Index',
		0,
		'Header',
		'',
		0,
		0,
		0,
		1
	)
end
GO