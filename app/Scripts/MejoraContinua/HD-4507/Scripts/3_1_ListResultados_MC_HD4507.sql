GO
USE BelcorpPeru
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
  inner join
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
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId,
			  c.Descripcion
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Descripcion) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
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
USE BelcorpMexico
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
  inner join
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
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId,
			  c.Descripcion
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Descripcion) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
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
USE BelcorpColombia
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
  inner join
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
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId,
			  c.Descripcion
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Descripcion) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
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
USE BelcorpSalvador
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
  inner join
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
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId,
			  c.Descripcion
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Descripcion) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
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
USE BelcorpPuertoRico
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
  inner join
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
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId,
			  c.Descripcion
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Descripcion) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
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
USE BelcorpPanama
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
  inner join
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
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId,
			  c.Descripcion
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Descripcion) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
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
USE BelcorpGuatemala
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
  inner join
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
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId,
			  c.Descripcion
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Descripcion) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
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
USE BelcorpEcuador
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
  inner join
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
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId,
			  c.Descripcion
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Descripcion) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
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
USE BelcorpDominicana
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
  inner join
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
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId,
			  c.Descripcion
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Descripcion) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
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
USE BelcorpCostaRica
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
  inner join
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
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId,
			  c.Descripcion
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Descripcion) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
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
USE BelcorpChile
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
  inner join
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
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId,
			  c.Descripcion
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Descripcion) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
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
USE BelcorpBolivia
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
  inner join
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
			  CONCAT(@NameRespDescrip, CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId,
			  c.Descripcion
	   from chatbot.DetalleResultados as dr inner join chatbot.Calificaciones c on dr.CalificacionId = c.CalificacionID
	   ) AS D
	PIVOT (max(Descripcion) FOR PreguntaId IN ([RespDescrip1],[RespDescrip2],[RespDescrip3])) pv2 ) as T2 ON
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
