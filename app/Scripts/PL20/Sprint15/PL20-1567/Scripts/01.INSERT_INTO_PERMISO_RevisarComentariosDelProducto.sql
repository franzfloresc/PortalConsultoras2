USE BelcorpBolivia
GO

BEGIN
    DECLARE @PermisoID int;
	DECLARE @Descripcion varchar(75);

    SELECT top 1 @Descripcion = Descripcion  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @Descripcion = ''  OR @Descripcion IS NULL 
	BEGIN
		SELECT top 1 @PermisoID = (PermisoID + 1) FROM Permiso order by PermisoID desc;

		insert into Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, Posicion, UrlImagen, PaginaNueva, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
		values (@PermisoID , 'Revisar Comentarios del Producto', 111, 29, 'ProductoComentario/Index', 'Header', '', 0, 0, 0, 0, 0);

		insert into RolPermiso (RolID, PermisoID, Activo, Mostrar) values (4, @PermisoID, 1, 1);
	END
END
GO

USE BelcorpChile
GO

BEGIN
    DECLARE @PermisoID int;
	DECLARE @Descripcion varchar(75);

    SELECT top 1 @Descripcion = Descripcion  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @Descripcion = ''  OR @Descripcion IS NULL 
	BEGIN
		SELECT top 1 @PermisoID = (PermisoID + 1) FROM Permiso order by PermisoID desc;

		insert into Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, Posicion, UrlImagen, PaginaNueva, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
		values (@PermisoID , 'Revisar Comentarios del Producto', 111, 29, 'ProductoComentario/Index', 'Header', '', 0, 0, 0, 0, 0);

		insert into RolPermiso (RolID, PermisoID, Activo, Mostrar) values (4, @PermisoID, 1, 1);
	END
END
GO

USE BelcorpColombia
GO

BEGIN
    DECLARE @PermisoID int;
	DECLARE @Descripcion varchar(75);

    SELECT top 1 @Descripcion = Descripcion  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @Descripcion = ''  OR @Descripcion IS NULL 
	BEGIN
		SELECT top 1 @PermisoID = (PermisoID + 1) FROM Permiso order by PermisoID desc;

		insert into Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, Posicion, UrlImagen, PaginaNueva, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
		values (@PermisoID , 'Revisar Comentarios del Producto', 111, 29, 'ProductoComentario/Index', 'Header', '', 0, 0, 0, 0, 0);

		insert into RolPermiso (RolID, PermisoID, Activo, Mostrar) values (4, @PermisoID, 1, 1);
	END
END
GO

USE BelcorpCostaRica
GO

BEGIN
    DECLARE @PermisoID int;
	DECLARE @Descripcion varchar(75);

    SELECT top 1 @Descripcion = Descripcion  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @Descripcion = ''  OR @Descripcion IS NULL 
	BEGIN
		SELECT top 1 @PermisoID = (PermisoID + 1) FROM Permiso order by PermisoID desc;

		insert into Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, Posicion, UrlImagen, PaginaNueva, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
		values (@PermisoID , 'Revisar Comentarios del Producto', 111, 29, 'ProductoComentario/Index', 'Header', '', 0, 0, 0, 0, 0);

		insert into RolPermiso (RolID, PermisoID, Activo, Mostrar) values (4, @PermisoID, 1, 1);
	END
END
GO

USE BelcorpDominicana
GO

BEGIN
    DECLARE @PermisoID int;
	DECLARE @Descripcion varchar(75);

    SELECT top 1 @Descripcion = Descripcion  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @Descripcion = ''  OR @Descripcion IS NULL 
	BEGIN
		SELECT top 1 @PermisoID = (PermisoID + 1) FROM Permiso order by PermisoID desc;

		insert into Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, Posicion, UrlImagen, PaginaNueva, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
		values (@PermisoID , 'Revisar Comentarios del Producto', 111, 29, 'ProductoComentario/Index', 'Header', '', 0, 0, 0, 0, 0);

		insert into RolPermiso (RolID, PermisoID, Activo, Mostrar) values (4, @PermisoID, 1, 1);
	END
END
GO

USE BelcorpEcuador
GO

BEGIN
    DECLARE @PermisoID int;
	DECLARE @Descripcion varchar(75);

    SELECT top 1 @Descripcion = Descripcion  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @Descripcion = ''  OR @Descripcion IS NULL 
	BEGIN
		SELECT top 1 @PermisoID = (PermisoID + 1) FROM Permiso order by PermisoID desc;

		insert into Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, Posicion, UrlImagen, PaginaNueva, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
		values (@PermisoID , 'Revisar Comentarios del Producto', 111, 29, 'ProductoComentario/Index', 'Header', '', 0, 0, 0, 0, 0);

		insert into RolPermiso (RolID, PermisoID, Activo, Mostrar) values (4, @PermisoID, 1, 1);
	END
END
GO

USE BelcorpGuatemala
GO

