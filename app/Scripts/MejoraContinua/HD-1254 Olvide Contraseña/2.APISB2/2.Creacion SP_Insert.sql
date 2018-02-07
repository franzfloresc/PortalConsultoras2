USE BelcorpPeru
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
GO
CREATE PROC InsCodigoSMS
(
@Origen varchar(30),
@CodigoConsultora varchar(20),
@CodigoGenerado varchar(6)
)
AS
BEGIN
	
	DECLARE @Cantidad int = 0
	SELECT @Cantidad = count(*) from CodigoSMS
	IF (@Cantidad >= 500)
	BEGIN
		DELETE FROM CodigoSMS
		DBCC CHECKIDENT (CodigoSMS, RESEED, 0);
	END

	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoSMS] where Origen = @Origen and CodigoConsultora = @CodigoConsultora)
	BEGIN
		INSERT INTO [dbo].[CodigoSMS]
			   (Origen
			   ,CodigoConsultora
			   ,CodigoGenerado
			   ,FechaGeneracion)
		 VALUES
			   (@Origen
			   ,@CodigoConsultora
			   ,@CodigoGenerado
			   ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoSMS]
		   SET CodigoGenerado = @CodigoGenerado
			  ,FechaGeneracion = GETDATE()
		 WHERE Origen = @Origen and CodigoConsultora = @CodigoConsultora
	END
END
GO

USE BelcorpMexico
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
GO
CREATE PROC InsCodigoSMS
(
@Origen varchar(30),
@CodigoConsultora varchar(20),
@CodigoGenerado varchar(6)
)
AS
BEGIN
	
	DECLARE @Cantidad int = 0
	SELECT @Cantidad = count(*) from CodigoSMS
	IF (@Cantidad >= 500)
	BEGIN
		DELETE FROM CodigoSMS
		DBCC CHECKIDENT (CodigoSMS, RESEED, 0);
	END

	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoSMS] where Origen = @Origen and CodigoConsultora = @CodigoConsultora)
	BEGIN
		INSERT INTO [dbo].[CodigoSMS]
			   (Origen
			   ,CodigoConsultora
			   ,CodigoGenerado
			   ,FechaGeneracion)
		 VALUES
			   (@Origen
			   ,@CodigoConsultora
			   ,@CodigoGenerado
			   ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoSMS]
		   SET CodigoGenerado = @CodigoGenerado
			  ,FechaGeneracion = GETDATE()
		 WHERE Origen = @Origen and CodigoConsultora = @CodigoConsultora
	END
END
GO

USE BelcorpColombia
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
GO
CREATE PROC InsCodigoSMS
(
@Origen varchar(30),
@CodigoConsultora varchar(20),
@CodigoGenerado varchar(6)
)
AS
BEGIN
	
	DECLARE @Cantidad int = 0
	SELECT @Cantidad = count(*) from CodigoSMS
	IF (@Cantidad >= 500)
	BEGIN
		DELETE FROM CodigoSMS
		DBCC CHECKIDENT (CodigoSMS, RESEED, 0);
	END

	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoSMS] where Origen = @Origen and CodigoConsultora = @CodigoConsultora)
	BEGIN
		INSERT INTO [dbo].[CodigoSMS]
			   (Origen
			   ,CodigoConsultora
			   ,CodigoGenerado
			   ,FechaGeneracion)
		 VALUES
			   (@Origen
			   ,@CodigoConsultora
			   ,@CodigoGenerado
			   ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoSMS]
		   SET CodigoGenerado = @CodigoGenerado
			  ,FechaGeneracion = GETDATE()
		 WHERE Origen = @Origen and CodigoConsultora = @CodigoConsultora
	END
END
GO

USE BelcorpVenezuela
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
GO
CREATE PROC InsCodigoSMS
(
@Origen varchar(30),
@CodigoConsultora varchar(20),
@CodigoGenerado varchar(6)
)
AS
BEGIN
	
	DECLARE @Cantidad int = 0
	SELECT @Cantidad = count(*) from CodigoSMS
	IF (@Cantidad >= 500)
	BEGIN
		DELETE FROM CodigoSMS
		DBCC CHECKIDENT (CodigoSMS, RESEED, 0);
	END

	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoSMS] where Origen = @Origen and CodigoConsultora = @CodigoConsultora)
	BEGIN
		INSERT INTO [dbo].[CodigoSMS]
			   (Origen
			   ,CodigoConsultora
			   ,CodigoGenerado
			   ,FechaGeneracion)
		 VALUES
			   (@Origen
			   ,@CodigoConsultora
			   ,@CodigoGenerado
			   ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoSMS]
		   SET CodigoGenerado = @CodigoGenerado
			  ,FechaGeneracion = GETDATE()
		 WHERE Origen = @Origen and CodigoConsultora = @CodigoConsultora
	END
END
GO

