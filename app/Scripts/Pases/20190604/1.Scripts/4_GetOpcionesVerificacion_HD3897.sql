USE BelcorpPeru
GO
ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
		,IsNull(OpcionConfirmarEmail, 0) as OpcionConfirmarEmail -- /* HD-3897 */
		,IsNull(OpcionConfirmarSms, 0) as OpcionConfirmarSms -- /* HD-3897 */
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END


GO
USE BelcorpMexico
GO
ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
		,IsNull(OpcionConfirmarEmail, 0) as OpcionConfirmarEmail -- /* HD-3897 */
		,IsNull(OpcionConfirmarSms, 0) as OpcionConfirmarSms -- /* HD-3897 */
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END


GO
USE BelcorpColombia
GO
ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
		,IsNull(OpcionConfirmarEmail, 0) as OpcionConfirmarEmail -- /* HD-3897 */
		,IsNull(OpcionConfirmarSms, 0) as OpcionConfirmarSms -- /* HD-3897 */
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END


GO
USE BelcorpSalvador
GO
ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
		,IsNull(OpcionConfirmarEmail, 0) as OpcionConfirmarEmail -- /* HD-3897 */
		,IsNull(OpcionConfirmarSms, 0) as OpcionConfirmarSms -- /* HD-3897 */
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END


GO
USE BelcorpPuertoRico
GO
ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
		,IsNull(OpcionConfirmarEmail, 0) as OpcionConfirmarEmail -- /* HD-3897 */
		,IsNull(OpcionConfirmarSms, 0) as OpcionConfirmarSms -- /* HD-3897 */
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END


GO
USE BelcorpPanama
GO
ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
		,IsNull(OpcionConfirmarEmail, 0) as OpcionConfirmarEmail -- /* HD-3897 */
		,IsNull(OpcionConfirmarSms, 0) as OpcionConfirmarSms -- /* HD-3897 */
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END


GO
USE BelcorpGuatemala
GO
ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
		,IsNull(OpcionConfirmarEmail, 0) as OpcionConfirmarEmail -- /* HD-3897 */
		,IsNull(OpcionConfirmarSms, 0) as OpcionConfirmarSms -- /* HD-3897 */
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END


GO
USE BelcorpEcuador
GO
ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
		,IsNull(OpcionConfirmarEmail, 0) as OpcionConfirmarEmail -- /* HD-3897 */
		,IsNull(OpcionConfirmarSms, 0) as OpcionConfirmarSms -- /* HD-3897 */
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END


GO
USE BelcorpDominicana
GO
ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
		,IsNull(OpcionConfirmarEmail, 0) as OpcionConfirmarEmail -- /* HD-3897 */
		,IsNull(OpcionConfirmarSms, 0) as OpcionConfirmarSms -- /* HD-3897 */
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END


GO
USE BelcorpCostaRica
GO
ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
		,IsNull(OpcionConfirmarEmail, 0) as OpcionConfirmarEmail -- /* HD-3897 */
		,IsNull(OpcionConfirmarSms, 0) as OpcionConfirmarSms -- /* HD-3897 */
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END


GO
USE BelcorpChile
GO
ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
		,IsNull(OpcionConfirmarEmail, 0) as OpcionConfirmarEmail -- /* HD-3897 */
		,IsNull(OpcionConfirmarSms, 0) as OpcionConfirmarSms -- /* HD-3897 */
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END


GO
USE BelcorpBolivia
GO
ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
		,IsNull(OpcionConfirmarEmail, 0) as OpcionConfirmarEmail -- /* HD-3897 */
		,IsNull(OpcionConfirmarSms, 0) as OpcionConfirmarSms -- /* HD-3897 */
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END


GO
