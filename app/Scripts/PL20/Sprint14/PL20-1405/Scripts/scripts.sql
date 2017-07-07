
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

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponesPorCampania]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponesPorCampania]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponesPorCampania]
@PaisId		INT,
@CampaniaId	INT
AS
BEGIN
	SELECT	CuponId,
			Tipo,
			Descripcion,
			CampaniaId,
			Estado,
			FechaCreacion
	FROM	Cupon
	WHERE	CampaniaId = @CampaniaId
	ORDER BY FechaCreacion ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponConsultorasPorCuponId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponConsultorasPorCuponId]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponConsultorasPorCuponId]
@PaisId		INT,
@CuponId	INT
AS
BEGIN
	SELECT	CuponConsultoraId,
			CodigoConsultora,
			CampaniaId,
			CuponId,
			ValorAsociado,
			EstadoCupon 
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId
	ORDER BY CodigoConsultora ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[CrearCuponConsultora]
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioCreacion	varchar(50)
AS
BEGIN
	INSERT INTO CuponConsultora(CodigoConsultora, CampaniaId, CuponId, ValorAsociado, EstadoCupon, EnvioCorreo, FechaCreacion, UsuarioCreacion)
	VALUES(@CodigoConsultora, @CampaniaId, @CuponId, @ValorAsociado, 1, 0, GETDATE(), @UsuarioCreacion);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCuponConsultora]
@CuponConsultoraId	INT,
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioModificacion	varchar(50)
AS
BEGIN
	UPDATE	CuponConsultora
	SET		CodigoConsultora	= @CodigoConsultora,
			CampaniaId			= @CampaniaId,
			CuponId				= @CuponId,
			ValorAsociado		= @ValorAsociado,
			FechaModificacion	=  GETDATE(),
			UsuarioModificacion = @UsuarioModificacion
	WHERE	CuponConsultoraId	= @CuponConsultoraId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[InsertarCuponConsultoraCargaMasiva]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[InsertarCuponConsultoraCargaMasiva]
END
GO

CREATE PROCEDURE [dbo].[InsertarCuponConsultoraCargaMasiva]
@CuponId				INT,
@CampaniaId				INT,
@CuponConsultorasXml	XML
AS
BEGIN

	DELETE
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId AND CampaniaID = @CampaniaId

	INSERT	INTO CuponConsultora(CodigoConsultora, ValorAsociado, CampaniaId, CuponId, EstadoCupon, EnvioCorreo, UsuarioCreacion, FechaCreacion)
	SELECT	cC.value('@CodigoConsultora','VARCHAR(50)'), 
			cC.value('@ValorAsociado','DECIMAL(18,2)'),
			@CampaniaId,
			@CuponId,
			1,
			0,
			'',
			GETDATE()
	FROM	@CuponConsultorasXml.nodes('/ROOT/CuponConsultora')n(cC);
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

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponesPorCampania]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponesPorCampania]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponesPorCampania]
@PaisId		INT,
@CampaniaId	INT
AS
BEGIN
	SELECT	CuponId,
			Tipo,
			Descripcion,
			CampaniaId,
			Estado,
			FechaCreacion
	FROM	Cupon
	WHERE	CampaniaId = @CampaniaId
	ORDER BY FechaCreacion ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponConsultorasPorCuponId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponConsultorasPorCuponId]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponConsultorasPorCuponId]
@PaisId		INT,
@CuponId	INT
AS
BEGIN
	SELECT	CuponConsultoraId,
			CodigoConsultora,
			CampaniaId,
			CuponId,
			ValorAsociado,
			EstadoCupon 
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId
	ORDER BY CodigoConsultora ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[CrearCuponConsultora]
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioCreacion	varchar(50)
AS
BEGIN
	INSERT INTO CuponConsultora(CodigoConsultora, CampaniaId, CuponId, ValorAsociado, EstadoCupon, EnvioCorreo, FechaCreacion, UsuarioCreacion)
	VALUES(@CodigoConsultora, @CampaniaId, @CuponId, @ValorAsociado, 1, 0, GETDATE(), @UsuarioCreacion);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCuponConsultora]
@CuponConsultoraId	INT,
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioModificacion	varchar(50)
AS
BEGIN
	UPDATE	CuponConsultora
	SET		CodigoConsultora	= @CodigoConsultora,
			CampaniaId			= @CampaniaId,
			CuponId				= @CuponId,
			ValorAsociado		= @ValorAsociado,
			FechaModificacion	=  GETDATE(),
			UsuarioModificacion = @UsuarioModificacion
	WHERE	CuponConsultoraId	= @CuponConsultoraId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[InsertarCuponConsultoraCargaMasiva]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[InsertarCuponConsultoraCargaMasiva]
