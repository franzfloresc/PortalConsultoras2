USE BelcorpBolivia
go

IF NOT EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @ORDEN_ADMCUPON SMALLINT, @PERMISOID SMALLINT, @ROLID SMALLINT;

	SET @ORDEN_ADMCUPON	= ((SELECT MAX(OrdenItem) FROM Permiso WHERE IdPadre = 111) + 1);
	SET @PERMISOID		= ((SELECT MAX(PermisoID) FROM Permiso) + 1);
	SET @ROLID			= 4;

	INSERT INTO Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo) 
	VALUES(@PERMISOID, 'Administrar Cupón', 111, @ORDEN_ADMCUPON, 'AdministrarCupon/Index', 0, 'Header', '', 0, 0, 0, 0, NULL);

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar) VALUES(@ROLID, @PERMISOID, 1, 1);
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

CREATE PROCEDURE [dbo].[CrearCupon]
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@CampaniaId		INT
AS
BEGIN
	INSERT INTO Cupon (Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
	VALUES (@Tipo, @Descripcion, @CampaniaId, 1, GETDATE(), NULL, NULL, NULL);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCupon]
@CuponId		INT,
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@Estado			BIT
AS
BEGIN
	UPDATE	Cupon
	SET		Tipo = @Tipo,
			Descripcion = @Descripcion,
			Estado	= @Estado
	WHERE	CuponId = @CuponId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

CREATE PROCEDURE [dbo].[ListarCupones]
AS
BEGIN
	SELECT	Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion
	FROM	Cupon
END
GO
/*end*/

USE BelcorpChile
go

IF NOT EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @ORDEN_ADMCUPON SMALLINT, @PERMISOID SMALLINT, @ROLID SMALLINT;

	SET @ORDEN_ADMCUPON	= ((SELECT MAX(OrdenItem) FROM Permiso WHERE IdPadre = 111) + 1);
	SET @PERMISOID		= ((SELECT MAX(PermisoID) FROM Permiso) + 1);
	SET @ROLID			= 4;

	INSERT INTO Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo) 
	VALUES(@PERMISOID, 'Administrar Cupón', 111, @ORDEN_ADMCUPON, 'AdministrarCupon/Index', 0, 'Header', '', 0, 0, 0, 0, NULL);

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar) VALUES(@ROLID, @PERMISOID, 1, 1);
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

CREATE PROCEDURE [dbo].[CrearCupon]
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@CampaniaId		INT
AS
BEGIN
	INSERT INTO Cupon (Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
	VALUES (@Tipo, @Descripcion, @CampaniaId, 1, GETDATE(), NULL, NULL, NULL);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCupon]
@CuponId		INT,
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@Estado			BIT
AS
BEGIN
	UPDATE	Cupon
	SET		Tipo = @Tipo,
			Descripcion = @Descripcion,
			Estado	= @Estado
	WHERE	CuponId = @CuponId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

CREATE PROCEDURE [dbo].[ListarCupones]
AS
BEGIN
	SELECT	Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion
	FROM	Cupon
END
GO
/*end*/

USE BelcorpColombia
go

IF NOT EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @ORDEN_ADMCUPON SMALLINT, @PERMISOID SMALLINT, @ROLID SMALLINT;

	SET @ORDEN_ADMCUPON	= ((SELECT MAX(OrdenItem) FROM Permiso WHERE IdPadre = 111) + 1);
	SET @PERMISOID		= ((SELECT MAX(PermisoID) FROM Permiso) + 1);
	SET @ROLID			= 4;

	INSERT INTO Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo) 
	VALUES(@PERMISOID, 'Administrar Cupón', 111, @ORDEN_ADMCUPON, 'AdministrarCupon/Index', 0, 'Header', '', 0, 0, 0, 0, NULL);

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar) VALUES(@ROLID, @PERMISOID, 1, 1);
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

