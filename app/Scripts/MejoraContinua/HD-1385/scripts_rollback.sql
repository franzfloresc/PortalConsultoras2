USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesEstrategiasByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesEstrategiasByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesOfertaLiquidacionByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesOfertaLiquidacionByCampania
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListaImagenesProductoSugeridoByCampania]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetListaImagenesProductoSugeridoByCampania
GO

