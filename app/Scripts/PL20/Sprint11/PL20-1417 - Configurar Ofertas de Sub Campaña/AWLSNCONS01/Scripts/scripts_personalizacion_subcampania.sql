USE BelcorpBolivia
GO
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoTituloOfertaSubCampania','Imagen Fondo Título Oferta SubCampaña (483px x 73px)','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoContenidoOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoContenidoOfertaSubCampania','Color Fondo Contenido Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoBotonVerMasOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoBotonVerMasOfertaSubCampania','Texto Ver Más Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

--Mobile==================================================================================
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go
USE BelcorpCostaRica
GO
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoTituloOfertaSubCampania','Imagen Fondo Título Oferta SubCampaña (483px x 73px)','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoContenidoOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoContenidoOfertaSubCampania','Color Fondo Contenido Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoBotonVerMasOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoBotonVerMasOfertaSubCampania','Texto Ver Más Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

--Mobile==================================================================================
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go
USE BelcorpChile
GO
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoTituloOfertaSubCampania','Imagen Fondo Título Oferta SubCampaña (483px x 73px)','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoContenidoOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoContenidoOfertaSubCampania','Color Fondo Contenido Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoBotonVerMasOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoBotonVerMasOfertaSubCampania','Texto Ver Más Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

--Mobile==================================================================================
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go
USE BelcorpColombia
GO
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoTituloOfertaSubCampania','Imagen Fondo Título Oferta SubCampaña (483px x 73px)','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoContenidoOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoContenidoOfertaSubCampania','Color Fondo Contenido Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoBotonVerMasOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoBotonVerMasOfertaSubCampania','Texto Ver Más Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

--Mobile==================================================================================
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go
USE BelcorpDominicana
GO
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoTituloOfertaSubCampania','Imagen Fondo Título Oferta SubCampaña (483px x 73px)','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoContenidoOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoContenidoOfertaSubCampania','Color Fondo Contenido Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoBotonVerMasOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoBotonVerMasOfertaSubCampania','Texto Ver Más Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

--Mobile==================================================================================
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go
USE BelcorpEcuador
GO
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoTituloOfertaSubCampania','Imagen Fondo Título Oferta SubCampaña (483px x 73px)','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoContenidoOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoContenidoOfertaSubCampania','Color Fondo Contenido Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoBotonVerMasOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoBotonVerMasOfertaSubCampania','Texto Ver Más Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

--Mobile==================================================================================
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go
USE BelcorpGuatemala
GO
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoTituloOfertaSubCampania','Imagen Fondo Título Oferta SubCampaña (483px x 73px)','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoContenidoOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoContenidoOfertaSubCampania','Color Fondo Contenido Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoBotonVerMasOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoBotonVerMasOfertaSubCampania','Texto Ver Más Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

--Mobile==================================================================================
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go
USE BelcorpMexico
GO
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoTituloOfertaSubCampania','Imagen Fondo Título Oferta SubCampaña (483px x 73px)','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoContenidoOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoContenidoOfertaSubCampania','Color Fondo Contenido Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoBotonVerMasOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoBotonVerMasOfertaSubCampania','Texto Ver Más Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

--Mobile==================================================================================
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go
USE BelcorpPanama
GO
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoTituloOfertaSubCampania','Imagen Fondo Título Oferta SubCampaña (483px x 73px)','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoContenidoOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoContenidoOfertaSubCampania','Color Fondo Contenido Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoBotonVerMasOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoBotonVerMasOfertaSubCampania','Texto Ver Más Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

--Mobile==================================================================================
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go
USE BelcorpPeru
GO
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoTituloOfertaSubCampania','Imagen Fondo Título Oferta SubCampaña (483px x 73px)','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoContenidoOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoContenidoOfertaSubCampania','Color Fondo Contenido Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoBotonVerMasOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoBotonVerMasOfertaSubCampania','Texto Ver Más Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

--Mobile==================================================================================
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go
USE BelcorpPuertoRico
GO
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoTituloOfertaSubCampania','Imagen Fondo Título Oferta SubCampaña (483px x 73px)','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoContenidoOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoContenidoOfertaSubCampania','Color Fondo Contenido Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoBotonVerMasOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoBotonVerMasOfertaSubCampania','Texto Ver Más Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

--Mobile==================================================================================
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go
USE BelcorpSalvador
GO
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoTituloOfertaSubCampania','Imagen Fondo Título Oferta SubCampaña (483px x 73px)','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoContenidoOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoContenidoOfertaSubCampania','Color Fondo Contenido Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoBotonVerMasOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoBotonVerMasOfertaSubCampania','Texto Ver Más Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

--Mobile==================================================================================
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go
USE BelcorpVenezuela
GO
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoTituloOfertaSubCampania','Imagen Fondo Título Oferta SubCampaña (483px x 73px)','IMAGEN','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ColorFondoContenidoOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondoContenidoOfertaSubCampania','Color Fondo Contenido Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='TextoBotonVerMasOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoBotonVerMasOfertaSubCampania','Texto Ver Más Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

--Mobile==================================================================================
if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoInicialOfertaSubCampania','Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoInicialOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoInicialOfertaSubCampania','Color Texto Inicial Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='TextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoTituloOfertaSubCampania','Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorTextoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorTextoTituloOfertaSubCampania','Color Texto Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ColorFondoTituloOfertaSubCampania'
	and TipoPersonalizacion = 'EVENTO')
begin

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondoTituloOfertaSubCampania','Color Fondo Título Oferta SubCampaña','TEXTO','EVENTO',
(select max(Orden)+1 from ShowRoom.Personalizacion),1)

end

go
