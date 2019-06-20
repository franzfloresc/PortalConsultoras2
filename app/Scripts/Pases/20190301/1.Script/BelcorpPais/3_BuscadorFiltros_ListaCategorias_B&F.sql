GO
USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_ListaCategorias]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_ListaCategorias]
GO
CREATE PROC BuscadorFiltros_ListaCategorias
AS
BEGIN
	SELECT descripcion as codigo, Nombre, isnull(imagen, '') imagen, imagenAncha  FROM filtrobuscador WHERE tablalogicadatosid = 14801
END

GO
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_ListaCategorias]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_ListaCategorias]
GO
CREATE PROC BuscadorFiltros_ListaCategorias
AS
BEGIN
	SELECT descripcion as codigo, Nombre, isnull(imagen, '') imagen, imagenAncha  FROM filtrobuscador WHERE tablalogicadatosid = 14801
END

GO
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_ListaCategorias]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_ListaCategorias]
GO
CREATE PROC BuscadorFiltros_ListaCategorias
AS
BEGIN
	SELECT descripcion as codigo, Nombre, isnull(imagen, '') imagen, imagenAncha  FROM filtrobuscador WHERE tablalogicadatosid = 14801
END

GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_ListaCategorias]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_ListaCategorias]
GO
CREATE PROC BuscadorFiltros_ListaCategorias
AS
BEGIN
	SELECT descripcion as codigo, Nombre, isnull(imagen, '') imagen, imagenAncha  FROM filtrobuscador WHERE tablalogicadatosid = 14801
END

GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_ListaCategorias]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_ListaCategorias]
GO
CREATE PROC BuscadorFiltros_ListaCategorias
AS
BEGIN
	SELECT descripcion as codigo, Nombre, isnull(imagen, '') imagen, imagenAncha  FROM filtrobuscador WHERE tablalogicadatosid = 14801
END

GO
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_ListaCategorias]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_ListaCategorias]
GO
CREATE PROC BuscadorFiltros_ListaCategorias
AS
BEGIN
	SELECT descripcion as codigo, Nombre, isnull(imagen, '') imagen, imagenAncha  FROM filtrobuscador WHERE tablalogicadatosid = 14801
END

GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_ListaCategorias]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_ListaCategorias]
GO
CREATE PROC BuscadorFiltros_ListaCategorias
AS
BEGIN
	SELECT descripcion as codigo, Nombre, isnull(imagen, '') imagen, imagenAncha  FROM filtrobuscador WHERE tablalogicadatosid = 14801
END

GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_ListaCategorias]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_ListaCategorias]
GO
CREATE PROC BuscadorFiltros_ListaCategorias
AS
BEGIN
	SELECT descripcion as codigo, Nombre, isnull(imagen, '') imagen, imagenAncha  FROM filtrobuscador WHERE tablalogicadatosid = 14801
END

GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_ListaCategorias]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_ListaCategorias]
GO
CREATE PROC BuscadorFiltros_ListaCategorias
AS
BEGIN
	SELECT descripcion as codigo, Nombre, isnull(imagen, '') imagen, imagenAncha  FROM filtrobuscador WHERE tablalogicadatosid = 14801
END

GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_ListaCategorias]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_ListaCategorias]
GO
CREATE PROC BuscadorFiltros_ListaCategorias
AS
BEGIN
	SELECT descripcion as codigo, Nombre, isnull(imagen, '') imagen, imagenAncha  FROM filtrobuscador WHERE tablalogicadatosid = 14801
END

GO
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_ListaCategorias]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_ListaCategorias]
GO
CREATE PROC BuscadorFiltros_ListaCategorias
AS
BEGIN
	SELECT descripcion as codigo, Nombre, isnull(imagen, '') imagen, imagenAncha  FROM filtrobuscador WHERE tablalogicadatosid = 14801
END

GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_ListaCategorias]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_ListaCategorias]
GO
CREATE PROC BuscadorFiltros_ListaCategorias
AS
BEGIN
	SELECT descripcion as codigo, Nombre, isnull(imagen, '') imagen, imagenAncha  FROM filtrobuscador WHERE tablalogicadatosid = 14801
END

GO
