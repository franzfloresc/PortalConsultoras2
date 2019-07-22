USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppGet]
GO

CREATE PROCEDURE [dbo].[ContenidoAppGet]
	@Codigo varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		IdContenido, Codigo, Descripcion, UrlMiniatura, Estado, DesdeCampania, CantidadContenido, RutaImagen
	FROM ContenidoApp AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppGet]
GO

CREATE PROCEDURE [dbo].[ContenidoAppGet]
	@Codigo varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		IdContenido, Codigo, Descripcion, UrlMiniatura, Estado, DesdeCampania, CantidadContenido, RutaImagen
	FROM ContenidoApp AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppGet]
GO

CREATE PROCEDURE [dbo].[ContenidoAppGet]
	@Codigo varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		IdContenido, Codigo, Descripcion, UrlMiniatura, Estado, DesdeCampania, CantidadContenido, RutaImagen
	FROM ContenidoApp AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppGet]
GO

CREATE PROCEDURE [dbo].[ContenidoAppGet]
	@Codigo varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		IdContenido, Codigo, Descripcion, UrlMiniatura, Estado, DesdeCampania, CantidadContenido, RutaImagen
	FROM ContenidoApp AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppGet]
GO

CREATE PROCEDURE [dbo].[ContenidoAppGet]
	@Codigo varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		IdContenido, Codigo, Descripcion, UrlMiniatura, Estado, DesdeCampania, CantidadContenido, RutaImagen
	FROM ContenidoApp AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppGet]
GO

CREATE PROCEDURE [dbo].[ContenidoAppGet]
	@Codigo varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		IdContenido, Codigo, Descripcion, UrlMiniatura, Estado, DesdeCampania, CantidadContenido, RutaImagen
	FROM ContenidoApp AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppGet]
GO

CREATE PROCEDURE [dbo].[ContenidoAppGet]
	@Codigo varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		IdContenido, Codigo, Descripcion, UrlMiniatura, Estado, DesdeCampania, CantidadContenido, RutaImagen
	FROM ContenidoApp AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppGet]
GO

CREATE PROCEDURE [dbo].[ContenidoAppGet]
	@Codigo varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		IdContenido, Codigo, Descripcion, UrlMiniatura, Estado, DesdeCampania, CantidadContenido, RutaImagen
	FROM ContenidoApp AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppGet]
GO

CREATE PROCEDURE [dbo].[ContenidoAppGet]
	@Codigo varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		IdContenido, Codigo, Descripcion, UrlMiniatura, Estado, DesdeCampania, CantidadContenido, RutaImagen
	FROM ContenidoApp AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppGet]
GO

CREATE PROCEDURE [dbo].[ContenidoAppGet]
	@Codigo varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		IdContenido, Codigo, Descripcion, UrlMiniatura, Estado, DesdeCampania, CantidadContenido, RutaImagen
	FROM ContenidoApp AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppGet]
GO

CREATE PROCEDURE [dbo].[ContenidoAppGet]
	@Codigo varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		IdContenido, Codigo, Descripcion, UrlMiniatura, Estado, DesdeCampania, CantidadContenido, RutaImagen
	FROM ContenidoApp AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContenidoAppGet]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ContenidoAppGet]
GO

CREATE PROCEDURE [dbo].[ContenidoAppGet]
	@Codigo varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		IdContenido, Codigo, Descripcion, UrlMiniatura, Estado, DesdeCampania, CantidadContenido, RutaImagen
	FROM ContenidoApp AS P with(nolock)
	WHERE
		P.Codigo = @Codigo
END

GO

