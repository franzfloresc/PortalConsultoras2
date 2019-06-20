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
			,desktopcantidadproductos = 3,mobilecantidadproductos = 0
			,desktopimagenfondo='BO_2018141641_vgasxyoiqi.png',mobileimagenfondo='BO_201845842_suzmhzyezi.png'
			,desktoptipopresentacion=3,mobiletipopresentacion=4
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
			 desktoptitulo = 'Especial de Preventa Navideña',MobileTitulo = 'Especial de Preventa Navideña'
			,desktopcantidadproductos=0,mobilecantidadproductos=0
			,desktoptipopresentacion=5,mobiletipopresentacion=4	
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
			,desktopcantidadproductos = 3,mobilecantidadproductos = 0
			,desktopimagenfondo='CL_20171242435_ahhomcawxm.png',mobileimagenfondo='CL_201849438_hcmrnzpmdt.png'
			,desktoptipopresentacion=3,mobiletipopresentacion=4
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
			 desktoptitulo = 'Ofertas Especiales',MobileTitulo = null
			,desktopcantidadproductos=0,mobilecantidadproductos=0
			,desktoptipopresentacion=5,mobiletipopresentacion=4	
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
			,desktopcantidadproductos = 3,mobilecantidadproductos = 0
			,desktopimagenfondo='CO_2018141425_fkqsptafdq.png',mobileimagenfondo='CO_2018410304_awtqofqoot.png'
			,desktoptipopresentacion=3,mobiletipopresentacion=4
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
			 desktoptitulo = 'OFERTAS ESPECIALES: PREPÁRATE PARA LA NAVIDAD',MobileTitulo = 'OFERTAS ESPECIALES: PREPÁRATE PARA LA NAVIDAD'
			,desktopcantidadproductos=0,mobilecantidadproductos=0
			,desktoptipopresentacion=5,mobiletipopresentacion=4	
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
			,desktopcantidadproductos = 3,mobilecantidadproductos = 0
			,desktopimagenfondo='CR_20171231977_czjzrriofc.png',mobileimagenfondo='CR_2018411542_ruofgirkve.png'
			,desktoptipopresentacion=3,mobiletipopresentacion=4
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
			 desktoptitulo = 'Especial de Navidad',MobileTitulo = 'Especial'
			,desktopcantidadproductos=0,mobilecantidadproductos=0
			,desktoptipopresentacion=5,mobiletipopresentacion=4	
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
			,desktopcantidadproductos = 3,mobilecantidadproductos = 0
			,desktopimagenfondo='rd-fondo-desktop.png',mobileimagenfondo='DO_2018418734_zprpiglvrf.png'
			,desktoptipopresentacion=3,mobiletipopresentacion=4
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
			 desktoptitulo = 'Ofertas Exclusivas Online',MobileTitulo = null
			,desktopcantidadproductos=0,mobilecantidadproductos=0
			,desktoptipopresentacion=5,mobiletipopresentacion=4	
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
			,desktopcantidadproductos = 3,mobilecantidadproductos = 0
			,desktopimagenfondo='EC_2018143439_cpmrixuhmd.png',mobileimagenfondo='EC_2018413417_iunbsjwehn.png'
			,desktoptipopresentacion=3,mobiletipopresentacion=4
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
			 desktoptitulo = 'Especial Venta Navideña',MobileTitulo = null
			,desktopcantidadproductos=0,mobilecantidadproductos=0
			,desktoptipopresentacion=5,mobiletipopresentacion=4	
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
			,desktopcantidadproductos = 3,mobilecantidadproductos = 0
			,desktopimagenfondo='rd-fondo-desktop.png',mobileimagenfondo='GT_2018415491_wuoaulnkbl.png'
			,desktoptipopresentacion=3,mobiletipopresentacion=4
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
			 desktoptitulo = null,MobileTitulo = null
			,desktopcantidadproductos=0,mobilecantidadproductos=0
			,desktoptipopresentacion=5,mobiletipopresentacion=4	
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
			,desktopcantidadproductos = 3,mobilecantidadproductos = 0
			,desktopimagenfondo='rd-fondo-desktop.png',mobileimagenfondo='MX_2018417605_syphrwcexd.png'
			,desktoptipopresentacion=3,mobiletipopresentacion=4
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
			 desktoptitulo = 'Especial de Navidad',MobileTitulo = 'Especial de Navidad'
			,desktopcantidadproductos=0,mobilecantidadproductos=0
			,desktoptipopresentacion=5,mobiletipopresentacion=4	
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
			,desktopcantidadproductos = 3,mobilecantidadproductos = 0
			,desktopimagenfondo='rd-fondo-desktop.png',mobileimagenfondo='PA_2018417535_eiasptkbqn.png'
			,desktoptipopresentacion=3,mobiletipopresentacion=4
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
			 desktoptitulo = 'Especial de Navidad',MobileTitulo = 'Especial'
			,desktopcantidadproductos=0,mobilecantidadproductos=0
			,desktoptipopresentacion=5,mobiletipopresentacion=4	
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
			,desktopcantidadproductos = 3,mobilecantidadproductos = 0
			,desktopimagenfondo='PE_201815452_hcjwvgqhud.png',mobileimagenfondo='PE_201842178_isszhwkrja.png'
			,desktoptipopresentacion=3,mobiletipopresentacion=4
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
			 desktoptitulo = 'ESPECIAL DE NAVIDAD',MobileTitulo = 'NAVIDAD'
			,desktopcantidadproductos=0,mobilecantidadproductos=0
			,desktoptipopresentacion=5,mobiletipopresentacion=4	
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
			,desktopcantidadproductos = 3,mobilecantidadproductos = 0
			,desktopimagenfondo='rd-fondo-desktop.png',mobileimagenfondo='PR_2018418256_zvtfbgyefz.png'
			,desktoptipopresentacion=3,mobiletipopresentacion=4
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
			 desktoptitulo = 'Prepara, repara e hidrata',MobileTitulo = null
			,desktopcantidadproductos=0,mobilecantidadproductos=0
			,desktoptipopresentacion=5,mobiletipopresentacion=4	
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
			,desktopcantidadproductos = 3,mobilecantidadproductos = 0
			,desktopimagenfondo='rd-fondo-desktop.png',mobileimagenfondo='SV_2018413796_hcmjtammqv.png'
			,desktoptipopresentacion=3,mobiletipopresentacion=4
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
			 desktoptitulo = null,MobileTitulo = null
			,desktopcantidadproductos=0,mobilecantidadproductos=0
			,desktoptipopresentacion=5,mobiletipopresentacion=4	
		where 
			((ConfiguracionPaisID = @vConfiguracionPaisIDSalvador) and 
			 (CampaniaID in(201817,201818)));
	end;
end;