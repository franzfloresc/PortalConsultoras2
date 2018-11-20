use BelcorpBolivia;
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

use BelcorpChile;
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

use BelcorpColombia;
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

use BelcorpCostaRica;
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

use BelcorpDominicana;
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

use BelcorpEcuador;
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

use BelcorpGuatemala;
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

use BelcorpMexico;
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

use BelcorpPanama;
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

use BelcorpPeru;
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

use BelcorpPuertoRico;
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

use BelcorpSalvador;
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