CREATE PROCEDURE [dbo].[CrearCupon]
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@CampaniaId		INT
AS
BEGIN
	INSERT INTO Cupon (Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
	VALUES (@Tipo, @Descripcion, @CampaniaId, 1, GETDATE(), NULL, NULL, NULL);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCupon]
@CuponId		INT,
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@Estado			BIT
AS
BEGIN
	UPDATE	Cupon
	SET		Tipo = @Tipo,
			Descripcion = @Descripcion,
			Estado	= @Estado
	WHERE	CuponId = @CuponId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

CREATE PROCEDURE [dbo].[ListarCupones]
AS
BEGIN
	SELECT	Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion
	FROM	Cupon
END
GO
/*end*/

USE BelcorpCostaRica
go

IF NOT EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @ORDEN_ADMCUPON SMALLINT, @PERMISOID SMALLINT, @ROLID SMALLINT;

	SET @ORDEN_ADMCUPON	= ((SELECT MAX(OrdenItem) FROM Permiso WHERE IdPadre = 111) + 1);
	SET @PERMISOID		= ((SELECT MAX(PermisoID) FROM Permiso) + 1);
	SET @ROLID			= 4;

	INSERT INTO Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo) 
	VALUES(@PERMISOID, 'Administrar Cupón', 111, @ORDEN_ADMCUPON, 'AdministrarCupon/Index', 0, 'Header', '', 0, 0, 0, 0, NULL);

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar) VALUES(@ROLID, @PERMISOID, 1, 1);
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

CREATE PROCEDURE [dbo].[CrearCupon]
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@CampaniaId		INT
AS
BEGIN
	INSERT INTO Cupon (Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
	VALUES (@Tipo, @Descripcion, @CampaniaId, 1, GETDATE(), NULL, NULL, NULL);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCupon]
@CuponId		INT,
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@Estado			BIT
AS
BEGIN
	UPDATE	Cupon
	SET		Tipo = @Tipo,
			Descripcion = @Descripcion,
			Estado	= @Estado
	WHERE	CuponId = @CuponId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

CREATE PROCEDURE [dbo].[ListarCupones]
AS
BEGIN
	SELECT	Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion
	FROM	Cupon
END
GO
/*end*/

USE BelcorpDominicana
go

IF NOT EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @ORDEN_ADMCUPON SMALLINT, @PERMISOID SMALLINT, @ROLID SMALLINT;

	SET @ORDEN_ADMCUPON	= ((SELECT MAX(OrdenItem) FROM Permiso WHERE IdPadre = 111) + 1);
	SET @PERMISOID		= ((SELECT MAX(PermisoID) FROM Permiso) + 1);
	SET @ROLID			= 4;

	INSERT INTO Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo) 
	VALUES(@PERMISOID, 'Administrar Cupón', 111, @ORDEN_ADMCUPON, 'AdministrarCupon/Index', 0, 'Header', '', 0, 0, 0, 0, NULL);

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar) VALUES(@ROLID, @PERMISOID, 1, 1);
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

CREATE PROCEDURE [dbo].[CrearCupon]
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@CampaniaId		INT
AS
BEGIN
	INSERT INTO Cupon (Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
	VALUES (@Tipo, @Descripcion, @CampaniaId, 1, GETDATE(), NULL, NULL, NULL);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCupon]
@CuponId		INT,
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@Estado			BIT
AS
BEGIN
	UPDATE	Cupon
	SET		Tipo = @Tipo,
			Descripcion = @Descripcion,
			Estado	= @Estado
	WHERE	CuponId = @CuponId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

CREATE PROCEDURE [dbo].[ListarCupones]
AS
BEGIN
	SELECT	Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion
	FROM	Cupon
END
GO
/*end*/

USE BelcorpEcuador
go

