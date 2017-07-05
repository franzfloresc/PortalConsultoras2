USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].GetPermisosByRol_SB2
(
@RolID smallint
)
AS
BEGIN
	SELECT P.PermisoID,
		P.Descripcion,
		P.IdPadre,
		P.OrdenItem,
		P.UrlItem,
		P.PaginaNueva,
		P.UrlImagen,
		P.EsSoloImagen,
		P.EsMenuEspecial,
		P.EsServicios,
		RL.RolID,
		isnull(RL.Mostrar,1) As Mostrar,
		isnull(Posicion,'') [Posicion]
	FROM Permiso P
		INNER JOIN RolPermiso RL
	ON RL.PermisoID = P.PermisoID
	WHERE RL.Activo = 1
		AND RL.RolID = @RolID
		AND (@RolID != 1 or P.EsPrincipal = 1)
END
GO
/*end*/

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].GetPermisosByRol_SB2
(
@RolID smallint
)
AS
BEGIN
	SELECT P.PermisoID,
		P.Descripcion,
		P.IdPadre,
		P.OrdenItem,
		P.UrlItem,
		P.PaginaNueva,
		P.UrlImagen,
		P.EsSoloImagen,
		P.EsMenuEspecial,
		P.EsServicios,
		RL.RolID,
		isnull(RL.Mostrar,1) As Mostrar,
		isnull(Posicion,'') [Posicion]
	FROM Permiso P
		INNER JOIN RolPermiso RL
	ON RL.PermisoID = P.PermisoID
	WHERE RL.Activo = 1
		AND RL.RolID = @RolID
		AND (@RolID != 1 or P.EsPrincipal = 1)
END
GO
/*end*/

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].GetPermisosByRol_SB2
(
@RolID smallint
)
AS
BEGIN
	SELECT P.PermisoID,
		P.Descripcion,
		P.IdPadre,
		P.OrdenItem,
		P.UrlItem,
		P.PaginaNueva,
		P.UrlImagen,
		P.EsSoloImagen,
		P.EsMenuEspecial,
		P.EsServicios,
		RL.RolID,
		isnull(RL.Mostrar,1) As Mostrar,
		isnull(Posicion,'') [Posicion]
	FROM Permiso P
		INNER JOIN RolPermiso RL
	ON RL.PermisoID = P.PermisoID
	WHERE RL.Activo = 1
		AND RL.RolID = @RolID
		AND (@RolID != 1 or P.EsPrincipal = 1)
END
GO
/*end*/

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].GetPermisosByRol_SB2
(
@RolID smallint
)
AS
BEGIN
	SELECT P.PermisoID,
		P.Descripcion,
		P.IdPadre,
		P.OrdenItem,
		P.UrlItem,
		P.PaginaNueva,
		P.UrlImagen,
		P.EsSoloImagen,
		P.EsMenuEspecial,
		P.EsServicios,
		RL.RolID,
		isnull(RL.Mostrar,1) As Mostrar,
		isnull(Posicion,'') [Posicion]
	FROM Permiso P
		INNER JOIN RolPermiso RL
	ON RL.PermisoID = P.PermisoID
	WHERE RL.Activo = 1
		AND RL.RolID = @RolID
		AND (@RolID != 1 or P.EsPrincipal = 1)
END
GO
/*end*/

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].GetPermisosByRol_SB2
(
@RolID smallint
)
AS
BEGIN
	SELECT P.PermisoID,
		P.Descripcion,
		P.IdPadre,
		P.OrdenItem,
		P.UrlItem,
		P.PaginaNueva,
		P.UrlImagen,
		P.EsSoloImagen,
		P.EsMenuEspecial,
		P.EsServicios,
		RL.RolID,
		isnull(RL.Mostrar,1) As Mostrar,
		isnull(Posicion,'') [Posicion]
	FROM Permiso P
		INNER JOIN RolPermiso RL
	ON RL.PermisoID = P.PermisoID
	WHERE RL.Activo = 1
		AND RL.RolID = @RolID
		AND (@RolID != 1 or P.EsPrincipal = 1)
END
GO
/*end*/

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].GetPermisosByRol_SB2
(
@RolID smallint
)
AS
BEGIN
	SELECT P.PermisoID,
		P.Descripcion,
		P.IdPadre,
		P.OrdenItem,
		P.UrlItem,
		P.PaginaNueva,
		P.UrlImagen,
		P.EsSoloImagen,
		P.EsMenuEspecial,
		P.EsServicios,
		RL.RolID,
		isnull(RL.Mostrar,1) As Mostrar,
		isnull(Posicion,'') [Posicion]
	FROM Permiso P
		INNER JOIN RolPermiso RL
	ON RL.PermisoID = P.PermisoID
	WHERE RL.Activo = 1
		AND RL.RolID = @RolID
		AND (@RolID != 1 or P.EsPrincipal = 1)
