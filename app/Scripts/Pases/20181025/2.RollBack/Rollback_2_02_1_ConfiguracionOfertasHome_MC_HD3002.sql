USE BelcorpBolivia;
GO
declare @ConfiguracionPaisPeruID int;

if(exists(select 1 from dbo.configuracionpais where codigo = 'PN'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;

if(exists(select 1 from dbo.configuracionpais where codigo = 'DP'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;
GO
USE BelcorpChile;
GO
declare @ConfiguracionPaisPeruID int;

if(exists(select 1 from dbo.configuracionpais where codigo = 'PN'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;

if(exists(select 1 from dbo.configuracionpais where codigo = 'DP'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;
GO
USE BelcorpColombia;
GO
declare @ConfiguracionPaisPeruID int;

if(exists(select 1 from dbo.configuracionpais where codigo = 'PN'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;

if(exists(select 1 from dbo.configuracionpais where codigo = 'DP'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;
GO
USE BelcorpCostaRica;
GO
declare @ConfiguracionPaisPeruID int;

if(exists(select 1 from dbo.configuracionpais where codigo = 'PN'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;

if(exists(select 1 from dbo.configuracionpais where codigo = 'DP'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;
GO
USE BelcorpDominicana;
GO
declare @ConfiguracionPaisPeruID int;

if(exists(select 1 from dbo.configuracionpais where codigo = 'PN'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;

if(exists(select 1 from dbo.configuracionpais where codigo = 'DP'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;
GO
USE BelcorpEcuador;
GO
declare @ConfiguracionPaisPeruID int;

if(exists(select 1 from dbo.configuracionpais where codigo = 'PN'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;

if(exists(select 1 from dbo.configuracionpais where codigo = 'DP'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;
GO
USE BelcorpGuatemala;
GO
declare @ConfiguracionPaisPeruID int;

if(exists(select 1 from dbo.configuracionpais where codigo = 'PN'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;

if(exists(select 1 from dbo.configuracionpais where codigo = 'DP'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;
GO
USE BelcorpMexico;
GO
declare @ConfiguracionPaisPeruID int;

if(exists(select 1 from dbo.configuracionpais where codigo = 'PN'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;

if(exists(select 1 from dbo.configuracionpais where codigo = 'DP'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;
GO
USE BelcorpPanama;
GO
declare @ConfiguracionPaisPeruID int;

if(exists(select 1 from dbo.configuracionpais where codigo = 'PN'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;

if(exists(select 1 from dbo.configuracionpais where codigo = 'DP'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;
GO
USE BelcorpPeru;
GO
declare @ConfiguracionPaisPeruID int;

if(exists(select 1 from dbo.configuracionpais where codigo = 'PN'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;

if(exists(select 1 from dbo.configuracionpais where codigo = 'DP'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;
GO
USE BelcorpPuertoRico;
GO
declare @ConfiguracionPaisPeruID int;

if(exists(select 1 from dbo.configuracionpais where codigo = 'PN'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;

if(exists(select 1 from dbo.configuracionpais where codigo = 'DP'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;
GO
USE BelcorpSalvador;
GO
declare @ConfiguracionPaisPeruID int;

if(exists(select 1 from dbo.configuracionpais where codigo = 'PN'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'PN');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;

if(exists(select 1 from dbo.configuracionpais where codigo = 'DP'))
begin
	set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'DP');

	delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
end;
GO