IF NOT EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @ORDEN_ADMCUPON SMALLINT, @PERMISOID SMALLINT, @ROLID SMALLINT;

	SET @ORDEN_ADMCUPON	= ((SELECT MAX(OrdenItem) FROM Permiso WHERE IdPadre = 111) + 1);
	SET @PERMISOID		= ((SELECT MAX(PermisoID) FROM Permiso) + 1);
	SET @ROLID			= 4;

	INSERT INTO Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo) 
	VALUES(@PERMISOID, 'Administrar Cupón', 111, @ORDEN_ADMCUPON, 'AdministrarCupon/Index', 0, 'Header', '', 0, 0, 0, 0, NULL);

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar) VALUES(@ROLID, @PERMISOID, 1, 1);
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

CREATE PROCEDURE [dbo].[CrearCupon]
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@CampaniaId		INT
AS
BEGIN
	INSERT INTO Cupon (Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
	VALUES (@Tipo, @Descripcion, @CampaniaId, 1, GETDATE(), NULL, NULL, NULL);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCupon]
@CuponId		INT,
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@Estado			BIT
AS
BEGIN
	UPDATE	Cupon
	SET		Tipo = @Tipo,
			Descripcion = @Descripcion,
			Estado	= @Estado
	WHERE	CuponId = @CuponId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

CREATE PROCEDURE [dbo].[ListarCupones]
AS
BEGIN
	SELECT	Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion
	FROM	Cupon
END
GO
/*end*/

USE BelcorpGuatemala
go

IF NOT EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @ORDEN_ADMCUPON SMALLINT, @PERMISOID SMALLINT, @ROLID SMALLINT;

	SET @ORDEN_ADMCUPON	= ((SELECT MAX(OrdenItem) FROM Permiso WHERE IdPadre = 111) + 1);
	SET @PERMISOID		= ((SELECT MAX(PermisoID) FROM Permiso) + 1);
	SET @ROLID			= 4;

	INSERT INTO Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo) 
	VALUES(@PERMISOID, 'Administrar Cupón', 111, @ORDEN_ADMCUPON, 'AdministrarCupon/Index', 0, 'Header', '', 0, 0, 0, 0, NULL);

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar) VALUES(@ROLID, @PERMISOID, 1, 1);
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

CREATE PROCEDURE [dbo].[CrearCupon]
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@CampaniaId		INT
AS
BEGIN
	INSERT INTO Cupon (Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
	VALUES (@Tipo, @Descripcion, @CampaniaId, 1, GETDATE(), NULL, NULL, NULL);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCupon]
@CuponId		INT,
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@Estado			BIT
AS
BEGIN
	UPDATE	Cupon
	SET		Tipo = @Tipo,
			Descripcion = @Descripcion,
			Estado	= @Estado
	WHERE	CuponId = @CuponId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

CREATE PROCEDURE [dbo].[ListarCupones]
AS
BEGIN
	SELECT	Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion
	FROM	Cupon
END
GO
/*end*/

USE BelcorpMexico
go

IF NOT EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @ORDEN_ADMCUPON SMALLINT, @PERMISOID SMALLINT, @ROLID SMALLINT;

	SET @ORDEN_ADMCUPON	= ((SELECT MAX(OrdenItem) FROM Permiso WHERE IdPadre = 111) + 1);
	SET @PERMISOID		= ((SELECT MAX(PermisoID) FROM Permiso) + 1);
	SET @ROLID			= 4;

	INSERT INTO Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo) 
	VALUES(@PERMISOID, 'Administrar Cupón', 111, @ORDEN_ADMCUPON, 'AdministrarCupon/Index', 0, 'Header', '', 0, 0, 0, 0, NULL);

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar) VALUES(@ROLID, @PERMISOID, 1, 1);
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

CREATE PROCEDURE [dbo].[CrearCupon]
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@CampaniaId		INT
AS
BEGIN
	INSERT INTO Cupon (Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
	VALUES (@Tipo, @Descripcion, @CampaniaId, 1, GETDATE(), NULL, NULL, NULL);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCupon]
@CuponId		INT,
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@Estado			BIT
AS
BEGIN
	UPDATE	Cupon
	SET		Tipo = @Tipo,
			Descripcion = @Descripcion,
			Estado	= @Estado
	WHERE	CuponId = @CuponId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