END
GO

CREATE PROCEDURE [dbo].[InsertarCuponConsultoraCargaMasiva]
@CuponId				INT,
@CampaniaId				INT,
@CuponConsultorasXml	XML
AS
BEGIN

	DELETE
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId AND CampaniaID = @CampaniaId

	INSERT	INTO CuponConsultora(CodigoConsultora, ValorAsociado, CampaniaId, CuponId, EstadoCupon, EnvioCorreo, UsuarioCreacion, FechaCreacion)
	SELECT	cC.value('@CodigoConsultora','VARCHAR(50)'), 
			cC.value('@ValorAsociado','DECIMAL(18,2)'),
			@CampaniaId,
			@CuponId,
			1,
			0,
			'',
			GETDATE()
	FROM	@CuponConsultorasXml.nodes('/ROOT/CuponConsultora')n(cC);
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

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponesPorCampania]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponesPorCampania]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponesPorCampania]
@PaisId		INT,
@CampaniaId	INT
AS
BEGIN
	SELECT	CuponId,
			Tipo,
			Descripcion,
			CampaniaId,
			Estado,
			FechaCreacion
	FROM	Cupon
	WHERE	CampaniaId = @CampaniaId
	ORDER BY FechaCreacion ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponConsultorasPorCuponId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponConsultorasPorCuponId]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponConsultorasPorCuponId]
@PaisId		INT,
@CuponId	INT
AS
BEGIN
	SELECT	CuponConsultoraId,
			CodigoConsultora,
			CampaniaId,
			CuponId,
			ValorAsociado,
			EstadoCupon 
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId
	ORDER BY CodigoConsultora ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[CrearCuponConsultora]
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioCreacion	varchar(50)
AS
BEGIN
	INSERT INTO CuponConsultora(CodigoConsultora, CampaniaId, CuponId, ValorAsociado, EstadoCupon, EnvioCorreo, FechaCreacion, UsuarioCreacion)
	VALUES(@CodigoConsultora, @CampaniaId, @CuponId, @ValorAsociado, 1, 0, GETDATE(), @UsuarioCreacion);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCuponConsultora]
@CuponConsultoraId	INT,
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioModificacion	varchar(50)
AS
BEGIN
	UPDATE	CuponConsultora
	SET		CodigoConsultora	= @CodigoConsultora,
			CampaniaId			= @CampaniaId,
			CuponId				= @CuponId,
			ValorAsociado		= @ValorAsociado,
			FechaModificacion	=  GETDATE(),
			UsuarioModificacion = @UsuarioModificacion
	WHERE	CuponConsultoraId	= @CuponConsultoraId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[InsertarCuponConsultoraCargaMasiva]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[InsertarCuponConsultoraCargaMasiva]
END
GO

CREATE PROCEDURE [dbo].[InsertarCuponConsultoraCargaMasiva]
@CuponId				INT,
@CampaniaId				INT,
@CuponConsultorasXml	XML
AS
BEGIN

	DELETE
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId AND CampaniaID = @CampaniaId

	INSERT	INTO CuponConsultora(CodigoConsultora, ValorAsociado, CampaniaId, CuponId, EstadoCupon, EnvioCorreo, UsuarioCreacion, FechaCreacion)
	SELECT	cC.value('@CodigoConsultora','VARCHAR(50)'), 
			cC.value('@ValorAsociado','DECIMAL(18,2)'),
			@CampaniaId,
			@CuponId,
			1,
			0,
			'',
			GETDATE()
	FROM	@CuponConsultorasXml.nodes('/ROOT/CuponConsultora')n(cC);
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

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponesPorCampania]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponesPorCampania]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponesPorCampania]
@PaisId		INT,
@CampaniaId	INT
AS
BEGIN
	SELECT	CuponId,
			Tipo,
			Descripcion,
			CampaniaId,
			Estado,
			FechaCreacion
	FROM	Cupon
	WHERE	CampaniaId = @CampaniaId
	ORDER BY FechaCreacion ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponConsultorasPorCuponId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponConsultorasPorCuponId]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponConsultorasPorCuponId]
