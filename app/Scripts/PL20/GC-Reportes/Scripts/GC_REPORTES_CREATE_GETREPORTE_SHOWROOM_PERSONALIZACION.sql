USE BelcorpBolivia
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomPersonalizacion]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomPersonalizacion]  201710
BEGIN

SELECT *
from (
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido	   
  from BelcorpBolivia.ShowRoom.Personalizacion p
 inner join BelcorpBolivia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpBolivia.ShowRoom.Evento e
                    inner join BelcorpBolivia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
      (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
      
  from BelcorpChile.ShowRoom.Personalizacion p
 inner join BelcorpChile.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpChile.ShowRoom.Evento e
                    inner join BelcorpChile.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpColombia.ShowRoom.Personalizacion p
 inner join BelcorpColombia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpColombia.ShowRoom.Evento e
                    inner join BelcorpColombia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpCostaRica.ShowRoom.Personalizacion p
 inner join BelcorpCostaRica.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpCostaRica.ShowRoom.Evento e
                    inner join BelcorpCostaRica.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpDominicana.ShowRoom.Personalizacion p
 inner join BelcorpDominicana.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpDominicana.ShowRoom.Evento e
                    inner join BelcorpDominicana.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpEcuador.ShowRoom.Personalizacion p
 inner join BelcorpEcuador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpEcuador.ShowRoom.Evento e
                    inner join BelcorpEcuador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpGuatemala.ShowRoom.Personalizacion p
 inner join BelcorpGuatemala.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpGuatemala.ShowRoom.Evento e
                    inner join BelcorpGuatemala.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpMexico.ShowRoom.Personalizacion p
 inner join BelcorpMexico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpMexico.ShowRoom.Evento e
                    inner join BelcorpMexico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPanama.ShowRoom.Personalizacion p
 inner join BelcorpPanama.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPanama.ShowRoom.Evento e
                    inner join BelcorpPanama.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPeru.ShowRoom.Personalizacion p
 inner join BelcorpPeru.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPeru.ShowRoom.Evento e
                    inner join BelcorpPeru.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPuertoRico.ShowRoom.Personalizacion p
 inner join BelcorpPuertoRico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPuertoRico.ShowRoom.Evento e
                    inner join BelcorpPuertoRico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpSalvador.ShowRoom.Personalizacion p
 inner join BelcorpSalvador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpSalvador.ShowRoom.Evento e
                    inner join BelcorpSalvador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpVenezuela.ShowRoom.Personalizacion p
 inner join BelcorpVenezuela.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpVenezuela.ShowRoom.Evento e
                    inner join BelcorpVenezuela.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
 ) t 
 pivot
 (
	max(FlagContenido) 
	FOR Pais in ([BO], [CL], [CO], [CR], [DO], [EC], [GT], [MX], [PA], [PE], [PR], [SV], [VE])
 ) p

END
GO

USE BelcorpChile
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomPersonalizacion]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomPersonalizacion]  201708
BEGIN

SELECT *
from (
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
	   
  from BelcorpBolivia.ShowRoom.Personalizacion p
 inner join BelcorpBolivia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpBolivia.ShowRoom.Evento e
                    inner join BelcorpBolivia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
      (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
      
  from BelcorpChile.ShowRoom.Personalizacion p
 inner join BelcorpChile.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpChile.ShowRoom.Evento e
                    inner join BelcorpChile.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpColombia.ShowRoom.Personalizacion p
 inner join BelcorpColombia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpColombia.ShowRoom.Evento e
                    inner join BelcorpColombia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpCostaRica.ShowRoom.Personalizacion p
 inner join BelcorpCostaRica.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpCostaRica.ShowRoom.Evento e
                    inner join BelcorpCostaRica.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpDominicana.ShowRoom.Personalizacion p
 inner join BelcorpDominicana.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpDominicana.ShowRoom.Evento e
                    inner join BelcorpDominicana.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpEcuador.ShowRoom.Personalizacion p
 inner join BelcorpEcuador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpEcuador.ShowRoom.Evento e
                    inner join BelcorpEcuador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpGuatemala.ShowRoom.Personalizacion p
 inner join BelcorpGuatemala.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpGuatemala.ShowRoom.Evento e
                    inner join BelcorpGuatemala.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpMexico.ShowRoom.Personalizacion p
 inner join BelcorpMexico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpMexico.ShowRoom.Evento e
                    inner join BelcorpMexico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPanama.ShowRoom.Personalizacion p
 inner join BelcorpPanama.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPanama.ShowRoom.Evento e
                    inner join BelcorpPanama.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPeru.ShowRoom.Personalizacion p
 inner join BelcorpPeru.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPeru.ShowRoom.Evento e
                    inner join BelcorpPeru.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPuertoRico.ShowRoom.Personalizacion p
 inner join BelcorpPuertoRico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPuertoRico.ShowRoom.Evento e
                    inner join BelcorpPuertoRico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpSalvador.ShowRoom.Personalizacion p
 inner join BelcorpSalvador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpSalvador.ShowRoom.Evento e
                    inner join BelcorpSalvador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpVenezuela.ShowRoom.Personalizacion p
 inner join BelcorpVenezuela.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpVenezuela.ShowRoom.Evento e
                    inner join BelcorpVenezuela.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
 ) t 
 pivot
 (
	max(FlagContenido) 
	FOR Pais in ([BO], [CL], [CO], [CR], [DO], [EC], [GT], [MX], [PA], [PE], [PR], [SV], [VE])
 ) p

END
GO

USE BelcorpColombia
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomPersonalizacion]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomPersonalizacion]  201708
BEGIN

