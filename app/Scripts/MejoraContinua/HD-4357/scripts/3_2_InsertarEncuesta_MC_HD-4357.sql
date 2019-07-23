USE BelcorpBolivia
GO
IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'InsertarEncuesta')
BEGIN
 DROP PROCEDURE InsertarEncuesta;
END

GO

CREATE PROCEDURE InsertarEncuesta(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@RetornoID  INT OUTPUT)
AS
BEGIN
   
  DECLARE @EncuestaResultadoId uniqueidentifier;

  SET @RetornoID  = 0;

  SET @EncuestaResultadoId = NEWID();

  INSERT INTO dbo.EncuestaResultado(
	   Id,
	   EncuestaId,
	   CanalId,
	   CodigoCampania,
	   CodigoConsultora,
	   SeleccionoMotivo,
	   CreatedBy,
	   CreatedHost
   )
  VALUES
  (
	  @EncuestaResultadoId,
	  @EncuestaId,
	  @CanalId,
	  @CodigoCampania,
	  @CodigoConsultora,
	  CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END,
	  @CreatedBy,
	  @CreateHost
  );
  
  INSERT INTO 
		  dbo.EncuestaResultadoDetalle
		   (
			Id
		   ,EncuestaResultadoId
		   ,MotivoId
		   ,Observacion
		   ,CreatedBy
		   ,CreatedHost
		   )
	   SELECT 
			NEWID(),
			@EncuestaResultadoId,
			field.value('id[1]', 'INT') AS MotivoId,
			field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
			@CreatedBy as CreatedBy,
			@CreateHost AS CreateHost
	   FROM 
			@XMLDetalle.nodes('//motivo') archivo(field);

  SET @RetornoID = 1;
END
GO


USE BelcorpChile
GO
IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'InsertarEncuesta')
BEGIN
 DROP PROCEDURE InsertarEncuesta;
END

GO

CREATE PROCEDURE InsertarEncuesta(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@RetornoID  INT OUTPUT)
AS
BEGIN
   
  DECLARE @EncuestaResultadoId uniqueidentifier;

  SET @RetornoID  = 0;

  SET @EncuestaResultadoId = NEWID();

  INSERT INTO dbo.EncuestaResultado(
	   Id,
	   EncuestaId,
	   CanalId,
	   CodigoCampania,
	   CodigoConsultora,
	   SeleccionoMotivo,
	   CreatedBy,
	   CreatedHost
   )
  VALUES
  (
	  @EncuestaResultadoId,
	  @EncuestaId,
	  @CanalId,
	  @CodigoCampania,
	  @CodigoConsultora,
	  CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END,
	  @CreatedBy,
	  @CreateHost
  );
  
  INSERT INTO 
		  dbo.EncuestaResultadoDetalle
		   (
			Id
		   ,EncuestaResultadoId
		   ,MotivoId
		   ,Observacion
		   ,CreatedBy
		   ,CreatedHost
		   )
	   SELECT 
			NEWID(),
			@EncuestaResultadoId,
			field.value('id[1]', 'INT') AS MotivoId,
			field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
			@CreatedBy as CreatedBy,
			@CreateHost AS CreateHost
	   FROM 
			@XMLDetalle.nodes('//motivo') archivo(field);

  SET @RetornoID = 1;
END
GO


USE BelcorpColombia
GO
IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'InsertarEncuesta')
BEGIN
 DROP PROCEDURE InsertarEncuesta;
END

GO

CREATE PROCEDURE InsertarEncuesta(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@RetornoID  INT OUTPUT)
AS
BEGIN
   
  DECLARE @EncuestaResultadoId uniqueidentifier;

  SET @RetornoID  = 0;

  SET @EncuestaResultadoId = NEWID();

  INSERT INTO dbo.EncuestaResultado(
	   Id,
	   EncuestaId,
	   CanalId,
	   CodigoCampania,
	   CodigoConsultora,
	   SeleccionoMotivo,
	   CreatedBy,
	   CreatedHost
   )
  VALUES
  (
	  @EncuestaResultadoId,
	  @EncuestaId,
	  @CanalId,
	  @CodigoCampania,
	  @CodigoConsultora,
	  CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END,
	  @CreatedBy,
	  @CreateHost
  );
  
  INSERT INTO 
		  dbo.EncuestaResultadoDetalle
		   (
			Id
		   ,EncuestaResultadoId
		   ,MotivoId
		   ,Observacion
		   ,CreatedBy
		   ,CreatedHost
		   )
	   SELECT 
			NEWID(),
			@EncuestaResultadoId,
			field.value('id[1]', 'INT') AS MotivoId,
			field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
			@CreatedBy as CreatedBy,
			@CreateHost AS CreateHost
	   FROM 
			@XMLDetalle.nodes('//motivo') archivo(field);

  SET @RetornoID = 1;
