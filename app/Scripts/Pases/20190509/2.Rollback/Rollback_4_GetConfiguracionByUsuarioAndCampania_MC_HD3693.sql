Use [BelcorpPeru]
GO
ALTER PROCEDURE [dbo].[GetConfiguracionByUsuarioAndCampania]
  @PaisID tinyint,
  @ConsultoraID bigint,
  @Campania int,
  @UsuarioPrueba bit,
  @AceptacionConsultoraDA int
AS
BEGIN
  declare @ZonaID int;
  declare @RegionID int;
  declare @CodigoUsuario varchar(20);
  declare @PrimerNombre varchar(25);
  declare @MontoMinimoPedido numeric(15,2);
  declare @MontoMaximoPedido numeric(15,2);
  declare @IdEstadoActividad int;
  declare @ConsultoraAsociadoID bigint;
  declare @ConsultoraAsociada varchar(20);
  declare @EsPostulante bit = 0;
    
  select top 1
    @EsPostulante = 1,
    @ZonaID = CP.ZonaID, -- ¿Siempre está lleno este campo o hago join con el Zona de UsuarioPostulante?
    @RegionID = CP.RegionID, -- ¿Siempre está lleno este campo o hago join con la Region de UsuarioPostulante?
    @CodigoUsuario = CP.Codigo,
    @PrimerNombre = CP.PrimerNombre
  from ConsultoraPostulante CP (nolock)
  inner join UsuarioPostulante UP (nolock) on UP.CodigoUsuario = CP.Codigo and UP.Estado = 1 -- inner o left
  where CP.ConsultoraID = @ConsultoraID and UP.UsuarioReal = 0;

  IF @EsPostulante = 0
  BEGIN
    IF @UsuarioPrueba = 0
    BEGIN
      select
        @ZonaID = C.ZonaID,
        @RegionID = C.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = C.PrimerNombre,
        @MontoMinimoPedido = C.MontoMinimoPedido,
        @MontoMaximoPedido = C.MontoMaximoPedido,
        @IdEstadoActividad = C.IdEstadoActividad
      from ods.Consultora C (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = C.Codigo
      where ConsultoraID = @ConsultoraID;
    END
    ELSE
    BEGIN
      select
        @ZonaID = CF.ZonaID,
        @RegionID = CF.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = CF.PrimerNombre,
        @MontoMinimoPedido = CF.MontoMinimoPedido,
        @MontoMaximoPedido = CF.MontoMaximoPedido,
        @IdEstadoActividad = CF.IdEstadoActividad,
        @ConsultoraAsociadoID = C.ConsultoraID,
        @ConsultoraAsociada = C.Codigo
      from ConsultoraFicticia CF (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = CF.Codigo
      left join usuarioprueba UP (nolock) on U.CodigoUsuario = UP.CodigoUsuario
      left join ods.Consultora C (nolock) on UP.CodigoConsultoraAsociada = C.Codigo
      where CF.ConsultoraID = @ConsultoraID;
    END
  END

  declare @DiasDuracionCronograma tinyint = 1;  
  declare @ZonaValida int;
  declare @IndicadorDias bit = 0;

  select
    @DiasDuracionCronograma = DiasDuracionCronograma,
    @ZonaValida = ZonaID,
    @IndicadorDias = ValidacionActiva
  from ConfiguracionValidacionZona with(nolock)
  where ZonaID = @ZonaID;

  -- Dias Duracion Cronograma para Nuevas (CR)
  IF @EsPostulante = 0 and @DiasDuracionCronograma > 1 and @PaisID in (5,7,8,10)
  BEGIN
    declare @UCF int = 0, @SID int = 0;
    select
      @UCF = isnull(UltimaCampanaFacturada,0),
      @SID = isnull(SegmentoId,0)
    from ods.Consultora with(nolock)
    where ConsultoraID = @ConsultoraID;

    IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
      SET @DiasDuracionCronograma = 2
  END

  select
    P.PaisID,
    P.CodigoISO,
    isnull(P.TieneHana,0) as TieneHana,
    P.Simbolo,
    P.EstadoSimplificacionCUV,
    isnull(P.ZonaHoraria,0) as ZonaHoraria,
    P.PROLSinStock,
    P.NuevoPROL,
    isnull(p.TieneODD,0) as TieneODD,
    iif(
      P.NuevoPROL = 0,
      0,
      isnull((select top 1 1 from ConfiguracionValidacionNuevoPROL with(nolock) where ZonaId = @ZonaId), 0)
    ) as ZonaNuevoPROL,
    iif(
      P.EsquemaDAConsultora = 0 or @AceptacionConsultoraDA < 1,
      isnull(@ZonaValida,-1),
      -1
    ) as ZonaValida,
    iif(@IndicadorDias = 0, 0, CV.DiasAntes) as DiasAntes,
    CV.HoraInicio,
    iif(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(cr.CampaniaId,0) = 0, CV.HoraFin, P.HoraCierreZonaDemAnti),
      iif(@AceptacionConsultoraDA < 1, CV.HoraFin, P.HoraCierreZonaDemAnti)
    ) as HoraFin,
    CV.HoraInicioNoFacturable,
    CV.HoraCierreNoFacturable,
    iif(@EsPostulante = 0,CV.ValidacionInteractiva,0) as ValidacionInteractiva,
    CV.HabilitarRestriccionHoraria,
    isnull(CV.HorasDuracionRestriccion,0) as HorasDuracionRestriccion,
    @Campania as CampaniaID,
    @ConsultoraID as ConsultoraID,
    isnull(@PrimerNombre,'') as PrimerNombre,
    @MontoMinimoPedido as MontoMinimoPedido,
    @MontoMaximoPedido as MontoMaximoPedido,
    isnull(@IdEstadoActividad,0) as ConsultoraNueva,
    isnull(U.TipoUsuario,0) as TipoUsuario,
    U.CodigoConsultora,
    U.CodigoUsuario,
    U.Nombre as NombreCompleto,
    isnull(U.Email,'') as Email,
    @UsuarioPrueba as UsuarioPrueba,
    isnull(R.RegionID,0) as RegionID,
    isnull(R.Codigo,'') as CodigorRegion,
    isnull(Z.ZonaID,0) as ZonaID,
    isnull(Z.Codigo,'') as CodigoZona,
    isnull(@ConsultoraAsociadoID,0) as ConsultoraAsociadoID,
    @ConsultoraAsociada as ConsultoraAsociada,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(P.TipoDA = 0,oCr.FechaInicioFacturacion,ISNULL(Cr.FechaInicioWeb, oCr.FechaInicioFacturacion)),
      IIF(@AceptacionConsultoraDA < 1, oCr.FechaInicioFacturacion, Cr.FechaInicioWeb)
    ) as FechaInicioFacturacion,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(
        P.TipoDA = 0,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        IIF(
          @PaisID = 4,
          ISNULL(Cr.FechaInicioDD,oCr.FechaInicioReFacturacion),
          ISNULL(Cr.FechaInicioWeb,oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0))
        )
      ),
      IIF(
        @AceptacionConsultoraDA < 1,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        Cr.FechaInicioWeb
      )
    ) as FechaFinFacturacion,
    P.HoraCierreZonaNormal as HoraCierreZonaNormal,
    IIF(
      P.EsquemaDAConsultora <> 0 AND @AceptacionConsultoraDA < 1,
      P.HoraCierreZonaNormal,
      P.HoraCierreZonaDemAnti
    ) as HoraCierreZonaDemAnti,   
    IIF(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(Cr.CampaniaId,0) = 0, 0, 1),
      iif(@AceptacionConsultoraDA = 0 or isnull(Cr.CampaniaId,0) = 0,0,1)
    ) as EsZonaDemAnti
  FROM Pais P (nolock)
  inner join ConfiguracionValidacion CV (nolock) on CV.PaisID = P.PaisID
  inner join Usuario U (nolock) on U.CodigoUsuario = @CodigoUsuario
  inner join UsuarioRol UR (nolock) ON U.CodigoUsuario = UR.CodigoUsuario
  inner join Rol Ro with(nolock) ON UR.RolID = Ro.RolID
  inner join ods.Region R (nolock) on R.RegionID = @RegionID
  inner join ods.Zona Z (nolock) on Z.ZonaID = @ZonaID
  inner join ods.Cronograma oCr (nolock) on oCr.ZonaID = @ZonaID AND oCr.RegionID = @RegionID
  inner join ods.Campania Ca (nolock) on oCr.CampaniaID = Ca.CampaniaID
  left join Cronograma Cr (nolock) on oCr.RegionID = Cr.RegionID and oCr.ZonaID = Cr.ZonaID and oCr.CampaniaID = Cr.CampaniaID
  WHERE P.PaisID = @PaisID and Ro.Sistema = 1 and Ca.Codigo = @Campania;
END

GO
USE [BelcorpChile]
GO