SELECT *
from (
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
	   
  from BelcorpBolivia.ShowRoom.Personalizacion p
 inner join BelcorpBolivia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpBolivia.ShowRoom.Evento e
                    inner join BelcorpBolivia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
      (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
      
  from BelcorpChile.ShowRoom.Personalizacion p
 inner join BelcorpChile.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpChile.ShowRoom.Evento e
                    inner join BelcorpChile.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpColombia.ShowRoom.Personalizacion p
 inner join BelcorpColombia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpColombia.ShowRoom.Evento e
                    inner join BelcorpColombia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpCostaRica.ShowRoom.Personalizacion p
 inner join BelcorpCostaRica.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpCostaRica.ShowRoom.Evento e
                    inner join BelcorpCostaRica.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpDominicana.ShowRoom.Personalizacion p
 inner join BelcorpDominicana.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpDominicana.ShowRoom.Evento e
                    inner join BelcorpDominicana.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpEcuador.ShowRoom.Personalizacion p
 inner join BelcorpEcuador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpEcuador.ShowRoom.Evento e
                    inner join BelcorpEcuador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpGuatemala.ShowRoom.Personalizacion p
 inner join BelcorpGuatemala.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpGuatemala.ShowRoom.Evento e
                    inner join BelcorpGuatemala.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpMexico.ShowRoom.Personalizacion p
 inner join BelcorpMexico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpMexico.ShowRoom.Evento e
                    inner join BelcorpMexico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPanama.ShowRoom.Personalizacion p
 inner join BelcorpPanama.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPanama.ShowRoom.Evento e
                    inner join BelcorpPanama.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPeru.ShowRoom.Personalizacion p
 inner join BelcorpPeru.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPeru.ShowRoom.Evento e
                    inner join BelcorpPeru.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPuertoRico.ShowRoom.Personalizacion p
 inner join BelcorpPuertoRico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPuertoRico.ShowRoom.Evento e
                    inner join BelcorpPuertoRico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpSalvador.ShowRoom.Personalizacion p
 inner join BelcorpSalvador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpSalvador.ShowRoom.Evento e
                    inner join BelcorpSalvador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpVenezuela.ShowRoom.Personalizacion p
 inner join BelcorpVenezuela.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpVenezuela.ShowRoom.Evento e
                    inner join BelcorpVenezuela.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
 ) t 
 pivot
 (
	max(FlagContenido) 
	FOR Pais in ([BO], [CL], [CO], [CR], [DO], [EC], [GT], [MX], [PA], [PE], [PR], [SV], [VE])
 ) p

END
GO

USE BelcorpCostaRica
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomPersonalizacion]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomPersonalizacion]  201708
BEGIN