END
GO
/*end*/

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].GetPermisosByRol_SB2
(
@RolID smallint
)
AS
BEGIN
	SELECT P.PermisoID,
		P.Descripcion,
		P.IdPadre,
		P.OrdenItem,
		P.UrlItem,
		P.PaginaNueva,
		P.UrlImagen,
		P.EsSoloImagen,
		P.EsMenuEspecial,
		P.EsServicios,
		RL.RolID,
		isnull(RL.Mostrar,1) As Mostrar,
		isnull(Posicion,'') [Posicion]
	FROM Permiso P
		INNER JOIN RolPermiso RL
	ON RL.PermisoID = P.PermisoID
	WHERE RL.Activo = 1
		AND RL.RolID = @RolID
		AND (@RolID != 1 or P.EsPrincipal = 1)
END
GO
/*end*/

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].GetPermisosByRol_SB2
(
@RolID smallint
)
AS
BEGIN
	SELECT P.PermisoID,
		P.Descripcion,
		P.IdPadre,
		P.OrdenItem,
		P.UrlItem,
		P.PaginaNueva,
		P.UrlImagen,
		P.EsSoloImagen,
		P.EsMenuEspecial,
		P.EsServicios,
		RL.RolID,
		isnull(RL.Mostrar,1) As Mostrar,
		isnull(Posicion,'') [Posicion]
	FROM Permiso P
		INNER JOIN RolPermiso RL
	ON RL.PermisoID = P.PermisoID
	WHERE RL.Activo = 1
		AND RL.RolID = @RolID
		AND (@RolID != 1 or P.EsPrincipal = 1)
END
GO
/*end*/

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].GetPermisosByRol_SB2
(
@RolID smallint
)
AS
BEGIN
	SELECT P.PermisoID,
		P.Descripcion,
		P.IdPadre,
		P.OrdenItem,
		P.UrlItem,
		P.PaginaNueva,
		P.UrlImagen,
		P.EsSoloImagen,
		P.EsMenuEspecial,
		P.EsServicios,
		RL.RolID,
		isnull(RL.Mostrar,1) As Mostrar,
		isnull(Posicion,'') [Posicion]
	FROM Permiso P
		INNER JOIN RolPermiso RL
	ON RL.PermisoID = P.PermisoID
	WHERE RL.Activo = 1
		AND RL.RolID = @RolID
		AND (@RolID != 1 or P.EsPrincipal = 1)
END
GO
/*end*/

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].GetPermisosByRol_SB2
(
@RolID smallint
)
AS
BEGIN
	SELECT P.PermisoID,
		P.Descripcion,
		P.IdPadre,
		P.OrdenItem,
		P.UrlItem,
		P.PaginaNueva,
		P.UrlImagen,
		P.EsSoloImagen,
		P.EsMenuEspecial,
		P.EsServicios,
		RL.RolID,
		isnull(RL.Mostrar,1) As Mostrar,
		isnull(Posicion,'') [Posicion]
	FROM Permiso P
		INNER JOIN RolPermiso RL
	ON RL.PermisoID = P.PermisoID
	WHERE RL.Activo = 1
		AND RL.RolID = @RolID
		AND (@RolID != 1 or P.EsPrincipal = 1)
END
GO
/*end*/

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].GetPermisosByRol_SB2
(
@RolID smallint
)
AS
BEGIN
	SELECT P.PermisoID,
		P.Descripcion,
		P.IdPadre,
		P.OrdenItem,
		P.UrlItem,
		P.PaginaNueva,
		P.UrlImagen,
		P.EsSoloImagen,
		P.EsMenuEspecial,
		P.EsServicios,
		RL.RolID,
		isnull(RL.Mostrar,1) As Mostrar,
		isnull(Posicion,'') [Posicion]
	FROM Permiso P
		INNER JOIN RolPermiso RL
	ON RL.PermisoID = P.PermisoID
	WHERE RL.Activo = 1
		AND RL.RolID = @RolID
		AND (@RolID != 1 or P.EsPrincipal = 1)
END
GO
/*end*/

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].GetPermisosByRol_SB2
(
@RolID smallint
)
AS
BEGIN
	SELECT P.PermisoID,
		P.Descripcion,
		P.IdPadre,
		P.OrdenItem,
		P.UrlItem,
		P.PaginaNueva,
		P.UrlImagen,
		P.EsSoloImagen,
		P.EsMenuEspecial,
		P.EsServicios,
		RL.RolID,
		isnull(RL.Mostrar,1) As Mostrar,
		isnull(Posicion,'') [Posicion]
	FROM Permiso P
		INNER JOIN RolPermiso RL
	ON RL.PermisoID = P.PermisoID
	WHERE RL.Activo = 1
		AND RL.RolID = @RolID
		AND (@RolID != 1 or P.EsPrincipal = 1)
END
GO
/*end*/

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].GetPermisosByRol_SB2
(
@RolID smallint
)
AS
BEGIN
	SELECT P.PermisoID,
		P.Descripcion,
		P.IdPadre,
		P.OrdenItem,
		P.UrlItem,
		P.PaginaNueva,
		P.UrlImagen,
		P.EsSoloImagen,
		P.EsMenuEspecial,
		P.EsServicios,
		RL.RolID,
		isnull(RL.Mostrar,1) As Mostrar,
		isnull(Posicion,'') [Posicion]
	FROM Permiso P
		INNER JOIN RolPermiso RL
	ON RL.PermisoID = P.PermisoID
	WHERE RL.Activo = 1
		AND RL.RolID = @RolID
		AND (@RolID != 1 or P.EsPrincipal = 1)
END
GO
