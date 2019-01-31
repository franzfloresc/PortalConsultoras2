exec dbo.GetGrupoBannerByCampania @CampaniaID=201903
exec dbo.GetBannerByCampaniaBienvenida @CampaniaID=201903



Update Banner set TituloComentario = 'Comparte tu catálogo digital y gana más' where CampaniaID = 201903 and GrupoBannerID = 153 and BannerID in (5,6)
go

select * from dbo.Banner a
inner join GrupoBanner b on a.CampaniaID = b.CampaniaID and a.GrupoBannerID = b.GrupoBannerID  
 where a.CampaniaID = 201903 and a.GrupoBannerID = 153


 select * from RolPermiso where PermisoID = 1019

 UPdate RolPermiso set Mostrar = 0 where PermisoID = 1019