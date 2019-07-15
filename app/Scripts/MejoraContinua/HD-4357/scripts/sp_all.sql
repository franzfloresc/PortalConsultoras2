use BelcorpPeru_MC
go

IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'ObtenerDataEncuesta')
BEGIN
 DROP PROCEDURE ObtenerDataEncuesta;
END

GO

IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'InsertarEncuesta')
BEGIN
 DROP PROCEDURE InsertarEncuesta;
END

GO

CREATE PROCEDURE ObtenerDataEncuesta(
@CodigoConsultora NVARCHAR(25) = ''
)

AS
BEGIN

DECLARE @vMostrarEncuesta INT = 0;

	SELECT  
		 @vMostrarEncuesta = ISNULL( COUNT(*),0) 
	FROM (
		 SELECT 
			  top 1 FechaEntregado,
			  Codigo,
			  Campana 
		 FROM 
			  ods.ApePedido 
		 WHERE
			  FechaEntregado is not null
			  AND codigo = @CodigoConsultora
		 ORDER BY Campana desc) AS T
	WHERE 
	DATEADD(DAY ,1, T.FechaEntregado) <= GETDATE()
	AND NOT EXISTS(
			  SELECT 
				   ER.CodigoConsultora
			  FROM 
				   dbo.EncuestaResultado AS ER
			  WHERE 
				   ER.CodigoCampania = T.Campana
				   AND ER.CodigoConsultora = @CodigoConsultora
			 )

	IF @vMostrarEncuesta > 0 
		BEGIN
			SELECT
				E.Id  as EncuestaId,
				EC.Id AS CalificacionId,
				EC.TipoCalificacion AS TipoCalificacion,
				EC.Descripcion AS Calificacion, 
				EM.Id as MotivoId,
				EM.TipoEncuestaMotivoId AS TipoMotivo,
				EM.Descripcion as Motivo
			FROM dbo.EncuestaMotivo as EM 
			INNER JOIN dbo.EncuestaCalificacion EC on EM.EncuestaCalificacionId = EC.Id
			INNER JOIN dbo.Encuesta as E ON EC.EncuestaId = E.Id
			WHERE E.Status = 1
			AND E.Prioridad = 1
		END
	ELSE
	    BEGIN
		  SELECT
				0  as EncuestaId,
				0 AS CalificacionId,
				0 AS TipoCalificacion,
				'' AS Calificacion, 
				0 as MotivoId,
				0 AS TipoMotivo,
				'' as Motivo
		END
END
GO


CREATE PROCEDURE InsertarEncuesta(
@EncuestaId INT = 0,
@CanalId INT = 0,
@CodigoCampania NVARCHAR(8) = '',
@CodigoConsultora NVARCHAR(25) = '',
@CreatedBy NVARCHAR(30)='',
@CreateHost NVARCHAR(20) = '',
@XMLDetalle XML = NULL
)
AS
BEGIN
   
  DECLARE @EncuestaResultadoId uniqueidentifier;

  SET @EncuestaResultadoId = NEWID();

  INSERT INTO dbo.EncuestaResultado(
	   Id,
	   EncuestaId,
	   CanalId,
	   CodigoCampania,
	   CodigoConsultora,
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
			field.value('MotivoId[1]', 'INT') AS MotivoId,
			field.value('Observacion[1]', 'NVARCHAR(max)') AS Observacion,
			@CreatedBy as CreatedBy,
			@CreateHost AS CreateHost
	   FROM 
			@XMLDetalle.nodes('//motivo') archivo(field);
END
GO








