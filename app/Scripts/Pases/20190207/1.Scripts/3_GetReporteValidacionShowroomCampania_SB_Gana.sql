USE BelcorpPeru
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomCampania_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowRoomCampania 201902
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
		  from Showroom.Evento e
		 inner join dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
END

GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomCampania_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowRoomCampania 201902
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
		  from Showroom.Evento e
		 inner join dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
END

GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomCampania_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowRoomCampania 201902
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
		  from Showroom.Evento e
		 inner join dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
END

GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomCampania_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowRoomCampania 201902
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
		  from Showroom.Evento e
		 inner join dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
END

GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomCampania_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowRoomCampania 201902
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
		  from Showroom.Evento e
		 inner join dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
END

GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomCampania_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowRoomCampania 201902
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
		  from Showroom.Evento e
		 inner join dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
END

GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomCampania_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowRoomCampania 201902
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
		  from Showroom.Evento e
		 inner join dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
END

GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomCampania_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowRoomCampania 201902
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
		  from Showroom.Evento e
		 inner join dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
END

GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomCampania_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowRoomCampania 201902
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
		  from Showroom.Evento e
		 inner join dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
END

GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomCampania_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowRoomCampania 201902
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
		  from Showroom.Evento e
		 inner join dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
END

GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomCampania_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowRoomCampania 201902
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
		  from Showroom.Evento e
		 inner join dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
END

GO

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 
          FROM   sys.procedures 
          WHERE  NAME = 'GetReporteValidacionShowroomCampania_SB') 
  BEGIN 
      DROP PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
  END 
GO 

CREATE PROCEDURE dbo.GetReporteValidacionShowroomCampania_SB
	@campania int
AS
--exec dbo.GetReporteValidacionShowRoomCampania 201902
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
		  from Showroom.Evento e
		 inner join dbo.Pais p on estadoactivo = 1
		 where e.campaniaid = @campania
END

GO

