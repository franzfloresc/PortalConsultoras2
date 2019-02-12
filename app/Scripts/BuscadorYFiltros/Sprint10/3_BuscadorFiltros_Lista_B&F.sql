GO
USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO
CREATE PROC [dbo].[BuscadorFiltros_Lista]
AS
BEGIN
	SELECT fc.TablaLogicaDatosId, tl.valor FiltroSeccion, fc.CampoES, fc.TipoOperadorES, fb.idFiltroBuscador,
		fb.Nombre FiltroNombre, fb.Descripcion Codigo, isnull(fb.ValorMinimo, 0) ValorMinimo,
		isnull(fb.ValorMaximo, 0) ValorMaximo FROM filtroSeccion fc
	INNER JOIN filtrobuscador fb on fc.TablaLogicaDatosId = fb.TablaLogicaDatosId
	INNER JOIN tablalogicadatos tl on tl.TablaLogicaId = 148 and fc.TablaLogicaDatosId = tl.TablaLogicaDatosId
	WHERE fb.Estado = 1
END

GO
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO
CREATE PROC [dbo].[BuscadorFiltros_Lista]
AS
BEGIN
	SELECT fc.TablaLogicaDatosId, tl.valor FiltroSeccion, fc.CampoES, fc.TipoOperadorES, fb.idFiltroBuscador,
		fb.Nombre FiltroNombre, fb.Descripcion Codigo, isnull(fb.ValorMinimo, 0) ValorMinimo,
		isnull(fb.ValorMaximo, 0) ValorMaximo FROM filtroSeccion fc
	INNER JOIN filtrobuscador fb on fc.TablaLogicaDatosId = fb.TablaLogicaDatosId
	INNER JOIN tablalogicadatos tl on tl.TablaLogicaId = 148 and fc.TablaLogicaDatosId = tl.TablaLogicaDatosId
	WHERE fb.Estado = 1
END

GO
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO
CREATE PROC [dbo].[BuscadorFiltros_Lista]
AS
BEGIN
	SELECT fc.TablaLogicaDatosId, tl.valor FiltroSeccion, fc.CampoES, fc.TipoOperadorES, fb.idFiltroBuscador,
		fb.Nombre FiltroNombre, fb.Descripcion Codigo, isnull(fb.ValorMinimo, 0) ValorMinimo,
		isnull(fb.ValorMaximo, 0) ValorMaximo FROM filtroSeccion fc
	INNER JOIN filtrobuscador fb on fc.TablaLogicaDatosId = fb.TablaLogicaDatosId
	INNER JOIN tablalogicadatos tl on tl.TablaLogicaId = 148 and fc.TablaLogicaDatosId = tl.TablaLogicaDatosId
	WHERE fb.Estado = 1
END

GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO
CREATE PROC [dbo].[BuscadorFiltros_Lista]
AS
BEGIN
	SELECT fc.TablaLogicaDatosId, tl.valor FiltroSeccion, fc.CampoES, fc.TipoOperadorES, fb.idFiltroBuscador,
		fb.Nombre FiltroNombre, fb.Descripcion Codigo, isnull(fb.ValorMinimo, 0) ValorMinimo,
		isnull(fb.ValorMaximo, 0) ValorMaximo FROM filtroSeccion fc
	INNER JOIN filtrobuscador fb on fc.TablaLogicaDatosId = fb.TablaLogicaDatosId
	INNER JOIN tablalogicadatos tl on tl.TablaLogicaId = 148 and fc.TablaLogicaDatosId = tl.TablaLogicaDatosId
	WHERE fb.Estado = 1
END

GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO
CREATE PROC [dbo].[BuscadorFiltros_Lista]
AS
BEGIN
	SELECT fc.TablaLogicaDatosId, tl.valor FiltroSeccion, fc.CampoES, fc.TipoOperadorES, fb.idFiltroBuscador,
		fb.Nombre FiltroNombre, fb.Descripcion Codigo, isnull(fb.ValorMinimo, 0) ValorMinimo,
		isnull(fb.ValorMaximo, 0) ValorMaximo FROM filtroSeccion fc
	INNER JOIN filtrobuscador fb on fc.TablaLogicaDatosId = fb.TablaLogicaDatosId
	INNER JOIN tablalogicadatos tl on tl.TablaLogicaId = 148 and fc.TablaLogicaDatosId = tl.TablaLogicaDatosId
	WHERE fb.Estado = 1
END

GO
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO
CREATE PROC [dbo].[BuscadorFiltros_Lista]
AS
BEGIN
	SELECT fc.TablaLogicaDatosId, tl.valor FiltroSeccion, fc.CampoES, fc.TipoOperadorES, fb.idFiltroBuscador,
		fb.Nombre FiltroNombre, fb.Descripcion Codigo, isnull(fb.ValorMinimo, 0) ValorMinimo,
		isnull(fb.ValorMaximo, 0) ValorMaximo FROM filtroSeccion fc
	INNER JOIN filtrobuscador fb on fc.TablaLogicaDatosId = fb.TablaLogicaDatosId
	INNER JOIN tablalogicadatos tl on tl.TablaLogicaId = 148 and fc.TablaLogicaDatosId = tl.TablaLogicaDatosId
	WHERE fb.Estado = 1