END
GO

	
USE BelcorpCostaRica
GO
IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'InsertarEncuesta')
BEGIN
 DROP PROCEDURE InsertarEncuesta;
END

GO

CREATE PROCEDURE InsertarEncuesta(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@RetornoID  INT OUTPUT)
AS
BEGIN
   
  DECLARE @EncuestaResultadoId uniqueidentifier;

  SET @RetornoID  = 0;

  SET @EncuestaResultadoId = NEWID();

  INSERT INTO dbo.EncuestaResultado(
	   Id,
	   EncuestaId,
	   CanalId,
	   CodigoCampania,
	   CodigoConsultora,
	   SeleccionoMotivo,
	   CreatedBy,
	   CreatedHost
   )
  VALUES
  (
	  @EncuestaResultadoId,
	  @EncuestaId,
	  @CanalId,
	  @CodigoCampania,
	  @CodigoConsultora,
	  CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END,
	  @CreatedBy,
	  @CreateHost
  );
  
  INSERT INTO 
		  dbo.EncuestaResultadoDetalle
		   (
			Id
		   ,EncuestaResultadoId
		   ,MotivoId
		   ,Observacion
		   ,CreatedBy
		   ,CreatedHost
		   )
	   SELECT 
			NEWID(),
			@EncuestaResultadoId,
			field.value('id[1]', 'INT') AS MotivoId,
			field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
			@CreatedBy as CreatedBy,
			@CreateHost AS CreateHost
	   FROM 
			@XMLDetalle.nodes('//motivo') archivo(field);

  SET @RetornoID = 1;
END
GO


USE BelcorpDominicana
GO
IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'InsertarEncuesta')
BEGIN
 DROP PROCEDURE InsertarEncuesta;
END

GO

CREATE PROCEDURE InsertarEncuesta(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@RetornoID  INT OUTPUT)
AS
BEGIN
   
  DECLARE @EncuestaResultadoId uniqueidentifier;

  SET @RetornoID  = 0;

  SET @EncuestaResultadoId = NEWID();

  INSERT INTO dbo.EncuestaResultado(
	   Id,
	   EncuestaId,
	   CanalId,
	   CodigoCampania,
	   CodigoConsultora,
	   SeleccionoMotivo,
	   CreatedBy,
	   CreatedHost
   )
  VALUES
  (
	  @EncuestaResultadoId,
	  @EncuestaId,
	  @CanalId,
	  @CodigoCampania,
	  @CodigoConsultora,
	  CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END,
	  @CreatedBy,
	  @CreateHost
  );
  
  INSERT INTO 
		  dbo.EncuestaResultadoDetalle
		   (
			Id
		   ,EncuestaResultadoId
		   ,MotivoId
		   ,Observacion
		   ,CreatedBy
		   ,CreatedHost
		   )
	   SELECT 
			NEWID(),
			@EncuestaResultadoId,
			field.value('id[1]', 'INT') AS MotivoId,
			field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
			@CreatedBy as CreatedBy,
			@CreateHost AS CreateHost
	   FROM 
			@XMLDetalle.nodes('//motivo') archivo(field);

  SET @RetornoID = 1;
END
GO


USE BelcorpEcuador
GO
IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'InsertarEncuesta')
BEGIN
 DROP PROCEDURE InsertarEncuesta;
END

GO

CREATE PROCEDURE InsertarEncuesta(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@RetornoID  INT OUTPUT)
AS
BEGIN
   
  DECLARE @EncuestaResultadoId uniqueidentifier;

  SET @RetornoID  = 0;

  SET @EncuestaResultadoId = NEWID();

  INSERT INTO dbo.EncuestaResultado(
	   Id,
	   EncuestaId,
	   CanalId,
	   CodigoCampania,
	   CodigoConsultora,
	   SeleccionoMotivo,
	   CreatedBy,
	   CreatedHost
   )
  VALUES
  (
	  @EncuestaResultadoId,
	  @EncuestaId,
	  @CanalId,
	  @CodigoCampania,
	  @CodigoConsultora,
	  CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END,
	  @CreatedBy,
	  @CreateHost
  );
  
  INSERT INTO 
		  dbo.EncuestaResultadoDetalle
		   (
			Id
		   ,EncuestaResultadoId
		   ,MotivoId
		   ,Observacion
		   ,CreatedBy
		   ,CreatedHost
		   )
	   SELECT 
			NEWID(),
			@EncuestaResultadoId,
			field.value('id[1]', 'INT') AS MotivoId,
			field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
			@CreatedBy as CreatedBy,
			@CreateHost AS CreateHost
	   FROM 
			@XMLDetalle.nodes('//motivo') archivo(field);

  SET @RetornoID = 1;
