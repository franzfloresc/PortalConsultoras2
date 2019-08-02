USE BelcorpPeru
GO
ALTER proc [dbo].[GetBannerByCampania]
	@CampaniaID int
as
select ban.CampaniaID, ban.BannerID, ban.GrupoBannerID, ban.Orden,
	ban.Titulo, ban.Archivo,  REPLACE(ban.URL, '*', '&') URL, ban.FlagGrupoConsultora, ban.FlagConsultoraNueva,
	isnull(gban.TiempoRotacion,0) TiempoRotacion,
	Isnull(ban.TipoContenido,0) TipoContenido,
	Isnull(ban.TipoAccion,0) TipoAccion,
	Isnull(ban.PaginaNueva,1) PaginaNueva,
	ISNULL(ban.TituloComentario,'') TituloComentario,
	ISNULL(ban.TextoComentario,'') TextoComentario,
	ISNULL(ban.CUVpedido,'') CUVpedido,
	ISNULL(ban.CantCUVpedido,'') CantCUVpedido,
	(select Nombre from grupobannerbase gbbase where gbbase.GrupoBannerID = gban.GrupoBannerID) Nombre
from dbo.Banner ban with(nolock)
left join GrupoBanner gban with(nolock) on ban.CampaniaID = gban.CampaniaID and ban.GrupoBannerID = gban.GrupoBannerID
where ban.CampaniaID = @CampaniaID
order by ban.BannerID

select bp.BannerID, bp.PaisID, ISNULL(Segmento,-1) as Segmento, ISNULL(ConfiguracionZona,'') as ConfiguracionZona
from dbo.BannerPais bp with(nolock)
left join dbo.BannerPaisSegmentoZona bpsz with(nolock) on bp.CampaniaId = bpsz.CampaniaId and bp.BannerId = bpsz.BannerId and bp.PaisId = bpsz.PaisId
where bp.CampaniaID = @CampaniaID
order by bp.BannerID, bp.PaisID

GO

USE BelcorpMexico
GO

ALTER proc [dbo].[GetBannerByCampania]
	@CampaniaID int
as
select ban.CampaniaID, ban.BannerID, ban.GrupoBannerID, ban.Orden,
	ban.Titulo, ban.Archivo, ban.URL, ban.FlagGrupoConsultora, ban.FlagConsultoraNueva,
	isnull(gban.TiempoRotacion,0) TiempoRotacion,
	Isnull(ban.TipoContenido,0) TipoContenido,
	Isnull(ban.TipoAccion,0) TipoAccion,
	Isnull(ban.PaginaNueva,1) PaginaNueva,
	(select Nombre from grupobannerbase gbbase where gbbase.GrupoBannerID = gban.GrupoBannerID) Nombre
from dbo.Banner ban
left join GrupoBanner gban on ban.CampaniaID = gban.CampaniaID and ban.GrupoBannerID = gban.GrupoBannerID
where ban.CampaniaID = @CampaniaID
order by ban.BannerID

select BannerID, PaisID
from dbo.BannerPais
where CampaniaID = @CampaniaID
order by BannerID, PaisID

GO

USE BelcorpColombia
GO

ALTER proc [dbo].[GetBannerByCampania]
	@CampaniaID int
as
select ban.CampaniaID, ban.BannerID, ban.GrupoBannerID, ban.Orden,
	ban.Titulo, ban.Archivo, ban.URL, ban.FlagGrupoConsultora, ban.FlagConsultoraNueva,
	isnull(gban.TiempoRotacion,0) TiempoRotacion,
	Isnull(ban.TipoContenido,0) TipoContenido,
	Isnull(ban.TipoAccion,0) TipoAccion,
	Isnull(ban.PaginaNueva,1) PaginaNueva,
	(select Nombre from grupobannerbase gbbase where gbbase.GrupoBannerID = gban.GrupoBannerID) Nombre
from dbo.Banner ban
left join GrupoBanner gban on ban.CampaniaID = gban.CampaniaID and ban.GrupoBannerID = gban.GrupoBannerID
where ban.CampaniaID = @CampaniaID
order by ban.BannerID

select BannerID, PaisID
from dbo.BannerPais
where CampaniaID = @CampaniaID
order by BannerID, PaisID

GO

USE BelcorpSalvador
GO

ALTER proc [dbo].[GetBannerByCampania]
	@CampaniaID int
as
select ban.CampaniaID, ban.BannerID, ban.GrupoBannerID, ban.Orden,
	ban.Titulo, ban.Archivo, ban.URL, ban.FlagGrupoConsultora, ban.FlagConsultoraNueva,
	isnull(gban.TiempoRotacion,0) TiempoRotacion,
	Isnull(ban.TipoContenido,0) TipoContenido,
	Isnull(ban.TipoAccion,0) TipoAccion,
	Isnull(ban.PaginaNueva,1) PaginaNueva,
	(select Nombre from grupobannerbase gbbase where gbbase.GrupoBannerID = gban.GrupoBannerID) Nombre
