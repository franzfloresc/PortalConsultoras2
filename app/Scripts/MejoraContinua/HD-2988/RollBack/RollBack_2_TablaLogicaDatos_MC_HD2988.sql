USE BelcorpPeru
GO

declare @TablaLogicaID int = 10
if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	delete from TablaLogicaDatos where TablaLogicaID = @TablaLogicaID 
	delete from TablaLogica where TablaLogicaID = @TablaLogicaID 
end
Go

USE BelcorpMexico
GO

declare @TablaLogicaID int = 10
if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	delete from TablaLogicaDatos where TablaLogicaID = @TablaLogicaID 
	delete from TablaLogica where TablaLogicaID = @TablaLogicaID 
end
Go

USE BelcorpColombia
GO

declare @TablaLogicaID int = 10
if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	delete from TablaLogicaDatos where TablaLogicaID = @TablaLogicaID 
	delete from TablaLogica where TablaLogicaID = @TablaLogicaID 
end
Go

USE BelcorpSalvador
GO

declare @TablaLogicaID int = 10
if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	delete from TablaLogicaDatos where TablaLogicaID = @TablaLogicaID 
	delete from TablaLogica where TablaLogicaID = @TablaLogicaID 
end
Go

USE BelcorpPuertoRico
GO

declare @TablaLogicaID int = 10
if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	delete from TablaLogicaDatos where TablaLogicaID = @TablaLogicaID 
	delete from TablaLogica where TablaLogicaID = @TablaLogicaID 
end
Go

USE BelcorpPanama
GO

declare @TablaLogicaID int = 10
if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	delete from TablaLogicaDatos where TablaLogicaID = @TablaLogicaID 
	delete from TablaLogica where TablaLogicaID = @TablaLogicaID 
end
Go

USE BelcorpGuatemala
GO

declare @TablaLogicaID int = 10
if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	delete from TablaLogicaDatos where TablaLogicaID = @TablaLogicaID 
	delete from TablaLogica where TablaLogicaID = @TablaLogicaID 
end
Go

USE BelcorpEcuador
GO

declare @TablaLogicaID int = 10
if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	delete from TablaLogicaDatos where TablaLogicaID = @TablaLogicaID 
	delete from TablaLogica where TablaLogicaID = @TablaLogicaID 
end
Go

USE BelcorpDominicana
GO

declare @TablaLogicaID int = 10
if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	delete from TablaLogicaDatos where TablaLogicaID = @TablaLogicaID 
	delete from TablaLogica where TablaLogicaID = @TablaLogicaID 
end
Go

USE BelcorpCostaRica
GO

declare @TablaLogicaID int = 10
if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	delete from TablaLogicaDatos where TablaLogicaID = @TablaLogicaID 
	delete from TablaLogica where TablaLogicaID = @TablaLogicaID 
end
Go

USE BelcorpChile
GO

declare @TablaLogicaID int = 10
if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	delete from TablaLogicaDatos where TablaLogicaID = @TablaLogicaID 
	delete from TablaLogica where TablaLogicaID = @TablaLogicaID 
end
Go

USE BelcorpBolivia
GO

declare @TablaLogicaID int = 10
if exists (select 1 from TablaLogica where TablaLogicaID = @TablaLogicaID)
begin
	delete from TablaLogicaDatos where TablaLogicaID = @TablaLogicaID 
	delete from TablaLogica where TablaLogicaID = @TablaLogicaID 
end
Go

