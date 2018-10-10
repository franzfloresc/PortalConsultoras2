use [BelcorpPeru_BPT];
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		update 
			dbo.configuracionpais 
		set 
			 orden			= orden			 - 1
			,ordenbpt		= ordenbpt		 - 1
			,mobileorden	= mobileorden	 - 1
			,mobileordenbpt = mobileordenbpt - 1
		where 
			not orden in(0,1);

		delete from dbo.configuracionpais where codigo = 'MG';
	end;
end;

use [BelcorpChile_BPT];
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		update 
			dbo.configuracionpais 
		set 
			 orden			= orden			 - 1
			,ordenbpt		= ordenbpt		 - 1
			,mobileorden	= mobileorden	 - 1
			,mobileordenbpt = mobileordenbpt - 1
		where 
			not orden in(0,1);

		delete from dbo.configuracionpais where codigo = 'MG';
	end;
end;

use [BelcorpCostaRica_BPT];
go

begin
	if(exists(select 1 from dbo.configuracionpais where codigo = 'MG'))
	begin
		update 
			dbo.configuracionpais 
		set 
			 orden			= orden			 - 1
			,ordenbpt		= ordenbpt		 - 1
			,mobileorden	= mobileorden	 - 1
			,mobileordenbpt = mobileordenbpt - 1
		where 
			not orden in(0,1);

		delete from dbo.configuracionpais where codigo = 'MG';
	end;
end;