USE BelcorpPeru
GO

/* InsCodigoGenerado */
IF (OBJECT_ID ( 'dbo.InsCodigoGenerado', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.InsCodigoGenerado AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[InsCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@OrigenDescripcion varchar(50),
	@TipoEnvio varchar(10),
	@CodigoGenerado varchar(6),
	@OpcionDesabilitado bit )
AS
BEGIN	
	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoGenerado] where OrigenID = @OrigenID and CodigoUsuario = @CodigoUsuario 
	and lower(TipoEnvio) = lower(@TipoEnvio))
	BEGIN
		INSERT INTO [dbo].[CodigoGenerado]
				(
				 CodigoUsuario
				,OrigenID
				,OrigenDescripcion
				,TipoEnvio
				,CodigoGenerado
				,OpcionDesabilitado
				,CantidadEnvios
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
				,1
			    ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoGenerado]
		   SET CodigoGenerado = @CodigoGenerado
			  ,OpcionDesabilitado = @OpcionDesabilitado
			  ,FechaRegistro = GETDATE()
		WHERE OrigenID = @OrigenID 
		AND CodigoUsuario = @CodigoUsuario 
		AND lower(TipoEnvio) = lower(@TipoEnvio)
	END
END
GO

USE BelcorpMexico
GO

/* InsCodigoGenerado */
IF (OBJECT_ID ( 'dbo.InsCodigoGenerado', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.InsCodigoGenerado AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[InsCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@OrigenDescripcion varchar(50),
	@TipoEnvio varchar(10),
	@CodigoGenerado varchar(6),
	@OpcionDesabilitado bit )
AS
BEGIN	
	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoGenerado] where OrigenID = @OrigenID and CodigoUsuario = @CodigoUsuario 
	and lower(TipoEnvio) = lower(@TipoEnvio))
	BEGIN
		INSERT INTO [dbo].[CodigoGenerado]
				(
				 CodigoUsuario
				,OrigenID
				,OrigenDescripcion
				,TipoEnvio
				,CodigoGenerado
				,OpcionDesabilitado
				,CantidadEnvios
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
				,1
			    ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoGenerado]
		   SET CodigoGenerado = @CodigoGenerado
			  ,OpcionDesabilitado = @OpcionDesabilitado
			  ,FechaRegistro = GETDATE()
		WHERE OrigenID = @OrigenID 
		AND CodigoUsuario = @CodigoUsuario 
		AND lower(TipoEnvio) = lower(@TipoEnvio)
	END
END
GO

USE BelcorpColombia
GO

/* InsCodigoGenerado */
IF (OBJECT_ID ( 'dbo.InsCodigoGenerado', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.InsCodigoGenerado AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[InsCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@OrigenDescripcion varchar(50),
	@TipoEnvio varchar(10),
	@CodigoGenerado varchar(6),
	@OpcionDesabilitado bit )
AS
BEGIN	
	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoGenerado] where OrigenID = @OrigenID and CodigoUsuario = @CodigoUsuario 
	and lower(TipoEnvio) = lower(@TipoEnvio))
	BEGIN
		INSERT INTO [dbo].[CodigoGenerado]
				(
				 CodigoUsuario
				,OrigenID
				,OrigenDescripcion
				,TipoEnvio
				,CodigoGenerado
				,OpcionDesabilitado
				,CantidadEnvios
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
				,1
			    ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoGenerado]
		   SET CodigoGenerado = @CodigoGenerado
			  ,OpcionDesabilitado = @OpcionDesabilitado
			  ,FechaRegistro = GETDATE()
		WHERE OrigenID = @OrigenID 
		AND CodigoUsuario = @CodigoUsuario 
		AND lower(TipoEnvio) = lower(@TipoEnvio)
	END
END
GO

USE BelcorpSalvador
GO

/* InsCodigoGenerado */
IF (OBJECT_ID ( 'dbo.InsCodigoGenerado', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.InsCodigoGenerado AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[InsCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@OrigenDescripcion varchar(50),
	@TipoEnvio varchar(10),
	@CodigoGenerado varchar(6),
	@OpcionDesabilitado bit )
AS
BEGIN	
	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoGenerado] where OrigenID = @OrigenID and CodigoUsuario = @CodigoUsuario 
	and lower(TipoEnvio) = lower(@TipoEnvio))
	BEGIN
		INSERT INTO [dbo].[CodigoGenerado]
				(
				 CodigoUsuario
				,OrigenID
				,OrigenDescripcion
				,TipoEnvio
				,CodigoGenerado
				,OpcionDesabilitado
				,CantidadEnvios
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
				,1
			    ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoGenerado]
		   SET CodigoGenerado = @CodigoGenerado
			  ,OpcionDesabilitado = @OpcionDesabilitado
			  ,FechaRegistro = GETDATE()
		WHERE OrigenID = @OrigenID 
		AND CodigoUsuario = @CodigoUsuario 
		AND lower(TipoEnvio) = lower(@TipoEnvio)
	END
END
GO