SELECT *
from (
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
	   
  from BelcorpBolivia.ShowRoom.Personalizacion p
 inner join BelcorpBolivia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpBolivia.ShowRoom.Evento e
                    inner join BelcorpBolivia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
      (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
      
  from BelcorpChile.ShowRoom.Personalizacion p
 inner join BelcorpChile.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpChile.ShowRoom.Evento e
                    inner join BelcorpChile.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpColombia.ShowRoom.Personalizacion p
 inner join BelcorpColombia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpColombia.ShowRoom.Evento e
                    inner join BelcorpColombia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpCostaRica.ShowRoom.Personalizacion p
 inner join BelcorpCostaRica.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpCostaRica.ShowRoom.Evento e
                    inner join BelcorpCostaRica.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpDominicana.ShowRoom.Personalizacion p
 inner join BelcorpDominicana.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpDominicana.ShowRoom.Evento e
                    inner join BelcorpDominicana.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpEcuador.ShowRoom.Personalizacion p
 inner join BelcorpEcuador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpEcuador.ShowRoom.Evento e
                    inner join BelcorpEcuador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpGuatemala.ShowRoom.Personalizacion p
 inner join BelcorpGuatemala.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpGuatemala.ShowRoom.Evento e
                    inner join BelcorpGuatemala.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpMexico.ShowRoom.Personalizacion p
 inner join BelcorpMexico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpMexico.ShowRoom.Evento e
                    inner join BelcorpMexico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPanama.ShowRoom.Personalizacion p
 inner join BelcorpPanama.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPanama.ShowRoom.Evento e
                    inner join BelcorpPanama.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPeru.ShowRoom.Personalizacion p
 inner join BelcorpPeru.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPeru.ShowRoom.Evento e
                    inner join BelcorpPeru.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPuertoRico.ShowRoom.Personalizacion p
 inner join BelcorpPuertoRico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPuertoRico.ShowRoom.Evento e
                    inner join BelcorpPuertoRico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpSalvador.ShowRoom.Personalizacion p
 inner join BelcorpSalvador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpSalvador.ShowRoom.Evento e
                    inner join BelcorpSalvador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpVenezuela.ShowRoom.Personalizacion p
 inner join BelcorpVenezuela.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpVenezuela.ShowRoom.Evento e
                    inner join BelcorpVenezuela.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
 ) t 
 pivot
 (
	max(FlagContenido) 
	FOR Pais in ([BO], [CL], [CO], [CR], [DO], [EC], [GT], [MX], [PA], [PE], [PR], [SV], [VE])
 ) p

END
GO

USE BelcorpDominicana
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomPersonalizacion]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomPersonalizacion]  201708
BEGIN

SELECT *
from (
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
	   
  from BelcorpBolivia.ShowRoom.Personalizacion p
 inner join BelcorpBolivia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpBolivia.ShowRoom.Evento e
                    inner join BelcorpBolivia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
      (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
      
  from BelcorpChile.ShowRoom.Personalizacion p
 inner join BelcorpChile.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpChile.ShowRoom.Evento e
                    inner join BelcorpChile.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpColombia.ShowRoom.Personalizacion p
 inner join BelcorpColombia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpColombia.ShowRoom.Evento e
                    inner join BelcorpColombia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpCostaRica.ShowRoom.Personalizacion p
 inner join BelcorpCostaRica.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpCostaRica.ShowRoom.Evento e
                    inner join BelcorpCostaRica.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpDominicana.ShowRoom.Personalizacion p
 inner join BelcorpDominicana.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpDominicana.ShowRoom.Evento e
                    inner join BelcorpDominicana.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpEcuador.ShowRoom.Personalizacion p
 inner join BelcorpEcuador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpEcuador.ShowRoom.Evento e
                    inner join BelcorpEcuador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpGuatemala.ShowRoom.Personalizacion p
 inner join BelcorpGuatemala.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpGuatemala.ShowRoom.Evento e
                    inner join BelcorpGuatemala.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpMexico.ShowRoom.Personalizacion p
 inner join BelcorpMexico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpMexico.ShowRoom.Evento e
                    inner join BelcorpMexico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPanama.ShowRoom.Personalizacion p
 inner join BelcorpPanama.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPanama.ShowRoom.Evento e
                    inner join BelcorpPanama.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPeru.ShowRoom.Personalizacion p
 inner join BelcorpPeru.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPeru.ShowRoom.Evento e
                    inner join BelcorpPeru.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPuertoRico.ShowRoom.Personalizacion p
 inner join BelcorpPuertoRico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPuertoRico.ShowRoom.Evento e
                    inner join BelcorpPuertoRico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpSalvador.ShowRoom.Personalizacion p
 inner join BelcorpSalvador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpSalvador.ShowRoom.Evento e
                    inner join BelcorpSalvador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpVenezuela.ShowRoom.Personalizacion p
 inner join BelcorpVenezuela.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpVenezuela.ShowRoom.Evento e
                    inner join BelcorpVenezuela.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
 ) t 
 pivot
 (
	max(FlagContenido) 
	FOR Pais in ([BO], [CL], [CO], [CR], [DO], [EC], [GT], [MX], [PA], [PE], [PR], [SV], [VE])
 ) p

END
GO

USE BelcorpEcuador
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomPersonalizacion]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomPersonalizacion]  201708
BEGIN

