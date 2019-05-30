USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[ContenidoAppGet]
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

ALTER PROCEDURE [dbo].[ContenidoAppGet]
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

ALTER PROCEDURE [dbo].[ContenidoAppGet]
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

ALTER PROCEDURE [dbo].[ContenidoAppGet]
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

ALTER PROCEDURE [dbo].[ContenidoAppGet]
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

ALTER PROCEDURE [dbo].[ContenidoAppGet]
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

ALTER PROCEDURE [dbo].[ContenidoAppGet]
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

ALTER PROCEDURE [dbo].[ContenidoAppGet]
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

ALTER PROCEDURE [dbo].[ContenidoAppGet]
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

ALTER PROCEDURE [dbo].[ContenidoAppGet]
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

ALTER PROCEDURE [dbo].[ContenidoAppGet]
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

ALTER PROCEDURE [dbo].[ContenidoAppGet]
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
