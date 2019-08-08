USE [BelcorpBolivia];
GO
IF (OBJECT_ID(N'[chatbot].[ListResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[ListResultados]
GO

CREATE PROCEDURE [chatbot].[ListResultados]
	@Pais VARCHAR(2),
	@CodigoConsultora VARCHAR(25),
	@NombreOperador VARCHAR(100),
	@FechaInicio DATE = NULL,
	@FechaFin DATE = NULL
AS
BEGIN
Declare @NameResp VARCHAR(50);
Declare @NameRespDescrip VARCHAR(50);
set @NameResp = 'Resp';
set @NameRespDescrip = 'RespDescrip';


SELECT
	P.ResultadosID,
	P.OperadorID,
	P.NombreOperador,
	P.CodigoConsultora,
	P.NombreConsultora,
	P.FechaInicio,
	P.FechaFin,
	P.Campania,
	P.Pais,
	P.ConversacionID,
	Q.Descripcion as CanalDescripcion,
	T3.Resp1,
	T3.Resp2,
	T3.Resp3,
	T3.RespDescrip1,
	T3.RespDescrip2,
	T3.RespDescrip3
FROM
  chatbot.Resultados P
  inner join chatbot.Canal AS Q with(nolock) ON Q.CanalId = P.CanalId
  LEFT JOIN
(SELECT T1.*,T2.* FROM
 (SELECT *
	 FROM(
	   select
	       dr.ResultadosID AS Det1ResultadosID
		  ,CONCAT(@NameResp,CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
		  ,c.Valor
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS C
	PIVOT (max(Valor) FOR PreguntaId IN ([Resp1],[Resp2],[Resp3])) pv1) as T1
	INNER JOIN
  (SELECT *
	 FROM(
	   select
	   dr.ResultadosID AS Det2ResultadosID,
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
			  ,dr.Cualitativo
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Cualitativo) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
	T1.Det1ResultadosID = T2.Det2ResultadosID) AS T3
	ON P.ResultadosID = T3.Det1ResultadosID
	WHERE
	((@CodigoConsultora is null)  or (P.CodigoConsultora = @CodigoConsultora))
	AND ((@NombreOperador is null)  or (P.NombreOperador like '%'+@NombreOperador+'%'))
	AND (@FechaInicio is null or @FechaInicio <= CONVERT(date, P.FechaInicio))
	AND (@FechaFin is null or @FechaFin >= CONVERT(date, P.FechaInicio))
	ORDER BY P.ResultadosID DESC;

END
GO
USE [BelcorpChile];
GO
IF (OBJECT_ID(N'[chatbot].[ListResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[ListResultados]
GO

CREATE PROCEDURE [chatbot].[ListResultados]
	@Pais VARCHAR(2),
	@CodigoConsultora VARCHAR(25),
	@NombreOperador VARCHAR(100),
	@FechaInicio DATE = NULL,
	@FechaFin DATE = NULL
AS
BEGIN
Declare @NameResp VARCHAR(50);
Declare @NameRespDescrip VARCHAR(50);
set @NameResp = 'Resp';
set @NameRespDescrip = 'RespDescrip';


SELECT
	P.ResultadosID,
	P.OperadorID,
	P.NombreOperador,
	P.CodigoConsultora,
	P.NombreConsultora,
	P.FechaInicio,
	P.FechaFin,
	P.Campania,
	P.Pais,
	P.ConversacionID,
	Q.Descripcion as CanalDescripcion,
	T3.Resp1,
	T3.Resp2,
	T3.Resp3,
	T3.RespDescrip1,
	T3.RespDescrip2,
	T3.RespDescrip3
FROM
  chatbot.Resultados P
  inner join chatbot.Canal AS Q with(nolock) ON Q.CanalId = P.CanalId
  LEFT JOIN
(SELECT T1.*,T2.* FROM
 (SELECT *
	 FROM(
	   select
	       dr.ResultadosID AS Det1ResultadosID
		  ,CONCAT(@NameResp,CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
		  ,c.Valor
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS C
	PIVOT (max(Valor) FOR PreguntaId IN ([Resp1],[Resp2],[Resp3])) pv1) as T1
	INNER JOIN
  (SELECT *
	 FROM(
	   select
	   dr.ResultadosID AS Det2ResultadosID,
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
			  ,dr.Cualitativo
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Cualitativo) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
	T1.Det1ResultadosID = T2.Det2ResultadosID) AS T3
	ON P.ResultadosID = T3.Det1ResultadosID
	WHERE
	((@CodigoConsultora is null)  or (P.CodigoConsultora = @CodigoConsultora))
	AND ((@NombreOperador is null)  or (P.NombreOperador like '%'+@NombreOperador+'%'))
	AND (@FechaInicio is null or @FechaInicio <= CONVERT(date, P.FechaInicio))
	AND (@FechaFin is null or @FechaFin >= CONVERT(date, P.FechaInicio))
	ORDER BY P.ResultadosID DESC;

END
GO
USE [BelcorpColombia];
GO
IF (OBJECT_ID(N'[chatbot].[ListResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[ListResultados]
GO

CREATE PROCEDURE [chatbot].[ListResultados]
	@Pais VARCHAR(2),
	@CodigoConsultora VARCHAR(25),
	@NombreOperador VARCHAR(100),
	@FechaInicio DATE = NULL,
	@FechaFin DATE = NULL
AS
BEGIN
Declare @NameResp VARCHAR(50);
Declare @NameRespDescrip VARCHAR(50);
set @NameResp = 'Resp';
set @NameRespDescrip = 'RespDescrip';


SELECT
	P.ResultadosID,
	P.OperadorID,
	P.NombreOperador,
	P.CodigoConsultora,
	P.NombreConsultora,
	P.FechaInicio,
	P.FechaFin,
	P.Campania,
	P.Pais,
	P.ConversacionID,
	Q.Descripcion as CanalDescripcion,
	T3.Resp1,
	T3.Resp2,
	T3.Resp3,
	T3.RespDescrip1,
	T3.RespDescrip2,
	T3.RespDescrip3
FROM
  chatbot.Resultados P
  inner join chatbot.Canal AS Q with(nolock) ON Q.CanalId = P.CanalId
  LEFT JOIN
(SELECT T1.*,T2.* FROM
 (SELECT *
	 FROM(
	   select
	       dr.ResultadosID AS Det1ResultadosID
		  ,CONCAT(@NameResp,CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
		  ,c.Valor
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS C
	PIVOT (max(Valor) FOR PreguntaId IN ([Resp1],[Resp2],[Resp3])) pv1) as T1
	INNER JOIN
  (SELECT *
	 FROM(
	   select
	   dr.ResultadosID AS Det2ResultadosID,
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
			  ,dr.Cualitativo
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Cualitativo) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
	T1.Det1ResultadosID = T2.Det2ResultadosID) AS T3
	ON P.ResultadosID = T3.Det1ResultadosID
	WHERE
	((@CodigoConsultora is null)  or (P.CodigoConsultora = @CodigoConsultora))
	AND ((@NombreOperador is null)  or (P.NombreOperador like '%'+@NombreOperador+'%'))
	AND (@FechaInicio is null or @FechaInicio <= CONVERT(date, P.FechaInicio))
	AND (@FechaFin is null or @FechaFin >= CONVERT(date, P.FechaInicio))
	ORDER BY P.ResultadosID DESC;

END
GO
USE [BelcorpCostaRica];
GO
IF (OBJECT_ID(N'[chatbot].[ListResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[ListResultados]
GO

CREATE PROCEDURE [chatbot].[ListResultados]
	@Pais VARCHAR(2),
	@CodigoConsultora VARCHAR(25),
	@NombreOperador VARCHAR(100),
	@FechaInicio DATE = NULL,
	@FechaFin DATE = NULL
AS
BEGIN
Declare @NameResp VARCHAR(50);
Declare @NameRespDescrip VARCHAR(50);
set @NameResp = 'Resp';
set @NameRespDescrip = 'RespDescrip';


SELECT
	P.ResultadosID,
	P.OperadorID,
	P.NombreOperador,
	P.CodigoConsultora,
	P.NombreConsultora,
	P.FechaInicio,
	P.FechaFin,
	P.Campania,
	P.Pais,
	P.ConversacionID,
	Q.Descripcion as CanalDescripcion,
	T3.Resp1,
	T3.Resp2,
	T3.Resp3,
	T3.RespDescrip1,
	T3.RespDescrip2,
	T3.RespDescrip3
FROM
  chatbot.Resultados P
  inner join chatbot.Canal AS Q with(nolock) ON Q.CanalId = P.CanalId
  LEFT JOIN
(SELECT T1.*,T2.* FROM
 (SELECT *
	 FROM(
	   select
	       dr.ResultadosID AS Det1ResultadosID
		  ,CONCAT(@NameResp,CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
		  ,c.Valor
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS C
	PIVOT (max(Valor) FOR PreguntaId IN ([Resp1],[Resp2],[Resp3])) pv1) as T1
	INNER JOIN
  (SELECT *
	 FROM(
	   select
	   dr.ResultadosID AS Det2ResultadosID,
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
			  ,dr.Cualitativo
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Cualitativo) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
	T1.Det1ResultadosID = T2.Det2ResultadosID) AS T3
	ON P.ResultadosID = T3.Det1ResultadosID
	WHERE
	((@CodigoConsultora is null)  or (P.CodigoConsultora = @CodigoConsultora))
	AND ((@NombreOperador is null)  or (P.NombreOperador like '%'+@NombreOperador+'%'))
	AND (@FechaInicio is null or @FechaInicio <= CONVERT(date, P.FechaInicio))
	AND (@FechaFin is null or @FechaFin >= CONVERT(date, P.FechaInicio))
	ORDER BY P.ResultadosID DESC;

END
GO
USE [BelcorpDominicana];
GO
IF (OBJECT_ID(N'[chatbot].[ListResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[ListResultados]
GO

CREATE PROCEDURE [chatbot].[ListResultados]
	@Pais VARCHAR(2),
	@CodigoConsultora VARCHAR(25),
	@NombreOperador VARCHAR(100),
	@FechaInicio DATE = NULL,
	@FechaFin DATE = NULL
AS
BEGIN
Declare @NameResp VARCHAR(50);
Declare @NameRespDescrip VARCHAR(50);
set @NameResp = 'Resp';
set @NameRespDescrip = 'RespDescrip';


SELECT
	P.ResultadosID,
	P.OperadorID,
	P.NombreOperador,
	P.CodigoConsultora,
	P.NombreConsultora,
	P.FechaInicio,
	P.FechaFin,
	P.Campania,
	P.Pais,
	P.ConversacionID,
	Q.Descripcion as CanalDescripcion,
	T3.Resp1,
	T3.Resp2,
	T3.Resp3,
	T3.RespDescrip1,
	T3.RespDescrip2,
	T3.RespDescrip3
FROM
  chatbot.Resultados P
  inner join chatbot.Canal AS Q with(nolock) ON Q.CanalId = P.CanalId
  LEFT JOIN
(SELECT T1.*,T2.* FROM
 (SELECT *
	 FROM(
	   select
	       dr.ResultadosID AS Det1ResultadosID
		  ,CONCAT(@NameResp,CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
		  ,c.Valor
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS C
	PIVOT (max(Valor) FOR PreguntaId IN ([Resp1],[Resp2],[Resp3])) pv1) as T1
	INNER JOIN
  (SELECT *
	 FROM(
	   select
	   dr.ResultadosID AS Det2ResultadosID,
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
			  ,dr.Cualitativo
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Cualitativo) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
	T1.Det1ResultadosID = T2.Det2ResultadosID) AS T3
	ON P.ResultadosID = T3.Det1ResultadosID
	WHERE
	((@CodigoConsultora is null)  or (P.CodigoConsultora = @CodigoConsultora))
	AND ((@NombreOperador is null)  or (P.NombreOperador like '%'+@NombreOperador+'%'))
	AND (@FechaInicio is null or @FechaInicio <= CONVERT(date, P.FechaInicio))
	AND (@FechaFin is null or @FechaFin >= CONVERT(date, P.FechaInicio))
	ORDER BY P.ResultadosID DESC;

END
GO
USE [BelcorpEcuador];
GO
IF (OBJECT_ID(N'[chatbot].[ListResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[ListResultados]
GO

CREATE PROCEDURE [chatbot].[ListResultados]
	@Pais VARCHAR(2),
	@CodigoConsultora VARCHAR(25),
	@NombreOperador VARCHAR(100),
	@FechaInicio DATE = NULL,
	@FechaFin DATE = NULL
AS
BEGIN
Declare @NameResp VARCHAR(50);
Declare @NameRespDescrip VARCHAR(50);
set @NameResp = 'Resp';
set @NameRespDescrip = 'RespDescrip';


SELECT
	P.ResultadosID,
	P.OperadorID,
	P.NombreOperador,
	P.CodigoConsultora,
	P.NombreConsultora,
	P.FechaInicio,
	P.FechaFin,
	P.Campania,
	P.Pais,
	P.ConversacionID,
	Q.Descripcion as CanalDescripcion,
	T3.Resp1,
	T3.Resp2,
	T3.Resp3,
	T3.RespDescrip1,
	T3.RespDescrip2,
	T3.RespDescrip3
FROM
  chatbot.Resultados P
  inner join chatbot.Canal AS Q with(nolock) ON Q.CanalId = P.CanalId
  LEFT JOIN
(SELECT T1.*,T2.* FROM
 (SELECT *
	 FROM(
	   select
	       dr.ResultadosID AS Det1ResultadosID
		  ,CONCAT(@NameResp,CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
		  ,c.Valor
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS C
	PIVOT (max(Valor) FOR PreguntaId IN ([Resp1],[Resp2],[Resp3])) pv1) as T1
	INNER JOIN
  (SELECT *
	 FROM(
	   select
	   dr.ResultadosID AS Det2ResultadosID,
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
			  ,dr.Cualitativo
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Cualitativo) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
	T1.Det1ResultadosID = T2.Det2ResultadosID) AS T3
	ON P.ResultadosID = T3.Det1ResultadosID
	WHERE
	((@CodigoConsultora is null)  or (P.CodigoConsultora = @CodigoConsultora))
	AND ((@NombreOperador is null)  or (P.NombreOperador like '%'+@NombreOperador+'%'))
	AND (@FechaInicio is null or @FechaInicio <= CONVERT(date, P.FechaInicio))
	AND (@FechaFin is null or @FechaFin >= CONVERT(date, P.FechaInicio))
	ORDER BY P.ResultadosID DESC;

END
GO
USE [BelcorpGuatemala];
GO
IF (OBJECT_ID(N'[chatbot].[ListResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[ListResultados]
GO

CREATE PROCEDURE [chatbot].[ListResultados]
	@Pais VARCHAR(2),
	@CodigoConsultora VARCHAR(25),
	@NombreOperador VARCHAR(100),
	@FechaInicio DATE = NULL,
	@FechaFin DATE = NULL
AS
BEGIN
Declare @NameResp VARCHAR(50);
Declare @NameRespDescrip VARCHAR(50);
set @NameResp = 'Resp';
set @NameRespDescrip = 'RespDescrip';


SELECT
	P.ResultadosID,
	P.OperadorID,
	P.NombreOperador,
	P.CodigoConsultora,
	P.NombreConsultora,
	P.FechaInicio,
	P.FechaFin,
	P.Campania,
	P.Pais,
	P.ConversacionID,
	Q.Descripcion as CanalDescripcion,
	T3.Resp1,
	T3.Resp2,
	T3.Resp3,
	T3.RespDescrip1,
	T3.RespDescrip2,
	T3.RespDescrip3
FROM
  chatbot.Resultados P
  inner join chatbot.Canal AS Q with(nolock) ON Q.CanalId = P.CanalId
  LEFT JOIN
(SELECT T1.*,T2.* FROM
 (SELECT *
	 FROM(
	   select
	       dr.ResultadosID AS Det1ResultadosID
		  ,CONCAT(@NameResp,CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
		  ,c.Valor
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS C
	PIVOT (max(Valor) FOR PreguntaId IN ([Resp1],[Resp2],[Resp3])) pv1) as T1
	INNER JOIN
  (SELECT *
	 FROM(
	   select
	   dr.ResultadosID AS Det2ResultadosID,
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
			  ,dr.Cualitativo
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Cualitativo) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
	T1.Det1ResultadosID = T2.Det2ResultadosID) AS T3
	ON P.ResultadosID = T3.Det1ResultadosID
	WHERE
	((@CodigoConsultora is null)  or (P.CodigoConsultora = @CodigoConsultora))
	AND ((@NombreOperador is null)  or (P.NombreOperador like '%'+@NombreOperador+'%'))
	AND (@FechaInicio is null or @FechaInicio <= CONVERT(date, P.FechaInicio))
	AND (@FechaFin is null or @FechaFin >= CONVERT(date, P.FechaInicio))
	ORDER BY P.ResultadosID DESC;

END
GO
USE [BelcorpMexico];
GO
IF (OBJECT_ID(N'[chatbot].[ListResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[ListResultados]
GO

CREATE PROCEDURE [chatbot].[ListResultados]
	@Pais VARCHAR(2),
	@CodigoConsultora VARCHAR(25),
	@NombreOperador VARCHAR(100),
	@FechaInicio DATE = NULL,
	@FechaFin DATE = NULL
AS
BEGIN
Declare @NameResp VARCHAR(50);
Declare @NameRespDescrip VARCHAR(50);
set @NameResp = 'Resp';
set @NameRespDescrip = 'RespDescrip';


SELECT
	P.ResultadosID,
	P.OperadorID,
	P.NombreOperador,
	P.CodigoConsultora,
	P.NombreConsultora,
	P.FechaInicio,
	P.FechaFin,
	P.Campania,
	P.Pais,
	P.ConversacionID,
	Q.Descripcion as CanalDescripcion,
	T3.Resp1,
	T3.Resp2,
	T3.Resp3,
	T3.RespDescrip1,
	T3.RespDescrip2,
	T3.RespDescrip3
FROM
  chatbot.Resultados P
  inner join chatbot.Canal AS Q with(nolock) ON Q.CanalId = P.CanalId
  LEFT JOIN
(SELECT T1.*,T2.* FROM
 (SELECT *
	 FROM(
	   select
	       dr.ResultadosID AS Det1ResultadosID
		  ,CONCAT(@NameResp,CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
		  ,c.Valor
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS C
	PIVOT (max(Valor) FOR PreguntaId IN ([Resp1],[Resp2],[Resp3])) pv1) as T1
	INNER JOIN
  (SELECT *
	 FROM(
	   select
	   dr.ResultadosID AS Det2ResultadosID,
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
			  ,dr.Cualitativo
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Cualitativo) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
	T1.Det1ResultadosID = T2.Det2ResultadosID) AS T3
	ON P.ResultadosID = T3.Det1ResultadosID
	WHERE
	((@CodigoConsultora is null)  or (P.CodigoConsultora = @CodigoConsultora))
	AND ((@NombreOperador is null)  or (P.NombreOperador like '%'+@NombreOperador+'%'))
	AND (@FechaInicio is null or @FechaInicio <= CONVERT(date, P.FechaInicio))
	AND (@FechaFin is null or @FechaFin >= CONVERT(date, P.FechaInicio))
	ORDER BY P.ResultadosID DESC;

END
GO
USE [BelcorpPanama];
GO
IF (OBJECT_ID(N'[chatbot].[ListResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[ListResultados]
GO

CREATE PROCEDURE [chatbot].[ListResultados]
	@Pais VARCHAR(2),
	@CodigoConsultora VARCHAR(25),
	@NombreOperador VARCHAR(100),
	@FechaInicio DATE = NULL,
	@FechaFin DATE = NULL
AS
BEGIN
Declare @NameResp VARCHAR(50);
Declare @NameRespDescrip VARCHAR(50);
set @NameResp = 'Resp';
set @NameRespDescrip = 'RespDescrip';


SELECT
	P.ResultadosID,
	P.OperadorID,
	P.NombreOperador,
	P.CodigoConsultora,
	P.NombreConsultora,
	P.FechaInicio,
	P.FechaFin,
	P.Campania,
	P.Pais,
	P.ConversacionID,
	Q.Descripcion as CanalDescripcion,
	T3.Resp1,
	T3.Resp2,
	T3.Resp3,
	T3.RespDescrip1,
	T3.RespDescrip2,
	T3.RespDescrip3
FROM
  chatbot.Resultados P
  inner join chatbot.Canal AS Q with(nolock) ON Q.CanalId = P.CanalId
  LEFT JOIN
(SELECT T1.*,T2.* FROM
 (SELECT *
	 FROM(
	   select
	       dr.ResultadosID AS Det1ResultadosID
		  ,CONCAT(@NameResp,CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
		  ,c.Valor
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS C
	PIVOT (max(Valor) FOR PreguntaId IN ([Resp1],[Resp2],[Resp3])) pv1) as T1
	INNER JOIN
  (SELECT *
	 FROM(
	   select
	   dr.ResultadosID AS Det2ResultadosID,
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
			  ,dr.Cualitativo
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Cualitativo) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
	T1.Det1ResultadosID = T2.Det2ResultadosID) AS T3
	ON P.ResultadosID = T3.Det1ResultadosID
	WHERE
	((@CodigoConsultora is null)  or (P.CodigoConsultora = @CodigoConsultora))
	AND ((@NombreOperador is null)  or (P.NombreOperador like '%'+@NombreOperador+'%'))
	AND (@FechaInicio is null or @FechaInicio <= CONVERT(date, P.FechaInicio))
	AND (@FechaFin is null or @FechaFin >= CONVERT(date, P.FechaInicio))
	ORDER BY P.ResultadosID DESC;

END
GO
USE [BelcorpPeru];
GO
IF (OBJECT_ID(N'[chatbot].[ListResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[ListResultados]
GO

CREATE PROCEDURE [chatbot].[ListResultados]
	@Pais VARCHAR(2),
	@CodigoConsultora VARCHAR(25),
	@NombreOperador VARCHAR(100),
	@FechaInicio DATE = NULL,
	@FechaFin DATE = NULL
AS
BEGIN
Declare @NameResp VARCHAR(50);
Declare @NameRespDescrip VARCHAR(50);
set @NameResp = 'Resp';
set @NameRespDescrip = 'RespDescrip';


SELECT
	P.ResultadosID,
	P.OperadorID,
	P.NombreOperador,
	P.CodigoConsultora,
	P.NombreConsultora,
	P.FechaInicio,
	P.FechaFin,
	P.Campania,
	P.Pais,
	P.ConversacionID,
	Q.Descripcion as CanalDescripcion,
	T3.Resp1,
	T3.Resp2,
	T3.Resp3,
	T3.RespDescrip1,
	T3.RespDescrip2,
	T3.RespDescrip3
FROM
  chatbot.Resultados P
  inner join chatbot.Canal AS Q with(nolock) ON Q.CanalId = P.CanalId
  LEFT JOIN
(SELECT T1.*,T2.* FROM
 (SELECT *
	 FROM(
	   select
	       dr.ResultadosID AS Det1ResultadosID
		  ,CONCAT(@NameResp,CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
		  ,c.Valor
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS C
	PIVOT (max(Valor) FOR PreguntaId IN ([Resp1],[Resp2],[Resp3])) pv1) as T1
	INNER JOIN
  (SELECT *
	 FROM(
	   select
	   dr.ResultadosID AS Det2ResultadosID,
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
			  ,dr.Cualitativo
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Cualitativo) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
	T1.Det1ResultadosID = T2.Det2ResultadosID) AS T3
	ON P.ResultadosID = T3.Det1ResultadosID
	WHERE
	((@CodigoConsultora is null)  or (P.CodigoConsultora = @CodigoConsultora))
	AND ((@NombreOperador is null)  or (P.NombreOperador like '%'+@NombreOperador+'%'))
	AND (@FechaInicio is null or @FechaInicio <= CONVERT(date, P.FechaInicio))
	AND (@FechaFin is null or @FechaFin >= CONVERT(date, P.FechaInicio))
	ORDER BY P.ResultadosID DESC;

END
GO
USE [BelcorpPuertoRico];
GO
IF (OBJECT_ID(N'[chatbot].[ListResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[ListResultados]
GO

CREATE PROCEDURE [chatbot].[ListResultados]
	@Pais VARCHAR(2),
	@CodigoConsultora VARCHAR(25),
	@NombreOperador VARCHAR(100),
	@FechaInicio DATE = NULL,
	@FechaFin DATE = NULL
AS
BEGIN
Declare @NameResp VARCHAR(50);
Declare @NameRespDescrip VARCHAR(50);
set @NameResp = 'Resp';
set @NameRespDescrip = 'RespDescrip';


SELECT
	P.ResultadosID,
	P.OperadorID,
	P.NombreOperador,
	P.CodigoConsultora,
	P.NombreConsultora,
	P.FechaInicio,
	P.FechaFin,
	P.Campania,
	P.Pais,
	P.ConversacionID,
	Q.Descripcion as CanalDescripcion,
	T3.Resp1,
	T3.Resp2,
	T3.Resp3,
	T3.RespDescrip1,
	T3.RespDescrip2,
	T3.RespDescrip3
FROM
  chatbot.Resultados P
  inner join chatbot.Canal AS Q with(nolock) ON Q.CanalId = P.CanalId
  LEFT JOIN
(SELECT T1.*,T2.* FROM
 (SELECT *
	 FROM(
	   select
	       dr.ResultadosID AS Det1ResultadosID
		  ,CONCAT(@NameResp,CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
		  ,c.Valor
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS C
	PIVOT (max(Valor) FOR PreguntaId IN ([Resp1],[Resp2],[Resp3])) pv1) as T1
	INNER JOIN
  (SELECT *
	 FROM(
	   select
	   dr.ResultadosID AS Det2ResultadosID,
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
			  ,dr.Cualitativo
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Cualitativo) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
	T1.Det1ResultadosID = T2.Det2ResultadosID) AS T3
	ON P.ResultadosID = T3.Det1ResultadosID
	WHERE
	((@CodigoConsultora is null)  or (P.CodigoConsultora = @CodigoConsultora))
	AND ((@NombreOperador is null)  or (P.NombreOperador like '%'+@NombreOperador+'%'))
	AND (@FechaInicio is null or @FechaInicio <= CONVERT(date, P.FechaInicio))
	AND (@FechaFin is null or @FechaFin >= CONVERT(date, P.FechaInicio))
	ORDER BY P.ResultadosID DESC;

END
GO
USE [BelcorpSalvador];
GO
IF (OBJECT_ID(N'[chatbot].[ListResultados]', 'P') IS NOT NULL)
  DROP PROCEDURE [chatbot].[ListResultados]
GO

CREATE PROCEDURE [chatbot].[ListResultados]
	@Pais VARCHAR(2),
	@CodigoConsultora VARCHAR(25),
	@NombreOperador VARCHAR(100),
	@FechaInicio DATE = NULL,
	@FechaFin DATE = NULL
AS
BEGIN
Declare @NameResp VARCHAR(50);
Declare @NameRespDescrip VARCHAR(50);
set @NameResp = 'Resp';
set @NameRespDescrip = 'RespDescrip';


SELECT
	P.ResultadosID,
	P.OperadorID,
	P.NombreOperador,
	P.CodigoConsultora,
	P.NombreConsultora,
	P.FechaInicio,
	P.FechaFin,
	P.Campania,
	P.Pais,
	P.ConversacionID,
	Q.Descripcion as CanalDescripcion,
	T3.Resp1,
	T3.Resp2,
	T3.Resp3,
	T3.RespDescrip1,
	T3.RespDescrip2,
	T3.RespDescrip3
FROM
  chatbot.Resultados P
  inner join chatbot.Canal AS Q with(nolock) ON Q.CanalId = P.CanalId
  LEFT JOIN
(SELECT T1.*,T2.* FROM
 (SELECT *
	 FROM(
	   select
	       dr.ResultadosID AS Det1ResultadosID
		  ,CONCAT(@NameResp,CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
		  ,c.Valor
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS C
	PIVOT (max(Valor) FOR PreguntaId IN ([Resp1],[Resp2],[Resp3])) pv1) as T1
	INNER JOIN
  (SELECT *
	 FROM(
	   select
	   dr.ResultadosID AS Det2ResultadosID,
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId
			  ,dr.Cualitativo
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Cualitativo) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
	T1.Det1ResultadosID = T2.Det2ResultadosID) AS T3
	ON P.ResultadosID = T3.Det1ResultadosID
	WHERE
	((@CodigoConsultora is null)  or (P.CodigoConsultora = @CodigoConsultora))
	AND ((@NombreOperador is null)  or (P.NombreOperador like '%'+@NombreOperador+'%'))
	AND (@FechaInicio is null or @FechaInicio <= CONVERT(date, P.FechaInicio))
	AND (@FechaFin is null or @FechaFin >= CONVERT(date, P.FechaInicio))
	ORDER BY P.ResultadosID DESC;

END
GO
