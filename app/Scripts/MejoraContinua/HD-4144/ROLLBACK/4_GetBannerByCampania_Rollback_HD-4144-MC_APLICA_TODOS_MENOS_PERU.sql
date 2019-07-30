
CREATE proc [dbo].[GetBannerByCampania]
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



