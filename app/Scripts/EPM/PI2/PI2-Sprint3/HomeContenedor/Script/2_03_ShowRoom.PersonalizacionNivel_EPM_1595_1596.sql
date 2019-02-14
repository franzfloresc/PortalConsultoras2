use BelcorpBolivia;
go

begin
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
				Valor = 'Banner-SR-C18-Esika-desktop.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;

		/* Mobile 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'Banner-SR-C18-Esika-mobile.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;
	end;
end;

use BelcorpChile;
go

begin
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
				Valor = 'Banner-SR-C18-Esika-desktop.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;

		/* Mobile 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'Banner-SR-C18-Esika-mobile.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;
	end;
end;

use BelcorpColombia;
go

begin
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
				Valor = 'Banner-SR-C18-Esika-desktop.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;

		/* Mobile 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'Banner-SR-C18-Esika-mobile.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;
	end;
end;

use BelcorpCostaRica;
go

begin
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
				Valor = 'Banner-SR-C18-Lbel-desktop.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;

		/* Mobile 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'Banner-SR-C18-Lbel-mobile.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;
	end;
end;

use BelcorpDominicana;
go

begin
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
				Valor = 'Banner-SR-C18-Esika-desktop.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;

		/* Mobile 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'Banner-SR-C18-Esika-mobile.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;
	end;
end;

use BelcorpEcuador;
go

begin
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
				Valor = 'Banner-SR-C18-Esika-desktop.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;

		/* Mobile 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'Banner-SR-C18-Esika-mobile.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;
	end;
end;

use BelcorpGuatemala;
go

begin
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
				Valor = 'Banner-SR-C18-Esika-desktop.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;

		/* Mobile 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'Banner-SR-C18-Esika-mobile.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;
	end;
end;

use BelcorpMexico;
go

begin
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
				Valor = 'Banner-SR-C18-Lbel-desktop.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;

		/* Mobile 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'Banner-SR-C18-Lbel-mobile.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;
	end;
end;

use BelcorpPanama;
go

begin
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
				Valor = 'Banner-SR-C18-Lbel-desktop.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;

		/* Mobile 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'Banner-SR-C18-Lbel-mobile.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;
	end;
end;

use BelcorpPeru;
go

begin
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
				Valor = 'Banner-SR-C18-Esika-desktop.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;

		/* Mobile 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'Banner-SR-C18-Esika-mobile.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;
	end;
end;

use BelcorpPuertoRico;
go

begin
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
				Valor = 'Banner-SR-C18-Lbel-desktop.jpg'
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
						(CampaniaID in(201812,201813))
				 )));
		end;

		/* Mobile 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'Banner-SR-C18-Lbel-mobile.jpg'
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
						(CampaniaID in(201812,20183))
				 )));
		end;
	end;
end;

use BelcorpSalvador;
go

begin
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
				Valor = 'Banner-SR-C18-Esika-desktop.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;

		/* Mobile 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'Banner-SR-C18-Esika-mobile.jpg'
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
						(CampaniaID in(201817,201818))
				 )));
		end;
	end;
end;