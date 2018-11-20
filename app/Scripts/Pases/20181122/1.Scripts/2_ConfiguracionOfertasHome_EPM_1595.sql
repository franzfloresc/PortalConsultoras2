use BelcorpBolivia;
go

begin
	declare @vConfiguracionPaisIDBolivia int;

	/* Revista digital 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'RD'))
	begin
		set @vConfiguracionPaisIDBolivia = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'RD');

		update 
			dbo.configuracionofertashome 
		set 
			 desktoptitulo = 'OFERTAS PARA TI',MobileTitulo = 'OFERTAS PARA TI'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktopimagenfondo='Banner-OPT-C18-desktop.jpg',mobileimagenfondo='Banner-OPT-C18-mobile.jpg'
			,desktoptipopresentacion=9,mobiletipopresentacion=9
		where 
			(ConfiguracionPaisID = @vConfiguracionPaisIDBolivia);
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDBolivia = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		update
			dbo.configuracionofertashome 
		set
			 desktoptitulo = 'ESPECIAL DE NAVIDAD',MobileTitulo = 'ESPECIAL DE NAVIDAD'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktoptipopresentacion=9,mobiletipopresentacion=9	
		where 
			((ConfiguracionPaisID = @vConfiguracionPaisIDBolivia) and 
			 (CampaniaID in(201817,201818)));
	end;
end;

use BelcorpChile;
go

begin
	declare @vConfiguracionPaisIDChile int;

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
			,desktopimagenfondo='Banner-OPT-C18-desktop.jpg',mobileimagenfondo='Banner-OPT-C18-mobile.jpg'
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
			 (CampaniaID in(201817,201818)));
	end;
end;

use BelcorpColombia;
go

begin
	declare @vConfiguracionPaisIDColombia int;

	/* Revista digital 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'RD'))
	begin
		set @vConfiguracionPaisIDColombia = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'RD');

		update 
			dbo.configuracionofertashome 
		set 
			 desktoptitulo = 'OFERTAS PARA TI',MobileTitulo = 'OFERTAS PARA TI'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktopimagenfondo='Banner-OPT-C18-desktop.jpg',mobileimagenfondo='Banner-OPT-C18-mobile.jpg'
			,desktoptipopresentacion=9,mobiletipopresentacion=9
		where 
			(ConfiguracionPaisID = @vConfiguracionPaisIDColombia);
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDColombia = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		update
			dbo.configuracionofertashome 
		set
			 desktoptitulo = 'ESPECIAL DE NAVIDAD',MobileTitulo = 'ESPECIAL DE NAVIDAD'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktoptipopresentacion=9,mobiletipopresentacion=9	
		where 
			((ConfiguracionPaisID = @vConfiguracionPaisIDColombia) and 
			 (CampaniaID in(201817,201818)));
	end;
end;

use BelcorpCostaRica;
go

begin
	declare @vConfiguracionPaisIDCostaRica int;

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
			,desktopimagenfondo='Banner-OPT-C18-desktop.jpg',mobileimagenfondo='Banner-OPT-C18-mobile.jpg'
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
			 (CampaniaID in(201817,201818)));
	end;
end;

use BelcorpDominicana;
go

begin
	declare @vConfiguracionPaisIDDominicana int;

	/* Revista digital 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'RD'))
	begin
		set @vConfiguracionPaisIDDominicana = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'RD');

		update 
			dbo.configuracionofertashome 
		set 
			 desktoptitulo = 'OFERTAS PARA TI',MobileTitulo = 'OFERTAS PARA TI'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktopimagenfondo='Banner-OPT-C18-desktop.jpg',mobileimagenfondo='Banner-OPT-C18-mobile.jpg'
			,desktoptipopresentacion=9,mobiletipopresentacion=9
		where 
			(ConfiguracionPaisID = @vConfiguracionPaisIDDominicana);
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDDominicana = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		update
			dbo.configuracionofertashome 
		set
			 desktoptitulo = 'ESPECIAL DE NAVIDAD',MobileTitulo = 'ESPECIAL DE NAVIDAD'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktoptipopresentacion=9,mobiletipopresentacion=9	
		where 
			((ConfiguracionPaisID = @vConfiguracionPaisIDDominicana) and 
			 (CampaniaID in(201817,201818)));
	end;
end;

use BelcorpEcuador;
go

begin
	declare @vConfiguracionPaisIDEcuador int;

	/* Revista digital 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'RD'))
	begin
		set @vConfiguracionPaisIDEcuador = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'RD');

		update 
			dbo.configuracionofertashome 
		set 
			 desktoptitulo = 'OFERTAS PARA TI',MobileTitulo = 'OFERTAS PARA TI'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktopimagenfondo='Banner-OPT-C18-desktop.jpg',mobileimagenfondo='Banner-OPT-C18-mobile.jpg'
			,desktoptipopresentacion=9,mobiletipopresentacion=9
		where 
			(ConfiguracionPaisID = @vConfiguracionPaisIDEcuador);
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDEcuador = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		update
			dbo.configuracionofertashome 
		set
			 desktoptitulo = 'ESPECIAL DE NAVIDAD',MobileTitulo = 'ESPECIAL DE NAVIDAD'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktoptipopresentacion=9,mobiletipopresentacion=9	
		where 
			((ConfiguracionPaisID = @vConfiguracionPaisIDEcuador) and 
			 (CampaniaID in(201817,201818)));
	end;
end;

use BelcorpGuatemala;
go

begin
	declare @vConfiguracionPaisIDGuatemala int;

	/* Revista digital 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'RD'))
	begin
		set @vConfiguracionPaisIDGuatemala = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'RD');

		update 
			dbo.configuracionofertashome 
		set 
			 desktoptitulo = 'OFERTAS PARA TI',MobileTitulo = 'OFERTAS PARA TI'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktopimagenfondo='Banner-OPT-C18-desktop.jpg',mobileimagenfondo='Banner-OPT-C18-mobile.jpg'
			,desktoptipopresentacion=9,mobiletipopresentacion=9
		where 
			(ConfiguracionPaisID = @vConfiguracionPaisIDGuatemala);
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDGuatemala = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		update
			dbo.configuracionofertashome 
		set
			 desktoptitulo = 'ESPECIAL DE NAVIDAD',MobileTitulo = 'ESPECIAL DE NAVIDAD'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktoptipopresentacion=9,mobiletipopresentacion=9	
		where 
			((ConfiguracionPaisID = @vConfiguracionPaisIDGuatemala) and 
			 (CampaniaID in(201817,201818)));
	end;
end;

use BelcorpMexico;
go

begin
	declare @vConfiguracionPaisIDMexico int;

	/* Revista digital 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'RD'))
	begin
		set @vConfiguracionPaisIDMexico = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'RD');

		update 
			dbo.configuracionofertashome 
		set 
			 desktoptitulo = 'OFERTAS PARA TI',MobileTitulo = 'OFERTAS PARA TI'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktopimagenfondo='Banner-OPT-C18-desktop.jpg',mobileimagenfondo='Banner-OPT-C18-mobile.jpg'
			,desktoptipopresentacion=9,mobiletipopresentacion=9
		where 
			(ConfiguracionPaisID = @vConfiguracionPaisIDMexico);
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDMexico = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		update
			dbo.configuracionofertashome 
		set
			 desktoptitulo = 'ESPECIAL DE NAVIDAD',MobileTitulo = 'ESPECIAL DE NAVIDAD'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktoptipopresentacion=9,mobiletipopresentacion=9	
		where 
			((ConfiguracionPaisID = @vConfiguracionPaisIDMexico) and 
			 (CampaniaID in(201817,201818)));
	end;
end;

use BelcorpPanama;
go

begin
	declare @vConfiguracionPaisIDPanama int;

	/* Revista digital 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'RD'))
	begin
		set @vConfiguracionPaisIDPanama = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'RD');

		update 
			dbo.configuracionofertashome 
		set 
			 desktoptitulo = 'OFERTAS PARA TI',MobileTitulo = 'OFERTAS PARA TI'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktopimagenfondo='Banner-OPT-C18-desktop.jpg',mobileimagenfondo='Banner-OPT-C18-mobile.jpg'
			,desktoptipopresentacion=9,mobiletipopresentacion=9
		where 
			(ConfiguracionPaisID = @vConfiguracionPaisIDPanama);
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDPanama = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		update
			dbo.configuracionofertashome 
		set
			 desktoptitulo = 'ESPECIAL DE NAVIDAD',MobileTitulo = 'ESPECIAL DE NAVIDAD'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktoptipopresentacion=9,mobiletipopresentacion=9	
		where 
			((ConfiguracionPaisID = @vConfiguracionPaisIDPanama) and 
			 (CampaniaID in(201817,201818)));
	end;
end;

use BelcorpPeru;
go

begin
	declare @vConfiguracionPaisIDPeru int;

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
			,desktopimagenfondo='Banner-OPT-C18-desktop.jpg',mobileimagenfondo='Banner-OPT-C18-mobile.jpg'
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
			 (CampaniaID in(201817,201818)));
	end;
end;

use BelcorpPuertoRico;
go

begin
	declare @vConfiguracionPaisIDPuertoRico int;

	/* Revista digital 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'RD'))
	begin
		set @vConfiguracionPaisIDPuertoRico = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'RD');

		update 
			dbo.configuracionofertashome 
		set 
			 desktoptitulo = 'OFERTAS PARA TI',MobileTitulo = 'OFERTAS PARA TI'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktopimagenfondo='Banner-OPT-C18-desktop.jpg',mobileimagenfondo='Banner-OPT-C18-mobile.jpg'
			,desktoptipopresentacion=9,mobiletipopresentacion=9
		where 
			(ConfiguracionPaisID = @vConfiguracionPaisIDPuertoRico);
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDPuertoRico = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		update
			dbo.configuracionofertashome 
		set
			 desktoptitulo = 'ESPECIAL DE NAVIDAD',MobileTitulo = 'ESPECIAL DE NAVIDAD'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktoptipopresentacion=9,mobiletipopresentacion=9	
		where 
			((ConfiguracionPaisID = @vConfiguracionPaisIDPuertoRico) and 
			 (CampaniaID in(201812,201813)));
	end;
end;

use BelcorpSalvador;
go

begin
	declare @vConfiguracionPaisIDSalvador int;

	/* Revista digital 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'RD'))
	begin
		set @vConfiguracionPaisIDSalvador = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'RD');

		update 
			dbo.configuracionofertashome 
		set 
			 desktoptitulo = 'OFERTAS PARA TI',MobileTitulo = 'OFERTAS PARA TI'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktopimagenfondo='Banner-OPT-C18-desktop.jpg',mobileimagenfondo='Banner-OPT-C18-mobile.jpg'
			,desktoptipopresentacion=9,mobiletipopresentacion=9
		where 
			(ConfiguracionPaisID = @vConfiguracionPaisIDSalvador);
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDSalvador = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		update
			dbo.configuracionofertashome 
		set
			 desktoptitulo = 'ESPECIAL DE NAVIDAD',MobileTitulo = 'ESPECIAL DE NAVIDAD'
			,desktopcantidadproductos = 5,mobilecantidadproductos = 5
			,desktoptipopresentacion=9,mobiletipopresentacion=9	
		where 
			((ConfiguracionPaisID = @vConfiguracionPaisIDSalvador) and 
			 (CampaniaID in(201817,201818)));
	end;
end;