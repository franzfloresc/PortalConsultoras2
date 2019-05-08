USE BelcorpPeru
GO

IF OBJECT_ID('GetConfiguracionPaisDatosAll') IS NOT NULL
	DROP PROCEDURE dbo.GetConfiguracionPaisDatosAll
GO
CREATE PROCEDURE dbo.GetConfiguracionPaisDatosAll
@ConfiguracionPaisID INT
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID,
		CPD.Codigo,
		CPD.CampaniaID,
		CPD.Valor1,
		CPD.Valor2,
		CPD.Valor3,
		CPD.Descripcion,
		CPD.Estado,
		CPD.Componente
	FROM dbo.ConfiguracionPaisDatos CPD (NOLOCK)
	INNER JOIN dbo.ConfiguracionPais CP (NOLOCK)
	ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpMexico
GO

IF OBJECT_ID('GetConfiguracionPaisDatosAll') IS NOT NULL
	DROP PROCEDURE dbo.GetConfiguracionPaisDatosAll
GO
CREATE PROCEDURE dbo.GetConfiguracionPaisDatosAll
@ConfiguracionPaisID INT
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID,
		CPD.Codigo,
		CPD.CampaniaID,
		CPD.Valor1,
		CPD.Valor2,
		CPD.Valor3,
		CPD.Descripcion,
		CPD.Estado,
		CPD.Componente
	FROM dbo.ConfiguracionPaisDatos CPD (NOLOCK)
	INNER JOIN dbo.ConfiguracionPais CP (NOLOCK)
	ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpColombia
GO

IF OBJECT_ID('GetConfiguracionPaisDatosAll') IS NOT NULL
	DROP PROCEDURE dbo.GetConfiguracionPaisDatosAll
GO
CREATE PROCEDURE dbo.GetConfiguracionPaisDatosAll
@ConfiguracionPaisID INT
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID,
		CPD.Codigo,
		CPD.CampaniaID,
		CPD.Valor1,
		CPD.Valor2,
		CPD.Valor3,
		CPD.Descripcion,
		CPD.Estado,
		CPD.Componente
	FROM dbo.ConfiguracionPaisDatos CPD (NOLOCK)
	INNER JOIN dbo.ConfiguracionPais CP (NOLOCK)
	ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpSalvador
GO

IF OBJECT_ID('GetConfiguracionPaisDatosAll') IS NOT NULL
	DROP PROCEDURE dbo.GetConfiguracionPaisDatosAll
GO
CREATE PROCEDURE dbo.GetConfiguracionPaisDatosAll
@ConfiguracionPaisID INT
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID,
		CPD.Codigo,
		CPD.CampaniaID,
		CPD.Valor1,
		CPD.Valor2,
		CPD.Valor3,
		CPD.Descripcion,
		CPD.Estado,
		CPD.Componente
	FROM dbo.ConfiguracionPaisDatos CPD (NOLOCK)
	INNER JOIN dbo.ConfiguracionPais CP (NOLOCK)
	ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpPuertoRico
GO

IF OBJECT_ID('GetConfiguracionPaisDatosAll') IS NOT NULL
	DROP PROCEDURE dbo.GetConfiguracionPaisDatosAll
GO
CREATE PROCEDURE dbo.GetConfiguracionPaisDatosAll
@ConfiguracionPaisID INT
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID,
		CPD.Codigo,
		CPD.CampaniaID,
		CPD.Valor1,
		CPD.Valor2,
		CPD.Valor3,
		CPD.Descripcion,
		CPD.Estado,
		CPD.Componente
	FROM dbo.ConfiguracionPaisDatos CPD (NOLOCK)
	INNER JOIN dbo.ConfiguracionPais CP (NOLOCK)
	ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpPanama
GO

IF OBJECT_ID('GetConfiguracionPaisDatosAll') IS NOT NULL
	DROP PROCEDURE dbo.GetConfiguracionPaisDatosAll
GO
CREATE PROCEDURE dbo.GetConfiguracionPaisDatosAll
@ConfiguracionPaisID INT
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID,
		CPD.Codigo,
		CPD.CampaniaID,
		CPD.Valor1,
		CPD.Valor2,
		CPD.Valor3,
		CPD.Descripcion,
		CPD.Estado,
		CPD.Componente
	FROM dbo.ConfiguracionPaisDatos CPD (NOLOCK)
	INNER JOIN dbo.ConfiguracionPais CP (NOLOCK)
	ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpGuatemala
GO