@PaisId		INT,
@CuponId	INT
AS
BEGIN
	SELECT	CuponConsultoraId,
			CodigoConsultora,
			CampaniaId,
			CuponId,
			ValorAsociado,
			EstadoCupon 
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId
	ORDER BY CodigoConsultora ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[CrearCuponConsultora]
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioCreacion	varchar(50)
AS
BEGIN
	INSERT INTO CuponConsultora(CodigoConsultora, CampaniaId, CuponId, ValorAsociado, EstadoCupon, EnvioCorreo, FechaCreacion, UsuarioCreacion)
	VALUES(@CodigoConsultora, @CampaniaId, @CuponId, @ValorAsociado, 1, 0, GETDATE(), @UsuarioCreacion);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCuponConsultora]
@CuponConsultoraId	INT,
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioModificacion	varchar(50)
AS
BEGIN
	UPDATE	CuponConsultora
	SET		CodigoConsultora	= @CodigoConsultora,
			CampaniaId			= @CampaniaId,
			CuponId				= @CuponId,
			ValorAsociado		= @ValorAsociado,
			FechaModificacion	=  GETDATE(),
			UsuarioModificacion = @UsuarioModificacion
	WHERE	CuponConsultoraId	= @CuponConsultoraId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[InsertarCuponConsultoraCargaMasiva]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[InsertarCuponConsultoraCargaMasiva]
END
GO

CREATE PROCEDURE [dbo].[InsertarCuponConsultoraCargaMasiva]
@CuponId				INT,
@CampaniaId				INT,
@CuponConsultorasXml	XML
AS
BEGIN

	DELETE
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId AND CampaniaID = @CampaniaId

	INSERT	INTO CuponConsultora(CodigoConsultora, ValorAsociado, CampaniaId, CuponId, EstadoCupon, EnvioCorreo, UsuarioCreacion, FechaCreacion)
	SELECT	cC.value('@CodigoConsultora','VARCHAR(50)'), 
			cC.value('@ValorAsociado','DECIMAL(18,2)'),
			@CampaniaId,
			@CuponId,
			1,
			0,
			'',
			GETDATE()
	FROM	@CuponConsultorasXml.nodes('/ROOT/CuponConsultora')n(cC);
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

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponesPorCampania]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponesPorCampania]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponesPorCampania]
@PaisId		INT,
@CampaniaId	INT
AS
BEGIN
	SELECT	CuponId,
			Tipo,
			Descripcion,
			CampaniaId,
			Estado,
			FechaCreacion
	FROM	Cupon
	WHERE	CampaniaId = @CampaniaId
	ORDER BY FechaCreacion ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponConsultorasPorCuponId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponConsultorasPorCuponId]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponConsultorasPorCuponId]
@PaisId		INT,
@CuponId	INT
AS
BEGIN
	SELECT	CuponConsultoraId,
			CodigoConsultora,
			CampaniaId,
			CuponId,
			ValorAsociado,
			EstadoCupon 
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId
	ORDER BY CodigoConsultora ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[CrearCuponConsultora]
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioCreacion	varchar(50)
AS
BEGIN
	INSERT INTO CuponConsultora(CodigoConsultora, CampaniaId, CuponId, ValorAsociado, EstadoCupon, EnvioCorreo, FechaCreacion, UsuarioCreacion)
	VALUES(@CodigoConsultora, @CampaniaId, @CuponId, @ValorAsociado, 1, 0, GETDATE(), @UsuarioCreacion);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCuponConsultora]
@CuponConsultoraId	INT,
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioModificacion	varchar(50)
AS
BEGIN
	UPDATE	CuponConsultora
	SET		CodigoConsultora	= @CodigoConsultora,
			CampaniaId			= @CampaniaId,
			CuponId				= @CuponId,
			ValorAsociado		= @ValorAsociado,
			FechaModificacion	=  GETDATE(),
			UsuarioModificacion = @UsuarioModificacion
	WHERE	CuponConsultoraId	= @CuponConsultoraId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[InsertarCuponConsultoraCargaMasiva]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[InsertarCuponConsultoraCargaMasiva]
END
GO

