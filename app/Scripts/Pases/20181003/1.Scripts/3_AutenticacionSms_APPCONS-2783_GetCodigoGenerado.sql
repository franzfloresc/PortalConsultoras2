USE BelcorpPeru
GO

/* GetCodigoGenerado */
IF (OBJECT_ID('GetCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[GetCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int )
AS
BEGIN	
	SELECT 
		CodigoGeneradoID AS CodigoGeneradoID
		,OrigenID AS OrigenID
		,CodigoUsuario  AS CodigoUsuario
		,OrigenDescripcion AS OrigenDescripcion
		,TipoEnvio AS TipoEnvio
		,CodigoGenerado AS CodigoGenerado
		,IsNull(OpcionDesabilitado, 0) AS OpcionDesabilitado
		,IsNull(FechaRegistro, GETDATE() ) AS FechaRegistro
		,GETDATE() AS FechaActual
		,CantidadEnvios AS CantidadEnvios
	FROM [dbo].[CodigoGenerado]
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpMexico
GO

/* GetCodigoGenerado */
IF (OBJECT_ID('GetCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[GetCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int )
AS
BEGIN	
	SELECT 
		CodigoGeneradoID AS CodigoGeneradoID
		,OrigenID AS OrigenID
		,CodigoUsuario  AS CodigoUsuario
		,OrigenDescripcion AS OrigenDescripcion
		,TipoEnvio AS TipoEnvio
		,CodigoGenerado AS CodigoGenerado
		,IsNull(OpcionDesabilitado, 0) AS OpcionDesabilitado
		,IsNull(FechaRegistro, GETDATE() ) AS FechaRegistro
		,GETDATE() AS FechaActual
		,CantidadEnvios AS CantidadEnvios
	FROM [dbo].[CodigoGenerado]
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpColombia
GO

/* GetCodigoGenerado */
IF (OBJECT_ID('GetCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[GetCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int )
AS
BEGIN	
	SELECT 
		CodigoGeneradoID AS CodigoGeneradoID
		,OrigenID AS OrigenID
		,CodigoUsuario  AS CodigoUsuario
		,OrigenDescripcion AS OrigenDescripcion
		,TipoEnvio AS TipoEnvio
		,CodigoGenerado AS CodigoGenerado
		,IsNull(OpcionDesabilitado, 0) AS OpcionDesabilitado
		,IsNull(FechaRegistro, GETDATE() ) AS FechaRegistro
		,GETDATE() AS FechaActual
		,CantidadEnvios AS CantidadEnvios
	FROM [dbo].[CodigoGenerado]
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpSalvador
GO

/* GetCodigoGenerado */
IF (OBJECT_ID('GetCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[GetCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int )
AS
BEGIN	
	SELECT 
		CodigoGeneradoID AS CodigoGeneradoID
		,OrigenID AS OrigenID
		,CodigoUsuario  AS CodigoUsuario
		,OrigenDescripcion AS OrigenDescripcion
		,TipoEnvio AS TipoEnvio
		,CodigoGenerado AS CodigoGenerado
		,IsNull(OpcionDesabilitado, 0) AS OpcionDesabilitado
		,IsNull(FechaRegistro, GETDATE() ) AS FechaRegistro
		,GETDATE() AS FechaActual
		,CantidadEnvios AS CantidadEnvios
	FROM [dbo].[CodigoGenerado]
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpPuertoRico
GO

/* GetCodigoGenerado */
IF (OBJECT_ID('GetCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[GetCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int )
AS
BEGIN	
	SELECT 
		CodigoGeneradoID AS CodigoGeneradoID
		,OrigenID AS OrigenID
		,CodigoUsuario  AS CodigoUsuario
		,OrigenDescripcion AS OrigenDescripcion
		,TipoEnvio AS TipoEnvio
		,CodigoGenerado AS CodigoGenerado
		,IsNull(OpcionDesabilitado, 0) AS OpcionDesabilitado
		,IsNull(FechaRegistro, GETDATE() ) AS FechaRegistro
		,GETDATE() AS FechaActual
		,CantidadEnvios AS CantidadEnvios
	FROM [dbo].[CodigoGenerado]
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpPanama
GO

/* GetCodigoGenerado */
IF (OBJECT_ID('GetCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[GetCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int )
AS
BEGIN	
	SELECT 
		CodigoGeneradoID AS CodigoGeneradoID
		,OrigenID AS OrigenID
		,CodigoUsuario  AS CodigoUsuario
		,OrigenDescripcion AS OrigenDescripcion
		,TipoEnvio AS TipoEnvio
		,CodigoGenerado AS CodigoGenerado
		,IsNull(OpcionDesabilitado, 0) AS OpcionDesabilitado
		,IsNull(FechaRegistro, GETDATE() ) AS FechaRegistro
		,GETDATE() AS FechaActual
		,CantidadEnvios AS CantidadEnvios
	FROM [dbo].[CodigoGenerado]
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpGuatemala
GO

/* GetCodigoGenerado */
IF (OBJECT_ID('GetCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[GetCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int )
AS
BEGIN	
	SELECT 
		CodigoGeneradoID AS CodigoGeneradoID
		,OrigenID AS OrigenID
		,CodigoUsuario  AS CodigoUsuario
		,OrigenDescripcion AS OrigenDescripcion
		,TipoEnvio AS TipoEnvio
		,CodigoGenerado AS CodigoGenerado
		,IsNull(OpcionDesabilitado, 0) AS OpcionDesabilitado
		,IsNull(FechaRegistro, GETDATE() ) AS FechaRegistro
		,GETDATE() AS FechaActual
		,CantidadEnvios AS CantidadEnvios
	FROM [dbo].[CodigoGenerado]
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpEcuador
GO

/* GetCodigoGenerado */
IF (OBJECT_ID('GetCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[GetCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int )
AS
BEGIN	
	SELECT 
		CodigoGeneradoID AS CodigoGeneradoID
		,OrigenID AS OrigenID
		,CodigoUsuario  AS CodigoUsuario
		,OrigenDescripcion AS OrigenDescripcion
		,TipoEnvio AS TipoEnvio
		,CodigoGenerado AS CodigoGenerado
		,IsNull(OpcionDesabilitado, 0) AS OpcionDesabilitado
		,IsNull(FechaRegistro, GETDATE() ) AS FechaRegistro
		,GETDATE() AS FechaActual
		,CantidadEnvios AS CantidadEnvios
	FROM [dbo].[CodigoGenerado]
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpDominicana
GO

/* GetCodigoGenerado */
IF (OBJECT_ID('GetCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[GetCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int )
AS
BEGIN	
	SELECT 
		CodigoGeneradoID AS CodigoGeneradoID
		,OrigenID AS OrigenID
		,CodigoUsuario  AS CodigoUsuario
		,OrigenDescripcion AS OrigenDescripcion
		,TipoEnvio AS TipoEnvio
		,CodigoGenerado AS CodigoGenerado
		,IsNull(OpcionDesabilitado, 0) AS OpcionDesabilitado
		,IsNull(FechaRegistro, GETDATE() ) AS FechaRegistro
		,GETDATE() AS FechaActual
		,CantidadEnvios AS CantidadEnvios
	FROM [dbo].[CodigoGenerado]
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpCostaRica
GO

/* GetCodigoGenerado */
IF (OBJECT_ID('GetCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[GetCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int )
AS
BEGIN	
	SELECT 
		CodigoGeneradoID AS CodigoGeneradoID
		,OrigenID AS OrigenID
		,CodigoUsuario  AS CodigoUsuario
		,OrigenDescripcion AS OrigenDescripcion
		,TipoEnvio AS TipoEnvio
		,CodigoGenerado AS CodigoGenerado
		,IsNull(OpcionDesabilitado, 0) AS OpcionDesabilitado
		,IsNull(FechaRegistro, GETDATE() ) AS FechaRegistro
		,GETDATE() AS FechaActual
		,CantidadEnvios AS CantidadEnvios
	FROM [dbo].[CodigoGenerado]
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpChile
GO

/* GetCodigoGenerado */
IF (OBJECT_ID('GetCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[GetCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int )
AS
BEGIN	
	SELECT 
		CodigoGeneradoID AS CodigoGeneradoID
		,OrigenID AS OrigenID
		,CodigoUsuario  AS CodigoUsuario
		,OrigenDescripcion AS OrigenDescripcion
		,TipoEnvio AS TipoEnvio
		,CodigoGenerado AS CodigoGenerado
		,IsNull(OpcionDesabilitado, 0) AS OpcionDesabilitado
		,IsNull(FechaRegistro, GETDATE() ) AS FechaRegistro
		,GETDATE() AS FechaActual
		,CantidadEnvios AS CantidadEnvios
	FROM [dbo].[CodigoGenerado]
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO

USE BelcorpBolivia
GO

/* GetCodigoGenerado */
IF (OBJECT_ID('GetCodigoGenerado') IS NOT NULL)
  DROP PROCEDURE [dbo].[GetCodigoGenerado]
GO

CREATE PROCEDURE [dbo].[GetCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int )
AS
BEGIN	
	SELECT 
		CodigoGeneradoID AS CodigoGeneradoID
		,OrigenID AS OrigenID
		,CodigoUsuario  AS CodigoUsuario
		,OrigenDescripcion AS OrigenDescripcion
		,TipoEnvio AS TipoEnvio
		,CodigoGenerado AS CodigoGenerado
		,IsNull(OpcionDesabilitado, 0) AS OpcionDesabilitado
		,IsNull(FechaRegistro, GETDATE() ) AS FechaRegistro
		,GETDATE() AS FechaActual
		,CantidadEnvios AS CantidadEnvios
	FROM [dbo].[CodigoGenerado]
	WHERE OrigenID = @OrigenID AND CodigoUsuario = @CodigoUsuario
END
GO



