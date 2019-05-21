
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ActualizaOrden]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].ActualizaOrden
GO

