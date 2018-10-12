USE BelcorpPeru
GO

/* UpdCodigoGenerado */
IF (OBJECT_ID('UpdCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[UpdCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[UpdCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CantidadEnvios int,
	@OpcionDesabilitado bit )
AS
BEGIN	
	UPDATE [dbo].[CodigoGenerado]
	SET CantidadEnvios = @CantidadEnvios,
		OpcionDesabilitado = @OpcionDesabilitado
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpMexico
GO

/* UpdCodigoGenerado */
IF (OBJECT_ID('UpdCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[UpdCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[UpdCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CantidadEnvios int,
	@OpcionDesabilitado bit )
AS
BEGIN	
	UPDATE [dbo].[CodigoGenerado]
	SET CantidadEnvios = @CantidadEnvios,
		OpcionDesabilitado = @OpcionDesabilitado
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpColombia
GO

/* UpdCodigoGenerado */
IF (OBJECT_ID('UpdCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[UpdCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[UpdCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CantidadEnvios int,
	@OpcionDesabilitado bit )
AS
BEGIN	
	UPDATE [dbo].[CodigoGenerado]
	SET CantidadEnvios = @CantidadEnvios,
		OpcionDesabilitado = @OpcionDesabilitado
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpSalvador
GO

/* UpdCodigoGenerado */
IF (OBJECT_ID('UpdCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[UpdCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[UpdCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CantidadEnvios int,
	@OpcionDesabilitado bit )
AS
BEGIN	
	UPDATE [dbo].[CodigoGenerado]
	SET CantidadEnvios = @CantidadEnvios,
		OpcionDesabilitado = @OpcionDesabilitado
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpPuertoRico
GO

/* UpdCodigoGenerado */
IF (OBJECT_ID('UpdCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[UpdCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[UpdCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CantidadEnvios int,
	@OpcionDesabilitado bit )
AS
BEGIN	
	UPDATE [dbo].[CodigoGenerado]
	SET CantidadEnvios = @CantidadEnvios,
		OpcionDesabilitado = @OpcionDesabilitado
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpPanama
GO

/* UpdCodigoGenerado */
IF (OBJECT_ID('UpdCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[UpdCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[UpdCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CantidadEnvios int,
	@OpcionDesabilitado bit )
AS
BEGIN	
	UPDATE [dbo].[CodigoGenerado]
	SET CantidadEnvios = @CantidadEnvios,
		OpcionDesabilitado = @OpcionDesabilitado
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpGuatemala
GO

/* UpdCodigoGenerado */
IF (OBJECT_ID('UpdCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[UpdCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[UpdCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CantidadEnvios int,
	@OpcionDesabilitado bit )
AS
BEGIN	
	UPDATE [dbo].[CodigoGenerado]
	SET CantidadEnvios = @CantidadEnvios,
		OpcionDesabilitado = @OpcionDesabilitado
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpEcuador
GO

/* UpdCodigoGenerado */
IF (OBJECT_ID('UpdCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[UpdCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[UpdCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CantidadEnvios int,
	@OpcionDesabilitado bit )
AS
BEGIN	
	UPDATE [dbo].[CodigoGenerado]
	SET CantidadEnvios = @CantidadEnvios,
		OpcionDesabilitado = @OpcionDesabilitado
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpDominicana
GO

/* UpdCodigoGenerado */
IF (OBJECT_ID('UpdCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[UpdCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[UpdCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CantidadEnvios int,
	@OpcionDesabilitado bit )
AS
BEGIN	
	UPDATE [dbo].[CodigoGenerado]
	SET CantidadEnvios = @CantidadEnvios,
		OpcionDesabilitado = @OpcionDesabilitado
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpCostaRica
GO

/* UpdCodigoGenerado */
IF (OBJECT_ID('UpdCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[UpdCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[UpdCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CantidadEnvios int,
	@OpcionDesabilitado bit )
AS
BEGIN	
	UPDATE [dbo].[CodigoGenerado]
	SET CantidadEnvios = @CantidadEnvios,
		OpcionDesabilitado = @OpcionDesabilitado
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpChile
GO

/* UpdCodigoGenerado */
IF (OBJECT_ID('UpdCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[UpdCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[UpdCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CantidadEnvios int,
	@OpcionDesabilitado bit )
AS
BEGIN	
	UPDATE [dbo].[CodigoGenerado]
	SET CantidadEnvios = @CantidadEnvios,
		OpcionDesabilitado = @OpcionDesabilitado
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpBolivia
GO

/* UpdCodigoGenerado */
IF (OBJECT_ID('UpdCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[UpdCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[UpdCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CantidadEnvios int,
	@OpcionDesabilitado bit )
AS
BEGIN	
	UPDATE [dbo].[CodigoGenerado]
	SET CantidadEnvios = @CantidadEnvios,
		OpcionDesabilitado = @OpcionDesabilitado
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

