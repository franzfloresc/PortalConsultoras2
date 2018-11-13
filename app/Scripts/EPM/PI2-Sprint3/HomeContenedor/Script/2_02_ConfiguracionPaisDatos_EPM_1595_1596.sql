use BelcorpBolivia;
go

begin
	declare @vConfiguracionPaisIDBolivia int;
	
	/* Revista digital 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'RD'))
	begin
		set @vConfiguracionPaisIDBolivia = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'RD');

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDBolivia) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDBolivia) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDBolivia,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDBolivia) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDBolivia) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDBolivia,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDBolivia) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDBolivia) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDBolivia,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDBolivia = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDBolivia) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDBolivia) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDBolivia,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDBolivia) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDBolivia) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDBolivia,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDBolivia) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDBolivia) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDBolivia,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
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

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDChile) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDChile) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDChile,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDChile) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDChile) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDChile,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDChile) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDChile) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDChile,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDChile = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDChile) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDChile) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDChile,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDChile) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDChile) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDChile,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDChile) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDChile) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDChile,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
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

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDColombia) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDColombia) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDColombia,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDColombia) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDColombia) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDColombia,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDColombia) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDColombia) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDColombia,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDColombia = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDColombia) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDColombia) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDColombia,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDColombia) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDColombia) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDColombia,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDColombia) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDColombia) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDColombia,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
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

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDCostaRica) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDCostaRica) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDCostaRica,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDCostaRica) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDCostaRica) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDCostaRica,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDCostaRica) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDCostaRica) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDCostaRica,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDCostaRica = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDCostaRica) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDCostaRica) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDCostaRica,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDCostaRica) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDCostaRica) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDCostaRica,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDCostaRica) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDCostaRica) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDCostaRica,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
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

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDDominicana) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDDominicana) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDDominicana,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDDominicana) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDDominicana) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDDominicana,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDDominicana) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDDominicana) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDDominicana,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDDominicana = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDDominicana) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDDominicana) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDDominicana,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDDominicana) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDDominicana) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDDominicana,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDDominicana) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDDominicana) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDDominicana,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
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

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDEcuador) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDEcuador) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDEcuador,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDEcuador) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDEcuador) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDEcuador,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDEcuador) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDEcuador) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDEcuador,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDEcuador = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDEcuador) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDEcuador) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDEcuador,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDEcuador) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDEcuador) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDEcuador,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDEcuador) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDEcuador) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDEcuador,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
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

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDGuatemala) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDGuatemala) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDGuatemala,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDGuatemala) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDGuatemala) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDGuatemala,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDGuatemala) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDGuatemala) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDGuatemala,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDGuatemala = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDGuatemala) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDGuatemala) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDGuatemala,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDGuatemala) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDGuatemala) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDGuatemala,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDGuatemala) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDGuatemala) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDGuatemala,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
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

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDMexico) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDMexico) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDMexico,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDMexico) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDMexico) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDMexico,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDMexico) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDMexico) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDMexico,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDMexico = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDMexico) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDMexico) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDMexico,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDMexico) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDMexico) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDMexico,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDMexico) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDMexico) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDMexico,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
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

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPanama) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPanama) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPanama,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPanama) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPanama) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPanama,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPanama) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPanama) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPanama,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDPanama = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPanama) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPanama) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPanama,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPanama) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPanama) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPanama,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPanama) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPanama) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPanama,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
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

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPeru) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPeru) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPeru,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPeru) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPeru) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPeru,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPeru) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPeru) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPeru,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDPeru = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPeru) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPeru) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPeru,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPeru) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPeru) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPeru,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPeru) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPeru) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPeru,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
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

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPuertoRico) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPuertoRico) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPuertoRico,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPuertoRico) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPuertoRico) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPuertoRico,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPuertoRico) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPuertoRico) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPuertoRico,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDPuertoRico = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPuertoRico) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPuertoRico) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPuertoRico,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPuertoRico) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPuertoRico) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPuertoRico,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDPuertoRico) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDPuertoRico) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDPuertoRico,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
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

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDSalvador) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDSalvador) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDSalvador,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDSalvador) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDSalvador) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDSalvador,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDSalvador) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDSalvador) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDSalvador,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDSalvador = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDSalvador) and (Codigo = 'BannerCarruselTitulo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>'
				,valor2 = 'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>' 
				,Descripcion = 'Texto para el banner del carrusel'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDSalvador) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDSalvador,'BannerCarruselTitulo',0,'TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','TENEMOS <b>MÁS&nbsp;OPCIONES PARA TI</b>','Texto para el banner del carrusel',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDSalvador) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'VER MÁS'
				,valor2 = 'VER MÁS' 
				,Descripcion = 'Texto para el botón'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDSalvador) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDSalvador,'BannerCarruselTextoEnlace',0,'VER MÁS','VER MÁS','Texto para el botón',1,'BannerCarrusel');
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDSalvador) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			update 
				dbo.configuracionpaisdatos 
			set 
				 CampaniaID = 0
				,valor1 = 'banner_carrusel_desktop.jpg'
				,valor2 = 'banner_carrusel_mobile.jpg' 
				,Descripcion = 'Imagen de fondo para el banner'
				,Estado = 1
				,Componente = 'BannerCarrusel'
			where 
				((configuracionpaisid = @vConfiguracionPaisIDSalvador) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
		else
		begin
			insert into dbo.configuracionpaisdatos(ConfiguracionPaisId,Codigo,CampaniaID,Valor1,Valor2,Descripcion,Estado,Componente)  values 
			(@vConfiguracionPaisIDSalvador,'BannerCarruselImagenFondo',0,'banner_carrusel_desktop.jpg','banner_carrusel_mobile.jpg','Imagen de fondo para el banner',1,'BannerCarrusel');
		end;
	end;
end;