GO
USE BelcorpPeru
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalDelete') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalDelete
GO
CREATE PROCEDURE [dbo].[EstrategiaTemporalDelete]
(
	@NroLote int
)
as
begin

	-- eliminar CUV hijos huerfanos
	delete from EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	delete from EstrategiaTemporal
	where NumeroLote = @NroLote

end


GO
USE BelcorpMexico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalDelete') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalDelete
GO
CREATE PROCEDURE [dbo].[EstrategiaTemporalDelete]
(
	@NroLote int
)
as
begin

	-- eliminar CUV hijos huerfanos
	delete from EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	delete from EstrategiaTemporal
	where NumeroLote = @NroLote

end


GO
USE BelcorpColombia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalDelete') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalDelete
GO
CREATE PROCEDURE [dbo].[EstrategiaTemporalDelete]
(
	@NroLote int
)
as
begin

	-- eliminar CUV hijos huerfanos
	delete from EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	delete from EstrategiaTemporal
	where NumeroLote = @NroLote

end


GO
USE BelcorpSalvador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalDelete') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalDelete
GO
CREATE PROCEDURE [dbo].[EstrategiaTemporalDelete]
(
	@NroLote int
)
as
begin

	-- eliminar CUV hijos huerfanos
	delete from EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	delete from EstrategiaTemporal
	where NumeroLote = @NroLote

end


GO
USE BelcorpPuertoRico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalDelete') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalDelete
GO
CREATE PROCEDURE [dbo].[EstrategiaTemporalDelete]
(
	@NroLote int
)
as
begin

	-- eliminar CUV hijos huerfanos
	delete from EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	delete from EstrategiaTemporal
	where NumeroLote = @NroLote

end


GO
USE BelcorpPanama
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalDelete') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalDelete
GO
CREATE PROCEDURE [dbo].[EstrategiaTemporalDelete]
(
	@NroLote int
)
as
begin

	-- eliminar CUV hijos huerfanos
	delete from EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	delete from EstrategiaTemporal
	where NumeroLote = @NroLote

end


GO
USE BelcorpGuatemala
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalDelete') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalDelete
GO
CREATE PROCEDURE [dbo].[EstrategiaTemporalDelete]
(
	@NroLote int
)
as
begin

	-- eliminar CUV hijos huerfanos
	delete from EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	delete from EstrategiaTemporal
	where NumeroLote = @NroLote

end


GO
USE BelcorpEcuador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalDelete') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalDelete
GO
CREATE PROCEDURE [dbo].[EstrategiaTemporalDelete]
(
	@NroLote int
)
as
begin

	-- eliminar CUV hijos huerfanos
	delete from EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	delete from EstrategiaTemporal
	where NumeroLote = @NroLote

end


GO
USE BelcorpDominicana
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalDelete') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalDelete
GO
CREATE PROCEDURE [dbo].[EstrategiaTemporalDelete]
(
	@NroLote int
)
as
begin

	-- eliminar CUV hijos huerfanos
	delete from EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	delete from EstrategiaTemporal
	where NumeroLote = @NroLote

end


GO
USE BelcorpCostaRica
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalDelete') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalDelete
GO
CREATE PROCEDURE [dbo].[EstrategiaTemporalDelete]
(
	@NroLote int
)
as
begin

	-- eliminar CUV hijos huerfanos
	delete from EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	delete from EstrategiaTemporal
	where NumeroLote = @NroLote

end


GO
USE BelcorpChile
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalDelete') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalDelete
GO
CREATE PROCEDURE [dbo].[EstrategiaTemporalDelete]
(
	@NroLote int
)
as
begin

	-- eliminar CUV hijos huerfanos
	delete from EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	delete from EstrategiaTemporal
	where NumeroLote = @NroLote

end


GO
USE BelcorpBolivia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalDelete') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalDelete
GO
CREATE PROCEDURE [dbo].[EstrategiaTemporalDelete]
(
	@NroLote int
)
as
begin

	-- eliminar CUV hijos huerfanos
	delete from EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	delete from EstrategiaTemporal
	where NumeroLote = @NroLote

end


GO