SELECT *
from (
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
	   
  from BelcorpBolivia.ShowRoom.Personalizacion p
 inner join BelcorpBolivia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpBolivia.ShowRoom.Evento e
                    inner join BelcorpBolivia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
      (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
      
  from BelcorpChile.ShowRoom.Personalizacion p
 inner join BelcorpChile.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpChile.ShowRoom.Evento e
                    inner join BelcorpChile.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpColombia.ShowRoom.Personalizacion p
 inner join BelcorpColombia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpColombia.ShowRoom.Evento e
                    inner join BelcorpColombia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpCostaRica.ShowRoom.Personalizacion p
 inner join BelcorpCostaRica.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpCostaRica.ShowRoom.Evento e
                    inner join BelcorpCostaRica.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpDominicana.ShowRoom.Personalizacion p
 inner join BelcorpDominicana.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpDominicana.ShowRoom.Evento e
                    inner join BelcorpDominicana.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpEcuador.ShowRoom.Personalizacion p
 inner join BelcorpEcuador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpEcuador.ShowRoom.Evento e
                    inner join BelcorpEcuador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpGuatemala.ShowRoom.Personalizacion p
 inner join BelcorpGuatemala.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpGuatemala.ShowRoom.Evento e
                    inner join BelcorpGuatemala.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpMexico.ShowRoom.Personalizacion p
 inner join BelcorpMexico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpMexico.ShowRoom.Evento e
                    inner join BelcorpMexico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPanama.ShowRoom.Personalizacion p
 inner join BelcorpPanama.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPanama.ShowRoom.Evento e
                    inner join BelcorpPanama.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPeru.ShowRoom.Personalizacion p
 inner join BelcorpPeru.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPeru.ShowRoom.Evento e
                    inner join BelcorpPeru.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPuertoRico.ShowRoom.Personalizacion p
 inner join BelcorpPuertoRico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPuertoRico.ShowRoom.Evento e
                    inner join BelcorpPuertoRico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpSalvador.ShowRoom.Personalizacion p
 inner join BelcorpSalvador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpSalvador.ShowRoom.Evento e
                    inner join BelcorpSalvador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpVenezuela.ShowRoom.Personalizacion p
 inner join BelcorpVenezuela.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpVenezuela.ShowRoom.Evento e
                    inner join BelcorpVenezuela.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
 ) t 
 pivot
 (
	max(FlagContenido) 
	FOR Pais in ([BO], [CL], [CO], [CR], [DO], [EC], [GT], [MX], [PA], [PE], [PR], [SV], [VE])
 ) p

END
GO

USE BelcorpGuatemala
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomPersonalizacion]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomPersonalizacion]  201708
BEGIN

SELECT *
from (
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
	   
  from BelcorpBolivia.ShowRoom.Personalizacion p
 inner join BelcorpBolivia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpBolivia.ShowRoom.Evento e
                    inner join BelcorpBolivia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
      (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
      
  from BelcorpChile.ShowRoom.Personalizacion p
 inner join BelcorpChile.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpChile.ShowRoom.Evento e
                    inner join BelcorpChile.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpColombia.ShowRoom.Personalizacion p
 inner join BelcorpColombia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpColombia.ShowRoom.Evento e
                    inner join BelcorpColombia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpCostaRica.ShowRoom.Personalizacion p
 inner join BelcorpCostaRica.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpCostaRica.ShowRoom.Evento e
                    inner join BelcorpCostaRica.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpDominicana.ShowRoom.Personalizacion p
 inner join BelcorpDominicana.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpDominicana.ShowRoom.Evento e
                    inner join BelcorpDominicana.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpEcuador.ShowRoom.Personalizacion p
 inner join BelcorpEcuador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpEcuador.ShowRoom.Evento e
                    inner join BelcorpEcuador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpGuatemala.ShowRoom.Personalizacion p
 inner join BelcorpGuatemala.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpGuatemala.ShowRoom.Evento e
                    inner join BelcorpGuatemala.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpMexico.ShowRoom.Personalizacion p
 inner join BelcorpMexico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpMexico.ShowRoom.Evento e
                    inner join BelcorpMexico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPanama.ShowRoom.Personalizacion p
 inner join BelcorpPanama.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPanama.ShowRoom.Evento e
                    inner join BelcorpPanama.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPeru.ShowRoom.Personalizacion p
 inner join BelcorpPeru.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPeru.ShowRoom.Evento e
                    inner join BelcorpPeru.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPuertoRico.ShowRoom.Personalizacion p
 inner join BelcorpPuertoRico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPuertoRico.ShowRoom.Evento e
                    inner join BelcorpPuertoRico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpSalvador.ShowRoom.Personalizacion p
 inner join BelcorpSalvador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpSalvador.ShowRoom.Evento e
                    inner join BelcorpSalvador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpVenezuela.ShowRoom.Personalizacion p
 inner join BelcorpVenezuela.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpVenezuela.ShowRoom.Evento e
                    inner join BelcorpVenezuela.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
 ) t 
 pivot
 (
	max(FlagContenido) 
	FOR Pais in ([BO], [CL], [CO], [CR], [DO], [EC], [GT], [MX], [PA], [PE], [PR], [SV], [VE])
 ) p

END
GO

USE BelcorpMexico
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomPersonalizacion]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomPersonalizacion]  201708
BEGIN

