USE BelcorpPeru
GO

----------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioPostulanteEmail]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetUsuarioPostulanteEmail]
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@Cantidad INT
AS
BEGIN
	SELECT TOP (@Cantidad) 
	U.CodigoUsuario,
	UP.CodigoUsuario AS CodigoConsultora,
	U.Nombre, 
	U.Email, 
	Z.Codigo AS CodigoZona,
	ISNULL(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
	ISNULL(Z.GerenteZona,'') GerenteZona,
	U.DocumentoIdentidad AS ClaveSecreta
	FROM usuario U
	INNER JOIN UsuarioPostulante UP ON U.CodigoUsuario = UP.CodigoUsuario AND EnvioCorreo = 0
	LEFT JOIN ods.Zona Z on UP.Zona = Z.ZonaID 
	WHERE U.TIpoUsuario = 2
END
GO

USE BelcorpMexico
GO

----------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioPostulanteEmail]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetUsuarioPostulanteEmail]
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@Cantidad INT
AS
BEGIN
	SELECT TOP (@Cantidad) 
	U.CodigoUsuario,
	UP.CodigoUsuario AS CodigoConsultora,
	U.Nombre, 
	U.Email, 
	Z.Codigo AS CodigoZona,
	ISNULL(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
	ISNULL(Z.GerenteZona,'') GerenteZona,
	U.DocumentoIdentidad AS ClaveSecreta
	FROM usuario U
	INNER JOIN UsuarioPostulante UP ON U.CodigoUsuario = UP.CodigoUsuario AND EnvioCorreo = 0
	LEFT JOIN ods.Zona Z on UP.Zona = Z.ZonaID 
	WHERE U.TIpoUsuario = 2
END
GO

USE BelcorpColombia
GO

----------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioPostulanteEmail]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetUsuarioPostulanteEmail]
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@Cantidad INT
AS
BEGIN
	SELECT TOP (@Cantidad) 
	U.CodigoUsuario,
	UP.CodigoUsuario AS CodigoConsultora,
	U.Nombre, 
	U.Email, 
	Z.Codigo AS CodigoZona,
	ISNULL(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
	ISNULL(Z.GerenteZona,'') GerenteZona,
	U.DocumentoIdentidad AS ClaveSecreta
	FROM usuario U
	INNER JOIN UsuarioPostulante UP ON U.CodigoUsuario = UP.CodigoUsuario AND EnvioCorreo = 0
	LEFT JOIN ods.Zona Z on UP.Zona = Z.ZonaID 
	WHERE U.TIpoUsuario = 2
END
GO

USE BelcorpVenezuela
GO

----------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioPostulanteEmail]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetUsuarioPostulanteEmail]
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@Cantidad INT
AS
BEGIN
	SELECT TOP (@Cantidad) 
	U.CodigoUsuario,
	UP.CodigoUsuario AS CodigoConsultora,
	U.Nombre, 
	U.Email, 
	Z.Codigo AS CodigoZona,
	ISNULL(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
	ISNULL(Z.GerenteZona,'') GerenteZona,
	U.DocumentoIdentidad AS ClaveSecreta
	FROM usuario U
	INNER JOIN UsuarioPostulante UP ON U.CodigoUsuario = UP.CodigoUsuario AND EnvioCorreo = 0
	LEFT JOIN ods.Zona Z on UP.Zona = Z.ZonaID 
	WHERE U.TIpoUsuario = 2
END
GO

USE BelcorpSalvador
GO

----------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioPostulanteEmail]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetUsuarioPostulanteEmail]
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@Cantidad INT
AS
BEGIN
	SELECT TOP (@Cantidad) 
	U.CodigoUsuario,
	UP.CodigoUsuario AS CodigoConsultora,
	U.Nombre, 
	U.Email, 
	Z.Codigo AS CodigoZona,
	ISNULL(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
	ISNULL(Z.GerenteZona,'') GerenteZona,
	U.DocumentoIdentidad AS ClaveSecreta
	FROM usuario U
	INNER JOIN UsuarioPostulante UP ON U.CodigoUsuario = UP.CodigoUsuario AND EnvioCorreo = 0
	LEFT JOIN ods.Zona Z on UP.Zona = Z.ZonaID 
	WHERE U.TIpoUsuario = 2
END
GO

USE BelcorpPuertoRico
GO

----------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioPostulanteEmail]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetUsuarioPostulanteEmail]
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@Cantidad INT
AS
BEGIN
	SELECT TOP (@Cantidad) 
	U.CodigoUsuario,
	UP.CodigoUsuario AS CodigoConsultora,
	U.Nombre, 
	U.Email, 
	Z.Codigo AS CodigoZona,
	ISNULL(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
	ISNULL(Z.GerenteZona,'') GerenteZona,
	U.DocumentoIdentidad AS ClaveSecreta
	FROM usuario U
	INNER JOIN UsuarioPostulante UP ON U.CodigoUsuario = UP.CodigoUsuario AND EnvioCorreo = 0
	LEFT JOIN ods.Zona Z on UP.Zona = Z.ZonaID 
	WHERE U.TIpoUsuario = 2
END
GO

USE BelcorpPanama
GO

----------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioPostulanteEmail]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetUsuarioPostulanteEmail]
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@Cantidad INT
AS
BEGIN
	SELECT TOP (@Cantidad) 
	U.CodigoUsuario,
	UP.CodigoUsuario AS CodigoConsultora,
	U.Nombre, 
	U.Email, 
	Z.Codigo AS CodigoZona,
	ISNULL(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
	ISNULL(Z.GerenteZona,'') GerenteZona,
	U.DocumentoIdentidad AS ClaveSecreta
	FROM usuario U
	INNER JOIN UsuarioPostulante UP ON U.CodigoUsuario = UP.CodigoUsuario AND EnvioCorreo = 0
	LEFT JOIN ods.Zona Z on UP.Zona = Z.ZonaID 
	WHERE U.TIpoUsuario = 2
END
GO

USE BelcorpGuatemala
GO

----------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioPostulanteEmail]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetUsuarioPostulanteEmail]
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@Cantidad INT
AS
BEGIN
	SELECT TOP (@Cantidad) 
	U.CodigoUsuario,
	UP.CodigoUsuario AS CodigoConsultora,
	U.Nombre, 
	U.Email, 
	Z.Codigo AS CodigoZona,
	ISNULL(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
	ISNULL(Z.GerenteZona,'') GerenteZona,
	U.DocumentoIdentidad AS ClaveSecreta
	FROM usuario U
	INNER JOIN UsuarioPostulante UP ON U.CodigoUsuario = UP.CodigoUsuario AND EnvioCorreo = 0
	LEFT JOIN ods.Zona Z on UP.Zona = Z.ZonaID 
	WHERE U.TIpoUsuario = 2
END
GO

USE BelcorpEcuador
GO

----------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioPostulanteEmail]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetUsuarioPostulanteEmail]
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@Cantidad INT
AS
BEGIN
	SELECT TOP (@Cantidad) 
	U.CodigoUsuario,
	UP.CodigoUsuario AS CodigoConsultora,
	U.Nombre, 
	U.Email, 
	Z.Codigo AS CodigoZona,
	ISNULL(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
	ISNULL(Z.GerenteZona,'') GerenteZona,
	U.DocumentoIdentidad AS ClaveSecreta
	FROM usuario U
	INNER JOIN UsuarioPostulante UP ON U.CodigoUsuario = UP.CodigoUsuario AND EnvioCorreo = 0
	LEFT JOIN ods.Zona Z on UP.Zona = Z.ZonaID 
	WHERE U.TIpoUsuario = 2
END
GO

USE BelcorpDominicana
GO

----------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioPostulanteEmail]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetUsuarioPostulanteEmail]
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@Cantidad INT
AS
BEGIN
	SELECT TOP (@Cantidad) 
	U.CodigoUsuario,
	UP.CodigoUsuario AS CodigoConsultora,
	U.Nombre, 
	U.Email, 
	Z.Codigo AS CodigoZona,
	ISNULL(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
	ISNULL(Z.GerenteZona,'') GerenteZona,
	U.DocumentoIdentidad AS ClaveSecreta
	FROM usuario U
	INNER JOIN UsuarioPostulante UP ON U.CodigoUsuario = UP.CodigoUsuario AND EnvioCorreo = 0
	LEFT JOIN ods.Zona Z on UP.Zona = Z.ZonaID 
	WHERE U.TIpoUsuario = 2
END
GO

USE BelcorpCostaRica
GO

----------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioPostulanteEmail]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetUsuarioPostulanteEmail]
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@Cantidad INT
AS
BEGIN
	SELECT TOP (@Cantidad) 
	U.CodigoUsuario,
	UP.CodigoUsuario AS CodigoConsultora,
	U.Nombre, 
	U.Email, 
	Z.Codigo AS CodigoZona,
	ISNULL(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
	ISNULL(Z.GerenteZona,'') GerenteZona,
	U.DocumentoIdentidad AS ClaveSecreta
	FROM usuario U
	INNER JOIN UsuarioPostulante UP ON U.CodigoUsuario = UP.CodigoUsuario AND EnvioCorreo = 0
	LEFT JOIN ods.Zona Z on UP.Zona = Z.ZonaID 
	WHERE U.TIpoUsuario = 2
END
GO

USE BelcorpChile
GO

----------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioPostulanteEmail]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetUsuarioPostulanteEmail]
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@Cantidad INT
AS
BEGIN
	SELECT TOP (@Cantidad) 
	U.CodigoUsuario,
	UP.CodigoUsuario AS CodigoConsultora,
	U.Nombre, 
	U.Email, 
	Z.Codigo AS CodigoZona,
	ISNULL(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
	ISNULL(Z.GerenteZona,'') GerenteZona,
	U.DocumentoIdentidad AS ClaveSecreta
	FROM usuario U
	INNER JOIN UsuarioPostulante UP ON U.CodigoUsuario = UP.CodigoUsuario AND EnvioCorreo = 0
	LEFT JOIN ods.Zona Z on UP.Zona = Z.ZonaID 
	WHERE U.TIpoUsuario = 2
END
GO

USE BelcorpBolivia
GO

----------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUsuarioPostulanteEmail]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetUsuarioPostulanteEmail]
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@Cantidad INT
AS
BEGIN
	SELECT TOP (@Cantidad) 
	U.CodigoUsuario,
	UP.CodigoUsuario AS CodigoConsultora,
	U.Nombre, 
	U.Email, 
	Z.Codigo AS CodigoZona,
	ISNULL(REPLACE(Z.GZEmail,'}',''), '') GZEmail,
	ISNULL(Z.GerenteZona,'') GerenteZona,
	U.DocumentoIdentidad AS ClaveSecreta
	FROM usuario U
	INNER JOIN UsuarioPostulante UP ON U.CodigoUsuario = UP.CodigoUsuario AND EnvioCorreo = 0
	LEFT JOIN ods.Zona Z on UP.Zona = Z.ZonaID 
	WHERE U.TIpoUsuario = 2
END
GO

