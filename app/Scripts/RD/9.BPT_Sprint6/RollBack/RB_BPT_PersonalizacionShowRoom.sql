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

USE BelcorpMexico
go

USE BelcorpPanama
go

USE BelcorpPeru_BPT
go

if exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenBannerContenedorOfertasIntriga'
	and TipoPersonalizacion = 'EVENTO')
begin
	delete from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenBannerContenedorOfertasIntriga'
	and TipoPersonalizacion = 'EVENTO'
end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenBannerContenedorOfertasVenta'
	and TipoPersonalizacion = 'EVENTO')
begin
	delete from ShowRoom.Personalizacion where TipoAplicacion = 'Desktop' and Atributo='ImagenBannerContenedorOfertasVenta'
	and TipoPersonalizacion = 'EVENTO'
end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ImagenBannerContenedorOfertasIntriga'
	and TipoPersonalizacion = 'EVENTO')
begin
	delete from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ImagenBannerContenedorOfertasIntriga'
	and TipoPersonalizacion = 'EVENTO'
end

go

if not exists (select 1 from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ImagenBannerContenedorOfertasVenta'
	and TipoPersonalizacion = 'EVENTO')
begin
	delete from ShowRoom.Personalizacion where TipoAplicacion = 'Mobile' and Atributo='ImagenBannerContenedorOfertasVenta'
	and TipoPersonalizacion = 'EVENTO'
end

go

USE BelcorpPuertoRico
go

USE BelcorpSalvador
go

USE BelcorpVenezuela
go