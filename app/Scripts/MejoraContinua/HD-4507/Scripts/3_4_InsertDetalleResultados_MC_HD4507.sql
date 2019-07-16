USE [BelcorpPeru_MC]
GO
/****** Object:  StoredProcedure [dbo].[ContenidoAppDetaUpd]    Script Date: 10/7/2019 11:31:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

ALTER PROCEDURE [chatbot].[InsertDetalleResultados]
	 @ResultadosID INT
	,@PreguntaID INT
	,@CalificacionID INT
	,@Cualitativo VARCHAR(500)
AS
BEGIN
	INSERT INTO [chatbot].[DetalleResultados]
		(ResultadosID
		,PreguntaID
		,CalificacionID
		,Cualitativo)
		VALUES
		(@ResultadosID
		,@PreguntaID
		,@CalificacionID
		,@Cualitativo);
END

/*
DECLARE @new_identity INT;
EXEC [chatbot].[InsertResultados] 
@OperadorID = '1', 
@NombreOperador = 'other op',
@CodigoConsultora = '50492627', 
@NombreConsultora = 'EOTYY', 
@FechaInicio = '2019-07-01 17:35:04.270', 
--@FechaFin = NULL, 
@Campania = '201911', 
@Pais = 'PE', 
@ConversacionID = '47HKQQ4OD12ORC7PM4EOUK4Q800AO0EB', 
@CanalID = '1', 
@new_identity = @new_identity OUTPUT;
PRINT @new_identity;
*/


