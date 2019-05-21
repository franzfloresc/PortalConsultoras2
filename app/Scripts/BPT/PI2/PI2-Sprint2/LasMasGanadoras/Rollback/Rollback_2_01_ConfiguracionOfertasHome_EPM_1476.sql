use [BelcorpPeru_BPT];
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		declare @ConfiguracionPaisPeruID int;

		set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');
		
		delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisPeruID;
	end;
end;

use [BelcorpChile_BPT];
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		declare @ConfiguracionPaisChileID int;

		set @ConfiguracionPaisChileID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');
		
		delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisChileID;
	end;
end;

use [BelcorpCostaRica_BPT];
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		declare @ConfiguracionPaisCostaRicaID int;

		set @ConfiguracionPaisCostaRicaID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');
		
		delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisCostaRicaID;
	end;
end;