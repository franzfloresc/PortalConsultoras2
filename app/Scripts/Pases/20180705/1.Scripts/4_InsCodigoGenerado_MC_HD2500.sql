USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'InsCodigoGenerado')
BEGIN
	DROP PROC [dbo].[InsCodigoGenerado]
END
GO
CREATE PROC [dbo].[InsCodigoGenerado]
(
@CodigoUsuario varchar(20),
@OrigenID int,
@OrigenDescripcion varchar(50),
@TipoEnvio varchar(10),
@CodigoGenerado varchar(6),
@OpcionDesabilitado bit
)
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
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
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

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'InsCodigoGenerado')
BEGIN
	DROP PROC [dbo].[InsCodigoGenerado]
END
GO
CREATE PROC [dbo].[InsCodigoGenerado]
(
@CodigoUsuario varchar(20),
@OrigenID int,
@OrigenDescripcion varchar(50),
@TipoEnvio varchar(10),
@CodigoGenerado varchar(6),
@OpcionDesabilitado bit
)
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
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
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

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'InsCodigoGenerado')
BEGIN
	DROP PROC [dbo].[InsCodigoGenerado]
END
GO
CREATE PROC [dbo].[InsCodigoGenerado]
(
@CodigoUsuario varchar(20),
@OrigenID int,
@OrigenDescripcion varchar(50),
@TipoEnvio varchar(10),
@CodigoGenerado varchar(6),
@OpcionDesabilitado bit
)
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
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
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

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'InsCodigoGenerado')
BEGIN
	DROP PROC [dbo].[InsCodigoGenerado]
END
GO
CREATE PROC [dbo].[InsCodigoGenerado]
(
@CodigoUsuario varchar(20),
@OrigenID int,
@OrigenDescripcion varchar(50),
@TipoEnvio varchar(10),
@CodigoGenerado varchar(6),
@OpcionDesabilitado bit
)
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
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
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

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'InsCodigoGenerado')
BEGIN
	DROP PROC [dbo].[InsCodigoGenerado]
END
GO
CREATE PROC [dbo].[InsCodigoGenerado]
(
@CodigoUsuario varchar(20),
@OrigenID int,
@OrigenDescripcion varchar(50),
@TipoEnvio varchar(10),
@CodigoGenerado varchar(6),
@OpcionDesabilitado bit
)
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
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
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

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'InsCodigoGenerado')
BEGIN
	DROP PROC [dbo].[InsCodigoGenerado]
END
GO
CREATE PROC [dbo].[InsCodigoGenerado]
(
@CodigoUsuario varchar(20),
@OrigenID int,
@OrigenDescripcion varchar(50),
@TipoEnvio varchar(10),
@CodigoGenerado varchar(6),
@OpcionDesabilitado bit
)
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
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
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

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'InsCodigoGenerado')
BEGIN
	DROP PROC [dbo].[InsCodigoGenerado]
END
GO
CREATE PROC [dbo].[InsCodigoGenerado]
(
@CodigoUsuario varchar(20),
@OrigenID int,
@OrigenDescripcion varchar(50),
@TipoEnvio varchar(10),
@CodigoGenerado varchar(6),
@OpcionDesabilitado bit
)
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
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
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

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'InsCodigoGenerado')
BEGIN
	DROP PROC [dbo].[InsCodigoGenerado]
END
GO
CREATE PROC [dbo].[InsCodigoGenerado]
(
@CodigoUsuario varchar(20),
@OrigenID int,
@OrigenDescripcion varchar(50),
@TipoEnvio varchar(10),
@CodigoGenerado varchar(6),
@OpcionDesabilitado bit
)
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
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
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

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'InsCodigoGenerado')
BEGIN
	DROP PROC [dbo].[InsCodigoGenerado]
END
GO
CREATE PROC [dbo].[InsCodigoGenerado]
(
@CodigoUsuario varchar(20),
@OrigenID int,
@OrigenDescripcion varchar(50),
@TipoEnvio varchar(10),
@CodigoGenerado varchar(6),
@OpcionDesabilitado bit
)
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
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
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

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'InsCodigoGenerado')
BEGIN
	DROP PROC [dbo].[InsCodigoGenerado]
END
GO
CREATE PROC [dbo].[InsCodigoGenerado]
(
@CodigoUsuario varchar(20),
@OrigenID int,
@OrigenDescripcion varchar(50),
@TipoEnvio varchar(10),
@CodigoGenerado varchar(6),
@OpcionDesabilitado bit
)
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
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
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

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'InsCodigoGenerado')
BEGIN
	DROP PROC [dbo].[InsCodigoGenerado]
END
GO
CREATE PROC [dbo].[InsCodigoGenerado]
(
@CodigoUsuario varchar(20),
@OrigenID int,
@OrigenDescripcion varchar(50),
@TipoEnvio varchar(10),
@CodigoGenerado varchar(6),
@OpcionDesabilitado bit
)
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
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
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

IF EXISTS (SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'InsCodigoGenerado')
BEGIN
	DROP PROC [dbo].[InsCodigoGenerado]
END
GO
CREATE PROC [dbo].[InsCodigoGenerado]
(
@CodigoUsuario varchar(20),
@OrigenID int,
@OrigenDescripcion varchar(50),
@TipoEnvio varchar(10),
@CodigoGenerado varchar(6),
@OpcionDesabilitado bit
)
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
				,FechaRegistro)
		 VALUES
			   (
				 @CodigoUsuario
				,@OrigenID
				,@OrigenDescripcion
				,@TipoEnvio
				,@CodigoGenerado
				,@OpcionDesabilitado
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