from dbo.Banner ban
left join GrupoBanner gban on ban.CampaniaID = gban.CampaniaID and ban.GrupoBannerID = gban.GrupoBannerID
where ban.CampaniaID = @CampaniaID
order by ban.BannerID

select BannerID, PaisID
from dbo.BannerPais
where CampaniaID = @CampaniaID
order by BannerID, PaisID

GO

USE BelcorpPuertoRico
GO

ALTER proc [dbo].[GetBannerByCampania]
	@CampaniaID int
as
select ban.CampaniaID, ban.BannerID, ban.GrupoBannerID, ban.Orden,
	ban.Titulo, ban.Archivo, ban.URL, ban.FlagGrupoConsultora, ban.FlagConsultoraNueva,
	isnull(gban.TiempoRotacion,0) TiempoRotacion,
	Isnull(ban.TipoContenido,0) TipoContenido,
	Isnull(ban.TipoAccion,0) TipoAccion,
	Isnull(ban.PaginaNueva,1) PaginaNueva,
	(select Nombre from grupobannerbase gbbase where gbbase.GrupoBannerID = gban.GrupoBannerID) Nombre
from dbo.Banner ban
left join GrupoBanner gban on ban.CampaniaID = gban.CampaniaID and ban.GrupoBannerID = gban.GrupoBannerID
where ban.CampaniaID = @CampaniaID
order by ban.BannerID

select BannerID, PaisID
from dbo.BannerPais
where CampaniaID = @CampaniaID
order by BannerID, PaisID

GO

USE BelcorpPanama
GO

ALTER proc [dbo].[GetBannerByCampania]
	@CampaniaID int
as
select ban.CampaniaID, ban.BannerID, ban.GrupoBannerID, ban.Orden,
	ban.Titulo, ban.Archivo, ban.URL, ban.FlagGrupoConsultora, ban.FlagConsultoraNueva,
	isnull(gban.TiempoRotacion,0) TiempoRotacion,
	Isnull(ban.TipoContenido,0) TipoContenido,
	Isnull(ban.TipoAccion,0) TipoAccion,
	Isnull(ban.PaginaNueva,1) PaginaNueva,
	(select Nombre from grupobannerbase gbbase where gbbase.GrupoBannerID = gban.GrupoBannerID) Nombre
from dbo.Banner ban
left join GrupoBanner gban on ban.CampaniaID = gban.CampaniaID and ban.GrupoBannerID = gban.GrupoBannerID
where ban.CampaniaID = @CampaniaID
order by ban.BannerID

select BannerID, PaisID
from dbo.BannerPais
where CampaniaID = @CampaniaID
order by BannerID, PaisID

GO

USE BelcorpGuatemala
GO

ALTER proc [dbo].[GetBannerByCampania]
	@CampaniaID int
as
select ban.CampaniaID, ban.BannerID, ban.GrupoBannerID, ban.Orden,
	ban.Titulo, ban.Archivo, ban.URL, ban.FlagGrupoConsultora, ban.FlagConsultoraNueva,
	isnull(gban.TiempoRotacion,0) TiempoRotacion,
	Isnull(ban.TipoContenido,0) TipoContenido,
	Isnull(ban.TipoAccion,0) TipoAccion,
	Isnull(ban.PaginaNueva,1) PaginaNueva,
	(select Nombre from grupobannerbase gbbase where gbbase.GrupoBannerID = gban.GrupoBannerID) Nombre
from dbo.Banner ban
left join GrupoBanner gban on ban.CampaniaID = gban.CampaniaID and ban.GrupoBannerID = gban.GrupoBannerID
where ban.CampaniaID = @CampaniaID
order by ban.BannerID

select BannerID, PaisID
from dbo.BannerPais
where CampaniaID = @CampaniaID
order by BannerID, PaisID

GO

USE BelcorpEcuador
GO

ALTER proc [dbo].[GetBannerByCampania]
	@CampaniaID int
as
select ban.CampaniaID, ban.BannerID, ban.GrupoBannerID, ban.Orden,
	ban.Titulo, ban.Archivo, ban.URL, ban.FlagGrupoConsultora, ban.FlagConsultoraNueva,
	isnull(gban.TiempoRotacion,0) TiempoRotacion,
	Isnull(ban.TipoContenido,0) TipoContenido,
	Isnull(ban.TipoAccion,0) TipoAccion,
	Isnull(ban.PaginaNueva,1) PaginaNueva,
	(select Nombre from grupobannerbase gbbase where gbbase.GrupoBannerID = gban.GrupoBannerID) Nombre
