use BelcorpPeru_BPT;
go

begin
	declare @vCampaniaIDPeru int;

	set @vCampaniaIDPeru = 201816;
	
	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		/* Desktop 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'banner_ganadoras_desktop.jpg'
			where
				((PersonalizacionId in(
					select
						PersonalizacionId
					from ShowRoom.Personalizacion
					where 
						(Atributo in('ImagenFondoContenedorOfertasShowRoomVenta'))
				 )) and 
				 (EventoId in (
					select 
						EventoID
					from ShowRoom.Evento
					where 
						(CampaniaID = @vCampaniaIDPeru)
				 )));
		end;

		/* Mobile 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'banner_ganadoras_mobile.jpg'
			where
				((PersonalizacionId in(
					select
						PersonalizacionId
					from ShowRoom.Personalizacion
					where 
						(Atributo in('ImagenBannerContenedorOfertasVenta'))
				 )) and 
				 (EventoId in(
					select 
						EventoID
					from ShowRoom.Evento 
					where 
						(CampaniaID = @vCampaniaIDPeru)
				 )));
		end;
	end;
end;

use BelcorpChile_BPT;
go

begin
	declare @vCampaniaIDChile int;

	set @vCampaniaIDChile = 201816;
	
	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		/* Desktop 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'banner_ganadoras_desktop.jpg'
			where
				((PersonalizacionId in(
					select
						PersonalizacionId
					from ShowRoom.Personalizacion
					where 
						(Atributo in('ImagenFondoContenedorOfertasShowRoomVenta'))
				 )) and 
				 (EventoId in (
					select 
						EventoID
					from ShowRoom.Evento
					where 
						(CampaniaID = @vCampaniaIDChile)
				 )));
		end;

		/* Mobile 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'banner_ganadoras_mobile.jpg'
			where
				((PersonalizacionId in(
					select
						PersonalizacionId
					from ShowRoom.Personalizacion
					where 
						(Atributo in('ImagenBannerContenedorOfertasVenta'))
				 )) and 
				 (EventoId in(
					select 
						EventoID
					from ShowRoom.Evento 
					where 
						(CampaniaID = @vCampaniaIDChile)
				 )));
		end;
	end;
end;

use BelcorpCostaRica_BPT;
go

begin
	declare @vCampaniaIDCostaRica int;

	set @vCampaniaIDCostaRica = 201816;
	
	/* ShowRoom 
	 */
	if(exists(select * from dbo.ConfiguracionPais where Codigo = 'SR'))
	begin
		/* Desktop 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'banner_ganadoras_desktop.jpg'
			where
				((PersonalizacionId in(
					select
						PersonalizacionId
					from ShowRoom.Personalizacion
					where 
						(Atributo in('ImagenFondoContenedorOfertasShowRoomVenta'))
				 )) and 
				 (EventoId in (
					select 
						EventoID
					from ShowRoom.Evento
					where 
						(CampaniaID = @vCampaniaIDCostaRica)
				 )));
		end;

		/* Mobile 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'banner_ganadoras_mobile.jpg'
			where
				((PersonalizacionId in(
					select
						PersonalizacionId
					from ShowRoom.Personalizacion
					where 
						(Atributo in('ImagenBannerContenedorOfertasVenta'))
				 )) and 
				 (EventoId in(
					select 
						EventoID
					from ShowRoom.Evento 
					where 
						(CampaniaID = @vCampaniaIDCostaRica)
				 )));
		end;
	end;
end;