CREATE PROCEDURE [dbo].[InsertarCuponConsultoraCargaMasiva]
@CuponId				INT,
@CampaniaId				INT,
@CuponConsultorasXml	XML
AS
BEGIN

	DELETE
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId AND CampaniaID = @CampaniaId

	INSERT	INTO CuponConsultora(CodigoConsultora, ValorAsociado, CampaniaId, CuponId, EstadoCupon, EnvioCorreo, UsuarioCreacion, FechaCreacion)
	SELECT	cC.value('@CodigoConsultora','VARCHAR(50)'), 
			cC.value('@ValorAsociado','DECIMAL(18,2)'),
			@CampaniaId,
			@CuponId,
			1,
			0,
			'',
			GETDATE()
	FROM	@CuponConsultorasXml.nodes('/ROOT/CuponConsultora')n(cC);
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

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponesPorCampania]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponesPorCampania]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponesPorCampania]
@PaisId		INT,
@CampaniaId	INT
AS
BEGIN
	SELECT	CuponId,
			Tipo,
			Descripcion,
			CampaniaId,
			Estado,
			FechaCreacion
	FROM	Cupon
	WHERE	CampaniaId = @CampaniaId
	ORDER BY FechaCreacion ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponConsultorasPorCuponId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponConsultorasPorCuponId]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponConsultorasPorCuponId]
@PaisId		INT,
@CuponId	INT
AS
BEGIN
	SELECT	CuponConsultoraId,
			CodigoConsultora,
			CampaniaId,
			CuponId,
			ValorAsociado,
			EstadoCupon 
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId
	ORDER BY CodigoConsultora ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[CrearCuponConsultora]
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioCreacion	varchar(50)
AS
BEGIN
	INSERT INTO CuponConsultora(CodigoConsultora, CampaniaId, CuponId, ValorAsociado, EstadoCupon, EnvioCorreo, FechaCreacion, UsuarioCreacion)
	VALUES(@CodigoConsultora, @CampaniaId, @CuponId, @ValorAsociado, 1, 0, GETDATE(), @UsuarioCreacion);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCuponConsultora]
@CuponConsultoraId	INT,
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioModificacion	varchar(50)
AS
BEGIN
	UPDATE	CuponConsultora
	SET		CodigoConsultora	= @CodigoConsultora,
			CampaniaId			= @CampaniaId,
			CuponId				= @CuponId,
			ValorAsociado		= @ValorAsociado,
			FechaModificacion	=  GETDATE(),
			UsuarioModificacion = @UsuarioModificacion
	WHERE	CuponConsultoraId	= @CuponConsultoraId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[InsertarCuponConsultoraCargaMasiva]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[InsertarCuponConsultoraCargaMasiva]
END
GO

CREATE PROCEDURE [dbo].[InsertarCuponConsultoraCargaMasiva]
@CuponId				INT,
@CampaniaId				INT,
@CuponConsultorasXml	XML
AS
BEGIN

	DELETE
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId AND CampaniaID = @CampaniaId

	INSERT	INTO CuponConsultora(CodigoConsultora, ValorAsociado, CampaniaId, CuponId, EstadoCupon, EnvioCorreo, UsuarioCreacion, FechaCreacion)
	SELECT	cC.value('@CodigoConsultora','VARCHAR(50)'), 
			cC.value('@ValorAsociado','DECIMAL(18,2)'),
			@CampaniaId,
			@CuponId,
			1,
			0,
			'',
			GETDATE()
	FROM	@CuponConsultorasXml.nodes('/ROOT/CuponConsultora')n(cC);
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

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponesPorCampania]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponesPorCampania]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponesPorCampania]
@PaisId		INT,
@CampaniaId	INT
AS
BEGIN
	SELECT	CuponId,
			Tipo,
			Descripcion,
			CampaniaId,
			Estado,
			FechaCreacion
	FROM	Cupon
	WHERE	CampaniaId = @CampaniaId
	ORDER BY FechaCreacion ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponConsultorasPorCuponId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponConsultorasPorCuponId]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponConsultorasPorCuponId]
@PaisId		INT,
@CuponId	INT
AS
BEGIN
	SELECT	CuponConsultoraId,
			CodigoConsultora,
			CampaniaId,
			CuponId,
			ValorAsociado,
			EstadoCupon 
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId
	ORDER BY CodigoConsultora ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[CrearCuponConsultora]
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioCreacion	varchar(50)
AS
BEGIN
	INSERT INTO CuponConsultora(CodigoConsultora, CampaniaId, CuponId, ValorAsociado, EstadoCupon, EnvioCorreo, FechaCreacion, UsuarioCreacion)
	VALUES(@CodigoConsultora, @CampaniaId, @CuponId, @ValorAsociado, 1, 0, GETDATE(), @UsuarioCreacion);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCuponConsultora]