END
GO


USE BelcorpGuatemala
GO
IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'InsertarEncuesta')
BEGIN
 DROP PROCEDURE InsertarEncuesta;
END

GO

CREATE PROCEDURE InsertarEncuesta(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@RetornoID  INT OUTPUT)
AS
BEGIN
   
  DECLARE @EncuestaResultadoId uniqueidentifier;

  SET @RetornoID  = 0;

  SET @EncuestaResultadoId = NEWID();

  INSERT INTO dbo.EncuestaResultado(
	   Id,
	   EncuestaId,
	   CanalId,
	   CodigoCampania,
	   CodigoConsultora,
	   SeleccionoMotivo,
	   CreatedBy,
	   CreatedHost
   )
  VALUES
  (
	  @EncuestaResultadoId,
	  @EncuestaId,
	  @CanalId,
	  @CodigoCampania,
	  @CodigoConsultora,
	  CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END,
	  @CreatedBy,
	  @CreateHost
  );
  
  INSERT INTO 
		  dbo.EncuestaResultadoDetalle
		   (
			Id
		   ,EncuestaResultadoId
		   ,MotivoId
		   ,Observacion
		   ,CreatedBy
		   ,CreatedHost
		   )
	   SELECT 
			NEWID(),
			@EncuestaResultadoId,
			field.value('id[1]', 'INT') AS MotivoId,
			field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
			@CreatedBy as CreatedBy,
			@CreateHost AS CreateHost
	   FROM 
			@XMLDetalle.nodes('//motivo') archivo(field);

  SET @RetornoID = 1;
END
GO


USE BelcorpMexico
GO
IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'InsertarEncuesta')
BEGIN
 DROP PROCEDURE InsertarEncuesta;
END

GO

CREATE PROCEDURE InsertarEncuesta(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@RetornoID  INT OUTPUT)
AS
BEGIN
   
  DECLARE @EncuestaResultadoId uniqueidentifier;

  SET @RetornoID  = 0;

  SET @EncuestaResultadoId = NEWID();

  INSERT INTO dbo.EncuestaResultado(
	   Id,
	   EncuestaId,
	   CanalId,
	   CodigoCampania,
	   CodigoConsultora,
	   SeleccionoMotivo,
	   CreatedBy,
	   CreatedHost
   )
  VALUES
  (
	  @EncuestaResultadoId,
	  @EncuestaId,
	  @CanalId,
	  @CodigoCampania,
	  @CodigoConsultora,
	  CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END,
	  @CreatedBy,
	  @CreateHost
  );
  
  INSERT INTO 
		  dbo.EncuestaResultadoDetalle
		   (
			Id
		   ,EncuestaResultadoId
		   ,MotivoId
		   ,Observacion
		   ,CreatedBy
		   ,CreatedHost
		   )
	   SELECT 
			NEWID(),
			@EncuestaResultadoId,
			field.value('id[1]', 'INT') AS MotivoId,
			field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
			@CreatedBy as CreatedBy,
			@CreateHost AS CreateHost
	   FROM 
			@XMLDetalle.nodes('//motivo') archivo(field);

  SET @RetornoID = 1;
END
GO


USE BelcorpPanama
GO
IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'InsertarEncuesta')
BEGIN
 DROP PROCEDURE InsertarEncuesta;
END

GO

CREATE PROCEDURE InsertarEncuesta(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@RetornoID  INT OUTPUT)
AS
BEGIN
   
  DECLARE @EncuestaResultadoId uniqueidentifier;

  SET @RetornoID  = 0;

  SET @EncuestaResultadoId = NEWID();

  INSERT INTO dbo.EncuestaResultado(
	   Id,
	   EncuestaId,
	   CanalId,
	   CodigoCampania,
	   CodigoConsultora,
	   SeleccionoMotivo,
	   CreatedBy,
	   CreatedHost
   )
  VALUES
  (
	  @EncuestaResultadoId,
	  @EncuestaId,
	  @CanalId,
	  @CodigoCampania,
	  @CodigoConsultora,
	  CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END,
	  @CreatedBy,
	  @CreateHost
  );
  
  INSERT INTO 
		  dbo.EncuestaResultadoDetalle
		   (
			Id
		   ,EncuestaResultadoId
		   ,MotivoId
		   ,Observacion
		   ,CreatedBy
		   ,CreatedHost
		   )
	   SELECT 
			NEWID(),
			@EncuestaResultadoId,
			field.value('id[1]', 'INT') AS MotivoId,
			field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
			@CreatedBy as CreatedBy,
			@CreateHost AS CreateHost
	   FROM 
			@XMLDetalle.nodes('//motivo') archivo(field);

  SET @RetornoID = 1;
END
GO


