GO
USE BelcorpPeru
GO
BEGIN

	/*** Agregar "Reporte de Encuesta Satisfacción" en Permiso ***/
	IF NOT EXISTS(SELECT 1 FROM Permiso P WHERE P.Codigo='ReporteEncSatisfaccion')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX(PERMISOID)) FROM Permiso)+1
			INSERT INTO [dbo].[Permiso]
			([PermisoID]
			,[Descripcion]
			,[IdPadre]
			,[OrdenItem]
			,[UrlItem]
			,[PaginaNueva]
			,[Posicion]
			,[UrlImagen]
			,[EsSoloImagen]
			,[EsMenuEspecial]
			,[EsServicios]
			,[EsPrincipal]
			,[Codigo])
			VALUES(@ID,
			'Reporte de Encuesta Satisfacción',
			81,
			115,
			'ReporteEncuestaSatisfaccion/Index',
			0,
			'Header',
			'',
			0,
			0,
			0,
			1,
			'ReporteEncSatisfaccion')

	END

END

GO
USE BelcorpMexico
GO
BEGIN

	/*** Agregar "Reporte de Encuesta Satisfacción" en Permiso ***/
	IF NOT EXISTS(SELECT 1 FROM Permiso P WHERE P.Codigo='ReporteEncSatisfaccion')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX(PERMISOID)) FROM Permiso)+1
			INSERT INTO [dbo].[Permiso]
			([PermisoID]
			,[Descripcion]
			,[IdPadre]
			,[OrdenItem]
			,[UrlItem]
			,[PaginaNueva]
			,[Posicion]
			,[UrlImagen]
			,[EsSoloImagen]
			,[EsMenuEspecial]
			,[EsServicios]
			,[EsPrincipal]
			,[Codigo])
			VALUES(@ID,
			'Reporte de Encuesta Satisfacción',
			81,
			115,
			'ReporteEncuestaSatisfaccion/Index',
			0,
			'Header',
			'',
			0,
			0,
			0,
			1,
			'ReporteEncSatisfaccion')

	END

END

GO
USE BelcorpColombia
GO
BEGIN

	/*** Agregar "Reporte de Encuesta Satisfacción" en Permiso ***/
	IF NOT EXISTS(SELECT 1 FROM Permiso P WHERE P.Codigo='ReporteEncSatisfaccion')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX(PERMISOID)) FROM Permiso)+1
			INSERT INTO [dbo].[Permiso]
			([PermisoID]
			,[Descripcion]
			,[IdPadre]
			,[OrdenItem]
			,[UrlItem]
			,[PaginaNueva]
			,[Posicion]
			,[UrlImagen]
			,[EsSoloImagen]
			,[EsMenuEspecial]
			,[EsServicios]
			,[EsPrincipal]
			,[Codigo])
			VALUES(@ID,
			'Reporte de Encuesta Satisfacción',
			81,
			115,
			'ReporteEncuestaSatisfaccion/Index',
			0,
			'Header',
			'',
			0,
			0,
			0,
			1,
			'ReporteEncSatisfaccion')

	END

END

GO
USE BelcorpSalvador
GO
BEGIN

	/*** Agregar "Reporte de Encuesta Satisfacción" en Permiso ***/
	IF NOT EXISTS(SELECT 1 FROM Permiso P WHERE P.Codigo='ReporteEncSatisfaccion')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX(PERMISOID)) FROM Permiso)+1
			INSERT INTO [dbo].[Permiso]
			([PermisoID]
			,[Descripcion]
			,[IdPadre]
			,[OrdenItem]
			,[UrlItem]
			,[PaginaNueva]
			,[Posicion]
			,[UrlImagen]
			,[EsSoloImagen]
			,[EsMenuEspecial]
			,[EsServicios]
			,[EsPrincipal]
			,[Codigo])
			VALUES(@ID,
			'Reporte de Encuesta Satisfacción',
			81,
			115,
			'ReporteEncuestaSatisfaccion/Index',
			0,
			'Header',
			'',
			0,
			0,
			0,
			1,
			'ReporteEncSatisfaccion')

	END

END