END

GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO
CREATE PROC [dbo].[BuscadorFiltros_Lista]
AS
BEGIN
	SELECT fc.TablaLogicaDatosId, tl.valor FiltroSeccion, fc.CampoES, fc.TipoOperadorES, fb.idFiltroBuscador,
		fb.Nombre FiltroNombre, fb.Descripcion Codigo, isnull(fb.ValorMinimo, 0) ValorMinimo,
		isnull(fb.ValorMaximo, 0) ValorMaximo FROM filtroSeccion fc
	INNER JOIN filtrobuscador fb on fc.TablaLogicaDatosId = fb.TablaLogicaDatosId
	INNER JOIN tablalogicadatos tl on tl.TablaLogicaId = 148 and fc.TablaLogicaDatosId = tl.TablaLogicaDatosId
	WHERE fb.Estado = 1
END

GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO
CREATE PROC [dbo].[BuscadorFiltros_Lista]
AS
BEGIN
	SELECT fc.TablaLogicaDatosId, tl.valor FiltroSeccion, fc.CampoES, fc.TipoOperadorES, fb.idFiltroBuscador,
		fb.Nombre FiltroNombre, fb.Descripcion Codigo, isnull(fb.ValorMinimo, 0) ValorMinimo,
		isnull(fb.ValorMaximo, 0) ValorMaximo FROM filtroSeccion fc
	INNER JOIN filtrobuscador fb on fc.TablaLogicaDatosId = fb.TablaLogicaDatosId
	INNER JOIN tablalogicadatos tl on tl.TablaLogicaId = 148 and fc.TablaLogicaDatosId = tl.TablaLogicaDatosId
	WHERE fb.Estado = 1
END

GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO
CREATE PROC [dbo].[BuscadorFiltros_Lista]
AS
BEGIN
	SELECT fc.TablaLogicaDatosId, tl.valor FiltroSeccion, fc.CampoES, fc.TipoOperadorES, fb.idFiltroBuscador,
		fb.Nombre FiltroNombre, fb.Descripcion Codigo, isnull(fb.ValorMinimo, 0) ValorMinimo,
		isnull(fb.ValorMaximo, 0) ValorMaximo FROM filtroSeccion fc
	INNER JOIN filtrobuscador fb on fc.TablaLogicaDatosId = fb.TablaLogicaDatosId
	INNER JOIN tablalogicadatos tl on tl.TablaLogicaId = 148 and fc.TablaLogicaDatosId = tl.TablaLogicaDatosId
	WHERE fb.Estado = 1
END

GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO
CREATE PROC [dbo].[BuscadorFiltros_Lista]
AS
BEGIN
	SELECT fc.TablaLogicaDatosId, tl.valor FiltroSeccion, fc.CampoES, fc.TipoOperadorES, fb.idFiltroBuscador,
		fb.Nombre FiltroNombre, fb.Descripcion Codigo, isnull(fb.ValorMinimo, 0) ValorMinimo,
		isnull(fb.ValorMaximo, 0) ValorMaximo FROM filtroSeccion fc
	INNER JOIN filtrobuscador fb on fc.TablaLogicaDatosId = fb.TablaLogicaDatosId
	INNER JOIN tablalogicadatos tl on tl.TablaLogicaId = 148 and fc.TablaLogicaDatosId = tl.TablaLogicaDatosId
	WHERE fb.Estado = 1
END

GO
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO
CREATE PROC [dbo].[BuscadorFiltros_Lista]
AS
BEGIN
	SELECT fc.TablaLogicaDatosId, tl.valor FiltroSeccion, fc.CampoES, fc.TipoOperadorES, fb.idFiltroBuscador,
		fb.Nombre FiltroNombre, fb.Descripcion Codigo, isnull(fb.ValorMinimo, 0) ValorMinimo,
		isnull(fb.ValorMaximo, 0) ValorMaximo FROM filtroSeccion fc
	INNER JOIN filtrobuscador fb on fc.TablaLogicaDatosId = fb.TablaLogicaDatosId
	INNER JOIN tablalogicadatos tl on tl.TablaLogicaId = 148 and fc.TablaLogicaDatosId = tl.TablaLogicaDatosId
	WHERE fb.Estado = 1
END

GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BuscadorFiltros_Lista]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[BuscadorFiltros_Lista]
GO
CREATE PROC [dbo].[BuscadorFiltros_Lista]
AS
BEGIN
	SELECT fc.TablaLogicaDatosId, tl.valor FiltroSeccion, fc.CampoES, fc.TipoOperadorES, fb.idFiltroBuscador,
		fb.Nombre FiltroNombre, fb.Descripcion Codigo, isnull(fb.ValorMinimo, 0) ValorMinimo,
		isnull(fb.ValorMaximo, 0) ValorMaximo FROM filtroSeccion fc
	INNER JOIN filtrobuscador fb on fc.TablaLogicaDatosId = fb.TablaLogicaDatosId
	INNER JOIN tablalogicadatos tl on tl.TablaLogicaId = 148 and fc.TablaLogicaDatosId = tl.TablaLogicaDatosId
	WHERE fb.Estado = 1
END

GO
