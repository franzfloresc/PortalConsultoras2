use BelcorpPeru_BPT;
go

begin
	declare @vCampaniaID int;

	set @vCampaniaID = 201816;

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
				Valor = 'PE_Desktop - IFondo del ShowRoom en el Contenedor Ofertas Venta_20181048470_01_oxlgzzufmj.jpg'
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
						(CampaniaID = @vCampaniaID)
				 )));
		end;

		/* Mobile 
		 */
		begin
			update 
				ShowRoom.PersonalizacionNivel
			set 
				Valor = 'PE_Mobile - Imagen del Banner del Contenedor Ofertas Venta_20181048139_01_fregxivrxk.jpg'
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
						(CampaniaID = @vCampaniaID)
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
				Valor = 'CL_PE_Desktop_Fondo_del_ShowRoom_en_el_Contenedor_Ofertas_Venta_2018826106_01_rpxuytnpsp_11_2018103694_01_yqzqneysuw.jpg'
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
				Valor = 'CL_imagendelbannerdelcontenedorofertasventa_2018108521_01_lcecrsrmmm.jpg'
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
				Valor = 'CR_opc1_20181020280_01_dwhzjjmqst.jpg'
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
				Valor = 'CR_imagendelbannerdelcontenedorofertasventa_20181014845_01_akrcahknzk.jpg'
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