@CuponConsultoraId	INT,
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioModificacion	varchar(50)
AS
BEGIN
	UPDATE	CuponConsultora
	SET		CodigoConsultora	= @CodigoConsultora,
			CampaniaId			= @CampaniaId,
			CuponId				= @CuponId,
			ValorAsociado		= @ValorAsociado,
			FechaModificacion	=  GETDATE(),
			UsuarioModificacion = @UsuarioModificacion
	WHERE	CuponConsultoraId	= @CuponConsultoraId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[InsertarCuponConsultoraCargaMasiva]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[InsertarCuponConsultoraCargaMasiva]
END
GO

CREATE PROCEDURE [dbo].[InsertarCuponConsultoraCargaMasiva]
@CuponId				INT,
@CampaniaId				INT,
@CuponConsultorasXml	XML
AS
BEGIN

	DELETE
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId AND CampaniaID = @CampaniaId

	INSERT	INTO CuponConsultora(CodigoConsultora, ValorAsociado, CampaniaId, CuponId, EstadoCupon, EnvioCorreo, UsuarioCreacion, FechaCreacion)
	SELECT	cC.value('@CodigoConsultora','VARCHAR(50)'), 
			cC.value('@ValorAsociado','DECIMAL(18,2)'),
			@CampaniaId,
			@CuponId,
			1,
			0,
			'',
			GETDATE()
	FROM	@CuponConsultorasXml.nodes('/ROOT/CuponConsultora')n(cC);
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

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponesPorCampania]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponesPorCampania]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponesPorCampania]
@PaisId		INT,
@CampaniaId	INT
AS
BEGIN
	SELECT	CuponId,
			Tipo,
			Descripcion,
			CampaniaId,
			Estado,
			FechaCreacion
	FROM	Cupon
	WHERE	CampaniaId = @CampaniaId
	ORDER BY FechaCreacion ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponConsultorasPorCuponId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponConsultorasPorCuponId]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponConsultorasPorCuponId]
@PaisId		INT,
@CuponId	INT
AS
BEGIN
	SELECT	CuponConsultoraId,
			CodigoConsultora,
			CampaniaId,
			CuponId,
			ValorAsociado,
			EstadoCupon 
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId
	ORDER BY CodigoConsultora ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[CrearCuponConsultora]
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioCreacion	varchar(50)
AS
BEGIN
	INSERT INTO CuponConsultora(CodigoConsultora, CampaniaId, CuponId, ValorAsociado, EstadoCupon, EnvioCorreo, FechaCreacion, UsuarioCreacion)
	VALUES(@CodigoConsultora, @CampaniaId, @CuponId, @ValorAsociado, 1, 0, GETDATE(), @UsuarioCreacion);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCuponConsultora]
@CuponConsultoraId	INT,
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioModificacion	varchar(50)
AS
BEGIN
	UPDATE	CuponConsultora
	SET		CodigoConsultora	= @CodigoConsultora,
			CampaniaId			= @CampaniaId,
			CuponId				= @CuponId,
			ValorAsociado		= @ValorAsociado,
			FechaModificacion	=  GETDATE(),
			UsuarioModificacion = @UsuarioModificacion
	WHERE	CuponConsultoraId	= @CuponConsultoraId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[InsertarCuponConsultoraCargaMasiva]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[InsertarCuponConsultoraCargaMasiva]
END
GO

CREATE PROCEDURE [dbo].[InsertarCuponConsultoraCargaMasiva]
@CuponId				INT,
@CampaniaId				INT,
@CuponConsultorasXml	XML
AS
BEGIN

	DELETE
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId AND CampaniaID = @CampaniaId

	INSERT	INTO CuponConsultora(CodigoConsultora, ValorAsociado, CampaniaId, CuponId, EstadoCupon, EnvioCorreo, UsuarioCreacion, FechaCreacion)
	SELECT	cC.value('@CodigoConsultora','VARCHAR(50)'), 
			cC.value('@ValorAsociado','DECIMAL(18,2)'),
			@CampaniaId,
			@CuponId,
			1,
			0,
			'',
			GETDATE()
	FROM	@CuponConsultorasXml.nodes('/ROOT/CuponConsultora')n(cC);
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

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponesPorCampania]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponesPorCampania]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponesPorCampania]
@PaisId		INT,
@CampaniaId	INT
AS
BEGIN
	SELECT	CuponId,
			Tipo,
			Descripcion,
			CampaniaId,
			Estado,
			FechaCreacion
	FROM	Cupon
	WHERE	CampaniaId = @CampaniaId
	ORDER BY FechaCreacion ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponConsultorasPorCuponId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponConsultorasPorCuponId]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponConsultorasPorCuponId]