SELECT *
from (
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
	   
  from BelcorpBolivia.ShowRoom.Personalizacion p
 inner join BelcorpBolivia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpBolivia.ShowRoom.Evento e
                    inner join BelcorpBolivia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
      (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
      
  from BelcorpChile.ShowRoom.Personalizacion p
 inner join BelcorpChile.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpChile.ShowRoom.Evento e
                    inner join BelcorpChile.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpColombia.ShowRoom.Personalizacion p
 inner join BelcorpColombia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpColombia.ShowRoom.Evento e
                    inner join BelcorpColombia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpCostaRica.ShowRoom.Personalizacion p
 inner join BelcorpCostaRica.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpCostaRica.ShowRoom.Evento e
                    inner join BelcorpCostaRica.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpDominicana.ShowRoom.Personalizacion p
 inner join BelcorpDominicana.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpDominicana.ShowRoom.Evento e
                    inner join BelcorpDominicana.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpEcuador.ShowRoom.Personalizacion p
 inner join BelcorpEcuador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpEcuador.ShowRoom.Evento e
                    inner join BelcorpEcuador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpGuatemala.ShowRoom.Personalizacion p
 inner join BelcorpGuatemala.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpGuatemala.ShowRoom.Evento e
                    inner join BelcorpGuatemala.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpMexico.ShowRoom.Personalizacion p
 inner join BelcorpMexico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpMexico.ShowRoom.Evento e
                    inner join BelcorpMexico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPanama.ShowRoom.Personalizacion p
 inner join BelcorpPanama.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPanama.ShowRoom.Evento e
                    inner join BelcorpPanama.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPeru.ShowRoom.Personalizacion p
 inner join BelcorpPeru.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPeru.ShowRoom.Evento e
                    inner join BelcorpPeru.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPuertoRico.ShowRoom.Personalizacion p
 inner join BelcorpPuertoRico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPuertoRico.ShowRoom.Evento e
                    inner join BelcorpPuertoRico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpSalvador.ShowRoom.Personalizacion p
 inner join BelcorpSalvador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpSalvador.ShowRoom.Evento e
                    inner join BelcorpSalvador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpVenezuela.ShowRoom.Personalizacion p
 inner join BelcorpVenezuela.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpVenezuela.ShowRoom.Evento e
                    inner join BelcorpVenezuela.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
 ) t 
 pivot
 (
	max(FlagContenido) 
	FOR Pais in ([BO], [CL], [CO], [CR], [DO], [EC], [GT], [MX], [PA], [PE], [PR], [SV], [VE])
 ) p

END
GO

USE BelcorpPanama
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomPersonalizacion]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomPersonalizacion]  201708
BEGIN