BEGIN
    DECLARE @PermisoID int;
	DECLARE @Descripcion varchar(75);

    SELECT top 1 @Descripcion = Descripcion  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @Descripcion = ''  OR @Descripcion IS NULL 
	BEGIN
		SELECT top 1 @PermisoID = (PermisoID + 1) FROM Permiso order by PermisoID desc;

		insert into Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, Posicion, UrlImagen, PaginaNueva, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
		values (@PermisoID , 'Revisar Comentarios del Producto', 111, 29, 'ProductoComentario/Index', 'Header', '', 0, 0, 0, 0, 0);

		insert into RolPermiso (RolID, PermisoID, Activo, Mostrar) values (4, @PermisoID, 1, 1);
	END
END
GO

USE BelcorpMexico
GO

BEGIN
    DECLARE @PermisoID int;
	DECLARE @Descripcion varchar(75);

    SELECT top 1 @Descripcion = Descripcion  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @Descripcion = ''  OR @Descripcion IS NULL 
	BEGIN
		SELECT top 1 @PermisoID = (PermisoID + 1) FROM Permiso order by PermisoID desc;

		insert into Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, Posicion, UrlImagen, PaginaNueva, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
		values (@PermisoID , 'Revisar Comentarios del Producto', 111, 29, 'ProductoComentario/Index', 'Header', '', 0, 0, 0, 0, 0);

		insert into RolPermiso (RolID, PermisoID, Activo, Mostrar) values (4, @PermisoID, 1, 1);
	END
END
GO

USE BelcorpPanama
GO

BEGIN
    DECLARE @PermisoID int;
	DECLARE @Descripcion varchar(75);

    SELECT top 1 @Descripcion = Descripcion  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @Descripcion = ''  OR @Descripcion IS NULL 
	BEGIN
		SELECT top 1 @PermisoID = (PermisoID + 1) FROM Permiso order by PermisoID desc;

		insert into Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, Posicion, UrlImagen, PaginaNueva, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
		values (@PermisoID , 'Revisar Comentarios del Producto', 111, 29, 'ProductoComentario/Index', 'Header', '', 0, 0, 0, 0, 0);

		insert into RolPermiso (RolID, PermisoID, Activo, Mostrar) values (4, @PermisoID, 1, 1);
	END
END
GO

USE BelcorpPeru
GO

BEGIN
    DECLARE @PermisoID int;
	DECLARE @Descripcion varchar(75);

    SELECT top 1 @Descripcion = Descripcion  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @Descripcion = ''  OR @Descripcion IS NULL 
	BEGIN
		SELECT top 1 @PermisoID = (PermisoID + 1) FROM Permiso order by PermisoID desc;

		insert into Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, Posicion, UrlImagen, PaginaNueva, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
		values (@PermisoID , 'Revisar Comentarios del Producto', 111, 29, 'ProductoComentario/Index', 'Header', '', 0, 0, 0, 0, 0);

		insert into RolPermiso (RolID, PermisoID, Activo, Mostrar) values (4, @PermisoID, 1, 1);
	END
END
GO

USE BelcorpPuertoRico
GO

BEGIN
    DECLARE @PermisoID int;
	DECLARE @Descripcion varchar(75);

    SELECT top 1 @Descripcion = Descripcion  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @Descripcion = ''  OR @Descripcion IS NULL 
	BEGIN
		SELECT top 1 @PermisoID = (PermisoID + 1) FROM Permiso order by PermisoID desc;

		insert into Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, Posicion, UrlImagen, PaginaNueva, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
		values (@PermisoID , 'Revisar Comentarios del Producto', 111, 29, 'ProductoComentario/Index', 'Header', '', 0, 0, 0, 0, 0);

		insert into RolPermiso (RolID, PermisoID, Activo, Mostrar) values (4, @PermisoID, 1, 1);
	END
END
GO

USE BelcorpSalvador
GO

BEGIN
    DECLARE @PermisoID int;
	DECLARE @Descripcion varchar(75);

    SELECT top 1 @Descripcion = Descripcion  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @Descripcion = ''  OR @Descripcion IS NULL 
	BEGIN
		SELECT top 1 @PermisoID = (PermisoID + 1) FROM Permiso order by PermisoID desc;

		insert into Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, Posicion, UrlImagen, PaginaNueva, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
		values (@PermisoID , 'Revisar Comentarios del Producto', 111, 29, 'ProductoComentario/Index', 'Header', '', 0, 0, 0, 0, 0);

		insert into RolPermiso (RolID, PermisoID, Activo, Mostrar) values (4, @PermisoID, 1, 1);
	END
END
GO

USE BelcorpVenezuela
GO

BEGIN
    DECLARE @PermisoID int;
	DECLARE @Descripcion varchar(75);

    SELECT top 1 @Descripcion = Descripcion  FROM Permiso where Descripcion like 'Revisar Comentarios del Producto';

	IF @Descripcion = ''  OR @Descripcion IS NULL 
	BEGIN
		SELECT top 1 @PermisoID = (PermisoID + 1) FROM Permiso order by PermisoID desc;

		insert into Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, Posicion, UrlImagen, PaginaNueva, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal)
		values (@PermisoID , 'Revisar Comentarios del Producto', 111, 29, 'ProductoComentario/Index', 'Header', '', 0, 0, 0, 0, 0);

		insert into RolPermiso (RolID, PermisoID, Activo, Mostrar) values (4, @PermisoID, 1, 1);
	END
END
GO