CREATE PROCEDURE [dbo].[ListarCupones]
AS
BEGIN
	SELECT	Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion
	FROM	Cupon
END
GO
/*end*/

USE BelcorpPanama
go

IF NOT EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @ORDEN_ADMCUPON SMALLINT, @PERMISOID SMALLINT, @ROLID SMALLINT;

	SET @ORDEN_ADMCUPON	= ((SELECT MAX(OrdenItem) FROM Permiso WHERE IdPadre = 111) + 1);
	SET @PERMISOID		= ((SELECT MAX(PermisoID) FROM Permiso) + 1);
	SET @ROLID			= 4;

	INSERT INTO Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo) 
	VALUES(@PERMISOID, 'Administrar Cupón', 111, @ORDEN_ADMCUPON, 'AdministrarCupon/Index', 0, 'Header', '', 0, 0, 0, 0, NULL);

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar) VALUES(@ROLID, @PERMISOID, 1, 1);
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

CREATE PROCEDURE [dbo].[CrearCupon]
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@CampaniaId		INT
AS
BEGIN
	INSERT INTO Cupon (Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
	VALUES (@Tipo, @Descripcion, @CampaniaId, 1, GETDATE(), NULL, NULL, NULL);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCupon]
@CuponId		INT,
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@Estado			BIT
AS
BEGIN
	UPDATE	Cupon
	SET		Tipo = @Tipo,
			Descripcion = @Descripcion,
			Estado	= @Estado
	WHERE	CuponId = @CuponId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

CREATE PROCEDURE [dbo].[ListarCupones]
AS
BEGIN
	SELECT	Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion
	FROM	Cupon
END
GO
/*end*/

USE BelcorpPeru
go

IF NOT EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @ORDEN_ADMCUPON SMALLINT, @PERMISOID SMALLINT, @ROLID SMALLINT;

	SET @ORDEN_ADMCUPON	= ((SELECT MAX(OrdenItem) FROM Permiso WHERE IdPadre = 111) + 1);
	SET @PERMISOID		= ((SELECT MAX(PermisoID) FROM Permiso) + 1);
	SET @ROLID			= 4;

	INSERT INTO Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo) 
	VALUES(@PERMISOID, 'Administrar Cupón', 111, @ORDEN_ADMCUPON, 'AdministrarCupon/Index', 0, 'Header', '', 0, 0, 0, 0, NULL);

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar) VALUES(@ROLID, @PERMISOID, 1, 1);
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

CREATE PROCEDURE [dbo].[CrearCupon]
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@CampaniaId		INT
AS
BEGIN
	INSERT INTO Cupon (Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
	VALUES (@Tipo, @Descripcion, @CampaniaId, 1, GETDATE(), NULL, NULL, NULL);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCupon]
@CuponId		INT,
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@Estado			BIT
AS
BEGIN
	UPDATE	Cupon
	SET		Tipo = @Tipo,
			Descripcion = @Descripcion,
			Estado	= @Estado
	WHERE	CuponId = @CuponId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

CREATE PROCEDURE [dbo].[ListarCupones]
AS
BEGIN
	SELECT	Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion
	FROM	Cupon
END
GO
/*end*/

USE BelcorpPuertoRico
go

IF NOT EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @ORDEN_ADMCUPON SMALLINT, @PERMISOID SMALLINT, @ROLID SMALLINT;

	SET @ORDEN_ADMCUPON	= ((SELECT MAX(OrdenItem) FROM Permiso WHERE IdPadre = 111) + 1);
	SET @PERMISOID		= ((SELECT MAX(PermisoID) FROM Permiso) + 1);
	SET @ROLID			= 4;

	INSERT INTO Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo) 
	VALUES(@PERMISOID, 'Administrar Cupón', 111, @ORDEN_ADMCUPON, 'AdministrarCupon/Index', 0, 'Header', '', 0, 0, 0, 0, NULL);

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar) VALUES(@ROLID, @PERMISOID, 1, 1);
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

