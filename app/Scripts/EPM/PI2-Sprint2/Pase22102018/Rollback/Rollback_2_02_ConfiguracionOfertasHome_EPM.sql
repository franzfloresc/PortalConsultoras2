GO
USE BelcorpPeru
GO
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		declare @ConfiguracionPaisPeruID int;

		set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');

		delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
	end;
end;
GO

GO
USE BelcorpMexico
GO
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		declare @ConfiguracionPaisPeruID int;

		set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');

		delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
	end;
end;
GO

GO
USE BelcorpColombia
GO
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		declare @ConfiguracionPaisPeruID int;

		set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');

		delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
	end;
end;
GO

GO
USE BelcorpSalvador
GO
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		declare @ConfiguracionPaisPeruID int;

		set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');

		delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
	end;
end;
GO

GO
USE BelcorpPuertoRico
GO
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		declare @ConfiguracionPaisPeruID int;

		set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');

		delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
	end;
end;
GO

GO
USE BelcorpPanama
GO
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		declare @ConfiguracionPaisPeruID int;

		set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');

		delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
	end;
end;
GO

GO
USE BelcorpGuatemala
GO
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		declare @ConfiguracionPaisPeruID int;

		set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');

		delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
	end;
end;
GO

GO
USE BelcorpEcuador
GO
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		declare @ConfiguracionPaisPeruID int;

		set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');

		delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
	end;
end;
GO

GO
USE BelcorpDominicana
GO
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		declare @ConfiguracionPaisPeruID int;

		set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');

		delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
	end;
end;
GO

GO
USE BelcorpCostaRica
GO
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		declare @ConfiguracionPaisPeruID int;

		set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');

		delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
	end;
end;
GO

GO
USE BelcorpChile
GO
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		declare @ConfiguracionPaisPeruID int;

		set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');

		delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
	end;
end;
GO

GO
USE BelcorpBolivia
GO
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		declare @ConfiguracionPaisPeruID int;

		set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');

		delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
	end;
end;
GO

GO
