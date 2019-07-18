use BelcorpColombia_GANAMAS;
go

begin
	if(exists(select 1 from ConfiguracionPais where codigo='MG'))
	begin
		update ConfiguracionOfertasHome
		set
			DesktopTipoEstrategia = 'LMG',
			MobileTipoEstrategia = 'LMG'
		where 
			(ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from ConfiguracionPais where codigo='MG'));
	end;
end;
go

use BelcorpPeru_GANAMAS;
go

begin
	if(exists(select 1 from ConfiguracionPais where codigo='MG'))
	begin
		update ConfiguracionOfertasHome
		set
			DesktopTipoEstrategia = 'LMG',
			MobileTipoEstrategia = 'LMG'
		where 
			(ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from ConfiguracionPais where codigo='MG'));
	end;
end;
go

use BelcorpChile_GANAMAS;
go

begin
	if(exists(select 1 from ConfiguracionPais where codigo='MG'))
	begin
		update ConfiguracionOfertasHome
		set
			DesktopTipoEstrategia = 'LMG',
			MobileTipoEstrategia = 'LMG'
		where 
			(ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from ConfiguracionPais where codigo='MG'));
	end;
end;
go

use BelcorpCostaRica_GANAMAS;
go

begin
	if(exists(select 1 from ConfiguracionPais where codigo='MG'))
	begin
		update ConfiguracionOfertasHome
		set
			DesktopTipoEstrategia = 'LMG',
			MobileTipoEstrategia = 'LMG'
		where 
			(ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from ConfiguracionPais where codigo='MG'));
	end;
end;
go

use BelcorpEcuador_GANAMAS;
go

begin
	if(exists(select 1 from ConfiguracionPais where codigo='MG'))
	begin
		update ConfiguracionOfertasHome
		set
			DesktopTipoEstrategia = 'LMG',
			MobileTipoEstrategia = 'LMG'
		where 
			(ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from ConfiguracionPais where codigo='MG'));
	end;
end;
go

use BelcorpMexico_GANAMAS;
go

begin
	if(exists(select 1 from ConfiguracionPais where codigo='MG'))
	begin
		update ConfiguracionOfertasHome
		set
			DesktopTipoEstrategia = 'LMG',
			MobileTipoEstrategia = 'LMG'
		where 
			(ConfiguracionPaisID = (select top 1 ConfiguracionPaisID from ConfiguracionPais where codigo='MG'));
	end;
end;
go
