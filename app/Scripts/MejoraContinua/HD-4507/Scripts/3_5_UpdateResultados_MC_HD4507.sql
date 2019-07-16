USE [BelcorpPeru_MC]
GO
/****** Object:  StoredProcedure [chatbot].[UpdateResultados]    Script Date: 15/7/2019 19:26:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

ALTER PROCEDURE [chatbot].[UpdateResultados]
	 @ResultadosID INT
	,@FechaFin DATETIME = NULL
AS
BEGIN

UPDATE [chatbot].[Resultados]
		SET FechaFin				= @FechaFin
		WHERE ResultadosID 			= @ResultadosID
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


