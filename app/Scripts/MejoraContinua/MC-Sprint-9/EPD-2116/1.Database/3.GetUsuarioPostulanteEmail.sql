USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulanteEmail'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulanteEmail
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@DocumentoIdentidad VARCHAR(50)
AS
BEGIN
	SELECT TOP (1) 
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
		AND RIGHT(CONCAT('000000000000000', U.DocumentoIdentidad),20) = RIGHT(CONCAT('000000000000000', @DocumentoIdentidad),20)
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulanteEmail'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulanteEmail
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@DocumentoIdentidad VARCHAR(50)
AS
BEGIN
	SELECT TOP (1) 
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
		AND RIGHT(CONCAT('000000000000000', U.DocumentoIdentidad),20) = RIGHT(CONCAT('000000000000000', @DocumentoIdentidad),20)
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulanteEmail'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulanteEmail
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@DocumentoIdentidad VARCHAR(50)
AS
BEGIN
	SELECT TOP (1) 
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
		AND RIGHT(CONCAT('000000000000000', U.DocumentoIdentidad),20) = RIGHT(CONCAT('000000000000000', @DocumentoIdentidad),20)
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulanteEmail'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulanteEmail
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@DocumentoIdentidad VARCHAR(50)
AS
BEGIN
	SELECT TOP (1) 
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
		AND RIGHT(CONCAT('000000000000000', U.DocumentoIdentidad),20) = RIGHT(CONCAT('000000000000000', @DocumentoIdentidad),20)
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulanteEmail'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulanteEmail
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@DocumentoIdentidad VARCHAR(50)
AS
BEGIN
	SELECT TOP (1) 
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
		AND RIGHT(CONCAT('000000000000000', U.DocumentoIdentidad),20) = RIGHT(CONCAT('000000000000000', @DocumentoIdentidad),20)
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulanteEmail'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulanteEmail
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@DocumentoIdentidad VARCHAR(50)
AS
BEGIN
	SELECT TOP (1) 
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
		AND RIGHT(CONCAT('000000000000000', U.DocumentoIdentidad),20) = RIGHT(CONCAT('000000000000000', @DocumentoIdentidad),20)
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulanteEmail'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulanteEmail
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@DocumentoIdentidad VARCHAR(50)
AS
BEGIN
	SELECT TOP (1) 
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
		AND RIGHT(CONCAT('000000000000000', U.DocumentoIdentidad),20) = RIGHT(CONCAT('000000000000000', @DocumentoIdentidad),20)
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulanteEmail'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulanteEmail
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@DocumentoIdentidad VARCHAR(50)
AS
BEGIN
	SELECT TOP (1) 
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
		AND RIGHT(CONCAT('000000000000000', U.DocumentoIdentidad),20) = RIGHT(CONCAT('000000000000000', @DocumentoIdentidad),20)
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulanteEmail'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulanteEmail
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@DocumentoIdentidad VARCHAR(50)
AS
BEGIN
	SELECT TOP (1) 
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
		AND RIGHT(CONCAT('000000000000000', U.DocumentoIdentidad),20) = RIGHT(CONCAT('000000000000000', @DocumentoIdentidad),20)
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulanteEmail'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulanteEmail
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@DocumentoIdentidad VARCHAR(50)
AS
BEGIN
	SELECT TOP (1) 
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
		AND RIGHT(CONCAT('000000000000000', U.DocumentoIdentidad),20) = RIGHT(CONCAT('000000000000000', @DocumentoIdentidad),20)
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulanteEmail'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulanteEmail
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@DocumentoIdentidad VARCHAR(50)
AS
BEGIN
	SELECT TOP (1) 
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
		AND RIGHT(CONCAT('000000000000000', U.DocumentoIdentidad),20) = RIGHT(CONCAT('000000000000000', @DocumentoIdentidad),20)
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulanteEmail'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulanteEmail
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@DocumentoIdentidad VARCHAR(50)
AS
BEGIN
	SELECT TOP (1) 
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
		AND RIGHT(CONCAT('000000000000000', U.DocumentoIdentidad),20) = RIGHT(CONCAT('000000000000000', @DocumentoIdentidad),20)
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioPostulanteEmail'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioPostulanteEmail
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioPostulanteEmail] 
	@DocumentoIdentidad VARCHAR(50)
AS
BEGIN
	SELECT TOP (1) 
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
		AND RIGHT(CONCAT('000000000000000', U.DocumentoIdentidad),20) = RIGHT(CONCAT('000000000000000', @DocumentoIdentidad),20)
END
GO