SELECT *
from (
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
	   
  from BelcorpBolivia.ShowRoom.Personalizacion p
 inner join BelcorpBolivia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpBolivia.ShowRoom.Evento e
                    inner join BelcorpBolivia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
      (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
      
  from BelcorpChile.ShowRoom.Personalizacion p
 inner join BelcorpChile.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpChile.ShowRoom.Evento e
                    inner join BelcorpChile.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpColombia.ShowRoom.Personalizacion p
 inner join BelcorpColombia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpColombia.ShowRoom.Evento e
                    inner join BelcorpColombia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpCostaRica.ShowRoom.Personalizacion p
 inner join BelcorpCostaRica.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpCostaRica.ShowRoom.Evento e
                    inner join BelcorpCostaRica.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpDominicana.ShowRoom.Personalizacion p
 inner join BelcorpDominicana.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpDominicana.ShowRoom.Evento e
                    inner join BelcorpDominicana.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpEcuador.ShowRoom.Personalizacion p
 inner join BelcorpEcuador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpEcuador.ShowRoom.Evento e
                    inner join BelcorpEcuador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpGuatemala.ShowRoom.Personalizacion p
 inner join BelcorpGuatemala.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpGuatemala.ShowRoom.Evento e
                    inner join BelcorpGuatemala.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpMexico.ShowRoom.Personalizacion p
 inner join BelcorpMexico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpMexico.ShowRoom.Evento e
                    inner join BelcorpMexico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPanama.ShowRoom.Personalizacion p
 inner join BelcorpPanama.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPanama.ShowRoom.Evento e
                    inner join BelcorpPanama.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPeru.ShowRoom.Personalizacion p
 inner join BelcorpPeru.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPeru.ShowRoom.Evento e
                    inner join BelcorpPeru.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPuertoRico.ShowRoom.Personalizacion p
 inner join BelcorpPuertoRico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPuertoRico.ShowRoom.Evento e
                    inner join BelcorpPuertoRico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpSalvador.ShowRoom.Personalizacion p
 inner join BelcorpSalvador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpSalvador.ShowRoom.Evento e
                    inner join BelcorpSalvador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpVenezuela.ShowRoom.Personalizacion p
 inner join BelcorpVenezuela.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpVenezuela.ShowRoom.Evento e
                    inner join BelcorpVenezuela.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
 ) t 
 pivot
 (
	max(FlagContenido) 
	FOR Pais in ([BO], [CL], [CO], [CR], [DO], [EC], [GT], [MX], [PA], [PE], [PR], [SV], [VE])
 ) p

END
GO

USE BelcorpPeru
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomPersonalizacion]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomPersonalizacion]  201708
BEGIN

SELECT *
from (
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
	   
  from BelcorpBolivia.ShowRoom.Personalizacion p
 inner join BelcorpBolivia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpBolivia.ShowRoom.Evento e
                    inner join BelcorpBolivia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
      (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
      
  from BelcorpChile.ShowRoom.Personalizacion p
 inner join BelcorpChile.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpChile.ShowRoom.Evento e
                    inner join BelcorpChile.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpColombia.ShowRoom.Personalizacion p
 inner join BelcorpColombia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpColombia.ShowRoom.Evento e
                    inner join BelcorpColombia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpCostaRica.ShowRoom.Personalizacion p
 inner join BelcorpCostaRica.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpCostaRica.ShowRoom.Evento e
                    inner join BelcorpCostaRica.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpDominicana.ShowRoom.Personalizacion p
 inner join BelcorpDominicana.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpDominicana.ShowRoom.Evento e
                    inner join BelcorpDominicana.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpEcuador.ShowRoom.Personalizacion p
 inner join BelcorpEcuador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpEcuador.ShowRoom.Evento e
                    inner join BelcorpEcuador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpGuatemala.ShowRoom.Personalizacion p
 inner join BelcorpGuatemala.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpGuatemala.ShowRoom.Evento e
                    inner join BelcorpGuatemala.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpMexico.ShowRoom.Personalizacion p
 inner join BelcorpMexico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpMexico.ShowRoom.Evento e
                    inner join BelcorpMexico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPanama.ShowRoom.Personalizacion p
 inner join BelcorpPanama.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPanama.ShowRoom.Evento e
                    inner join BelcorpPanama.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPeru.ShowRoom.Personalizacion p
 inner join BelcorpPeru.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPeru.ShowRoom.Evento e
                    inner join BelcorpPeru.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPuertoRico.ShowRoom.Personalizacion p
 inner join BelcorpPuertoRico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPuertoRico.ShowRoom.Evento e
                    inner join BelcorpPuertoRico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpSalvador.ShowRoom.Personalizacion p
 inner join BelcorpSalvador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpSalvador.ShowRoom.Evento e
                    inner join BelcorpSalvador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpVenezuela.ShowRoom.Personalizacion p
 inner join BelcorpVenezuela.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpVenezuela.ShowRoom.Evento e
                    inner join BelcorpVenezuela.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
 ) t 
 pivot
 (
	max(FlagContenido) 
	FOR Pais in ([BO], [CL], [CO], [CR], [DO], [EC], [GT], [MX], [PA], [PE], [PR], [SV], [VE])
 ) p

END
GO

USE BelcorpPuertoRico
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomPersonalizacion]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomPersonalizacion]  201708
BEGIN

