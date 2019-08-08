USE BelcorpBolivia
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
	AND DATEDIFF(hour,T.FechaEntregado,GETDATE())>= 24
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
				EC.PreguntaDescripcion,
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
USE BelcorpChile
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
	AND DATEDIFF(hour,T.FechaEntregado,GETDATE())>= 24
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
				EC.PreguntaDescripcion,
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
USE BelcorpColombia
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
	AND DATEDIFF(hour,T.FechaEntregado,GETDATE())>= 24
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
				EC.PreguntaDescripcion,
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
USE BelcorpCostaRica
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
	AND DATEDIFF(hour,T.FechaEntregado,GETDATE())>= 24
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
				EC.PreguntaDescripcion,
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
USE BelcorpDominicana
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
	AND DATEDIFF(hour,T.FechaEntregado,GETDATE())>= 24
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
				EC.PreguntaDescripcion,
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
USE BelcorpEcuador
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
	AND DATEDIFF(hour,T.FechaEntregado,GETDATE())>= 24
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
				EC.PreguntaDescripcion,
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
USE BelcorpGuatemala
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
	AND DATEDIFF(hour,T.FechaEntregado,GETDATE())>= 24
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
				EC.PreguntaDescripcion,
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
USE BelcorpMexico
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
	AND DATEDIFF(hour,T.FechaEntregado,GETDATE())>= 24
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
				EC.PreguntaDescripcion,
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
USE BelcorpPanama
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
	AND DATEDIFF(hour,T.FechaEntregado,GETDATE())>= 24
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
				EC.PreguntaDescripcion,
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
USE BelcorpPeru
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
	AND DATEDIFF(hour,T.FechaEntregado,GETDATE())>= 24
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
				EC.PreguntaDescripcion,
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
USE BelcorpPuertoRico
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
	AND DATEDIFF(hour,T.FechaEntregado,GETDATE())>= 24
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
				EC.PreguntaDescripcion,
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

USE BelcorpSalvador
GO

IF EXISTS(SELECT * FROM sys.procedures WHERE name = 'ObtenerDataEncuesta')
BEGIN
 DROP PROCEDURE ObtenerDataEncuesta;
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
	AND DATEDIFF(hour,T.FechaEntregado,GETDATE())>= 24
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
				EC.PreguntaDescripcion,
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