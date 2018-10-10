USE BelcorpBolivia
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

USE BelcorpChile
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

USE BelcorpColombia
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

USE BelcorpCostaRica
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

USE BelcorpDominicana
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

USE BelcorpEcuador
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

USE BelcorpGuatemala
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

USE BelcorpMexico
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

USE BelcorpPeru
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

USE BelcorpSalvador
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

USE BelcorpVenezuela
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