use BelcorpPeru_BPT;
go

begin
	declare @vConfiguracionPaisID int;
	
	/* Revista digital 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'RD'))
	begin
		set @vConfiguracionPaisID = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'RD');

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisID) and (Codigo = 'BannerCarruselTitulo')))
		begin
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisID) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisID) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisID) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisID) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisID) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisID = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisID) and (Codigo = 'BannerCarruselTitulo')))
		begin
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisID) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisID) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisID) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisID) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisID) and 
				 (codigo = 'BannerCarruselImagenFondo'));
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
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisIDChile) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDChile) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisIDChile) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDChile) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisIDChile) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDChile = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDChile) and (Codigo = 'BannerCarruselTitulo')))
		begin
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisIDChile) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDChile) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisIDChile) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDChile) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisIDChile) and 
				 (codigo = 'BannerCarruselImagenFondo'));
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
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisIDCostaRica) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDCostaRica) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisIDCostaRica) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDCostaRica) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisIDCostaRica) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
	end;

	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		set @vConfiguracionPaisIDCostaRica = (select ConfiguracionPaisID from dbo.ConfiguracionPais where Codigo = 'SR');

		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDCostaRica) and (Codigo = 'BannerCarruselTitulo')))
		begin
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisIDCostaRica) and 
				 (codigo = 'BannerCarruselTitulo'));
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDCostaRica) and (Codigo = 'BannerCarruselTextoEnlace')))
		begin
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisIDCostaRica) and 
				 (codigo = 'BannerCarruselTextoEnlace'));
		end;
		if(exists(select * from dbo.configuracionpaisdatos where (configuracionpaisid = @vConfiguracionPaisIDCostaRica) and (Codigo = 'BannerCarruselImagenFondo')))
		begin
			delete from dbo.configuracionpaisdatos 
			where 
				((configuracionpaisid = @vConfiguracionPaisIDCostaRica) and 
				 (codigo = 'BannerCarruselImagenFondo'));
		end;
	end;
end;