IF OBJECT_ID('GetConfiguracionPaisDatosAll') IS NOT NULL
	DROP PROCEDURE dbo.GetConfiguracionPaisDatosAll
GO
CREATE PROCEDURE dbo.GetConfiguracionPaisDatosAll
@ConfiguracionPaisID INT
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID,
		CPD.Codigo,
		CPD.CampaniaID,
		CPD.Valor1,
		CPD.Valor2,
		CPD.Valor3,
		CPD.Descripcion,
		CPD.Estado,
		CPD.Componente
	FROM dbo.ConfiguracionPaisDatos CPD (NOLOCK)
	INNER JOIN dbo.ConfiguracionPais CP (NOLOCK)
	ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpEcuador
GO

IF OBJECT_ID('GetConfiguracionPaisDatosAll') IS NOT NULL
	DROP PROCEDURE dbo.GetConfiguracionPaisDatosAll
GO
CREATE PROCEDURE dbo.GetConfiguracionPaisDatosAll
@ConfiguracionPaisID INT
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID,
		CPD.Codigo,
		CPD.CampaniaID,
		CPD.Valor1,
		CPD.Valor2,
		CPD.Valor3,
		CPD.Descripcion,
		CPD.Estado,
		CPD.Componente
	FROM dbo.ConfiguracionPaisDatos CPD (NOLOCK)
	INNER JOIN dbo.ConfiguracionPais CP (NOLOCK)
	ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpDominicana
GO

IF OBJECT_ID('GetConfiguracionPaisDatosAll') IS NOT NULL
	DROP PROCEDURE dbo.GetConfiguracionPaisDatosAll
GO
CREATE PROCEDURE dbo.GetConfiguracionPaisDatosAll
@ConfiguracionPaisID INT
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID,
		CPD.Codigo,
		CPD.CampaniaID,
		CPD.Valor1,
		CPD.Valor2,
		CPD.Valor3,
		CPD.Descripcion,
		CPD.Estado,
		CPD.Componente
	FROM dbo.ConfiguracionPaisDatos CPD (NOLOCK)
	INNER JOIN dbo.ConfiguracionPais CP (NOLOCK)
	ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpCostaRica
GO

IF OBJECT_ID('GetConfiguracionPaisDatosAll') IS NOT NULL
	DROP PROCEDURE dbo.GetConfiguracionPaisDatosAll
GO
CREATE PROCEDURE dbo.GetConfiguracionPaisDatosAll
@ConfiguracionPaisID INT
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID,
		CPD.Codigo,
		CPD.CampaniaID,
		CPD.Valor1,
		CPD.Valor2,
		CPD.Valor3,
		CPD.Descripcion,
		CPD.Estado,
		CPD.Componente
	FROM dbo.ConfiguracionPaisDatos CPD (NOLOCK)
	INNER JOIN dbo.ConfiguracionPais CP (NOLOCK)
	ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpChile
GO

IF OBJECT_ID('GetConfiguracionPaisDatosAll') IS NOT NULL
	DROP PROCEDURE dbo.GetConfiguracionPaisDatosAll
GO
CREATE PROCEDURE dbo.GetConfiguracionPaisDatosAll
@ConfiguracionPaisID INT
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID,
		CPD.Codigo,
		CPD.CampaniaID,
		CPD.Valor1,
		CPD.Valor2,
		CPD.Valor3,
		CPD.Descripcion,
		CPD.Estado,
		CPD.Componente
	FROM dbo.ConfiguracionPaisDatos CPD (NOLOCK)
	INNER JOIN dbo.ConfiguracionPais CP (NOLOCK)
	ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpBolivia
GO

IF OBJECT_ID('GetConfiguracionPaisDatosAll') IS NOT NULL
	DROP PROCEDURE dbo.GetConfiguracionPaisDatosAll
GO
CREATE PROCEDURE dbo.GetConfiguracionPaisDatosAll
@ConfiguracionPaisID INT
AS
BEGIN
	SELECT 
		CPD.ConfiguracionPaisID,
		CPD.Codigo,
		CPD.CampaniaID,
		CPD.Valor1,
		CPD.Valor2,
		CPD.Valor3,
		CPD.Descripcion,
		CPD.Estado,
		CPD.Componente
	FROM dbo.ConfiguracionPaisDatos CPD (NOLOCK)
	INNER JOIN dbo.ConfiguracionPais CP (NOLOCK)
	ON CPD.ConfiguracionPaisID = CP.ConfiguracionPaisID
	WHERE CP.ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

