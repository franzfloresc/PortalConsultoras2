USE BelcorpPeru
GO
ALTER PROCEDURE InsertarEncuesta
(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@EncuestaCalificacionId INT = 0,
@RetornoID  INT OUTPUT)
AS
BEGIN

  DECLARE @EncuestaResultadoId uniqueidentifier,
		  @EncuestaMotivoId_Tem INT, --Para el caso que el app no manda detalle se inserta el motivo "Sin motivo"
		  @SeleccionoMotivo INT; --Para evaluar el caso que los motivos vengan vacios
  DECLARE @FlagUsuarioNoRealizoEncuesta BIT = 0;

  SET @RetornoID  = 0;
  SET @EncuestaResultadoId = NULL;
  SET @SeleccionoMotivo = CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END



  IF(@CanalId=3)
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora

		SET @SeleccionoMotivo=1
		SELECT @EncuestaMotivoId_Tem=id FROM EncuestaMotivo WHERE EncuestaCalificacionId=@EncuestaCalificacionId AND TipoEncuestaMotivoId=3
  END
  ELSE
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora
			-- and ER.SeleccionoMotivo = 0; /* HD-5072*/
  END

  IF LEN( @EncuestaResultadoId ) > 0
  BEGIN
    SET @FlagUsuarioNoRealizoEncuesta = 1;
	IF(@CanalId=3)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
  END

  IF (@FlagUsuarioNoRealizoEncuesta = 0)
	  BEGIN
		   SET @EncuestaResultadoId = NEWID();

		  INSERT INTO dbo.EncuestaResultado(Id,EncuestaId,CanalId,CodigoCampania,CodigoConsultora,SeleccionoMotivo,CreatedBy,CreatedHost)
		  VALUES(@EncuestaResultadoId,@EncuestaId,@CanalId,@CodigoCampania,@CodigoConsultora,@SeleccionoMotivo,@CreatedBy,@CreateHost);
	  END
  ELSE
	  BEGIN
	     UPDATE EncuestaResultado SET SeleccionoMotivo = @SeleccionoMotivo,CreatedBy=@CreatedBy,CreatedHost=@CreateHost WHERE Id = @EncuestaResultadoId ---AND  @XMLDetalle IS NOT NULL /*HD-5072*/;
	  END

  IF(@XMLDetalle IS NULL AND @CanalId=3)
  BEGIN
	INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
	VALUES(NEWID(),@EncuestaResultadoId,@EncuestaMotivoId_Tem,NULL,@CreatedBy,@CreateHost)
  END
  ELSE
  BEGIN
	IF EXISTS (SELECT 1 FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
	ELSE
		INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
		   SELECT
				NEWID(),
				@EncuestaResultadoId,
				field.value('id[1]', 'INT') AS MotivoId,
				field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
				@CreatedBy as CreatedBy,
				@CreateHost AS CreateHost
		   FROM
				@XMLDetalle.nodes('//motivo') archivo(field);
  END
  SET @RetornoID = 1;
END
GO


GO
USE BelcorpMexico
GO
ALTER PROCEDURE InsertarEncuesta
(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@EncuestaCalificacionId INT = 0,
@RetornoID  INT OUTPUT)
AS
BEGIN

  DECLARE @EncuestaResultadoId uniqueidentifier,
		  @EncuestaMotivoId_Tem INT, --Para el caso que el app no manda detalle se inserta el motivo "Sin motivo"
		  @SeleccionoMotivo INT; --Para evaluar el caso que los motivos vengan vacios
  DECLARE @FlagUsuarioNoRealizoEncuesta BIT = 0;

  SET @RetornoID  = 0;
  SET @EncuestaResultadoId = NULL;
  SET @SeleccionoMotivo = CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END



  IF(@CanalId=3)
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora

		SET @SeleccionoMotivo=1
		SELECT @EncuestaMotivoId_Tem=id FROM EncuestaMotivo WHERE EncuestaCalificacionId=@EncuestaCalificacionId AND TipoEncuestaMotivoId=3
  END
  ELSE
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora
			-- and ER.SeleccionoMotivo = 0; /* HD-5072*/
  END

  IF LEN( @EncuestaResultadoId ) > 0
  BEGIN
    SET @FlagUsuarioNoRealizoEncuesta = 1;
	IF(@CanalId=3)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
  END

  IF (@FlagUsuarioNoRealizoEncuesta = 0)
	  BEGIN
		   SET @EncuestaResultadoId = NEWID();

		  INSERT INTO dbo.EncuestaResultado(Id,EncuestaId,CanalId,CodigoCampania,CodigoConsultora,SeleccionoMotivo,CreatedBy,CreatedHost)
		  VALUES(@EncuestaResultadoId,@EncuestaId,@CanalId,@CodigoCampania,@CodigoConsultora,@SeleccionoMotivo,@CreatedBy,@CreateHost);
	  END
  ELSE
	  BEGIN
	     UPDATE EncuestaResultado SET SeleccionoMotivo = @SeleccionoMotivo,CreatedBy=@CreatedBy,CreatedHost=@CreateHost WHERE Id = @EncuestaResultadoId ---AND  @XMLDetalle IS NOT NULL /*HD-5072*/;
	  END

  IF(@XMLDetalle IS NULL AND @CanalId=3)
  BEGIN
	INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
	VALUES(NEWID(),@EncuestaResultadoId,@EncuestaMotivoId_Tem,NULL,@CreatedBy,@CreateHost)
  END
  ELSE
  BEGIN
	IF EXISTS (SELECT 1 FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
	ELSE
		INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
		   SELECT
				NEWID(),
				@EncuestaResultadoId,
				field.value('id[1]', 'INT') AS MotivoId,
				field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
				@CreatedBy as CreatedBy,
				@CreateHost AS CreateHost
		   FROM
				@XMLDetalle.nodes('//motivo') archivo(field);
  END
  SET @RetornoID = 1;
END
GO


GO
USE BelcorpColombia
GO
ALTER PROCEDURE InsertarEncuesta
(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@EncuestaCalificacionId INT = 0,
@RetornoID  INT OUTPUT)
AS
BEGIN

  DECLARE @EncuestaResultadoId uniqueidentifier,
		  @EncuestaMotivoId_Tem INT, --Para el caso que el app no manda detalle se inserta el motivo "Sin motivo"
		  @SeleccionoMotivo INT; --Para evaluar el caso que los motivos vengan vacios
  DECLARE @FlagUsuarioNoRealizoEncuesta BIT = 0;

  SET @RetornoID  = 0;
  SET @EncuestaResultadoId = NULL;
  SET @SeleccionoMotivo = CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END



  IF(@CanalId=3)
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora

		SET @SeleccionoMotivo=1
		SELECT @EncuestaMotivoId_Tem=id FROM EncuestaMotivo WHERE EncuestaCalificacionId=@EncuestaCalificacionId AND TipoEncuestaMotivoId=3
  END
  ELSE
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora
			-- and ER.SeleccionoMotivo = 0; /* HD-5072*/
  END

  IF LEN( @EncuestaResultadoId ) > 0
  BEGIN
    SET @FlagUsuarioNoRealizoEncuesta = 1;
	IF(@CanalId=3)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
  END

  IF (@FlagUsuarioNoRealizoEncuesta = 0)
	  BEGIN
		   SET @EncuestaResultadoId = NEWID();

		  INSERT INTO dbo.EncuestaResultado(Id,EncuestaId,CanalId,CodigoCampania,CodigoConsultora,SeleccionoMotivo,CreatedBy,CreatedHost)
		  VALUES(@EncuestaResultadoId,@EncuestaId,@CanalId,@CodigoCampania,@CodigoConsultora,@SeleccionoMotivo,@CreatedBy,@CreateHost);
	  END
  ELSE
	  BEGIN
	     UPDATE EncuestaResultado SET SeleccionoMotivo = @SeleccionoMotivo,CreatedBy=@CreatedBy,CreatedHost=@CreateHost WHERE Id = @EncuestaResultadoId ---AND  @XMLDetalle IS NOT NULL /*HD-5072*/;
	  END

  IF(@XMLDetalle IS NULL AND @CanalId=3)
  BEGIN
	INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
	VALUES(NEWID(),@EncuestaResultadoId,@EncuestaMotivoId_Tem,NULL,@CreatedBy,@CreateHost)
  END
  ELSE
  BEGIN
	IF EXISTS (SELECT 1 FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
	ELSE
		INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
		   SELECT
				NEWID(),
				@EncuestaResultadoId,
				field.value('id[1]', 'INT') AS MotivoId,
				field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
				@CreatedBy as CreatedBy,
				@CreateHost AS CreateHost
		   FROM
				@XMLDetalle.nodes('//motivo') archivo(field);
  END
  SET @RetornoID = 1;
END
GO


GO
USE BelcorpSalvador
GO
ALTER PROCEDURE InsertarEncuesta
(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@EncuestaCalificacionId INT = 0,
@RetornoID  INT OUTPUT)
AS
BEGIN

  DECLARE @EncuestaResultadoId uniqueidentifier,
		  @EncuestaMotivoId_Tem INT, --Para el caso que el app no manda detalle se inserta el motivo "Sin motivo"
		  @SeleccionoMotivo INT; --Para evaluar el caso que los motivos vengan vacios
  DECLARE @FlagUsuarioNoRealizoEncuesta BIT = 0;

  SET @RetornoID  = 0;
  SET @EncuestaResultadoId = NULL;
  SET @SeleccionoMotivo = CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END



  IF(@CanalId=3)
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora

		SET @SeleccionoMotivo=1
		SELECT @EncuestaMotivoId_Tem=id FROM EncuestaMotivo WHERE EncuestaCalificacionId=@EncuestaCalificacionId AND TipoEncuestaMotivoId=3
  END
  ELSE
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora
			-- and ER.SeleccionoMotivo = 0; /* HD-5072*/
  END

  IF LEN( @EncuestaResultadoId ) > 0
  BEGIN
    SET @FlagUsuarioNoRealizoEncuesta = 1;
	IF(@CanalId=3)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
  END

  IF (@FlagUsuarioNoRealizoEncuesta = 0)
	  BEGIN
		   SET @EncuestaResultadoId = NEWID();

		  INSERT INTO dbo.EncuestaResultado(Id,EncuestaId,CanalId,CodigoCampania,CodigoConsultora,SeleccionoMotivo,CreatedBy,CreatedHost)
		  VALUES(@EncuestaResultadoId,@EncuestaId,@CanalId,@CodigoCampania,@CodigoConsultora,@SeleccionoMotivo,@CreatedBy,@CreateHost);
	  END
  ELSE
	  BEGIN
	     UPDATE EncuestaResultado SET SeleccionoMotivo = @SeleccionoMotivo,CreatedBy=@CreatedBy,CreatedHost=@CreateHost WHERE Id = @EncuestaResultadoId ---AND  @XMLDetalle IS NOT NULL /*HD-5072*/;
	  END

  IF(@XMLDetalle IS NULL AND @CanalId=3)
  BEGIN
	INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
	VALUES(NEWID(),@EncuestaResultadoId,@EncuestaMotivoId_Tem,NULL,@CreatedBy,@CreateHost)
  END
  ELSE
  BEGIN
	IF EXISTS (SELECT 1 FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
	ELSE
		INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
		   SELECT
				NEWID(),
				@EncuestaResultadoId,
				field.value('id[1]', 'INT') AS MotivoId,
				field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
				@CreatedBy as CreatedBy,
				@CreateHost AS CreateHost
		   FROM
				@XMLDetalle.nodes('//motivo') archivo(field);
  END
  SET @RetornoID = 1;
END
GO


GO
USE BelcorpPuertoRico
GO
ALTER PROCEDURE InsertarEncuesta
(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@EncuestaCalificacionId INT = 0,
@RetornoID  INT OUTPUT)
AS
BEGIN

  DECLARE @EncuestaResultadoId uniqueidentifier,
		  @EncuestaMotivoId_Tem INT, --Para el caso que el app no manda detalle se inserta el motivo "Sin motivo"
		  @SeleccionoMotivo INT; --Para evaluar el caso que los motivos vengan vacios
  DECLARE @FlagUsuarioNoRealizoEncuesta BIT = 0;

  SET @RetornoID  = 0;
  SET @EncuestaResultadoId = NULL;
  SET @SeleccionoMotivo = CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END



  IF(@CanalId=3)
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora

		SET @SeleccionoMotivo=1
		SELECT @EncuestaMotivoId_Tem=id FROM EncuestaMotivo WHERE EncuestaCalificacionId=@EncuestaCalificacionId AND TipoEncuestaMotivoId=3
  END
  ELSE
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora
			-- and ER.SeleccionoMotivo = 0; /* HD-5072*/
  END

  IF LEN( @EncuestaResultadoId ) > 0
  BEGIN
    SET @FlagUsuarioNoRealizoEncuesta = 1;
	IF(@CanalId=3)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
  END

  IF (@FlagUsuarioNoRealizoEncuesta = 0)
	  BEGIN
		   SET @EncuestaResultadoId = NEWID();

		  INSERT INTO dbo.EncuestaResultado(Id,EncuestaId,CanalId,CodigoCampania,CodigoConsultora,SeleccionoMotivo,CreatedBy,CreatedHost)
		  VALUES(@EncuestaResultadoId,@EncuestaId,@CanalId,@CodigoCampania,@CodigoConsultora,@SeleccionoMotivo,@CreatedBy,@CreateHost);
	  END
  ELSE
	  BEGIN
	     UPDATE EncuestaResultado SET SeleccionoMotivo = @SeleccionoMotivo,CreatedBy=@CreatedBy,CreatedHost=@CreateHost WHERE Id = @EncuestaResultadoId ---AND  @XMLDetalle IS NOT NULL /*HD-5072*/;
	  END

  IF(@XMLDetalle IS NULL AND @CanalId=3)
  BEGIN
	INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
	VALUES(NEWID(),@EncuestaResultadoId,@EncuestaMotivoId_Tem,NULL,@CreatedBy,@CreateHost)
  END
  ELSE
  BEGIN
	IF EXISTS (SELECT 1 FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
	ELSE
		INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
		   SELECT
				NEWID(),
				@EncuestaResultadoId,
				field.value('id[1]', 'INT') AS MotivoId,
				field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
				@CreatedBy as CreatedBy,
				@CreateHost AS CreateHost
		   FROM
				@XMLDetalle.nodes('//motivo') archivo(field);
  END
  SET @RetornoID = 1;
END
GO


GO
USE BelcorpPanama
GO
ALTER PROCEDURE InsertarEncuesta
(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@EncuestaCalificacionId INT = 0,
@RetornoID  INT OUTPUT)
AS
BEGIN

  DECLARE @EncuestaResultadoId uniqueidentifier,
		  @EncuestaMotivoId_Tem INT, --Para el caso que el app no manda detalle se inserta el motivo "Sin motivo"
		  @SeleccionoMotivo INT; --Para evaluar el caso que los motivos vengan vacios
  DECLARE @FlagUsuarioNoRealizoEncuesta BIT = 0;

  SET @RetornoID  = 0;
  SET @EncuestaResultadoId = NULL;
  SET @SeleccionoMotivo = CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END



  IF(@CanalId=3)
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora

		SET @SeleccionoMotivo=1
		SELECT @EncuestaMotivoId_Tem=id FROM EncuestaMotivo WHERE EncuestaCalificacionId=@EncuestaCalificacionId AND TipoEncuestaMotivoId=3
  END
  ELSE
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora
			-- and ER.SeleccionoMotivo = 0; /* HD-5072*/
  END

  IF LEN( @EncuestaResultadoId ) > 0
  BEGIN
    SET @FlagUsuarioNoRealizoEncuesta = 1;
	IF(@CanalId=3)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
  END

  IF (@FlagUsuarioNoRealizoEncuesta = 0)
	  BEGIN
		   SET @EncuestaResultadoId = NEWID();

		  INSERT INTO dbo.EncuestaResultado(Id,EncuestaId,CanalId,CodigoCampania,CodigoConsultora,SeleccionoMotivo,CreatedBy,CreatedHost)
		  VALUES(@EncuestaResultadoId,@EncuestaId,@CanalId,@CodigoCampania,@CodigoConsultora,@SeleccionoMotivo,@CreatedBy,@CreateHost);
	  END
  ELSE
	  BEGIN
	     UPDATE EncuestaResultado SET SeleccionoMotivo = @SeleccionoMotivo,CreatedBy=@CreatedBy,CreatedHost=@CreateHost WHERE Id = @EncuestaResultadoId ---AND  @XMLDetalle IS NOT NULL /*HD-5072*/;
	  END

  IF(@XMLDetalle IS NULL AND @CanalId=3)
  BEGIN
	INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
	VALUES(NEWID(),@EncuestaResultadoId,@EncuestaMotivoId_Tem,NULL,@CreatedBy,@CreateHost)
  END
  ELSE
  BEGIN
	IF EXISTS (SELECT 1 FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
	ELSE
		INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
		   SELECT
				NEWID(),
				@EncuestaResultadoId,
				field.value('id[1]', 'INT') AS MotivoId,
				field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
				@CreatedBy as CreatedBy,
				@CreateHost AS CreateHost
		   FROM
				@XMLDetalle.nodes('//motivo') archivo(field);
  END
  SET @RetornoID = 1;
END
GO


GO
USE BelcorpGuatemala
GO
ALTER PROCEDURE InsertarEncuesta
(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@EncuestaCalificacionId INT = 0,
@RetornoID  INT OUTPUT)
AS
BEGIN

  DECLARE @EncuestaResultadoId uniqueidentifier,
		  @EncuestaMotivoId_Tem INT, --Para el caso que el app no manda detalle se inserta el motivo "Sin motivo"
		  @SeleccionoMotivo INT; --Para evaluar el caso que los motivos vengan vacios
  DECLARE @FlagUsuarioNoRealizoEncuesta BIT = 0;

  SET @RetornoID  = 0;
  SET @EncuestaResultadoId = NULL;
  SET @SeleccionoMotivo = CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END



  IF(@CanalId=3)
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora

		SET @SeleccionoMotivo=1
		SELECT @EncuestaMotivoId_Tem=id FROM EncuestaMotivo WHERE EncuestaCalificacionId=@EncuestaCalificacionId AND TipoEncuestaMotivoId=3
  END
  ELSE
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora
			-- and ER.SeleccionoMotivo = 0; /* HD-5072*/
  END

  IF LEN( @EncuestaResultadoId ) > 0
  BEGIN
    SET @FlagUsuarioNoRealizoEncuesta = 1;
	IF(@CanalId=3)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
  END

  IF (@FlagUsuarioNoRealizoEncuesta = 0)
	  BEGIN
		   SET @EncuestaResultadoId = NEWID();

		  INSERT INTO dbo.EncuestaResultado(Id,EncuestaId,CanalId,CodigoCampania,CodigoConsultora,SeleccionoMotivo,CreatedBy,CreatedHost)
		  VALUES(@EncuestaResultadoId,@EncuestaId,@CanalId,@CodigoCampania,@CodigoConsultora,@SeleccionoMotivo,@CreatedBy,@CreateHost);
	  END
  ELSE
	  BEGIN
	     UPDATE EncuestaResultado SET SeleccionoMotivo = @SeleccionoMotivo,CreatedBy=@CreatedBy,CreatedHost=@CreateHost WHERE Id = @EncuestaResultadoId ---AND  @XMLDetalle IS NOT NULL /*HD-5072*/;
	  END

  IF(@XMLDetalle IS NULL AND @CanalId=3)
  BEGIN
	INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
	VALUES(NEWID(),@EncuestaResultadoId,@EncuestaMotivoId_Tem,NULL,@CreatedBy,@CreateHost)
  END
  ELSE
  BEGIN
	IF EXISTS (SELECT 1 FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
	ELSE
		INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
		   SELECT
				NEWID(),
				@EncuestaResultadoId,
				field.value('id[1]', 'INT') AS MotivoId,
				field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
				@CreatedBy as CreatedBy,
				@CreateHost AS CreateHost
		   FROM
				@XMLDetalle.nodes('//motivo') archivo(field);
  END
  SET @RetornoID = 1;
END
GO


GO
USE BelcorpEcuador
GO
ALTER PROCEDURE InsertarEncuesta
(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@EncuestaCalificacionId INT = 0,
@RetornoID  INT OUTPUT)
AS
BEGIN

  DECLARE @EncuestaResultadoId uniqueidentifier,
		  @EncuestaMotivoId_Tem INT, --Para el caso que el app no manda detalle se inserta el motivo "Sin motivo"
		  @SeleccionoMotivo INT; --Para evaluar el caso que los motivos vengan vacios
  DECLARE @FlagUsuarioNoRealizoEncuesta BIT = 0;

  SET @RetornoID  = 0;
  SET @EncuestaResultadoId = NULL;
  SET @SeleccionoMotivo = CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END



  IF(@CanalId=3)
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora

		SET @SeleccionoMotivo=1
		SELECT @EncuestaMotivoId_Tem=id FROM EncuestaMotivo WHERE EncuestaCalificacionId=@EncuestaCalificacionId AND TipoEncuestaMotivoId=3
  END
  ELSE
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora
			-- and ER.SeleccionoMotivo = 0; /* HD-5072*/
  END

  IF LEN( @EncuestaResultadoId ) > 0
  BEGIN
    SET @FlagUsuarioNoRealizoEncuesta = 1;
	IF(@CanalId=3)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
  END

  IF (@FlagUsuarioNoRealizoEncuesta = 0)
	  BEGIN
		   SET @EncuestaResultadoId = NEWID();

		  INSERT INTO dbo.EncuestaResultado(Id,EncuestaId,CanalId,CodigoCampania,CodigoConsultora,SeleccionoMotivo,CreatedBy,CreatedHost)
		  VALUES(@EncuestaResultadoId,@EncuestaId,@CanalId,@CodigoCampania,@CodigoConsultora,@SeleccionoMotivo,@CreatedBy,@CreateHost);
	  END
  ELSE
	  BEGIN
	     UPDATE EncuestaResultado SET SeleccionoMotivo = @SeleccionoMotivo,CreatedBy=@CreatedBy,CreatedHost=@CreateHost WHERE Id = @EncuestaResultadoId ---AND  @XMLDetalle IS NOT NULL /*HD-5072*/;
	  END

  IF(@XMLDetalle IS NULL AND @CanalId=3)
  BEGIN
	INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
	VALUES(NEWID(),@EncuestaResultadoId,@EncuestaMotivoId_Tem,NULL,@CreatedBy,@CreateHost)
  END
  ELSE
  BEGIN
	IF EXISTS (SELECT 1 FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
	ELSE
		INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
		   SELECT
				NEWID(),
				@EncuestaResultadoId,
				field.value('id[1]', 'INT') AS MotivoId,
				field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
				@CreatedBy as CreatedBy,
				@CreateHost AS CreateHost
		   FROM
				@XMLDetalle.nodes('//motivo') archivo(field);
  END
  SET @RetornoID = 1;
END
GO


GO
USE BelcorpDominicana
GO
ALTER PROCEDURE InsertarEncuesta
(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@EncuestaCalificacionId INT = 0,
@RetornoID  INT OUTPUT)
AS
BEGIN

  DECLARE @EncuestaResultadoId uniqueidentifier,
		  @EncuestaMotivoId_Tem INT, --Para el caso que el app no manda detalle se inserta el motivo "Sin motivo"
		  @SeleccionoMotivo INT; --Para evaluar el caso que los motivos vengan vacios
  DECLARE @FlagUsuarioNoRealizoEncuesta BIT = 0;

  SET @RetornoID  = 0;
  SET @EncuestaResultadoId = NULL;
  SET @SeleccionoMotivo = CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END



  IF(@CanalId=3)
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora

		SET @SeleccionoMotivo=1
		SELECT @EncuestaMotivoId_Tem=id FROM EncuestaMotivo WHERE EncuestaCalificacionId=@EncuestaCalificacionId AND TipoEncuestaMotivoId=3
  END
  ELSE
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora
			-- and ER.SeleccionoMotivo = 0; /* HD-5072*/
  END

  IF LEN( @EncuestaResultadoId ) > 0
  BEGIN
    SET @FlagUsuarioNoRealizoEncuesta = 1;
	IF(@CanalId=3)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
  END

  IF (@FlagUsuarioNoRealizoEncuesta = 0)
	  BEGIN
		   SET @EncuestaResultadoId = NEWID();

		  INSERT INTO dbo.EncuestaResultado(Id,EncuestaId,CanalId,CodigoCampania,CodigoConsultora,SeleccionoMotivo,CreatedBy,CreatedHost)
		  VALUES(@EncuestaResultadoId,@EncuestaId,@CanalId,@CodigoCampania,@CodigoConsultora,@SeleccionoMotivo,@CreatedBy,@CreateHost);
	  END
  ELSE
	  BEGIN
	     UPDATE EncuestaResultado SET SeleccionoMotivo = @SeleccionoMotivo,CreatedBy=@CreatedBy,CreatedHost=@CreateHost WHERE Id = @EncuestaResultadoId ---AND  @XMLDetalle IS NOT NULL /*HD-5072*/;
	  END

  IF(@XMLDetalle IS NULL AND @CanalId=3)
  BEGIN
	INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
	VALUES(NEWID(),@EncuestaResultadoId,@EncuestaMotivoId_Tem,NULL,@CreatedBy,@CreateHost)
  END
  ELSE
  BEGIN
	IF EXISTS (SELECT 1 FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
	ELSE
		INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
		   SELECT
				NEWID(),
				@EncuestaResultadoId,
				field.value('id[1]', 'INT') AS MotivoId,
				field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
				@CreatedBy as CreatedBy,
				@CreateHost AS CreateHost
		   FROM
				@XMLDetalle.nodes('//motivo') archivo(field);
  END
  SET @RetornoID = 1;
END
GO


GO
USE BelcorpCostaRica
GO
ALTER PROCEDURE InsertarEncuesta
(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@EncuestaCalificacionId INT = 0,
@RetornoID  INT OUTPUT)
AS
BEGIN

  DECLARE @EncuestaResultadoId uniqueidentifier,
		  @EncuestaMotivoId_Tem INT, --Para el caso que el app no manda detalle se inserta el motivo "Sin motivo"
		  @SeleccionoMotivo INT; --Para evaluar el caso que los motivos vengan vacios
  DECLARE @FlagUsuarioNoRealizoEncuesta BIT = 0;

  SET @RetornoID  = 0;
  SET @EncuestaResultadoId = NULL;
  SET @SeleccionoMotivo = CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END



  IF(@CanalId=3)
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora

		SET @SeleccionoMotivo=1
		SELECT @EncuestaMotivoId_Tem=id FROM EncuestaMotivo WHERE EncuestaCalificacionId=@EncuestaCalificacionId AND TipoEncuestaMotivoId=3
  END
  ELSE
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora
			-- and ER.SeleccionoMotivo = 0; /* HD-5072*/
  END

  IF LEN( @EncuestaResultadoId ) > 0
  BEGIN
    SET @FlagUsuarioNoRealizoEncuesta = 1;
	IF(@CanalId=3)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
  END

  IF (@FlagUsuarioNoRealizoEncuesta = 0)
	  BEGIN
		   SET @EncuestaResultadoId = NEWID();

		  INSERT INTO dbo.EncuestaResultado(Id,EncuestaId,CanalId,CodigoCampania,CodigoConsultora,SeleccionoMotivo,CreatedBy,CreatedHost)
		  VALUES(@EncuestaResultadoId,@EncuestaId,@CanalId,@CodigoCampania,@CodigoConsultora,@SeleccionoMotivo,@CreatedBy,@CreateHost);
	  END
  ELSE
	  BEGIN
	     UPDATE EncuestaResultado SET SeleccionoMotivo = @SeleccionoMotivo,CreatedBy=@CreatedBy,CreatedHost=@CreateHost WHERE Id = @EncuestaResultadoId ---AND  @XMLDetalle IS NOT NULL /*HD-5072*/;
	  END

  IF(@XMLDetalle IS NULL AND @CanalId=3)
  BEGIN
	INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
	VALUES(NEWID(),@EncuestaResultadoId,@EncuestaMotivoId_Tem,NULL,@CreatedBy,@CreateHost)
  END
  ELSE
  BEGIN
	IF EXISTS (SELECT 1 FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
	ELSE
		INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
		   SELECT
				NEWID(),
				@EncuestaResultadoId,
				field.value('id[1]', 'INT') AS MotivoId,
				field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
				@CreatedBy as CreatedBy,
				@CreateHost AS CreateHost
		   FROM
				@XMLDetalle.nodes('//motivo') archivo(field);
  END
  SET @RetornoID = 1;
END
GO


GO
USE BelcorpChile
GO
ALTER PROCEDURE InsertarEncuesta
(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@EncuestaCalificacionId INT = 0,
@RetornoID  INT OUTPUT)
AS
BEGIN

  DECLARE @EncuestaResultadoId uniqueidentifier,
		  @EncuestaMotivoId_Tem INT, --Para el caso que el app no manda detalle se inserta el motivo "Sin motivo"
		  @SeleccionoMotivo INT; --Para evaluar el caso que los motivos vengan vacios
  DECLARE @FlagUsuarioNoRealizoEncuesta BIT = 0;

  SET @RetornoID  = 0;
  SET @EncuestaResultadoId = NULL;
  SET @SeleccionoMotivo = CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END



  IF(@CanalId=3)
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora

		SET @SeleccionoMotivo=1
		SELECT @EncuestaMotivoId_Tem=id FROM EncuestaMotivo WHERE EncuestaCalificacionId=@EncuestaCalificacionId AND TipoEncuestaMotivoId=3
  END
  ELSE
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora
			-- and ER.SeleccionoMotivo = 0; /* HD-5072*/
  END

  IF LEN( @EncuestaResultadoId ) > 0
  BEGIN
    SET @FlagUsuarioNoRealizoEncuesta = 1;
	IF(@CanalId=3)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
  END

  IF (@FlagUsuarioNoRealizoEncuesta = 0)
	  BEGIN
		   SET @EncuestaResultadoId = NEWID();

		  INSERT INTO dbo.EncuestaResultado(Id,EncuestaId,CanalId,CodigoCampania,CodigoConsultora,SeleccionoMotivo,CreatedBy,CreatedHost)
		  VALUES(@EncuestaResultadoId,@EncuestaId,@CanalId,@CodigoCampania,@CodigoConsultora,@SeleccionoMotivo,@CreatedBy,@CreateHost);
	  END
  ELSE
	  BEGIN
	     UPDATE EncuestaResultado SET SeleccionoMotivo = @SeleccionoMotivo,CreatedBy=@CreatedBy,CreatedHost=@CreateHost WHERE Id = @EncuestaResultadoId ---AND  @XMLDetalle IS NOT NULL /*HD-5072*/;
	  END

  IF(@XMLDetalle IS NULL AND @CanalId=3)
  BEGIN
	INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
	VALUES(NEWID(),@EncuestaResultadoId,@EncuestaMotivoId_Tem,NULL,@CreatedBy,@CreateHost)
  END
  ELSE
  BEGIN
	IF EXISTS (SELECT 1 FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
	ELSE
		INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
		   SELECT
				NEWID(),
				@EncuestaResultadoId,
				field.value('id[1]', 'INT') AS MotivoId,
				field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
				@CreatedBy as CreatedBy,
				@CreateHost AS CreateHost
		   FROM
				@XMLDetalle.nodes('//motivo') archivo(field);
  END
  SET @RetornoID = 1;
END
GO


GO
USE BelcorpBolivia
GO
ALTER PROCEDURE InsertarEncuesta
(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@EncuestaCalificacionId INT = 0,
@RetornoID  INT OUTPUT)
AS
BEGIN

  DECLARE @EncuestaResultadoId uniqueidentifier,
		  @EncuestaMotivoId_Tem INT, --Para el caso que el app no manda detalle se inserta el motivo "Sin motivo"
		  @SeleccionoMotivo INT; --Para evaluar el caso que los motivos vengan vacios
  DECLARE @FlagUsuarioNoRealizoEncuesta BIT = 0;

  SET @RetornoID  = 0;
  SET @EncuestaResultadoId = NULL;
  SET @SeleccionoMotivo = CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END



  IF(@CanalId=3)
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora

		SET @SeleccionoMotivo=1
		SELECT @EncuestaMotivoId_Tem=id FROM EncuestaMotivo WHERE EncuestaCalificacionId=@EncuestaCalificacionId AND TipoEncuestaMotivoId=3
  END
  ELSE
  BEGIN
		SELECT @EncuestaResultadoId = ER.Id
		FROM dbo.EncuestaResultado ER
		WHERE ER.CodigoCampania = @CodigoCampania and
			ER.CodigoConsultora = @CodigoConsultora
			-- and ER.SeleccionoMotivo = 0; /* HD-5072*/
  END

  IF LEN( @EncuestaResultadoId ) > 0
  BEGIN
    SET @FlagUsuarioNoRealizoEncuesta = 1;
	IF(@CanalId=3)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
  END

  IF (@FlagUsuarioNoRealizoEncuesta = 0)
	  BEGIN
		   SET @EncuestaResultadoId = NEWID();

		  INSERT INTO dbo.EncuestaResultado(Id,EncuestaId,CanalId,CodigoCampania,CodigoConsultora,SeleccionoMotivo,CreatedBy,CreatedHost)
		  VALUES(@EncuestaResultadoId,@EncuestaId,@CanalId,@CodigoCampania,@CodigoConsultora,@SeleccionoMotivo,@CreatedBy,@CreateHost);
	  END
  ELSE
	  BEGIN
	     UPDATE EncuestaResultado SET SeleccionoMotivo = @SeleccionoMotivo,CreatedBy=@CreatedBy,CreatedHost=@CreateHost WHERE Id = @EncuestaResultadoId ---AND  @XMLDetalle IS NOT NULL /*HD-5072*/;
	  END

  IF(@XMLDetalle IS NULL AND @CanalId=3)
  BEGIN
	INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
	VALUES(NEWID(),@EncuestaResultadoId,@EncuestaMotivoId_Tem,NULL,@CreatedBy,@CreateHost)
  END
  ELSE
  BEGIN
	IF EXISTS (SELECT 1 FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId)
		DELETE FROM dbo.EncuestaResultadoDetalle WHERE EncuestaResultadoId=@EncuestaResultadoId
	ELSE
		INSERT INTO dbo.EncuestaResultadoDetalle(Id,EncuestaResultadoId,MotivoId,Observacion,CreatedBy,CreatedHost)
		   SELECT
				NEWID(),
				@EncuestaResultadoId,
				field.value('id[1]', 'INT') AS MotivoId,
				field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
				@CreatedBy as CreatedBy,
				@CreateHost AS CreateHost
		   FROM
				@XMLDetalle.nodes('//motivo') archivo(field);
  END
  SET @RetornoID = 1;
END
GO


GO