USE BelcorpPuertoRico
GO

/* InsCodigoGenerado */
IF (OBJECT_ID ( 'dbo.InsCodigoGenerado', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.InsCodigoGenerado AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[InsCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@OrigenDescripcion varchar(50),
	@TipoEnvio varchar(10),
	@CodigoGenerado varchar(6),
	@OpcionDesabilitado bit )
AS
BEGIN	
	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoGenerado] where OrigenID = @OrigenID and CodigoUsuario = @CodigoUsuario 
	and lower(TipoEnvio) = lower(@TipoEnvio))
	BEGIN
		INSERT INTO [dbo].[CodigoGenerado]
				(
				 CodigoUsuario
				,OrigenID
				,OrigenDescripcion
				,TipoEnvio
				,CodigoGenerado
				,OpcionDesabilitado
				,CantidadEnvios
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
				,1
			    ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoGenerado]
		   SET CodigoGenerado = @CodigoGenerado
			  ,OpcionDesabilitado = @OpcionDesabilitado
			  ,FechaRegistro = GETDATE()
		WHERE OrigenID = @OrigenID 
		AND CodigoUsuario = @CodigoUsuario 
		AND lower(TipoEnvio) = lower(@TipoEnvio)
	END
END
GO

USE BelcorpPanama
GO

/* InsCodigoGenerado */
IF (OBJECT_ID ( 'dbo.InsCodigoGenerado', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.InsCodigoGenerado AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[InsCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@OrigenDescripcion varchar(50),
	@TipoEnvio varchar(10),
	@CodigoGenerado varchar(6),
	@OpcionDesabilitado bit )
AS
BEGIN	
	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoGenerado] where OrigenID = @OrigenID and CodigoUsuario = @CodigoUsuario 
	and lower(TipoEnvio) = lower(@TipoEnvio))
	BEGIN
		INSERT INTO [dbo].[CodigoGenerado]
				(
				 CodigoUsuario
				,OrigenID
				,OrigenDescripcion
				,TipoEnvio
				,CodigoGenerado
				,OpcionDesabilitado
				,CantidadEnvios
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
				,1
			    ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoGenerado]
		   SET CodigoGenerado = @CodigoGenerado
			  ,OpcionDesabilitado = @OpcionDesabilitado
			  ,FechaRegistro = GETDATE()
		WHERE OrigenID = @OrigenID 
		AND CodigoUsuario = @CodigoUsuario 
		AND lower(TipoEnvio) = lower(@TipoEnvio)
	END
END
GO

USE BelcorpGuatemala
GO

/* InsCodigoGenerado */
IF (OBJECT_ID ( 'dbo.InsCodigoGenerado', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.InsCodigoGenerado AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[InsCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@OrigenDescripcion varchar(50),
	@TipoEnvio varchar(10),
	@CodigoGenerado varchar(6),
	@OpcionDesabilitado bit )
AS
BEGIN	
	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoGenerado] where OrigenID = @OrigenID and CodigoUsuario = @CodigoUsuario 
	and lower(TipoEnvio) = lower(@TipoEnvio))
	BEGIN
		INSERT INTO [dbo].[CodigoGenerado]
				(
				 CodigoUsuario
				,OrigenID
				,OrigenDescripcion
				,TipoEnvio
				,CodigoGenerado
				,OpcionDesabilitado
				,CantidadEnvios
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
				,1
			    ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoGenerado]
		   SET CodigoGenerado = @CodigoGenerado
			  ,OpcionDesabilitado = @OpcionDesabilitado
			  ,FechaRegistro = GETDATE()
		WHERE OrigenID = @OrigenID 
		AND CodigoUsuario = @CodigoUsuario 
		AND lower(TipoEnvio) = lower(@TipoEnvio)
	END
END
GO

USE BelcorpEcuador
GO

/* InsCodigoGenerado */
IF (OBJECT_ID ( 'dbo.InsCodigoGenerado', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.InsCodigoGenerado AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[InsCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@OrigenDescripcion varchar(50),
	@TipoEnvio varchar(10),
	@CodigoGenerado varchar(6),
	@OpcionDesabilitado bit )
AS
BEGIN	
	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoGenerado] where OrigenID = @OrigenID and CodigoUsuario = @CodigoUsuario 
	and lower(TipoEnvio) = lower(@TipoEnvio))
	BEGIN
		INSERT INTO [dbo].[CodigoGenerado]
				(
				 CodigoUsuario
				,OrigenID
				,OrigenDescripcion
				,TipoEnvio
				,CodigoGenerado
				,OpcionDesabilitado
				,CantidadEnvios
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
				,1
			    ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoGenerado]
		   SET CodigoGenerado = @CodigoGenerado
			  ,OpcionDesabilitado = @OpcionDesabilitado
			  ,FechaRegistro = GETDATE()
		WHERE OrigenID = @OrigenID 
		AND CodigoUsuario = @CodigoUsuario 
		AND lower(TipoEnvio) = lower(@TipoEnvio)
	END
END
GO

