USE BelcorpBolivia
GO
ALTER PROCEDURE [dbo.[GetUsuarioPostulanteEmail]
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
ALTER PROCEDURE [dbo.[GetUsuarioPostulanteEmail]
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
ALTER PROCEDURE [dbo.[GetUsuarioPostulanteEmail]
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
ALTER PROCEDURE [dbo.[GetUsuarioPostulanteEmail]
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
ALTER PROCEDURE [dbo.[GetUsuarioPostulanteEmail]
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
ALTER PROCEDURE [dbo.[GetUsuarioPostulanteEmail]
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
ALTER PROCEDURE [dbo.[GetUsuarioPostulanteEmail]
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
ALTER PROCEDURE [dbo.[GetUsuarioPostulanteEmail]
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
ALTER PROCEDURE [dbo.[GetUsuarioPostulanteEmail]
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
ALTER PROCEDURE [dbo.[GetUsuarioPostulanteEmail]
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
ALTER PROCEDURE [dbo.[GetUsuarioPostulanteEmail]
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
ALTER PROCEDURE [dbo.[GetUsuarioPostulanteEmail]
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
ALTER PROCEDURE [dbo.[GetUsuarioPostulanteEmail]
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