USE BelcorpPeru
GO
IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'InsertarEncuesta')
BEGIN
 DROP PROCEDURE InsertarEncuesta;
END

GO

CREATE PROCEDURE InsertarEncuesta(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@RetornoID  INT OUTPUT)
AS
BEGIN
   
  DECLARE @EncuestaResultadoId uniqueidentifier;

  SET @RetornoID  = 0;

  SET @EncuestaResultadoId = NEWID();

  INSERT INTO dbo.EncuestaResultado(
	   Id,
	   EncuestaId,
	   CanalId,
	   CodigoCampania,
	   CodigoConsultora,
	   SeleccionoMotivo,
	   CreatedBy,
	   CreatedHost
   )
  VALUES
  (
	  @EncuestaResultadoId,
	  @EncuestaId,
	  @CanalId,
	  @CodigoCampania,
	  @CodigoConsultora,
	  CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END,
	  @CreatedBy,
	  @CreateHost
  );
  
  INSERT INTO 
		  dbo.EncuestaResultadoDetalle
		   (
			Id
		   ,EncuestaResultadoId
		   ,MotivoId
		   ,Observacion
		   ,CreatedBy
		   ,CreatedHost
		   )
	   SELECT 
			NEWID(),
			@EncuestaResultadoId,
			field.value('id[1]', 'INT') AS MotivoId,
			field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
			@CreatedBy as CreatedBy,
			@CreateHost AS CreateHost
	   FROM 
			@XMLDetalle.nodes('//motivo') archivo(field);

  SET @RetornoID = 1;
END
GO


USE BelcorpPuertoRico
GO
IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'InsertarEncuesta')
BEGIN
 DROP PROCEDURE InsertarEncuesta;
END

GO

CREATE PROCEDURE InsertarEncuesta(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@RetornoID  INT OUTPUT)
AS
BEGIN
   
  DECLARE @EncuestaResultadoId uniqueidentifier;

  SET @RetornoID  = 0;

  SET @EncuestaResultadoId = NEWID();

  INSERT INTO dbo.EncuestaResultado(
	   Id,
	   EncuestaId,
	   CanalId,
	   CodigoCampania,
	   CodigoConsultora,
	   SeleccionoMotivo,
	   CreatedBy,
	   CreatedHost
   )
  VALUES
  (
	  @EncuestaResultadoId,
	  @EncuestaId,
	  @CanalId,
	  @CodigoCampania,
	  @CodigoConsultora,
	  CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END,
	  @CreatedBy,
	  @CreateHost
  );
  
  INSERT INTO 
		  dbo.EncuestaResultadoDetalle
		   (
			Id
		   ,EncuestaResultadoId
		   ,MotivoId
		   ,Observacion
		   ,CreatedBy
		   ,CreatedHost
		   )
	   SELECT 
			NEWID(),
			@EncuestaResultadoId,
			field.value('id[1]', 'INT') AS MotivoId,
			field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
			@CreatedBy as CreatedBy,
			@CreateHost AS CreateHost
	   FROM 
			@XMLDetalle.nodes('//motivo') archivo(field);

  SET @RetornoID = 1;
END
GO


USE BelcorpSalvador
GO

IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'InsertarEncuesta')
BEGIN
 DROP PROCEDURE InsertarEncuesta;
END

GO

CREATE PROCEDURE InsertarEncuesta(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL,
@RetornoID  INT OUTPUT)
AS
BEGIN
   
  DECLARE @EncuestaResultadoId uniqueidentifier;

  SET @RetornoID  = 0;

  SET @EncuestaResultadoId = NEWID();

  INSERT INTO dbo.EncuestaResultado(
	   Id,
	   EncuestaId,
	   CanalId,
	   CodigoCampania,
	   CodigoConsultora,
	   SeleccionoMotivo,
	   CreatedBy,
	   CreatedHost
   )
  VALUES
  (
	  @EncuestaResultadoId,
	  @EncuestaId,
	  @CanalId,
	  @CodigoCampania,
	  @CodigoConsultora,
	  CASE WHEN @XMLDetalle IS NULL THEN 0 ELSE 1 END,
	  @CreatedBy,
	  @CreateHost
  );
  
  INSERT INTO 
		  dbo.EncuestaResultadoDetalle
		   (
			Id
		   ,EncuestaResultadoId
		   ,MotivoId
		   ,Observacion
		   ,CreatedBy
		   ,CreatedHost
		   )
	   SELECT 
			NEWID(),
			@EncuestaResultadoId,
			field.value('id[1]', 'INT') AS MotivoId,
			field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
			@CreatedBy as CreatedBy,
			@CreateHost AS CreateHost
	   FROM 
			@XMLDetalle.nodes('//motivo') archivo(field);

  SET @RetornoID = 1;
END
GO

