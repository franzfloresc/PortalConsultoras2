USE BelcorpBolivia
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomCampania]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomCampania]  201708
BEGIN
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpBolivia.Showroom.Evento e
		 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpChile.Showroom.Evento e
		 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpColombia.Showroom.Evento e
		 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpCostaRica.Showroom.Evento e
		 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpDominicana.Showroom.Evento e
		 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpEcuador.Showroom.Evento e
		 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpGuatemala.Showroom.Evento e
		 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpMexico.Showroom.Evento e
		 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPanama.Showroom.Evento e
		 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPeru.Showroom.Evento e
		 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPuertoRico.Showroom.Evento e
		 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpSalvador.Showroom.Evento e
		 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpVenezuela.Showroom.Evento e
		 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 order by 1
END
GO

USE BelcorpChile
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomCampania]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomCampania]  201710
BEGIN
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpBolivia.Showroom.Evento e
		 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpChile.Showroom.Evento e
		 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpColombia.Showroom.Evento e
		 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpCostaRica.Showroom.Evento e
		 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpDominicana.Showroom.Evento e
		 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpEcuador.Showroom.Evento e
		 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpGuatemala.Showroom.Evento e
		 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpMexico.Showroom.Evento e
		 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPanama.Showroom.Evento e
		 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPeru.Showroom.Evento e
		 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPuertoRico.Showroom.Evento e
		 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpSalvador.Showroom.Evento e
		 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpVenezuela.Showroom.Evento e
		 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 order by 1
END
GO

USE BelcorpColombia
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomCampania]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomCampania]  201710
BEGIN
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpBolivia.Showroom.Evento e
		 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpChile.Showroom.Evento e
		 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpColombia.Showroom.Evento e
		 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpCostaRica.Showroom.Evento e
		 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpDominicana.Showroom.Evento e
		 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpEcuador.Showroom.Evento e
		 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpGuatemala.Showroom.Evento e
		 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpMexico.Showroom.Evento e
		 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPanama.Showroom.Evento e
		 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPeru.Showroom.Evento e
		 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPuertoRico.Showroom.Evento e
		 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpSalvador.Showroom.Evento e
		 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpVenezuela.Showroom.Evento e
		 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 order by 1
END
GO

USE BelcorpCostaRica
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomCampania]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomCampania]  201710
BEGIN
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpBolivia.Showroom.Evento e
		 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpChile.Showroom.Evento e
		 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpColombia.Showroom.Evento e
		 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpCostaRica.Showroom.Evento e
		 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpDominicana.Showroom.Evento e
		 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpEcuador.Showroom.Evento e
		 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpGuatemala.Showroom.Evento e
		 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpMexico.Showroom.Evento e
		 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPanama.Showroom.Evento e
		 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPeru.Showroom.Evento e
		 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPuertoRico.Showroom.Evento e
		 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpSalvador.Showroom.Evento e
		 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpVenezuela.Showroom.Evento e
		 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 order by 1
END
GO

USE BelcorpDominicana
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomCampania]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomCampania]  201710
BEGIN
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpBolivia.Showroom.Evento e
		 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpChile.Showroom.Evento e
		 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpColombia.Showroom.Evento e
		 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpCostaRica.Showroom.Evento e
		 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpDominicana.Showroom.Evento e
		 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpEcuador.Showroom.Evento e
		 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpGuatemala.Showroom.Evento e
		 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpMexico.Showroom.Evento e
		 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPanama.Showroom.Evento e
		 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPeru.Showroom.Evento e
		 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPuertoRico.Showroom.Evento e
		 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpSalvador.Showroom.Evento e
		 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpVenezuela.Showroom.Evento e
		 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 order by 1
END
GO

USE BelcorpEcuador
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomCampania]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomCampania]  201710
BEGIN
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpBolivia.Showroom.Evento e
		 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpChile.Showroom.Evento e
		 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpColombia.Showroom.Evento e
		 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpCostaRica.Showroom.Evento e
		 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpDominicana.Showroom.Evento e
		 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpEcuador.Showroom.Evento e
		 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpGuatemala.Showroom.Evento e
		 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpMexico.Showroom.Evento e
		 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPanama.Showroom.Evento e
		 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPeru.Showroom.Evento e
		 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPuertoRico.Showroom.Evento e
		 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpSalvador.Showroom.Evento e
		 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpVenezuela.Showroom.Evento e
		 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 order by 1
END
GO

USE BelcorpGuatemala
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomCampania]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomCampania]  201710
BEGIN
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpBolivia.Showroom.Evento e
		 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpChile.Showroom.Evento e
		 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpColombia.Showroom.Evento e
		 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpCostaRica.Showroom.Evento e
		 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpDominicana.Showroom.Evento e
		 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpEcuador.Showroom.Evento e
		 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpGuatemala.Showroom.Evento e
		 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpMexico.Showroom.Evento e
		 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPanama.Showroom.Evento e
		 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPeru.Showroom.Evento e
		 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPuertoRico.Showroom.Evento e
		 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpSalvador.Showroom.Evento e
		 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpVenezuela.Showroom.Evento e
		 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 order by 1
END
GO

