GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetOfertasParaTiByTipoConfiguradoTemporal') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.GetOfertasParaTiByTipoConfiguradoTemporal
GO