/****** Object:  StoredProcedure [dbo].[GetConfiguracionByUsuarioAndCampania]    Script Date: 21/03/2019 11:13:54 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetConfiguracionByUsuarioAndCampania]
  @PaisID tinyint,
  @ConsultoraID bigint,
  @Campania int,
  @UsuarioPrueba bit,
  @AceptacionConsultoraDA int
AS
BEGIN
  declare @ZonaID int;
  declare @RegionID int;
  declare @CodigoUsuario varchar(20);
  declare @PrimerNombre varchar(25);
  declare @MontoMinimoPedido numeric(15,2);
  declare @MontoMaximoPedido numeric(15,2);
  declare @IdEstadoActividad int;
  declare @ConsultoraAsociadoID bigint;
  declare @ConsultoraAsociada varchar(20);
  declare @EsPostulante bit = 0;
    
  select top 1
    @EsPostulante = 1,
    @ZonaID = CP.ZonaID, -- ¿Siempre está lleno este campo o hago join con el Zona de UsuarioPostulante?
    @RegionID = CP.RegionID, -- ¿Siempre está lleno este campo o hago join con la Region de UsuarioPostulante?
    @CodigoUsuario = CP.Codigo,
    @PrimerNombre = CP.PrimerNombre
  from ConsultoraPostulante CP (nolock)
  inner join UsuarioPostulante UP (nolock) on UP.CodigoUsuario = CP.Codigo and UP.Estado = 1 -- inner o left
  where CP.ConsultoraID = @ConsultoraID and UP.UsuarioReal = 0;

  IF @EsPostulante = 0
  BEGIN
    IF @UsuarioPrueba = 0
    BEGIN
      select
        @ZonaID = C.ZonaID,
        @RegionID = C.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = C.PrimerNombre,
        @MontoMinimoPedido = C.MontoMinimoPedido,
        @MontoMaximoPedido = C.MontoMaximoPedido,
        @IdEstadoActividad = C.IdEstadoActividad
      from ods.Consultora C (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = C.Codigo
      where ConsultoraID = @ConsultoraID;
    END
    ELSE
    BEGIN
      select
        @ZonaID = CF.ZonaID,
        @RegionID = CF.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = CF.PrimerNombre,
        @MontoMinimoPedido = CF.MontoMinimoPedido,
        @MontoMaximoPedido = CF.MontoMaximoPedido,
        @IdEstadoActividad = CF.IdEstadoActividad,
        @ConsultoraAsociadoID = C.ConsultoraID,
        @ConsultoraAsociada = C.Codigo
      from ConsultoraFicticia CF (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = CF.Codigo
      left join usuarioprueba UP (nolock) on U.CodigoUsuario = UP.CodigoUsuario
      left join ods.Consultora C (nolock) on UP.CodigoConsultoraAsociada = C.Codigo
      where CF.ConsultoraID = @ConsultoraID;
    END
  END

  declare @DiasDuracionCronograma tinyint = 1;  
  declare @ZonaValida int;
  declare @IndicadorDias bit = 0;

  select
    @DiasDuracionCronograma = DiasDuracionCronograma,
    @ZonaValida = ZonaID,
    @IndicadorDias = ValidacionActiva
  from ConfiguracionValidacionZona with(nolock)
  where ZonaID = @ZonaID;

  -- Dias Duracion Cronograma para Nuevas (CR)
  IF @EsPostulante = 0 and @DiasDuracionCronograma > 1 and @PaisID in (5,7,8,10)
  BEGIN
    declare @UCF int = 0, @SID int = 0;
    select
      @UCF = isnull(UltimaCampanaFacturada,0),
      @SID = isnull(SegmentoId,0)
    from ods.Consultora with(nolock)
    where ConsultoraID = @ConsultoraID;

    IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
      SET @DiasDuracionCronograma = 2
  END

  select
    P.PaisID,
    P.CodigoISO,
    isnull(P.TieneHana,0) as TieneHana,
    P.Simbolo,
    P.EstadoSimplificacionCUV,
    isnull(P.ZonaHoraria,0) as ZonaHoraria,
    P.PROLSinStock,
    P.NuevoPROL,
    isnull(p.TieneODD,0) as TieneODD,
    iif(
      P.NuevoPROL = 0,
      0,
      isnull((select top 1 1 from ConfiguracionValidacionNuevoPROL with(nolock) where ZonaId = @ZonaId), 0)
    ) as ZonaNuevoPROL,
    iif(
      P.EsquemaDAConsultora = 0 or @AceptacionConsultoraDA < 1,
      isnull(@ZonaValida,-1),
      -1
    ) as ZonaValida,
    iif(@IndicadorDias = 0, 0, CV.DiasAntes) as DiasAntes,
    CV.HoraInicio,
    iif(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(cr.CampaniaId,0) = 0, CV.HoraFin, P.HoraCierreZonaDemAnti),
      iif(@AceptacionConsultoraDA < 1, CV.HoraFin, P.HoraCierreZonaDemAnti)
    ) as HoraFin,
    CV.HoraInicioNoFacturable,
    CV.HoraCierreNoFacturable,
    iif(@EsPostulante = 0,CV.ValidacionInteractiva,0) as ValidacionInteractiva,
    CV.HabilitarRestriccionHoraria,
    isnull(CV.HorasDuracionRestriccion,0) as HorasDuracionRestriccion,
    @Campania as CampaniaID,
    @ConsultoraID as ConsultoraID,
    isnull(@PrimerNombre,'') as PrimerNombre,
    @MontoMinimoPedido as MontoMinimoPedido,
    @MontoMaximoPedido as MontoMaximoPedido,
    isnull(@IdEstadoActividad,0) as ConsultoraNueva,
    isnull(U.TipoUsuario,0) as TipoUsuario,
    U.CodigoConsultora,
    U.CodigoUsuario,
    U.Nombre as NombreCompleto,
    isnull(U.Email,'') as Email,
    @UsuarioPrueba as UsuarioPrueba,
    isnull(R.RegionID,0) as RegionID,
    isnull(R.Codigo,'') as CodigorRegion,
    isnull(Z.ZonaID,0) as ZonaID,
    isnull(Z.Codigo,'') as CodigoZona,
    isnull(@ConsultoraAsociadoID,0) as ConsultoraAsociadoID,
    @ConsultoraAsociada as ConsultoraAsociada,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(P.TipoDA = 0,oCr.FechaInicioFacturacion,ISNULL(Cr.FechaInicioWeb, oCr.FechaInicioFacturacion)),
      IIF(@AceptacionConsultoraDA < 1, oCr.FechaInicioFacturacion, Cr.FechaInicioWeb)
    ) as FechaInicioFacturacion,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(
        P.TipoDA = 0,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        IIF(
          @PaisID = 4,
          ISNULL(Cr.FechaInicioDD,oCr.FechaInicioReFacturacion),
          ISNULL(Cr.FechaInicioWeb,oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0))
        )
      ),
      IIF(
        @AceptacionConsultoraDA < 1,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        Cr.FechaInicioWeb
      )
    ) as FechaFinFacturacion,
    P.HoraCierreZonaNormal as HoraCierreZonaNormal,
    IIF(
      P.EsquemaDAConsultora <> 0 AND @AceptacionConsultoraDA < 1,
      P.HoraCierreZonaNormal,
      P.HoraCierreZonaDemAnti
    ) as HoraCierreZonaDemAnti,   
    IIF(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(Cr.CampaniaId,0) = 0, 0, 1),
      iif(@AceptacionConsultoraDA = 0 or isnull(Cr.CampaniaId,0) = 0,0,1)
    ) as EsZonaDemAnti
  FROM Pais P (nolock)
  inner join ConfiguracionValidacion CV (nolock) on CV.PaisID = P.PaisID
  inner join Usuario U (nolock) on U.CodigoUsuario = @CodigoUsuario
  inner join UsuarioRol UR (nolock) ON U.CodigoUsuario = UR.CodigoUsuario
  inner join Rol Ro with(nolock) ON UR.RolID = Ro.RolID
  inner join ods.Region R (nolock) on R.RegionID = @RegionID
  inner join ods.Zona Z (nolock) on Z.ZonaID = @ZonaID
  inner join ods.Cronograma oCr (nolock) on oCr.ZonaID = @ZonaID AND oCr.RegionID = @RegionID
  inner join ods.Campania Ca (nolock) on oCr.CampaniaID = Ca.CampaniaID
  left join Cronograma Cr (nolock) on oCr.RegionID = Cr.RegionID and oCr.ZonaID = Cr.ZonaID and oCr.CampaniaID = Cr.CampaniaID
  WHERE P.PaisID = @PaisID and Ro.Sistema = 1 and Ca.Codigo = @Campania;
END

GO

Use [BelcorpBolivia]
GO
ALTER PROCEDURE [dbo].[GetConfiguracionByUsuarioAndCampania]
  @PaisID tinyint,
  @ConsultoraID bigint,
  @Campania int,
  @UsuarioPrueba bit,
  @AceptacionConsultoraDA int
AS
BEGIN
  declare @ZonaID int;
  declare @RegionID int;
  declare @CodigoUsuario varchar(20);
  declare @PrimerNombre varchar(25);
  declare @MontoMinimoPedido numeric(15,2);
  declare @MontoMaximoPedido numeric(15,2);
  declare @IdEstadoActividad int;
  declare @ConsultoraAsociadoID bigint;
  declare @ConsultoraAsociada varchar(20);
  declare @EsPostulante bit = 0;
    
  select top 1
    @EsPostulante = 1,
    @ZonaID = CP.ZonaID, -- ¿Siempre está lleno este campo o hago join con el Zona de UsuarioPostulante?
    @RegionID = CP.RegionID, -- ¿Siempre está lleno este campo o hago join con la Region de UsuarioPostulante?
    @CodigoUsuario = CP.Codigo,
    @PrimerNombre = CP.PrimerNombre
  from ConsultoraPostulante CP (nolock)
  inner join UsuarioPostulante UP (nolock) on UP.CodigoUsuario = CP.Codigo and UP.Estado = 1 -- inner o left
  where CP.ConsultoraID = @ConsultoraID and UP.UsuarioReal = 0;

  IF @EsPostulante = 0
  BEGIN
    IF @UsuarioPrueba = 0
    BEGIN
      select
        @ZonaID = C.ZonaID,
        @RegionID = C.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = C.PrimerNombre,
        @MontoMinimoPedido = C.MontoMinimoPedido,
        @MontoMaximoPedido = C.MontoMaximoPedido,
        @IdEstadoActividad = C.IdEstadoActividad
      from ods.Consultora C (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = C.Codigo
      where ConsultoraID = @ConsultoraID;
    END
    ELSE
    BEGIN
      select
        @ZonaID = CF.ZonaID,
        @RegionID = CF.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = CF.PrimerNombre,
        @MontoMinimoPedido = CF.MontoMinimoPedido,
        @MontoMaximoPedido = CF.MontoMaximoPedido,
        @IdEstadoActividad = CF.IdEstadoActividad,
        @ConsultoraAsociadoID = C.ConsultoraID,
        @ConsultoraAsociada = C.Codigo
      from ConsultoraFicticia CF (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = CF.Codigo
      left join usuarioprueba UP (nolock) on U.CodigoUsuario = UP.CodigoUsuario
      left join ods.Consultora C (nolock) on UP.CodigoConsultoraAsociada = C.Codigo
      where CF.ConsultoraID = @ConsultoraID;
    END
  END

  declare @DiasDuracionCronograma tinyint = 1;  
  declare @ZonaValida int;
  declare @IndicadorDias bit = 0;

  select
    @DiasDuracionCronograma = DiasDuracionCronograma,
    @ZonaValida = ZonaID,
    @IndicadorDias = ValidacionActiva
  from ConfiguracionValidacionZona with(nolock)
  where ZonaID = @ZonaID;

  -- Dias Duracion Cronograma para Nuevas (CR)
  IF @EsPostulante = 0 and @DiasDuracionCronograma > 1 and @PaisID in (5,7,8,10)
  BEGIN
    declare @UCF int = 0, @SID int = 0;
    select
      @UCF = isnull(UltimaCampanaFacturada,0),
      @SID = isnull(SegmentoId,0)
    from ods.Consultora with(nolock)
    where ConsultoraID = @ConsultoraID;

    IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
      SET @DiasDuracionCronograma = 2
  END

  select
    P.PaisID,
    P.CodigoISO,
    isnull(P.TieneHana,0) as TieneHana,
    P.Simbolo,
    P.EstadoSimplificacionCUV,
    isnull(P.ZonaHoraria,0) as ZonaHoraria,
    P.PROLSinStock,
    P.NuevoPROL,
    isnull(p.TieneODD,0) as TieneODD,
    iif(
      P.NuevoPROL = 0,
      0,
      isnull((select top 1 1 from ConfiguracionValidacionNuevoPROL with(nolock) where ZonaId = @ZonaId), 0)
    ) as ZonaNuevoPROL,
    iif(
      P.EsquemaDAConsultora = 0 or @AceptacionConsultoraDA < 1,
      isnull(@ZonaValida,-1),
      -1
    ) as ZonaValida,
    iif(@IndicadorDias = 0, 0, CV.DiasAntes) as DiasAntes,
    CV.HoraInicio,
    iif(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(cr.CampaniaId,0) = 0, CV.HoraFin, P.HoraCierreZonaDemAnti),
      iif(@AceptacionConsultoraDA < 1, CV.HoraFin, P.HoraCierreZonaDemAnti)
    ) as HoraFin,
    CV.HoraInicioNoFacturable,
    CV.HoraCierreNoFacturable,
    iif(@EsPostulante = 0,CV.ValidacionInteractiva,0) as ValidacionInteractiva,
    CV.HabilitarRestriccionHoraria,
    isnull(CV.HorasDuracionRestriccion,0) as HorasDuracionRestriccion,
    @Campania as CampaniaID,
    @ConsultoraID as ConsultoraID,
    isnull(@PrimerNombre,'') as PrimerNombre,
    @MontoMinimoPedido as MontoMinimoPedido,
    @MontoMaximoPedido as MontoMaximoPedido,
    isnull(@IdEstadoActividad,0) as ConsultoraNueva,
    isnull(U.TipoUsuario,0) as TipoUsuario,
    U.CodigoConsultora,
    U.CodigoUsuario,
    U.Nombre as NombreCompleto,
    isnull(U.Email,'') as Email,
    @UsuarioPrueba as UsuarioPrueba,
    isnull(R.RegionID,0) as RegionID,
    isnull(R.Codigo,'') as CodigorRegion,
    isnull(Z.ZonaID,0) as ZonaID,
    isnull(Z.Codigo,'') as CodigoZona,
    isnull(@ConsultoraAsociadoID,0) as ConsultoraAsociadoID,
    @ConsultoraAsociada as ConsultoraAsociada,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(P.TipoDA = 0,oCr.FechaInicioFacturacion,ISNULL(Cr.FechaInicioWeb, oCr.FechaInicioFacturacion)),
      IIF(@AceptacionConsultoraDA < 1, oCr.FechaInicioFacturacion, Cr.FechaInicioWeb)
    ) as FechaInicioFacturacion,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(
        P.TipoDA = 0,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        IIF(
          @PaisID = 4,
          ISNULL(Cr.FechaInicioDD,oCr.FechaInicioReFacturacion),
          ISNULL(Cr.FechaInicioWeb,oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0))
        )
      ),
      IIF(
        @AceptacionConsultoraDA < 1,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        Cr.FechaInicioWeb
      )
    ) as FechaFinFacturacion,
    P.HoraCierreZonaNormal as HoraCierreZonaNormal,
    IIF(
      P.EsquemaDAConsultora <> 0 AND @AceptacionConsultoraDA < 1,
      P.HoraCierreZonaNormal,
      P.HoraCierreZonaDemAnti
    ) as HoraCierreZonaDemAnti,   
    IIF(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(Cr.CampaniaId,0) = 0, 0, 1),
      iif(@AceptacionConsultoraDA = 0 or isnull(Cr.CampaniaId,0) = 0,0,1)
    ) as EsZonaDemAnti
  FROM Pais P (nolock)
  inner join ConfiguracionValidacion CV (nolock) on CV.PaisID = P.PaisID
  inner join Usuario U (nolock) on U.CodigoUsuario = @CodigoUsuario
  inner join UsuarioRol UR (nolock) ON U.CodigoUsuario = UR.CodigoUsuario
  inner join Rol Ro with(nolock) ON UR.RolID = Ro.RolID
  inner join ods.Region R (nolock) on R.RegionID = @RegionID
  inner join ods.Zona Z (nolock) on Z.ZonaID = @ZonaID
  inner join ods.Cronograma oCr (nolock) on oCr.ZonaID = @ZonaID AND oCr.RegionID = @RegionID
  inner join ods.Campania Ca (nolock) on oCr.CampaniaID = Ca.CampaniaID
  left join Cronograma Cr (nolock) on oCr.RegionID = Cr.RegionID and oCr.ZonaID = Cr.ZonaID and oCr.CampaniaID = Cr.CampaniaID
  WHERE P.PaisID = @PaisID and Ro.Sistema = 1 and Ca.Codigo = @Campania;
END

GO
USE [BelcorpColombia]
GO

/****** Object:  StoredProcedure [dbo].[GetConfiguracionByUsuarioAndCampania]    Script Date: 21/03/2019 11:22:13 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[GetConfiguracionByUsuarioAndCampania]
  @PaisID tinyint,
  @ConsultoraID bigint,
  @Campania int,
  @UsuarioPrueba bit,
  @AceptacionConsultoraDA int
AS
BEGIN
  declare @ZonaID int;
  declare @RegionID int;
  declare @CodigoUsuario varchar(20);
  declare @PrimerNombre varchar(25);
  declare @MontoMinimoPedido numeric(15,2);
  declare @MontoMaximoPedido numeric(15,2);
  declare @IdEstadoActividad int;
  declare @ConsultoraAsociadoID bigint;
  declare @ConsultoraAsociada varchar(20);
  declare @EsPostulante bit = 0;
    
  select top 1
    @EsPostulante = 1,
    @ZonaID = CP.ZonaID, -- ¿Siempre está lleno este campo o hago join con el Zona de UsuarioPostulante?
    @RegionID = CP.RegionID, -- ¿Siempre está lleno este campo o hago join con la Region de UsuarioPostulante?
    @CodigoUsuario = CP.Codigo,
    @PrimerNombre = CP.PrimerNombre
  from ConsultoraPostulante CP (nolock)
  inner join UsuarioPostulante UP (nolock) on UP.CodigoUsuario = CP.Codigo and UP.Estado = 1 -- inner o left
  where CP.ConsultoraID = @ConsultoraID and UP.UsuarioReal = 0;

  IF @EsPostulante = 0
  BEGIN
    IF @UsuarioPrueba = 0
    BEGIN
      select
        @ZonaID = C.ZonaID,
        @RegionID = C.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = C.PrimerNombre,
        @MontoMinimoPedido = C.MontoMinimoPedido,
        @MontoMaximoPedido = C.MontoMaximoPedido,
        @IdEstadoActividad = C.IdEstadoActividad
      from ods.Consultora C (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = C.Codigo
      where ConsultoraID = @ConsultoraID;
    END
    ELSE
    BEGIN
      select
        @ZonaID = CF.ZonaID,
        @RegionID = CF.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = CF.PrimerNombre,
        @MontoMinimoPedido = CF.MontoMinimoPedido,
        @MontoMaximoPedido = CF.MontoMaximoPedido,
        @IdEstadoActividad = CF.IdEstadoActividad,
        @ConsultoraAsociadoID = C.ConsultoraID,
        @ConsultoraAsociada = C.Codigo
      from ConsultoraFicticia CF (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = CF.Codigo
      left join usuarioprueba UP (nolock) on U.CodigoUsuario = UP.CodigoUsuario
      left join ods.Consultora C (nolock) on UP.CodigoConsultoraAsociada = C.Codigo
      where CF.ConsultoraID = @ConsultoraID;
    END
  END

  declare @DiasDuracionCronograma tinyint = 1;  
  declare @ZonaValida int;
  declare @IndicadorDias bit = 0;

  select
    @DiasDuracionCronograma = DiasDuracionCronograma,
    @ZonaValida = ZonaID,
    @IndicadorDias = ValidacionActiva
  from ConfiguracionValidacionZona with(nolock)
  where ZonaID = @ZonaID;

  -- Dias Duracion Cronograma para Nuevas (CR)
  IF @EsPostulante = 0 and @DiasDuracionCronograma > 1 and @PaisID in (5,7,8,10)
  BEGIN
    declare @UCF int = 0, @SID int = 0;
    select
      @UCF = isnull(UltimaCampanaFacturada,0),
      @SID = isnull(SegmentoId,0)
    from ods.Consultora with(nolock)
    where ConsultoraID = @ConsultoraID;

    IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
      SET @DiasDuracionCronograma = 2
  END

  select
    P.PaisID,
    P.CodigoISO,
    isnull(P.TieneHana,0) as TieneHana,
    P.Simbolo,
    P.EstadoSimplificacionCUV,
    isnull(P.ZonaHoraria,0) as ZonaHoraria,
    P.PROLSinStock,
    P.NuevoPROL,
    isnull(p.TieneODD,0) as TieneODD,
    iif(
      P.NuevoPROL = 0,
      0,
      isnull((select top 1 1 from ConfiguracionValidacionNuevoPROL with(nolock) where ZonaId = @ZonaId), 0)
    ) as ZonaNuevoPROL,
    iif(
      P.EsquemaDAConsultora = 0 or @AceptacionConsultoraDA < 1,
      isnull(@ZonaValida,-1),
      -1
    ) as ZonaValida,
    iif(@IndicadorDias = 0, 0, CV.DiasAntes) as DiasAntes,
    CV.HoraInicio,
    iif(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(cr.CampaniaId,0) = 0, CV.HoraFin, P.HoraCierreZonaDemAnti),
      iif(@AceptacionConsultoraDA < 1, CV.HoraFin, P.HoraCierreZonaDemAnti)
    ) as HoraFin,
    CV.HoraInicioNoFacturable,
    CV.HoraCierreNoFacturable,
    iif(@EsPostulante = 0,CV.ValidacionInteractiva,0) as ValidacionInteractiva,
    CV.HabilitarRestriccionHoraria,
    isnull(CV.HorasDuracionRestriccion,0) as HorasDuracionRestriccion,
    @Campania as CampaniaID,
    @ConsultoraID as ConsultoraID,
    isnull(@PrimerNombre,'') as PrimerNombre,
    @MontoMinimoPedido as MontoMinimoPedido,
    @MontoMaximoPedido as MontoMaximoPedido,
    isnull(@IdEstadoActividad,0) as ConsultoraNueva,
    isnull(U.TipoUsuario,0) as TipoUsuario,
    U.CodigoConsultora,
    U.CodigoUsuario,
    U.Nombre as NombreCompleto,
    isnull(U.Email,'') as Email,
    @UsuarioPrueba as UsuarioPrueba,
    isnull(R.RegionID,0) as RegionID,
    isnull(R.Codigo,'') as CodigorRegion,
    isnull(Z.ZonaID,0) as ZonaID,
    isnull(Z.Codigo,'') as CodigoZona,
    isnull(@ConsultoraAsociadoID,0) as ConsultoraAsociadoID,
    @ConsultoraAsociada as ConsultoraAsociada,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(P.TipoDA = 0,oCr.FechaInicioFacturacion,ISNULL(Cr.FechaInicioWeb, oCr.FechaInicioFacturacion)),
      IIF(@AceptacionConsultoraDA < 1, oCr.FechaInicioFacturacion, Cr.FechaInicioWeb)
    ) as FechaInicioFacturacion,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(
        P.TipoDA = 0,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        IIF(
          @PaisID = 4,
          ISNULL(Cr.FechaInicioDD,oCr.FechaInicioReFacturacion),
          ISNULL(Cr.FechaInicioWeb,oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0))
        )
      ),
      IIF(
        @AceptacionConsultoraDA < 1,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        Cr.FechaInicioWeb
      )
    ) as FechaFinFacturacion,
    P.HoraCierreZonaNormal as HoraCierreZonaNormal,
    IIF(
      P.EsquemaDAConsultora <> 0 AND @AceptacionConsultoraDA < 1,
      P.HoraCierreZonaNormal,
      P.HoraCierreZonaDemAnti
    ) as HoraCierreZonaDemAnti,   
    IIF(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(Cr.CampaniaId,0) = 0, 0, 1),
      iif(@AceptacionConsultoraDA = 0 or isnull(Cr.CampaniaId,0) = 0,0,1)
    ) as EsZonaDemAnti
  FROM Pais P (nolock)
  inner join ConfiguracionValidacion CV (nolock) on CV.PaisID = P.PaisID
  inner join Usuario U (nolock) on U.CodigoUsuario = @CodigoUsuario
  inner join UsuarioRol UR (nolock) ON U.CodigoUsuario = UR.CodigoUsuario
  inner join Rol Ro with(nolock) ON UR.RolID = Ro.RolID
  inner join ods.Region R (nolock) on R.RegionID = @RegionID
  inner join ods.Zona Z (nolock) on Z.ZonaID = @ZonaID
  inner join ods.Cronograma oCr (nolock) on oCr.ZonaID = @ZonaID AND oCr.RegionID = @RegionID
  inner join ods.Campania Ca (nolock) on oCr.CampaniaID = Ca.CampaniaID
  left join Cronograma Cr (nolock) on oCr.RegionID = Cr.RegionID and oCr.ZonaID = Cr.ZonaID and oCr.CampaniaID = Cr.CampaniaID
  WHERE P.PaisID = @PaisID and Ro.Sistema = 1 and Ca.Codigo = @Campania;
END

GO

USE [BelcorpCostaRica]
GO

/****** Object:  StoredProcedure [dbo].[GetConfiguracionByUsuarioAndCampania]    Script Date: 21/03/2019 11:29:13 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[GetConfiguracionByUsuarioAndCampania]
  @PaisID tinyint,
  @ConsultoraID bigint,
  @Campania int,
  @UsuarioPrueba bit,
  @AceptacionConsultoraDA int
AS
BEGIN
  declare @ZonaID int;
  declare @RegionID int;
  declare @CodigoUsuario varchar(20);
  declare @PrimerNombre varchar(25);
  declare @MontoMinimoPedido numeric(15,2);
  declare @MontoMaximoPedido numeric(15,2);
  declare @IdEstadoActividad int;
  declare @ConsultoraAsociadoID bigint;
  declare @ConsultoraAsociada varchar(20);
  declare @EsPostulante bit = 0;
    
  select top 1
    @EsPostulante = 1,
    @ZonaID = CP.ZonaID, -- ¿Siempre está lleno este campo o hago join con el Zona de UsuarioPostulante?
    @RegionID = CP.RegionID, -- ¿Siempre está lleno este campo o hago join con la Region de UsuarioPostulante?
    @CodigoUsuario = CP.Codigo,
    @PrimerNombre = CP.PrimerNombre
  from ConsultoraPostulante CP (nolock)
  inner join UsuarioPostulante UP (nolock) on UP.CodigoUsuario = CP.Codigo and UP.Estado = 1 -- inner o left
  where CP.ConsultoraID = @ConsultoraID and UP.UsuarioReal = 0;

  IF @EsPostulante = 0
  BEGIN
    IF @UsuarioPrueba = 0
    BEGIN
      select
        @ZonaID = C.ZonaID,
        @RegionID = C.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = C.PrimerNombre,
        @MontoMinimoPedido = C.MontoMinimoPedido,
        @MontoMaximoPedido = C.MontoMaximoPedido,
        @IdEstadoActividad = C.IdEstadoActividad
      from ods.Consultora C (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = C.Codigo
      where ConsultoraID = @ConsultoraID;
    END
    ELSE
    BEGIN
      select
        @ZonaID = CF.ZonaID,
        @RegionID = CF.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = CF.PrimerNombre,
        @MontoMinimoPedido = CF.MontoMinimoPedido,
        @MontoMaximoPedido = CF.MontoMaximoPedido,
        @IdEstadoActividad = CF.IdEstadoActividad,
        @ConsultoraAsociadoID = C.ConsultoraID,
        @ConsultoraAsociada = C.Codigo
      from ConsultoraFicticia CF (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = CF.Codigo
      left join usuarioprueba UP (nolock) on U.CodigoUsuario = UP.CodigoUsuario
      left join ods.Consultora C (nolock) on UP.CodigoConsultoraAsociada = C.Codigo
      where CF.ConsultoraID = @ConsultoraID;
    END
  END

  declare @DiasDuracionCronograma tinyint = 1;  
  declare @ZonaValida int;
  declare @IndicadorDias bit = 0;

  select
    @DiasDuracionCronograma = DiasDuracionCronograma,
    @ZonaValida = ZonaID,
    @IndicadorDias = ValidacionActiva
  from ConfiguracionValidacionZona with(nolock)
  where ZonaID = @ZonaID;

  -- Dias Duracion Cronograma para Nuevas (CR)
  IF @EsPostulante = 0 and @DiasDuracionCronograma > 1 and @PaisID in (5,7,8,10)
  BEGIN
    declare @UCF int = 0, @SID int = 0;
    select
      @UCF = isnull(UltimaCampanaFacturada,0),
      @SID = isnull(SegmentoId,0)
    from ods.Consultora with(nolock)
    where ConsultoraID = @ConsultoraID;

    IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
      SET @DiasDuracionCronograma = 2
  END

  select
    P.PaisID,
    P.CodigoISO,
    isnull(P.TieneHana,0) as TieneHana,
    P.Simbolo,
    P.EstadoSimplificacionCUV,
    isnull(P.ZonaHoraria,0) as ZonaHoraria,
    P.PROLSinStock,
    P.NuevoPROL,
    isnull(p.TieneODD,0) as TieneODD,
    iif(
      P.NuevoPROL = 0,
      0,
      isnull((select top 1 1 from ConfiguracionValidacionNuevoPROL with(nolock) where ZonaId = @ZonaId), 0)
    ) as ZonaNuevoPROL,
    iif(
      P.EsquemaDAConsultora = 0 or @AceptacionConsultoraDA < 1,
      isnull(@ZonaValida,-1),
      -1
    ) as ZonaValida,
    iif(@IndicadorDias = 0, 0, CV.DiasAntes) as DiasAntes,
    CV.HoraInicio,
    iif(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(cr.CampaniaId,0) = 0, CV.HoraFin, P.HoraCierreZonaDemAnti),
      iif(@AceptacionConsultoraDA < 1, CV.HoraFin, P.HoraCierreZonaDemAnti)
    ) as HoraFin,
    CV.HoraInicioNoFacturable,
    CV.HoraCierreNoFacturable,
    iif(@EsPostulante = 0,CV.ValidacionInteractiva,0) as ValidacionInteractiva,
    CV.HabilitarRestriccionHoraria,
    isnull(CV.HorasDuracionRestriccion,0) as HorasDuracionRestriccion,
    @Campania as CampaniaID,
    @ConsultoraID as ConsultoraID,
    isnull(@PrimerNombre,'') as PrimerNombre,
    @MontoMinimoPedido as MontoMinimoPedido,
    @MontoMaximoPedido as MontoMaximoPedido,
    isnull(@IdEstadoActividad,0) as ConsultoraNueva,
    isnull(U.TipoUsuario,0) as TipoUsuario,
    U.CodigoConsultora,
    U.CodigoUsuario,
    U.Nombre as NombreCompleto,
    isnull(U.Email,'') as Email,
    @UsuarioPrueba as UsuarioPrueba,
    isnull(R.RegionID,0) as RegionID,
    isnull(R.Codigo,'') as CodigorRegion,
    isnull(Z.ZonaID,0) as ZonaID,
    isnull(Z.Codigo,'') as CodigoZona,
    isnull(@ConsultoraAsociadoID,0) as ConsultoraAsociadoID,
    @ConsultoraAsociada as ConsultoraAsociada,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(P.TipoDA = 0,oCr.FechaInicioFacturacion,ISNULL(Cr.FechaInicioWeb, oCr.FechaInicioFacturacion)),
      IIF(@AceptacionConsultoraDA < 1, oCr.FechaInicioFacturacion, Cr.FechaInicioWeb)
    ) as FechaInicioFacturacion,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(
        P.TipoDA = 0,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        IIF(
          @PaisID = 4,
          ISNULL(Cr.FechaInicioDD,oCr.FechaInicioReFacturacion),
          ISNULL(Cr.FechaInicioWeb,oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0))
        )
      ),
      IIF(
        @AceptacionConsultoraDA < 1,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        Cr.FechaInicioWeb
      )
    ) as FechaFinFacturacion,
    P.HoraCierreZonaNormal as HoraCierreZonaNormal,
    IIF(
      P.EsquemaDAConsultora <> 0 AND @AceptacionConsultoraDA < 1,
      P.HoraCierreZonaNormal,
      P.HoraCierreZonaDemAnti
    ) as HoraCierreZonaDemAnti,   
    IIF(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(Cr.CampaniaId,0) = 0, 0, 1),
      iif(@AceptacionConsultoraDA = 0 or isnull(Cr.CampaniaId,0) = 0,0,1)
    ) as EsZonaDemAnti
  FROM Pais P (nolock)
  inner join ConfiguracionValidacion CV (nolock) on CV.PaisID = P.PaisID
  inner join Usuario U (nolock) on U.CodigoUsuario = @CodigoUsuario
  inner join UsuarioRol UR (nolock) ON U.CodigoUsuario = UR.CodigoUsuario
  inner join Rol Ro with(nolock) ON UR.RolID = Ro.RolID
  inner join ods.Region R (nolock) on R.RegionID = @RegionID
  inner join ods.Zona Z (nolock) on Z.ZonaID = @ZonaID
  inner join ods.Cronograma oCr (nolock) on oCr.ZonaID = @ZonaID AND oCr.RegionID = @RegionID
  inner join ods.Campania Ca (nolock) on oCr.CampaniaID = Ca.CampaniaID
  left join Cronograma Cr (nolock) on oCr.RegionID = Cr.RegionID and oCr.ZonaID = Cr.ZonaID and oCr.CampaniaID = Cr.CampaniaID
  WHERE P.PaisID = @PaisID and Ro.Sistema = 1 and Ca.Codigo = @Campania;
END

GO

USE [BelcorpDominicana]
GO

/****** Object:  StoredProcedure [dbo].[GetConfiguracionByUsuarioAndCampania]    Script Date: 21/03/2019 11:46:47 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[GetConfiguracionByUsuarioAndCampania]
  @PaisID tinyint,
  @ConsultoraID bigint,
  @Campania int,
  @UsuarioPrueba bit,
  @AceptacionConsultoraDA int
AS
BEGIN
  declare @ZonaID int;
  declare @RegionID int;
  declare @CodigoUsuario varchar(20);
  declare @PrimerNombre varchar(25);
  declare @MontoMinimoPedido numeric(15,2);
  declare @MontoMaximoPedido numeric(15,2);
  declare @IdEstadoActividad int;
  declare @ConsultoraAsociadoID bigint;
  declare @ConsultoraAsociada varchar(20);
  declare @EsPostulante bit = 0;
    
  select top 1
    @EsPostulante = 1,
    @ZonaID = CP.ZonaID, -- ¿Siempre está lleno este campo o hago join con el Zona de UsuarioPostulante?
    @RegionID = CP.RegionID, -- ¿Siempre está lleno este campo o hago join con la Region de UsuarioPostulante?
    @CodigoUsuario = CP.Codigo,
    @PrimerNombre = CP.PrimerNombre
  from ConsultoraPostulante CP (nolock)
  inner join UsuarioPostulante UP (nolock) on UP.CodigoUsuario = CP.Codigo and UP.Estado = 1 -- inner o left
  where CP.ConsultoraID = @ConsultoraID and UP.UsuarioReal = 0;

  IF @EsPostulante = 0
  BEGIN
    IF @UsuarioPrueba = 0
    BEGIN
      select
        @ZonaID = C.ZonaID,
        @RegionID = C.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = C.PrimerNombre,
        @MontoMinimoPedido = C.MontoMinimoPedido,
        @MontoMaximoPedido = C.MontoMaximoPedido,
        @IdEstadoActividad = C.IdEstadoActividad
      from ods.Consultora C (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = C.Codigo
      where ConsultoraID = @ConsultoraID;
    END
    ELSE
    BEGIN
      select
        @ZonaID = CF.ZonaID,
        @RegionID = CF.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = CF.PrimerNombre,
        @MontoMinimoPedido = CF.MontoMinimoPedido,
        @MontoMaximoPedido = CF.MontoMaximoPedido,
        @IdEstadoActividad = CF.IdEstadoActividad,
        @ConsultoraAsociadoID = C.ConsultoraID,
        @ConsultoraAsociada = C.Codigo
      from ConsultoraFicticia CF (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = CF.Codigo
      left join usuarioprueba UP (nolock) on U.CodigoUsuario = UP.CodigoUsuario
      left join ods.Consultora C (nolock) on UP.CodigoConsultoraAsociada = C.Codigo
      where CF.ConsultoraID = @ConsultoraID;
    END
  END

  declare @DiasDuracionCronograma tinyint = 1;  
  declare @ZonaValida int;
  declare @IndicadorDias bit = 0;

  select
    @DiasDuracionCronograma = DiasDuracionCronograma,
    @ZonaValida = ZonaID,
    @IndicadorDias = ValidacionActiva
  from ConfiguracionValidacionZona with(nolock)
  where ZonaID = @ZonaID;

  -- Dias Duracion Cronograma para Nuevas (CR)
  IF @EsPostulante = 0 and @DiasDuracionCronograma > 1 and @PaisID in (5,7,8,10)
  BEGIN
    declare @UCF int = 0, @SID int = 0;
    select
      @UCF = isnull(UltimaCampanaFacturada,0),
      @SID = isnull(SegmentoId,0)
    from ods.Consultora with(nolock)
    where ConsultoraID = @ConsultoraID;

    IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
      SET @DiasDuracionCronograma = 2
  END

  select
    P.PaisID,
    P.CodigoISO,
    isnull(P.TieneHana,0) as TieneHana,
    P.Simbolo,
    P.EstadoSimplificacionCUV,
    isnull(P.ZonaHoraria,0) as ZonaHoraria,
    P.PROLSinStock,
    P.NuevoPROL,
    isnull(p.TieneODD,0) as TieneODD,
    iif(
      P.NuevoPROL = 0,
      0,
      isnull((select top 1 1 from ConfiguracionValidacionNuevoPROL with(nolock) where ZonaId = @ZonaId), 0)
    ) as ZonaNuevoPROL,
    iif(
      P.EsquemaDAConsultora = 0 or @AceptacionConsultoraDA < 1,
      isnull(@ZonaValida,-1),
      -1
    ) as ZonaValida,
    iif(@IndicadorDias = 0, 0, CV.DiasAntes) as DiasAntes,
    CV.HoraInicio,
    iif(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(cr.CampaniaId,0) = 0, CV.HoraFin, P.HoraCierreZonaDemAnti),
      iif(@AceptacionConsultoraDA < 1, CV.HoraFin, P.HoraCierreZonaDemAnti)
    ) as HoraFin,
    CV.HoraInicioNoFacturable,
    CV.HoraCierreNoFacturable,
    iif(@EsPostulante = 0,CV.ValidacionInteractiva,0) as ValidacionInteractiva,
    CV.HabilitarRestriccionHoraria,
    isnull(CV.HorasDuracionRestriccion,0) as HorasDuracionRestriccion,
    @Campania as CampaniaID,
    @ConsultoraID as ConsultoraID,
    isnull(@PrimerNombre,'') as PrimerNombre,
    @MontoMinimoPedido as MontoMinimoPedido,
    @MontoMaximoPedido as MontoMaximoPedido,
    isnull(@IdEstadoActividad,0) as ConsultoraNueva,
    isnull(U.TipoUsuario,0) as TipoUsuario,
    U.CodigoConsultora,
    U.CodigoUsuario,
    U.Nombre as NombreCompleto,
    isnull(U.Email,'') as Email,
    @UsuarioPrueba as UsuarioPrueba,
    isnull(R.RegionID,0) as RegionID,
    isnull(R.Codigo,'') as CodigorRegion,
    isnull(Z.ZonaID,0) as ZonaID,
    isnull(Z.Codigo,'') as CodigoZona,
    isnull(@ConsultoraAsociadoID,0) as ConsultoraAsociadoID,
    @ConsultoraAsociada as ConsultoraAsociada,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(P.TipoDA = 0,oCr.FechaInicioFacturacion,ISNULL(Cr.FechaInicioWeb, oCr.FechaInicioFacturacion)),
      IIF(@AceptacionConsultoraDA < 1, oCr.FechaInicioFacturacion, Cr.FechaInicioWeb)
    ) as FechaInicioFacturacion,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(
        P.TipoDA = 0,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        IIF(
          @PaisID = 4,
          ISNULL(Cr.FechaInicioDD,oCr.FechaInicioReFacturacion),
          ISNULL(Cr.FechaInicioWeb,oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0))
        )
      ),
      IIF(
        @AceptacionConsultoraDA < 1,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        Cr.FechaInicioWeb
      )
    ) as FechaFinFacturacion,
    P.HoraCierreZonaNormal as HoraCierreZonaNormal,
    IIF(
      P.EsquemaDAConsultora <> 0 AND @AceptacionConsultoraDA < 1,
      P.HoraCierreZonaNormal,
      P.HoraCierreZonaDemAnti
    ) as HoraCierreZonaDemAnti,   
    IIF(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(Cr.CampaniaId,0) = 0, 0, 1),
      iif(@AceptacionConsultoraDA = 0 or isnull(Cr.CampaniaId,0) = 0,0,1)
    ) as EsZonaDemAnti
  FROM Pais P (nolock)
  inner join ConfiguracionValidacion CV (nolock) on CV.PaisID = P.PaisID
  inner join Usuario U (nolock) on U.CodigoUsuario = @CodigoUsuario
  inner join UsuarioRol UR (nolock) ON U.CodigoUsuario = UR.CodigoUsuario
  inner join Rol Ro with(nolock) ON UR.RolID = Ro.RolID
  inner join ods.Region R (nolock) on R.RegionID = @RegionID
  inner join ods.Zona Z (nolock) on Z.ZonaID = @ZonaID
  inner join ods.Cronograma oCr (nolock) on oCr.ZonaID = @ZonaID AND oCr.RegionID = @RegionID
  inner join ods.Campania Ca (nolock) on oCr.CampaniaID = Ca.CampaniaID
  left join Cronograma Cr (nolock) on oCr.RegionID = Cr.RegionID and oCr.ZonaID = Cr.ZonaID and oCr.CampaniaID = Cr.CampaniaID
  WHERE P.PaisID = @PaisID and Ro.Sistema = 1 and Ca.Codigo = @Campania;
END

GO

USE [BelcorpEcuador]
GO

/****** Object:  StoredProcedure [dbo].[GetConfiguracionByUsuarioAndCampania]    Script Date: 21/03/2019 11:56:56 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[GetConfiguracionByUsuarioAndCampania]
  @PaisID tinyint,
  @ConsultoraID bigint,
  @Campania int,
  @UsuarioPrueba bit,
  @AceptacionConsultoraDA int
AS
BEGIN
  declare @ZonaID int;
  declare @RegionID int;
  declare @CodigoUsuario varchar(20);
  declare @PrimerNombre varchar(25);
  declare @MontoMinimoPedido numeric(15,2);
  declare @MontoMaximoPedido numeric(15,2);
  declare @IdEstadoActividad int;
  declare @ConsultoraAsociadoID bigint;
  declare @ConsultoraAsociada varchar(20);
  declare @EsPostulante bit = 0;
    
  select top 1
    @EsPostulante = 1,
    @ZonaID = CP.ZonaID, -- ¿Siempre está lleno este campo o hago join con el Zona de UsuarioPostulante?
    @RegionID = CP.RegionID, -- ¿Siempre está lleno este campo o hago join con la Region de UsuarioPostulante?
    @CodigoUsuario = CP.Codigo,
    @PrimerNombre = CP.PrimerNombre
  from ConsultoraPostulante CP (nolock)
  inner join UsuarioPostulante UP (nolock) on UP.CodigoUsuario = CP.Codigo and UP.Estado = 1 -- inner o left
  where CP.ConsultoraID = @ConsultoraID and UP.UsuarioReal = 0;

  IF @EsPostulante = 0
  BEGIN
    IF @UsuarioPrueba = 0
    BEGIN
      select
        @ZonaID = C.ZonaID,
        @RegionID = C.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = C.PrimerNombre,
        @MontoMinimoPedido = C.MontoMinimoPedido,
        @MontoMaximoPedido = C.MontoMaximoPedido,
        @IdEstadoActividad = C.IdEstadoActividad
      from ods.Consultora C (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = C.Codigo
      where ConsultoraID = @ConsultoraID;
    END
    ELSE
    BEGIN
      select
        @ZonaID = CF.ZonaID,
        @RegionID = CF.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = CF.PrimerNombre,
        @MontoMinimoPedido = CF.MontoMinimoPedido,
        @MontoMaximoPedido = CF.MontoMaximoPedido,
        @IdEstadoActividad = CF.IdEstadoActividad,
        @ConsultoraAsociadoID = C.ConsultoraID,
        @ConsultoraAsociada = C.Codigo
      from ConsultoraFicticia CF (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = CF.Codigo
      left join usuarioprueba UP (nolock) on U.CodigoUsuario = UP.CodigoUsuario
      left join ods.Consultora C (nolock) on UP.CodigoConsultoraAsociada = C.Codigo
      where CF.ConsultoraID = @ConsultoraID;
    END
  END

  declare @DiasDuracionCronograma tinyint = 1;  
  declare @ZonaValida int;
  declare @IndicadorDias bit = 0;

  select
    @DiasDuracionCronograma = DiasDuracionCronograma,
    @ZonaValida = ZonaID,
    @IndicadorDias = ValidacionActiva
  from ConfiguracionValidacionZona with(nolock)
  where ZonaID = @ZonaID;

  -- Dias Duracion Cronograma para Nuevas (CR)
  IF @EsPostulante = 0 and @DiasDuracionCronograma > 1 and @PaisID in (5,7,8,10)
  BEGIN
    declare @UCF int = 0, @SID int = 0;
    select
      @UCF = isnull(UltimaCampanaFacturada,0),
      @SID = isnull(SegmentoId,0)
    from ods.Consultora with(nolock)
    where ConsultoraID = @ConsultoraID;

    IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
      SET @DiasDuracionCronograma = 2
  END

  select
    P.PaisID,
    P.CodigoISO,
    isnull(P.TieneHana,0) as TieneHana,
    P.Simbolo,
    P.EstadoSimplificacionCUV,
    isnull(P.ZonaHoraria,0) as ZonaHoraria,
    P.PROLSinStock,
    P.NuevoPROL,
    isnull(p.TieneODD,0) as TieneODD,
    iif(
      P.NuevoPROL = 0,
      0,
      isnull((select top 1 1 from ConfiguracionValidacionNuevoPROL with(nolock) where ZonaId = @ZonaId), 0)
    ) as ZonaNuevoPROL,
    iif(
      P.EsquemaDAConsultora = 0 or @AceptacionConsultoraDA < 1,
      isnull(@ZonaValida,-1),
      -1
    ) as ZonaValida,
    iif(@IndicadorDias = 0, 0, CV.DiasAntes) as DiasAntes,
    CV.HoraInicio,
    iif(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(cr.CampaniaId,0) = 0, CV.HoraFin, P.HoraCierreZonaDemAnti),
      iif(@AceptacionConsultoraDA < 1, CV.HoraFin, P.HoraCierreZonaDemAnti)
    ) as HoraFin,
    CV.HoraInicioNoFacturable,
    CV.HoraCierreNoFacturable,
    iif(@EsPostulante = 0,CV.ValidacionInteractiva,0) as ValidacionInteractiva,
    CV.HabilitarRestriccionHoraria,
    isnull(CV.HorasDuracionRestriccion,0) as HorasDuracionRestriccion,
    @Campania as CampaniaID,
    @ConsultoraID as ConsultoraID,
    isnull(@PrimerNombre,'') as PrimerNombre,
    @MontoMinimoPedido as MontoMinimoPedido,
    @MontoMaximoPedido as MontoMaximoPedido,
    isnull(@IdEstadoActividad,0) as ConsultoraNueva,
    isnull(U.TipoUsuario,0) as TipoUsuario,
    U.CodigoConsultora,
    U.CodigoUsuario,
    U.Nombre as NombreCompleto,
    isnull(U.Email,'') as Email,
    @UsuarioPrueba as UsuarioPrueba,
    isnull(R.RegionID,0) as RegionID,
    isnull(R.Codigo,'') as CodigorRegion,
    isnull(Z.ZonaID,0) as ZonaID,
    isnull(Z.Codigo,'') as CodigoZona,
    isnull(@ConsultoraAsociadoID,0) as ConsultoraAsociadoID,
    @ConsultoraAsociada as ConsultoraAsociada,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(P.TipoDA = 0,oCr.FechaInicioFacturacion,ISNULL(Cr.FechaInicioWeb, oCr.FechaInicioFacturacion)),
      IIF(@AceptacionConsultoraDA < 1, oCr.FechaInicioFacturacion, Cr.FechaInicioWeb)
    ) as FechaInicioFacturacion,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(
        P.TipoDA = 0,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        IIF(
          @PaisID = 4,
          ISNULL(Cr.FechaInicioDD,oCr.FechaInicioReFacturacion),
          ISNULL(Cr.FechaInicioWeb,oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0))
        )
      ),
      IIF(
        @AceptacionConsultoraDA < 1,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        Cr.FechaInicioWeb
      )
    ) as FechaFinFacturacion,
    P.HoraCierreZonaNormal as HoraCierreZonaNormal,
    IIF(
      P.EsquemaDAConsultora <> 0 AND @AceptacionConsultoraDA < 1,
      P.HoraCierreZonaNormal,
      P.HoraCierreZonaDemAnti
    ) as HoraCierreZonaDemAnti,   
    IIF(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(Cr.CampaniaId,0) = 0, 0, 1),
      iif(@AceptacionConsultoraDA = 0 or isnull(Cr.CampaniaId,0) = 0,0,1)
    ) as EsZonaDemAnti
  FROM Pais P (nolock)
  inner join ConfiguracionValidacion CV (nolock) on CV.PaisID = P.PaisID
  inner join Usuario U (nolock) on U.CodigoUsuario = @CodigoUsuario
  inner join UsuarioRol UR (nolock) ON U.CodigoUsuario = UR.CodigoUsuario
  inner join Rol Ro with(nolock) ON UR.RolID = Ro.RolID
  inner join ods.Region R (nolock) on R.RegionID = @RegionID
  inner join ods.Zona Z (nolock) on Z.ZonaID = @ZonaID
  inner join ods.Cronograma oCr (nolock) on oCr.ZonaID = @ZonaID AND oCr.RegionID = @RegionID
  inner join ods.Campania Ca (nolock) on oCr.CampaniaID = Ca.CampaniaID
  left join Cronograma Cr (nolock) on oCr.RegionID = Cr.RegionID and oCr.ZonaID = Cr.ZonaID and oCr.CampaniaID = Cr.CampaniaID
  WHERE P.PaisID = @PaisID and Ro.Sistema = 1 and Ca.Codigo = @Campania;
END

GO
USE [BelcorpGuatemala]
GO

/****** Object:  StoredProcedure [dbo].[GetConfiguracionByUsuarioAndCampania]    Script Date: 21/03/2019 12:04:59 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[GetConfiguracionByUsuarioAndCampania]
  @PaisID tinyint,
  @ConsultoraID bigint,
  @Campania int,
  @UsuarioPrueba bit,
  @AceptacionConsultoraDA int
AS
BEGIN
  declare @ZonaID int;
  declare @RegionID int;
  declare @CodigoUsuario varchar(20);
  declare @PrimerNombre varchar(25);
  declare @MontoMinimoPedido numeric(15,2);
  declare @MontoMaximoPedido numeric(15,2);
  declare @IdEstadoActividad int;
  declare @ConsultoraAsociadoID bigint;
  declare @ConsultoraAsociada varchar(20);
  declare @EsPostulante bit = 0;
    
  select top 1
    @EsPostulante = 1,
    @ZonaID = CP.ZonaID, -- ¿Siempre está lleno este campo o hago join con el Zona de UsuarioPostulante?
    @RegionID = CP.RegionID, -- ¿Siempre está lleno este campo o hago join con la Region de UsuarioPostulante?
    @CodigoUsuario = CP.Codigo,
    @PrimerNombre = CP.PrimerNombre
  from ConsultoraPostulante CP (nolock)
  inner join UsuarioPostulante UP (nolock) on UP.CodigoUsuario = CP.Codigo and UP.Estado = 1 -- inner o left
  where CP.ConsultoraID = @ConsultoraID and UP.UsuarioReal = 0;

  IF @EsPostulante = 0
  BEGIN
    IF @UsuarioPrueba = 0
    BEGIN
      select
        @ZonaID = C.ZonaID,
        @RegionID = C.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = C.PrimerNombre,
        @MontoMinimoPedido = C.MontoMinimoPedido,
        @MontoMaximoPedido = C.MontoMaximoPedido,
        @IdEstadoActividad = C.IdEstadoActividad
      from ods.Consultora C (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = C.Codigo
      where ConsultoraID = @ConsultoraID;
    END
    ELSE
    BEGIN
      select
        @ZonaID = CF.ZonaID,
        @RegionID = CF.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = CF.PrimerNombre,
        @MontoMinimoPedido = CF.MontoMinimoPedido,
        @MontoMaximoPedido = CF.MontoMaximoPedido,
        @IdEstadoActividad = CF.IdEstadoActividad,
        @ConsultoraAsociadoID = C.ConsultoraID,
        @ConsultoraAsociada = C.Codigo
      from ConsultoraFicticia CF (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = CF.Codigo
      left join usuarioprueba UP (nolock) on U.CodigoUsuario = UP.CodigoUsuario
      left join ods.Consultora C (nolock) on UP.CodigoConsultoraAsociada = C.Codigo
      where CF.ConsultoraID = @ConsultoraID;
    END
  END

  declare @DiasDuracionCronograma tinyint = 1;  
  declare @ZonaValida int;
  declare @IndicadorDias bit = 0;

  select
    @DiasDuracionCronograma = DiasDuracionCronograma,
    @ZonaValida = ZonaID,
    @IndicadorDias = ValidacionActiva
  from ConfiguracionValidacionZona with(nolock)
  where ZonaID = @ZonaID;

  -- Dias Duracion Cronograma para Nuevas (CR)
  IF @EsPostulante = 0 and @DiasDuracionCronograma > 1 and @PaisID in (5,7,8,10)
  BEGIN
    declare @UCF int = 0, @SID int = 0;
    select
      @UCF = isnull(UltimaCampanaFacturada,0),
      @SID = isnull(SegmentoId,0)
    from ods.Consultora with(nolock)
    where ConsultoraID = @ConsultoraID;

    IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
      SET @DiasDuracionCronograma = 2
  END

  select
    P.PaisID,
    P.CodigoISO,
    isnull(P.TieneHana,0) as TieneHana,
    P.Simbolo,
    P.EstadoSimplificacionCUV,
    isnull(P.ZonaHoraria,0) as ZonaHoraria,
    P.PROLSinStock,
    P.NuevoPROL,
    isnull(p.TieneODD,0) as TieneODD,
    iif(
      P.NuevoPROL = 0,
      0,
      isnull((select top 1 1 from ConfiguracionValidacionNuevoPROL with(nolock) where ZonaId = @ZonaId), 0)
    ) as ZonaNuevoPROL,
    iif(
      P.EsquemaDAConsultora = 0 or @AceptacionConsultoraDA < 1,
      isnull(@ZonaValida,-1),
      -1
    ) as ZonaValida,
    iif(@IndicadorDias = 0, 0, CV.DiasAntes) as DiasAntes,
    CV.HoraInicio,
    iif(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(cr.CampaniaId,0) = 0, CV.HoraFin, P.HoraCierreZonaDemAnti),
      iif(@AceptacionConsultoraDA < 1, CV.HoraFin, P.HoraCierreZonaDemAnti)
    ) as HoraFin,
    CV.HoraInicioNoFacturable,
    CV.HoraCierreNoFacturable,
    iif(@EsPostulante = 0,CV.ValidacionInteractiva,0) as ValidacionInteractiva,
    CV.HabilitarRestriccionHoraria,
    isnull(CV.HorasDuracionRestriccion,0) as HorasDuracionRestriccion,
    @Campania as CampaniaID,
    @ConsultoraID as ConsultoraID,
    isnull(@PrimerNombre,'') as PrimerNombre,
    @MontoMinimoPedido as MontoMinimoPedido,
    @MontoMaximoPedido as MontoMaximoPedido,
    isnull(@IdEstadoActividad,0) as ConsultoraNueva,
    isnull(U.TipoUsuario,0) as TipoUsuario,
    U.CodigoConsultora,
    U.CodigoUsuario,
    U.Nombre as NombreCompleto,
    isnull(U.Email,'') as Email,
    @UsuarioPrueba as UsuarioPrueba,
    isnull(R.RegionID,0) as RegionID,
    isnull(R.Codigo,'') as CodigorRegion,
    isnull(Z.ZonaID,0) as ZonaID,
    isnull(Z.Codigo,'') as CodigoZona,
    isnull(@ConsultoraAsociadoID,0) as ConsultoraAsociadoID,
    @ConsultoraAsociada as ConsultoraAsociada,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(P.TipoDA = 0,oCr.FechaInicioFacturacion,ISNULL(Cr.FechaInicioWeb, oCr.FechaInicioFacturacion)),
      IIF(@AceptacionConsultoraDA < 1, oCr.FechaInicioFacturacion, Cr.FechaInicioWeb)
    ) as FechaInicioFacturacion,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(
        P.TipoDA = 0,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        IIF(
          @PaisID = 4,
          ISNULL(Cr.FechaInicioDD,oCr.FechaInicioReFacturacion),
          ISNULL(Cr.FechaInicioWeb,oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0))
        )
      ),
      IIF(
        @AceptacionConsultoraDA < 1,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        Cr.FechaInicioWeb
      )
    ) as FechaFinFacturacion,
    P.HoraCierreZonaNormal as HoraCierreZonaNormal,
    IIF(
      P.EsquemaDAConsultora <> 0 AND @AceptacionConsultoraDA < 1,
      P.HoraCierreZonaNormal,
      P.HoraCierreZonaDemAnti
    ) as HoraCierreZonaDemAnti,   
    IIF(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(Cr.CampaniaId,0) = 0, 0, 1),
      iif(@AceptacionConsultoraDA = 0 or isnull(Cr.CampaniaId,0) = 0,0,1)
    ) as EsZonaDemAnti
  FROM Pais P (nolock)
  inner join ConfiguracionValidacion CV (nolock) on CV.PaisID = P.PaisID
  inner join Usuario U (nolock) on U.CodigoUsuario = @CodigoUsuario
  inner join UsuarioRol UR (nolock) ON U.CodigoUsuario = UR.CodigoUsuario
  inner join Rol Ro with(nolock) ON UR.RolID = Ro.RolID
  inner join ods.Region R (nolock) on R.RegionID = @RegionID
  inner join ods.Zona Z (nolock) on Z.ZonaID = @ZonaID
  inner join ods.Cronograma oCr (nolock) on oCr.ZonaID = @ZonaID AND oCr.RegionID = @RegionID
  inner join ods.Campania Ca (nolock) on oCr.CampaniaID = Ca.CampaniaID
  left join Cronograma Cr (nolock) on oCr.RegionID = Cr.RegionID and oCr.ZonaID = Cr.ZonaID and oCr.CampaniaID = Cr.CampaniaID
  WHERE P.PaisID = @PaisID and Ro.Sistema = 1 and Ca.Codigo = @Campania;
END

GO


USE [BelcorpMexico]
GO

/****** Object:  StoredProcedure [dbo].[GetConfiguracionByUsuarioAndCampania]    Script Date: 21/03/2019 12:11:46 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[GetConfiguracionByUsuarioAndCampania]
  @PaisID tinyint,
  @ConsultoraID bigint,
  @Campania int,
  @UsuarioPrueba bit,
  @AceptacionConsultoraDA int
AS
BEGIN
  declare @ZonaID int;
  declare @RegionID int;
  declare @CodigoUsuario varchar(20);
  declare @PrimerNombre varchar(25);
  declare @MontoMinimoPedido numeric(15,2);
  declare @MontoMaximoPedido numeric(15,2);
  declare @IdEstadoActividad int;
  declare @ConsultoraAsociadoID bigint;
  declare @ConsultoraAsociada varchar(20);
  declare @EsPostulante bit = 0;
    
  select top 1
    @EsPostulante = 1,
    @ZonaID = CP.ZonaID, -- ¿Siempre está lleno este campo o hago join con el Zona de UsuarioPostulante?
    @RegionID = CP.RegionID, -- ¿Siempre está lleno este campo o hago join con la Region de UsuarioPostulante?
    @CodigoUsuario = CP.Codigo,
    @PrimerNombre = CP.PrimerNombre
  from ConsultoraPostulante CP (nolock)
  inner join UsuarioPostulante UP (nolock) on UP.CodigoUsuario = CP.Codigo and UP.Estado = 1 -- inner o left
  where CP.ConsultoraID = @ConsultoraID and UP.UsuarioReal = 0;

  IF @EsPostulante = 0
  BEGIN
    IF @UsuarioPrueba = 0
    BEGIN
      select
        @ZonaID = C.ZonaID,
        @RegionID = C.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = C.PrimerNombre,
        @MontoMinimoPedido = C.MontoMinimoPedido,
        @MontoMaximoPedido = C.MontoMaximoPedido,
        @IdEstadoActividad = C.IdEstadoActividad
      from ods.Consultora C (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = C.Codigo
      where ConsultoraID = @ConsultoraID;
    END
    ELSE
    BEGIN
      select
        @ZonaID = CF.ZonaID,
        @RegionID = CF.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = CF.PrimerNombre,
        @MontoMinimoPedido = CF.MontoMinimoPedido,
        @MontoMaximoPedido = CF.MontoMaximoPedido,
        @IdEstadoActividad = CF.IdEstadoActividad,
        @ConsultoraAsociadoID = C.ConsultoraID,
        @ConsultoraAsociada = C.Codigo
      from ConsultoraFicticia CF (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = CF.Codigo
      left join usuarioprueba UP (nolock) on U.CodigoUsuario = UP.CodigoUsuario
      left join ods.Consultora C (nolock) on UP.CodigoConsultoraAsociada = C.Codigo
      where CF.ConsultoraID = @ConsultoraID;
    END
  END

  declare @DiasDuracionCronograma tinyint = 1;  
  declare @ZonaValida int;
  declare @IndicadorDias bit = 0;

  select
    @DiasDuracionCronograma = DiasDuracionCronograma,
    @ZonaValida = ZonaID,
    @IndicadorDias = ValidacionActiva
  from ConfiguracionValidacionZona with(nolock)
  where ZonaID = @ZonaID;

  -- Dias Duracion Cronograma para Nuevas (CR)
  IF @EsPostulante = 0 and @DiasDuracionCronograma > 1 and @PaisID in (5,7,8,10)
  BEGIN
    declare @UCF int = 0, @SID int = 0;
    select
      @UCF = isnull(UltimaCampanaFacturada,0),
      @SID = isnull(SegmentoId,0)
    from ods.Consultora with(nolock)
    where ConsultoraID = @ConsultoraID;

    IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
      SET @DiasDuracionCronograma = 2
  END

  select
    P.PaisID,
    P.CodigoISO,
    isnull(P.TieneHana,0) as TieneHana,
    P.Simbolo,
    P.EstadoSimplificacionCUV,
    isnull(P.ZonaHoraria,0) as ZonaHoraria,
    P.PROLSinStock,
    P.NuevoPROL,
    isnull(p.TieneODD,0) as TieneODD,
    iif(
      P.NuevoPROL = 0,
      0,
      isnull((select top 1 1 from ConfiguracionValidacionNuevoPROL with(nolock) where ZonaId = @ZonaId), 0)
    ) as ZonaNuevoPROL,
    iif(
      P.EsquemaDAConsultora = 0 or @AceptacionConsultoraDA < 1,
      isnull(@ZonaValida,-1),
      -1
    ) as ZonaValida,
    iif(@IndicadorDias = 0, 0, CV.DiasAntes) as DiasAntes,
    CV.HoraInicio,
    iif(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(cr.CampaniaId,0) = 0, CV.HoraFin, P.HoraCierreZonaDemAnti),
      iif(@AceptacionConsultoraDA < 1, CV.HoraFin, P.HoraCierreZonaDemAnti)
    ) as HoraFin,
    CV.HoraInicioNoFacturable,
    CV.HoraCierreNoFacturable,
    iif(@EsPostulante = 0,CV.ValidacionInteractiva,0) as ValidacionInteractiva,
    CV.HabilitarRestriccionHoraria,
    isnull(CV.HorasDuracionRestriccion,0) as HorasDuracionRestriccion,
    @Campania as CampaniaID,
    @ConsultoraID as ConsultoraID,
    isnull(@PrimerNombre,'') as PrimerNombre,
    @MontoMinimoPedido as MontoMinimoPedido,
    @MontoMaximoPedido as MontoMaximoPedido,
    isnull(@IdEstadoActividad,0) as ConsultoraNueva,
    isnull(U.TipoUsuario,0) as TipoUsuario,
    U.CodigoConsultora,
    U.CodigoUsuario,
    U.Nombre as NombreCompleto,
    isnull(U.Email,'') as Email,
    @UsuarioPrueba as UsuarioPrueba,
    isnull(R.RegionID,0) as RegionID,
    isnull(R.Codigo,'') as CodigorRegion,
    isnull(Z.ZonaID,0) as ZonaID,
    isnull(Z.Codigo,'') as CodigoZona,
    isnull(@ConsultoraAsociadoID,0) as ConsultoraAsociadoID,
    @ConsultoraAsociada as ConsultoraAsociada,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(P.TipoDA = 0,oCr.FechaInicioFacturacion,ISNULL(Cr.FechaInicioWeb, oCr.FechaInicioFacturacion)),
      IIF(@AceptacionConsultoraDA < 1, oCr.FechaInicioFacturacion, Cr.FechaInicioWeb)
    ) as FechaInicioFacturacion,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(
        P.TipoDA = 0,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        IIF(
          @PaisID = 4,
          ISNULL(Cr.FechaInicioDD,oCr.FechaInicioReFacturacion),
          ISNULL(Cr.FechaInicioWeb,oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0))
        )
      ),
      IIF(
        @AceptacionConsultoraDA < 1,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        Cr.FechaInicioWeb
      )
    ) as FechaFinFacturacion,
    P.HoraCierreZonaNormal as HoraCierreZonaNormal,
    IIF(
      P.EsquemaDAConsultora <> 0 AND @AceptacionConsultoraDA < 1,
      P.HoraCierreZonaNormal,
      P.HoraCierreZonaDemAnti
    ) as HoraCierreZonaDemAnti,   
    IIF(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(Cr.CampaniaId,0) = 0, 0, 1),
      iif(@AceptacionConsultoraDA = 0 or isnull(Cr.CampaniaId,0) = 0,0,1)
    ) as EsZonaDemAnti
  FROM Pais P (nolock)
  inner join ConfiguracionValidacion CV (nolock) on CV.PaisID = P.PaisID
  inner join Usuario U (nolock) on U.CodigoUsuario = @CodigoUsuario
  inner join UsuarioRol UR (nolock) ON U.CodigoUsuario = UR.CodigoUsuario
  inner join Rol Ro with(nolock) ON UR.RolID = Ro.RolID
  inner join ods.Region R (nolock) on R.RegionID = @RegionID
  inner join ods.Zona Z (nolock) on Z.ZonaID = @ZonaID
  inner join ods.Cronograma oCr (nolock) on oCr.ZonaID = @ZonaID AND oCr.RegionID = @RegionID
  inner join ods.Campania Ca (nolock) on oCr.CampaniaID = Ca.CampaniaID
  left join Cronograma Cr (nolock) on oCr.RegionID = Cr.RegionID and oCr.ZonaID = Cr.ZonaID and oCr.CampaniaID = Cr.CampaniaID
  WHERE P.PaisID = @PaisID and Ro.Sistema = 1 and Ca.Codigo = @Campania;
END

GO
USE [BelcorpPanama]
GO

/****** Object:  StoredProcedure [dbo].[GetConfiguracionByUsuarioAndCampania]    Script Date: 21/03/2019 12:19:31 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[GetConfiguracionByUsuarioAndCampania]
  @PaisID tinyint,
  @ConsultoraID bigint,
  @Campania int,
  @UsuarioPrueba bit,
  @AceptacionConsultoraDA int
AS
BEGIN
  declare @ZonaID int;
  declare @RegionID int;
  declare @CodigoUsuario varchar(20);
  declare @PrimerNombre varchar(25);
  declare @MontoMinimoPedido numeric(15,2);
  declare @MontoMaximoPedido numeric(15,2);
  declare @IdEstadoActividad int;
  declare @ConsultoraAsociadoID bigint;
  declare @ConsultoraAsociada varchar(20);
  declare @EsPostulante bit = 0;
    
  select top 1
    @EsPostulante = 1,
    @ZonaID = CP.ZonaID, -- ¿Siempre está lleno este campo o hago join con el Zona de UsuarioPostulante?
    @RegionID = CP.RegionID, -- ¿Siempre está lleno este campo o hago join con la Region de UsuarioPostulante?
    @CodigoUsuario = CP.Codigo,
    @PrimerNombre = CP.PrimerNombre
  from ConsultoraPostulante CP (nolock)
  inner join UsuarioPostulante UP (nolock) on UP.CodigoUsuario = CP.Codigo and UP.Estado = 1 -- inner o left
  where CP.ConsultoraID = @ConsultoraID and UP.UsuarioReal = 0;

  IF @EsPostulante = 0
  BEGIN
    IF @UsuarioPrueba = 0
    BEGIN
      select
        @ZonaID = C.ZonaID,
        @RegionID = C.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = C.PrimerNombre,
        @MontoMinimoPedido = C.MontoMinimoPedido,
        @MontoMaximoPedido = C.MontoMaximoPedido,
        @IdEstadoActividad = C.IdEstadoActividad
      from ods.Consultora C (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = C.Codigo
      where ConsultoraID = @ConsultoraID;
    END
    ELSE
    BEGIN
      select
        @ZonaID = CF.ZonaID,
        @RegionID = CF.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = CF.PrimerNombre,
        @MontoMinimoPedido = CF.MontoMinimoPedido,
        @MontoMaximoPedido = CF.MontoMaximoPedido,
        @IdEstadoActividad = CF.IdEstadoActividad,
        @ConsultoraAsociadoID = C.ConsultoraID,
        @ConsultoraAsociada = C.Codigo
      from ConsultoraFicticia CF (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = CF.Codigo
      left join usuarioprueba UP (nolock) on U.CodigoUsuario = UP.CodigoUsuario
      left join ods.Consultora C (nolock) on UP.CodigoConsultoraAsociada = C.Codigo
      where CF.ConsultoraID = @ConsultoraID;
    END
  END

  declare @DiasDuracionCronograma tinyint = 1;  
  declare @ZonaValida int;
  declare @IndicadorDias bit = 0;

  select
    @DiasDuracionCronograma = DiasDuracionCronograma,
    @ZonaValida = ZonaID,
    @IndicadorDias = ValidacionActiva
  from ConfiguracionValidacionZona with(nolock)
  where ZonaID = @ZonaID;

  -- Dias Duracion Cronograma para Nuevas (CR)
  IF @EsPostulante = 0 and @DiasDuracionCronograma > 1 and @PaisID in (5,7,8,10)
  BEGIN
    declare @UCF int = 0, @SID int = 0;
    select
      @UCF = isnull(UltimaCampanaFacturada,0),
      @SID = isnull(SegmentoId,0)
    from ods.Consultora with(nolock)
    where ConsultoraID = @ConsultoraID;

    IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
      SET @DiasDuracionCronograma = 2
  END

  select
    P.PaisID,
    P.CodigoISO,
    isnull(P.TieneHana,0) as TieneHana,
    P.Simbolo,
    P.EstadoSimplificacionCUV,
    isnull(P.ZonaHoraria,0) as ZonaHoraria,
    P.PROLSinStock,
    P.NuevoPROL,
    isnull(p.TieneODD,0) as TieneODD,
    iif(
      P.NuevoPROL = 0,
      0,
      isnull((select top 1 1 from ConfiguracionValidacionNuevoPROL with(nolock) where ZonaId = @ZonaId), 0)
    ) as ZonaNuevoPROL,
    iif(
      P.EsquemaDAConsultora = 0 or @AceptacionConsultoraDA < 1,
      isnull(@ZonaValida,-1),
      -1
    ) as ZonaValida,
    iif(@IndicadorDias = 0, 0, CV.DiasAntes) as DiasAntes,
    CV.HoraInicio,
    iif(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(cr.CampaniaId,0) = 0, CV.HoraFin, P.HoraCierreZonaDemAnti),
      iif(@AceptacionConsultoraDA < 1, CV.HoraFin, P.HoraCierreZonaDemAnti)
    ) as HoraFin,
    CV.HoraInicioNoFacturable,
    CV.HoraCierreNoFacturable,
    iif(@EsPostulante = 0,CV.ValidacionInteractiva,0) as ValidacionInteractiva,
    CV.HabilitarRestriccionHoraria,
    isnull(CV.HorasDuracionRestriccion,0) as HorasDuracionRestriccion,
    @Campania as CampaniaID,
    @ConsultoraID as ConsultoraID,
    isnull(@PrimerNombre,'') as PrimerNombre,
    @MontoMinimoPedido as MontoMinimoPedido,
    @MontoMaximoPedido as MontoMaximoPedido,
    isnull(@IdEstadoActividad,0) as ConsultoraNueva,
    isnull(U.TipoUsuario,0) as TipoUsuario,
    U.CodigoConsultora,
    U.CodigoUsuario,
    U.Nombre as NombreCompleto,
    isnull(U.Email,'') as Email,
    @UsuarioPrueba as UsuarioPrueba,
    isnull(R.RegionID,0) as RegionID,
    isnull(R.Codigo,'') as CodigorRegion,
    isnull(Z.ZonaID,0) as ZonaID,
    isnull(Z.Codigo,'') as CodigoZona,
    isnull(@ConsultoraAsociadoID,0) as ConsultoraAsociadoID,
    @ConsultoraAsociada as ConsultoraAsociada,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(P.TipoDA = 0,oCr.FechaInicioFacturacion,ISNULL(Cr.FechaInicioWeb, oCr.FechaInicioFacturacion)),
      IIF(@AceptacionConsultoraDA < 1, oCr.FechaInicioFacturacion, Cr.FechaInicioWeb)
    ) as FechaInicioFacturacion,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(
        P.TipoDA = 0,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        IIF(
          @PaisID = 4,
          ISNULL(Cr.FechaInicioDD,oCr.FechaInicioReFacturacion),
          ISNULL(Cr.FechaInicioWeb,oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0))
        )
      ),
      IIF(
        @AceptacionConsultoraDA < 1,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        Cr.FechaInicioWeb
      )
    ) as FechaFinFacturacion,
    P.HoraCierreZonaNormal as HoraCierreZonaNormal,
    IIF(
      P.EsquemaDAConsultora <> 0 AND @AceptacionConsultoraDA < 1,
      P.HoraCierreZonaNormal,
      P.HoraCierreZonaDemAnti
    ) as HoraCierreZonaDemAnti,   
    IIF(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(Cr.CampaniaId,0) = 0, 0, 1),
      iif(@AceptacionConsultoraDA = 0 or isnull(Cr.CampaniaId,0) = 0,0,1)
    ) as EsZonaDemAnti
  FROM Pais P (nolock)
  inner join ConfiguracionValidacion CV (nolock) on CV.PaisID = P.PaisID
  inner join Usuario U (nolock) on U.CodigoUsuario = @CodigoUsuario
  inner join UsuarioRol UR (nolock) ON U.CodigoUsuario = UR.CodigoUsuario
  inner join Rol Ro with(nolock) ON UR.RolID = Ro.RolID
  inner join ods.Region R (nolock) on R.RegionID = @RegionID
  inner join ods.Zona Z (nolock) on Z.ZonaID = @ZonaID
  inner join ods.Cronograma oCr (nolock) on oCr.ZonaID = @ZonaID AND oCr.RegionID = @RegionID
  inner join ods.Campania Ca (nolock) on oCr.CampaniaID = Ca.CampaniaID
  left join Cronograma Cr (nolock) on oCr.RegionID = Cr.RegionID and oCr.ZonaID = Cr.ZonaID and oCr.CampaniaID = Cr.CampaniaID
  WHERE P.PaisID = @PaisID and Ro.Sistema = 1 and Ca.Codigo = @Campania;
END

GO


USE [BelcorpPuertoRico]
GO

/****** Object:  StoredProcedure [dbo].[GetConfiguracionByUsuarioAndCampania]    Script Date: 21/03/2019 12:33:05 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[GetConfiguracionByUsuarioAndCampania]
  @PaisID tinyint,
  @ConsultoraID bigint,
  @Campania int,
  @UsuarioPrueba bit,
  @AceptacionConsultoraDA int
AS
BEGIN
  declare @ZonaID int;
  declare @RegionID int;
  declare @CodigoUsuario varchar(20);
  declare @PrimerNombre varchar(25);
  declare @MontoMinimoPedido numeric(15,2);
  declare @MontoMaximoPedido numeric(15,2);
  declare @IdEstadoActividad int;
  declare @ConsultoraAsociadoID bigint;
  declare @ConsultoraAsociada varchar(20);
  declare @EsPostulante bit = 0;
    
  select top 1
    @EsPostulante = 1,
    @ZonaID = CP.ZonaID, -- ¿Siempre está lleno este campo o hago join con el Zona de UsuarioPostulante?
    @RegionID = CP.RegionID, -- ¿Siempre está lleno este campo o hago join con la Region de UsuarioPostulante?
    @CodigoUsuario = CP.Codigo,
    @PrimerNombre = CP.PrimerNombre
  from ConsultoraPostulante CP (nolock)
  inner join UsuarioPostulante UP (nolock) on UP.CodigoUsuario = CP.Codigo and UP.Estado = 1 -- inner o left
  where CP.ConsultoraID = @ConsultoraID and UP.UsuarioReal = 0;

  IF @EsPostulante = 0
  BEGIN
    IF @UsuarioPrueba = 0
    BEGIN
      select
        @ZonaID = C.ZonaID,
        @RegionID = C.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = C.PrimerNombre,
        @MontoMinimoPedido = C.MontoMinimoPedido,
        @MontoMaximoPedido = C.MontoMaximoPedido,
        @IdEstadoActividad = C.IdEstadoActividad
      from ods.Consultora C (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = C.Codigo
      where ConsultoraID = @ConsultoraID;
    END
    ELSE
    BEGIN
      select
        @ZonaID = CF.ZonaID,
        @RegionID = CF.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = CF.PrimerNombre,
        @MontoMinimoPedido = CF.MontoMinimoPedido,
        @MontoMaximoPedido = CF.MontoMaximoPedido,
        @IdEstadoActividad = CF.IdEstadoActividad,
        @ConsultoraAsociadoID = C.ConsultoraID,
        @ConsultoraAsociada = C.Codigo
      from ConsultoraFicticia CF (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = CF.Codigo
      left join usuarioprueba UP (nolock) on U.CodigoUsuario = UP.CodigoUsuario
      left join ods.Consultora C (nolock) on UP.CodigoConsultoraAsociada = C.Codigo
      where CF.ConsultoraID = @ConsultoraID;
    END
  END

  declare @DiasDuracionCronograma tinyint = 1;  
  declare @ZonaValida int;
  declare @IndicadorDias bit = 0;

  select
    @DiasDuracionCronograma = DiasDuracionCronograma,
    @ZonaValida = ZonaID,
    @IndicadorDias = ValidacionActiva
  from ConfiguracionValidacionZona with(nolock)
  where ZonaID = @ZonaID;

  -- Dias Duracion Cronograma para Nuevas (CR)
  IF @EsPostulante = 0 and @DiasDuracionCronograma > 1 and @PaisID in (5,7,8,10)
  BEGIN
    declare @UCF int = 0, @SID int = 0;
    select
      @UCF = isnull(UltimaCampanaFacturada,0),
      @SID = isnull(SegmentoId,0)
    from ods.Consultora with(nolock)
    where ConsultoraID = @ConsultoraID;

    IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
      SET @DiasDuracionCronograma = 2
  END

  select
    P.PaisID,
    P.CodigoISO,
    isnull(P.TieneHana,0) as TieneHana,
    P.Simbolo,
    P.EstadoSimplificacionCUV,
    isnull(P.ZonaHoraria,0) as ZonaHoraria,
    P.PROLSinStock,
    P.NuevoPROL,
    isnull(p.TieneODD,0) as TieneODD,
    iif(
      P.NuevoPROL = 0,
      0,
      isnull((select top 1 1 from ConfiguracionValidacionNuevoPROL with(nolock) where ZonaId = @ZonaId), 0)
    ) as ZonaNuevoPROL,
    iif(
      P.EsquemaDAConsultora = 0 or @AceptacionConsultoraDA < 1,
      isnull(@ZonaValida,-1),
      -1
    ) as ZonaValida,
    iif(@IndicadorDias = 0, 0, CV.DiasAntes) as DiasAntes,
    CV.HoraInicio,
    iif(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(cr.CampaniaId,0) = 0, CV.HoraFin, P.HoraCierreZonaDemAnti),
      iif(@AceptacionConsultoraDA < 1, CV.HoraFin, P.HoraCierreZonaDemAnti)
    ) as HoraFin,
    CV.HoraInicioNoFacturable,
    CV.HoraCierreNoFacturable,
    iif(@EsPostulante = 0,CV.ValidacionInteractiva,0) as ValidacionInteractiva,
    CV.HabilitarRestriccionHoraria,
    isnull(CV.HorasDuracionRestriccion,0) as HorasDuracionRestriccion,
    @Campania as CampaniaID,
    @ConsultoraID as ConsultoraID,
    isnull(@PrimerNombre,'') as PrimerNombre,
    @MontoMinimoPedido as MontoMinimoPedido,
    @MontoMaximoPedido as MontoMaximoPedido,
    isnull(@IdEstadoActividad,0) as ConsultoraNueva,
    isnull(U.TipoUsuario,0) as TipoUsuario,
    U.CodigoConsultora,
    U.CodigoUsuario,
    U.Nombre as NombreCompleto,
    isnull(U.Email,'') as Email,
    @UsuarioPrueba as UsuarioPrueba,
    isnull(R.RegionID,0) as RegionID,
    isnull(R.Codigo,'') as CodigorRegion,
    isnull(Z.ZonaID,0) as ZonaID,
    isnull(Z.Codigo,'') as CodigoZona,
    isnull(@ConsultoraAsociadoID,0) as ConsultoraAsociadoID,
    @ConsultoraAsociada as ConsultoraAsociada,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(P.TipoDA = 0,oCr.FechaInicioFacturacion,ISNULL(Cr.FechaInicioWeb, oCr.FechaInicioFacturacion)),
      IIF(@AceptacionConsultoraDA < 1, oCr.FechaInicioFacturacion, Cr.FechaInicioWeb)
    ) as FechaInicioFacturacion,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(
        P.TipoDA = 0,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        IIF(
          @PaisID = 4,
          ISNULL(Cr.FechaInicioDD,oCr.FechaInicioReFacturacion),
          ISNULL(Cr.FechaInicioWeb,oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0))
        )
      ),
      IIF(
        @AceptacionConsultoraDA < 1,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        Cr.FechaInicioWeb
      )
    ) as FechaFinFacturacion,
    P.HoraCierreZonaNormal as HoraCierreZonaNormal,
    IIF(
      P.EsquemaDAConsultora <> 0 AND @AceptacionConsultoraDA < 1,
      P.HoraCierreZonaNormal,
      P.HoraCierreZonaDemAnti
    ) as HoraCierreZonaDemAnti,   
    IIF(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(Cr.CampaniaId,0) = 0, 0, 1),
      iif(@AceptacionConsultoraDA = 0 or isnull(Cr.CampaniaId,0) = 0,0,1)
    ) as EsZonaDemAnti
  FROM Pais P (nolock)
  inner join ConfiguracionValidacion CV (nolock) on CV.PaisID = P.PaisID
  inner join Usuario U (nolock) on U.CodigoUsuario = @CodigoUsuario
  inner join UsuarioRol UR (nolock) ON U.CodigoUsuario = UR.CodigoUsuario
  inner join Rol Ro with(nolock) ON UR.RolID = Ro.RolID
  inner join ods.Region R (nolock) on R.RegionID = @RegionID
  inner join ods.Zona Z (nolock) on Z.ZonaID = @ZonaID
  inner join ods.Cronograma oCr (nolock) on oCr.ZonaID = @ZonaID AND oCr.RegionID = @RegionID
  inner join ods.Campania Ca (nolock) on oCr.CampaniaID = Ca.CampaniaID
  left join Cronograma Cr (nolock) on oCr.RegionID = Cr.RegionID and oCr.ZonaID = Cr.ZonaID and oCr.CampaniaID = Cr.CampaniaID
  WHERE P.PaisID = @PaisID and Ro.Sistema = 1 and Ca.Codigo = @Campania;
END

GO


USE [BelcorpSalvador]
GO

/****** Object:  StoredProcedure [dbo].[GetConfiguracionByUsuarioAndCampania]    Script Date: 21/03/2019 12:46:31 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[GetConfiguracionByUsuarioAndCampania]
  @PaisID tinyint,
  @ConsultoraID bigint,
  @Campania int,
  @UsuarioPrueba bit,
  @AceptacionConsultoraDA int
AS
BEGIN
  declare @ZonaID int;
  declare @RegionID int;
  declare @CodigoUsuario varchar(20);
  declare @PrimerNombre varchar(25);
  declare @MontoMinimoPedido numeric(15,2);
  declare @MontoMaximoPedido numeric(15,2);
  declare @IdEstadoActividad int;
  declare @ConsultoraAsociadoID bigint;
  declare @ConsultoraAsociada varchar(20);
  declare @EsPostulante bit = 0;
    
  select top 1
    @EsPostulante = 1,
    @ZonaID = CP.ZonaID, -- ¿Siempre está lleno este campo o hago join con el Zona de UsuarioPostulante?
    @RegionID = CP.RegionID, -- ¿Siempre está lleno este campo o hago join con la Region de UsuarioPostulante?
    @CodigoUsuario = CP.Codigo,
    @PrimerNombre = CP.PrimerNombre
  from ConsultoraPostulante CP (nolock)
  inner join UsuarioPostulante UP (nolock) on UP.CodigoUsuario = CP.Codigo and UP.Estado = 1 -- inner o left
  where CP.ConsultoraID = @ConsultoraID and UP.UsuarioReal = 0;

  IF @EsPostulante = 0
  BEGIN
    IF @UsuarioPrueba = 0
    BEGIN
      select
        @ZonaID = C.ZonaID,
        @RegionID = C.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = C.PrimerNombre,
        @MontoMinimoPedido = C.MontoMinimoPedido,
        @MontoMaximoPedido = C.MontoMaximoPedido,
        @IdEstadoActividad = C.IdEstadoActividad
      from ods.Consultora C (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = C.Codigo
      where ConsultoraID = @ConsultoraID;
    END
    ELSE
    BEGIN
      select
        @ZonaID = CF.ZonaID,
        @RegionID = CF.RegionID,
        @CodigoUsuario = U.CodigoUsuario,
        @PrimerNombre = CF.PrimerNombre,
        @MontoMinimoPedido = CF.MontoMinimoPedido,
        @MontoMaximoPedido = CF.MontoMaximoPedido,
        @IdEstadoActividad = CF.IdEstadoActividad,
        @ConsultoraAsociadoID = C.ConsultoraID,
        @ConsultoraAsociada = C.Codigo
      from ConsultoraFicticia CF (nolock)
      inner join Usuario U (nolock) on U.CodigoConsultora = CF.Codigo
      left join usuarioprueba UP (nolock) on U.CodigoUsuario = UP.CodigoUsuario
      left join ods.Consultora C (nolock) on UP.CodigoConsultoraAsociada = C.Codigo
      where CF.ConsultoraID = @ConsultoraID;
    END
  END

  declare @DiasDuracionCronograma tinyint = 1;  
  declare @ZonaValida int;
  declare @IndicadorDias bit = 0;

  select
    @DiasDuracionCronograma = DiasDuracionCronograma,
    @ZonaValida = ZonaID,
    @IndicadorDias = ValidacionActiva
  from ConfiguracionValidacionZona with(nolock)
  where ZonaID = @ZonaID;

  -- Dias Duracion Cronograma para Nuevas (CR)
  IF @EsPostulante = 0 and @DiasDuracionCronograma > 1 and @PaisID in (5,7,8,10)
  BEGIN
    declare @UCF int = 0, @SID int = 0;
    select
      @UCF = isnull(UltimaCampanaFacturada,0),
      @SID = isnull(SegmentoId,0)
    from ods.Consultora with(nolock)
    where ConsultoraID = @ConsultoraID;

    IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
      SET @DiasDuracionCronograma = 2
  END

  select
    P.PaisID,
    P.CodigoISO,
    isnull(P.TieneHana,0) as TieneHana,
    P.Simbolo,
    P.EstadoSimplificacionCUV,
    isnull(P.ZonaHoraria,0) as ZonaHoraria,
    P.PROLSinStock,
    P.NuevoPROL,
    isnull(p.TieneODD,0) as TieneODD,
    iif(
      P.NuevoPROL = 0,
      0,
      isnull((select top 1 1 from ConfiguracionValidacionNuevoPROL with(nolock) where ZonaId = @ZonaId), 0)
    ) as ZonaNuevoPROL,
    iif(
      P.EsquemaDAConsultora = 0 or @AceptacionConsultoraDA < 1,
      isnull(@ZonaValida,-1),
      -1
    ) as ZonaValida,
    iif(@IndicadorDias = 0, 0, CV.DiasAntes) as DiasAntes,
    CV.HoraInicio,
    iif(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(cr.CampaniaId,0) = 0, CV.HoraFin, P.HoraCierreZonaDemAnti),
      iif(@AceptacionConsultoraDA < 1, CV.HoraFin, P.HoraCierreZonaDemAnti)
    ) as HoraFin,
    CV.HoraInicioNoFacturable,
    CV.HoraCierreNoFacturable,
    iif(@EsPostulante = 0,CV.ValidacionInteractiva,0) as ValidacionInteractiva,
    CV.HabilitarRestriccionHoraria,
    isnull(CV.HorasDuracionRestriccion,0) as HorasDuracionRestriccion,
    @Campania as CampaniaID,
    @ConsultoraID as ConsultoraID,
    isnull(@PrimerNombre,'') as PrimerNombre,
    @MontoMinimoPedido as MontoMinimoPedido,
    @MontoMaximoPedido as MontoMaximoPedido,
    isnull(@IdEstadoActividad,0) as ConsultoraNueva,
    isnull(U.TipoUsuario,0) as TipoUsuario,
    U.CodigoConsultora,
    U.CodigoUsuario,
    U.Nombre as NombreCompleto,
    isnull(U.Email,'') as Email,
    @UsuarioPrueba as UsuarioPrueba,
    isnull(R.RegionID,0) as RegionID,
    isnull(R.Codigo,'') as CodigorRegion,
    isnull(Z.ZonaID,0) as ZonaID,
    isnull(Z.Codigo,'') as CodigoZona,
    isnull(@ConsultoraAsociadoID,0) as ConsultoraAsociadoID,
    @ConsultoraAsociada as ConsultoraAsociada,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(P.TipoDA = 0,oCr.FechaInicioFacturacion,ISNULL(Cr.FechaInicioWeb, oCr.FechaInicioFacturacion)),
      IIF(@AceptacionConsultoraDA < 1, oCr.FechaInicioFacturacion, Cr.FechaInicioWeb)
    ) as FechaInicioFacturacion,
    IIF(
      P.EsquemaDAConsultora = 0,
      IIF(
        P.TipoDA = 0,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        IIF(
          @PaisID = 4,
          ISNULL(Cr.FechaInicioDD,oCr.FechaInicioReFacturacion),
          ISNULL(Cr.FechaInicioWeb,oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0))
        )
      ),
      IIF(
        @AceptacionConsultoraDA < 1,
        oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
        Cr.FechaInicioWeb
      )
    ) as FechaFinFacturacion,
    P.HoraCierreZonaNormal as HoraCierreZonaNormal,
    IIF(
      P.EsquemaDAConsultora <> 0 AND @AceptacionConsultoraDA < 1,
      P.HoraCierreZonaNormal,
      P.HoraCierreZonaDemAnti
    ) as HoraCierreZonaDemAnti,   
    IIF(
      P.EsquemaDAConsultora = 0,
      iif(P.TipoDA = 0 or isnull(Cr.CampaniaId,0) = 0, 0, 1),
      iif(@AceptacionConsultoraDA = 0 or isnull(Cr.CampaniaId,0) = 0,0,1)
    ) as EsZonaDemAnti
  FROM Pais P (nolock)
  inner join ConfiguracionValidacion CV (nolock) on CV.PaisID = P.PaisID
  inner join Usuario U (nolock) on U.CodigoUsuario = @CodigoUsuario
  inner join UsuarioRol UR (nolock) ON U.CodigoUsuario = UR.CodigoUsuario
  inner join Rol Ro with(nolock) ON UR.RolID = Ro.RolID
  inner join ods.Region R (nolock) on R.RegionID = @RegionID
  inner join ods.Zona Z (nolock) on Z.ZonaID = @ZonaID
  inner join ods.Cronograma oCr (nolock) on oCr.ZonaID = @ZonaID AND oCr.RegionID = @RegionID
  inner join ods.Campania Ca (nolock) on oCr.CampaniaID = Ca.CampaniaID
  left join Cronograma Cr (nolock) on oCr.RegionID = Cr.RegionID and oCr.ZonaID = Cr.ZonaID and oCr.CampaniaID = Cr.CampaniaID
  WHERE P.PaisID = @PaisID and Ro.Sistema = 1 and Ca.Codigo = @Campania;
END

GO














