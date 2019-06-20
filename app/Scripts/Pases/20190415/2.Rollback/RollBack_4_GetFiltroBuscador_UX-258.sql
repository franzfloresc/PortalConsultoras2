USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.GetFiltroBuscador', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetFiltroBuscador AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetFiltroBuscador
@TablaLogicaDatosID INT
AS
BEGIN
	SELECT 
		IdFiltroBuscador,
		Codigo,
		Nombre,
		Descripcion,
		ValorMinimo,
		ValorMaximo,
		ISNULL(OrdenApp,0) AS OrdenApp,
		ColorTextoApp,
		ColorFondoApp
	FROM dbo.FiltroBuscador (NOLOCK)
	WHERE TablaLogicaDatosID = @TablaLogicaDatosID
	AND Estado = 1
END
GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( 'dbo.GetFiltroBuscador', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetFiltroBuscador AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetFiltroBuscador
@TablaLogicaDatosID INT
AS
BEGIN
	SELECT 
		IdFiltroBuscador,
		Codigo,
		Nombre,
		Descripcion,
		ValorMinimo,
		ValorMaximo,
		ISNULL(OrdenApp,0) AS OrdenApp,
		ColorTextoApp,
		ColorFondoApp
	FROM dbo.FiltroBuscador (NOLOCK)
	WHERE TablaLogicaDatosID = @TablaLogicaDatosID
	AND Estado = 1
END
GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( 'dbo.GetFiltroBuscador', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetFiltroBuscador AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetFiltroBuscador
@TablaLogicaDatosID INT
AS
BEGIN
	SELECT 
		IdFiltroBuscador,
		Codigo,
		Nombre,
		Descripcion,
		ValorMinimo,
		ValorMaximo,
		ISNULL(OrdenApp,0) AS OrdenApp,
		ColorTextoApp,
		ColorFondoApp
	FROM dbo.FiltroBuscador (NOLOCK)
	WHERE TablaLogicaDatosID = @TablaLogicaDatosID
	AND Estado = 1
END
GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( 'dbo.GetFiltroBuscador', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetFiltroBuscador AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetFiltroBuscador
@TablaLogicaDatosID INT
AS
BEGIN
	SELECT 
		IdFiltroBuscador,
		Codigo,
		Nombre,
		Descripcion,
		ValorMinimo,
		ValorMaximo,
		ISNULL(OrdenApp,0) AS OrdenApp,
		ColorTextoApp,
		ColorFondoApp
	FROM dbo.FiltroBuscador (NOLOCK)
	WHERE TablaLogicaDatosID = @TablaLogicaDatosID
	AND Estado = 1
END
GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( 'dbo.GetFiltroBuscador', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetFiltroBuscador AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetFiltroBuscador
@TablaLogicaDatosID INT
AS
BEGIN
	SELECT 
		IdFiltroBuscador,
		Codigo,
		Nombre,
		Descripcion,
		ValorMinimo,
		ValorMaximo,
		ISNULL(OrdenApp,0) AS OrdenApp,
		ColorTextoApp,
		ColorFondoApp
	FROM dbo.FiltroBuscador (NOLOCK)
	WHERE TablaLogicaDatosID = @TablaLogicaDatosID
	AND Estado = 1
END
GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( 'dbo.GetFiltroBuscador', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetFiltroBuscador AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetFiltroBuscador
@TablaLogicaDatosID INT
AS
BEGIN
	SELECT 
		IdFiltroBuscador,
		Codigo,
		Nombre,
		Descripcion,
		ValorMinimo,
		ValorMaximo,
		ISNULL(OrdenApp,0) AS OrdenApp,
		ColorTextoApp,
		ColorFondoApp
	FROM dbo.FiltroBuscador (NOLOCK)
	WHERE TablaLogicaDatosID = @TablaLogicaDatosID
	AND Estado = 1
END
GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( 'dbo.GetFiltroBuscador', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetFiltroBuscador AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetFiltroBuscador
@TablaLogicaDatosID INT
AS
BEGIN
	SELECT 
		IdFiltroBuscador,
		Codigo,
		Nombre,
		Descripcion,
		ValorMinimo,
		ValorMaximo,
		ISNULL(OrdenApp,0) AS OrdenApp,
		ColorTextoApp,
		ColorFondoApp
	FROM dbo.FiltroBuscador (NOLOCK)
	WHERE TablaLogicaDatosID = @TablaLogicaDatosID
	AND Estado = 1
END
GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( 'dbo.GetFiltroBuscador', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetFiltroBuscador AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetFiltroBuscador
@TablaLogicaDatosID INT
AS
BEGIN
	SELECT 
		IdFiltroBuscador,
		Codigo,
		Nombre,
		Descripcion,
		ValorMinimo,
		ValorMaximo,
		ISNULL(OrdenApp,0) AS OrdenApp,
		ColorTextoApp,
		ColorFondoApp
	FROM dbo.FiltroBuscador (NOLOCK)
	WHERE TablaLogicaDatosID = @TablaLogicaDatosID
	AND Estado = 1
END
GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( 'dbo.GetFiltroBuscador', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetFiltroBuscador AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetFiltroBuscador
@TablaLogicaDatosID INT
AS
BEGIN
	SELECT 
		IdFiltroBuscador,
		Codigo,
		Nombre,
		Descripcion,
		ValorMinimo,
		ValorMaximo,
		ISNULL(OrdenApp,0) AS OrdenApp,
		ColorTextoApp,
		ColorFondoApp
	FROM dbo.FiltroBuscador (NOLOCK)
	WHERE TablaLogicaDatosID = @TablaLogicaDatosID
	AND Estado = 1
END
GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( 'dbo.GetFiltroBuscador', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetFiltroBuscador AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetFiltroBuscador
@TablaLogicaDatosID INT
AS
BEGIN
	SELECT 
		IdFiltroBuscador,
		Codigo,
		Nombre,
		Descripcion,
		ValorMinimo,
		ValorMaximo,
		ISNULL(OrdenApp,0) AS OrdenApp,
		ColorTextoApp,
		ColorFondoApp
	FROM dbo.FiltroBuscador (NOLOCK)
	WHERE TablaLogicaDatosID = @TablaLogicaDatosID
	AND Estado = 1
END
GO

USE BelcorpChile
GO

IF (OBJECT_ID ( 'dbo.GetFiltroBuscador', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetFiltroBuscador AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetFiltroBuscador
@TablaLogicaDatosID INT
AS
BEGIN
	SELECT 
		IdFiltroBuscador,
		Codigo,
		Nombre,
		Descripcion,
		ValorMinimo,
		ValorMaximo,
		ISNULL(OrdenApp,0) AS OrdenApp,
		ColorTextoApp,
		ColorFondoApp
	FROM dbo.FiltroBuscador (NOLOCK)
	WHERE TablaLogicaDatosID = @TablaLogicaDatosID
	AND Estado = 1
END
GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( 'dbo.GetFiltroBuscador', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetFiltroBuscador AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetFiltroBuscador
@TablaLogicaDatosID INT
AS
BEGIN
	SELECT 
		IdFiltroBuscador,
		Codigo,
		Nombre,
		Descripcion,
		ValorMinimo,
		ValorMaximo,
		ISNULL(OrdenApp,0) AS OrdenApp,
		ColorTextoApp,
		ColorFondoApp
	FROM dbo.FiltroBuscador (NOLOCK)
	WHERE TablaLogicaDatosID = @TablaLogicaDatosID
	AND Estado = 1
END
GO

