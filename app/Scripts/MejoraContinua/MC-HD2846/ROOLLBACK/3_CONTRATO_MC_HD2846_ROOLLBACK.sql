use belcorpColombia
go

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ObtenerReporteContratoAceptacion]') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE [dbo].[ObtenerReporteContratoAceptacion]
GO