USE BelcorpSalvador
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
GO
CREATE PROC InsCodigoSMS
(
@Origen varchar(30),
@CodigoConsultora varchar(20),
@CodigoGenerado varchar(6)
)
AS
BEGIN
	
	DECLARE @Cantidad int = 0
	SELECT @Cantidad = count(*) from CodigoSMS
	IF (@Cantidad >= 500)
	BEGIN
		DELETE FROM CodigoSMS
		DBCC CHECKIDENT (CodigoSMS, RESEED, 0);
	END

	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoSMS] where Origen = @Origen and CodigoConsultora = @CodigoConsultora)
	BEGIN
		INSERT INTO [dbo].[CodigoSMS]
			   (Origen
			   ,CodigoConsultora
			   ,CodigoGenerado
			   ,FechaGeneracion)
		 VALUES
			   (@Origen
			   ,@CodigoConsultora
			   ,@CodigoGenerado
			   ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoSMS]
		   SET CodigoGenerado = @CodigoGenerado
			  ,FechaGeneracion = GETDATE()
		 WHERE Origen = @Origen and CodigoConsultora = @CodigoConsultora
	END
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
GO
CREATE PROC InsCodigoSMS
(
@Origen varchar(30),
@CodigoConsultora varchar(20),
@CodigoGenerado varchar(6)
)
AS
BEGIN
	
	DECLARE @Cantidad int = 0
	SELECT @Cantidad = count(*) from CodigoSMS
	IF (@Cantidad >= 500)
	BEGIN
		DELETE FROM CodigoSMS
		DBCC CHECKIDENT (CodigoSMS, RESEED, 0);
	END

	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoSMS] where Origen = @Origen and CodigoConsultora = @CodigoConsultora)
	BEGIN
		INSERT INTO [dbo].[CodigoSMS]
			   (Origen
			   ,CodigoConsultora
			   ,CodigoGenerado
			   ,FechaGeneracion)
		 VALUES
			   (@Origen
			   ,@CodigoConsultora
			   ,@CodigoGenerado
			   ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoSMS]
		   SET CodigoGenerado = @CodigoGenerado
			  ,FechaGeneracion = GETDATE()
		 WHERE Origen = @Origen and CodigoConsultora = @CodigoConsultora
	END
END
GO

USE BelcorpPanama
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
GO
CREATE PROC InsCodigoSMS
(
@Origen varchar(30),
@CodigoConsultora varchar(20),
@CodigoGenerado varchar(6)
)
AS
BEGIN
	
	DECLARE @Cantidad int = 0
	SELECT @Cantidad = count(*) from CodigoSMS
	IF (@Cantidad >= 500)
	BEGIN
		DELETE FROM CodigoSMS
		DBCC CHECKIDENT (CodigoSMS, RESEED, 0);
	END

	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoSMS] where Origen = @Origen and CodigoConsultora = @CodigoConsultora)
	BEGIN
		INSERT INTO [dbo].[CodigoSMS]
			   (Origen
			   ,CodigoConsultora
			   ,CodigoGenerado
			   ,FechaGeneracion)
		 VALUES
			   (@Origen
			   ,@CodigoConsultora
			   ,@CodigoGenerado
			   ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoSMS]
		   SET CodigoGenerado = @CodigoGenerado
			  ,FechaGeneracion = GETDATE()
		 WHERE Origen = @Origen and CodigoConsultora = @CodigoConsultora
	END
END
GO

USE BelcorpGuatemala
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
GO
CREATE PROC InsCodigoSMS
(
@Origen varchar(30),
@CodigoConsultora varchar(20),
@CodigoGenerado varchar(6)
)
AS
BEGIN
	
	DECLARE @Cantidad int = 0
	SELECT @Cantidad = count(*) from CodigoSMS
	IF (@Cantidad >= 500)
	BEGIN
		DELETE FROM CodigoSMS
		DBCC CHECKIDENT (CodigoSMS, RESEED, 0);
	END

	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoSMS] where Origen = @Origen and CodigoConsultora = @CodigoConsultora)
	BEGIN
		INSERT INTO [dbo].[CodigoSMS]
			   (Origen
			   ,CodigoConsultora
			   ,CodigoGenerado
			   ,FechaGeneracion)
		 VALUES
			   (@Origen
			   ,@CodigoConsultora
			   ,@CodigoGenerado
			   ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoSMS]
		   SET CodigoGenerado = @CodigoGenerado
			  ,FechaGeneracion = GETDATE()
		 WHERE Origen = @Origen and CodigoConsultora = @CodigoConsultora
	END
END
GO

USE BelcorpEcuador
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
GO
CREATE PROC InsCodigoSMS
(
@Origen varchar(30),
@CodigoConsultora varchar(20),
@CodigoGenerado varchar(6)
)
AS
BEGIN
	
	DECLARE @Cantidad int = 0
	SELECT @Cantidad = count(*) from CodigoSMS
	IF (@Cantidad >= 500)
	BEGIN
		DELETE FROM CodigoSMS
		DBCC CHECKIDENT (CodigoSMS, RESEED, 0);
	END

	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoSMS] where Origen = @Origen and CodigoConsultora = @CodigoConsultora)
	BEGIN
		INSERT INTO [dbo].[CodigoSMS]
			   (Origen
			   ,CodigoConsultora
			   ,CodigoGenerado
			   ,FechaGeneracion)
		 VALUES
			   (@Origen
			   ,@CodigoConsultora
			   ,@CodigoGenerado
			   ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoSMS]
		   SET CodigoGenerado = @CodigoGenerado
			  ,FechaGeneracion = GETDATE()
		 WHERE Origen = @Origen and CodigoConsultora = @CodigoConsultora
	END