GO
USE BelcorpPuertoRico
GO
BEGIN

	/*** Agregar "Reporte de Encuesta Satisfacción" en Permiso ***/
	IF NOT EXISTS(SELECT 1 FROM Permiso P WHERE P.Codigo='ReporteEncSatisfaccion')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX(PERMISOID)) FROM Permiso)+1
			INSERT INTO [dbo].[Permiso]
			([PermisoID]
			,[Descripcion]
			,[IdPadre]
			,[OrdenItem]
			,[UrlItem]
			,[PaginaNueva]
			,[Posicion]
			,[UrlImagen]
			,[EsSoloImagen]
			,[EsMenuEspecial]
			,[EsServicios]
			,[EsPrincipal]
			,[Codigo])
			VALUES(@ID,
			'Reporte de Encuesta Satisfacción',
			81,
			115,
			'ReporteEncuestaSatisfaccion/Index',
			0,
			'Header',
			'',
			0,
			0,
			0,
			1,
			'ReporteEncSatisfaccion')

	END

END

GO
USE BelcorpPanama
GO
BEGIN

	/*** Agregar "Reporte de Encuesta Satisfacción" en Permiso ***/
	IF NOT EXISTS(SELECT 1 FROM Permiso P WHERE P.Codigo='ReporteEncSatisfaccion')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX(PERMISOID)) FROM Permiso)+1
			INSERT INTO [dbo].[Permiso]
			([PermisoID]
			,[Descripcion]
			,[IdPadre]
			,[OrdenItem]
			,[UrlItem]
			,[PaginaNueva]
			,[Posicion]
			,[UrlImagen]
			,[EsSoloImagen]
			,[EsMenuEspecial]
			,[EsServicios]
			,[EsPrincipal]
			,[Codigo])
			VALUES(@ID,
			'Reporte de Encuesta Satisfacción',
			81,
			115,
			'ReporteEncuestaSatisfaccion/Index',
			0,
			'Header',
			'',
			0,
			0,
			0,
			1,
			'ReporteEncSatisfaccion')

	END

END

GO
USE BelcorpGuatemala
GO
BEGIN

	/*** Agregar "Reporte de Encuesta Satisfacción" en Permiso ***/
	IF NOT EXISTS(SELECT 1 FROM Permiso P WHERE P.Codigo='ReporteEncSatisfaccion')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX(PERMISOID)) FROM Permiso)+1
			INSERT INTO [dbo].[Permiso]
			([PermisoID]
			,[Descripcion]
			,[IdPadre]
			,[OrdenItem]
			,[UrlItem]
			,[PaginaNueva]
			,[Posicion]
			,[UrlImagen]
			,[EsSoloImagen]
			,[EsMenuEspecial]
			,[EsServicios]
			,[EsPrincipal]
			,[Codigo])
			VALUES(@ID,
			'Reporte de Encuesta Satisfacción',
			81,
			115,
			'ReporteEncuestaSatisfaccion/Index',
			0,
			'Header',
			'',
			0,
			0,
			0,
			1,
			'ReporteEncSatisfaccion')

	END

END

GO
USE BelcorpEcuador
GO
BEGIN

	/*** Agregar "Reporte de Encuesta Satisfacción" en Permiso ***/
	IF NOT EXISTS(SELECT 1 FROM Permiso P WHERE P.Codigo='ReporteEncSatisfaccion')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX(PERMISOID)) FROM Permiso)+1
			INSERT INTO [dbo].[Permiso]
			([PermisoID]
			,[Descripcion]
			,[IdPadre]
			,[OrdenItem]
			,[UrlItem]
			,[PaginaNueva]
			,[Posicion]
			,[UrlImagen]
			,[EsSoloImagen]
			,[EsMenuEspecial]
			,[EsServicios]
			,[EsPrincipal]
			,[Codigo])
			VALUES(@ID,
			'Reporte de Encuesta Satisfacción',
			81,
			115,
			'ReporteEncuestaSatisfaccion/Index',
			0,
			'Header',
			'',
			0,
			0,
			0,
			1,
			'ReporteEncSatisfaccion')

	END

END