@PaisId		INT,
@CuponId	INT
AS
BEGIN
	SELECT	CuponConsultoraId,
			CodigoConsultora,
			CampaniaId,
			CuponId,
			ValorAsociado,
			EstadoCupon 
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId
	ORDER BY CodigoConsultora ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[CrearCuponConsultora]
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioCreacion	varchar(50)
AS
BEGIN
	INSERT INTO CuponConsultora(CodigoConsultora, CampaniaId, CuponId, ValorAsociado, EstadoCupon, EnvioCorreo, FechaCreacion, UsuarioCreacion)
	VALUES(@CodigoConsultora, @CampaniaId, @CuponId, @ValorAsociado, 1, 0, GETDATE(), @UsuarioCreacion);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCuponConsultora]
@CuponConsultoraId	INT,
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioModificacion	varchar(50)
AS
BEGIN
	UPDATE	CuponConsultora
	SET		CodigoConsultora	= @CodigoConsultora,
			CampaniaId			= @CampaniaId,
			CuponId				= @CuponId,
			ValorAsociado		= @ValorAsociado,
			FechaModificacion	=  GETDATE(),
			UsuarioModificacion = @UsuarioModificacion
	WHERE	CuponConsultoraId	= @CuponConsultoraId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[InsertarCuponConsultoraCargaMasiva]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[InsertarCuponConsultoraCargaMasiva]
END
GO

CREATE PROCEDURE [dbo].[InsertarCuponConsultoraCargaMasiva]
@CuponId				INT,
@CampaniaId				INT,
@CuponConsultorasXml	XML
AS
BEGIN

	DELETE
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId AND CampaniaID = @CampaniaId

	INSERT	INTO CuponConsultora(CodigoConsultora, ValorAsociado, CampaniaId, CuponId, EstadoCupon, EnvioCorreo, UsuarioCreacion, FechaCreacion)
	SELECT	cC.value('@CodigoConsultora','VARCHAR(50)'), 
			cC.value('@ValorAsociado','DECIMAL(18,2)'),
			@CampaniaId,
			@CuponId,
			1,
			0,
			'',
			GETDATE()
	FROM	@CuponConsultorasXml.nodes('/ROOT/CuponConsultora')n(cC);
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

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponesPorCampania]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponesPorCampania]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponesPorCampania]
@PaisId		INT,
@CampaniaId	INT
AS
BEGIN
	SELECT	CuponId,
			Tipo,
			Descripcion,
			CampaniaId,
			Estado,
			FechaCreacion
	FROM	Cupon
	WHERE	CampaniaId = @CampaniaId
	ORDER BY FechaCreacion ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponConsultorasPorCuponId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponConsultorasPorCuponId]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponConsultorasPorCuponId]
@PaisId		INT,
@CuponId	INT
AS
BEGIN
	SELECT	CuponConsultoraId,
			CodigoConsultora,
			CampaniaId,
			CuponId,
			ValorAsociado,
			EstadoCupon 
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId
	ORDER BY CodigoConsultora ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[CrearCuponConsultora]
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioCreacion	varchar(50)
AS
BEGIN
	INSERT INTO CuponConsultora(CodigoConsultora, CampaniaId, CuponId, ValorAsociado, EstadoCupon, EnvioCorreo, FechaCreacion, UsuarioCreacion)
	VALUES(@CodigoConsultora, @CampaniaId, @CuponId, @ValorAsociado, 1, 0, GETDATE(), @UsuarioCreacion);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCuponConsultora]
@CuponConsultoraId	INT,
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioModificacion	varchar(50)
AS
BEGIN
	UPDATE	CuponConsultora
	SET		CodigoConsultora	= @CodigoConsultora,
			CampaniaId			= @CampaniaId,
			CuponId				= @CuponId,
			ValorAsociado		= @ValorAsociado,
			FechaModificacion	=  GETDATE(),
			UsuarioModificacion = @UsuarioModificacion
	WHERE	CuponConsultoraId	= @CuponConsultoraId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[InsertarCuponConsultoraCargaMasiva]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[InsertarCuponConsultoraCargaMasiva]
END
GO

