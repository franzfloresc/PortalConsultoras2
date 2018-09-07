USE BelcorpBolivia;
GO
IF (OBJECT_ID ( 'dbo.ObtenerDireccionConsultora', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerDireccionConsultora
GO
CREATE PROCEDURE ObtenerDireccionConsultora
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP(1)
		ISNULL(D.Direccion,D.DireccionLinea1) AS Direccion, u.UnidadGeografica1 AS Ciudad
	FROM ods.Direccion d
	INNER JOIN ods.consultora c ON c.ConsultoraID = d.ConsultoraID
	LEFT JOIN dbo.Ubigeo u ON u.CodigoUbigeo = d.UnidadGeografica
	WHERE
		d.tipoDireccion='Domicilio' AND
		c.Codigo=@CodigoConsultora;
END
GO
USE BelcorpChile;
GO
IF (OBJECT_ID ( 'dbo.ObtenerDireccionConsultora', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerDireccionConsultora
GO
CREATE PROCEDURE ObtenerDireccionConsultora
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP(1)
		ISNULL(D.Direccion,D.DireccionLinea1) AS Direccion, u.UnidadGeografica1 AS Ciudad
	FROM ods.Direccion d
	INNER JOIN ods.consultora c ON c.ConsultoraID = d.ConsultoraID
	LEFT JOIN dbo.Ubigeo u ON u.CodigoUbigeo = d.UnidadGeografica
	WHERE
		d.tipoDireccion='Domicilio' AND
		c.Codigo=@CodigoConsultora;
END
GO
USE BelcorpColombia;
GO
IF (OBJECT_ID ( 'dbo.ObtenerDireccionConsultora', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerDireccionConsultora
GO
CREATE PROCEDURE ObtenerDireccionConsultora
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP(1)
		ISNULL(D.Direccion,D.DireccionLinea1) AS Direccion, u.UnidadGeografica1 AS Ciudad
	FROM ods.Direccion d
	INNER JOIN ods.consultora c ON c.ConsultoraID = d.ConsultoraID
	LEFT JOIN dbo.Ubigeo u ON u.CodigoUbigeo = d.UnidadGeografica
	WHERE
		d.tipoDireccion='Domicilio' AND
		c.Codigo=@CodigoConsultora;
END
GO
USE BelcorpCostaRica;
GO
IF (OBJECT_ID ( 'dbo.ObtenerDireccionConsultora', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerDireccionConsultora
GO
CREATE PROCEDURE ObtenerDireccionConsultora
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP(1)
		ISNULL(D.Direccion,D.DireccionLinea1) AS Direccion, u.UnidadGeografica1 AS Ciudad
	FROM ods.Direccion d
	INNER JOIN ods.consultora c ON c.ConsultoraID = d.ConsultoraID
	LEFT JOIN dbo.Ubigeo u ON u.CodigoUbigeo = d.UnidadGeografica
	WHERE
		d.tipoDireccion='Domicilio' AND
		c.Codigo=@CodigoConsultora;
END
GO
USE BelcorpDominicana;
GO
IF (OBJECT_ID ( 'dbo.ObtenerDireccionConsultora', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerDireccionConsultora
GO
CREATE PROCEDURE ObtenerDireccionConsultora
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP(1)
		ISNULL(D.Direccion,D.DireccionLinea1) AS Direccion, u.UnidadGeografica1 AS Ciudad
	FROM ods.Direccion d
	INNER JOIN ods.consultora c ON c.ConsultoraID = d.ConsultoraID
	LEFT JOIN dbo.Ubigeo u ON u.CodigoUbigeo = d.UnidadGeografica
	WHERE
		d.tipoDireccion='Domicilio' AND
		c.Codigo=@CodigoConsultora;
END
GO
USE BelcorpEcuador;
GO
IF (OBJECT_ID ( 'dbo.ObtenerDireccionConsultora', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerDireccionConsultora
GO
CREATE PROCEDURE ObtenerDireccionConsultora
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP(1)
		ISNULL(D.Direccion,D.DireccionLinea1) AS Direccion, u.UnidadGeografica1 AS Ciudad
	FROM ods.Direccion d
	INNER JOIN ods.consultora c ON c.ConsultoraID = d.ConsultoraID
	LEFT JOIN dbo.Ubigeo u ON u.CodigoUbigeo = d.UnidadGeografica
	WHERE
		d.tipoDireccion='Domicilio' AND
		c.Codigo=@CodigoConsultora;
END
GO
USE BelcorpGuatemala;
GO
IF (OBJECT_ID ( 'dbo.ObtenerDireccionConsultora', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerDireccionConsultora
GO
CREATE PROCEDURE ObtenerDireccionConsultora
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP(1)
		ISNULL(D.Direccion,D.DireccionLinea1) AS Direccion, u.UnidadGeografica1 AS Ciudad
	FROM ods.Direccion d
	INNER JOIN ods.consultora c ON c.ConsultoraID = d.ConsultoraID
	LEFT JOIN dbo.Ubigeo u ON u.CodigoUbigeo = d.UnidadGeografica
	WHERE
		d.tipoDireccion='Domicilio' AND
		c.Codigo=@CodigoConsultora;
END
GO
USE BelcorpMexico;
GO
IF (OBJECT_ID ( 'dbo.ObtenerDireccionConsultora', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerDireccionConsultora
GO
CREATE PROCEDURE ObtenerDireccionConsultora
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP(1)
		ISNULL(D.Direccion,D.DireccionLinea1) AS Direccion, u.UnidadGeografica1 AS Ciudad
	FROM ods.Direccion d
	INNER JOIN ods.consultora c ON c.ConsultoraID = d.ConsultoraID
	LEFT JOIN dbo.Ubigeo u ON u.CodigoUbigeo = d.UnidadGeografica
	WHERE
		d.tipoDireccion='Domicilio' AND
		c.Codigo=@CodigoConsultora;
END
GO
USE BelcorpPanama;
GO
IF (OBJECT_ID ( 'dbo.ObtenerDireccionConsultora', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerDireccionConsultora
GO
CREATE PROCEDURE ObtenerDireccionConsultora
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP(1)
		ISNULL(D.Direccion,D.DireccionLinea1) AS Direccion, u.UnidadGeografica1 AS Ciudad
	FROM ods.Direccion d
	INNER JOIN ods.consultora c ON c.ConsultoraID = d.ConsultoraID
	LEFT JOIN dbo.Ubigeo u ON u.CodigoUbigeo = d.UnidadGeografica
	WHERE
		d.tipoDireccion='Domicilio' AND
		c.Codigo=@CodigoConsultora;
END
GO
USE BelcorpPeru;
GO
IF (OBJECT_ID ( 'dbo.ObtenerDireccionConsultora', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerDireccionConsultora
GO
CREATE PROCEDURE ObtenerDireccionConsultora
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP(1)
		ISNULL(D.Direccion,D.DireccionLinea1) AS Direccion, u.UnidadGeografica1 AS Ciudad
	FROM ods.Direccion d
	INNER JOIN ods.consultora c ON c.ConsultoraID = d.ConsultoraID
	LEFT JOIN dbo.Ubigeo u ON u.CodigoUbigeo = d.UnidadGeografica
	WHERE
		d.tipoDireccion='Domicilio' AND
		c.Codigo=@CodigoConsultora;
END
GO
USE BelcorpPuertoRico;
GO
IF (OBJECT_ID ( 'dbo.ObtenerDireccionConsultora', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerDireccionConsultora
GO
CREATE PROCEDURE ObtenerDireccionConsultora
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP(1)
		ISNULL(D.Direccion,D.DireccionLinea1) AS Direccion, u.UnidadGeografica1 AS Ciudad
	FROM ods.Direccion d
	INNER JOIN ods.consultora c ON c.ConsultoraID = d.ConsultoraID
	LEFT JOIN dbo.Ubigeo u ON u.CodigoUbigeo = d.UnidadGeografica
	WHERE
		d.tipoDireccion='Domicilio' AND
		c.Codigo=@CodigoConsultora;
END
GO
USE BelcorpSalvador;
GO
IF (OBJECT_ID ( 'dbo.ObtenerDireccionConsultora', 'P' ) IS NOT NULL)
	DROP PROCEDURE dbo.ObtenerDireccionConsultora
GO
CREATE PROCEDURE ObtenerDireccionConsultora
@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP(1)
		ISNULL(D.Direccion,D.DireccionLinea1) AS Direccion, u.UnidadGeografica1 AS Ciudad
	FROM ods.Direccion d
	INNER JOIN ods.consultora c ON c.ConsultoraID = d.ConsultoraID
	LEFT JOIN dbo.Ubigeo u ON u.CodigoUbigeo = d.UnidadGeografica
	WHERE
		d.tipoDireccion='Domicilio' AND
		c.Codigo=@CodigoConsultora;
END
GO
