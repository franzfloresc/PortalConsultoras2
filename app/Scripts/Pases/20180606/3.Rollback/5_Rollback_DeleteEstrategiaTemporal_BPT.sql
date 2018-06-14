GO
USE BelcorpPeru
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DeleteEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO
CREATE PROCEDURE [dbo].[DeleteEstrategiaTemporal]
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	-- eliminar CUV hijos huerfanos
	delete ep from EstrategiaProducto ep
	inner join EstrategiaTemporal t on ep.Campania = t.CampaniaId
		and ep.CUV2 = t.CUV
		and isnull(ep.EstrategiaId,0) = 0
	where t.CampaniaId = @CampaniaID
		and t.NumeroLote = @NumeroLote
	delete from EstrategiaTemporal
	where
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote

end
GO

GO
USE BelcorpMexico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DeleteEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO
CREATE PROCEDURE [dbo].[DeleteEstrategiaTemporal]
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	-- eliminar CUV hijos huerfanos
	delete ep from EstrategiaProducto ep
	inner join EstrategiaTemporal t on ep.Campania = t.CampaniaId
		and ep.CUV2 = t.CUV
		and isnull(ep.EstrategiaId,0) = 0
	where t.CampaniaId = @CampaniaID
		and t.NumeroLote = @NumeroLote
	delete from EstrategiaTemporal
	where
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote

end
GO

GO
USE BelcorpColombia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DeleteEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO
CREATE PROCEDURE [dbo].[DeleteEstrategiaTemporal]
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	-- eliminar CUV hijos huerfanos
	delete ep from EstrategiaProducto ep
	inner join EstrategiaTemporal t on ep.Campania = t.CampaniaId
		and ep.CUV2 = t.CUV
		and isnull(ep.EstrategiaId,0) = 0
	where t.CampaniaId = @CampaniaID
		and t.NumeroLote = @NumeroLote
	delete from EstrategiaTemporal
	where
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote

end
GO

GO
USE BelcorpSalvador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DeleteEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO
CREATE PROCEDURE [dbo].[DeleteEstrategiaTemporal]
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	-- eliminar CUV hijos huerfanos
	delete ep from EstrategiaProducto ep
	inner join EstrategiaTemporal t on ep.Campania = t.CampaniaId
		and ep.CUV2 = t.CUV
		and isnull(ep.EstrategiaId,0) = 0
	where t.CampaniaId = @CampaniaID
		and t.NumeroLote = @NumeroLote
	delete from EstrategiaTemporal
	where
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote

end
GO

GO
USE BelcorpPuertoRico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DeleteEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO
CREATE PROCEDURE [dbo].[DeleteEstrategiaTemporal]
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	-- eliminar CUV hijos huerfanos
	delete ep from EstrategiaProducto ep
	inner join EstrategiaTemporal t on ep.Campania = t.CampaniaId
		and ep.CUV2 = t.CUV
		and isnull(ep.EstrategiaId,0) = 0
	where t.CampaniaId = @CampaniaID
		and t.NumeroLote = @NumeroLote
	delete from EstrategiaTemporal
	where
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote

end
GO

GO
USE BelcorpPanama
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DeleteEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO
CREATE PROCEDURE [dbo].[DeleteEstrategiaTemporal]
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	-- eliminar CUV hijos huerfanos
	delete ep from EstrategiaProducto ep
	inner join EstrategiaTemporal t on ep.Campania = t.CampaniaId
		and ep.CUV2 = t.CUV
		and isnull(ep.EstrategiaId,0) = 0
	where t.CampaniaId = @CampaniaID
		and t.NumeroLote = @NumeroLote
	delete from EstrategiaTemporal
	where
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote

end
GO

GO
USE BelcorpGuatemala
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DeleteEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO
CREATE PROCEDURE [dbo].[DeleteEstrategiaTemporal]
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	-- eliminar CUV hijos huerfanos
	delete ep from EstrategiaProducto ep
	inner join EstrategiaTemporal t on ep.Campania = t.CampaniaId
		and ep.CUV2 = t.CUV
		and isnull(ep.EstrategiaId,0) = 0
	where t.CampaniaId = @CampaniaID
		and t.NumeroLote = @NumeroLote
	delete from EstrategiaTemporal
	where
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote

end
GO

GO
USE BelcorpEcuador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DeleteEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO
CREATE PROCEDURE [dbo].[DeleteEstrategiaTemporal]
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	-- eliminar CUV hijos huerfanos
	delete ep from EstrategiaProducto ep
	inner join EstrategiaTemporal t on ep.Campania = t.CampaniaId
		and ep.CUV2 = t.CUV
		and isnull(ep.EstrategiaId,0) = 0
	where t.CampaniaId = @CampaniaID
		and t.NumeroLote = @NumeroLote
	delete from EstrategiaTemporal
	where
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote

end
GO

GO
USE BelcorpDominicana
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DeleteEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO
CREATE PROCEDURE [dbo].[DeleteEstrategiaTemporal]
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	-- eliminar CUV hijos huerfanos
	delete ep from EstrategiaProducto ep
	inner join EstrategiaTemporal t on ep.Campania = t.CampaniaId
		and ep.CUV2 = t.CUV
		and isnull(ep.EstrategiaId,0) = 0
	where t.CampaniaId = @CampaniaID
		and t.NumeroLote = @NumeroLote
	delete from EstrategiaTemporal
	where
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote

end
GO

GO
USE BelcorpCostaRica
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DeleteEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO
CREATE PROCEDURE [dbo].[DeleteEstrategiaTemporal]
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	-- eliminar CUV hijos huerfanos
	delete ep from EstrategiaProducto ep
	inner join EstrategiaTemporal t on ep.Campania = t.CampaniaId
		and ep.CUV2 = t.CUV
		and isnull(ep.EstrategiaId,0) = 0
	where t.CampaniaId = @CampaniaID
		and t.NumeroLote = @NumeroLote
	delete from EstrategiaTemporal
	where
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote

end
GO

GO
USE BelcorpChile
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DeleteEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO
CREATE PROCEDURE [dbo].[DeleteEstrategiaTemporal]
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	-- eliminar CUV hijos huerfanos
	delete ep from EstrategiaProducto ep
	inner join EstrategiaTemporal t on ep.Campania = t.CampaniaId
		and ep.CUV2 = t.CUV
		and isnull(ep.EstrategiaId,0) = 0
	where t.CampaniaId = @CampaniaID
		and t.NumeroLote = @NumeroLote
	delete from EstrategiaTemporal
	where
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote

end
GO

GO
USE BelcorpBolivia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DeleteEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.DeleteEstrategiaTemporal
GO
CREATE PROCEDURE [dbo].[DeleteEstrategiaTemporal]
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

	-- eliminar CUV hijos huerfanos
	delete ep from EstrategiaProducto ep
	inner join EstrategiaTemporal t on ep.Campania = t.CampaniaId
		and ep.CUV2 = t.CUV
		and isnull(ep.EstrategiaId,0) = 0
	where t.CampaniaId = @CampaniaID
		and t.NumeroLote = @NumeroLote
	delete from EstrategiaTemporal
	where
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote

end
GO

GO
