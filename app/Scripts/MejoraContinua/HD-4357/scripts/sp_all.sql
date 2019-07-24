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

CREATE PROCEDURE ObtenerDataEncuesta

(
@CodigoConsultora NVARCHAR(25) = '',
@VerificarEncuestado INT  = 1
)

AS
BEGIN

DECLARE @vMostrarEncuesta INT = 0;
DECLARE @vCodigoCampanaia VARCHAR(6) = '';

   IF @VerificarEncuestado  = 1
   BEGIN
    SELECT  
		 @vMostrarEncuesta = ISNULL( COUNT(*),0),
		 @vCodigoCampanaia = T.Campana
	FROM (
		 SELECT 
			  top 1 FechaEntregado,
			  Codigo,
			  Campana 
		 FROM 
			  ods.ApePedido 
		 WHERE
		      codigo = @CodigoConsultora
		 ORDER BY Campana desc) AS T		 
	WHERE
	T.FechaEntregado IS NOT NULL
	AND DATEADD(DAY ,1, T.FechaEntregado) <= GETDATE()
	AND NOT EXISTS(
			  SELECT 
				   ER.CodigoConsultora
			  FROM 
				   dbo.EncuestaResultado AS ER
			  WHERE 
				   ER.CodigoCampania = T.Campana
				   AND ER.CodigoConsultora = @CodigoConsultora
			 )
	GROUP BY T.Campana
   END

	IF ((@vMostrarEncuesta > 0 AND @VerificarEncuestado = 1) OR  @VerificarEncuestado = 0)
		BEGIN
			SELECT
			    @vCodigoCampanaia AS CodigoCampania,
				E.Id  as EncuestaId,
				EC.Id AS CalificacionId,
				EC.TipoCalificacion AS TipoCalificacion,
				EC.Descripcion AS Calificacion,
				EC.CssClass as EstiloCalificacion,
				EC.Imagen as ImagenCalificacion,
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
			field.value('id[1]', 'INT') AS MotivoId,
			field.value('obs[1]', 'NVARCHAR(max)') AS Observacion,
			@CreatedBy as CreatedBy,
			@CreateHost AS CreateHost
	   FROM 
			@XMLDetalle.nodes('//motivo') archivo(field);

  SET @RetornoID = 1;
END
GO









