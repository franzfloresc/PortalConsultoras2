GO
USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizaNovedadBuscador]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ActualizaNovedadBuscador]
GO

CREATE PROC [dbo].[ActualizaNovedadBuscador](
	@usuario VARCHAR(20)
)
AS
BEGIN
	UPDATE usuario SET NovedadBuscador = isnull(NovedadBuscador, 0) + 1 WHERE CodigoUsuario = @usuario
END

GO
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizaNovedadBuscador]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ActualizaNovedadBuscador]
GO

CREATE PROC [dbo].[ActualizaNovedadBuscador](
	@usuario VARCHAR(20)
)
AS
BEGIN
	UPDATE usuario SET NovedadBuscador = isnull(NovedadBuscador, 0) + 1 WHERE CodigoUsuario = @usuario
END

GO
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizaNovedadBuscador]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ActualizaNovedadBuscador]
GO

CREATE PROC [dbo].[ActualizaNovedadBuscador](
	@usuario VARCHAR(20)
)
AS
BEGIN
	UPDATE usuario SET NovedadBuscador = isnull(NovedadBuscador, 0) + 1 WHERE CodigoUsuario = @usuario
END

GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizaNovedadBuscador]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ActualizaNovedadBuscador]
GO

CREATE PROC [dbo].[ActualizaNovedadBuscador](
	@usuario VARCHAR(20)
)
AS
BEGIN
	UPDATE usuario SET NovedadBuscador = isnull(NovedadBuscador, 0) + 1 WHERE CodigoUsuario = @usuario
END

GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizaNovedadBuscador]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ActualizaNovedadBuscador]
GO

CREATE PROC [dbo].[ActualizaNovedadBuscador](
	@usuario VARCHAR(20)
)
AS
BEGIN
	UPDATE usuario SET NovedadBuscador = isnull(NovedadBuscador, 0) + 1 WHERE CodigoUsuario = @usuario
END

GO
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizaNovedadBuscador]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ActualizaNovedadBuscador]
GO

CREATE PROC [dbo].[ActualizaNovedadBuscador](
	@usuario VARCHAR(20)
)
AS
BEGIN
	UPDATE usuario SET NovedadBuscador = isnull(NovedadBuscador, 0) + 1 WHERE CodigoUsuario = @usuario
END

GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizaNovedadBuscador]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ActualizaNovedadBuscador]
GO

CREATE PROC [dbo].[ActualizaNovedadBuscador](
	@usuario VARCHAR(20)
)
AS
BEGIN
	UPDATE usuario SET NovedadBuscador = isnull(NovedadBuscador, 0) + 1 WHERE CodigoUsuario = @usuario
END

GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizaNovedadBuscador]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ActualizaNovedadBuscador]
GO

CREATE PROC [dbo].[ActualizaNovedadBuscador](
	@usuario VARCHAR(20)
)
AS
BEGIN
	UPDATE usuario SET NovedadBuscador = isnull(NovedadBuscador, 0) + 1 WHERE CodigoUsuario = @usuario
END

GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizaNovedadBuscador]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ActualizaNovedadBuscador]
GO

CREATE PROC [dbo].[ActualizaNovedadBuscador](
	@usuario VARCHAR(20)
)
AS
BEGIN
	UPDATE usuario SET NovedadBuscador = isnull(NovedadBuscador, 0) + 1 WHERE CodigoUsuario = @usuario
END

GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizaNovedadBuscador]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ActualizaNovedadBuscador]
GO

CREATE PROC [dbo].[ActualizaNovedadBuscador](
	@usuario VARCHAR(20)
)
AS
BEGIN
	UPDATE usuario SET NovedadBuscador = isnull(NovedadBuscador, 0) + 1 WHERE CodigoUsuario = @usuario
END

GO
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizaNovedadBuscador]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ActualizaNovedadBuscador]
GO

CREATE PROC [dbo].[ActualizaNovedadBuscador](
	@usuario VARCHAR(20)
)
AS
BEGIN
	UPDATE usuario SET NovedadBuscador = isnull(NovedadBuscador, 0) + 1 WHERE CodigoUsuario = @usuario
END

GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActualizaNovedadBuscador]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ActualizaNovedadBuscador]
GO

CREATE PROC [dbo].[ActualizaNovedadBuscador](
	@usuario VARCHAR(20)
)
AS
BEGIN
	UPDATE usuario SET NovedadBuscador = isnull(NovedadBuscador, 0) + 1 WHERE CodigoUsuario = @usuario
END

GO
