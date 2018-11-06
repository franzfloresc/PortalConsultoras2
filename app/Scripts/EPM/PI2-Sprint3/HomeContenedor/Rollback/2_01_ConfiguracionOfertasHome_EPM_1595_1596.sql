use BelcorpPeru_BPT;
go

begin
	declare @vConfiguracionPaisID int;
	declare @vCampaniaID int;

	set @vCampaniaID = 201816;
	
	/* Revista digital 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'RD'))
	begin
		set @vConfiguracionPaisID = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'RD');

		update 
			dbo.configuracionofertashome 
		set 
			 desktoptitulo = 'OFERTAS PARA TI',MobileTitulo = 'OFERTAS PARA TI'
			,desktopcantidadproductos = 3,mobilecantidadproductos = 0
			,desktopimagenfondo='PE_201815452_hcjwvgqhud.png',mobileimagenfondo='PE_201842178_isszhwkrja.png'
			,desktoptipopresentacion=3,mobiletipopresentacion=4
		where 
			(ConfiguracionPaisID = @vConfiguracionPaisID);
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisID = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		update
			dbo.configuracionofertashome 
		set
			 desktoptitulo = 'ESPECIAL DE Preventa Navideña',MobileTitulo = 'Especial'
			,desktopcantidadproductos=0,mobilecantidadproductos=0
			,desktoptipopresentacion=5,mobiletipopresentacion=4	
		where 
			((ConfiguracionPaisID = @vConfiguracionPaisID) and 
			 (CampaniaID >= @vCampaniaID));
	end;
end;

use BelcorpChile_BPT;
go

begin
	declare @vConfiguracionPaisIDChile int;
	declare @vCampaniaIDChile int;

	set @vCampaniaIDChile = 201816;

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
			,desktopimagenfondo='PE_201815452_hcjwvgqhud.png',mobileimagenfondo='PE_201842178_isszhwkrja.png'
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
			 desktoptitulo = 'ESPECIAL DE Preventa Navideña',MobileTitulo = 'Especial'
			,desktopcantidadproductos=0,mobilecantidadproductos=0
			,desktoptipopresentacion=5,mobiletipopresentacion=4	
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
			 desktoptitulo = 'ESPECIAL Preventa Navideña',MobileTitulo = 'Especial'
			,desktopcantidadproductos=0,mobilecantidadproductos=0
			,desktoptipopresentacion=5,mobiletipopresentacion=4	
		where 
			((ConfiguracionPaisID = @vConfiguracionPaisIDCostaRica) and 
			 (CampaniaID >= @vCampaniaIDCostaRica));
	end;
end;