GO
USE BelcorpDominicana
GO
BEGIN

	/*** Agregar "Reporte de Encuesta Satisfacción" en Permiso ***/
	IF NOT EXISTS(SELECT 1 FROM Permiso P WHERE P.Codigo='ReporteEncSatisfaccion')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX(PERMISOID)) FROM Permiso)+1
			INSERT INTO [dbo].[Permiso]
			([PermisoID]
			,[Descripcion]
			,[IdPadre]
			,[OrdenItem]
			,[UrlItem]
			,[PaginaNueva]
			,[Posicion]
			,[UrlImagen]
			,[EsSoloImagen]
			,[EsMenuEspecial]
			,[EsServicios]
			,[EsPrincipal]
			,[Codigo])
			VALUES(@ID,
			'Reporte de Encuesta Satisfacción',
			81,
			115,
			'ReporteEncuestaSatisfaccion/Index',
			0,
			'Header',
			'',
			0,
			0,
			0,
			1,
			'ReporteEncSatisfaccion')

	END

END

GO
USE BelcorpCostaRica
GO
BEGIN

	/*** Agregar "Reporte de Encuesta Satisfacción" en Permiso ***/
	IF NOT EXISTS(SELECT 1 FROM Permiso P WHERE P.Codigo='ReporteEncSatisfaccion')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX(PERMISOID)) FROM Permiso)+1
			INSERT INTO [dbo].[Permiso]
			([PermisoID]
			,[Descripcion]
			,[IdPadre]
			,[OrdenItem]
			,[UrlItem]
			,[PaginaNueva]
			,[Posicion]
			,[UrlImagen]
			,[EsSoloImagen]
			,[EsMenuEspecial]
			,[EsServicios]
			,[EsPrincipal]
			,[Codigo])
			VALUES(@ID,
			'Reporte de Encuesta Satisfacción',
			81,
			115,
			'ReporteEncuestaSatisfaccion/Index',
			0,
			'Header',
			'',
			0,
			0,
			0,
			1,
			'ReporteEncSatisfaccion')

	END

END

GO
USE BelcorpChile
GO
BEGIN

	/*** Agregar "Reporte de Encuesta Satisfacción" en Permiso ***/
	IF NOT EXISTS(SELECT 1 FROM Permiso P WHERE P.Codigo='ReporteEncSatisfaccion')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX(PERMISOID)) FROM Permiso)+1
			INSERT INTO [dbo].[Permiso]
			([PermisoID]
			,[Descripcion]
			,[IdPadre]
			,[OrdenItem]
			,[UrlItem]
			,[PaginaNueva]
			,[Posicion]
			,[UrlImagen]
			,[EsSoloImagen]
			,[EsMenuEspecial]
			,[EsServicios]
			,[EsPrincipal]
			,[Codigo])
			VALUES(@ID,
			'Reporte de Encuesta Satisfacción',
			81,
			115,
			'ReporteEncuestaSatisfaccion/Index',
			0,
			'Header',
			'',
			0,
			0,
			0,
			1,
			'ReporteEncSatisfaccion')

	END

END

GO
USE BelcorpBolivia
GO
BEGIN

	/*** Agregar "Reporte de Encuesta Satisfacción" en Permiso ***/
	IF NOT EXISTS(SELECT 1 FROM Permiso P WHERE P.Codigo='ReporteEncSatisfaccion')
	BEGIN
			DECLARE @ID INT=(SELECT (MAX(PERMISOID)) FROM Permiso)+1
			INSERT INTO [dbo].[Permiso]
			([PermisoID]
			,[Descripcion]
			,[IdPadre]
			,[OrdenItem]
			,[UrlItem]
			,[PaginaNueva]
			,[Posicion]
			,[UrlImagen]
			,[EsSoloImagen]
			,[EsMenuEspecial]
			,[EsServicios]
			,[EsPrincipal]
			,[Codigo])
			VALUES(@ID,
			'Reporte de Encuesta Satisfacción',
			81,
			115,
			'ReporteEncuestaSatisfaccion/Index',
			0,
			'Header',
			'',
			0,
			0,
			0,
			1,
			'ReporteEncSatisfaccion')

	END

END

GO