SELECT *
from (
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
	   
  from BelcorpBolivia.ShowRoom.Personalizacion p
 inner join BelcorpBolivia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpBolivia.ShowRoom.Evento e
                    inner join BelcorpBolivia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
      (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
      
  from BelcorpChile.ShowRoom.Personalizacion p
 inner join BelcorpChile.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpChile.ShowRoom.Evento e
                    inner join BelcorpChile.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpColombia.ShowRoom.Personalizacion p
 inner join BelcorpColombia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpColombia.ShowRoom.Evento e
                    inner join BelcorpColombia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpCostaRica.ShowRoom.Personalizacion p
 inner join BelcorpCostaRica.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpCostaRica.ShowRoom.Evento e
                    inner join BelcorpCostaRica.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpDominicana.ShowRoom.Personalizacion p
 inner join BelcorpDominicana.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpDominicana.ShowRoom.Evento e
                    inner join BelcorpDominicana.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpEcuador.ShowRoom.Personalizacion p
 inner join BelcorpEcuador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpEcuador.ShowRoom.Evento e
                    inner join BelcorpEcuador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpGuatemala.ShowRoom.Personalizacion p
 inner join BelcorpGuatemala.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpGuatemala.ShowRoom.Evento e
                    inner join BelcorpGuatemala.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpMexico.ShowRoom.Personalizacion p
 inner join BelcorpMexico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpMexico.ShowRoom.Evento e
                    inner join BelcorpMexico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPanama.ShowRoom.Personalizacion p
 inner join BelcorpPanama.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPanama.ShowRoom.Evento e
                    inner join BelcorpPanama.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPeru.ShowRoom.Personalizacion p
 inner join BelcorpPeru.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPeru.ShowRoom.Evento e
                    inner join BelcorpPeru.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPuertoRico.ShowRoom.Personalizacion p
 inner join BelcorpPuertoRico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPuertoRico.ShowRoom.Evento e
                    inner join BelcorpPuertoRico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpSalvador.ShowRoom.Personalizacion p
 inner join BelcorpSalvador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpSalvador.ShowRoom.Evento e
                    inner join BelcorpSalvador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpVenezuela.ShowRoom.Personalizacion p
 inner join BelcorpVenezuela.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpVenezuela.ShowRoom.Evento e
                    inner join BelcorpVenezuela.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
 ) t 
 pivot
 (
	max(FlagContenido) 
	FOR Pais in ([BO], [CL], [CO], [CR], [DO], [EC], [GT], [MX], [PA], [PE], [PR], [SV], [VE])
 ) p

END
GO

USE BelcorpSalvador
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomPersonalizacion]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomPersonalizacion]  201708
BEGIN

SELECT *
from (
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
	   
  from BelcorpBolivia.ShowRoom.Personalizacion p
 inner join BelcorpBolivia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpBolivia.ShowRoom.Evento e
                    inner join BelcorpBolivia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
      (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
      
  from BelcorpChile.ShowRoom.Personalizacion p
 inner join BelcorpChile.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpChile.ShowRoom.Evento e
                    inner join BelcorpChile.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpColombia.ShowRoom.Personalizacion p
 inner join BelcorpColombia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpColombia.ShowRoom.Evento e
                    inner join BelcorpColombia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpCostaRica.ShowRoom.Personalizacion p
 inner join BelcorpCostaRica.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpCostaRica.ShowRoom.Evento e
                    inner join BelcorpCostaRica.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpDominicana.ShowRoom.Personalizacion p
 inner join BelcorpDominicana.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpDominicana.ShowRoom.Evento e
                    inner join BelcorpDominicana.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpEcuador.ShowRoom.Personalizacion p
 inner join BelcorpEcuador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpEcuador.ShowRoom.Evento e
                    inner join BelcorpEcuador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpGuatemala.ShowRoom.Personalizacion p
 inner join BelcorpGuatemala.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpGuatemala.ShowRoom.Evento e
                    inner join BelcorpGuatemala.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpMexico.ShowRoom.Personalizacion p
 inner join BelcorpMexico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpMexico.ShowRoom.Evento e
                    inner join BelcorpMexico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPanama.ShowRoom.Personalizacion p
 inner join BelcorpPanama.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPanama.ShowRoom.Evento e
                    inner join BelcorpPanama.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPeru.ShowRoom.Personalizacion p
 inner join BelcorpPeru.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPeru.ShowRoom.Evento e
                    inner join BelcorpPeru.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPuertoRico.ShowRoom.Personalizacion p
 inner join BelcorpPuertoRico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPuertoRico.ShowRoom.Evento e
                    inner join BelcorpPuertoRico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpSalvador.ShowRoom.Personalizacion p
 inner join BelcorpSalvador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpSalvador.ShowRoom.Evento e
                    inner join BelcorpSalvador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpVenezuela.ShowRoom.Personalizacion p
 inner join BelcorpVenezuela.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpVenezuela.ShowRoom.Evento e
                    inner join BelcorpVenezuela.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
 ) t 
 pivot
 (
	max(FlagContenido) 
	FOR Pais in ([BO], [CL], [CO], [CR], [DO], [EC], [GT], [MX], [PA], [PE], [PR], [SV], [VE])
 ) p

END
GO

USE BelcorpVenezuela
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomPersonalizacion]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomPersonalizacion]  201708
BEGIN