CREATE PROCEDURE [dbo].[InsertarCuponConsultoraCargaMasiva]
@CuponId				INT,
@CampaniaId				INT,
@CuponConsultorasXml	XML
AS
BEGIN

	DELETE
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId AND CampaniaID = @CampaniaId

	INSERT	INTO CuponConsultora(CodigoConsultora, ValorAsociado, CampaniaId, CuponId, EstadoCupon, EnvioCorreo, UsuarioCreacion, FechaCreacion)
	SELECT	cC.value('@CodigoConsultora','VARCHAR(50)'), 
			cC.value('@ValorAsociado','DECIMAL(18,2)'),
			@CampaniaId,
			@CuponId,
			1,
			0,
			'',
			GETDATE()
	FROM	@CuponConsultorasXml.nodes('/ROOT/CuponConsultora')n(cC);
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

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponesPorCampania]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponesPorCampania]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponesPorCampania]
@PaisId		INT,
@CampaniaId	INT
AS
BEGIN
	SELECT	CuponId,
			Tipo,
			Descripcion,
			CampaniaId,
			Estado,
			FechaCreacion
	FROM	Cupon
	WHERE	CampaniaId = @CampaniaId
	ORDER BY FechaCreacion ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponConsultorasPorCuponId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponConsultorasPorCuponId]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponConsultorasPorCuponId]
@PaisId		INT,
@CuponId	INT
AS
BEGIN
	SELECT	CuponConsultoraId,
			CodigoConsultora,
			CampaniaId,
			CuponId,
			ValorAsociado,
			EstadoCupon 
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId
	ORDER BY CodigoConsultora ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[CrearCuponConsultora]
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioCreacion	varchar(50)
AS
BEGIN
	INSERT INTO CuponConsultora(CodigoConsultora, CampaniaId, CuponId, ValorAsociado, EstadoCupon, EnvioCorreo, FechaCreacion, UsuarioCreacion)
	VALUES(@CodigoConsultora, @CampaniaId, @CuponId, @ValorAsociado, 1, 0, GETDATE(), @UsuarioCreacion);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCuponConsultora]
@CuponConsultoraId	INT,
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioModificacion	varchar(50)
AS
BEGIN
	UPDATE	CuponConsultora
	SET		CodigoConsultora	= @CodigoConsultora,
			CampaniaId			= @CampaniaId,
			CuponId				= @CuponId,
			ValorAsociado		= @ValorAsociado,
			FechaModificacion	=  GETDATE(),
			UsuarioModificacion = @UsuarioModificacion
	WHERE	CuponConsultoraId	= @CuponConsultoraId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[InsertarCuponConsultoraCargaMasiva]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[InsertarCuponConsultoraCargaMasiva]
END
GO

CREATE PROCEDURE [dbo].[InsertarCuponConsultoraCargaMasiva]
@CuponId				INT,
@CampaniaId				INT,
@CuponConsultorasXml	XML
AS
BEGIN

	DELETE
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId AND CampaniaID = @CampaniaId

	INSERT	INTO CuponConsultora(CodigoConsultora, ValorAsociado, CampaniaId, CuponId, EstadoCupon, EnvioCorreo, UsuarioCreacion, FechaCreacion)
	SELECT	cC.value('@CodigoConsultora','VARCHAR(50)'), 
			cC.value('@ValorAsociado','DECIMAL(18,2)'),
			@CampaniaId,
			@CuponId,
			1,
			0,
			'',
			GETDATE()
	FROM	@CuponConsultorasXml.nodes('/ROOT/CuponConsultora')n(cC);
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

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponesPorCampania]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponesPorCampania]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponesPorCampania]
@PaisId		INT,
@CampaniaId	INT
AS
BEGIN
	SELECT	CuponId,
			Tipo,
			Descripcion,
			CampaniaId,
			Estado,
			FechaCreacion
	FROM	Cupon
	WHERE	CampaniaId = @CampaniaId
	ORDER BY FechaCreacion ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponConsultorasPorCuponId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponConsultorasPorCuponId]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponConsultorasPorCuponId]
@PaisId		INT,
@CuponId	INT
AS
BEGIN
	SELECT	CuponConsultoraId,
			CodigoConsultora,
			CampaniaId,
			CuponId,
			ValorAsociado,
			EstadoCupon 
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId
	ORDER BY CodigoConsultora ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[CrearCuponConsultora]
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioCreacion	varchar(50)
AS
BEGIN
	INSERT INTO CuponConsultora(CodigoConsultora, CampaniaId, CuponId, ValorAsociado, EstadoCupon, EnvioCorreo, FechaCreacion, UsuarioCreacion)
	VALUES(@CodigoConsultora, @CampaniaId, @CuponId, @ValorAsociado, 1, 0, GETDATE(), @UsuarioCreacion);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCuponConsultora]
