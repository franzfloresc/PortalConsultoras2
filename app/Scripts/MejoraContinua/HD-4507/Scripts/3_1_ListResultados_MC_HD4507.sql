USE [BelcorpPeru_MC]
GO
/****** Object:  StoredProcedure [chatbot].[ListResultados]    Script Date: 15/7/2019 19:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [chatbot].[ListResultados]
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
	       dr.ResultadosID AS Det1ResultadosID, 
		  CONCAT(@NameResp,CONVERT(VARCHAR(50), dr.PreguntaId)) AS PreguntaId,
		dr.CalificacionID 
	   from chatbot.DetalleResultados as dr
	   ) AS C
	PIVOT (max(CalificacionID) FOR PreguntaId IN ([Resp1],[Resp2],[Resp3])) pv1) as T1
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

--EXEC [chatbot].[ListResultados] @Pais='PE', @CodigoConsultora = '', @NombreOperador = '', @FechaInicio='2019-03-30', @FechaFin='2019-06-29';
--EXEC [chatbot].[ListResultados] @Pais='PE', @CodigoConsultora = null, @NombreOperador =null, @FechaInicio='2/07/2019', @FechaFin=null;


