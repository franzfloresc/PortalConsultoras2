use BelcorpPeru_BPT;
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
				,valor1 = 'TENEMOS MÁS&nbsp;OPCIONES PARA TI'
				,valor2 = 'TENEMOS MÁS&nbsp;OPCIONES PARA TI' 
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
			(@vConfiguracionPaisIDPeru,'BannerCarruselTitulo',0,'TENEMOS MÁS&nbsp;OPCIONES PARA TI','TENEMOS MÁS&nbsp;OPCIONES PARA TI','Texto para el banner del carrusel',1,'BannerCarrusel');
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
				,valor1 = 'TENEMOS MÁS&nbsp;OPCIONES PARA TI'
				,valor2 = 'TENEMOS MÁS&nbsp;OPCIONES PARA TI' 
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
			(@vConfiguracionPaisIDPeru,'BannerCarruselTitulo',0,'TENEMOS MÁS&nbsp;OPCIONES PARA TI','TENEMOS MÁS&nbsp;OPCIONES PARA TI','Texto para el banner del carrusel',1,'BannerCarrusel');
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

use BelcorpChile_BPT;
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
				,valor1 = 'TENEMOS MÁS&nbsp;OPCIONES PARA TI'
				,valor2 = 'TENEMOS MÁS&nbsp;OPCIONES PARA TI' 
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
			(@vConfiguracionPaisIDChile,'BannerCarruselTitulo',0,'TENEMOS MÁS&nbsp;OPCIONES PARA TI','TENEMOS MÁS&nbsp;OPCIONES PARA TI','Texto para el banner del carrusel',1,'BannerCarrusel');
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
				,valor1 = 'TENEMOS MÁS&nbsp;OPCIONES PARA TI'
				,valor2 = 'TENEMOS MÁS&nbsp;OPCIONES PARA TI' 
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
			(@vConfiguracionPaisIDChile,'BannerCarruselTitulo',0,'TENEMOS MÁS&nbsp;OPCIONES PARA TI','TENEMOS MÁS&nbsp;OPCIONES PARA TI','Texto para el banner del carrusel',1,'BannerCarrusel');
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

use BelcorpCostaRica_BPT;
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
				,valor1 = 'TENEMOS MÁS&nbsp;OPCIONES PARA TI'
				,valor2 = 'TENEMOS MÁS&nbsp;OPCIONES PARA TI' 
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
			(@vConfiguracionPaisIDCostaRica,'BannerCarruselTitulo',0,'TENEMOS MÁS&nbsp;OPCIONES PARA TI','TENEMOS MÁS&nbsp;OPCIONES PARA TI','Texto para el banner del carrusel',1,'BannerCarrusel');
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
				,valor1 = 'TENEMOS MÁS&nbsp;OPCIONES PARA TI'
				,valor2 = 'TENEMOS MÁS&nbsp;OPCIONES PARA TI' 
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
			(@vConfiguracionPaisIDCostaRica,'BannerCarruselTitulo',0,'TENEMOS MÁS&nbsp;OPCIONES PARA TI','TENEMOS MÁS&nbsp;OPCIONES PARA TI','Texto para el banner del carrusel',1,'BannerCarrusel');
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