USE BelcorpDominicana
GO

/* InsCodigoGenerado */
IF (OBJECT_ID ( 'dbo.InsCodigoGenerado', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.InsCodigoGenerado AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[InsCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@OrigenDescripcion varchar(50),
	@TipoEnvio varchar(10),
	@CodigoGenerado varchar(6),
	@OpcionDesabilitado bit )
AS
BEGIN	
	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoGenerado] where OrigenID = @OrigenID and CodigoUsuario = @CodigoUsuario 
	and lower(TipoEnvio) = lower(@TipoEnvio))
	BEGIN
		INSERT INTO [dbo].[CodigoGenerado]
				(
				 CodigoUsuario
				,OrigenID
				,OrigenDescripcion
				,TipoEnvio
				,CodigoGenerado
				,OpcionDesabilitado
				,CantidadEnvios
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
				,1
			    ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoGenerado]
		   SET CodigoGenerado = @CodigoGenerado
			  ,OpcionDesabilitado = @OpcionDesabilitado
			  ,FechaRegistro = GETDATE()
		WHERE OrigenID = @OrigenID 
		AND CodigoUsuario = @CodigoUsuario 
		AND lower(TipoEnvio) = lower(@TipoEnvio)
	END
END
GO

USE BelcorpCostaRica
GO

/* InsCodigoGenerado */
IF (OBJECT_ID ( 'dbo.InsCodigoGenerado', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.InsCodigoGenerado AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[InsCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@OrigenDescripcion varchar(50),
	@TipoEnvio varchar(10),
	@CodigoGenerado varchar(6),
	@OpcionDesabilitado bit )
AS
BEGIN	
	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoGenerado] where OrigenID = @OrigenID and CodigoUsuario = @CodigoUsuario 
	and lower(TipoEnvio) = lower(@TipoEnvio))
	BEGIN
		INSERT INTO [dbo].[CodigoGenerado]
				(
				 CodigoUsuario
				,OrigenID
				,OrigenDescripcion
				,TipoEnvio
				,CodigoGenerado
				,OpcionDesabilitado
				,CantidadEnvios
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
				,1
			    ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoGenerado]
		   SET CodigoGenerado = @CodigoGenerado
			  ,OpcionDesabilitado = @OpcionDesabilitado
			  ,FechaRegistro = GETDATE()
		WHERE OrigenID = @OrigenID 
		AND CodigoUsuario = @CodigoUsuario 
		AND lower(TipoEnvio) = lower(@TipoEnvio)
	END
END
GO

USE BelcorpChile
GO

/* InsCodigoGenerado */
IF (OBJECT_ID ( 'dbo.InsCodigoGenerado', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.InsCodigoGenerado AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[InsCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@OrigenDescripcion varchar(50),
	@TipoEnvio varchar(10),
	@CodigoGenerado varchar(6),
	@OpcionDesabilitado bit )
AS
BEGIN	
	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoGenerado] where OrigenID = @OrigenID and CodigoUsuario = @CodigoUsuario 
	and lower(TipoEnvio) = lower(@TipoEnvio))
	BEGIN
		INSERT INTO [dbo].[CodigoGenerado]
				(
				 CodigoUsuario
				,OrigenID
				,OrigenDescripcion
				,TipoEnvio
				,CodigoGenerado
				,OpcionDesabilitado
				,CantidadEnvios
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
				,1
			    ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoGenerado]
		   SET CodigoGenerado = @CodigoGenerado
			  ,OpcionDesabilitado = @OpcionDesabilitado
			  ,FechaRegistro = GETDATE()
		WHERE OrigenID = @OrigenID 
		AND CodigoUsuario = @CodigoUsuario 
		AND lower(TipoEnvio) = lower(@TipoEnvio)
	END
END
GO

USE BelcorpBolivia
GO

/* InsCodigoGenerado */
IF (OBJECT_ID ( 'dbo.InsCodigoGenerado', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.InsCodigoGenerado AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[InsCodigoGenerado] (
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@OrigenDescripcion varchar(50),
	@TipoEnvio varchar(10),
	@CodigoGenerado varchar(6),
	@OpcionDesabilitado bit )
AS
BEGIN	
	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoGenerado] where OrigenID = @OrigenID and CodigoUsuario = @CodigoUsuario 
	and lower(TipoEnvio) = lower(@TipoEnvio))
	BEGIN
		INSERT INTO [dbo].[CodigoGenerado]
				(
				 CodigoUsuario
				,OrigenID
				,OrigenDescripcion
				,TipoEnvio
				,CodigoGenerado
				,OpcionDesabilitado
				,CantidadEnvios
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
				,1
			    ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoGenerado]
		   SET CodigoGenerado = @CodigoGenerado
			  ,OpcionDesabilitado = @OpcionDesabilitado
			  ,FechaRegistro = GETDATE()
		WHERE OrigenID = @OrigenID 
		AND CodigoUsuario = @CodigoUsuario 
		AND lower(TipoEnvio) = lower(@TipoEnvio)
	END
END
GO

