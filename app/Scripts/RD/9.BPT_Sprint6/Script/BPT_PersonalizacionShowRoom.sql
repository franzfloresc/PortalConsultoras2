USE BelcorpBolivia
go

USE BelcorpChile_BPT
go

USE BelcorpColombia
go

USE BelcorpCostaRica
go

USE BelcorpDominicana
go

USE BelcorpEcuador
go

USE BelcorpGuatemala
go

USE BelcorpMexico_Plan20
go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenFondoContenedorOfertasShowRoomIntriga'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoContenedorOfertasShowRoomIntriga','Fondo del ShowRoom en el Contenedor Ofertas Intriga','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenFondoContenedorOfertasShowRoomVenta'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoContenedorOfertasShowRoomVenta','Fondo del ShowRoom en el Contenedor Ofertas Venta','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ImagenBannerContenedorOfertasIntriga'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ImagenBannerContenedorOfertasIntriga','Imagen del Banner del Contenedor Ofertas Intriga','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ImagenBannerContenedorOfertasVenta'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ImagenBannerContenedorOfertasVenta','Imagen del Banner del Contenedor Ofertas Venta','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

USE BelcorpPanama
go

USE BelcorpPeru_BPT
go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenFondoContenedorOfertasShowRoomIntriga'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoContenedorOfertasShowRoomIntriga','Fondo del ShowRoom en el Contenedor Ofertas Intriga','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenFondoContenedorOfertasShowRoomVenta'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoContenedorOfertasShowRoomVenta','IFondo del ShowRoom en el Contenedor Ofertas Venta','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ImagenBannerContenedorOfertasIntriga'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ImagenBannerContenedorOfertasIntriga','Imagen del Banner del Contenedor Ofertas Intriga','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ImagenBannerContenedorOfertasVenta'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ImagenBannerContenedorOfertasVenta','Imagen del Banner del Contenedor Ofertas Venta','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

USE BelcorpPuertoRico
go

USE BelcorpSalvador
go

USE BelcorpVenezuela
go