from dbo.Banner ban
left join GrupoBanner gban on ban.CampaniaID = gban.CampaniaID and ban.GrupoBannerID = gban.GrupoBannerID
where ban.CampaniaID = @CampaniaID
order by ban.BannerID

select BannerID, PaisID
from dbo.BannerPais
where CampaniaID = @CampaniaID
order by BannerID, PaisID

GO

USE BelcorpDominicana
GO

ALTER proc [dbo].[GetBannerByCampania]
	@CampaniaID int
as
select ban.CampaniaID, ban.BannerID, ban.GrupoBannerID, ban.Orden,
	ban.Titulo, ban.Archivo, ban.URL, ban.FlagGrupoConsultora, ban.FlagConsultoraNueva,
	isnull(gban.TiempoRotacion,0) TiempoRotacion,
	Isnull(ban.TipoContenido,0) TipoContenido,
	Isnull(ban.TipoAccion,0) TipoAccion,
	Isnull(ban.PaginaNueva,1) PaginaNueva,
	(select Nombre from grupobannerbase gbbase where gbbase.GrupoBannerID = gban.GrupoBannerID) Nombre
from dbo.Banner ban
left join GrupoBanner gban on ban.CampaniaID = gban.CampaniaID and ban.GrupoBannerID = gban.GrupoBannerID
where ban.CampaniaID = @CampaniaID
order by ban.BannerID

select BannerID, PaisID
from dbo.BannerPais
where CampaniaID = @CampaniaID
order by BannerID, PaisID

GO

USE BelcorpCostaRica
GO

ALTER proc [dbo].[GetBannerByCampania]
	@CampaniaID int
as
select ban.CampaniaID, ban.BannerID, ban.GrupoBannerID, ban.Orden,
	ban.Titulo, ban.Archivo, ban.URL, ban.FlagGrupoConsultora, ban.FlagConsultoraNueva,
	isnull(gban.TiempoRotacion,0) TiempoRotacion,
	Isnull(ban.TipoContenido,0) TipoContenido,
	Isnull(ban.TipoAccion,0) TipoAccion,
	Isnull(ban.PaginaNueva,1) PaginaNueva,
	(select Nombre from grupobannerbase gbbase where gbbase.GrupoBannerID = gban.GrupoBannerID) Nombre
from dbo.Banner ban
left join GrupoBanner gban on ban.CampaniaID = gban.CampaniaID and ban.GrupoBannerID = gban.GrupoBannerID
where ban.CampaniaID = @CampaniaID
order by ban.BannerID

select BannerID, PaisID
from dbo.BannerPais
where CampaniaID = @CampaniaID
order by BannerID, PaisID

GO

USE BelcorpChile
GO

ALTER proc [dbo].[GetBannerByCampania]
	@CampaniaID int
as
select ban.CampaniaID, ban.BannerID, ban.GrupoBannerID, ban.Orden,
	ban.Titulo, ban.Archivo, ban.URL, ban.FlagGrupoConsultora, ban.FlagConsultoraNueva,
	isnull(gban.TiempoRotacion,0) TiempoRotacion,
	Isnull(ban.TipoContenido,0) TipoContenido,
	Isnull(ban.TipoAccion,0) TipoAccion,
	Isnull(ban.PaginaNueva,1) PaginaNueva,
	(select Nombre from grupobannerbase gbbase where gbbase.GrupoBannerID = gban.GrupoBannerID) Nombre
from dbo.Banner ban
left join GrupoBanner gban on ban.CampaniaID = gban.CampaniaID and ban.GrupoBannerID = gban.GrupoBannerID
where ban.CampaniaID = @CampaniaID
order by ban.BannerID

select BannerID, PaisID
from dbo.BannerPais
where CampaniaID = @CampaniaID
order by BannerID, PaisID

GO

USE BelcorpBolivia
GO

ALTER proc [dbo].[GetBannerByCampania]
	@CampaniaID int
as
select ban.CampaniaID, ban.BannerID, ban.GrupoBannerID, ban.Orden,
	ban.Titulo, ban.Archivo, ban.URL, ban.FlagGrupoConsultora, ban.FlagConsultoraNueva,
	isnull(gban.TiempoRotacion,0) TiempoRotacion,
	Isnull(ban.TipoContenido,0) TipoContenido,
	Isnull(ban.TipoAccion,0) TipoAccion,
	Isnull(ban.PaginaNueva,1) PaginaNueva,
	(select Nombre from grupobannerbase gbbase where gbbase.GrupoBannerID = gban.GrupoBannerID) Nombre
from dbo.Banner ban
left join GrupoBanner gban on ban.CampaniaID = gban.CampaniaID and ban.GrupoBannerID = gban.GrupoBannerID
where ban.CampaniaID = @CampaniaID
order by ban.BannerID

select BannerID, PaisID
from dbo.BannerPais
where CampaniaID = @CampaniaID
order by BannerID, PaisID

GO

