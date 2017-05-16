USE [BelcorpBolivia]
GO
----------------------------------------------------------------------------
ALTER PROCEDURE GetUsuarioPostulante
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		cp.ConsultoraID,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion,
		MensajeDesktop,
		MensajeMobile
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	LEFT JOIN ConsultoraPostulante cp on p.CodigoUsuario = cp.Codigo
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO

/*end*/

USE [BelcorpChile]
GO
----------------------------------------------------------------------------
ALTER PROCEDURE GetUsuarioPostulante
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		cp.ConsultoraID,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion,
		MensajeDesktop,
		MensajeMobile
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	LEFT JOIN ConsultoraPostulante cp on p.CodigoUsuario = cp.Codigo
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO

/*end*/

USE [BelcorpColombia]
GO
----------------------------------------------------------------------------
ALTER PROCEDURE GetUsuarioPostulante
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		cp.ConsultoraID,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion,
		MensajeDesktop,
		MensajeMobile
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	LEFT JOIN ConsultoraPostulante cp on p.CodigoUsuario = cp.Codigo
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO

/*end*/

USE [BelcorpCostaRica]
GO
----------------------------------------------------------------------------
ALTER PROCEDURE GetUsuarioPostulante
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		cp.ConsultoraID,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion,
		MensajeDesktop,
		MensajeMobile
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	LEFT JOIN ConsultoraPostulante cp on p.CodigoUsuario = cp.Codigo
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO

/*end*/

USE [BelcorpDominicana]
GO
----------------------------------------------------------------------------
ALTER PROCEDURE GetUsuarioPostulante
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		cp.ConsultoraID,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion,
		MensajeDesktop,
		MensajeMobile
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	LEFT JOIN ConsultoraPostulante cp on p.CodigoUsuario = cp.Codigo
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO

/*end*/

USE [BelcorpEcuador]
GO
----------------------------------------------------------------------------
ALTER PROCEDURE GetUsuarioPostulante
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		cp.ConsultoraID,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion,
		MensajeDesktop,
		MensajeMobile
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	LEFT JOIN ConsultoraPostulante cp on p.CodigoUsuario = cp.Codigo
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO

/*end*/

USE [BelcorpGuatemala]
GO
----------------------------------------------------------------------------
ALTER PROCEDURE GetUsuarioPostulante
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		cp.ConsultoraID,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion,
		MensajeDesktop,
		MensajeMobile
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	LEFT JOIN ConsultoraPostulante cp on p.CodigoUsuario = cp.Codigo
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO

/*end*/

USE [BelcorpMexico]
GO
----------------------------------------------------------------------------
ALTER PROCEDURE GetUsuarioPostulante
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		cp.ConsultoraID,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion,
		MensajeDesktop,
		MensajeMobile
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	LEFT JOIN ConsultoraPostulante cp on p.CodigoUsuario = cp.Codigo
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO

/*end*/

USE [BelcorpPanama]
GO
----------------------------------------------------------------------------
ALTER PROCEDURE GetUsuarioPostulante
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		cp.ConsultoraID,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion,
		MensajeDesktop,
		MensajeMobile
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	LEFT JOIN ConsultoraPostulante cp on p.CodigoUsuario = cp.Codigo
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO

/*end*/

USE [BelcorpPeru]
GO
----------------------------------------------------------------------------
ALTER PROCEDURE GetUsuarioPostulante
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		cp.ConsultoraID,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion,
		MensajeDesktop,
		MensajeMobile
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	LEFT JOIN ConsultoraPostulante cp on p.CodigoUsuario = cp.Codigo
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO

/*end*/

USE [BelcorpPuertoRico]
GO
----------------------------------------------------------------------------
ALTER PROCEDURE GetUsuarioPostulante
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		cp.ConsultoraID,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion,
		MensajeDesktop,
		MensajeMobile
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	LEFT JOIN ConsultoraPostulante cp on p.CodigoUsuario = cp.Codigo
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO

/*end*/

USE [BelcorpSalvador]
GO
----------------------------------------------------------------------------
ALTER PROCEDURE GetUsuarioPostulante
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		cp.ConsultoraID,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion,
		MensajeDesktop,
		MensajeMobile
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	LEFT JOIN ConsultoraPostulante cp on p.CodigoUsuario = cp.Codigo
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO

/*end*/

USE [BelcorpVenezuela]
GO
----------------------------------------------------------------------------
ALTER PROCEDURE GetUsuarioPostulante
(
	@NumeroDocumento VARCHAR(20)
)
AS

BEGIN
	SELECT TOP 1
		IdPostulante,
		CodigoUsuario,
		cp.ConsultoraID,
		Zona,
		Seccion,
		EnvioCorreo,
		UsuarioReal,
		FechaRegistro,
		Estado,
		z.ZonaID,
		z.Codigo AS CodigoZona,
		r.RegionID,
		r.Codigo AS CodigoRegion,
		MensajeDesktop,
		MensajeMobile
	FROM UsuarioPostulante p 
	LEFT JOIN ods.Zona z on p.Zona = z.Codigo
	LEFT JOIN ods.Region r on z.RegionID = r.RegionID
	LEFT JOIN ConsultoraPostulante cp on p.CodigoUsuario = cp.Codigo
	WHERE CodigoUsuario = @NumeroDocumento
	AND Estado = 1
END
GO

