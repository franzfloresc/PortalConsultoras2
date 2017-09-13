USE BelcorpBolivia
go

IF EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @PERMISOID INT, @ROLID INT;

	SET	@PERMISOID	= (SELECT PermisoID FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index');
	SET @ROLID		= 4;

	DELETE
	FROM	RolPermiso
	WHERE	RolID = @ROLID AND PermisoID = @PERMISOID

	DELETE	
	FROM	Permiso 
	WHERE	PermisoID = @PERMISOID
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO
/*end*/

USE BelcorpChile
go

IF EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @PERMISOID INT, @ROLID INT;

	SET	@PERMISOID	= (SELECT PermisoID FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index');
	SET @ROLID		= 4;

	DELETE
	FROM	RolPermiso
	WHERE	RolID = @ROLID AND PermisoID = @PERMISOID

	DELETE	
	FROM	Permiso 
	WHERE	PermisoID = @PERMISOID
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO
/*end*/

USE BelcorpColombia
go

IF EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @PERMISOID INT, @ROLID INT;

	SET	@PERMISOID	= (SELECT PermisoID FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index');
	SET @ROLID		= 4;

	DELETE
	FROM	RolPermiso
	WHERE	RolID = @ROLID AND PermisoID = @PERMISOID

	DELETE	
	FROM	Permiso 
	WHERE	PermisoID = @PERMISOID
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO
/*end*/

USE BelcorpCostaRica
go

IF EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @PERMISOID INT, @ROLID INT;

	SET	@PERMISOID	= (SELECT PermisoID FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index');
	SET @ROLID		= 4;

	DELETE
	FROM	RolPermiso
	WHERE	RolID = @ROLID AND PermisoID = @PERMISOID

	DELETE	
	FROM	Permiso 
	WHERE	PermisoID = @PERMISOID
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO
/*end*/

USE BelcorpDominicana
go

IF EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @PERMISOID INT, @ROLID INT;

	SET	@PERMISOID	= (SELECT PermisoID FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index');
	SET @ROLID		= 4;

	DELETE
	FROM	RolPermiso
	WHERE	RolID = @ROLID AND PermisoID = @PERMISOID

	DELETE	
	FROM	Permiso 
	WHERE	PermisoID = @PERMISOID
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO
/*end*/

USE BelcorpEcuador
go

IF EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @PERMISOID INT, @ROLID INT;

	SET	@PERMISOID	= (SELECT PermisoID FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index');
	SET @ROLID		= 4;

	DELETE
	FROM	RolPermiso
	WHERE	RolID = @ROLID AND PermisoID = @PERMISOID

	DELETE	
	FROM	Permiso 
	WHERE	PermisoID = @PERMISOID
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO
/*end*/

USE BelcorpGuatemala
go

IF EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @PERMISOID INT, @ROLID INT;

	SET	@PERMISOID	= (SELECT PermisoID FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index');
	SET @ROLID		= 4;

	DELETE
	FROM	RolPermiso
	WHERE	RolID = @ROLID AND PermisoID = @PERMISOID

	DELETE	
	FROM	Permiso 
	WHERE	PermisoID = @PERMISOID
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO
/*end*/

USE BelcorpMexico
go

IF EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @PERMISOID INT, @ROLID INT;

	SET	@PERMISOID	= (SELECT PermisoID FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index');
	SET @ROLID		= 4;

	DELETE
	FROM	RolPermiso
	WHERE	RolID = @ROLID AND PermisoID = @PERMISOID

	DELETE	
	FROM	Permiso 
	WHERE	PermisoID = @PERMISOID
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO
/*end*/

USE BelcorpPanama
go

IF EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @PERMISOID INT, @ROLID INT;

	SET	@PERMISOID	= (SELECT PermisoID FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index');
	SET @ROLID		= 4;

	DELETE
	FROM	RolPermiso
	WHERE	RolID = @ROLID AND PermisoID = @PERMISOID

	DELETE	
	FROM	Permiso 
	WHERE	PermisoID = @PERMISOID
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO
/*end*/

USE BelcorpPeru
go

IF EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @PERMISOID INT, @ROLID INT;

	SET	@PERMISOID	= (SELECT PermisoID FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index');
	SET @ROLID		= 4;

	DELETE
	FROM	RolPermiso
	WHERE	RolID = @ROLID AND PermisoID = @PERMISOID

	DELETE	
	FROM	Permiso 
	WHERE	PermisoID = @PERMISOID
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO
/*end*/

USE BelcorpPuertoRico
go

IF EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @PERMISOID INT, @ROLID INT;

	SET	@PERMISOID	= (SELECT PermisoID FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index');
	SET @ROLID		= 4;

	DELETE
	FROM	RolPermiso
	WHERE	RolID = @ROLID AND PermisoID = @PERMISOID

	DELETE	
	FROM	Permiso 
	WHERE	PermisoID = @PERMISOID
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO
/*end*/

USE BelcorpSalvador
go

IF EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @PERMISOID INT, @ROLID INT;

	SET	@PERMISOID	= (SELECT PermisoID FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index');
	SET @ROLID		= 4;

	DELETE
	FROM	RolPermiso
	WHERE	RolID = @ROLID AND PermisoID = @PERMISOID

	DELETE	
	FROM	Permiso 
	WHERE	PermisoID = @PERMISOID
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO
/*end*/

USE BelcorpVenezuela
go

IF EXISTS (SELECT 1 FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index')
BEGIN
	DECLARE @PERMISOID INT, @ROLID INT;

	SET	@PERMISOID	= (SELECT PermisoID FROM Permiso WHERE UrlItem = 'AdministrarCupon/Index');
	SET @ROLID		= 4;

	DELETE
	FROM	RolPermiso
	WHERE	RolID = @ROLID AND PermisoID = @PERMISOID

	DELETE	
	FROM	Permiso 
	WHERE	PermisoID = @PERMISOID
END

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[CrearCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[CrearCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ActualizarCupon]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ActualizarCupon]
END
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListarCupones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE  [dbo].[ListarCupones]
END
GO

