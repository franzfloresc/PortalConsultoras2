use [BelcorpPeru_BPT];
go

begin
	-- actualiza configuracionofertashome
	update 
		dbo.configuracionofertashome 
	set 
		 desktoporden		= desktoporden		+ 1
		,mobileorden		= mobileorden		+ 1
		,desktopordenbpt	= desktopordenbpt	+ 1
		,mobileordenbpt		= mobileordenbpt	+ 1
	where 
		not desktoporden in(0,1);
end;
go

use [BelcorpChile_BPT];
go

begin
	-- actualiza configuracionofertashome
	update 
		dbo.configuracionofertashome 
	set 
		 desktoporden		= desktoporden		+ 1
		,mobileorden		= mobileorden		+ 1
		,desktopordenbpt	= desktopordenbpt	+ 1
		,mobileordenbpt		= mobileordenbpt	+ 1
	where 
		not desktoporden in(0,1);
end;
go

use [BelcorpCostaRica_BPT];
go

begin
	-- actualiza configuracionofertashome
	update 
		dbo.configuracionofertashome 
	set 
		 desktoporden		= desktoporden		+ 1
		,mobileorden		= mobileorden		+ 1
		,desktopordenbpt	= desktopordenbpt	+ 1
		,mobileordenbpt		= mobileordenbpt	+ 1
	where 
		not desktoporden in(0,1);
end;
go