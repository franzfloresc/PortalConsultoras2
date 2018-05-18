GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetListaImagenesProductoSugeridoByCampania') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.GetListaImagenesProductoSugeridoByCampania
GO