@CuponConsultoraId	INT,
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioModificacion	varchar(50)
AS
BEGIN
	UPDATE	CuponConsultora
	SET		CodigoConsultora	= @CodigoConsultora,
			CampaniaId			= @CampaniaId,
			CuponId				= @CuponId,
			ValorAsociado		= @ValorAsociado,
			FechaModificacion	=  GETDATE(),
			UsuarioModificacion = @UsuarioModificacion
	WHERE	CuponConsultoraId	= @CuponConsultoraId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[InsertarCuponConsultoraCargaMasiva]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[InsertarCuponConsultoraCargaMasiva]
END
GO

CREATE PROCEDURE [dbo].[InsertarCuponConsultoraCargaMasiva]
@CuponId				INT,
@CampaniaId				INT,
@CuponConsultorasXml	XML
AS
BEGIN

	DELETE
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId AND CampaniaID = @CampaniaId

	INSERT	INTO CuponConsultora(CodigoConsultora, ValorAsociado, CampaniaId, CuponId, EstadoCupon, EnvioCorreo, UsuarioCreacion, FechaCreacion)
	SELECT	cC.value('@CodigoConsultora','VARCHAR(50)'), 
			cC.value('@ValorAsociado','DECIMAL(18,2)'),
			@CampaniaId,
			@CuponId,
			1,
			0,
			'',
			GETDATE()
	FROM	@CuponConsultorasXml.nodes('/ROOT/CuponConsultora')n(cC);
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

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponesPorCampania]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponesPorCampania]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponesPorCampania]
@PaisId		INT,
@CampaniaId	INT
AS
BEGIN
	SELECT	CuponId,
			Tipo,
			Descripcion,
			CampaniaId,
			Estado,
			FechaCreacion
	FROM	Cupon
	WHERE	CampaniaId = @CampaniaId
	ORDER BY FechaCreacion ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCuponConsultorasPorCuponId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCuponConsultorasPorCuponId]
END
GO

CREATE PROCEDURE [dbo].[ListarCuponConsultorasPorCuponId]
@PaisId		INT,
@CuponId	INT
AS
BEGIN
	SELECT	CuponConsultoraId,
			CodigoConsultora,
			CampaniaId,
			CuponId,
			ValorAsociado,
			EstadoCupon 
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId
	ORDER BY CodigoConsultora ASC
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[CrearCuponConsultora]
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioCreacion	varchar(50)
AS
BEGIN
	INSERT INTO CuponConsultora(CodigoConsultora, CampaniaId, CuponId, ValorAsociado, EstadoCupon, EnvioCorreo, FechaCreacion, UsuarioCreacion)
	VALUES(@CodigoConsultora, @CampaniaId, @CuponId, @ValorAsociado, 1, 0, GETDATE(), @UsuarioCreacion);
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCuponConsultora]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCuponConsultora]
END
GO

CREATE PROCEDURE [dbo].[ActualizarCuponConsultora]
@CuponConsultoraId	INT,
@CodigoConsultora	VARCHAR(50),
@CampaniaId			INT,
@CuponId			INT,
@ValorAsociado		DECIMAL(18, 2),
@UsuarioModificacion	varchar(50)
AS
BEGIN
	UPDATE	CuponConsultora
	SET		CodigoConsultora	= @CodigoConsultora,
			CampaniaId			= @CampaniaId,
			CuponId				= @CuponId,
			ValorAsociado		= @ValorAsociado,
			FechaModificacion	=  GETDATE(),
			UsuarioModificacion = @UsuarioModificacion
	WHERE	CuponConsultoraId	= @CuponConsultoraId
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[InsertarCuponConsultoraCargaMasiva]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[InsertarCuponConsultoraCargaMasiva]
END
GO

CREATE PROCEDURE [dbo].[InsertarCuponConsultoraCargaMasiva]
@CuponId				INT,
@CampaniaId				INT,
@CuponConsultorasXml	XML
AS
BEGIN

	DELETE
	FROM	CuponConsultora
	WHERE	CuponId = @CuponId AND CampaniaID = @CampaniaId

	INSERT	INTO CuponConsultora(CodigoConsultora, ValorAsociado, CampaniaId, CuponId, EstadoCupon, EnvioCorreo, UsuarioCreacion, FechaCreacion)
	SELECT	cC.value('@CodigoConsultora','VARCHAR(50)'), 
			cC.value('@ValorAsociado','DECIMAL(18,2)'),
			@CampaniaId,
			@CuponId,
			1,
			0,
			'',
			GETDATE()
	FROM	@CuponConsultorasXml.nodes('/ROOT/CuponConsultora')n(cC);
END
GO
