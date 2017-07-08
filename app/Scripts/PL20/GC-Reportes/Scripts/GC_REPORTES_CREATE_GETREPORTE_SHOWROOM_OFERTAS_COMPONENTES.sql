USE BelcorpBolivia
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomComponentes]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomComponentes]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end
go

USE BelcorpChile
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomComponentes]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomComponentes]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end
go

USE BelcorpColombia
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomComponentes]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomComponentes]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end
go

USE BelcorpCostaRica
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomComponentes]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomComponentes]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end
go

USE BelcorpDominicana
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomComponentes]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomComponentes]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end
go

USE BelcorpEcuador
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomComponentes]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomComponentes]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end
go

USE BelcorpGuatemala
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomComponentes]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomComponentes]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end
go

USE BelcorpMexico
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomComponentes]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomComponentes]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end
go

USE BelcorpPanama
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomComponentes]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomComponentes]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end
go

USE BelcorpPeru
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomComponentes]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomComponentes]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end
go

USE BelcorpPuertoRico
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomComponentes]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomComponentes]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end
go

USE BelcorpSalvador
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomComponentes]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomComponentes]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end
go

USE BelcorpVenezuela
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomComponentes]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomComponentes]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       os.cuv CUV,
       isnull(osd.nombreproducto, '') Nombre,
       isnull(osd.descripcion1, '') Descripcion1,
       isnull(osd.descripcion2, '') Descripcion2,
       isnull(osd.descripcion3, '') Descripcion3,
       (case when isnull(osd.imagen	, '') = '' then '0' else '1' end) FlagImagenCargada
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoomDetalle osd on osd.campaniaid = e.campaniaid and osd.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end
go

