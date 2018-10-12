
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetOfertasParaTiByTipoConfigurado') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
GO
