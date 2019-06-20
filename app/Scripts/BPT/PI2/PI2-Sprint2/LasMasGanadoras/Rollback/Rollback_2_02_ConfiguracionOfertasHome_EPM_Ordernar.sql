use [BelcorpPeru_BPT];
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		update 
			dbo.configuracionofertashome 
		set 
			 desktoporden		= desktoporden		- 1
			,mobileorden		= mobileorden		- 1
			,desktopordenbpt	= desktopordenbpt	- 1
			,mobileordenbpt		= mobileordenbpt	- 1
		where 
			not desktoporden in(0,1);

	end;
end;

use [BelcorpChile_BPT];
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		update 
			dbo.configuracionofertashome 
		set 
			 desktoporden		= desktoporden		- 1
			,mobileorden		= mobileorden		- 1
			,desktopordenbpt	= desktopordenbpt	- 1
			,mobileordenbpt		= mobileordenbpt	- 1
		where 
			not desktoporden in(0,1);

	end;
end;

use [BelcorpCostaRica_BPT];
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		update 
			dbo.configuracionofertashome 
		set 
			 desktoporden		= desktoporden		- 1
			,mobileorden		= mobileorden		- 1
			,desktopordenbpt	= desktopordenbpt	- 1
			,mobileordenbpt		= mobileordenbpt	- 1
		where 
			not desktoporden in(0,1);

	end;
end;