USE BelcorpMexico
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomCampania]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomCampania]  201710
BEGIN
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpBolivia.Showroom.Evento e
		 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpChile.Showroom.Evento e
		 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpColombia.Showroom.Evento e
		 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpCostaRica.Showroom.Evento e
		 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpDominicana.Showroom.Evento e
		 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpEcuador.Showroom.Evento e
		 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpGuatemala.Showroom.Evento e
		 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpMexico.Showroom.Evento e
		 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPanama.Showroom.Evento e
		 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPeru.Showroom.Evento e
		 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPuertoRico.Showroom.Evento e
		 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpSalvador.Showroom.Evento e
		 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpVenezuela.Showroom.Evento e
		 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 order by 1
END
GO

USE BelcorpPanama
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomCampania]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomCampania]  201710
BEGIN
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpBolivia.Showroom.Evento e
		 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpChile.Showroom.Evento e
		 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpColombia.Showroom.Evento e
		 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpCostaRica.Showroom.Evento e
		 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpDominicana.Showroom.Evento e
		 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpEcuador.Showroom.Evento e
		 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpGuatemala.Showroom.Evento e
		 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpMexico.Showroom.Evento e
		 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPanama.Showroom.Evento e
		 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPeru.Showroom.Evento e
		 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPuertoRico.Showroom.Evento e
		 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpSalvador.Showroom.Evento e
		 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpVenezuela.Showroom.Evento e
		 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 order by 1
END
GO

USE BelcorpPeru
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomCampania]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomCampania]  201710
BEGIN
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpBolivia.Showroom.Evento e
		 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpChile.Showroom.Evento e
		 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpColombia.Showroom.Evento e
		 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpCostaRica.Showroom.Evento e
		 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpDominicana.Showroom.Evento e
		 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpEcuador.Showroom.Evento e
		 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpGuatemala.Showroom.Evento e
		 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpMexico.Showroom.Evento e
		 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPanama.Showroom.Evento e
		 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPeru.Showroom.Evento e
		 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPuertoRico.Showroom.Evento e
		 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpSalvador.Showroom.Evento e
		 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpVenezuela.Showroom.Evento e
		 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 order by 1
END
GO

USE BelcorpPuertoRico
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomCampania]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomCampania]  201710
BEGIN
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpBolivia.Showroom.Evento e
		 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpChile.Showroom.Evento e
		 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpColombia.Showroom.Evento e
		 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpCostaRica.Showroom.Evento e
		 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpDominicana.Showroom.Evento e
		 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpEcuador.Showroom.Evento e
		 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpGuatemala.Showroom.Evento e
		 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpMexico.Showroom.Evento e
		 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPanama.Showroom.Evento e
		 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPeru.Showroom.Evento e
		 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPuertoRico.Showroom.Evento e
		 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpSalvador.Showroom.Evento e
		 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpVenezuela.Showroom.Evento e
		 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 order by 1
END
GO

USE BelcorpSalvador
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomCampania]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomCampania]  201710
BEGIN
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpBolivia.Showroom.Evento e
		 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpChile.Showroom.Evento e
		 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpColombia.Showroom.Evento e
		 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpCostaRica.Showroom.Evento e
		 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpDominicana.Showroom.Evento e
		 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpEcuador.Showroom.Evento e
		 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpGuatemala.Showroom.Evento e
		 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpMexico.Showroom.Evento e
		 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPanama.Showroom.Evento e
		 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPeru.Showroom.Evento e
		 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPuertoRico.Showroom.Evento e
		 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpSalvador.Showroom.Evento e
		 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpVenezuela.Showroom.Evento e
		 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 order by 1
END
GO

USE BelcorpVenezuela
GO

CREATE PROCEDURE [dbo].[GetReporteValidacionShowRoomCampania]
	@campania int
AS
--exec [dbo].[GetReporteValidacionShowRoomCampania]  201710
BEGIN
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpBolivia.Showroom.Evento e
		 inner join BelcorpBolivia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpChile.Showroom.Evento e
		 inner join BelcorpChile.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpColombia.Showroom.Evento e
		 inner join BelcorpColombia.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpCostaRica.Showroom.Evento e
		 inner join BelcorpCostaRica.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpDominicana.Showroom.Evento e
		 inner join BelcorpDominicana.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpEcuador.Showroom.Evento e
		 inner join BelcorpEcuador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpGuatemala.Showroom.Evento e
		 inner join BelcorpGuatemala.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpMexico.Showroom.Evento e
		 inner join BelcorpMexico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPanama.Showroom.Evento e
		 inner join BelcorpPanama.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPeru.Showroom.Evento e
		 inner join BelcorpPeru.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpPuertoRico.Showroom.Evento e
		 inner join BelcorpPuertoRico.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpSalvador.Showroom.Evento e
		 inner join BelcorpSalvador.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 union
		select p.codigoiso Pais,
			   e.campaniaid Campania,
			   e.nombre NombreEvento,
			   e.diasantes DiasAntes,
			   e.diasdespues DiasDespues,
			   e.estado FlagHabilitarEvento,
			   (case when isnull(e.tienecompraxcompra, 0) = 0 then 0 else 1 end) FlagHabilitarCompraXCompra,
			   (case when isnull(e.tienesubcampania, 0) = 0 then 0 else 1 end) FlagHabilitarSubCampania,
			   (case when isnull(e.tienepersonalizacion, 0) = 0 then 0 else 1 end) FlagHabilitarPersonalizacion
		  from BelcorpVenezuela.Showroom.Evento e
		 inner join BelcorpVenezuela.dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
		 order by 1
END
GO