SELECT *
from (
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
	   
  from BelcorpBolivia.ShowRoom.Personalizacion p
 inner join BelcorpBolivia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpBolivia.ShowRoom.Evento e
                    inner join BelcorpBolivia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
      (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
      
  from BelcorpChile.ShowRoom.Personalizacion p
 inner join BelcorpChile.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpChile.ShowRoom.Evento e
                    inner join BelcorpChile.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpColombia.ShowRoom.Personalizacion p
 inner join BelcorpColombia.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpColombia.ShowRoom.Evento e
                    inner join BelcorpColombia.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpCostaRica.ShowRoom.Personalizacion p
 inner join BelcorpCostaRica.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpCostaRica.ShowRoom.Evento e
                    inner join BelcorpCostaRica.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpDominicana.ShowRoom.Personalizacion p
 inner join BelcorpDominicana.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpDominicana.ShowRoom.Evento e
                    inner join BelcorpDominicana.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpEcuador.ShowRoom.Personalizacion p
 inner join BelcorpEcuador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpEcuador.ShowRoom.Evento e
                    inner join BelcorpEcuador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpGuatemala.ShowRoom.Personalizacion p
 inner join BelcorpGuatemala.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpGuatemala.ShowRoom.Evento e
                    inner join BelcorpGuatemala.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpMexico.ShowRoom.Personalizacion p
 inner join BelcorpMexico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpMexico.ShowRoom.Evento e
                    inner join BelcorpMexico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPanama.ShowRoom.Personalizacion p
 inner join BelcorpPanama.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPanama.ShowRoom.Evento e
                    inner join BelcorpPanama.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPeru.ShowRoom.Personalizacion p
 inner join BelcorpPeru.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPeru.ShowRoom.Evento e
                    inner join BelcorpPeru.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpPuertoRico.ShowRoom.Personalizacion p
 inner join BelcorpPuertoRico.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpPuertoRico.ShowRoom.Evento e
                    inner join BelcorpPuertoRico.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpSalvador.ShowRoom.Personalizacion p
 inner join BelcorpSalvador.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpSalvador.ShowRoom.Evento e
                    inner join BelcorpSalvador.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
union
select pp.codigoiso Pais,
       p.atributo Personalizacion,
       p.tipoaplicacion Medio,
       (case when isnull(pn.personalizacionid, 0) = 0 then (case when p.tipoatributo = 'IMAGEN' then '0' else '' end) else (case when p.tipoatributo = 'IMAGEN' then '1' else pn.valor end) end) FlagContenido
       
  from BelcorpVenezuela.ShowRoom.Personalizacion p
 inner join BelcorpVenezuela.dbo.Pais pp on pp.estadoactivo = 1
  left outer join (select pn.personalizacionnivelid, pn.personalizacionid, pn.valor
                     from BelcorpVenezuela.ShowRoom.Evento e
                    inner join BelcorpVenezuela.ShowRoom.PersonalizacionNivel pn on pn.eventoid = e.eventoid
                    where e.campaniaid = @campania) pn on pn.personalizacionid = p.personalizacionid
 where p.estado = 1  and p.atributo != 'TituloPrincipal' and p.atributo != 'ImagenPrincipal' and p.atributo != 'ColorFondo'
 ) t 
 pivot
 (
	max(FlagContenido) 
	FOR Pais in ([BO], [CL], [CO], [CR], [DO], [EC], [GT], [MX], [PA], [PE], [PR], [SV], [VE])
 ) p

END
GO


