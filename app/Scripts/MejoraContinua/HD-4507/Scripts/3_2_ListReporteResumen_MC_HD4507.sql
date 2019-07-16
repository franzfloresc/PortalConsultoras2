USE [BelcorpPeru_MC]
GO
/****** Object:  StoredProcedure [chatbot].[ListReporteResumen]    Script Date: 5/7/2019 11:01:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [chatbot].[ListReporteResumen]
	@Pais VARCHAR(2),
	@CodigoConsultora VARCHAR(25),
	@NombreOperador VARCHAR(100),
	@FechaInicio VARCHAR(6),
	@FechaFin VARCHAR(6)
AS
BEGIN		
--set @FechaInicio ='201903';
--set @FechaFin ='201907';

SELECT
CONCAT('RESP1',YEAR(P.FechaInicio), '',RIGHT('0' + CONVERT(varchar(2),MONTH(P.FechaInicio)) , 2)) AS CodeAnioMes,
(
select 
count(*) from chatbot.Resultados as R where year(R.FechaInicio) = year(P.FechaInicio) and MONTH(R.FechaInicio) = MONTH(P.FechaInicio)
) as TotalEncuestados,
 
 YEAR(P.FechaInicio) AS FechaAnio,
 MONTH(P.FechaInicio) AS FechaMes
			,count(*) as Resp
			FROM chatbot.Resultados AS P with(nolock)
			INNER JOIN chatbot.DetalleResultados AS Q with(nolock) ON Q.ResultadosId = P.ResultadosId
			where 
			Q.PreguntaID = 1 and
			Q.CalificacionID  in (4,5)
			and CONCAT(YEAR(P.FechaInicio), RIGHT('0' + CONVERT(varchar(2),MONTH(P.FechaInicio)) , 2)) >= @FechaInicio
		    and CONCAT(YEAR(P.FechaInicio), RIGHT('0' + CONVERT(varchar(2),MONTH(P.FechaInicio)) , 2)) <= @FechaFin
			group by month(p.FechaInicio),
			YEAR(P.FechaInicio)
		UNION ALL
SELECT 
CONCAT('RESP2',YEAR(P.FechaInicio), '',RIGHT('0' + CONVERT(varchar(2),MONTH(P.FechaInicio)) , 2)) AS CodeAnioMes,
--CONCAT('RESP2',YEAR(P.FechaInicio), '', MONTH(P.FechaInicio)) AS CodeAnioMes,
(
select 
count(*) from chatbot.Resultados as R where year(R.FechaInicio) = year(P.FechaInicio) and MONTH(R.FechaInicio) = MONTH(P.FechaInicio)
) as TotalEncuestados,
 
 YEAR(P.FechaInicio) AS FechaAnio,
 MONTH(P.FechaInicio) AS FechaMes
			,count(*) as Resp
			FROM chatbot.Resultados AS P with(nolock)
			INNER JOIN chatbot.DetalleResultados AS Q with(nolock) ON Q.ResultadosId = P.ResultadosId
			where 
			Q.PreguntaID = 2 and
			Q.CalificacionID  = 7
			and CONCAT(YEAR(P.FechaInicio), RIGHT('0' + CONVERT(varchar(2),MONTH(P.FechaInicio)) , 2)) >= @FechaInicio
		    and CONCAT(YEAR(P.FechaInicio), RIGHT('0' + CONVERT(varchar(2),MONTH(P.FechaInicio)) , 2)) <= @FechaFin
			group by month(p.FechaInicio),
			YEAR(P.FechaInicio)

			UNION ALL
SELECT
CONCAT('RESP3',YEAR(P.FechaInicio), '',RIGHT('0' + CONVERT(varchar(2),MONTH(P.FechaInicio)) , 2)) AS CodeAnioMes,
--CONCAT('RESP3',YEAR(P.FechaInicio), '', MONTH(P.FechaInicio)) AS CodeAnioMes,
(
select 
count(*) from chatbot.Resultados as R where year(R.FechaInicio) = year(P.FechaInicio) and MONTH(R.FechaInicio) = MONTH(P.FechaInicio)
) as TotalEncuestados,
 
 YEAR(P.FechaInicio) AS FechaAnio,
 MONTH(P.FechaInicio) AS FechaMes
			,count(*) as Resp
			FROM chatbot.Resultados AS P with(nolock)
			INNER JOIN chatbot.DetalleResultados AS Q with(nolock) ON Q.ResultadosId = P.ResultadosId
			where 
			Q.PreguntaID = 3 and
			Q.CalificacionID  in (4,5)
			and CONCAT(YEAR(P.FechaInicio), RIGHT('0' + CONVERT(varchar(2),MONTH(P.FechaInicio)) , 2)) >= @FechaInicio
		    and CONCAT(YEAR(P.FechaInicio), RIGHT('0' + CONVERT(varchar(2),MONTH(P.FechaInicio)) , 2)) <= @FechaFin
			group by month(p.FechaInicio),
			YEAR(P.FechaInicio)
			order by FechaAnio, FechaMes
			
			
		 		
END

--EXEC [chatbot].[ListResultados] @Pais='PE', @CodigoConsultora = null, @NombreOperador =null, @FechaInicio='2/07/2019', @FechaFin=null;
--EXEC [chatbot].[ListReporteResumen] @FechaInicio='2019-03-01', @FechaFin='2019-03-31';



--declare @fecInicial datetime
--declare @fecFin datetime 

--set @fecInicial = '2019-03-01T12:23:45';
--set @fecFin = '2019-08-06T21:10:12';
--EXEC [chatbot].[ListReporteResumen] 'PE',null,null, @fecInicial, @fecFin;
--EXEC [chatbot].[ListReporteResumen] 'PE',null,null, '201903', '201907';