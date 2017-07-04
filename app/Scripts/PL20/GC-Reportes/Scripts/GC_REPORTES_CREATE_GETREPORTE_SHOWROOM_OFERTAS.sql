USE BelcorpBolivia
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomOferta]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomOferta]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_BO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CL.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_DO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_EC.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_GT.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_MX.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PA.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_SV.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_VE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end
GO

USE BelcorpChile
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomOferta]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomOferta]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_BO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CL.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_DO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_EC.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_GT.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_MX.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PA.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_SV.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_VE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end


GO

USE BelcorpColombia
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomOferta]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomOferta]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_BO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CL.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_DO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_EC.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_GT.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_MX.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PA.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_SV.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_VE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end

GO

USE BelcorpCostaRica
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomOferta]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomOferta]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_BO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CL.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_DO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_EC.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_GT.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_MX.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PA.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_SV.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_VE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end

GO

USE BelcorpDominicana
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomOferta]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomOferta]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_BO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CL.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_DO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_EC.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_GT.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_MX.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PA.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_SV.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_VE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end

GO

USE BelcorpEcuador
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomOferta]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomOferta]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_BO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CL.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_DO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_EC.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_GT.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_MX.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PA.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_SV.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_VE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end

GO

USE BelcorpGuatemala
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomOferta]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomOferta]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_BO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CL.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_DO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_EC.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_GT.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_MX.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PA.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_SV.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_VE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end

GO

USE BelcorpMexico
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomOferta]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomOferta]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_BO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CL.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_DO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_EC.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_GT.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_MX.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PA.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_SV.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_VE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end

GO

USE BelcorpPanama
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomOferta]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomOferta]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_BO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CL.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_DO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_EC.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_GT.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_MX.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PA.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_SV.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_VE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end

GO

USE BelcorpPeru
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomOferta]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomOferta]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_BO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CL.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_DO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_EC.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_GT.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_MX.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PA.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_SV.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_VE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end

GO

USE BelcorpPuertoRico
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomOferta]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomOferta]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_BO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CL.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_DO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_EC.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_GT.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_MX.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PA.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_SV.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_VE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end

GO

USE BelcorpSalvador
GO
CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomOferta]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomOferta]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_BO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CL.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_DO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_EC.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_GT.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_MX.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PA.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_SV.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_VE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end

GO

USE BelcorpVenezuela
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomOferta]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomOferta]  201708
BEGIN
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpBolivia.Showroom.Evento e
 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
 inner join ODS_BO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpBolivia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_BO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpChile.Showroom.Evento e
 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
 inner join ODS_CL.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpChile.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CL.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpColombia.Showroom.Evento e
 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
 inner join ODS_CO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpColombia.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpCostaRica.Showroom.Evento e
 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
 inner join ODS_CR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpCostaRica.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_CR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpDominicana.Showroom.Evento e
 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
 inner join ODS_DO.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpDominicana.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_DO.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpEcuador.Showroom.Evento e
 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
 inner join ODS_EC.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpEcuador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_EC.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpGuatemala.Showroom.Evento e
 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
 inner join ODS_GT.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpGuatemala.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_GT.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpMexico.Showroom.Evento e
 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
 inner join ODS_MX.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpMexico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_MX.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPanama.Showroom.Evento e
 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
 inner join ODS_PA.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPanama.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PA.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPeru.Showroom.Evento e
 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
 inner join ODS_PE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPeru.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpPuertoRico.Showroom.Evento e
 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
 inner join ODS_PR.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpPuertoRico.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_PR.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpSalvador.Showroom.Evento e
 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
 inner join ODS_SV.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpSalvador.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_SV.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 union
select p.codigoiso Pais,
       e.campaniaid Campania,
       pc.codigotipooferta CodigoTO,
       pc.codigoproducto SAP,
       os.cuv CUV,
       os.descripcion Descripcion,
       os.preciovalorizado PrecioValorizado,
       os.preciooferta PrecioOferta,
       os.unidadespermitidas UnidadesPermitidas,
       (case when isnull(os.essubcampania, 0) = 0 then 0 else 1 end) EsSubCampaña,
       (case when isnull(os.flaghabilitarproducto, 0) = 0 then 0 else 1 end) HabilitarOferta,
       (case when isnull(os.imagenproducto, '') = '' then '0' else '1' end) FlagImagenCargada,
       (case when isnull(os.imagenmini, '') = '' then '0' else '1' end) FlagImagenMini
  from BelcorpVenezuela.Showroom.Evento e
 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
 inner join ODS_VE.dbo.Campania c on c.codigo = e.campaniaid
 inner join BelcorpVenezuela.ShowRoom.OfertaShowRoom os on os.campaniaid = c.campaniaid
 inner join ODS_VE.dbo.ProductoComercial pc on pc.campaniaid = os.campaniaid and pc.cuv = os.cuv
 where e.campaniaid = @campania
 order by 1
 
end

GO


