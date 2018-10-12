

USE BelcorpBolivia
GO

ALTER procedure [dbo].[DeleteEstrategiaTemporal]
@CampaniaID int
as
begin
	declare @NumeroLote int = 0
	select @NumeroLote = max(NumeroLote) from EstrategiaTemporal

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

	delete from EstrategiaTemporal
	where 
		CampaniaId = @CampaniaID
		and NumeroLote = @NumeroLote
end

GO