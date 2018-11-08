use BelcorpPeru_BPT;
go

begin
	declare @vConfiguracionPaisIDPeru int;
	declare @vCampaniaIDPeru int;

	set @vCampaniaIDPeru = 201816;

	/* Revista digital 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'RD'))
	begin
		set @vConfiguracionPaisIDPeru = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'RD');

		update 
			dbo.configuracionofertashome 
		set 
			 desktoptitulo = 'OFERTAS PARA TI',MobileTitulo = 'OFERTAS PARA TI'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktopimagenfondo='banner_ganadoras_desktop.jpg',mobileimagenfondo='banner_ganadoras_mobile.jpg'
			,desktoptipopresentacion=9,mobiletipopresentacion=9
		where 
			(ConfiguracionPaisID = @vConfiguracionPaisIDPeru);
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDPeru = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		update
			dbo.configuracionofertashome 
		set
			 desktoptitulo = 'ESPECIAL DE NAVIDAD',MobileTitulo = 'ESPECIAL DE NAVIDAD'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktoptipopresentacion=9,mobiletipopresentacion=9	
		where 
			((ConfiguracionPaisID = @vConfiguracionPaisIDPeru) and 
			 (CampaniaID >= @vCampaniaIDPeru));
	end;
end;

use BelcorpChile_BPT;
go

begin
	declare @vConfiguracionPaisIDChile int;
	declare @vCampaniaIDChile int;

	set @vCampaniaIDChile = 201813;

	/* Revista digital 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'RD'))
	begin
		set @vConfiguracionPaisIDChile = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'RD');

		update 
			dbo.configuracionofertashome 
		set 
			 desktoptitulo = 'OFERTAS PARA TI',MobileTitulo = 'OFERTAS PARA TI'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktopimagenfondo='banner_ganadoras_desktop.jpg',mobileimagenfondo='banner_ganadoras_mobile.jpg'
			,desktoptipopresentacion=9,mobiletipopresentacion=9
		where 
			(ConfiguracionPaisID = @vConfiguracionPaisIDChile);
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDChile = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		update
			dbo.configuracionofertashome 
		set
			 desktoptitulo = 'ESPECIAL DE NAVIDAD',MobileTitulo = 'ESPECIAL DE NAVIDAD'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktoptipopresentacion=9,mobiletipopresentacion=9	
		where 
			((ConfiguracionPaisID = @vConfiguracionPaisIDChile) and 
			 (CampaniaID >= @vCampaniaIDChile));
	end;
end;

use BelcorpCostaRica_BPT;
go

begin
	declare @vConfiguracionPaisIDCostaRica int;
	declare @vCampaniaIDCostaRica int;

	set @vCampaniaIDCostaRica = 201816;

	/* Revista digital 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'RD'))
	begin
		set @vConfiguracionPaisIDCostaRica = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'RD');

		update 
			dbo.configuracionofertashome 
		set 
			 desktoptitulo = 'OFERTAS PARA TI',MobileTitulo = 'OFERTAS PARA TI'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktopimagenfondo='banner_ganadoras_desktop.jpg',mobileimagenfondo='banner_ganadoras_mobile.jpg'
			,desktoptipopresentacion=9,mobiletipopresentacion=9
		where 
			(ConfiguracionPaisID = @vConfiguracionPaisIDCostaRica);
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDCostaRica = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		update
			dbo.configuracionofertashome 
		set
			 desktoptitulo = 'ESPECIAL DE NAVIDAD',MobileTitulo = 'ESPECIAL DE NAVIDAD'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktoptipopresentacion=9,mobiletipopresentacion=9	
		where 
			((ConfiguracionPaisID = @vConfiguracionPaisIDCostaRica) and 
			 (CampaniaID >= @vCampaniaIDCostaRica));
	end;
end;