CREATE PROCEDURE [dbo].[CrearCupon]
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@CampaniaId		INT
AS
BEGIN
	INSERT INTO Cupon (Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
	VALUES (@Tipo, @Descripcion, @CampaniaId, 1, GETDATE(), NULL, NULL, NULL);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCupon]
@CuponId		INT,
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@Estado			BIT
AS
BEGIN
	UPDATE	Cupon
	SET		Tipo = @Tipo,
			Descripcion = @Descripcion,
			Estado	= @Estado
	WHERE	CuponId = @CuponId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

CREATE PROCEDURE [dbo].[ListarCupones]
AS
BEGIN
	SELECT	Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion
	FROM	Cupon
END
GO
/*end*/

USE BelcorpSalvador
go

IF NOT EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @ORDEN_ADMCUPON SMALLINT, @PERMISOID SMALLINT, @ROLID SMALLINT;

	SET @ORDEN_ADMCUPON	= ((SELECT MAX(OrdenItem) FROM Permiso WHERE IdPadre = 111) + 1);
	SET @PERMISOID		= ((SELECT MAX(PermisoID) FROM Permiso) + 1);
	SET @ROLID			= 4;

	INSERT INTO Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo) 
	VALUES(@PERMISOID, 'Administrar Cupón', 111, @ORDEN_ADMCUPON, 'AdministrarCupon/Index', 0, 'Header', '', 0, 0, 0, 0, NULL);

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar) VALUES(@ROLID, @PERMISOID, 1, 1);
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

CREATE PROCEDURE [dbo].[CrearCupon]
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@CampaniaId		INT
AS
BEGIN
	INSERT INTO Cupon (Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
	VALUES (@Tipo, @Descripcion, @CampaniaId, 1, GETDATE(), NULL, NULL, NULL);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCupon]
@CuponId		INT,
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@Estado			BIT
AS
BEGIN
	UPDATE	Cupon
	SET		Tipo = @Tipo,
			Descripcion = @Descripcion,
			Estado	= @Estado
	WHERE	CuponId = @CuponId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

CREATE PROCEDURE [dbo].[ListarCupones]
AS
BEGIN
	SELECT	Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion
	FROM	Cupon
END
GO
/*end*/

USE BelcorpVenezuela
go

IF NOT EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @ORDEN_ADMCUPON SMALLINT, @PERMISOID SMALLINT, @ROLID SMALLINT;

	SET @ORDEN_ADMCUPON	= ((SELECT MAX(OrdenItem) FROM Permiso WHERE IdPadre = 111) + 1);
	SET @PERMISOID		= ((SELECT MAX(PermisoID) FROM Permiso) + 1);
	SET @ROLID			= 4;

	INSERT INTO Permiso (PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios, EsPrincipal, Codigo) 
	VALUES(@PERMISOID, 'Administrar Cupón', 111, @ORDEN_ADMCUPON, 'AdministrarCupon/Index', 0, 'Header', '', 0, 0, 0, 0, NULL);

	INSERT INTO RolPermiso (RolID, PermisoID, Activo, Mostrar) VALUES(@ROLID, @PERMISOID, 1, 1);
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

CREATE PROCEDURE [dbo].[CrearCupon]
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@CampaniaId		INT
AS
BEGIN
	INSERT INTO Cupon (Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
	VALUES (@Tipo, @Descripcion, @CampaniaId, 1, GETDATE(), NULL, NULL, NULL);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCupon]
@CuponId		INT,
@Tipo			VARCHAR(20),
@Descripcion	VARCHAR(100),
@Estado			BIT
AS
BEGIN
	UPDATE	Cupon
	SET		Tipo = @Tipo,
			Descripcion = @Descripcion,
			Estado	= @Estado
	WHERE	CuponId = @CuponId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

CREATE PROCEDURE [dbo].[ListarCupones]
AS
BEGIN
	SELECT	Tipo, Descripcion, CampaniaId, Estado, FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion
	FROM	Cupon
END
GO

