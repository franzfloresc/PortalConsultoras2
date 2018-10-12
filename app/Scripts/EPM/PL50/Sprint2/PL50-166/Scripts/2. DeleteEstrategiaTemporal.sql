
USE BelcorpBolivia
GO

ALTER procedure [dbo].[DeleteEstrategiaTemporal]
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

USE BelcorpChile
GO

ALTER procedure [dbo].[DeleteEstrategiaTemporal]
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

USE BelcorpColombia
GO

ALTER procedure [dbo].[DeleteEstrategiaTemporal]
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

USE BelcorpCostaRica
GO

ALTER procedure [dbo].[DeleteEstrategiaTemporal]
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

USE BelcorpDominicana
GO

ALTER procedure [dbo].[DeleteEstrategiaTemporal]
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

USE BelcorpEcuador
GO

ALTER procedure [dbo].[DeleteEstrategiaTemporal]
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

USE BelcorpGuatemala
GO

ALTER procedure [dbo].[DeleteEstrategiaTemporal]
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

USE BelcorpMexico
GO

ALTER procedure [dbo].[DeleteEstrategiaTemporal]
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

USE BelcorpPanama
GO

ALTER procedure [dbo].[DeleteEstrategiaTemporal]
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

USE BelcorpPeru
GO

ALTER procedure [dbo].[DeleteEstrategiaTemporal]
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

USE BelcorpPuertoRico
GO

ALTER procedure [dbo].[DeleteEstrategiaTemporal]
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

USE BelcorpSalvador
GO

ALTER procedure [dbo].[DeleteEstrategiaTemporal]
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

USE BelcorpVenezuela
GO

ALTER procedure [dbo].[DeleteEstrategiaTemporal]
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