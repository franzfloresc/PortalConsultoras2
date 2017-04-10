USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulante]
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO
