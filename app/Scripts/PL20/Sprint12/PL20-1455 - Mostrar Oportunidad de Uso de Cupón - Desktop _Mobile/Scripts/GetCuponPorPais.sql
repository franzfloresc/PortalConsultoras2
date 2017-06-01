USE BelcorpBolivia
GO
IF OBJECT_ID('GetCuponPorPais', 'P') IS NOT NULL
	DROP PROCEDURE GetCuponPorPais
GO

CREATE PROCEDURE dbo.GetCuponPorPais
	@CodigoConsultora varchar(25)
AS
/*
GetCuponPorPais '000758833'
*/
SELECT u.EMailActivo, isnull(p.TieneCupon,0) as TieneCupon 
FROM dbo.Usuario u (nolock) 
INNER JOIN Pais p (nolock) ON u.PaisID = p.PaisID
LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
WHERE
			ro.Sistema = 1
			and u.CodigoConsultora = @CodigoConsultora
GO

USE BelcorpCostaRica
GO
IF OBJECT_ID('GetCuponPorPais', 'P') IS NOT NULL
	DROP PROCEDURE GetCuponPorPais
GO

CREATE PROCEDURE dbo.GetCuponPorPais
	@CodigoConsultora varchar(25)
AS
/*
GetCuponPorPais '000758833'
*/
SELECT u.EMailActivo, isnull(p.TieneCupon,0) as TieneCupon 
FROM dbo.Usuario u (nolock) 
INNER JOIN Pais p (nolock) ON u.PaisID = p.PaisID
LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
WHERE
			ro.Sistema = 1
			and u.CodigoConsultora = @CodigoConsultora
GO

USE BelcorpChile
GO
IF OBJECT_ID('GetCuponPorPais', 'P') IS NOT NULL
	DROP PROCEDURE GetCuponPorPais
GO

CREATE PROCEDURE dbo.GetCuponPorPais
	@CodigoConsultora varchar(25)
AS
/*
GetCuponPorPais '000758833'
*/
SELECT u.EMailActivo, isnull(p.TieneCupon,0) as TieneCupon 
FROM dbo.Usuario u (nolock) 
INNER JOIN Pais p (nolock) ON u.PaisID = p.PaisID
LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
WHERE
			ro.Sistema = 1
			and u.CodigoConsultora = @CodigoConsultora
GO

USE BelcorpColombia
GO
IF OBJECT_ID('GetCuponPorPais', 'P') IS NOT NULL
	DROP PROCEDURE GetCuponPorPais
GO

CREATE PROCEDURE dbo.GetCuponPorPais
	@CodigoConsultora varchar(25)
AS
/*
GetCuponPorPais '000758833'
*/
SELECT u.EMailActivo, isnull(p.TieneCupon,0) as TieneCupon 
FROM dbo.Usuario u (nolock) 
INNER JOIN Pais p (nolock) ON u.PaisID = p.PaisID
LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
WHERE
			ro.Sistema = 1
			and u.CodigoConsultora = @CodigoConsultora
GO

USE BelcorpDominicana
GO
IF OBJECT_ID('GetCuponPorPais', 'P') IS NOT NULL
	DROP PROCEDURE GetCuponPorPais
GO

CREATE PROCEDURE dbo.GetCuponPorPais
	@CodigoConsultora varchar(25)
AS
/*
GetCuponPorPais '000758833'
*/
SELECT u.EMailActivo, isnull(p.TieneCupon,0) as TieneCupon 
FROM dbo.Usuario u (nolock) 
INNER JOIN Pais p (nolock) ON u.PaisID = p.PaisID
LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
WHERE
			ro.Sistema = 1
			and u.CodigoConsultora = @CodigoConsultora
GO

USE BelcorpEcuador
GO
IF OBJECT_ID('GetCuponPorPais', 'P') IS NOT NULL
	DROP PROCEDURE GetCuponPorPais
GO

CREATE PROCEDURE dbo.GetCuponPorPais
	@CodigoConsultora varchar(25)
AS
/*
GetCuponPorPais '000758833'
*/
SELECT u.EMailActivo, isnull(p.TieneCupon,0) as TieneCupon 
FROM dbo.Usuario u (nolock) 
INNER JOIN Pais p (nolock) ON u.PaisID = p.PaisID
LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
WHERE
			ro.Sistema = 1
			and u.CodigoConsultora = @CodigoConsultora
GO

USE BelcorpGuatemala
GO
IF OBJECT_ID('GetCuponPorPais', 'P') IS NOT NULL
	DROP PROCEDURE GetCuponPorPais
GO

CREATE PROCEDURE dbo.GetCuponPorPais
	@CodigoConsultora varchar(25)
AS
/*
GetCuponPorPais '000758833'
*/
SELECT u.EMailActivo, isnull(p.TieneCupon,0) as TieneCupon 
FROM dbo.Usuario u (nolock) 
INNER JOIN Pais p (nolock) ON u.PaisID = p.PaisID
LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
WHERE
			ro.Sistema = 1
			and u.CodigoConsultora = @CodigoConsultora
GO

USE BelcorpMexico
GO
IF OBJECT_ID('GetCuponPorPais', 'P') IS NOT NULL
	DROP PROCEDURE GetCuponPorPais
GO

CREATE PROCEDURE dbo.GetCuponPorPais
	@CodigoConsultora varchar(25)
AS
/*
GetCuponPorPais '000758833'
*/
SELECT u.EMailActivo, isnull(p.TieneCupon,0) as TieneCupon 
FROM dbo.Usuario u (nolock) 
INNER JOIN Pais p (nolock) ON u.PaisID = p.PaisID
LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
WHERE
			ro.Sistema = 1
			and u.CodigoConsultora = @CodigoConsultora
GO

USE BelcorpPanama
GO
IF OBJECT_ID('GetCuponPorPais', 'P') IS NOT NULL
	DROP PROCEDURE GetCuponPorPais
GO

CREATE PROCEDURE dbo.GetCuponPorPais
	@CodigoConsultora varchar(25)
AS
/*
GetCuponPorPais '000758833'
*/
SELECT u.EMailActivo, isnull(p.TieneCupon,0) as TieneCupon 
FROM dbo.Usuario u (nolock) 
INNER JOIN Pais p (nolock) ON u.PaisID = p.PaisID
LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
WHERE
			ro.Sistema = 1
			and u.CodigoConsultora = @CodigoConsultora
GO

USE BelcorpPeru
GO
IF OBJECT_ID('GetCuponPorPais', 'P') IS NOT NULL
	DROP PROCEDURE GetCuponPorPais
GO

CREATE PROCEDURE dbo.GetCuponPorPais
	@CodigoConsultora varchar(25)
AS
/*
GetCuponPorPais '000758833'
*/
SELECT u.EMailActivo, isnull(p.TieneCupon,0) as TieneCupon 
FROM dbo.Usuario u (nolock) 
INNER JOIN Pais p (nolock) ON u.PaisID = p.PaisID
LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
WHERE
			ro.Sistema = 1
			and u.CodigoConsultora = @CodigoConsultora
GO

USE BelcorpPuertoRico
GO
IF OBJECT_ID('GetCuponPorPais', 'P') IS NOT NULL
	DROP PROCEDURE GetCuponPorPais
GO

CREATE PROCEDURE dbo.GetCuponPorPais
	@CodigoConsultora varchar(25)
AS
/*
GetCuponPorPais '000758833'
*/
SELECT u.EMailActivo, isnull(p.TieneCupon,0) as TieneCupon 
FROM dbo.Usuario u (nolock) 
INNER JOIN Pais p (nolock) ON u.PaisID = p.PaisID
LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
WHERE
			ro.Sistema = 1
			and u.CodigoConsultora = @CodigoConsultora
GO

USE BelcorpSalvador
GO
IF OBJECT_ID('GetCuponPorPais', 'P') IS NOT NULL
	DROP PROCEDURE GetCuponPorPais
GO

CREATE PROCEDURE dbo.GetCuponPorPais
	@CodigoConsultora varchar(25)
AS
/*
GetCuponPorPais '000758833'
*/
SELECT u.EMailActivo, isnull(p.TieneCupon,0) as TieneCupon 
FROM dbo.Usuario u (nolock) 
INNER JOIN Pais p (nolock) ON u.PaisID = p.PaisID
LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
WHERE
			ro.Sistema = 1
			and u.CodigoConsultora = @CodigoConsultora
GO

USE BelcorpVenezuela
GO
IF OBJECT_ID('GetCuponPorPais', 'P') IS NOT NULL
	DROP PROCEDURE GetCuponPorPais
GO

CREATE PROCEDURE dbo.GetCuponPorPais
	@CodigoConsultora varchar(25)
AS
/*
GetCuponPorPais '000758833'
*/
SELECT u.EMailActivo, isnull(p.TieneCupon,0) as TieneCupon 
FROM dbo.Usuario u (nolock) 
INNER JOIN Pais p (nolock) ON u.PaisID = p.PaisID
LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
WHERE
			ro.Sistema = 1
			and u.CodigoConsultora = @CodigoConsultora
GO