END
GO

USE BelcorpDominicana
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
GO
CREATE PROC InsCodigoSMS
(
@Origen varchar(30),
@CodigoConsultora varchar(20),
@CodigoGenerado varchar(6)
)
AS
BEGIN
	
	DECLARE @Cantidad int = 0
	SELECT @Cantidad = count(*) from CodigoSMS
	IF (@Cantidad >= 500)
	BEGIN
		DELETE FROM CodigoSMS
		DBCC CHECKIDENT (CodigoSMS, RESEED, 0);
	END

	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoSMS] where Origen = @Origen and CodigoConsultora = @CodigoConsultora)
	BEGIN
		INSERT INTO [dbo].[CodigoSMS]
			   (Origen
			   ,CodigoConsultora
			   ,CodigoGenerado
			   ,FechaGeneracion)
		 VALUES
			   (@Origen
			   ,@CodigoConsultora
			   ,@CodigoGenerado
			   ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoSMS]
		   SET CodigoGenerado = @CodigoGenerado
			  ,FechaGeneracion = GETDATE()
		 WHERE Origen = @Origen and CodigoConsultora = @CodigoConsultora
	END
END
GO

USE BelcorpCostaRica
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
GO
CREATE PROC InsCodigoSMS
(
@Origen varchar(30),
@CodigoConsultora varchar(20),
@CodigoGenerado varchar(6)
)
AS
BEGIN
	
	DECLARE @Cantidad int = 0
	SELECT @Cantidad = count(*) from CodigoSMS
	IF (@Cantidad >= 500)
	BEGIN
		DELETE FROM CodigoSMS
		DBCC CHECKIDENT (CodigoSMS, RESEED, 0);
	END

	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoSMS] where Origen = @Origen and CodigoConsultora = @CodigoConsultora)
	BEGIN
		INSERT INTO [dbo].[CodigoSMS]
			   (Origen
			   ,CodigoConsultora
			   ,CodigoGenerado
			   ,FechaGeneracion)
		 VALUES
			   (@Origen
			   ,@CodigoConsultora
			   ,@CodigoGenerado
			   ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoSMS]
		   SET CodigoGenerado = @CodigoGenerado
			  ,FechaGeneracion = GETDATE()
		 WHERE Origen = @Origen and CodigoConsultora = @CodigoConsultora
	END
END
GO

USE BelcorpChile
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
GO
CREATE PROC InsCodigoSMS
(
@Origen varchar(30),
@CodigoConsultora varchar(20),
@CodigoGenerado varchar(6)
)
AS
BEGIN
	
	DECLARE @Cantidad int = 0
	SELECT @Cantidad = count(*) from CodigoSMS
	IF (@Cantidad >= 500)
	BEGIN
		DELETE FROM CodigoSMS
		DBCC CHECKIDENT (CodigoSMS, RESEED, 0);
	END

	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoSMS] where Origen = @Origen and CodigoConsultora = @CodigoConsultora)
	BEGIN
		INSERT INTO [dbo].[CodigoSMS]
			   (Origen
			   ,CodigoConsultora
			   ,CodigoGenerado
			   ,FechaGeneracion)
		 VALUES
			   (@Origen
			   ,@CodigoConsultora
			   ,@CodigoGenerado
			   ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoSMS]
		   SET CodigoGenerado = @CodigoGenerado
			  ,FechaGeneracion = GETDATE()
		 WHERE Origen = @Origen and CodigoConsultora = @CodigoConsultora
	END
END
GO

USE BelcorpBolivia
GO

IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'InsCodigoSMS')
BEGIN
	DROP PROC InsCodigoSMS
END
GO
CREATE PROC InsCodigoSMS
(
@Origen varchar(30),
@CodigoConsultora varchar(20),
@CodigoGenerado varchar(6)
)
AS
BEGIN
	
	DECLARE @Cantidad int = 0
	SELECT @Cantidad = count(*) from CodigoSMS
	IF (@Cantidad >= 500)
	BEGIN
		DELETE FROM CodigoSMS
		DBCC CHECKIDENT (CodigoSMS, RESEED, 0);
	END

	/*** Verificando si la consultora ya tiene un codigo generado ***/
	IF NOT EXISTS (select 1 from [dbo].[CodigoSMS] where Origen = @Origen and CodigoConsultora = @CodigoConsultora)
	BEGIN
		INSERT INTO [dbo].[CodigoSMS]
			   (Origen
			   ,CodigoConsultora
			   ,CodigoGenerado
			   ,FechaGeneracion)
		 VALUES
			   (@Origen
			   ,@CodigoConsultora
			   ,@CodigoGenerado
			   ,GetDate())
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CodigoSMS]
		   SET CodigoGenerado = @CodigoGenerado
			  ,FechaGeneracion = GETDATE()
		 WHERE Origen = @Origen and CodigoConsultora = @CodigoConsultora
	END
END
GO

