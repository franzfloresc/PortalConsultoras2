use [BelcorpPeru_BPT];
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		declare @ConfiguracionPaisPeruID int;

		set @ConfiguracionPaisPeruID = (select ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG');
		
		update 
			dbo.configuracionofertashome 
		set 
			 desktoporden		= desktoporden		- 1
			,mobileorden		= mobileorden		- 1
			,desktopordenbpt	= desktopordenbpt	- 1
			,mobileordenbpt		= mobileordenbpt	- 1
		where 
			not desktoporden in(0,1);

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
		
		update 
			dbo.configuracionofertashome 
		set 
			 desktoporden		= desktoporden		- 1
			,mobileorden		= mobileorden		- 1
			,desktopordenbpt	= desktopordenbpt	- 1
			,mobileordenbpt		= mobileordenbpt	- 1
		where 
			not desktoporden in(0,1);

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
		
		update 
			dbo.configuracionofertashome 
		set 
			 desktoporden		= desktoporden		- 1
			,mobileorden		= mobileorden		- 1
			,desktopordenbpt	= desktopordenbpt	- 1
			,mobileordenbpt		= mobileordenbpt	- 1
		where 
			not desktoporden in(0,1);

		delete from dbo.configuracionofertashome where ConfiguracionPaisID = @ConfiguracionPaisCostaRicaID;
	end;
end;