IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarRecepcionPedido]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarRecepcionPedido]
GO
