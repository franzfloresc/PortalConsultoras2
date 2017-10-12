USE BelcorpBolivia
GO
if object_id('fnGetTableTerritorioIdByFiltroAndUbigeo') is not null
begin
	drop function fnGetTableTerritorioIdByFiltroAndUbigeo;
end
GO
create function fnGetTableTerritorioIdByFiltroAndUbigeo(
	@TipoFiltroUbigeo int,
	@CodigoUbigeo varchar(24)
)
returns @List table (TerritorioID int, CodigoUbigeo varchar(24))
as
begin
	IF @TipoFiltroUbigeo = 1
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM ods.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 2
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 3
	BEGIN
		INSERT INTO @List
		SELECT TT.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		INNER JOIN ods.UBIGEO U with(nolock) ON U.UBIGEOID = T.TERRITORIOID
		INNER JOIN ods.TERRITORIO TT with(nolock) ON TT.CODIGOUBIGEO = U.CODIGOUBIGEO
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END

	return;
end
GO
IF OBJECT_ID('dbo.fnAddCampaniaAndNumero2') IS NOT NULL
BEGIN
	DROP FUNCTION dbo.fnAddCampaniaAndNumero2;
END
GO
CREATE FUNCTION dbo.fnAddCampaniaAndNumero2(
	@CampaniaActual INT,
	@AddNro INT,
	@NroCampanias INT
)
RETURNS INT
AS
BEGIN	
	DECLARE @AnioCampaniaActual INT = @CampaniaActual/100;
	DECLARE @NroCampaniaActual INT = @CampaniaActual%100;
	DECLARE @SumNroCampania INT = (@NroCampaniaActual + @AddNro) - 1;
	DECLARE @AnioCampaniaSiguiente INT = @AnioCampaniaActual + @SumNroCampania/@NroCampanias;
	DECLARE @NroCampaniaSiguiente INT = @SumNroCampania%@NroCampanias + 1;
	
	IF @NroCampaniaSiguiente < 1
	BEGIN
		SET @AnioCampaniaSiguiente = @AnioCampaniaSiguiente - 1;
		SET @NroCampaniaSiguiente = @NroCampaniaSiguiente + @NroCampanias;
	END
	DECLARE @CampaniaSiguiente INT = @AnioCampaniaSiguiente*100 + @NroCampaniaSiguiente;
	RETURN @CampaniaSiguiente;
END
GO
ALTER FUNCTION dbo.fnAddCampaniaAndNumero(
	@CodigoISO CHAR(2),
	@CampaniaActual INT,
	@AddNro INT
)
RETURNS INT
AS
BEGIN
	DECLARE @NroCampanias INT = IIF(
		ISNULL(@CodigoISO,'') <> '',
		(select top 1 NroCampanias from Pais with(nolock) where CodigoISO = @CodigoISO),
		(select top 1 NroCampanias from Pais with(nolock) where EstadoActivo = 1)
	);
	
	RETURN dbo.fnAddCampaniaAndNumero2(@CampaniaActual,@AddNro,@NroCampanias);
END
GO
ALTER FUNCTION dbo.fnGetConfiguracionCampania
(
	@PaisID tinyint,
	@ZonaID int,
	@RegionID int,
	@ConsultoraID bigint
)
RETURNS @TConfiguracionCampania TABLE(
	ID int,
	CampaniaID varchar(6),
	FechaInicioFacturacion datetime,
	FechaFinFacturacion datetime,
	CampaniaDescripcion varchar(6),
	HoraInicio time,
	HoraFin time,
	DiasAntes int,
	ZonaValida int,
	HoraInicioNoFacturable time,
	HoraCierreNoFacturable time,
	ZonaHoraria float,
	HoraCierreZonaNormal time,
	HoraCierreZonaDemAnti time,
	HoraCierreZonaDemAntiCierre time,
	EsZonaDemAnti int,
	DiasDuracionCronograma int,
	HabilitarRestriccionHoraria int,
	HorasDuracionRestriccion int,
	NroCampanias int,
	PROLSinStock bit,
	FechaFinFIC datetime,
	IndicadorOfertaFIC int,
	ImagenURLOfertaFIC varchar(500),
	NuevoPROL bit,
	ZonaNuevoPROL bit,
	EstadoSimplificacionCUV bit,
	EsquemaDAConsultora bit,	
	ValidacionInteractiva bit,
	MensajeValidacionInteractiva varchar(500),
	IndicadorEnviado bit,
	IndicadorGPRSB int,
	FechaActualPais datetime,
	EstadoPedido smallint,
	ValidacionAbierta BIT,
	FechaLimitePago SMALLDATETIME,
	AceptacionConsultoraDA int
)
AS
/*
select * from dbo.fnGetConfiguracionCampania(11,2161,2017,2)
*/
BEGIN
	-- Variables Pais
	DECLARE @CodigoISO CHAR(2)
	DECLARE @ZonaHoraria FLOAT
	DECLARE @HoraCierreZonaNormal TIME(0)
	DECLARE @HoraCierreZonaDemAnti TIME(0)
	DECLARE @NroCampanias INT
	DECLARE @PROLSinStock BIT
	DECLARE @NuevoPROL BIT
	DECLARE @EstadoSimplificacionCUV BIT
	DECLARE @EsquemaDAConsultora BIT
	DECLARE @TipoDA BIT
	DECLARE @PedidoFIC BIT

	select
		@CodigoISO = CodigoISO,
		@ZonaHoraria = ISNULL(ZonaHoraria,0),
		@HoraCierreZonaNormal = HoraCierreZonaNormal,
		@HoraCierreZonaDemAnti = HoraCierreZonaDemAnti,
		@NroCampanias = NroCampanias,
		@PROLSinStock = PROLSinStock,
		@NuevoPROL = NuevoPROL,
		@EstadoSimplificacionCUV = EstadoSimplificacionCUV,
		@EsquemaDAConsultora = EsquemaDAConsultora,
		@TipoDA = TipoDA,
		@PedidoFIC = PedidoFIC
	from Pais (nolock)
	where PaisId = @PaisID

	-- Variables ConfiguracionValidacion
	DECLARE @HoraInicio time(0)
	DECLARE @HoraFin time(0)
	DECLARE @DiasAntes tinyint
	DECLARE @HoraInicioNoFacturable time(0)
	DECLARE @HoraCierreNoFacturable time(0)
	DECLARE @HabilitarRestriccionHoraria bit
	DECLARE @HorasDuracionRestriccion INT
	DECLARE @ValidacionInteractiva bit
	DECLARE @MensajeValidacionInteractiva varchar(500)

	SELECT
		@HoraInicio = HoraInicio,
		@HoraFin = HoraFin,
		@DiasAntes = DiasAntes,
		@HoraInicioNoFacturable = HoraInicioNoFacturable,
		@HoraCierreNoFacturable = HoraCierreNoFacturable,
		@HabilitarRestriccionHoraria = HabilitarRestriccionHoraria,
		@HorasDuracionRestriccion =  ISNULL(HorasDuracionRestriccion,0),
		@ValidacionInteractiva = ValidacionInteractiva,
		@MensajeValidacionInteractiva = MensajeValidacionInteractiva
	FROM [dbo].[ConfiguracionValidacion] (nolock)
	WHERE  PaisID = @PaisID

	 -- Variables ConfiguracionValidacionZona
	DECLARE @DiasDuracionCronograma tinyint
	SET @DiasDuracionCronograma = 1
	DECLARE @ZonaValida int
	DECLARE @IndicadorDias bit
	SET @IndicadorDias = 0

	select
		@DiasDuracionCronograma = DiasDuracionCronograma,
		@ZonaValida = ZonaID,
		@IndicadorDias = ValidacionActiva
	from ConfiguracionValidacionZona with(nolock)
	where CampaniaID = 201301 and ZonaID = @ZonaID

	-- Dias Duracion Cronograma para Nuevas (CR)
	IF @PaisID = 5 OR @PaisID = 8 OR @PaisID = 7 OR @PaisID = 10
	BEGIN
		declare @UCF int = 0;
		declare @SID int = 0;

		select
			@UCF = ISNULL(UltimaCampanaFacturada,0),
			@SID = ISNULL(SegmentoId,0)
		from ods.Consultora with(nolock)
		where ConsultoraID = @ConsultoraID

		IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
			SET @DiasDuracionCronograma = 2
	END

	-- Variables ConfiguracionValidacionNuevoPROL
	DECLARE @ZonaNuevoPROL BIT = 0;
	DECLARE @ContNuevoPROL INT = 0;

	IF @NuevoPROL = 1
	BEGIN
		SELECT @ContNuevoPROL = COUNT(ZonaId)
		FROM ConfiguracionValidacionNuevoPROL with(nolock)
		WHERE ZonaId = @ZonaId

		IF @ContNuevoPROL > 0
			SET @ZonaNuevoPROL = 1
	END

	-- Otras Configuraciones
	IF @IndicadorDias = 0
		SET @DiasAntes = 0

	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	DECLARE @AceptacionConsultoraDA INT
	SET @AceptacionConsultoraDA = -1

	-- Obtener Campania Anterior
	DECLARE @Campania INT
	DECLARE @Anio INT
	SET @Campania = 0

	IF @EsquemaDAConsultora = 0
	BEGIN
		IF @TipoDA = 0
		BEGIN
			SELECT TOP 1
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
			WHERE
				c.ZonaID = @ZonaID AND
				c.RegionID = @RegionID AND
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
		ELSE
		BEGIN
			SELECT TOP 1	
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID		
			LEFT JOIN [dbo].[Cronograma] cr (nolock) ON 
				c.CampaniaID = cr.CampaniaID AND
				c.RegionID = cr.RegionID AND
				c.ZonaID = cr.ZonaID
			WHERE 
				c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
				IIF(@PaisID = 4,
					ISNULL(CONVERT(datetime, cr.FechaInicioDD) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioReFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal)),
					ISNULL(CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
								ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
								CONVERT(datetime, @HoraCierreZonaNormal))
				) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
	END
	ELSE
	BEGIN

		DECLARE @Campania_temp INT
		DECLARE @Anio_temp INT
		SET @Campania_temp = 0

		SELECT TOP 1
			@Campania_temp = ca.Codigo,
			@Anio_temp = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
				ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
		ORDER BY c.CampaniaID DESC

		IF(@Campania_temp <> 0)
		BEGIN
			SET @Campania_temp = @Campania_temp - @Anio_temp
			IF(@Campania_temp = @NroCampanias)
				SET @Campania_temp = @Anio_temp + 101
			ELSE
				SET @Campania_temp = @Anio_temp + @Campania_temp + 1

			SELECT @AceptacionConsultoraDA = TipoConfiguracion
			FROM ConfiguracionConsultoraDA with(nolock)
			WHERE			
				ConsultoraId = @ConsultoraId and
				ZonaId = @ZonaId and
				CampaniaId = cast(@Campania_temp as int)
		END

		SELECT TOP 1
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			IIF(@AceptacionConsultoraDA < 1,
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal),
				CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti)) < @FechaGeneral
		ORDER BY c.CampaniaID DESC
	END
	
	--Obtiene UltimaCampaniaFacturada
	declare @UltimaCampanaFacturada int;
	declare @TipoFacturacion char(2);
	declare @ConsultoraIdAsociada bigint;

	select
		@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0),
		@TipoFacturacion = ISNULL(TipoFacturacion,'')
	From ods.consultora (nolock)
	Where consultoraid = @consultoraid

	--Obtiene UltimaCampaniaFacturada x UsuarioPrueba
	IF @UltimaCampanaFacturada IS NULL
	BEGIN
		SELECT
			@UltimaCampanaFacturada = ISNULL(c.UltimaCampanaFacturada,0),
			@TipoFacturacion = ISNULL(c.TipoFacturacion,''),
			@ConsultoraIdAsociada = ISNULL(c.ConsultoraId,0)
		FROM ConsultoraFicticia cf with(nolock)
		INNER JOIN UsuarioPrueba up with(nolock) on cf.Codigo = up.CodigoFicticio
		INNER JOIN ods.Consultora c with(nolock) on up.CodigoConsultoraAsociada = c.Codigo
		WHERE cf.ConsultoraId = @consultoraid
	END

	IF @TipoFacturacion <> 'FA'
	BEGIN
		SET @UltimaCampanaFacturada = dbo.fnAddCampaniaAndNumero(@CodigoISO,@UltimaCampanaFacturada,-1);
	END

	-- Valida Campania Anterior
	IF(@Campania <> 0)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1

		IF @EsquemaDAConsultora = 1 AND @Campania > @Campania_temp
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
		
		-- validar si pertenece a una zona DA
		DECLARE @EsZonaDA BIT;
		SELECT @EsZonaDA = IIF(ISNULL(c.CampaniaID,0) = 0,0,1)
		FROM dbo.Cronograma c 
		INNER JOIN ods.Campania ca ON c.CampaniaID = ca.CampaniaID 
		WHERE
			ca.Codigo = @Campania_temp AND
			c.RegionID = @RegionID AND
			c.ZonaID = @ZonaID AND
			c.TipoCronograma = 2

		-- si el esquema es de DA y la zona es de DA y ya facturo en la campaña actual 
		-- y la consultora respondio que no en la DA anterior
		-- se resetea la variable
		IF (@EsquemaDAConsultora = 1 AND @EsZonaDA = 1 AND @UltimaCampanaFacturada = @Campania_temp AND @AceptacionConsultoraDA = 0) 
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
	END
	ELSE
	BEGIN
		SELECT TOP 1 
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		WHERE z.ZonaID = @ZonaID AND z.RegionID = @RegionID
		ORDER BY c.FechaInicioFacturacion ASC
	END

	--Valida UltimaCampaniaFacturada
	IF (@UltimaCampanaFacturada = @Campania)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1
	END
	ELSE
	BEGIN
		DECLARE @IndicadorEnviado BIT= 0, @ValidacionAbierta BIT = 0
		DECLARE @IndicadorGPR TINYINT = 0
		DECLARE @EstadoPedido SMALLINT
  
		SELECT	@IndicadorEnviado  = IndicadorEnviado,  
				@IndicadorGPR = GPRSB, 
				@EstadoPedido = EstadoPedido, 
				@ValidacionAbierta = ValidacionAbierta
		FROM	Pedidoweb (nolock)
		WHERE	CampaniaID = @campania and consultoraid = ISNULL(@ConsultoraIdAsociada,@consultoraid)	

		If(@IndicadorEnviado = 1 AND @IndicadorGPR = 0)
		BEGIN
			SET @Campania = @Campania - @Anio
			IF(@Campania = @NroCampanias)
				SET @Campania = @Anio + 101
			ELSE
				SET @Campania = @Anio + @Campania + 1
		END
	END

	-- Pedido FIC
	DECLARE @FechaFinFIC datetime;
	DECLARE @IndicadorOfertaFIC int = 0;
	DECLARE @ImagenURLOfertaFIC varchar(500) = '';

	IF @PedidoFIC = 1
	BEGIN
		DECLARE @campaniaFIC INT
		IF substring(cast(@Campania as varchar(6)),5,2)=cast(@NroCampanias as char(2))
			set @campaniaFIC=cast(cast( cast(substring(cast(@Campania as varchar(6)),1,4)as int)+1 as varchar(4)) + '01' as int)
		ELSE
			set @campaniaFIC= @Campania +1

		SELECT @FechaFinFIC=isnull(FechaFin,GETDATE())
		FROM CronogramaFIC with(nolock)
		WHERE 
			ZonaID=@ZonaID and 
			CampaniaID = (				
				SELECT CampaniaID
				FROM ods.Campania with(nolock)
				WHERE Codigo=@campaniaFIC
			);

		select top 1
			@IndicadorOfertaFIC = 1,
			@ImagenURLOfertaFIC = isnull(ImagenUrl,'')
		from OfertaFIC (nolock)
		where CampaniaID = @campaniaFIC;
	END
			
	-- Listar Variables
	IF @EsquemaDAConsultora = 0
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@TipoDA = 0,c.FechaInicioFacturacion,ISNULL(cr.FechaInicioWeb, c.FechaInicioFacturacion)) AS FechaInicioFacturacion,
			IIF(@TipoDA = 0,
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				IIF(@PaisID = 4,
					ISNULL(cr.FechaInicioDD,c.FechaInicioReFacturacion),
					ISNULL(cr.FechaInicioWeb,c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
						ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)))
			) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@TipoDA = 0, @HoraFin,IIF(ISNULL(cr.CampaniaId,0) = 0,@HoraFin,@HoraCierreZonaDemAnti)) as HoraFin,
			@DiasAntes AS DiasAntes,
			ISNULL(@ZonaValida,-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(@TipoDA = 0, 0, IIF(ISNULL(cr.CampaniaId,0) = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END
	ELSE
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@AceptacionConsultoraDA < 1, c.FechaInicioFacturacion, cr.FechaInicioWeb) AS FechaInicioFacturacion,
			IIF(@AceptacionConsultoraDA < 1, 
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				cr.FechaInicioWeb) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@AceptacionConsultoraDA < 1, @HoraFin, @HoraCierreZonaDemAnti) as HoraFin,
			@DiasAntes AS DiasAntes,
			IIF(@AceptacionConsultoraDA < 1,ISNULL(@ZonaValida,-1),-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			IIF(@AceptacionConsultoraDA < 1,@HoraCierreZonaNormal,@HoraCierreZonaDemAnti) AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(ISNULL(cr.CampaniaId,0) = 0,0,IIF(@AceptacionConsultoraDA = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END

	RETURN
END
GO
ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @CodigoConsultora VARCHAR(50);
	SELECT TOP 1 @CodigoConsultora = co.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		iif(@PaisValido = 1, CO.ZonaID, CO.TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) AND
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	RETURN ISNULL(@CodigoConsultora, '');
END
GO
ALTER FUNCTION dbo.ObtenerConsultoraVecina
(
	@PaisID INT,
	@EdadMaxima INT,
	@UltimaCampanaFacturada INT,
	@ListadoConsultoraId dbo.IdBigintType READONLY,
	@RegionID INT,
	@ZonaID INT,
	@SeccionID INT,
	@TerritorioID INT
)
RETURNS @Consultora TABLE(
	ConsultoraID BIGINT,
	Codigo VARCHAR(30)
)
AS
BEGIN
	INSERT INTO @Consultora(ConsultoraID, Codigo)
	SELECT TOP 1 CO.ConsultoraID, CO.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID      
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, CO.FechaNacimiento, getdate()) <= @EdadMaxima AND
		CO.UltimaCampanaFacturada >= @UltimaCampanaFacturada AND
		CO.ConsultoraID NOT IN (SELECT Id FROM @ListadoConsultoraId) AND
		CO.RegionID = @RegionID AND CO.ZonaID = @ZonaID AND
		(@SeccionID = 0 OR CO.SeccionID = @SeccionID) AND
		(@TerritorioID = 0 OR CO.TerritorioID = @TerritorioID)
	ORDER BY MontoUltimoPedido DESC;
           
	RETURN;
END
GO
ALTER FUNCTION ValidarAutorizacion
(
	@paisID			INT,
	@CodigoUsuario	VARCHAR(100)
)
RETURNS INT
AS
/*
	SELECT DBO.ValidarAutorizacion(3, '1281283')
	SELECT DBO.ValidarAutorizacion(3, '076912262')
*/
BEGIN
	DECLARE @Usuario VARCHAR(100),
            @RolID INT,
            @AutorizaPedido VARCHAR(10),
            @IdEstadoActividad INT,
            @UltimaCampania INT,
            @CampaniaActual INT,
			@Resultado	INT,
			@CodigoConsultora varchar(20),
			@ZonaID INT,
			@RegionID INT,
			@ConsultoraID INT

	SET @RolID = 0
	SET @Usuario = ''
	SET @IdEstadoActividad = -1
	SET @UltimaCampania = 0
	SET @CampaniaActual = 0
	SET @Resultado = 0	

	SELECT	
		@CodigoConsultora = IsNull(CodigoConsultora,0),
		@PaisID = IsNull(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE codigousuario = @CodigoUsuario

	SELECT	
		@ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
		@AutorizaPedido = ISNULL(AutorizaPedido,''),
		@UltimaCampania = ISNULL(UltimaCampanaFacturada,0)
	FROM ods.consultora WITH(NOLOCK)
	WHERE codigo = @CodigoConsultora

	SELECT 
		@Usuario = u.CodigoUsuario, 
		@RolID = ISNULL(ur.RolId,0),
		@AutorizaPedido = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END),
		@CampaniaActual = ISNULL((SELECT TOP 1 campaniaId FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	FROM Usuario u WITH(NOLOCK)
		LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

    --0: Usuario No Existe
    --1: Usuario No es del Portal
    --2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
    --3: Usuario OK
	DECLARE @tabla_Retirada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Retirada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 12
	
	DECLARE @tabla_Reingresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Reingresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 18
	
	DECLARE @tabla_Egresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Egresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 19

    IF @Usuario IS NOT NULL AND @Usuario <> ''
    BEGIN
        IF @RolID != 0
        BEGIN
            IF @AutorizaPedido IS NOT NULL AND @AutorizaPedido <> ''
            BEGIN
                IF @IdEstadoActividad <> -1
                BEGIN
                    -- Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
                    IF @paisID = 11 OR @paisID = 2 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                    BEGIN
                        --Validamos si el estado es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                            BEGIN
                                --Caso Colombia
								IF @paisID = 4
								BEGIN
                                    SET @Resultado =  2
                                END
								ELSE
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                            END
                            ELSE
                            BEGIN
                                --Para bolivia (FOX) se hace la validación del campo AutorizaPedido
                                IF @paisID = 2
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                BEGIN
                                    SET @Resultado =  3
                                END
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es reingresada
                            IF EXISTS(SELECT 1 FROM @tabla_Reingresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
                                IF @paisID = 3
                                BEGIN
                                    --Se valida las campañas que no ha ingresado
									DECLARE @CampaniasSinIngresar INT = 0;
                                    IF LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampania) = 6
                                    BEGIN
										set @CampaniasSinIngresar = @CampaniaActual - dbo.fnAddCampaniaAndNumero(null,@UltimaCampania,3);
                                    END

                                    IF @CampaniasSinIngresar > 0
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        --Validamos el Autoriza Pedido
                                        IF @AutorizaPedido = 'N'
                                            SET @Resultado =  2
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                                ELSE
                                BEGIN
                                    --Caso Colombia
                                    IF @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        IF @AutorizaPedido = 'N'
                                        BEGIN
                                            --Validamos si es SICC o Bolivia
                                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2
                                                SET @Resultado =  2
                                            ELSE
                                                SET @Resultado =  3
                                        END
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                            END
                            ELSE
                            BEGIN
                                --Caso Colombia
                                IF @paisID = 4
                                BEGIN
                                    --Egresada o Posible Egreso
                                    IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                                    BEGIN
                                        SET @Resultado =  2
                                    END
                                END

                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC o Bolivia
                                    IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2 OR @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3

                            END
                        END
                    END
                    -- Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
                    ELSE IF @paisID = 5 OR @paisID = 10 OR @paisID = 9 OR @paisID = 12 OR @paisID = 13 OR @paisID = 6 OR @paisID = 1 OR @paisID = 14
                    BEGIN
                        -- Validamos si la consultora es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                    SET @Resultado =  2
                                ELSE
                                    SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    SET @Resultado =  2
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es retirada
                            IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
								IF @AutorizaPedido = 'N'
								BEGIN
									--Validamos si es SICC
									IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
										SET @Resultado =  2
									ELSE
										SET @Resultado =  3
								END
								ELSE
									SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC
                                    IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                    END
                    ELSE
                        SET @Resultado = 3
                END
                ELSE
                    SET @Resultado = 3 --Se asume para usuarios del tipo SAC
            END
            ELSE
                SET @Resultado = 3 --Se asume para usuarios del tipo SAC
        END
        ELSE
            SET @Resultado = 1
    END
    ELSE
        SET @Resultado = 0

    RETURN @Resultado

END
GO
ALTER PROCEDURE dbo.GetSesionUsuario_SB2
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	
	DECLARE @FechaLimitePago SMALLDATETIME
	DECLARE @ODSCampaniaID INT
	
	declare @PaisID int
	declare @UsuarioPrueba bit
	declare @CodConsultora varchar(20)
	declare @CampaniaID int
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint
	declare @UltimaCampanaFacturada int
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario

	declare @CountCodigoNivel bigint

	/*Oferta Final, Catalogo Personalizado, CDR*/
	declare @EsOfertaFinalZonaValida bit = 0
	declare @EsOFGanaMasZonaValida bit = 0
	declare @EsCatalogoPersonalizadoZonaValida bit = 0
	declare @EsCDRWebZonaValida  bit = 0
	declare @CodigoZona varchar(4) = ''
	declare @CodigoRegion varchar(2) = ''

	select
		@CodigoZona = IsNull(z.Codigo,''),
		@CodigoRegion = IsNull(r.Codigo,'')
	from ods.consultora c with(nolock)
	inner join ods.Region r on
		c.RegionID = r.RegionID
	inner join ods.Zona z on
		c.ZonaID = z.ZonaID
	where c.codigo = @CodConsultora

	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
		
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/

	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;
	
	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919

	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0

		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;

		/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,-11), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
		)

		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			isnull(c.EsJoven,0) EsJoven,
			(case
				when @CountCodigoNivel =0 then 0  --1589
				when @CountCodigoNivel>0 then 1 End) Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			null as ConsultoraAsociada, --1688
			isnull(si.descripcion,null) SegmentoConstancia, --2469
			isnull(se.Codigo,null) Seccion, --2469
			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469
			case When cl.ConsultoraID is null then 0
				else 1 end esConsultoraLider,
			u.EMailActivo, --2532
			si.SegmentoInternoId,
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u with(nolock)
		LEFT JOIN (
			select *
			from ods.consultora with(nolock)
			where ConsultoraId = @ConsultoraID
		) c ON u.CodigoConsultora = c.Codigo
		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID
		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469
		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469
		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t with(nolock) ON 
			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeo
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@MarcaId int,
	@tipoFiltroUbigeo int
)    
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;
	
	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
	
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';
	
	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1,''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2,''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3,'')
	FROM Ubigeo U with(nolock)
	WHERE codigoubigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		--ISNULL((select top 1 campaniaId from dbo.GetCampaniaPreLogin(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID)),0) as CampaniaActual,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND (@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite) AND
		UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.CampaniaId, -2)
	ORDER BY C.UltimaCampanaFacturada DESC, C.MontoUltimoPedido DESC
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@Nombres varchar(51),
	@Apellidos varchar(51),
	@MarcaId int,
	@tipoFiltroUbigeo int
)
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;

	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
 
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';

	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1, ''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2, ''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3, '')
	FROM Ubigeo with(nolock)
	WHERE CodigoUbigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND
		CONCAT(PrimerNombre,' ',SegundoNombre) LIKE CONCAT('%',@Nombres,'%') AND
		CONCAT(PrimerApellido,' ',SegundoApellido) LIKE CONCAT('%',@Apellidos,'%') AND
		(@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite);
END
GO
ALTER PROCEDURE dbo.GetConsultorasPorUbigeo
	@PaisId int,    
	@CodigoUbigeo varchar(24),    
	@Campania int,    
	@MarcaId int,
	@tipoFiltroUbigeo int
AS    
BEGIN
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	CREATE TABLE #TempConsultoraUbigeo    
	(    
		ID int IDENTITY,    
		ConsultoraID bigint,    
		Codigo varchar(100),    
		CodigoUbigeo varchar(24),    
		NombreCompletoConsultora varchar(300),    
		Email varchar(200),      
		FechaNacimiento datetime,    
		MONTOULTIMOPEDIDO MONEY,    
		UltimaCampanaFacturada INT,     
		CodigoUsuario varchar(100),    
		ZonaID int,    
		RegionID int  
	)

	INSERT INTO #TempConsultoraUbigeo  
    SELECT DISTINCT
		C.ConsultoraID,    
		C.Codigo,
		@CodigoUbigeo as CodigoUbigeo,
		C.NombreCompleto as NombreCompletoConsultora,
		U.Email,
		FechaNacimiento,
		MONTOULTIMOPEDIDO,
		UltimaCampanaFacturada,
		u.CodigoUsuario,
		c.ZonaID,
		c.RegionID    
    FROM ods.CONSULTORA AS C  
    INNER JOIN AFILIACLIENTECONSULTORA AS ACC ON C.CONSULTORAID = ACC.CONSULTORAID  
    INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo   
    WHERE ACC.EsAfiliado = 1 AND C.TERRITORIOID IN (SELECT TerritorioID FROM @TerritorioObjetivo);
		
    IF @MarcaId = 3    
    BEGIN
		DECLARE @EDADLIMITE INT = (SELECT Codigo FROM TABLALOGICADATOS WHERE TABLALOGICAID = 56 AND TABLALOGICADATOSID = 5605);

		DELETE FROM #TempConsultoraUbigeo 
		WHERE ID IN(  
			SELECT ID
			FROM #TempConsultoraUbigeo  
			WHERE (YEAR(getdate()) - year(FechaNacimiento)) >= @EDADLIMITE
		);
    END  
  
   -- -- FILTRANDO CONSULTORAS QUE HAYAN FACTURADO EN LA CAMPAÑANA ANTERIOR  
    --R2442 -  JC - Ya no filtrará por Campaña actual  
    SELECT TCU.ConsultoraID, TCU.Codigo, TCU.CodigoUbigeo, TCU.NombreCompletoConsultora as NombreCompleto, TCU.Email
    FROM #TempConsultoraUbigeo TCU
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,TCU.ZonaID,TCU.RegionID,TCU.ConsultoraID) CC
    WHERE
		dbo.ValidarAutorizacion(@PaisId, TCU.CodigoUsuario) = 3 AND
		TCU.UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.campaniaId, -2)
	order by ULTIMACAMPANAFACTURADA DESC , MONTOULTIMOPEDIDO DESC --R2626 
	
	DROP TABLE #TempConsultoraUbigeo;
END
GO
ALTER PROCEDURE GetProductosOfertaConsultoraNueva
	@CampaniaID INT,
	@ConsultoraID INT
AS
BEGIN
	DECLARE @NroCampania INT = (SELECT TOP 1 nrocampanias FROM pais with(nolock) WHERE EstadoActivo = 1);

	DECLARE @ultimacampaniafacturable INT;
	DECLARE @idcampaniaingreso INT;
	SELECT
		@idcampaniaingreso = AnoCampanaIngreso,
		@ultimacampaniafacturable = isnull(iif(TipoFacturacion = 'FA', UltimaCampanaFacturada, dbo.fnAddCampaniaAndNumero(UltimaCampanaFacturada,-1,@NroCampania)),0)
	FROM ods.Consultora WHERE ConsultoraID=@ConsultoraID;
		
	DECLARE @campaniafacturableingreso INT = @ultimacampaniafacturable - @idcampaniaingreso;
	DECLARE @campaniacompare INT = dbo.fnAddCampaniaAndNumero2(@ultimacampaniafacturable,1,@NroCampania);
	DECLARE @NumeroPedido INT;	
	DECLARE @indicador INT = 0;

	if @CampaniaID = @campaniacompare and (@campaniafacturableingreso between 0 and 3)
	begin		
		declare @CampaniaID1 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -1, @NroCampania);
		declare @CampaniaID2 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -2, @NroCampania);
		declare @CampaniaID3 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -3, @NroCampania);
		declare @CampaniaID4 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -4, @NroCampania);

		declare @idCampaniaID1 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID1);
		declare @idCampaniaID2 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID2);
		declare @idCampaniaID3 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID3);
		declare @idCampaniaID4 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID4);

		declare @campaniasFacturas int;

		---la consultora es nueva, esta realizando su segundo pedido compruebo que la campaña anterior tenga pedido facturado
		if @campaniafacturableingreso = 0
		begin
			set @NumeroPedido = 1;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1) and consultoraid = @ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 1, 1,0);
		end
		---la consultora es nueva, esta realizando su tercer pedido compruebo que las 2 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 1
		begin
			set @NumeroPedido=2;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 2, 1,0);
		end
		---la consultora es nueva, esta realizando su cuarto pedido compruebo que las 3 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 2
		begin
			set @NumeroPedido=3;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 3, 1,0);
		end
		---la consultora es nueva, esta realizando su quINTo pedido compruebo que las 4 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 3
		begin
			set @NumeroPedido=4;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido (nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3,@idCampaniaID4) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 4, 1,0);
		end
	end

	IF @indicador = 1 and (@campaniafacturableingreso between 0 and 3)
	begin
		SELECT TOP 4
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			MarcaID,
			IndicadorMontoMinimo,
			DescripcionProd,
			UnidadesPermitidas,
			(case when len(IndicadorPedido) >0 then 1 else 0 end) IndicadorPedido,
			ganahasta
		FROM (
			SELECT
				og.OfertaNuevaId,
				og.NumeroPedido,
				case isnull(og.FlagImagenActiva,0)
					when 1 then og.ImagenProducto01
					when 2 then og.ImagenProducto02
					when 3 then og.ImagenProducto03
					else ''
				end ImagenProducto01,
				og.Descripcion,
				og.CUV,
				og.PrecioNormal,
				og.PrecioParaTi,
				pc.MarcaID,
				pc.IndicadorMontoMinimo,
				coalesce(pd.Descripcion, pc.Descripcion) DescripcionProd,
				dbo.fnObtenerCantidadOfertaNueva(og.CUV, og.CampaniaID, og.UnidadesPermitidas,og.TipoOfertaSisID, og.ConfiguracionOfertaID) UnidadesPermitidas,
				isnull(pwd.CUV,'') IndicadorPedido,
				isnull(og.ganahasta, 0) ganahasta
			FROM dbo.OfertaNueva  og with(nolock)
			inner join ods.ProductoComercial pc with(nolock) on og.CUV = pc.CUV and og.CampaniaID = pc.AnoCampania
			inner join ods.Campania ca with(nolock) on pc.CampaniaID = ca.CampaniaID
			left join dbo.ProductoDescripcion pd with(nolock) on og.CampaniaID = pd.CampaniaID and og.CUV = pd.CUV
			left join PedidoWebDetalle pwd with(nolock) on pwd.CUV=og.CUV and pwd.CampaniaID= @CampaniaID and pwd.ConsultoraID=@ConsultoraID
			WHERE
				ca.CodiGO = @CampaniaID and
				og.FlagHabilitarOferta = 1 and
				og.NumeroPedido=@NumeroPedido and
				og.CUV not in(SELECT CUV FROM PedidoWebDetalle with(nolock) WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID)
		) a
		WHERE a.UnidadesPermitidas > 0
		order by 5 asc
	end
	else
	begin
		SELECT
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			'' MarcaID,
			'' IndicadorMontoMinimo,
			'' DescripcionProd,
			UnidadesPermitidas,
			0 IndicadorPedido,
			0 ganahasta
		FROM OfertaNueva with(nolock)
		WHERE OfertaNuevaID < 0
		order by 5 asc
	end
END
GO
/*end*/

USE BelcorpChile
GO
if object_id('fnGetTableTerritorioIdByFiltroAndUbigeo') is not null
begin
	drop function fnGetTableTerritorioIdByFiltroAndUbigeo;
end
GO
create function fnGetTableTerritorioIdByFiltroAndUbigeo(
	@TipoFiltroUbigeo int,
	@CodigoUbigeo varchar(24)
)
returns @List table (TerritorioID int, CodigoUbigeo varchar(24))
as
begin
	IF @TipoFiltroUbigeo = 1
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM ods.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 2
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 3
	BEGIN
		INSERT INTO @List
		SELECT TT.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		INNER JOIN ods.UBIGEO U with(nolock) ON U.UBIGEOID = T.TERRITORIOID
		INNER JOIN ods.TERRITORIO TT with(nolock) ON TT.CODIGOUBIGEO = U.CODIGOUBIGEO
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END

	return;
end
GO
IF OBJECT_ID('dbo.fnAddCampaniaAndNumero2') IS NOT NULL
BEGIN
	DROP FUNCTION dbo.fnAddCampaniaAndNumero2;
END
GO
CREATE FUNCTION dbo.fnAddCampaniaAndNumero2(
	@CampaniaActual INT,
	@AddNro INT,
	@NroCampanias INT
)
RETURNS INT
AS
BEGIN	
	DECLARE @AnioCampaniaActual INT = @CampaniaActual/100;
	DECLARE @NroCampaniaActual INT = @CampaniaActual%100;
	DECLARE @SumNroCampania INT = (@NroCampaniaActual + @AddNro) - 1;
	DECLARE @AnioCampaniaSiguiente INT = @AnioCampaniaActual + @SumNroCampania/@NroCampanias;
	DECLARE @NroCampaniaSiguiente INT = @SumNroCampania%@NroCampanias + 1;
	
	IF @NroCampaniaSiguiente < 1
	BEGIN
		SET @AnioCampaniaSiguiente = @AnioCampaniaSiguiente - 1;
		SET @NroCampaniaSiguiente = @NroCampaniaSiguiente + @NroCampanias;
	END
	DECLARE @CampaniaSiguiente INT = @AnioCampaniaSiguiente*100 + @NroCampaniaSiguiente;
	RETURN @CampaniaSiguiente;
END
GO
ALTER FUNCTION dbo.fnAddCampaniaAndNumero(
	@CodigoISO CHAR(2),
	@CampaniaActual INT,
	@AddNro INT
)
RETURNS INT
AS
BEGIN
	DECLARE @NroCampanias INT = IIF(
		ISNULL(@CodigoISO,'') <> '',
		(select top 1 NroCampanias from Pais with(nolock) where CodigoISO = @CodigoISO),
		(select top 1 NroCampanias from Pais with(nolock) where EstadoActivo = 1)
	);
	
	RETURN dbo.fnAddCampaniaAndNumero2(@CampaniaActual,@AddNro,@NroCampanias);
END
GO
ALTER FUNCTION dbo.fnGetConfiguracionCampania
(
	@PaisID tinyint,
	@ZonaID int,
	@RegionID int,
	@ConsultoraID bigint
)
RETURNS @TConfiguracionCampania TABLE(
	ID int,
	CampaniaID varchar(6),
	FechaInicioFacturacion datetime,
	FechaFinFacturacion datetime,
	CampaniaDescripcion varchar(6),
	HoraInicio time,
	HoraFin time,
	DiasAntes int,
	ZonaValida int,
	HoraInicioNoFacturable time,
	HoraCierreNoFacturable time,
	ZonaHoraria float,
	HoraCierreZonaNormal time,
	HoraCierreZonaDemAnti time,
	HoraCierreZonaDemAntiCierre time,
	EsZonaDemAnti int,
	DiasDuracionCronograma int,
	HabilitarRestriccionHoraria int,
	HorasDuracionRestriccion int,
	NroCampanias int,
	PROLSinStock bit,
	FechaFinFIC datetime,
	IndicadorOfertaFIC int,
	ImagenURLOfertaFIC varchar(500),
	NuevoPROL bit,
	ZonaNuevoPROL bit,
	EstadoSimplificacionCUV bit,
	EsquemaDAConsultora bit,	
	ValidacionInteractiva bit,
	MensajeValidacionInteractiva varchar(500),
	IndicadorEnviado bit,
	IndicadorGPRSB int,
	FechaActualPais datetime,
	EstadoPedido smallint,
	ValidacionAbierta BIT,
	FechaLimitePago SMALLDATETIME,
	AceptacionConsultoraDA int
)
AS
/*
select * from dbo.fnGetConfiguracionCampania(11,2161,2017,2)
*/
BEGIN
	-- Variables Pais
	DECLARE @CodigoISO CHAR(2)
	DECLARE @ZonaHoraria FLOAT
	DECLARE @HoraCierreZonaNormal TIME(0)
	DECLARE @HoraCierreZonaDemAnti TIME(0)
	DECLARE @NroCampanias INT
	DECLARE @PROLSinStock BIT
	DECLARE @NuevoPROL BIT
	DECLARE @EstadoSimplificacionCUV BIT
	DECLARE @EsquemaDAConsultora BIT
	DECLARE @TipoDA BIT
	DECLARE @PedidoFIC BIT

	select
		@CodigoISO = CodigoISO,
		@ZonaHoraria = ISNULL(ZonaHoraria,0),
		@HoraCierreZonaNormal = HoraCierreZonaNormal,
		@HoraCierreZonaDemAnti = HoraCierreZonaDemAnti,
		@NroCampanias = NroCampanias,
		@PROLSinStock = PROLSinStock,
		@NuevoPROL = NuevoPROL,
		@EstadoSimplificacionCUV = EstadoSimplificacionCUV,
		@EsquemaDAConsultora = EsquemaDAConsultora,
		@TipoDA = TipoDA,
		@PedidoFIC = PedidoFIC
	from Pais (nolock)
	where PaisId = @PaisID

	-- Variables ConfiguracionValidacion
	DECLARE @HoraInicio time(0)
	DECLARE @HoraFin time(0)
	DECLARE @DiasAntes tinyint
	DECLARE @HoraInicioNoFacturable time(0)
	DECLARE @HoraCierreNoFacturable time(0)
	DECLARE @HabilitarRestriccionHoraria bit
	DECLARE @HorasDuracionRestriccion INT
	DECLARE @ValidacionInteractiva bit
	DECLARE @MensajeValidacionInteractiva varchar(500)

	SELECT
		@HoraInicio = HoraInicio,
		@HoraFin = HoraFin,
		@DiasAntes = DiasAntes,
		@HoraInicioNoFacturable = HoraInicioNoFacturable,
		@HoraCierreNoFacturable = HoraCierreNoFacturable,
		@HabilitarRestriccionHoraria = HabilitarRestriccionHoraria,
		@HorasDuracionRestriccion =  ISNULL(HorasDuracionRestriccion,0),
		@ValidacionInteractiva = ValidacionInteractiva,
		@MensajeValidacionInteractiva = MensajeValidacionInteractiva
	FROM [dbo].[ConfiguracionValidacion] (nolock)
	WHERE  PaisID = @PaisID

	 -- Variables ConfiguracionValidacionZona
	DECLARE @DiasDuracionCronograma tinyint
	SET @DiasDuracionCronograma = 1
	DECLARE @ZonaValida int
	DECLARE @IndicadorDias bit
	SET @IndicadorDias = 0

	select
		@DiasDuracionCronograma = DiasDuracionCronograma,
		@ZonaValida = ZonaID,
		@IndicadorDias = ValidacionActiva
	from ConfiguracionValidacionZona with(nolock)
	where CampaniaID = 201301 and ZonaID = @ZonaID

	-- Dias Duracion Cronograma para Nuevas (CR)
	IF @PaisID = 5 OR @PaisID = 8 OR @PaisID = 7 OR @PaisID = 10
	BEGIN
		declare @UCF int = 0;
		declare @SID int = 0;

		select
			@UCF = ISNULL(UltimaCampanaFacturada,0),
			@SID = ISNULL(SegmentoId,0)
		from ods.Consultora with(nolock)
		where ConsultoraID = @ConsultoraID

		IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
			SET @DiasDuracionCronograma = 2
	END

	-- Variables ConfiguracionValidacionNuevoPROL
	DECLARE @ZonaNuevoPROL BIT = 0;
	DECLARE @ContNuevoPROL INT = 0;

	IF @NuevoPROL = 1
	BEGIN
		SELECT @ContNuevoPROL = COUNT(ZonaId)
		FROM ConfiguracionValidacionNuevoPROL with(nolock)
		WHERE ZonaId = @ZonaId

		IF @ContNuevoPROL > 0
			SET @ZonaNuevoPROL = 1
	END

	-- Otras Configuraciones
	IF @IndicadorDias = 0
		SET @DiasAntes = 0

	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	DECLARE @AceptacionConsultoraDA INT
	SET @AceptacionConsultoraDA = -1

	-- Obtener Campania Anterior
	DECLARE @Campania INT
	DECLARE @Anio INT
	SET @Campania = 0

	IF @EsquemaDAConsultora = 0
	BEGIN
		IF @TipoDA = 0
		BEGIN
			SELECT TOP 1
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
			WHERE
				c.ZonaID = @ZonaID AND
				c.RegionID = @RegionID AND
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
		ELSE
		BEGIN
			SELECT TOP 1	
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID		
			LEFT JOIN [dbo].[Cronograma] cr (nolock) ON 
				c.CampaniaID = cr.CampaniaID AND
				c.RegionID = cr.RegionID AND
				c.ZonaID = cr.ZonaID
			WHERE 
				c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
				IIF(@PaisID = 4,
					ISNULL(CONVERT(datetime, cr.FechaInicioDD) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioReFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal)),
					ISNULL(CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
								ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
								CONVERT(datetime, @HoraCierreZonaNormal))
				) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
	END
	ELSE
	BEGIN

		DECLARE @Campania_temp INT
		DECLARE @Anio_temp INT
		SET @Campania_temp = 0

		SELECT TOP 1
			@Campania_temp = ca.Codigo,
			@Anio_temp = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
				ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
		ORDER BY c.CampaniaID DESC

		IF(@Campania_temp <> 0)
		BEGIN
			SET @Campania_temp = @Campania_temp - @Anio_temp
			IF(@Campania_temp = @NroCampanias)
				SET @Campania_temp = @Anio_temp + 101
			ELSE
				SET @Campania_temp = @Anio_temp + @Campania_temp + 1

			SELECT @AceptacionConsultoraDA = TipoConfiguracion
			FROM ConfiguracionConsultoraDA with(nolock)
			WHERE			
				ConsultoraId = @ConsultoraId and
				ZonaId = @ZonaId and
				CampaniaId = cast(@Campania_temp as int)
		END

		SELECT TOP 1
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			IIF(@AceptacionConsultoraDA < 1,
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal),
				CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti)) < @FechaGeneral
		ORDER BY c.CampaniaID DESC
	END
	
	--Obtiene UltimaCampaniaFacturada
	declare @UltimaCampanaFacturada int;
	declare @TipoFacturacion char(2);
	declare @ConsultoraIdAsociada bigint;

	select
		@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0),
		@TipoFacturacion = ISNULL(TipoFacturacion,'')
	From ods.consultora (nolock)
	Where consultoraid = @consultoraid

	--Obtiene UltimaCampaniaFacturada x UsuarioPrueba
	IF @UltimaCampanaFacturada IS NULL
	BEGIN
		SELECT
			@UltimaCampanaFacturada = ISNULL(c.UltimaCampanaFacturada,0),
			@TipoFacturacion = ISNULL(c.TipoFacturacion,''),
			@ConsultoraIdAsociada = ISNULL(c.ConsultoraId,0)
		FROM ConsultoraFicticia cf with(nolock)
		INNER JOIN UsuarioPrueba up with(nolock) on cf.Codigo = up.CodigoFicticio
		INNER JOIN ods.Consultora c with(nolock) on up.CodigoConsultoraAsociada = c.Codigo
		WHERE cf.ConsultoraId = @consultoraid
	END

	IF @TipoFacturacion <> 'FA'
	BEGIN
		SET @UltimaCampanaFacturada = dbo.fnAddCampaniaAndNumero(@CodigoISO,@UltimaCampanaFacturada,-1);
	END

	-- Valida Campania Anterior
	IF(@Campania <> 0)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1

		IF @EsquemaDAConsultora = 1 AND @Campania > @Campania_temp
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
		
		-- validar si pertenece a una zona DA
		DECLARE @EsZonaDA BIT;
		SELECT @EsZonaDA = IIF(ISNULL(c.CampaniaID,0) = 0,0,1)
		FROM dbo.Cronograma c 
		INNER JOIN ods.Campania ca ON c.CampaniaID = ca.CampaniaID 
		WHERE
			ca.Codigo = @Campania_temp AND
			c.RegionID = @RegionID AND
			c.ZonaID = @ZonaID AND
			c.TipoCronograma = 2

		-- si el esquema es de DA y la zona es de DA y ya facturo en la campaña actual 
		-- y la consultora respondio que no en la DA anterior
		-- se resetea la variable
		IF (@EsquemaDAConsultora = 1 AND @EsZonaDA = 1 AND @UltimaCampanaFacturada = @Campania_temp AND @AceptacionConsultoraDA = 0) 
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
	END
	ELSE
	BEGIN
		SELECT TOP 1 
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		WHERE z.ZonaID = @ZonaID AND z.RegionID = @RegionID
		ORDER BY c.FechaInicioFacturacion ASC
	END

	--Valida UltimaCampaniaFacturada
	IF (@UltimaCampanaFacturada = @Campania)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1
	END
	ELSE
	BEGIN
		DECLARE @IndicadorEnviado BIT= 0, @ValidacionAbierta BIT = 0
		DECLARE @IndicadorGPR TINYINT = 0
		DECLARE @EstadoPedido SMALLINT
  
		SELECT	@IndicadorEnviado  = IndicadorEnviado,  
				@IndicadorGPR = GPRSB, 
				@EstadoPedido = EstadoPedido, 
				@ValidacionAbierta = ValidacionAbierta
		FROM	Pedidoweb (nolock)
		WHERE	CampaniaID = @campania and consultoraid = ISNULL(@ConsultoraIdAsociada,@consultoraid)	

		If(@IndicadorEnviado = 1 AND @IndicadorGPR = 0)
		BEGIN
			SET @Campania = @Campania - @Anio
			IF(@Campania = @NroCampanias)
				SET @Campania = @Anio + 101
			ELSE
				SET @Campania = @Anio + @Campania + 1
		END
	END

	-- Pedido FIC
	DECLARE @FechaFinFIC datetime;
	DECLARE @IndicadorOfertaFIC int = 0;
	DECLARE @ImagenURLOfertaFIC varchar(500) = '';

	IF @PedidoFIC = 1
	BEGIN
		DECLARE @campaniaFIC INT
		IF substring(cast(@Campania as varchar(6)),5,2)=cast(@NroCampanias as char(2))
			set @campaniaFIC=cast(cast( cast(substring(cast(@Campania as varchar(6)),1,4)as int)+1 as varchar(4)) + '01' as int)
		ELSE
			set @campaniaFIC= @Campania +1

		SELECT @FechaFinFIC=isnull(FechaFin,GETDATE())
		FROM CronogramaFIC with(nolock)
		WHERE 
			ZonaID=@ZonaID and 
			CampaniaID = (				
				SELECT CampaniaID
				FROM ods.Campania with(nolock)
				WHERE Codigo=@campaniaFIC
			);

		select top 1
			@IndicadorOfertaFIC = 1,
			@ImagenURLOfertaFIC = isnull(ImagenUrl,'')
		from OfertaFIC (nolock)
		where CampaniaID = @campaniaFIC;
	END
			
	-- Listar Variables
	IF @EsquemaDAConsultora = 0
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@TipoDA = 0,c.FechaInicioFacturacion,ISNULL(cr.FechaInicioWeb, c.FechaInicioFacturacion)) AS FechaInicioFacturacion,
			IIF(@TipoDA = 0,
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				IIF(@PaisID = 4,
					ISNULL(cr.FechaInicioDD,c.FechaInicioReFacturacion),
					ISNULL(cr.FechaInicioWeb,c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
						ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)))
			) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@TipoDA = 0, @HoraFin,IIF(ISNULL(cr.CampaniaId,0) = 0,@HoraFin,@HoraCierreZonaDemAnti)) as HoraFin,
			@DiasAntes AS DiasAntes,
			ISNULL(@ZonaValida,-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(@TipoDA = 0, 0, IIF(ISNULL(cr.CampaniaId,0) = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END
	ELSE
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@AceptacionConsultoraDA < 1, c.FechaInicioFacturacion, cr.FechaInicioWeb) AS FechaInicioFacturacion,
			IIF(@AceptacionConsultoraDA < 1, 
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				cr.FechaInicioWeb) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@AceptacionConsultoraDA < 1, @HoraFin, @HoraCierreZonaDemAnti) as HoraFin,
			@DiasAntes AS DiasAntes,
			IIF(@AceptacionConsultoraDA < 1,ISNULL(@ZonaValida,-1),-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			IIF(@AceptacionConsultoraDA < 1,@HoraCierreZonaNormal,@HoraCierreZonaDemAnti) AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(ISNULL(cr.CampaniaId,0) = 0,0,IIF(@AceptacionConsultoraDA = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END

	RETURN
END
GO
ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @CodigoConsultora VARCHAR(50);
	SELECT TOP 1 @CodigoConsultora = co.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		iif(@PaisValido = 1, CO.ZonaID, CO.TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) AND
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	RETURN ISNULL(@CodigoConsultora, '');
END
GO
ALTER FUNCTION dbo.ObtenerConsultoraVecina
(
	@PaisID INT,
	@EdadMaxima INT,
	@UltimaCampanaFacturada INT,
	@ListadoConsultoraId dbo.IdBigintType READONLY,
	@RegionID INT,
	@ZonaID INT,
	@SeccionID INT,
	@TerritorioID INT
)
RETURNS @Consultora TABLE(
	ConsultoraID BIGINT,
	Codigo VARCHAR(30)
)
AS
BEGIN
	INSERT INTO @Consultora(ConsultoraID, Codigo)
	SELECT TOP 1 CO.ConsultoraID, CO.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID      
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, CO.FechaNacimiento, getdate()) <= @EdadMaxima AND
		CO.UltimaCampanaFacturada >= @UltimaCampanaFacturada AND
		CO.ConsultoraID NOT IN (SELECT Id FROM @ListadoConsultoraId) AND
		CO.RegionID = @RegionID AND CO.ZonaID = @ZonaID AND
		(@SeccionID = 0 OR CO.SeccionID = @SeccionID) AND
		(@TerritorioID = 0 OR CO.TerritorioID = @TerritorioID)
	ORDER BY MontoUltimoPedido DESC;
           
	RETURN;
END
GO
ALTER FUNCTION ValidarAutorizacion
(
	@paisID			INT,
	@CodigoUsuario	VARCHAR(100)
)
RETURNS INT
AS
/*
	SELECT DBO.ValidarAutorizacion(3, '1281283')
	SELECT DBO.ValidarAutorizacion(3, '076912262')
*/
BEGIN
	DECLARE @Usuario VARCHAR(100),
            @RolID INT,
            @AutorizaPedido VARCHAR(10),
            @IdEstadoActividad INT,
            @UltimaCampania INT,
            @CampaniaActual INT,
			@Resultado	INT,
			@CodigoConsultora varchar(20),
			@ZonaID INT,
			@RegionID INT,
			@ConsultoraID INT

	SET @RolID = 0
	SET @Usuario = ''
	SET @IdEstadoActividad = -1
	SET @UltimaCampania = 0
	SET @CampaniaActual = 0
	SET @Resultado = 0	

	SELECT	
		@CodigoConsultora = IsNull(CodigoConsultora,0),
		@PaisID = IsNull(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE codigousuario = @CodigoUsuario

	SELECT	
		@ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
		@AutorizaPedido = ISNULL(AutorizaPedido,''),
		@UltimaCampania = ISNULL(UltimaCampanaFacturada,0)
	FROM ods.consultora WITH(NOLOCK)
	WHERE codigo = @CodigoConsultora

	SELECT 
		@Usuario = u.CodigoUsuario, 
		@RolID = ISNULL(ur.RolId,0),
		@AutorizaPedido = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END),
		@CampaniaActual = ISNULL((SELECT TOP 1 campaniaId FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	FROM Usuario u WITH(NOLOCK)
		LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

    --0: Usuario No Existe
    --1: Usuario No es del Portal
    --2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
    --3: Usuario OK
	DECLARE @tabla_Retirada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Retirada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 12
	
	DECLARE @tabla_Reingresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Reingresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 18
	
	DECLARE @tabla_Egresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Egresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 19

    IF @Usuario IS NOT NULL AND @Usuario <> ''
    BEGIN
        IF @RolID != 0
        BEGIN
            IF @AutorizaPedido IS NOT NULL AND @AutorizaPedido <> ''
            BEGIN
                IF @IdEstadoActividad <> -1
                BEGIN
                    -- Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
                    IF @paisID = 11 OR @paisID = 2 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                    BEGIN
                        --Validamos si el estado es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                            BEGIN
                                --Caso Colombia
								IF @paisID = 4
								BEGIN
                                    SET @Resultado =  2
                                END
								ELSE
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                            END
                            ELSE
                            BEGIN
                                --Para bolivia (FOX) se hace la validación del campo AutorizaPedido
                                IF @paisID = 2
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                BEGIN
                                    SET @Resultado =  3
                                END
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es reingresada
                            IF EXISTS(SELECT 1 FROM @tabla_Reingresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
                                IF @paisID = 3
                                BEGIN
                                    --Se valida las campañas que no ha ingresado
									DECLARE @CampaniasSinIngresar INT = 0;
                                    IF LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampania) = 6
                                    BEGIN
										set @CampaniasSinIngresar = @CampaniaActual - dbo.fnAddCampaniaAndNumero(null,@UltimaCampania,3);
                                    END

                                    IF @CampaniasSinIngresar > 0
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        --Validamos el Autoriza Pedido
                                        IF @AutorizaPedido = 'N'
                                            SET @Resultado =  2
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                                ELSE
                                BEGIN
                                    --Caso Colombia
                                    IF @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        IF @AutorizaPedido = 'N'
                                        BEGIN
                                            --Validamos si es SICC o Bolivia
                                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2
                                                SET @Resultado =  2
                                            ELSE
                                                SET @Resultado =  3
                                        END
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                            END
                            ELSE
                            BEGIN
                                --Caso Colombia
                                IF @paisID = 4
                                BEGIN
                                    --Egresada o Posible Egreso
                                    IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                                    BEGIN
                                        SET @Resultado =  2
                                    END
                                END

                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC o Bolivia
                                    IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2 OR @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3

                            END
                        END
                    END
                    -- Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
                    ELSE IF @paisID = 5 OR @paisID = 10 OR @paisID = 9 OR @paisID = 12 OR @paisID = 13 OR @paisID = 6 OR @paisID = 1 OR @paisID = 14
                    BEGIN
                        -- Validamos si la consultora es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                    SET @Resultado =  2
                                ELSE
                                    SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    SET @Resultado =  2
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es retirada
                            IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
								IF @AutorizaPedido = 'N'
								BEGIN
									--Validamos si es SICC
									IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
										SET @Resultado =  2
									ELSE
										SET @Resultado =  3
								END
								ELSE
									SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC
                                    IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                    END
                    ELSE
                        SET @Resultado = 3
                END
                ELSE
                    SET @Resultado = 3 --Se asume para usuarios del tipo SAC
            END
            ELSE
                SET @Resultado = 3 --Se asume para usuarios del tipo SAC
        END
        ELSE
            SET @Resultado = 1
    END
    ELSE
        SET @Resultado = 0

    RETURN @Resultado

END
GO
ALTER PROCEDURE dbo.GetSesionUsuario_SB2
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	
	DECLARE @FechaLimitePago SMALLDATETIME
	DECLARE @ODSCampaniaID INT
	
	declare @PaisID int
	declare @UsuarioPrueba bit
	declare @CodConsultora varchar(20)
	declare @CampaniaID int
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint
	declare @UltimaCampanaFacturada int
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario

	declare @CountCodigoNivel bigint

	/*Oferta Final, Catalogo Personalizado, CDR*/
	declare @EsOfertaFinalZonaValida bit = 0
	declare @EsOFGanaMasZonaValida bit = 0
	declare @EsCatalogoPersonalizadoZonaValida bit = 0
	declare @EsCDRWebZonaValida  bit = 0
	declare @CodigoZona varchar(4) = ''
	declare @CodigoRegion varchar(2) = ''

	select
		@CodigoZona = IsNull(z.Codigo,''),
		@CodigoRegion = IsNull(r.Codigo,'')
	from ods.consultora c with(nolock)
	inner join ods.Region r on
		c.RegionID = r.RegionID
	inner join ods.Zona z on
		c.ZonaID = z.ZonaID
	where c.codigo = @CodConsultora

	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
		
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/

	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;
	
	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919

	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0

		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;

		/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,-11), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
		)

		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			isnull(c.EsJoven,0) EsJoven,
			(case
				when @CountCodigoNivel =0 then 0  --1589
				when @CountCodigoNivel>0 then 1 End) Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			null as ConsultoraAsociada, --1688
			isnull(si.descripcion,null) SegmentoConstancia, --2469
			isnull(se.Codigo,null) Seccion, --2469
			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469
			case When cl.ConsultoraID is null then 0
				else 1 end esConsultoraLider,
			u.EMailActivo, --2532
			si.SegmentoInternoId,
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u with(nolock)
		LEFT JOIN (
			select *
			from ods.consultora with(nolock)
			where ConsultoraId = @ConsultoraID
		) c ON u.CodigoConsultora = c.Codigo
		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID
		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469
		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469
		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t with(nolock) ON 
			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeo
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@MarcaId int,
	@tipoFiltroUbigeo int
)    
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;
	
	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
	
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';
	
	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1,''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2,''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3,'')
	FROM Ubigeo U with(nolock)
	WHERE codigoubigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		--ISNULL((select top 1 campaniaId from dbo.GetCampaniaPreLogin(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID)),0) as CampaniaActual,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND (@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite) AND
		UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.CampaniaId, -2)
	ORDER BY C.UltimaCampanaFacturada DESC, C.MontoUltimoPedido DESC
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@Nombres varchar(51),
	@Apellidos varchar(51),
	@MarcaId int,
	@tipoFiltroUbigeo int
)
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;

	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
 
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';

	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1, ''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2, ''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3, '')
	FROM Ubigeo with(nolock)
	WHERE CodigoUbigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND
		CONCAT(PrimerNombre,' ',SegundoNombre) LIKE CONCAT('%',@Nombres,'%') AND
		CONCAT(PrimerApellido,' ',SegundoApellido) LIKE CONCAT('%',@Apellidos,'%') AND
		(@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite);
END
GO
ALTER PROCEDURE dbo.GetConsultorasPorUbigeo
	@PaisId int,    
	@CodigoUbigeo varchar(24),    
	@Campania int,    
	@MarcaId int,
	@tipoFiltroUbigeo int
AS    
BEGIN
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	CREATE TABLE #TempConsultoraUbigeo    
	(    
		ID int IDENTITY,    
		ConsultoraID bigint,    
		Codigo varchar(100),    
		CodigoUbigeo varchar(24),    
		NombreCompletoConsultora varchar(300),    
		Email varchar(200),      
		FechaNacimiento datetime,    
		MONTOULTIMOPEDIDO MONEY,    
		UltimaCampanaFacturada INT,     
		CodigoUsuario varchar(100),    
		ZonaID int,    
		RegionID int  
	)

	INSERT INTO #TempConsultoraUbigeo  
    SELECT DISTINCT
		C.ConsultoraID,    
		C.Codigo,
		@CodigoUbigeo as CodigoUbigeo,
		C.NombreCompleto as NombreCompletoConsultora,
		U.Email,
		FechaNacimiento,
		MONTOULTIMOPEDIDO,
		UltimaCampanaFacturada,
		u.CodigoUsuario,
		c.ZonaID,
		c.RegionID    
    FROM ods.CONSULTORA AS C  
    INNER JOIN AFILIACLIENTECONSULTORA AS ACC ON C.CONSULTORAID = ACC.CONSULTORAID  
    INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo   
    WHERE ACC.EsAfiliado = 1 AND C.TERRITORIOID IN (SELECT TerritorioID FROM @TerritorioObjetivo);
		
    IF @MarcaId = 3    
    BEGIN
		DECLARE @EDADLIMITE INT = (SELECT Codigo FROM TABLALOGICADATOS WHERE TABLALOGICAID = 56 AND TABLALOGICADATOSID = 5605);

		DELETE FROM #TempConsultoraUbigeo 
		WHERE ID IN(  
			SELECT ID
			FROM #TempConsultoraUbigeo  
			WHERE (YEAR(getdate()) - year(FechaNacimiento)) >= @EDADLIMITE
		);
    END  
  
   -- -- FILTRANDO CONSULTORAS QUE HAYAN FACTURADO EN LA CAMPAÑANA ANTERIOR  
    --R2442 -  JC - Ya no filtrará por Campaña actual  
    SELECT TCU.ConsultoraID, TCU.Codigo, TCU.CodigoUbigeo, TCU.NombreCompletoConsultora as NombreCompleto, TCU.Email
    FROM #TempConsultoraUbigeo TCU
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,TCU.ZonaID,TCU.RegionID,TCU.ConsultoraID) CC
    WHERE
		dbo.ValidarAutorizacion(@PaisId, TCU.CodigoUsuario) = 3 AND
		TCU.UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.campaniaId, -2)
	order by ULTIMACAMPANAFACTURADA DESC , MONTOULTIMOPEDIDO DESC --R2626 
	
	DROP TABLE #TempConsultoraUbigeo;
END
GO
ALTER PROCEDURE GetProductosOfertaConsultoraNueva
	@CampaniaID INT,
	@ConsultoraID INT
AS
BEGIN
	DECLARE @NroCampania INT = (SELECT TOP 1 nrocampanias FROM pais with(nolock) WHERE EstadoActivo = 1);

	DECLARE @ultimacampaniafacturable INT;
	DECLARE @idcampaniaingreso INT;
	SELECT
		@idcampaniaingreso = AnoCampanaIngreso,
		@ultimacampaniafacturable = isnull(iif(TipoFacturacion = 'FA', UltimaCampanaFacturada, dbo.fnAddCampaniaAndNumero(UltimaCampanaFacturada,-1,@NroCampania)),0)
	FROM ods.Consultora WHERE ConsultoraID=@ConsultoraID;
		
	DECLARE @campaniafacturableingreso INT = @ultimacampaniafacturable - @idcampaniaingreso;
	DECLARE @campaniacompare INT = dbo.fnAddCampaniaAndNumero2(@ultimacampaniafacturable,1,@NroCampania);
	DECLARE @NumeroPedido INT;	
	DECLARE @indicador INT = 0;

	if @CampaniaID = @campaniacompare and (@campaniafacturableingreso between 0 and 3)
	begin		
		declare @CampaniaID1 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -1, @NroCampania);
		declare @CampaniaID2 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -2, @NroCampania);
		declare @CampaniaID3 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -3, @NroCampania);
		declare @CampaniaID4 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -4, @NroCampania);

		declare @idCampaniaID1 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID1);
		declare @idCampaniaID2 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID2);
		declare @idCampaniaID3 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID3);
		declare @idCampaniaID4 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID4);

		declare @campaniasFacturas int;

		---la consultora es nueva, esta realizando su segundo pedido compruebo que la campaña anterior tenga pedido facturado
		if @campaniafacturableingreso = 0
		begin
			set @NumeroPedido = 1;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1) and consultoraid = @ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 1, 1,0);
		end
		---la consultora es nueva, esta realizando su tercer pedido compruebo que las 2 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 1
		begin
			set @NumeroPedido=2;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 2, 1,0);
		end
		---la consultora es nueva, esta realizando su cuarto pedido compruebo que las 3 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 2
		begin
			set @NumeroPedido=3;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 3, 1,0);
		end
		---la consultora es nueva, esta realizando su quINTo pedido compruebo que las 4 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 3
		begin
			set @NumeroPedido=4;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido (nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3,@idCampaniaID4) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 4, 1,0);
		end
	end

	IF @indicador = 1 and (@campaniafacturableingreso between 0 and 3)
	begin
		SELECT TOP 4
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			MarcaID,
			IndicadorMontoMinimo,
			DescripcionProd,
			UnidadesPermitidas,
			(case when len(IndicadorPedido) >0 then 1 else 0 end) IndicadorPedido,
			ganahasta
		FROM (
			SELECT
				og.OfertaNuevaId,
				og.NumeroPedido,
				case isnull(og.FlagImagenActiva,0)
					when 1 then og.ImagenProducto01
					when 2 then og.ImagenProducto02
					when 3 then og.ImagenProducto03
					else ''
				end ImagenProducto01,
				og.Descripcion,
				og.CUV,
				og.PrecioNormal,
				og.PrecioParaTi,
				pc.MarcaID,
				pc.IndicadorMontoMinimo,
				coalesce(pd.Descripcion, pc.Descripcion) DescripcionProd,
				dbo.fnObtenerCantidadOfertaNueva(og.CUV, og.CampaniaID, og.UnidadesPermitidas,og.TipoOfertaSisID, og.ConfiguracionOfertaID) UnidadesPermitidas,
				isnull(pwd.CUV,'') IndicadorPedido,
				isnull(og.ganahasta, 0) ganahasta
			FROM dbo.OfertaNueva  og with(nolock)
			inner join ods.ProductoComercial pc with(nolock) on og.CUV = pc.CUV and og.CampaniaID = pc.AnoCampania
			inner join ods.Campania ca with(nolock) on pc.CampaniaID = ca.CampaniaID
			left join dbo.ProductoDescripcion pd with(nolock) on og.CampaniaID = pd.CampaniaID and og.CUV = pd.CUV
			left join PedidoWebDetalle pwd with(nolock) on pwd.CUV=og.CUV and pwd.CampaniaID= @CampaniaID and pwd.ConsultoraID=@ConsultoraID
			WHERE
				ca.CodiGO = @CampaniaID and
				og.FlagHabilitarOferta = 1 and
				og.NumeroPedido=@NumeroPedido and
				og.CUV not in(SELECT CUV FROM PedidoWebDetalle with(nolock) WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID)
		) a
		WHERE a.UnidadesPermitidas > 0
		order by 5 asc
	end
	else
	begin
		SELECT
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			'' MarcaID,
			'' IndicadorMontoMinimo,
			'' DescripcionProd,
			UnidadesPermitidas,
			0 IndicadorPedido,
			0 ganahasta
		FROM OfertaNueva with(nolock)
		WHERE OfertaNuevaID < 0
		order by 5 asc
	end
END
GO
/*end*/

USE BelcorpColombia
GO
if object_id('fnGetTableTerritorioIdByFiltroAndUbigeo') is not null
begin
	drop function fnGetTableTerritorioIdByFiltroAndUbigeo;
end
GO
create function fnGetTableTerritorioIdByFiltroAndUbigeo(
	@TipoFiltroUbigeo int,
	@CodigoUbigeo varchar(24)
)
returns @List table (TerritorioID int, CodigoUbigeo varchar(24))
as
begin
	IF @TipoFiltroUbigeo = 1
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM ods.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 2
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 3
	BEGIN
		INSERT INTO @List
		SELECT TT.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		INNER JOIN ods.UBIGEO U with(nolock) ON U.UBIGEOID = T.TERRITORIOID
		INNER JOIN ods.TERRITORIO TT with(nolock) ON TT.CODIGOUBIGEO = U.CODIGOUBIGEO
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END

	return;
end
GO
IF OBJECT_ID('dbo.fnAddCampaniaAndNumero2') IS NOT NULL
BEGIN
	DROP FUNCTION dbo.fnAddCampaniaAndNumero2;
END
GO
CREATE FUNCTION dbo.fnAddCampaniaAndNumero2(
	@CampaniaActual INT,
	@AddNro INT,
	@NroCampanias INT
)
RETURNS INT
AS
BEGIN	
	DECLARE @AnioCampaniaActual INT = @CampaniaActual/100;
	DECLARE @NroCampaniaActual INT = @CampaniaActual%100;
	DECLARE @SumNroCampania INT = (@NroCampaniaActual + @AddNro) - 1;
	DECLARE @AnioCampaniaSiguiente INT = @AnioCampaniaActual + @SumNroCampania/@NroCampanias;
	DECLARE @NroCampaniaSiguiente INT = @SumNroCampania%@NroCampanias + 1;
	
	IF @NroCampaniaSiguiente < 1
	BEGIN
		SET @AnioCampaniaSiguiente = @AnioCampaniaSiguiente - 1;
		SET @NroCampaniaSiguiente = @NroCampaniaSiguiente + @NroCampanias;
	END
	DECLARE @CampaniaSiguiente INT = @AnioCampaniaSiguiente*100 + @NroCampaniaSiguiente;
	RETURN @CampaniaSiguiente;
END
GO
ALTER FUNCTION dbo.fnAddCampaniaAndNumero(
	@CodigoISO CHAR(2),
	@CampaniaActual INT,
	@AddNro INT
)
RETURNS INT
AS
BEGIN
	DECLARE @NroCampanias INT = IIF(
		ISNULL(@CodigoISO,'') <> '',
		(select top 1 NroCampanias from Pais with(nolock) where CodigoISO = @CodigoISO),
		(select top 1 NroCampanias from Pais with(nolock) where EstadoActivo = 1)
	);
	
	RETURN dbo.fnAddCampaniaAndNumero2(@CampaniaActual,@AddNro,@NroCampanias);
END
GO
ALTER FUNCTION dbo.fnGetConfiguracionCampania
(
	@PaisID tinyint,
	@ZonaID int,
	@RegionID int,
	@ConsultoraID bigint
)
RETURNS @TConfiguracionCampania TABLE(
	ID int,
	CampaniaID varchar(6),
	FechaInicioFacturacion datetime,
	FechaFinFacturacion datetime,
	CampaniaDescripcion varchar(6),
	HoraInicio time,
	HoraFin time,
	DiasAntes int,
	ZonaValida int,
	HoraInicioNoFacturable time,
	HoraCierreNoFacturable time,
	ZonaHoraria float,
	HoraCierreZonaNormal time,
	HoraCierreZonaDemAnti time,
	HoraCierreZonaDemAntiCierre time,
	EsZonaDemAnti int,
	DiasDuracionCronograma int,
	HabilitarRestriccionHoraria int,
	HorasDuracionRestriccion int,
	NroCampanias int,
	PROLSinStock bit,
	FechaFinFIC datetime,
	IndicadorOfertaFIC int,
	ImagenURLOfertaFIC varchar(500),
	NuevoPROL bit,
	ZonaNuevoPROL bit,
	EstadoSimplificacionCUV bit,
	EsquemaDAConsultora bit,	
	ValidacionInteractiva bit,
	MensajeValidacionInteractiva varchar(500),
	IndicadorEnviado bit,
	IndicadorGPRSB int,
	FechaActualPais datetime,
	EstadoPedido smallint,
	ValidacionAbierta BIT,
	FechaLimitePago SMALLDATETIME,
	AceptacionConsultoraDA int
)
AS
/*
select * from dbo.fnGetConfiguracionCampania(11,2161,2017,2)
*/
BEGIN
	-- Variables Pais
	DECLARE @CodigoISO CHAR(2)
	DECLARE @ZonaHoraria FLOAT
	DECLARE @HoraCierreZonaNormal TIME(0)
	DECLARE @HoraCierreZonaDemAnti TIME(0)
	DECLARE @NroCampanias INT
	DECLARE @PROLSinStock BIT
	DECLARE @NuevoPROL BIT
	DECLARE @EstadoSimplificacionCUV BIT
	DECLARE @EsquemaDAConsultora BIT
	DECLARE @TipoDA BIT
	DECLARE @PedidoFIC BIT

	select
		@CodigoISO = CodigoISO,
		@ZonaHoraria = ISNULL(ZonaHoraria,0),
		@HoraCierreZonaNormal = HoraCierreZonaNormal,
		@HoraCierreZonaDemAnti = HoraCierreZonaDemAnti,
		@NroCampanias = NroCampanias,
		@PROLSinStock = PROLSinStock,
		@NuevoPROL = NuevoPROL,
		@EstadoSimplificacionCUV = EstadoSimplificacionCUV,
		@EsquemaDAConsultora = EsquemaDAConsultora,
		@TipoDA = TipoDA,
		@PedidoFIC = PedidoFIC
	from Pais (nolock)
	where PaisId = @PaisID

	-- Variables ConfiguracionValidacion
	DECLARE @HoraInicio time(0)
	DECLARE @HoraFin time(0)
	DECLARE @DiasAntes tinyint
	DECLARE @HoraInicioNoFacturable time(0)
	DECLARE @HoraCierreNoFacturable time(0)
	DECLARE @HabilitarRestriccionHoraria bit
	DECLARE @HorasDuracionRestriccion INT
	DECLARE @ValidacionInteractiva bit
	DECLARE @MensajeValidacionInteractiva varchar(500)

	SELECT
		@HoraInicio = HoraInicio,
		@HoraFin = HoraFin,
		@DiasAntes = DiasAntes,
		@HoraInicioNoFacturable = HoraInicioNoFacturable,
		@HoraCierreNoFacturable = HoraCierreNoFacturable,
		@HabilitarRestriccionHoraria = HabilitarRestriccionHoraria,
		@HorasDuracionRestriccion =  ISNULL(HorasDuracionRestriccion,0),
		@ValidacionInteractiva = ValidacionInteractiva,
		@MensajeValidacionInteractiva = MensajeValidacionInteractiva
	FROM [dbo].[ConfiguracionValidacion] (nolock)
	WHERE  PaisID = @PaisID

	 -- Variables ConfiguracionValidacionZona
	DECLARE @DiasDuracionCronograma tinyint
	SET @DiasDuracionCronograma = 1
	DECLARE @ZonaValida int
	DECLARE @IndicadorDias bit
	SET @IndicadorDias = 0

	select
		@DiasDuracionCronograma = DiasDuracionCronograma,
		@ZonaValida = ZonaID,
		@IndicadorDias = ValidacionActiva
	from ConfiguracionValidacionZona with(nolock)
	where CampaniaID = 201301 and ZonaID = @ZonaID

	-- Dias Duracion Cronograma para Nuevas (CR)
	IF @PaisID = 5 OR @PaisID = 8 OR @PaisID = 7 OR @PaisID = 10
	BEGIN
		declare @UCF int = 0;
		declare @SID int = 0;

		select
			@UCF = ISNULL(UltimaCampanaFacturada,0),
			@SID = ISNULL(SegmentoId,0)
		from ods.Consultora with(nolock)
		where ConsultoraID = @ConsultoraID

		IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
			SET @DiasDuracionCronograma = 2
	END

	-- Variables ConfiguracionValidacionNuevoPROL
	DECLARE @ZonaNuevoPROL BIT = 0;
	DECLARE @ContNuevoPROL INT = 0;

	IF @NuevoPROL = 1
	BEGIN
		SELECT @ContNuevoPROL = COUNT(ZonaId)
		FROM ConfiguracionValidacionNuevoPROL with(nolock)
		WHERE ZonaId = @ZonaId

		IF @ContNuevoPROL > 0
			SET @ZonaNuevoPROL = 1
	END

	-- Otras Configuraciones
	IF @IndicadorDias = 0
		SET @DiasAntes = 0

	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	DECLARE @AceptacionConsultoraDA INT
	SET @AceptacionConsultoraDA = -1

	-- Obtener Campania Anterior
	DECLARE @Campania INT
	DECLARE @Anio INT
	SET @Campania = 0

	IF @EsquemaDAConsultora = 0
	BEGIN
		IF @TipoDA = 0
		BEGIN
			SELECT TOP 1
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
			WHERE
				c.ZonaID = @ZonaID AND
				c.RegionID = @RegionID AND
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
		ELSE
		BEGIN
			SELECT TOP 1	
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID		
			LEFT JOIN [dbo].[Cronograma] cr (nolock) ON 
				c.CampaniaID = cr.CampaniaID AND
				c.RegionID = cr.RegionID AND
				c.ZonaID = cr.ZonaID
			WHERE 
				c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
				IIF(@PaisID = 4,
					ISNULL(CONVERT(datetime, cr.FechaInicioDD) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioReFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal)),
					ISNULL(CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
								ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
								CONVERT(datetime, @HoraCierreZonaNormal))
				) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
	END
	ELSE
	BEGIN

		DECLARE @Campania_temp INT
		DECLARE @Anio_temp INT
		SET @Campania_temp = 0

		SELECT TOP 1
			@Campania_temp = ca.Codigo,
			@Anio_temp = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
				ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
		ORDER BY c.CampaniaID DESC

		IF(@Campania_temp <> 0)
		BEGIN
			SET @Campania_temp = @Campania_temp - @Anio_temp
			IF(@Campania_temp = @NroCampanias)
				SET @Campania_temp = @Anio_temp + 101
			ELSE
				SET @Campania_temp = @Anio_temp + @Campania_temp + 1

			SELECT @AceptacionConsultoraDA = TipoConfiguracion
			FROM ConfiguracionConsultoraDA with(nolock)
			WHERE			
				ConsultoraId = @ConsultoraId and
				ZonaId = @ZonaId and
				CampaniaId = cast(@Campania_temp as int)
		END

		SELECT TOP 1
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			IIF(@AceptacionConsultoraDA < 1,
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal),
				CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti)) < @FechaGeneral
		ORDER BY c.CampaniaID DESC
	END
	
	--Obtiene UltimaCampaniaFacturada
	declare @UltimaCampanaFacturada int;
	declare @TipoFacturacion char(2);
	declare @ConsultoraIdAsociada bigint;

	select
		@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0),
		@TipoFacturacion = ISNULL(TipoFacturacion,'')
	From ods.consultora (nolock)
	Where consultoraid = @consultoraid

	--Obtiene UltimaCampaniaFacturada x UsuarioPrueba
	IF @UltimaCampanaFacturada IS NULL
	BEGIN
		SELECT
			@UltimaCampanaFacturada = ISNULL(c.UltimaCampanaFacturada,0),
			@TipoFacturacion = ISNULL(c.TipoFacturacion,''),
			@ConsultoraIdAsociada = ISNULL(c.ConsultoraId,0)
		FROM ConsultoraFicticia cf with(nolock)
		INNER JOIN UsuarioPrueba up with(nolock) on cf.Codigo = up.CodigoFicticio
		INNER JOIN ods.Consultora c with(nolock) on up.CodigoConsultoraAsociada = c.Codigo
		WHERE cf.ConsultoraId = @consultoraid
	END

	IF @TipoFacturacion <> 'FA'
	BEGIN
		SET @UltimaCampanaFacturada = dbo.fnAddCampaniaAndNumero(@CodigoISO,@UltimaCampanaFacturada,-1);
	END

	-- Valida Campania Anterior
	IF(@Campania <> 0)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1

		IF @EsquemaDAConsultora = 1 AND @Campania > @Campania_temp
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
		
		-- validar si pertenece a una zona DA
		DECLARE @EsZonaDA BIT;
		SELECT @EsZonaDA = IIF(ISNULL(c.CampaniaID,0) = 0,0,1)
		FROM dbo.Cronograma c 
		INNER JOIN ods.Campania ca ON c.CampaniaID = ca.CampaniaID 
		WHERE
			ca.Codigo = @Campania_temp AND
			c.RegionID = @RegionID AND
			c.ZonaID = @ZonaID AND
			c.TipoCronograma = 2

		-- si el esquema es de DA y la zona es de DA y ya facturo en la campaña actual 
		-- y la consultora respondio que no en la DA anterior
		-- se resetea la variable
		IF (@EsquemaDAConsultora = 1 AND @EsZonaDA = 1 AND @UltimaCampanaFacturada = @Campania_temp AND @AceptacionConsultoraDA = 0) 
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
	END
	ELSE
	BEGIN
		SELECT TOP 1 
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		WHERE z.ZonaID = @ZonaID AND z.RegionID = @RegionID
		ORDER BY c.FechaInicioFacturacion ASC
	END

	--Valida UltimaCampaniaFacturada
	IF (@UltimaCampanaFacturada = @Campania)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1
	END
	ELSE
	BEGIN
		DECLARE @IndicadorEnviado BIT= 0, @ValidacionAbierta BIT = 0
		DECLARE @IndicadorGPR TINYINT = 0
		DECLARE @EstadoPedido SMALLINT
  
		SELECT	@IndicadorEnviado  = IndicadorEnviado,  
				@IndicadorGPR = GPRSB, 
				@EstadoPedido = EstadoPedido, 
				@ValidacionAbierta = ValidacionAbierta
		FROM	Pedidoweb (nolock)
		WHERE	CampaniaID = @campania and consultoraid = ISNULL(@ConsultoraIdAsociada,@consultoraid)	

		If(@IndicadorEnviado = 1 AND @IndicadorGPR = 0)
		BEGIN
			SET @Campania = @Campania - @Anio
			IF(@Campania = @NroCampanias)
				SET @Campania = @Anio + 101
			ELSE
				SET @Campania = @Anio + @Campania + 1
		END
	END

	-- Pedido FIC
	DECLARE @FechaFinFIC datetime;
	DECLARE @IndicadorOfertaFIC int = 0;
	DECLARE @ImagenURLOfertaFIC varchar(500) = '';

	IF @PedidoFIC = 1
	BEGIN
		DECLARE @campaniaFIC INT
		IF substring(cast(@Campania as varchar(6)),5,2)=cast(@NroCampanias as char(2))
			set @campaniaFIC=cast(cast( cast(substring(cast(@Campania as varchar(6)),1,4)as int)+1 as varchar(4)) + '01' as int)
		ELSE
			set @campaniaFIC= @Campania +1

		SELECT @FechaFinFIC=isnull(FechaFin,GETDATE())
		FROM CronogramaFIC with(nolock)
		WHERE 
			ZonaID=@ZonaID and 
			CampaniaID = (				
				SELECT CampaniaID
				FROM ods.Campania with(nolock)
				WHERE Codigo=@campaniaFIC
			);

		select top 1
			@IndicadorOfertaFIC = 1,
			@ImagenURLOfertaFIC = isnull(ImagenUrl,'')
		from OfertaFIC (nolock)
		where CampaniaID = @campaniaFIC;
	END
			
	-- Listar Variables
	IF @EsquemaDAConsultora = 0
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@TipoDA = 0,c.FechaInicioFacturacion,ISNULL(cr.FechaInicioWeb, c.FechaInicioFacturacion)) AS FechaInicioFacturacion,
			IIF(@TipoDA = 0,
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				IIF(@PaisID = 4,
					ISNULL(cr.FechaInicioDD,c.FechaInicioReFacturacion),
					ISNULL(cr.FechaInicioWeb,c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
						ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)))
			) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@TipoDA = 0, @HoraFin,IIF(ISNULL(cr.CampaniaId,0) = 0,@HoraFin,@HoraCierreZonaDemAnti)) as HoraFin,
			@DiasAntes AS DiasAntes,
			ISNULL(@ZonaValida,-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(@TipoDA = 0, 0, IIF(ISNULL(cr.CampaniaId,0) = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END
	ELSE
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@AceptacionConsultoraDA < 1, c.FechaInicioFacturacion, cr.FechaInicioWeb) AS FechaInicioFacturacion,
			IIF(@AceptacionConsultoraDA < 1, 
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				cr.FechaInicioWeb) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@AceptacionConsultoraDA < 1, @HoraFin, @HoraCierreZonaDemAnti) as HoraFin,
			@DiasAntes AS DiasAntes,
			IIF(@AceptacionConsultoraDA < 1,ISNULL(@ZonaValida,-1),-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			IIF(@AceptacionConsultoraDA < 1,@HoraCierreZonaNormal,@HoraCierreZonaDemAnti) AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(ISNULL(cr.CampaniaId,0) = 0,0,IIF(@AceptacionConsultoraDA = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END

	RETURN
END
GO
ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @CodigoConsultora VARCHAR(50);
	SELECT TOP 1 @CodigoConsultora = co.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		iif(@PaisValido = 1, CO.ZonaID, CO.TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) AND
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	RETURN ISNULL(@CodigoConsultora, '');
END
GO
ALTER FUNCTION dbo.ObtenerConsultoraVecina
(
	@PaisID INT,
	@EdadMaxima INT,
	@UltimaCampanaFacturada INT,
	@ListadoConsultoraId dbo.IdBigintType READONLY,
	@RegionID INT,
	@ZonaID INT,
	@SeccionID INT,
	@TerritorioID INT
)
RETURNS @Consultora TABLE(
	ConsultoraID BIGINT,
	Codigo VARCHAR(30)
)
AS
BEGIN
	INSERT INTO @Consultora(ConsultoraID, Codigo)
	SELECT TOP 1 CO.ConsultoraID, CO.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID      
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, CO.FechaNacimiento, getdate()) <= @EdadMaxima AND
		CO.UltimaCampanaFacturada >= @UltimaCampanaFacturada AND
		CO.ConsultoraID NOT IN (SELECT Id FROM @ListadoConsultoraId) AND
		CO.RegionID = @RegionID AND CO.ZonaID = @ZonaID AND
		(@SeccionID = 0 OR CO.SeccionID = @SeccionID) AND
		(@TerritorioID = 0 OR CO.TerritorioID = @TerritorioID)
	ORDER BY MontoUltimoPedido DESC;
           
	RETURN;
END
GO
ALTER FUNCTION ValidarAutorizacion
(
	@paisID			INT,
	@CodigoUsuario	VARCHAR(100)
)
RETURNS INT
AS
/*
	SELECT DBO.ValidarAutorizacion(3, '1281283')
	SELECT DBO.ValidarAutorizacion(3, '076912262')
*/
BEGIN
	DECLARE @Usuario VARCHAR(100),
            @RolID INT,
            @AutorizaPedido VARCHAR(10),
            @IdEstadoActividad INT,
            @UltimaCampania INT,
            @CampaniaActual INT,
			@Resultado	INT,
			@CodigoConsultora varchar(20),
			@ZonaID INT,
			@RegionID INT,
			@ConsultoraID INT

	SET @RolID = 0
	SET @Usuario = ''
	SET @IdEstadoActividad = -1
	SET @UltimaCampania = 0
	SET @CampaniaActual = 0
	SET @Resultado = 0	

	SELECT	
		@CodigoConsultora = IsNull(CodigoConsultora,0),
		@PaisID = IsNull(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE codigousuario = @CodigoUsuario

	SELECT	
		@ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
		@AutorizaPedido = ISNULL(AutorizaPedido,''),
		@UltimaCampania = ISNULL(UltimaCampanaFacturada,0)
	FROM ods.consultora WITH(NOLOCK)
	WHERE codigo = @CodigoConsultora

	SELECT 
		@Usuario = u.CodigoUsuario, 
		@RolID = ISNULL(ur.RolId,0),
		@AutorizaPedido = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END),
		@CampaniaActual = ISNULL((SELECT TOP 1 campaniaId FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	FROM Usuario u WITH(NOLOCK)
		LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

    --0: Usuario No Existe
    --1: Usuario No es del Portal
    --2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
    --3: Usuario OK
	DECLARE @tabla_Retirada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Retirada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 12
	
	DECLARE @tabla_Reingresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Reingresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 18
	
	DECLARE @tabla_Egresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Egresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 19

    IF @Usuario IS NOT NULL AND @Usuario <> ''
    BEGIN
        IF @RolID != 0
        BEGIN
            IF @AutorizaPedido IS NOT NULL AND @AutorizaPedido <> ''
            BEGIN
                IF @IdEstadoActividad <> -1
                BEGIN
                    -- Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
                    IF @paisID = 11 OR @paisID = 2 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                    BEGIN
                        --Validamos si el estado es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                            BEGIN
                                --Caso Colombia
								IF @paisID = 4
								BEGIN
                                    SET @Resultado =  2
                                END
								ELSE
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                            END
                            ELSE
                            BEGIN
                                --Para bolivia (FOX) se hace la validación del campo AutorizaPedido
                                IF @paisID = 2
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                BEGIN
                                    SET @Resultado =  3
                                END
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es reingresada
                            IF EXISTS(SELECT 1 FROM @tabla_Reingresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
                                IF @paisID = 3
                                BEGIN
                                    --Se valida las campañas que no ha ingresado
									DECLARE @CampaniasSinIngresar INT = 0;
                                    IF LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampania) = 6
                                    BEGIN
										set @CampaniasSinIngresar = @CampaniaActual - dbo.fnAddCampaniaAndNumero(null,@UltimaCampania,3);
                                    END

                                    IF @CampaniasSinIngresar > 0
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        --Validamos el Autoriza Pedido
                                        IF @AutorizaPedido = 'N'
                                            SET @Resultado =  2
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                                ELSE
                                BEGIN
                                    --Caso Colombia
                                    IF @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        IF @AutorizaPedido = 'N'
                                        BEGIN
                                            --Validamos si es SICC o Bolivia
                                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2
                                                SET @Resultado =  2
                                            ELSE
                                                SET @Resultado =  3
                                        END
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                            END
                            ELSE
                            BEGIN
                                --Caso Colombia
                                IF @paisID = 4
                                BEGIN
                                    --Egresada o Posible Egreso
                                    IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                                    BEGIN
                                        SET @Resultado =  2
                                    END
                                END

                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC o Bolivia
                                    IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2 OR @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3

                            END
                        END
                    END
                    -- Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
                    ELSE IF @paisID = 5 OR @paisID = 10 OR @paisID = 9 OR @paisID = 12 OR @paisID = 13 OR @paisID = 6 OR @paisID = 1 OR @paisID = 14
                    BEGIN
                        -- Validamos si la consultora es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                    SET @Resultado =  2
                                ELSE
                                    SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    SET @Resultado =  2
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es retirada
                            IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
								IF @AutorizaPedido = 'N'
								BEGIN
									--Validamos si es SICC
									IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
										SET @Resultado =  2
									ELSE
										SET @Resultado =  3
								END
								ELSE
									SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC
                                    IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                    END
                    ELSE
                        SET @Resultado = 3
                END
                ELSE
                    SET @Resultado = 3 --Se asume para usuarios del tipo SAC
            END
            ELSE
                SET @Resultado = 3 --Se asume para usuarios del tipo SAC
        END
        ELSE
            SET @Resultado = 1
    END
    ELSE
        SET @Resultado = 0

    RETURN @Resultado

END
GO
ALTER PROCEDURE dbo.GetSesionUsuario_SB2
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	
	DECLARE @FechaLimitePago SMALLDATETIME
	DECLARE @ODSCampaniaID INT
	
	declare @PaisID int
	declare @UsuarioPrueba bit
	declare @CodConsultora varchar(20)
	declare @CampaniaID int
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint
	declare @UltimaCampanaFacturada int
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario

	declare @CountCodigoNivel bigint

	/*Oferta Final, Catalogo Personalizado, CDR*/
	declare @EsOfertaFinalZonaValida bit = 0
	declare @EsOFGanaMasZonaValida bit = 0
	declare @EsCatalogoPersonalizadoZonaValida bit = 0
	declare @EsCDRWebZonaValida  bit = 0
	declare @CodigoZona varchar(4) = ''
	declare @CodigoRegion varchar(2) = ''

	select
		@CodigoZona = IsNull(z.Codigo,''),
		@CodigoRegion = IsNull(r.Codigo,'')
	from ods.consultora c with(nolock)
	inner join ods.Region r on
		c.RegionID = r.RegionID
	inner join ods.Zona z on
		c.ZonaID = z.ZonaID
	where c.codigo = @CodConsultora

	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
		
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/

	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;
	
	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919

	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0

		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;

		/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,-11), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
		)

		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			isnull(c.EsJoven,0) EsJoven,
			(case
				when @CountCodigoNivel =0 then 0  --1589
				when @CountCodigoNivel>0 then 1 End) Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			null as ConsultoraAsociada, --1688
			isnull(si.descripcion,null) SegmentoConstancia, --2469
			isnull(se.Codigo,null) Seccion, --2469
			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469
			case When cl.ConsultoraID is null then 0
				else 1 end esConsultoraLider,
			u.EMailActivo, --2532
			si.SegmentoInternoId,
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u with(nolock)
		LEFT JOIN (
			select *
			from ods.consultora with(nolock)
			where ConsultoraId = @ConsultoraID
		) c ON u.CodigoConsultora = c.Codigo
		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID
		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469
		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469
		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t with(nolock) ON 
			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeo
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@MarcaId int,
	@tipoFiltroUbigeo int
)    
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;
	
	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
	
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';
	
	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1,''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2,''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3,'')
	FROM Ubigeo U with(nolock)
	WHERE codigoubigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		--ISNULL((select top 1 campaniaId from dbo.GetCampaniaPreLogin(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID)),0) as CampaniaActual,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND (@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite) AND
		UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.CampaniaId, -2)
	ORDER BY C.UltimaCampanaFacturada DESC, C.MontoUltimoPedido DESC
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@Nombres varchar(51),
	@Apellidos varchar(51),
	@MarcaId int,
	@tipoFiltroUbigeo int
)
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;

	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
 
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';

	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1, ''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2, ''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3, '')
	FROM Ubigeo with(nolock)
	WHERE CodigoUbigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND
		CONCAT(PrimerNombre,' ',SegundoNombre) LIKE CONCAT('%',@Nombres,'%') AND
		CONCAT(PrimerApellido,' ',SegundoApellido) LIKE CONCAT('%',@Apellidos,'%') AND
		(@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite);
END
GO
ALTER PROCEDURE dbo.GetConsultorasPorUbigeo
	@PaisId int,    
	@CodigoUbigeo varchar(24),    
	@Campania int,    
	@MarcaId int,
	@tipoFiltroUbigeo int
AS    
BEGIN
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	CREATE TABLE #TempConsultoraUbigeo    
	(    
		ID int IDENTITY,    
		ConsultoraID bigint,    
		Codigo varchar(100),    
		CodigoUbigeo varchar(24),    
		NombreCompletoConsultora varchar(300),    
		Email varchar(200),      
		FechaNacimiento datetime,    
		MONTOULTIMOPEDIDO MONEY,    
		UltimaCampanaFacturada INT,     
		CodigoUsuario varchar(100),    
		ZonaID int,    
		RegionID int  
	)

	INSERT INTO #TempConsultoraUbigeo  
    SELECT DISTINCT
		C.ConsultoraID,    
		C.Codigo,
		@CodigoUbigeo as CodigoUbigeo,
		C.NombreCompleto as NombreCompletoConsultora,
		U.Email,
		FechaNacimiento,
		MONTOULTIMOPEDIDO,
		UltimaCampanaFacturada,
		u.CodigoUsuario,
		c.ZonaID,
		c.RegionID    
    FROM ods.CONSULTORA AS C  
    INNER JOIN AFILIACLIENTECONSULTORA AS ACC ON C.CONSULTORAID = ACC.CONSULTORAID  
    INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo   
    WHERE ACC.EsAfiliado = 1 AND C.TERRITORIOID IN (SELECT TerritorioID FROM @TerritorioObjetivo);
		
    IF @MarcaId = 3    
    BEGIN
		DECLARE @EDADLIMITE INT = (SELECT Codigo FROM TABLALOGICADATOS WHERE TABLALOGICAID = 56 AND TABLALOGICADATOSID = 5605);

		DELETE FROM #TempConsultoraUbigeo 
		WHERE ID IN(  
			SELECT ID
			FROM #TempConsultoraUbigeo  
			WHERE (YEAR(getdate()) - year(FechaNacimiento)) >= @EDADLIMITE
		);
    END  
  
   -- -- FILTRANDO CONSULTORAS QUE HAYAN FACTURADO EN LA CAMPAÑANA ANTERIOR  
    --R2442 -  JC - Ya no filtrará por Campaña actual  
    SELECT TCU.ConsultoraID, TCU.Codigo, TCU.CodigoUbigeo, TCU.NombreCompletoConsultora as NombreCompleto, TCU.Email
    FROM #TempConsultoraUbigeo TCU
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,TCU.ZonaID,TCU.RegionID,TCU.ConsultoraID) CC
    WHERE
		dbo.ValidarAutorizacion(@PaisId, TCU.CodigoUsuario) = 3 AND
		TCU.UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.campaniaId, -2)
	order by ULTIMACAMPANAFACTURADA DESC , MONTOULTIMOPEDIDO DESC --R2626 
	
	DROP TABLE #TempConsultoraUbigeo;
END
GO
ALTER PROCEDURE GetProductosOfertaConsultoraNueva
	@CampaniaID INT,
	@ConsultoraID INT
AS
BEGIN
	DECLARE @NroCampania INT = (SELECT TOP 1 nrocampanias FROM pais with(nolock) WHERE EstadoActivo = 1);

	DECLARE @ultimacampaniafacturable INT;
	DECLARE @idcampaniaingreso INT;
	SELECT
		@idcampaniaingreso = AnoCampanaIngreso,
		@ultimacampaniafacturable = isnull(iif(TipoFacturacion = 'FA', UltimaCampanaFacturada, dbo.fnAddCampaniaAndNumero(UltimaCampanaFacturada,-1,@NroCampania)),0)
	FROM ods.Consultora WHERE ConsultoraID=@ConsultoraID;
		
	DECLARE @campaniafacturableingreso INT = @ultimacampaniafacturable - @idcampaniaingreso;
	DECLARE @campaniacompare INT = dbo.fnAddCampaniaAndNumero2(@ultimacampaniafacturable,1,@NroCampania);
	DECLARE @NumeroPedido INT;	
	DECLARE @indicador INT = 0;

	if @CampaniaID = @campaniacompare and (@campaniafacturableingreso between 0 and 3)
	begin		
		declare @CampaniaID1 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -1, @NroCampania);
		declare @CampaniaID2 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -2, @NroCampania);
		declare @CampaniaID3 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -3, @NroCampania);
		declare @CampaniaID4 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -4, @NroCampania);

		declare @idCampaniaID1 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID1);
		declare @idCampaniaID2 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID2);
		declare @idCampaniaID3 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID3);
		declare @idCampaniaID4 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID4);

		declare @campaniasFacturas int;

		---la consultora es nueva, esta realizando su segundo pedido compruebo que la campaña anterior tenga pedido facturado
		if @campaniafacturableingreso = 0
		begin
			set @NumeroPedido = 1;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1) and consultoraid = @ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 1, 1,0);
		end
		---la consultora es nueva, esta realizando su tercer pedido compruebo que las 2 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 1
		begin
			set @NumeroPedido=2;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 2, 1,0);
		end
		---la consultora es nueva, esta realizando su cuarto pedido compruebo que las 3 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 2
		begin
			set @NumeroPedido=3;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 3, 1,0);
		end
		---la consultora es nueva, esta realizando su quINTo pedido compruebo que las 4 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 3
		begin
			set @NumeroPedido=4;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido (nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3,@idCampaniaID4) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 4, 1,0);
		end
	end

	IF @indicador = 1 and (@campaniafacturableingreso between 0 and 3)
	begin
		SELECT TOP 4
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			MarcaID,
			IndicadorMontoMinimo,
			DescripcionProd,
			UnidadesPermitidas,
			(case when len(IndicadorPedido) >0 then 1 else 0 end) IndicadorPedido,
			ganahasta
		FROM (
			SELECT
				og.OfertaNuevaId,
				og.NumeroPedido,
				case isnull(og.FlagImagenActiva,0)
					when 1 then og.ImagenProducto01
					when 2 then og.ImagenProducto02
					when 3 then og.ImagenProducto03
					else ''
				end ImagenProducto01,
				og.Descripcion,
				og.CUV,
				og.PrecioNormal,
				og.PrecioParaTi,
				pc.MarcaID,
				pc.IndicadorMontoMinimo,
				coalesce(pd.Descripcion, pc.Descripcion) DescripcionProd,
				dbo.fnObtenerCantidadOfertaNueva(og.CUV, og.CampaniaID, og.UnidadesPermitidas,og.TipoOfertaSisID, og.ConfiguracionOfertaID) UnidadesPermitidas,
				isnull(pwd.CUV,'') IndicadorPedido,
				isnull(og.ganahasta, 0) ganahasta
			FROM dbo.OfertaNueva  og with(nolock)
			inner join ods.ProductoComercial pc with(nolock) on og.CUV = pc.CUV and og.CampaniaID = pc.AnoCampania
			inner join ods.Campania ca with(nolock) on pc.CampaniaID = ca.CampaniaID
			left join dbo.ProductoDescripcion pd with(nolock) on og.CampaniaID = pd.CampaniaID and og.CUV = pd.CUV
			left join PedidoWebDetalle pwd with(nolock) on pwd.CUV=og.CUV and pwd.CampaniaID= @CampaniaID and pwd.ConsultoraID=@ConsultoraID
			WHERE
				ca.CodiGO = @CampaniaID and
				og.FlagHabilitarOferta = 1 and
				og.NumeroPedido=@NumeroPedido and
				og.CUV not in(SELECT CUV FROM PedidoWebDetalle with(nolock) WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID)
		) a
		WHERE a.UnidadesPermitidas > 0
		order by 5 asc
	end
	else
	begin
		SELECT
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			'' MarcaID,
			'' IndicadorMontoMinimo,
			'' DescripcionProd,
			UnidadesPermitidas,
			0 IndicadorPedido,
			0 ganahasta
		FROM OfertaNueva with(nolock)
		WHERE OfertaNuevaID < 0
		order by 5 asc
	end
END
GO
/*end*/

USE BelcorpCostaRica
GO
if object_id('fnGetTableTerritorioIdByFiltroAndUbigeo') is not null
begin
	drop function fnGetTableTerritorioIdByFiltroAndUbigeo;
end
GO
create function fnGetTableTerritorioIdByFiltroAndUbigeo(
	@TipoFiltroUbigeo int,
	@CodigoUbigeo varchar(24)
)
returns @List table (TerritorioID int, CodigoUbigeo varchar(24))
as
begin
	IF @TipoFiltroUbigeo = 1
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM ods.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 2
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 3
	BEGIN
		INSERT INTO @List
		SELECT TT.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		INNER JOIN ods.UBIGEO U with(nolock) ON U.UBIGEOID = T.TERRITORIOID
		INNER JOIN ods.TERRITORIO TT with(nolock) ON TT.CODIGOUBIGEO = U.CODIGOUBIGEO
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END

	return;
end
GO
IF OBJECT_ID('dbo.fnAddCampaniaAndNumero2') IS NOT NULL
BEGIN
	DROP FUNCTION dbo.fnAddCampaniaAndNumero2;
END
GO
CREATE FUNCTION dbo.fnAddCampaniaAndNumero2(
	@CampaniaActual INT,
	@AddNro INT,
	@NroCampanias INT
)
RETURNS INT
AS
BEGIN	
	DECLARE @AnioCampaniaActual INT = @CampaniaActual/100;
	DECLARE @NroCampaniaActual INT = @CampaniaActual%100;
	DECLARE @SumNroCampania INT = (@NroCampaniaActual + @AddNro) - 1;
	DECLARE @AnioCampaniaSiguiente INT = @AnioCampaniaActual + @SumNroCampania/@NroCampanias;
	DECLARE @NroCampaniaSiguiente INT = @SumNroCampania%@NroCampanias + 1;
	
	IF @NroCampaniaSiguiente < 1
	BEGIN
		SET @AnioCampaniaSiguiente = @AnioCampaniaSiguiente - 1;
		SET @NroCampaniaSiguiente = @NroCampaniaSiguiente + @NroCampanias;
	END
	DECLARE @CampaniaSiguiente INT = @AnioCampaniaSiguiente*100 + @NroCampaniaSiguiente;
	RETURN @CampaniaSiguiente;
END
GO
ALTER FUNCTION dbo.fnAddCampaniaAndNumero(
	@CodigoISO CHAR(2),
	@CampaniaActual INT,
	@AddNro INT
)
RETURNS INT
AS
BEGIN
	DECLARE @NroCampanias INT = IIF(
		ISNULL(@CodigoISO,'') <> '',
		(select top 1 NroCampanias from Pais with(nolock) where CodigoISO = @CodigoISO),
		(select top 1 NroCampanias from Pais with(nolock) where EstadoActivo = 1)
	);
	
	RETURN dbo.fnAddCampaniaAndNumero2(@CampaniaActual,@AddNro,@NroCampanias);
END
GO
ALTER FUNCTION dbo.fnGetConfiguracionCampania
(
	@PaisID tinyint,
	@ZonaID int,
	@RegionID int,
	@ConsultoraID bigint
)
RETURNS @TConfiguracionCampania TABLE(
	ID int,
	CampaniaID varchar(6),
	FechaInicioFacturacion datetime,
	FechaFinFacturacion datetime,
	CampaniaDescripcion varchar(6),
	HoraInicio time,
	HoraFin time,
	DiasAntes int,
	ZonaValida int,
	HoraInicioNoFacturable time,
	HoraCierreNoFacturable time,
	ZonaHoraria float,
	HoraCierreZonaNormal time,
	HoraCierreZonaDemAnti time,
	HoraCierreZonaDemAntiCierre time,
	EsZonaDemAnti int,
	DiasDuracionCronograma int,
	HabilitarRestriccionHoraria int,
	HorasDuracionRestriccion int,
	NroCampanias int,
	PROLSinStock bit,
	FechaFinFIC datetime,
	IndicadorOfertaFIC int,
	ImagenURLOfertaFIC varchar(500),
	NuevoPROL bit,
	ZonaNuevoPROL bit,
	EstadoSimplificacionCUV bit,
	EsquemaDAConsultora bit,	
	ValidacionInteractiva bit,
	MensajeValidacionInteractiva varchar(500),
	IndicadorEnviado bit,
	IndicadorGPRSB int,
	FechaActualPais datetime,
	EstadoPedido smallint,
	ValidacionAbierta BIT,
	FechaLimitePago SMALLDATETIME,
	AceptacionConsultoraDA int
)
AS
/*
select * from dbo.fnGetConfiguracionCampania(11,2161,2017,2)
*/
BEGIN
	-- Variables Pais
	DECLARE @CodigoISO CHAR(2)
	DECLARE @ZonaHoraria FLOAT
	DECLARE @HoraCierreZonaNormal TIME(0)
	DECLARE @HoraCierreZonaDemAnti TIME(0)
	DECLARE @NroCampanias INT
	DECLARE @PROLSinStock BIT
	DECLARE @NuevoPROL BIT
	DECLARE @EstadoSimplificacionCUV BIT
	DECLARE @EsquemaDAConsultora BIT
	DECLARE @TipoDA BIT
	DECLARE @PedidoFIC BIT

	select
		@CodigoISO = CodigoISO,
		@ZonaHoraria = ISNULL(ZonaHoraria,0),
		@HoraCierreZonaNormal = HoraCierreZonaNormal,
		@HoraCierreZonaDemAnti = HoraCierreZonaDemAnti,
		@NroCampanias = NroCampanias,
		@PROLSinStock = PROLSinStock,
		@NuevoPROL = NuevoPROL,
		@EstadoSimplificacionCUV = EstadoSimplificacionCUV,
		@EsquemaDAConsultora = EsquemaDAConsultora,
		@TipoDA = TipoDA,
		@PedidoFIC = PedidoFIC
	from Pais (nolock)
	where PaisId = @PaisID

	-- Variables ConfiguracionValidacion
	DECLARE @HoraInicio time(0)
	DECLARE @HoraFin time(0)
	DECLARE @DiasAntes tinyint
	DECLARE @HoraInicioNoFacturable time(0)
	DECLARE @HoraCierreNoFacturable time(0)
	DECLARE @HabilitarRestriccionHoraria bit
	DECLARE @HorasDuracionRestriccion INT
	DECLARE @ValidacionInteractiva bit
	DECLARE @MensajeValidacionInteractiva varchar(500)

	SELECT
		@HoraInicio = HoraInicio,
		@HoraFin = HoraFin,
		@DiasAntes = DiasAntes,
		@HoraInicioNoFacturable = HoraInicioNoFacturable,
		@HoraCierreNoFacturable = HoraCierreNoFacturable,
		@HabilitarRestriccionHoraria = HabilitarRestriccionHoraria,
		@HorasDuracionRestriccion =  ISNULL(HorasDuracionRestriccion,0),
		@ValidacionInteractiva = ValidacionInteractiva,
		@MensajeValidacionInteractiva = MensajeValidacionInteractiva
	FROM [dbo].[ConfiguracionValidacion] (nolock)
	WHERE  PaisID = @PaisID

	 -- Variables ConfiguracionValidacionZona
	DECLARE @DiasDuracionCronograma tinyint
	SET @DiasDuracionCronograma = 1
	DECLARE @ZonaValida int
	DECLARE @IndicadorDias bit
	SET @IndicadorDias = 0

	select
		@DiasDuracionCronograma = DiasDuracionCronograma,
		@ZonaValida = ZonaID,
		@IndicadorDias = ValidacionActiva
	from ConfiguracionValidacionZona with(nolock)
	where CampaniaID = 201301 and ZonaID = @ZonaID

	-- Dias Duracion Cronograma para Nuevas (CR)
	IF @PaisID = 5 OR @PaisID = 8 OR @PaisID = 7 OR @PaisID = 10
	BEGIN
		declare @UCF int = 0;
		declare @SID int = 0;

		select
			@UCF = ISNULL(UltimaCampanaFacturada,0),
			@SID = ISNULL(SegmentoId,0)
		from ods.Consultora with(nolock)
		where ConsultoraID = @ConsultoraID

		IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
			SET @DiasDuracionCronograma = 2
	END

	-- Variables ConfiguracionValidacionNuevoPROL
	DECLARE @ZonaNuevoPROL BIT = 0;
	DECLARE @ContNuevoPROL INT = 0;

	IF @NuevoPROL = 1
	BEGIN
		SELECT @ContNuevoPROL = COUNT(ZonaId)
		FROM ConfiguracionValidacionNuevoPROL with(nolock)
		WHERE ZonaId = @ZonaId

		IF @ContNuevoPROL > 0
			SET @ZonaNuevoPROL = 1
	END

	-- Otras Configuraciones
	IF @IndicadorDias = 0
		SET @DiasAntes = 0

	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	DECLARE @AceptacionConsultoraDA INT
	SET @AceptacionConsultoraDA = -1

	-- Obtener Campania Anterior
	DECLARE @Campania INT
	DECLARE @Anio INT
	SET @Campania = 0

	IF @EsquemaDAConsultora = 0
	BEGIN
		IF @TipoDA = 0
		BEGIN
			SELECT TOP 1
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
			WHERE
				c.ZonaID = @ZonaID AND
				c.RegionID = @RegionID AND
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
		ELSE
		BEGIN
			SELECT TOP 1	
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID		
			LEFT JOIN [dbo].[Cronograma] cr (nolock) ON 
				c.CampaniaID = cr.CampaniaID AND
				c.RegionID = cr.RegionID AND
				c.ZonaID = cr.ZonaID
			WHERE 
				c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
				IIF(@PaisID = 4,
					ISNULL(CONVERT(datetime, cr.FechaInicioDD) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioReFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal)),
					ISNULL(CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
								ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
								CONVERT(datetime, @HoraCierreZonaNormal))
				) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
	END
	ELSE
	BEGIN

		DECLARE @Campania_temp INT
		DECLARE @Anio_temp INT
		SET @Campania_temp = 0

		SELECT TOP 1
			@Campania_temp = ca.Codigo,
			@Anio_temp = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
				ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
		ORDER BY c.CampaniaID DESC

		IF(@Campania_temp <> 0)
		BEGIN
			SET @Campania_temp = @Campania_temp - @Anio_temp
			IF(@Campania_temp = @NroCampanias)
				SET @Campania_temp = @Anio_temp + 101
			ELSE
				SET @Campania_temp = @Anio_temp + @Campania_temp + 1

			SELECT @AceptacionConsultoraDA = TipoConfiguracion
			FROM ConfiguracionConsultoraDA with(nolock)
			WHERE			
				ConsultoraId = @ConsultoraId and
				ZonaId = @ZonaId and
				CampaniaId = cast(@Campania_temp as int)
		END

		SELECT TOP 1
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			IIF(@AceptacionConsultoraDA < 1,
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal),
				CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti)) < @FechaGeneral
		ORDER BY c.CampaniaID DESC
	END
	
	--Obtiene UltimaCampaniaFacturada
	declare @UltimaCampanaFacturada int;
	declare @TipoFacturacion char(2);
	declare @ConsultoraIdAsociada bigint;

	select
		@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0),
		@TipoFacturacion = ISNULL(TipoFacturacion,'')
	From ods.consultora (nolock)
	Where consultoraid = @consultoraid

	--Obtiene UltimaCampaniaFacturada x UsuarioPrueba
	IF @UltimaCampanaFacturada IS NULL
	BEGIN
		SELECT
			@UltimaCampanaFacturada = ISNULL(c.UltimaCampanaFacturada,0),
			@TipoFacturacion = ISNULL(c.TipoFacturacion,''),
			@ConsultoraIdAsociada = ISNULL(c.ConsultoraId,0)
		FROM ConsultoraFicticia cf with(nolock)
		INNER JOIN UsuarioPrueba up with(nolock) on cf.Codigo = up.CodigoFicticio
		INNER JOIN ods.Consultora c with(nolock) on up.CodigoConsultoraAsociada = c.Codigo
		WHERE cf.ConsultoraId = @consultoraid
	END

	IF @TipoFacturacion <> 'FA'
	BEGIN
		SET @UltimaCampanaFacturada = dbo.fnAddCampaniaAndNumero(@CodigoISO,@UltimaCampanaFacturada,-1);
	END

	-- Valida Campania Anterior
	IF(@Campania <> 0)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1

		IF @EsquemaDAConsultora = 1 AND @Campania > @Campania_temp
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
		
		-- validar si pertenece a una zona DA
		DECLARE @EsZonaDA BIT;
		SELECT @EsZonaDA = IIF(ISNULL(c.CampaniaID,0) = 0,0,1)
		FROM dbo.Cronograma c 
		INNER JOIN ods.Campania ca ON c.CampaniaID = ca.CampaniaID 
		WHERE
			ca.Codigo = @Campania_temp AND
			c.RegionID = @RegionID AND
			c.ZonaID = @ZonaID AND
			c.TipoCronograma = 2

		-- si el esquema es de DA y la zona es de DA y ya facturo en la campaña actual 
		-- y la consultora respondio que no en la DA anterior
		-- se resetea la variable
		IF (@EsquemaDAConsultora = 1 AND @EsZonaDA = 1 AND @UltimaCampanaFacturada = @Campania_temp AND @AceptacionConsultoraDA = 0) 
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
	END
	ELSE
	BEGIN
		SELECT TOP 1 
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		WHERE z.ZonaID = @ZonaID AND z.RegionID = @RegionID
		ORDER BY c.FechaInicioFacturacion ASC
	END

	--Valida UltimaCampaniaFacturada
	IF (@UltimaCampanaFacturada = @Campania)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1
	END
	ELSE
	BEGIN
		DECLARE @IndicadorEnviado BIT= 0, @ValidacionAbierta BIT = 0
		DECLARE @IndicadorGPR TINYINT = 0
		DECLARE @EstadoPedido SMALLINT
  
		SELECT	@IndicadorEnviado  = IndicadorEnviado,  
				@IndicadorGPR = GPRSB, 
				@EstadoPedido = EstadoPedido, 
				@ValidacionAbierta = ValidacionAbierta
		FROM	Pedidoweb (nolock)
		WHERE	CampaniaID = @campania and consultoraid = ISNULL(@ConsultoraIdAsociada,@consultoraid)	

		If(@IndicadorEnviado = 1 AND @IndicadorGPR = 0)
		BEGIN
			SET @Campania = @Campania - @Anio
			IF(@Campania = @NroCampanias)
				SET @Campania = @Anio + 101
			ELSE
				SET @Campania = @Anio + @Campania + 1
		END
	END

	-- Pedido FIC
	DECLARE @FechaFinFIC datetime;
	DECLARE @IndicadorOfertaFIC int = 0;
	DECLARE @ImagenURLOfertaFIC varchar(500) = '';

	IF @PedidoFIC = 1
	BEGIN
		DECLARE @campaniaFIC INT
		IF substring(cast(@Campania as varchar(6)),5,2)=cast(@NroCampanias as char(2))
			set @campaniaFIC=cast(cast( cast(substring(cast(@Campania as varchar(6)),1,4)as int)+1 as varchar(4)) + '01' as int)
		ELSE
			set @campaniaFIC= @Campania +1

		SELECT @FechaFinFIC=isnull(FechaFin,GETDATE())
		FROM CronogramaFIC with(nolock)
		WHERE 
			ZonaID=@ZonaID and 
			CampaniaID = (				
				SELECT CampaniaID
				FROM ods.Campania with(nolock)
				WHERE Codigo=@campaniaFIC
			);

		select top 1
			@IndicadorOfertaFIC = 1,
			@ImagenURLOfertaFIC = isnull(ImagenUrl,'')
		from OfertaFIC (nolock)
		where CampaniaID = @campaniaFIC;
	END
			
	-- Listar Variables
	IF @EsquemaDAConsultora = 0
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@TipoDA = 0,c.FechaInicioFacturacion,ISNULL(cr.FechaInicioWeb, c.FechaInicioFacturacion)) AS FechaInicioFacturacion,
			IIF(@TipoDA = 0,
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				IIF(@PaisID = 4,
					ISNULL(cr.FechaInicioDD,c.FechaInicioReFacturacion),
					ISNULL(cr.FechaInicioWeb,c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
						ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)))
			) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@TipoDA = 0, @HoraFin,IIF(ISNULL(cr.CampaniaId,0) = 0,@HoraFin,@HoraCierreZonaDemAnti)) as HoraFin,
			@DiasAntes AS DiasAntes,
			ISNULL(@ZonaValida,-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(@TipoDA = 0, 0, IIF(ISNULL(cr.CampaniaId,0) = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END
	ELSE
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@AceptacionConsultoraDA < 1, c.FechaInicioFacturacion, cr.FechaInicioWeb) AS FechaInicioFacturacion,
			IIF(@AceptacionConsultoraDA < 1, 
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				cr.FechaInicioWeb) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@AceptacionConsultoraDA < 1, @HoraFin, @HoraCierreZonaDemAnti) as HoraFin,
			@DiasAntes AS DiasAntes,
			IIF(@AceptacionConsultoraDA < 1,ISNULL(@ZonaValida,-1),-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			IIF(@AceptacionConsultoraDA < 1,@HoraCierreZonaNormal,@HoraCierreZonaDemAnti) AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(ISNULL(cr.CampaniaId,0) = 0,0,IIF(@AceptacionConsultoraDA = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END

	RETURN
END
GO
ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @CodigoConsultora VARCHAR(50);
	SELECT TOP 1 @CodigoConsultora = co.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		iif(@PaisValido = 1, CO.ZonaID, CO.TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) AND
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	RETURN ISNULL(@CodigoConsultora, '');
END
GO
ALTER FUNCTION dbo.ObtenerConsultoraVecina
(
	@PaisID INT,
	@EdadMaxima INT,
	@UltimaCampanaFacturada INT,
	@ListadoConsultoraId dbo.IdBigintType READONLY,
	@RegionID INT,
	@ZonaID INT,
	@SeccionID INT,
	@TerritorioID INT
)
RETURNS @Consultora TABLE(
	ConsultoraID BIGINT,
	Codigo VARCHAR(30)
)
AS
BEGIN
	INSERT INTO @Consultora(ConsultoraID, Codigo)
	SELECT TOP 1 CO.ConsultoraID, CO.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID      
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, CO.FechaNacimiento, getdate()) <= @EdadMaxima AND
		CO.UltimaCampanaFacturada >= @UltimaCampanaFacturada AND
		CO.ConsultoraID NOT IN (SELECT Id FROM @ListadoConsultoraId) AND
		CO.RegionID = @RegionID AND CO.ZonaID = @ZonaID AND
		(@SeccionID = 0 OR CO.SeccionID = @SeccionID) AND
		(@TerritorioID = 0 OR CO.TerritorioID = @TerritorioID)
	ORDER BY MontoUltimoPedido DESC;
           
	RETURN;
END
GO
ALTER FUNCTION ValidarAutorizacion
(
	@paisID			INT,
	@CodigoUsuario	VARCHAR(100)
)
RETURNS INT
AS
/*
	SELECT DBO.ValidarAutorizacion(3, '1281283')
	SELECT DBO.ValidarAutorizacion(3, '076912262')
*/
BEGIN
	DECLARE @Usuario VARCHAR(100),
            @RolID INT,
            @AutorizaPedido VARCHAR(10),
            @IdEstadoActividad INT,
            @UltimaCampania INT,
            @CampaniaActual INT,
			@Resultado	INT,
			@CodigoConsultora varchar(20),
			@ZonaID INT,
			@RegionID INT,
			@ConsultoraID INT

	SET @RolID = 0
	SET @Usuario = ''
	SET @IdEstadoActividad = -1
	SET @UltimaCampania = 0
	SET @CampaniaActual = 0
	SET @Resultado = 0	

	SELECT	
		@CodigoConsultora = IsNull(CodigoConsultora,0),
		@PaisID = IsNull(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE codigousuario = @CodigoUsuario

	SELECT	
		@ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
		@AutorizaPedido = ISNULL(AutorizaPedido,''),
		@UltimaCampania = ISNULL(UltimaCampanaFacturada,0)
	FROM ods.consultora WITH(NOLOCK)
	WHERE codigo = @CodigoConsultora

	SELECT 
		@Usuario = u.CodigoUsuario, 
		@RolID = ISNULL(ur.RolId,0),
		@AutorizaPedido = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END),
		@CampaniaActual = ISNULL((SELECT TOP 1 campaniaId FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	FROM Usuario u WITH(NOLOCK)
		LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

    --0: Usuario No Existe
    --1: Usuario No es del Portal
    --2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
    --3: Usuario OK
	DECLARE @tabla_Retirada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Retirada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 12
	
	DECLARE @tabla_Reingresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Reingresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 18
	
	DECLARE @tabla_Egresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Egresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 19

    IF @Usuario IS NOT NULL AND @Usuario <> ''
    BEGIN
        IF @RolID != 0
        BEGIN
            IF @AutorizaPedido IS NOT NULL AND @AutorizaPedido <> ''
            BEGIN
                IF @IdEstadoActividad <> -1
                BEGIN
                    -- Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
                    IF @paisID = 11 OR @paisID = 2 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                    BEGIN
                        --Validamos si el estado es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                            BEGIN
                                --Caso Colombia
								IF @paisID = 4
								BEGIN
                                    SET @Resultado =  2
                                END
								ELSE
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                            END
                            ELSE
                            BEGIN
                                --Para bolivia (FOX) se hace la validación del campo AutorizaPedido
                                IF @paisID = 2
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                BEGIN
                                    SET @Resultado =  3
                                END
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es reingresada
                            IF EXISTS(SELECT 1 FROM @tabla_Reingresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
                                IF @paisID = 3
                                BEGIN
                                    --Se valida las campañas que no ha ingresado
									DECLARE @CampaniasSinIngresar INT = 0;
                                    IF LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampania) = 6
                                    BEGIN
										set @CampaniasSinIngresar = @CampaniaActual - dbo.fnAddCampaniaAndNumero(null,@UltimaCampania,3);
                                    END

                                    IF @CampaniasSinIngresar > 0
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        --Validamos el Autoriza Pedido
                                        IF @AutorizaPedido = 'N'
                                            SET @Resultado =  2
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                                ELSE
                                BEGIN
                                    --Caso Colombia
                                    IF @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        IF @AutorizaPedido = 'N'
                                        BEGIN
                                            --Validamos si es SICC o Bolivia
                                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2
                                                SET @Resultado =  2
                                            ELSE
                                                SET @Resultado =  3
                                        END
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                            END
                            ELSE
                            BEGIN
                                --Caso Colombia
                                IF @paisID = 4
                                BEGIN
                                    --Egresada o Posible Egreso
                                    IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                                    BEGIN
                                        SET @Resultado =  2
                                    END
                                END

                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC o Bolivia
                                    IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2 OR @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3

                            END
                        END
                    END
                    -- Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
                    ELSE IF @paisID = 5 OR @paisID = 10 OR @paisID = 9 OR @paisID = 12 OR @paisID = 13 OR @paisID = 6 OR @paisID = 1 OR @paisID = 14
                    BEGIN
                        -- Validamos si la consultora es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                    SET @Resultado =  2
                                ELSE
                                    SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    SET @Resultado =  2
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es retirada
                            IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
								IF @AutorizaPedido = 'N'
								BEGIN
									--Validamos si es SICC
									IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
										SET @Resultado =  2
									ELSE
										SET @Resultado =  3
								END
								ELSE
									SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC
                                    IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                    END
                    ELSE
                        SET @Resultado = 3
                END
                ELSE
                    SET @Resultado = 3 --Se asume para usuarios del tipo SAC
            END
            ELSE
                SET @Resultado = 3 --Se asume para usuarios del tipo SAC
        END
        ELSE
            SET @Resultado = 1
    END
    ELSE
        SET @Resultado = 0

    RETURN @Resultado

END
GO
ALTER PROCEDURE dbo.GetSesionUsuario_SB2
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	
	DECLARE @FechaLimitePago SMALLDATETIME
	DECLARE @ODSCampaniaID INT
	
	declare @PaisID int
	declare @UsuarioPrueba bit
	declare @CodConsultora varchar(20)
	declare @CampaniaID int
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint
	declare @UltimaCampanaFacturada int
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario

	declare @CountCodigoNivel bigint

	/*Oferta Final, Catalogo Personalizado, CDR*/
	declare @EsOfertaFinalZonaValida bit = 0
	declare @EsOFGanaMasZonaValida bit = 0
	declare @EsCatalogoPersonalizadoZonaValida bit = 0
	declare @EsCDRWebZonaValida  bit = 0
	declare @CodigoZona varchar(4) = ''
	declare @CodigoRegion varchar(2) = ''

	select
		@CodigoZona = IsNull(z.Codigo,''),
		@CodigoRegion = IsNull(r.Codigo,'')
	from ods.consultora c with(nolock)
	inner join ods.Region r on
		c.RegionID = r.RegionID
	inner join ods.Zona z on
		c.ZonaID = z.ZonaID
	where c.codigo = @CodConsultora

	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
		
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/

	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;
	
	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919

	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0

		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;

		/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,-11), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
		)

		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			isnull(c.EsJoven,0) EsJoven,
			(case
				when @CountCodigoNivel =0 then 0  --1589
				when @CountCodigoNivel>0 then 1 End) Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			null as ConsultoraAsociada, --1688
			isnull(si.descripcion,null) SegmentoConstancia, --2469
			isnull(se.Codigo,null) Seccion, --2469
			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469
			case When cl.ConsultoraID is null then 0
				else 1 end esConsultoraLider,
			u.EMailActivo, --2532
			si.SegmentoInternoId,
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u with(nolock)
		LEFT JOIN (
			select *
			from ods.consultora with(nolock)
			where ConsultoraId = @ConsultoraID
		) c ON u.CodigoConsultora = c.Codigo
		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID
		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469
		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469
		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t with(nolock) ON 
			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeo
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@MarcaId int,
	@tipoFiltroUbigeo int
)    
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;
	
	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
	
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';
	
	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1,''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2,''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3,'')
	FROM Ubigeo U with(nolock)
	WHERE codigoubigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		--ISNULL((select top 1 campaniaId from dbo.GetCampaniaPreLogin(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID)),0) as CampaniaActual,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND (@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite) AND
		UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.CampaniaId, -2)
	ORDER BY C.UltimaCampanaFacturada DESC, C.MontoUltimoPedido DESC
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@Nombres varchar(51),
	@Apellidos varchar(51),
	@MarcaId int,
	@tipoFiltroUbigeo int
)
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;

	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
 
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';

	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1, ''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2, ''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3, '')
	FROM Ubigeo with(nolock)
	WHERE CodigoUbigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND
		CONCAT(PrimerNombre,' ',SegundoNombre) LIKE CONCAT('%',@Nombres,'%') AND
		CONCAT(PrimerApellido,' ',SegundoApellido) LIKE CONCAT('%',@Apellidos,'%') AND
		(@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite);
END
GO
ALTER PROCEDURE dbo.GetConsultorasPorUbigeo
	@PaisId int,    
	@CodigoUbigeo varchar(24),    
	@Campania int,    
	@MarcaId int,
	@tipoFiltroUbigeo int
AS    
BEGIN
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	CREATE TABLE #TempConsultoraUbigeo    
	(    
		ID int IDENTITY,    
		ConsultoraID bigint,    
		Codigo varchar(100),    
		CodigoUbigeo varchar(24),    
		NombreCompletoConsultora varchar(300),    
		Email varchar(200),      
		FechaNacimiento datetime,    
		MONTOULTIMOPEDIDO MONEY,    
		UltimaCampanaFacturada INT,     
		CodigoUsuario varchar(100),    
		ZonaID int,    
		RegionID int  
	)

	INSERT INTO #TempConsultoraUbigeo  
    SELECT DISTINCT
		C.ConsultoraID,    
		C.Codigo,
		@CodigoUbigeo as CodigoUbigeo,
		C.NombreCompleto as NombreCompletoConsultora,
		U.Email,
		FechaNacimiento,
		MONTOULTIMOPEDIDO,
		UltimaCampanaFacturada,
		u.CodigoUsuario,
		c.ZonaID,
		c.RegionID    
    FROM ods.CONSULTORA AS C  
    INNER JOIN AFILIACLIENTECONSULTORA AS ACC ON C.CONSULTORAID = ACC.CONSULTORAID  
    INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo   
    WHERE ACC.EsAfiliado = 1 AND C.TERRITORIOID IN (SELECT TerritorioID FROM @TerritorioObjetivo);
		
    IF @MarcaId = 3    
    BEGIN
		DECLARE @EDADLIMITE INT = (SELECT Codigo FROM TABLALOGICADATOS WHERE TABLALOGICAID = 56 AND TABLALOGICADATOSID = 5605);

		DELETE FROM #TempConsultoraUbigeo 
		WHERE ID IN(  
			SELECT ID
			FROM #TempConsultoraUbigeo  
			WHERE (YEAR(getdate()) - year(FechaNacimiento)) >= @EDADLIMITE
		);
    END  
  
   -- -- FILTRANDO CONSULTORAS QUE HAYAN FACTURADO EN LA CAMPAÑANA ANTERIOR  
    --R2442 -  JC - Ya no filtrará por Campaña actual  
    SELECT TCU.ConsultoraID, TCU.Codigo, TCU.CodigoUbigeo, TCU.NombreCompletoConsultora as NombreCompleto, TCU.Email
    FROM #TempConsultoraUbigeo TCU
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,TCU.ZonaID,TCU.RegionID,TCU.ConsultoraID) CC
    WHERE
		dbo.ValidarAutorizacion(@PaisId, TCU.CodigoUsuario) = 3 AND
		TCU.UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.campaniaId, -2)
	order by ULTIMACAMPANAFACTURADA DESC , MONTOULTIMOPEDIDO DESC --R2626 
	
	DROP TABLE #TempConsultoraUbigeo;
END
GO
ALTER PROCEDURE GetProductosOfertaConsultoraNueva
	@CampaniaID INT,
	@ConsultoraID INT
AS
BEGIN
	DECLARE @NroCampania INT = (SELECT TOP 1 nrocampanias FROM pais with(nolock) WHERE EstadoActivo = 1);

	DECLARE @ultimacampaniafacturable INT;
	DECLARE @idcampaniaingreso INT;
	SELECT
		@idcampaniaingreso = AnoCampanaIngreso,
		@ultimacampaniafacturable = isnull(iif(TipoFacturacion = 'FA', UltimaCampanaFacturada, dbo.fnAddCampaniaAndNumero(UltimaCampanaFacturada,-1,@NroCampania)),0)
	FROM ods.Consultora WHERE ConsultoraID=@ConsultoraID;
		
	DECLARE @campaniafacturableingreso INT = @ultimacampaniafacturable - @idcampaniaingreso;
	DECLARE @campaniacompare INT = dbo.fnAddCampaniaAndNumero2(@ultimacampaniafacturable,1,@NroCampania);
	DECLARE @NumeroPedido INT;	
	DECLARE @indicador INT = 0;

	if @CampaniaID = @campaniacompare and (@campaniafacturableingreso between 0 and 3)
	begin		
		declare @CampaniaID1 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -1, @NroCampania);
		declare @CampaniaID2 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -2, @NroCampania);
		declare @CampaniaID3 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -3, @NroCampania);
		declare @CampaniaID4 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -4, @NroCampania);

		declare @idCampaniaID1 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID1);
		declare @idCampaniaID2 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID2);
		declare @idCampaniaID3 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID3);
		declare @idCampaniaID4 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID4);

		declare @campaniasFacturas int;

		---la consultora es nueva, esta realizando su segundo pedido compruebo que la campaña anterior tenga pedido facturado
		if @campaniafacturableingreso = 0
		begin
			set @NumeroPedido = 1;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1) and consultoraid = @ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 1, 1,0);
		end
		---la consultora es nueva, esta realizando su tercer pedido compruebo que las 2 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 1
		begin
			set @NumeroPedido=2;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 2, 1,0);
		end
		---la consultora es nueva, esta realizando su cuarto pedido compruebo que las 3 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 2
		begin
			set @NumeroPedido=3;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 3, 1,0);
		end
		---la consultora es nueva, esta realizando su quINTo pedido compruebo que las 4 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 3
		begin
			set @NumeroPedido=4;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido (nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3,@idCampaniaID4) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 4, 1,0);
		end
	end

	IF @indicador = 1 and (@campaniafacturableingreso between 0 and 3)
	begin
		SELECT TOP 4
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			MarcaID,
			IndicadorMontoMinimo,
			DescripcionProd,
			UnidadesPermitidas,
			(case when len(IndicadorPedido) >0 then 1 else 0 end) IndicadorPedido,
			ganahasta
		FROM (
			SELECT
				og.OfertaNuevaId,
				og.NumeroPedido,
				case isnull(og.FlagImagenActiva,0)
					when 1 then og.ImagenProducto01
					when 2 then og.ImagenProducto02
					when 3 then og.ImagenProducto03
					else ''
				end ImagenProducto01,
				og.Descripcion,
				og.CUV,
				og.PrecioNormal,
				og.PrecioParaTi,
				pc.MarcaID,
				pc.IndicadorMontoMinimo,
				coalesce(pd.Descripcion, pc.Descripcion) DescripcionProd,
				dbo.fnObtenerCantidadOfertaNueva(og.CUV, og.CampaniaID, og.UnidadesPermitidas,og.TipoOfertaSisID, og.ConfiguracionOfertaID) UnidadesPermitidas,
				isnull(pwd.CUV,'') IndicadorPedido,
				isnull(og.ganahasta, 0) ganahasta
			FROM dbo.OfertaNueva  og with(nolock)
			inner join ods.ProductoComercial pc with(nolock) on og.CUV = pc.CUV and og.CampaniaID = pc.AnoCampania
			inner join ods.Campania ca with(nolock) on pc.CampaniaID = ca.CampaniaID
			left join dbo.ProductoDescripcion pd with(nolock) on og.CampaniaID = pd.CampaniaID and og.CUV = pd.CUV
			left join PedidoWebDetalle pwd with(nolock) on pwd.CUV=og.CUV and pwd.CampaniaID= @CampaniaID and pwd.ConsultoraID=@ConsultoraID
			WHERE
				ca.CodiGO = @CampaniaID and
				og.FlagHabilitarOferta = 1 and
				og.NumeroPedido=@NumeroPedido and
				og.CUV not in(SELECT CUV FROM PedidoWebDetalle with(nolock) WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID)
		) a
		WHERE a.UnidadesPermitidas > 0
		order by 5 asc
	end
	else
	begin
		SELECT
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			'' MarcaID,
			'' IndicadorMontoMinimo,
			'' DescripcionProd,
			UnidadesPermitidas,
			0 IndicadorPedido,
			0 ganahasta
		FROM OfertaNueva with(nolock)
		WHERE OfertaNuevaID < 0
		order by 5 asc
	end
END
GO
/*end*/

USE BelcorpDominicana
GO
if object_id('fnGetTableTerritorioIdByFiltroAndUbigeo') is not null
begin
	drop function fnGetTableTerritorioIdByFiltroAndUbigeo;
end
GO
create function fnGetTableTerritorioIdByFiltroAndUbigeo(
	@TipoFiltroUbigeo int,
	@CodigoUbigeo varchar(24)
)
returns @List table (TerritorioID int, CodigoUbigeo varchar(24))
as
begin
	IF @TipoFiltroUbigeo = 1
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM ods.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 2
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 3
	BEGIN
		INSERT INTO @List
		SELECT TT.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		INNER JOIN ods.UBIGEO U with(nolock) ON U.UBIGEOID = T.TERRITORIOID
		INNER JOIN ods.TERRITORIO TT with(nolock) ON TT.CODIGOUBIGEO = U.CODIGOUBIGEO
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END

	return;
end
GO
IF OBJECT_ID('dbo.fnAddCampaniaAndNumero2') IS NOT NULL
BEGIN
	DROP FUNCTION dbo.fnAddCampaniaAndNumero2;
END
GO
CREATE FUNCTION dbo.fnAddCampaniaAndNumero2(
	@CampaniaActual INT,
	@AddNro INT,
	@NroCampanias INT
)
RETURNS INT
AS
BEGIN	
	DECLARE @AnioCampaniaActual INT = @CampaniaActual/100;
	DECLARE @NroCampaniaActual INT = @CampaniaActual%100;
	DECLARE @SumNroCampania INT = (@NroCampaniaActual + @AddNro) - 1;
	DECLARE @AnioCampaniaSiguiente INT = @AnioCampaniaActual + @SumNroCampania/@NroCampanias;
	DECLARE @NroCampaniaSiguiente INT = @SumNroCampania%@NroCampanias + 1;
	
	IF @NroCampaniaSiguiente < 1
	BEGIN
		SET @AnioCampaniaSiguiente = @AnioCampaniaSiguiente - 1;
		SET @NroCampaniaSiguiente = @NroCampaniaSiguiente + @NroCampanias;
	END
	DECLARE @CampaniaSiguiente INT = @AnioCampaniaSiguiente*100 + @NroCampaniaSiguiente;
	RETURN @CampaniaSiguiente;
END
GO
ALTER FUNCTION dbo.fnAddCampaniaAndNumero(
	@CodigoISO CHAR(2),
	@CampaniaActual INT,
	@AddNro INT
)
RETURNS INT
AS
BEGIN
	DECLARE @NroCampanias INT = IIF(
		ISNULL(@CodigoISO,'') <> '',
		(select top 1 NroCampanias from Pais with(nolock) where CodigoISO = @CodigoISO),
		(select top 1 NroCampanias from Pais with(nolock) where EstadoActivo = 1)
	);
	
	RETURN dbo.fnAddCampaniaAndNumero2(@CampaniaActual,@AddNro,@NroCampanias);
END
GO
ALTER FUNCTION dbo.fnGetConfiguracionCampania
(
	@PaisID tinyint,
	@ZonaID int,
	@RegionID int,
	@ConsultoraID bigint
)
RETURNS @TConfiguracionCampania TABLE(
	ID int,
	CampaniaID varchar(6),
	FechaInicioFacturacion datetime,
	FechaFinFacturacion datetime,
	CampaniaDescripcion varchar(6),
	HoraInicio time,
	HoraFin time,
	DiasAntes int,
	ZonaValida int,
	HoraInicioNoFacturable time,
	HoraCierreNoFacturable time,
	ZonaHoraria float,
	HoraCierreZonaNormal time,
	HoraCierreZonaDemAnti time,
	HoraCierreZonaDemAntiCierre time,
	EsZonaDemAnti int,
	DiasDuracionCronograma int,
	HabilitarRestriccionHoraria int,
	HorasDuracionRestriccion int,
	NroCampanias int,
	PROLSinStock bit,
	FechaFinFIC datetime,
	IndicadorOfertaFIC int,
	ImagenURLOfertaFIC varchar(500),
	NuevoPROL bit,
	ZonaNuevoPROL bit,
	EstadoSimplificacionCUV bit,
	EsquemaDAConsultora bit,	
	ValidacionInteractiva bit,
	MensajeValidacionInteractiva varchar(500),
	IndicadorEnviado bit,
	IndicadorGPRSB int,
	FechaActualPais datetime,
	EstadoPedido smallint,
	ValidacionAbierta BIT,
	FechaLimitePago SMALLDATETIME,
	AceptacionConsultoraDA int
)
AS
/*
select * from dbo.fnGetConfiguracionCampania(11,2161,2017,2)
*/
BEGIN
	-- Variables Pais
	DECLARE @CodigoISO CHAR(2)
	DECLARE @ZonaHoraria FLOAT
	DECLARE @HoraCierreZonaNormal TIME(0)
	DECLARE @HoraCierreZonaDemAnti TIME(0)
	DECLARE @NroCampanias INT
	DECLARE @PROLSinStock BIT
	DECLARE @NuevoPROL BIT
	DECLARE @EstadoSimplificacionCUV BIT
	DECLARE @EsquemaDAConsultora BIT
	DECLARE @TipoDA BIT
	DECLARE @PedidoFIC BIT

	select
		@CodigoISO = CodigoISO,
		@ZonaHoraria = ISNULL(ZonaHoraria,0),
		@HoraCierreZonaNormal = HoraCierreZonaNormal,
		@HoraCierreZonaDemAnti = HoraCierreZonaDemAnti,
		@NroCampanias = NroCampanias,
		@PROLSinStock = PROLSinStock,
		@NuevoPROL = NuevoPROL,
		@EstadoSimplificacionCUV = EstadoSimplificacionCUV,
		@EsquemaDAConsultora = EsquemaDAConsultora,
		@TipoDA = TipoDA,
		@PedidoFIC = PedidoFIC
	from Pais (nolock)
	where PaisId = @PaisID

	-- Variables ConfiguracionValidacion
	DECLARE @HoraInicio time(0)
	DECLARE @HoraFin time(0)
	DECLARE @DiasAntes tinyint
	DECLARE @HoraInicioNoFacturable time(0)
	DECLARE @HoraCierreNoFacturable time(0)
	DECLARE @HabilitarRestriccionHoraria bit
	DECLARE @HorasDuracionRestriccion INT
	DECLARE @ValidacionInteractiva bit
	DECLARE @MensajeValidacionInteractiva varchar(500)

	SELECT
		@HoraInicio = HoraInicio,
		@HoraFin = HoraFin,
		@DiasAntes = DiasAntes,
		@HoraInicioNoFacturable = HoraInicioNoFacturable,
		@HoraCierreNoFacturable = HoraCierreNoFacturable,
		@HabilitarRestriccionHoraria = HabilitarRestriccionHoraria,
		@HorasDuracionRestriccion =  ISNULL(HorasDuracionRestriccion,0),
		@ValidacionInteractiva = ValidacionInteractiva,
		@MensajeValidacionInteractiva = MensajeValidacionInteractiva
	FROM [dbo].[ConfiguracionValidacion] (nolock)
	WHERE  PaisID = @PaisID

	 -- Variables ConfiguracionValidacionZona
	DECLARE @DiasDuracionCronograma tinyint
	SET @DiasDuracionCronograma = 1
	DECLARE @ZonaValida int
	DECLARE @IndicadorDias bit
	SET @IndicadorDias = 0

	select
		@DiasDuracionCronograma = DiasDuracionCronograma,
		@ZonaValida = ZonaID,
		@IndicadorDias = ValidacionActiva
	from ConfiguracionValidacionZona with(nolock)
	where CampaniaID = 201301 and ZonaID = @ZonaID

	-- Dias Duracion Cronograma para Nuevas (CR)
	IF @PaisID = 5 OR @PaisID = 8 OR @PaisID = 7 OR @PaisID = 10
	BEGIN
		declare @UCF int = 0;
		declare @SID int = 0;

		select
			@UCF = ISNULL(UltimaCampanaFacturada,0),
			@SID = ISNULL(SegmentoId,0)
		from ods.Consultora with(nolock)
		where ConsultoraID = @ConsultoraID

		IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
			SET @DiasDuracionCronograma = 2
	END

	-- Variables ConfiguracionValidacionNuevoPROL
	DECLARE @ZonaNuevoPROL BIT = 0;
	DECLARE @ContNuevoPROL INT = 0;

	IF @NuevoPROL = 1
	BEGIN
		SELECT @ContNuevoPROL = COUNT(ZonaId)
		FROM ConfiguracionValidacionNuevoPROL with(nolock)
		WHERE ZonaId = @ZonaId

		IF @ContNuevoPROL > 0
			SET @ZonaNuevoPROL = 1
	END

	-- Otras Configuraciones
	IF @IndicadorDias = 0
		SET @DiasAntes = 0

	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	DECLARE @AceptacionConsultoraDA INT
	SET @AceptacionConsultoraDA = -1

	-- Obtener Campania Anterior
	DECLARE @Campania INT
	DECLARE @Anio INT
	SET @Campania = 0

	IF @EsquemaDAConsultora = 0
	BEGIN
		IF @TipoDA = 0
		BEGIN
			SELECT TOP 1
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
			WHERE
				c.ZonaID = @ZonaID AND
				c.RegionID = @RegionID AND
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
		ELSE
		BEGIN
			SELECT TOP 1	
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID		
			LEFT JOIN [dbo].[Cronograma] cr (nolock) ON 
				c.CampaniaID = cr.CampaniaID AND
				c.RegionID = cr.RegionID AND
				c.ZonaID = cr.ZonaID
			WHERE 
				c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
				IIF(@PaisID = 4,
					ISNULL(CONVERT(datetime, cr.FechaInicioDD) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioReFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal)),
					ISNULL(CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
								ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
								CONVERT(datetime, @HoraCierreZonaNormal))
				) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
	END
	ELSE
	BEGIN

		DECLARE @Campania_temp INT
		DECLARE @Anio_temp INT
		SET @Campania_temp = 0

		SELECT TOP 1
			@Campania_temp = ca.Codigo,
			@Anio_temp = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
				ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
		ORDER BY c.CampaniaID DESC

		IF(@Campania_temp <> 0)
		BEGIN
			SET @Campania_temp = @Campania_temp - @Anio_temp
			IF(@Campania_temp = @NroCampanias)
				SET @Campania_temp = @Anio_temp + 101
			ELSE
				SET @Campania_temp = @Anio_temp + @Campania_temp + 1

			SELECT @AceptacionConsultoraDA = TipoConfiguracion
			FROM ConfiguracionConsultoraDA with(nolock)
			WHERE			
				ConsultoraId = @ConsultoraId and
				ZonaId = @ZonaId and
				CampaniaId = cast(@Campania_temp as int)
		END

		SELECT TOP 1
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			IIF(@AceptacionConsultoraDA < 1,
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal),
				CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti)) < @FechaGeneral
		ORDER BY c.CampaniaID DESC
	END
	
	--Obtiene UltimaCampaniaFacturada
	declare @UltimaCampanaFacturada int;
	declare @TipoFacturacion char(2);
	declare @ConsultoraIdAsociada bigint;

	select
		@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0),
		@TipoFacturacion = ISNULL(TipoFacturacion,'')
	From ods.consultora (nolock)
	Where consultoraid = @consultoraid

	--Obtiene UltimaCampaniaFacturada x UsuarioPrueba
	IF @UltimaCampanaFacturada IS NULL
	BEGIN
		SELECT
			@UltimaCampanaFacturada = ISNULL(c.UltimaCampanaFacturada,0),
			@TipoFacturacion = ISNULL(c.TipoFacturacion,''),
			@ConsultoraIdAsociada = ISNULL(c.ConsultoraId,0)
		FROM ConsultoraFicticia cf with(nolock)
		INNER JOIN UsuarioPrueba up with(nolock) on cf.Codigo = up.CodigoFicticio
		INNER JOIN ods.Consultora c with(nolock) on up.CodigoConsultoraAsociada = c.Codigo
		WHERE cf.ConsultoraId = @consultoraid
	END

	IF @TipoFacturacion <> 'FA'
	BEGIN
		SET @UltimaCampanaFacturada = dbo.fnAddCampaniaAndNumero(@CodigoISO,@UltimaCampanaFacturada,-1);
	END

	-- Valida Campania Anterior
	IF(@Campania <> 0)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1

		IF @EsquemaDAConsultora = 1 AND @Campania > @Campania_temp
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
		
		-- validar si pertenece a una zona DA
		DECLARE @EsZonaDA BIT;
		SELECT @EsZonaDA = IIF(ISNULL(c.CampaniaID,0) = 0,0,1)
		FROM dbo.Cronograma c 
		INNER JOIN ods.Campania ca ON c.CampaniaID = ca.CampaniaID 
		WHERE
			ca.Codigo = @Campania_temp AND
			c.RegionID = @RegionID AND
			c.ZonaID = @ZonaID AND
			c.TipoCronograma = 2

		-- si el esquema es de DA y la zona es de DA y ya facturo en la campaña actual 
		-- y la consultora respondio que no en la DA anterior
		-- se resetea la variable
		IF (@EsquemaDAConsultora = 1 AND @EsZonaDA = 1 AND @UltimaCampanaFacturada = @Campania_temp AND @AceptacionConsultoraDA = 0) 
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
	END
	ELSE
	BEGIN
		SELECT TOP 1 
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		WHERE z.ZonaID = @ZonaID AND z.RegionID = @RegionID
		ORDER BY c.FechaInicioFacturacion ASC
	END

	--Valida UltimaCampaniaFacturada
	IF (@UltimaCampanaFacturada = @Campania)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1
	END
	ELSE
	BEGIN
		DECLARE @IndicadorEnviado BIT= 0, @ValidacionAbierta BIT = 0
		DECLARE @IndicadorGPR TINYINT = 0
		DECLARE @EstadoPedido SMALLINT
  
		SELECT	@IndicadorEnviado  = IndicadorEnviado,  
				@IndicadorGPR = GPRSB, 
				@EstadoPedido = EstadoPedido, 
				@ValidacionAbierta = ValidacionAbierta
		FROM	Pedidoweb (nolock)
		WHERE	CampaniaID = @campania and consultoraid = ISNULL(@ConsultoraIdAsociada,@consultoraid)	

		If(@IndicadorEnviado = 1 AND @IndicadorGPR = 0)
		BEGIN
			SET @Campania = @Campania - @Anio
			IF(@Campania = @NroCampanias)
				SET @Campania = @Anio + 101
			ELSE
				SET @Campania = @Anio + @Campania + 1
		END
	END

	-- Pedido FIC
	DECLARE @FechaFinFIC datetime;
	DECLARE @IndicadorOfertaFIC int = 0;
	DECLARE @ImagenURLOfertaFIC varchar(500) = '';

	IF @PedidoFIC = 1
	BEGIN
		DECLARE @campaniaFIC INT
		IF substring(cast(@Campania as varchar(6)),5,2)=cast(@NroCampanias as char(2))
			set @campaniaFIC=cast(cast( cast(substring(cast(@Campania as varchar(6)),1,4)as int)+1 as varchar(4)) + '01' as int)
		ELSE
			set @campaniaFIC= @Campania +1

		SELECT @FechaFinFIC=isnull(FechaFin,GETDATE())
		FROM CronogramaFIC with(nolock)
		WHERE 
			ZonaID=@ZonaID and 
			CampaniaID = (				
				SELECT CampaniaID
				FROM ods.Campania with(nolock)
				WHERE Codigo=@campaniaFIC
			);

		select top 1
			@IndicadorOfertaFIC = 1,
			@ImagenURLOfertaFIC = isnull(ImagenUrl,'')
		from OfertaFIC (nolock)
		where CampaniaID = @campaniaFIC;
	END
			
	-- Listar Variables
	IF @EsquemaDAConsultora = 0
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@TipoDA = 0,c.FechaInicioFacturacion,ISNULL(cr.FechaInicioWeb, c.FechaInicioFacturacion)) AS FechaInicioFacturacion,
			IIF(@TipoDA = 0,
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				IIF(@PaisID = 4,
					ISNULL(cr.FechaInicioDD,c.FechaInicioReFacturacion),
					ISNULL(cr.FechaInicioWeb,c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
						ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)))
			) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@TipoDA = 0, @HoraFin,IIF(ISNULL(cr.CampaniaId,0) = 0,@HoraFin,@HoraCierreZonaDemAnti)) as HoraFin,
			@DiasAntes AS DiasAntes,
			ISNULL(@ZonaValida,-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(@TipoDA = 0, 0, IIF(ISNULL(cr.CampaniaId,0) = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END
	ELSE
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@AceptacionConsultoraDA < 1, c.FechaInicioFacturacion, cr.FechaInicioWeb) AS FechaInicioFacturacion,
			IIF(@AceptacionConsultoraDA < 1, 
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				cr.FechaInicioWeb) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@AceptacionConsultoraDA < 1, @HoraFin, @HoraCierreZonaDemAnti) as HoraFin,
			@DiasAntes AS DiasAntes,
			IIF(@AceptacionConsultoraDA < 1,ISNULL(@ZonaValida,-1),-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			IIF(@AceptacionConsultoraDA < 1,@HoraCierreZonaNormal,@HoraCierreZonaDemAnti) AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(ISNULL(cr.CampaniaId,0) = 0,0,IIF(@AceptacionConsultoraDA = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END

	RETURN
END
GO
ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @CodigoConsultora VARCHAR(50);
	SELECT TOP 1 @CodigoConsultora = co.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		iif(@PaisValido = 1, CO.ZonaID, CO.TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) AND
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	RETURN ISNULL(@CodigoConsultora, '');
END
GO
ALTER FUNCTION dbo.ObtenerConsultoraVecina
(
	@PaisID INT,
	@EdadMaxima INT,
	@UltimaCampanaFacturada INT,
	@ListadoConsultoraId dbo.IdBigintType READONLY,
	@RegionID INT,
	@ZonaID INT,
	@SeccionID INT,
	@TerritorioID INT
)
RETURNS @Consultora TABLE(
	ConsultoraID BIGINT,
	Codigo VARCHAR(30)
)
AS
BEGIN
	INSERT INTO @Consultora(ConsultoraID, Codigo)
	SELECT TOP 1 CO.ConsultoraID, CO.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID      
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, CO.FechaNacimiento, getdate()) <= @EdadMaxima AND
		CO.UltimaCampanaFacturada >= @UltimaCampanaFacturada AND
		CO.ConsultoraID NOT IN (SELECT Id FROM @ListadoConsultoraId) AND
		CO.RegionID = @RegionID AND CO.ZonaID = @ZonaID AND
		(@SeccionID = 0 OR CO.SeccionID = @SeccionID) AND
		(@TerritorioID = 0 OR CO.TerritorioID = @TerritorioID)
	ORDER BY MontoUltimoPedido DESC;
           
	RETURN;
END
GO
ALTER FUNCTION ValidarAutorizacion
(
	@paisID			INT,
	@CodigoUsuario	VARCHAR(100)
)
RETURNS INT
AS
/*
	SELECT DBO.ValidarAutorizacion(3, '1281283')
	SELECT DBO.ValidarAutorizacion(3, '076912262')
*/
BEGIN
	DECLARE @Usuario VARCHAR(100),
            @RolID INT,
            @AutorizaPedido VARCHAR(10),
            @IdEstadoActividad INT,
            @UltimaCampania INT,
            @CampaniaActual INT,
			@Resultado	INT,
			@CodigoConsultora varchar(20),
			@ZonaID INT,
			@RegionID INT,
			@ConsultoraID INT

	SET @RolID = 0
	SET @Usuario = ''
	SET @IdEstadoActividad = -1
	SET @UltimaCampania = 0
	SET @CampaniaActual = 0
	SET @Resultado = 0	

	SELECT	
		@CodigoConsultora = IsNull(CodigoConsultora,0),
		@PaisID = IsNull(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE codigousuario = @CodigoUsuario

	SELECT	
		@ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
		@AutorizaPedido = ISNULL(AutorizaPedido,''),
		@UltimaCampania = ISNULL(UltimaCampanaFacturada,0)
	FROM ods.consultora WITH(NOLOCK)
	WHERE codigo = @CodigoConsultora

	SELECT 
		@Usuario = u.CodigoUsuario, 
		@RolID = ISNULL(ur.RolId,0),
		@AutorizaPedido = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END),
		@CampaniaActual = ISNULL((SELECT TOP 1 campaniaId FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	FROM Usuario u WITH(NOLOCK)
		LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

    --0: Usuario No Existe
    --1: Usuario No es del Portal
    --2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
    --3: Usuario OK
	DECLARE @tabla_Retirada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Retirada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 12
	
	DECLARE @tabla_Reingresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Reingresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 18
	
	DECLARE @tabla_Egresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Egresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 19

    IF @Usuario IS NOT NULL AND @Usuario <> ''
    BEGIN
        IF @RolID != 0
        BEGIN
            IF @AutorizaPedido IS NOT NULL AND @AutorizaPedido <> ''
            BEGIN
                IF @IdEstadoActividad <> -1
                BEGIN
                    -- Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
                    IF @paisID = 11 OR @paisID = 2 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                    BEGIN
                        --Validamos si el estado es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                            BEGIN
                                --Caso Colombia
								IF @paisID = 4
								BEGIN
                                    SET @Resultado =  2
                                END
								ELSE
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                            END
                            ELSE
                            BEGIN
                                --Para bolivia (FOX) se hace la validación del campo AutorizaPedido
                                IF @paisID = 2
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                BEGIN
                                    SET @Resultado =  3
                                END
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es reingresada
                            IF EXISTS(SELECT 1 FROM @tabla_Reingresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
                                IF @paisID = 3
                                BEGIN
                                    --Se valida las campañas que no ha ingresado
									DECLARE @CampaniasSinIngresar INT = 0;
                                    IF LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampania) = 6
                                    BEGIN
										set @CampaniasSinIngresar = @CampaniaActual - dbo.fnAddCampaniaAndNumero(null,@UltimaCampania,3);
                                    END

                                    IF @CampaniasSinIngresar > 0
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        --Validamos el Autoriza Pedido
                                        IF @AutorizaPedido = 'N'
                                            SET @Resultado =  2
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                                ELSE
                                BEGIN
                                    --Caso Colombia
                                    IF @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        IF @AutorizaPedido = 'N'
                                        BEGIN
                                            --Validamos si es SICC o Bolivia
                                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2
                                                SET @Resultado =  2
                                            ELSE
                                                SET @Resultado =  3
                                        END
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                            END
                            ELSE
                            BEGIN
                                --Caso Colombia
                                IF @paisID = 4
                                BEGIN
                                    --Egresada o Posible Egreso
                                    IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                                    BEGIN
                                        SET @Resultado =  2
                                    END
                                END

                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC o Bolivia
                                    IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2 OR @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3

                            END
                        END
                    END
                    -- Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
                    ELSE IF @paisID = 5 OR @paisID = 10 OR @paisID = 9 OR @paisID = 12 OR @paisID = 13 OR @paisID = 6 OR @paisID = 1 OR @paisID = 14
                    BEGIN
                        -- Validamos si la consultora es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                    SET @Resultado =  2
                                ELSE
                                    SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    SET @Resultado =  2
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es retirada
                            IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
								IF @AutorizaPedido = 'N'
								BEGIN
									--Validamos si es SICC
									IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
										SET @Resultado =  2
									ELSE
										SET @Resultado =  3
								END
								ELSE
									SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC
                                    IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                    END
                    ELSE
                        SET @Resultado = 3
                END
                ELSE
                    SET @Resultado = 3 --Se asume para usuarios del tipo SAC
            END
            ELSE
                SET @Resultado = 3 --Se asume para usuarios del tipo SAC
        END
        ELSE
            SET @Resultado = 1
    END
    ELSE
        SET @Resultado = 0

    RETURN @Resultado

END
GO
ALTER PROCEDURE dbo.GetSesionUsuario_SB2
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	
	DECLARE @FechaLimitePago SMALLDATETIME
	DECLARE @ODSCampaniaID INT
	
	declare @PaisID int
	declare @UsuarioPrueba bit
	declare @CodConsultora varchar(20)
	declare @CampaniaID int
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint
	declare @UltimaCampanaFacturada int
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario

	declare @CountCodigoNivel bigint

	/*Oferta Final, Catalogo Personalizado, CDR*/
	declare @EsOfertaFinalZonaValida bit = 0
	declare @EsOFGanaMasZonaValida bit = 0
	declare @EsCatalogoPersonalizadoZonaValida bit = 0
	declare @EsCDRWebZonaValida  bit = 0
	declare @CodigoZona varchar(4) = ''
	declare @CodigoRegion varchar(2) = ''

	select
		@CodigoZona = IsNull(z.Codigo,''),
		@CodigoRegion = IsNull(r.Codigo,'')
	from ods.consultora c with(nolock)
	inner join ods.Region r on
		c.RegionID = r.RegionID
	inner join ods.Zona z on
		c.ZonaID = z.ZonaID
	where c.codigo = @CodConsultora

	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
		
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/

	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;
	
	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919

	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0

		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;

		/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,-11), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
		)

		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			isnull(c.EsJoven,0) EsJoven,
			(case
				when @CountCodigoNivel =0 then 0  --1589
				when @CountCodigoNivel>0 then 1 End) Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			null as ConsultoraAsociada, --1688
			isnull(si.descripcion,null) SegmentoConstancia, --2469
			isnull(se.Codigo,null) Seccion, --2469
			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469
			case When cl.ConsultoraID is null then 0
				else 1 end esConsultoraLider,
			u.EMailActivo, --2532
			si.SegmentoInternoId,
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u with(nolock)
		LEFT JOIN (
			select *
			from ods.consultora with(nolock)
			where ConsultoraId = @ConsultoraID
		) c ON u.CodigoConsultora = c.Codigo
		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID
		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469
		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469
		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t with(nolock) ON 
			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeo
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@MarcaId int,
	@tipoFiltroUbigeo int
)    
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;
	
	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
	
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';
	
	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1,''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2,''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3,'')
	FROM Ubigeo U with(nolock)
	WHERE codigoubigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		--ISNULL((select top 1 campaniaId from dbo.GetCampaniaPreLogin(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID)),0) as CampaniaActual,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND (@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite) AND
		UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.CampaniaId, -2)
	ORDER BY C.UltimaCampanaFacturada DESC, C.MontoUltimoPedido DESC
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@Nombres varchar(51),
	@Apellidos varchar(51),
	@MarcaId int,
	@tipoFiltroUbigeo int
)
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;

	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
 
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';

	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1, ''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2, ''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3, '')
	FROM Ubigeo with(nolock)
	WHERE CodigoUbigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND
		CONCAT(PrimerNombre,' ',SegundoNombre) LIKE CONCAT('%',@Nombres,'%') AND
		CONCAT(PrimerApellido,' ',SegundoApellido) LIKE CONCAT('%',@Apellidos,'%') AND
		(@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite);
END
GO
ALTER PROCEDURE dbo.GetConsultorasPorUbigeo
	@PaisId int,    
	@CodigoUbigeo varchar(24),    
	@Campania int,    
	@MarcaId int,
	@tipoFiltroUbigeo int
AS    
BEGIN
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	CREATE TABLE #TempConsultoraUbigeo    
	(    
		ID int IDENTITY,    
		ConsultoraID bigint,    
		Codigo varchar(100),    
		CodigoUbigeo varchar(24),    
		NombreCompletoConsultora varchar(300),    
		Email varchar(200),      
		FechaNacimiento datetime,    
		MONTOULTIMOPEDIDO MONEY,    
		UltimaCampanaFacturada INT,     
		CodigoUsuario varchar(100),    
		ZonaID int,    
		RegionID int  
	)

	INSERT INTO #TempConsultoraUbigeo  
    SELECT DISTINCT
		C.ConsultoraID,    
		C.Codigo,
		@CodigoUbigeo as CodigoUbigeo,
		C.NombreCompleto as NombreCompletoConsultora,
		U.Email,
		FechaNacimiento,
		MONTOULTIMOPEDIDO,
		UltimaCampanaFacturada,
		u.CodigoUsuario,
		c.ZonaID,
		c.RegionID    
    FROM ods.CONSULTORA AS C  
    INNER JOIN AFILIACLIENTECONSULTORA AS ACC ON C.CONSULTORAID = ACC.CONSULTORAID  
    INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo   
    WHERE ACC.EsAfiliado = 1 AND C.TERRITORIOID IN (SELECT TerritorioID FROM @TerritorioObjetivo);
		
    IF @MarcaId = 3    
    BEGIN
		DECLARE @EDADLIMITE INT = (SELECT Codigo FROM TABLALOGICADATOS WHERE TABLALOGICAID = 56 AND TABLALOGICADATOSID = 5605);

		DELETE FROM #TempConsultoraUbigeo 
		WHERE ID IN(  
			SELECT ID
			FROM #TempConsultoraUbigeo  
			WHERE (YEAR(getdate()) - year(FechaNacimiento)) >= @EDADLIMITE
		);
    END  
  
   -- -- FILTRANDO CONSULTORAS QUE HAYAN FACTURADO EN LA CAMPAÑANA ANTERIOR  
    --R2442 -  JC - Ya no filtrará por Campaña actual  
    SELECT TCU.ConsultoraID, TCU.Codigo, TCU.CodigoUbigeo, TCU.NombreCompletoConsultora as NombreCompleto, TCU.Email
    FROM #TempConsultoraUbigeo TCU
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,TCU.ZonaID,TCU.RegionID,TCU.ConsultoraID) CC
    WHERE
		dbo.ValidarAutorizacion(@PaisId, TCU.CodigoUsuario) = 3 AND
		TCU.UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.campaniaId, -2)
	order by ULTIMACAMPANAFACTURADA DESC , MONTOULTIMOPEDIDO DESC --R2626 
	
	DROP TABLE #TempConsultoraUbigeo;
END
GO
ALTER PROCEDURE GetProductosOfertaConsultoraNueva
	@CampaniaID INT,
	@ConsultoraID INT
AS
BEGIN
	DECLARE @NroCampania INT = (SELECT TOP 1 nrocampanias FROM pais with(nolock) WHERE EstadoActivo = 1);

	DECLARE @ultimacampaniafacturable INT;
	DECLARE @idcampaniaingreso INT;
	SELECT
		@idcampaniaingreso = AnoCampanaIngreso,
		@ultimacampaniafacturable = isnull(iif(TipoFacturacion = 'FA', UltimaCampanaFacturada, dbo.fnAddCampaniaAndNumero(UltimaCampanaFacturada,-1,@NroCampania)),0)
	FROM ods.Consultora WHERE ConsultoraID=@ConsultoraID;
		
	DECLARE @campaniafacturableingreso INT = @ultimacampaniafacturable - @idcampaniaingreso;
	DECLARE @campaniacompare INT = dbo.fnAddCampaniaAndNumero2(@ultimacampaniafacturable,1,@NroCampania);
	DECLARE @NumeroPedido INT;	
	DECLARE @indicador INT = 0;

	if @CampaniaID = @campaniacompare and (@campaniafacturableingreso between 0 and 3)
	begin		
		declare @CampaniaID1 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -1, @NroCampania);
		declare @CampaniaID2 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -2, @NroCampania);
		declare @CampaniaID3 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -3, @NroCampania);
		declare @CampaniaID4 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -4, @NroCampania);

		declare @idCampaniaID1 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID1);
		declare @idCampaniaID2 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID2);
		declare @idCampaniaID3 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID3);
		declare @idCampaniaID4 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID4);

		declare @campaniasFacturas int;

		---la consultora es nueva, esta realizando su segundo pedido compruebo que la campaña anterior tenga pedido facturado
		if @campaniafacturableingreso = 0
		begin
			set @NumeroPedido = 1;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1) and consultoraid = @ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 1, 1,0);
		end
		---la consultora es nueva, esta realizando su tercer pedido compruebo que las 2 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 1
		begin
			set @NumeroPedido=2;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 2, 1,0);
		end
		---la consultora es nueva, esta realizando su cuarto pedido compruebo que las 3 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 2
		begin
			set @NumeroPedido=3;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 3, 1,0);
		end
		---la consultora es nueva, esta realizando su quINTo pedido compruebo que las 4 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 3
		begin
			set @NumeroPedido=4;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido (nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3,@idCampaniaID4) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 4, 1,0);
		end
	end

	IF @indicador = 1 and (@campaniafacturableingreso between 0 and 3)
	begin
		SELECT TOP 4
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			MarcaID,
			IndicadorMontoMinimo,
			DescripcionProd,
			UnidadesPermitidas,
			(case when len(IndicadorPedido) >0 then 1 else 0 end) IndicadorPedido,
			ganahasta
		FROM (
			SELECT
				og.OfertaNuevaId,
				og.NumeroPedido,
				case isnull(og.FlagImagenActiva,0)
					when 1 then og.ImagenProducto01
					when 2 then og.ImagenProducto02
					when 3 then og.ImagenProducto03
					else ''
				end ImagenProducto01,
				og.Descripcion,
				og.CUV,
				og.PrecioNormal,
				og.PrecioParaTi,
				pc.MarcaID,
				pc.IndicadorMontoMinimo,
				coalesce(pd.Descripcion, pc.Descripcion) DescripcionProd,
				dbo.fnObtenerCantidadOfertaNueva(og.CUV, og.CampaniaID, og.UnidadesPermitidas,og.TipoOfertaSisID, og.ConfiguracionOfertaID) UnidadesPermitidas,
				isnull(pwd.CUV,'') IndicadorPedido,
				isnull(og.ganahasta, 0) ganahasta
			FROM dbo.OfertaNueva  og with(nolock)
			inner join ods.ProductoComercial pc with(nolock) on og.CUV = pc.CUV and og.CampaniaID = pc.AnoCampania
			inner join ods.Campania ca with(nolock) on pc.CampaniaID = ca.CampaniaID
			left join dbo.ProductoDescripcion pd with(nolock) on og.CampaniaID = pd.CampaniaID and og.CUV = pd.CUV
			left join PedidoWebDetalle pwd with(nolock) on pwd.CUV=og.CUV and pwd.CampaniaID= @CampaniaID and pwd.ConsultoraID=@ConsultoraID
			WHERE
				ca.CodiGO = @CampaniaID and
				og.FlagHabilitarOferta = 1 and
				og.NumeroPedido=@NumeroPedido and
				og.CUV not in(SELECT CUV FROM PedidoWebDetalle with(nolock) WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID)
		) a
		WHERE a.UnidadesPermitidas > 0
		order by 5 asc
	end
	else
	begin
		SELECT
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			'' MarcaID,
			'' IndicadorMontoMinimo,
			'' DescripcionProd,
			UnidadesPermitidas,
			0 IndicadorPedido,
			0 ganahasta
		FROM OfertaNueva with(nolock)
		WHERE OfertaNuevaID < 0
		order by 5 asc
	end
END
GO
/*end*/

USE BelcorpEcuador
GO
if object_id('fnGetTableTerritorioIdByFiltroAndUbigeo') is not null
begin
	drop function fnGetTableTerritorioIdByFiltroAndUbigeo;
end
GO
create function fnGetTableTerritorioIdByFiltroAndUbigeo(
	@TipoFiltroUbigeo int,
	@CodigoUbigeo varchar(24)
)
returns @List table (TerritorioID int, CodigoUbigeo varchar(24))
as
begin
	IF @TipoFiltroUbigeo = 1
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM ods.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 2
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 3
	BEGIN
		INSERT INTO @List
		SELECT TT.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		INNER JOIN ods.UBIGEO U with(nolock) ON U.UBIGEOID = T.TERRITORIOID
		INNER JOIN ods.TERRITORIO TT with(nolock) ON TT.CODIGOUBIGEO = U.CODIGOUBIGEO
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END

	return;
end
GO
IF OBJECT_ID('dbo.fnAddCampaniaAndNumero2') IS NOT NULL
BEGIN
	DROP FUNCTION dbo.fnAddCampaniaAndNumero2;
END
GO
CREATE FUNCTION dbo.fnAddCampaniaAndNumero2(
	@CampaniaActual INT,
	@AddNro INT,
	@NroCampanias INT
)
RETURNS INT
AS
BEGIN	
	DECLARE @AnioCampaniaActual INT = @CampaniaActual/100;
	DECLARE @NroCampaniaActual INT = @CampaniaActual%100;
	DECLARE @SumNroCampania INT = (@NroCampaniaActual + @AddNro) - 1;
	DECLARE @AnioCampaniaSiguiente INT = @AnioCampaniaActual + @SumNroCampania/@NroCampanias;
	DECLARE @NroCampaniaSiguiente INT = @SumNroCampania%@NroCampanias + 1;
	
	IF @NroCampaniaSiguiente < 1
	BEGIN
		SET @AnioCampaniaSiguiente = @AnioCampaniaSiguiente - 1;
		SET @NroCampaniaSiguiente = @NroCampaniaSiguiente + @NroCampanias;
	END
	DECLARE @CampaniaSiguiente INT = @AnioCampaniaSiguiente*100 + @NroCampaniaSiguiente;
	RETURN @CampaniaSiguiente;
END
GO
ALTER FUNCTION dbo.fnAddCampaniaAndNumero(
	@CodigoISO CHAR(2),
	@CampaniaActual INT,
	@AddNro INT
)
RETURNS INT
AS
BEGIN
	DECLARE @NroCampanias INT = IIF(
		ISNULL(@CodigoISO,'') <> '',
		(select top 1 NroCampanias from Pais with(nolock) where CodigoISO = @CodigoISO),
		(select top 1 NroCampanias from Pais with(nolock) where EstadoActivo = 1)
	);
	
	RETURN dbo.fnAddCampaniaAndNumero2(@CampaniaActual,@AddNro,@NroCampanias);
END
GO
ALTER FUNCTION dbo.fnGetConfiguracionCampania
(
	@PaisID tinyint,
	@ZonaID int,
	@RegionID int,
	@ConsultoraID bigint
)
RETURNS @TConfiguracionCampania TABLE(
	ID int,
	CampaniaID varchar(6),
	FechaInicioFacturacion datetime,
	FechaFinFacturacion datetime,
	CampaniaDescripcion varchar(6),
	HoraInicio time,
	HoraFin time,
	DiasAntes int,
	ZonaValida int,
	HoraInicioNoFacturable time,
	HoraCierreNoFacturable time,
	ZonaHoraria float,
	HoraCierreZonaNormal time,
	HoraCierreZonaDemAnti time,
	HoraCierreZonaDemAntiCierre time,
	EsZonaDemAnti int,
	DiasDuracionCronograma int,
	HabilitarRestriccionHoraria int,
	HorasDuracionRestriccion int,
	NroCampanias int,
	PROLSinStock bit,
	FechaFinFIC datetime,
	IndicadorOfertaFIC int,
	ImagenURLOfertaFIC varchar(500),
	NuevoPROL bit,
	ZonaNuevoPROL bit,
	EstadoSimplificacionCUV bit,
	EsquemaDAConsultora bit,	
	ValidacionInteractiva bit,
	MensajeValidacionInteractiva varchar(500),
	IndicadorEnviado bit,
	IndicadorGPRSB int,
	FechaActualPais datetime,
	EstadoPedido smallint,
	ValidacionAbierta BIT,
	FechaLimitePago SMALLDATETIME,
	AceptacionConsultoraDA int
)
AS
/*
select * from dbo.fnGetConfiguracionCampania(11,2161,2017,2)
*/
BEGIN
	-- Variables Pais
	DECLARE @CodigoISO CHAR(2)
	DECLARE @ZonaHoraria FLOAT
	DECLARE @HoraCierreZonaNormal TIME(0)
	DECLARE @HoraCierreZonaDemAnti TIME(0)
	DECLARE @NroCampanias INT
	DECLARE @PROLSinStock BIT
	DECLARE @NuevoPROL BIT
	DECLARE @EstadoSimplificacionCUV BIT
	DECLARE @EsquemaDAConsultora BIT
	DECLARE @TipoDA BIT
	DECLARE @PedidoFIC BIT

	select
		@CodigoISO = CodigoISO,
		@ZonaHoraria = ISNULL(ZonaHoraria,0),
		@HoraCierreZonaNormal = HoraCierreZonaNormal,
		@HoraCierreZonaDemAnti = HoraCierreZonaDemAnti,
		@NroCampanias = NroCampanias,
		@PROLSinStock = PROLSinStock,
		@NuevoPROL = NuevoPROL,
		@EstadoSimplificacionCUV = EstadoSimplificacionCUV,
		@EsquemaDAConsultora = EsquemaDAConsultora,
		@TipoDA = TipoDA,
		@PedidoFIC = PedidoFIC
	from Pais (nolock)
	where PaisId = @PaisID

	-- Variables ConfiguracionValidacion
	DECLARE @HoraInicio time(0)
	DECLARE @HoraFin time(0)
	DECLARE @DiasAntes tinyint
	DECLARE @HoraInicioNoFacturable time(0)
	DECLARE @HoraCierreNoFacturable time(0)
	DECLARE @HabilitarRestriccionHoraria bit
	DECLARE @HorasDuracionRestriccion INT
	DECLARE @ValidacionInteractiva bit
	DECLARE @MensajeValidacionInteractiva varchar(500)

	SELECT
		@HoraInicio = HoraInicio,
		@HoraFin = HoraFin,
		@DiasAntes = DiasAntes,
		@HoraInicioNoFacturable = HoraInicioNoFacturable,
		@HoraCierreNoFacturable = HoraCierreNoFacturable,
		@HabilitarRestriccionHoraria = HabilitarRestriccionHoraria,
		@HorasDuracionRestriccion =  ISNULL(HorasDuracionRestriccion,0),
		@ValidacionInteractiva = ValidacionInteractiva,
		@MensajeValidacionInteractiva = MensajeValidacionInteractiva
	FROM [dbo].[ConfiguracionValidacion] (nolock)
	WHERE  PaisID = @PaisID

	 -- Variables ConfiguracionValidacionZona
	DECLARE @DiasDuracionCronograma tinyint
	SET @DiasDuracionCronograma = 1
	DECLARE @ZonaValida int
	DECLARE @IndicadorDias bit
	SET @IndicadorDias = 0

	select
		@DiasDuracionCronograma = DiasDuracionCronograma,
		@ZonaValida = ZonaID,
		@IndicadorDias = ValidacionActiva
	from ConfiguracionValidacionZona with(nolock)
	where CampaniaID = 201301 and ZonaID = @ZonaID

	-- Dias Duracion Cronograma para Nuevas (CR)
	IF @PaisID = 5 OR @PaisID = 8 OR @PaisID = 7 OR @PaisID = 10
	BEGIN
		declare @UCF int = 0;
		declare @SID int = 0;

		select
			@UCF = ISNULL(UltimaCampanaFacturada,0),
			@SID = ISNULL(SegmentoId,0)
		from ods.Consultora with(nolock)
		where ConsultoraID = @ConsultoraID

		IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
			SET @DiasDuracionCronograma = 2
	END

	-- Variables ConfiguracionValidacionNuevoPROL
	DECLARE @ZonaNuevoPROL BIT = 0;
	DECLARE @ContNuevoPROL INT = 0;

	IF @NuevoPROL = 1
	BEGIN
		SELECT @ContNuevoPROL = COUNT(ZonaId)
		FROM ConfiguracionValidacionNuevoPROL with(nolock)
		WHERE ZonaId = @ZonaId

		IF @ContNuevoPROL > 0
			SET @ZonaNuevoPROL = 1
	END

	-- Otras Configuraciones
	IF @IndicadorDias = 0
		SET @DiasAntes = 0

	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	DECLARE @AceptacionConsultoraDA INT
	SET @AceptacionConsultoraDA = -1

	-- Obtener Campania Anterior
	DECLARE @Campania INT
	DECLARE @Anio INT
	SET @Campania = 0

	IF @EsquemaDAConsultora = 0
	BEGIN
		IF @TipoDA = 0
		BEGIN
			SELECT TOP 1
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
			WHERE
				c.ZonaID = @ZonaID AND
				c.RegionID = @RegionID AND
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
		ELSE
		BEGIN
			SELECT TOP 1	
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID		
			LEFT JOIN [dbo].[Cronograma] cr (nolock) ON 
				c.CampaniaID = cr.CampaniaID AND
				c.RegionID = cr.RegionID AND
				c.ZonaID = cr.ZonaID
			WHERE 
				c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
				IIF(@PaisID = 4,
					ISNULL(CONVERT(datetime, cr.FechaInicioDD) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioReFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal)),
					ISNULL(CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
								ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
								CONVERT(datetime, @HoraCierreZonaNormal))
				) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
	END
	ELSE
	BEGIN

		DECLARE @Campania_temp INT
		DECLARE @Anio_temp INT
		SET @Campania_temp = 0

		SELECT TOP 1
			@Campania_temp = ca.Codigo,
			@Anio_temp = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
				ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
		ORDER BY c.CampaniaID DESC

		IF(@Campania_temp <> 0)
		BEGIN
			SET @Campania_temp = @Campania_temp - @Anio_temp
			IF(@Campania_temp = @NroCampanias)
				SET @Campania_temp = @Anio_temp + 101
			ELSE
				SET @Campania_temp = @Anio_temp + @Campania_temp + 1

			SELECT @AceptacionConsultoraDA = TipoConfiguracion
			FROM ConfiguracionConsultoraDA with(nolock)
			WHERE			
				ConsultoraId = @ConsultoraId and
				ZonaId = @ZonaId and
				CampaniaId = cast(@Campania_temp as int)
		END

		SELECT TOP 1
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			IIF(@AceptacionConsultoraDA < 1,
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal),
				CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti)) < @FechaGeneral
		ORDER BY c.CampaniaID DESC
	END
	
	--Obtiene UltimaCampaniaFacturada
	declare @UltimaCampanaFacturada int;
	declare @TipoFacturacion char(2);
	declare @ConsultoraIdAsociada bigint;

	select
		@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0),
		@TipoFacturacion = ISNULL(TipoFacturacion,'')
	From ods.consultora (nolock)
	Where consultoraid = @consultoraid

	--Obtiene UltimaCampaniaFacturada x UsuarioPrueba
	IF @UltimaCampanaFacturada IS NULL
	BEGIN
		SELECT
			@UltimaCampanaFacturada = ISNULL(c.UltimaCampanaFacturada,0),
			@TipoFacturacion = ISNULL(c.TipoFacturacion,''),
			@ConsultoraIdAsociada = ISNULL(c.ConsultoraId,0)
		FROM ConsultoraFicticia cf with(nolock)
		INNER JOIN UsuarioPrueba up with(nolock) on cf.Codigo = up.CodigoFicticio
		INNER JOIN ods.Consultora c with(nolock) on up.CodigoConsultoraAsociada = c.Codigo
		WHERE cf.ConsultoraId = @consultoraid
	END

	IF @TipoFacturacion <> 'FA'
	BEGIN
		SET @UltimaCampanaFacturada = dbo.fnAddCampaniaAndNumero(@CodigoISO,@UltimaCampanaFacturada,-1);
	END

	-- Valida Campania Anterior
	IF(@Campania <> 0)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1

		IF @EsquemaDAConsultora = 1 AND @Campania > @Campania_temp
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
		
		-- validar si pertenece a una zona DA
		DECLARE @EsZonaDA BIT;
		SELECT @EsZonaDA = IIF(ISNULL(c.CampaniaID,0) = 0,0,1)
		FROM dbo.Cronograma c 
		INNER JOIN ods.Campania ca ON c.CampaniaID = ca.CampaniaID 
		WHERE
			ca.Codigo = @Campania_temp AND
			c.RegionID = @RegionID AND
			c.ZonaID = @ZonaID AND
			c.TipoCronograma = 2

		-- si el esquema es de DA y la zona es de DA y ya facturo en la campaña actual 
		-- y la consultora respondio que no en la DA anterior
		-- se resetea la variable
		IF (@EsquemaDAConsultora = 1 AND @EsZonaDA = 1 AND @UltimaCampanaFacturada = @Campania_temp AND @AceptacionConsultoraDA = 0) 
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
	END
	ELSE
	BEGIN
		SELECT TOP 1 
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		WHERE z.ZonaID = @ZonaID AND z.RegionID = @RegionID
		ORDER BY c.FechaInicioFacturacion ASC
	END

	--Valida UltimaCampaniaFacturada
	IF (@UltimaCampanaFacturada = @Campania)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1
	END
	ELSE
	BEGIN
		DECLARE @IndicadorEnviado BIT= 0, @ValidacionAbierta BIT = 0
		DECLARE @IndicadorGPR TINYINT = 0
		DECLARE @EstadoPedido SMALLINT
  
		SELECT	@IndicadorEnviado  = IndicadorEnviado,  
				@IndicadorGPR = GPRSB, 
				@EstadoPedido = EstadoPedido, 
				@ValidacionAbierta = ValidacionAbierta
		FROM	Pedidoweb (nolock)
		WHERE	CampaniaID = @campania and consultoraid = ISNULL(@ConsultoraIdAsociada,@consultoraid)	

		If(@IndicadorEnviado = 1 AND @IndicadorGPR = 0)
		BEGIN
			SET @Campania = @Campania - @Anio
			IF(@Campania = @NroCampanias)
				SET @Campania = @Anio + 101
			ELSE
				SET @Campania = @Anio + @Campania + 1
		END
	END

	-- Pedido FIC
	DECLARE @FechaFinFIC datetime;
	DECLARE @IndicadorOfertaFIC int = 0;
	DECLARE @ImagenURLOfertaFIC varchar(500) = '';

	IF @PedidoFIC = 1
	BEGIN
		DECLARE @campaniaFIC INT
		IF substring(cast(@Campania as varchar(6)),5,2)=cast(@NroCampanias as char(2))
			set @campaniaFIC=cast(cast( cast(substring(cast(@Campania as varchar(6)),1,4)as int)+1 as varchar(4)) + '01' as int)
		ELSE
			set @campaniaFIC= @Campania +1

		SELECT @FechaFinFIC=isnull(FechaFin,GETDATE())
		FROM CronogramaFIC with(nolock)
		WHERE 
			ZonaID=@ZonaID and 
			CampaniaID = (				
				SELECT CampaniaID
				FROM ods.Campania with(nolock)
				WHERE Codigo=@campaniaFIC
			);

		select top 1
			@IndicadorOfertaFIC = 1,
			@ImagenURLOfertaFIC = isnull(ImagenUrl,'')
		from OfertaFIC (nolock)
		where CampaniaID = @campaniaFIC;
	END
			
	-- Listar Variables
	IF @EsquemaDAConsultora = 0
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@TipoDA = 0,c.FechaInicioFacturacion,ISNULL(cr.FechaInicioWeb, c.FechaInicioFacturacion)) AS FechaInicioFacturacion,
			IIF(@TipoDA = 0,
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				IIF(@PaisID = 4,
					ISNULL(cr.FechaInicioDD,c.FechaInicioReFacturacion),
					ISNULL(cr.FechaInicioWeb,c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
						ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)))
			) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@TipoDA = 0, @HoraFin,IIF(ISNULL(cr.CampaniaId,0) = 0,@HoraFin,@HoraCierreZonaDemAnti)) as HoraFin,
			@DiasAntes AS DiasAntes,
			ISNULL(@ZonaValida,-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(@TipoDA = 0, 0, IIF(ISNULL(cr.CampaniaId,0) = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END
	ELSE
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@AceptacionConsultoraDA < 1, c.FechaInicioFacturacion, cr.FechaInicioWeb) AS FechaInicioFacturacion,
			IIF(@AceptacionConsultoraDA < 1, 
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				cr.FechaInicioWeb) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@AceptacionConsultoraDA < 1, @HoraFin, @HoraCierreZonaDemAnti) as HoraFin,
			@DiasAntes AS DiasAntes,
			IIF(@AceptacionConsultoraDA < 1,ISNULL(@ZonaValida,-1),-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			IIF(@AceptacionConsultoraDA < 1,@HoraCierreZonaNormal,@HoraCierreZonaDemAnti) AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(ISNULL(cr.CampaniaId,0) = 0,0,IIF(@AceptacionConsultoraDA = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END

	RETURN
END
GO
ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @CodigoConsultora VARCHAR(50);
	SELECT TOP 1 @CodigoConsultora = co.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		iif(@PaisValido = 1, CO.ZonaID, CO.TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) AND
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	RETURN ISNULL(@CodigoConsultora, '');
END
GO
ALTER FUNCTION dbo.ObtenerConsultoraVecina
(
	@PaisID INT,
	@EdadMaxima INT,
	@UltimaCampanaFacturada INT,
	@ListadoConsultoraId dbo.IdBigintType READONLY,
	@RegionID INT,
	@ZonaID INT,
	@SeccionID INT,
	@TerritorioID INT
)
RETURNS @Consultora TABLE(
	ConsultoraID BIGINT,
	Codigo VARCHAR(30)
)
AS
BEGIN
	INSERT INTO @Consultora(ConsultoraID, Codigo)
	SELECT TOP 1 CO.ConsultoraID, CO.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID      
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, CO.FechaNacimiento, getdate()) <= @EdadMaxima AND
		CO.UltimaCampanaFacturada >= @UltimaCampanaFacturada AND
		CO.ConsultoraID NOT IN (SELECT Id FROM @ListadoConsultoraId) AND
		CO.RegionID = @RegionID AND CO.ZonaID = @ZonaID AND
		(@SeccionID = 0 OR CO.SeccionID = @SeccionID) AND
		(@TerritorioID = 0 OR CO.TerritorioID = @TerritorioID)
	ORDER BY MontoUltimoPedido DESC;
           
	RETURN;
END
GO
ALTER FUNCTION ValidarAutorizacion
(
	@paisID			INT,
	@CodigoUsuario	VARCHAR(100)
)
RETURNS INT
AS
/*
	SELECT DBO.ValidarAutorizacion(3, '1281283')
	SELECT DBO.ValidarAutorizacion(3, '076912262')
*/
BEGIN
	DECLARE @Usuario VARCHAR(100),
            @RolID INT,
            @AutorizaPedido VARCHAR(10),
            @IdEstadoActividad INT,
            @UltimaCampania INT,
            @CampaniaActual INT,
			@Resultado	INT,
			@CodigoConsultora varchar(20),
			@ZonaID INT,
			@RegionID INT,
			@ConsultoraID INT

	SET @RolID = 0
	SET @Usuario = ''
	SET @IdEstadoActividad = -1
	SET @UltimaCampania = 0
	SET @CampaniaActual = 0
	SET @Resultado = 0	

	SELECT	
		@CodigoConsultora = IsNull(CodigoConsultora,0),
		@PaisID = IsNull(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE codigousuario = @CodigoUsuario

	SELECT	
		@ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
		@AutorizaPedido = ISNULL(AutorizaPedido,''),
		@UltimaCampania = ISNULL(UltimaCampanaFacturada,0)
	FROM ods.consultora WITH(NOLOCK)
	WHERE codigo = @CodigoConsultora

	SELECT 
		@Usuario = u.CodigoUsuario, 
		@RolID = ISNULL(ur.RolId,0),
		@AutorizaPedido = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END),
		@CampaniaActual = ISNULL((SELECT TOP 1 campaniaId FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	FROM Usuario u WITH(NOLOCK)
		LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

    --0: Usuario No Existe
    --1: Usuario No es del Portal
    --2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
    --3: Usuario OK
	DECLARE @tabla_Retirada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Retirada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 12
	
	DECLARE @tabla_Reingresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Reingresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 18
	
	DECLARE @tabla_Egresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Egresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 19

    IF @Usuario IS NOT NULL AND @Usuario <> ''
    BEGIN
        IF @RolID != 0
        BEGIN
            IF @AutorizaPedido IS NOT NULL AND @AutorizaPedido <> ''
            BEGIN
                IF @IdEstadoActividad <> -1
                BEGIN
                    -- Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
                    IF @paisID = 11 OR @paisID = 2 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                    BEGIN
                        --Validamos si el estado es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                            BEGIN
                                --Caso Colombia
								IF @paisID = 4
								BEGIN
                                    SET @Resultado =  2
                                END
								ELSE
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                            END
                            ELSE
                            BEGIN
                                --Para bolivia (FOX) se hace la validación del campo AutorizaPedido
                                IF @paisID = 2
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                BEGIN
                                    SET @Resultado =  3
                                END
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es reingresada
                            IF EXISTS(SELECT 1 FROM @tabla_Reingresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
                                IF @paisID = 3
                                BEGIN
                                    --Se valida las campañas que no ha ingresado
									DECLARE @CampaniasSinIngresar INT = 0;
                                    IF LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampania) = 6
                                    BEGIN
										set @CampaniasSinIngresar = @CampaniaActual - dbo.fnAddCampaniaAndNumero(null,@UltimaCampania,3);
                                    END

                                    IF @CampaniasSinIngresar > 0
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        --Validamos el Autoriza Pedido
                                        IF @AutorizaPedido = 'N'
                                            SET @Resultado =  2
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                                ELSE
                                BEGIN
                                    --Caso Colombia
                                    IF @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        IF @AutorizaPedido = 'N'
                                        BEGIN
                                            --Validamos si es SICC o Bolivia
                                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2
                                                SET @Resultado =  2
                                            ELSE
                                                SET @Resultado =  3
                                        END
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                            END
                            ELSE
                            BEGIN
                                --Caso Colombia
                                IF @paisID = 4
                                BEGIN
                                    --Egresada o Posible Egreso
                                    IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                                    BEGIN
                                        SET @Resultado =  2
                                    END
                                END

                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC o Bolivia
                                    IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2 OR @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3

                            END
                        END
                    END
                    -- Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
                    ELSE IF @paisID = 5 OR @paisID = 10 OR @paisID = 9 OR @paisID = 12 OR @paisID = 13 OR @paisID = 6 OR @paisID = 1 OR @paisID = 14
                    BEGIN
                        -- Validamos si la consultora es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                    SET @Resultado =  2
                                ELSE
                                    SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    SET @Resultado =  2
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es retirada
                            IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
								IF @AutorizaPedido = 'N'
								BEGIN
									--Validamos si es SICC
									IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
										SET @Resultado =  2
									ELSE
										SET @Resultado =  3
								END
								ELSE
									SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC
                                    IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                    END
                    ELSE
                        SET @Resultado = 3
                END
                ELSE
                    SET @Resultado = 3 --Se asume para usuarios del tipo SAC
            END
            ELSE
                SET @Resultado = 3 --Se asume para usuarios del tipo SAC
        END
        ELSE
            SET @Resultado = 1
    END
    ELSE
        SET @Resultado = 0

    RETURN @Resultado

END
GO
ALTER PROCEDURE dbo.GetSesionUsuario_SB2
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	
	DECLARE @FechaLimitePago SMALLDATETIME
	DECLARE @ODSCampaniaID INT
	
	declare @PaisID int
	declare @UsuarioPrueba bit
	declare @CodConsultora varchar(20)
	declare @CampaniaID int
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint
	declare @UltimaCampanaFacturada int
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario

	declare @CountCodigoNivel bigint

	/*Oferta Final, Catalogo Personalizado, CDR*/
	declare @EsOfertaFinalZonaValida bit = 0
	declare @EsOFGanaMasZonaValida bit = 0
	declare @EsCatalogoPersonalizadoZonaValida bit = 0
	declare @EsCDRWebZonaValida  bit = 0
	declare @CodigoZona varchar(4) = ''
	declare @CodigoRegion varchar(2) = ''

	select
		@CodigoZona = IsNull(z.Codigo,''),
		@CodigoRegion = IsNull(r.Codigo,'')
	from ods.consultora c with(nolock)
	inner join ods.Region r on
		c.RegionID = r.RegionID
	inner join ods.Zona z on
		c.ZonaID = z.ZonaID
	where c.codigo = @CodConsultora

	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
		
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/

	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;
	
	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919

	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0

		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;

		/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,-11), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
		)

		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			isnull(c.EsJoven,0) EsJoven,
			(case
				when @CountCodigoNivel =0 then 0  --1589
				when @CountCodigoNivel>0 then 1 End) Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			null as ConsultoraAsociada, --1688
			isnull(si.descripcion,null) SegmentoConstancia, --2469
			isnull(se.Codigo,null) Seccion, --2469
			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469
			case When cl.ConsultoraID is null then 0
				else 1 end esConsultoraLider,
			u.EMailActivo, --2532
			si.SegmentoInternoId,
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u with(nolock)
		LEFT JOIN (
			select *
			from ods.consultora with(nolock)
			where ConsultoraId = @ConsultoraID
		) c ON u.CodigoConsultora = c.Codigo
		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID
		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469
		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469
		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t with(nolock) ON 
			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeo
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@MarcaId int,
	@tipoFiltroUbigeo int
)    
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;
	
	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
	
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';
	
	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1,''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2,''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3,'')
	FROM Ubigeo U with(nolock)
	WHERE codigoubigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		--ISNULL((select top 1 campaniaId from dbo.GetCampaniaPreLogin(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID)),0) as CampaniaActual,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND (@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite) AND
		UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.CampaniaId, -2)
	ORDER BY C.UltimaCampanaFacturada DESC, C.MontoUltimoPedido DESC
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@Nombres varchar(51),
	@Apellidos varchar(51),
	@MarcaId int,
	@tipoFiltroUbigeo int
)
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;

	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
 
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';

	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1, ''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2, ''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3, '')
	FROM Ubigeo with(nolock)
	WHERE CodigoUbigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND
		CONCAT(PrimerNombre,' ',SegundoNombre) LIKE CONCAT('%',@Nombres,'%') AND
		CONCAT(PrimerApellido,' ',SegundoApellido) LIKE CONCAT('%',@Apellidos,'%') AND
		(@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite);
END
GO
ALTER PROCEDURE dbo.GetConsultorasPorUbigeo
	@PaisId int,    
	@CodigoUbigeo varchar(24),    
	@Campania int,    
	@MarcaId int,
	@tipoFiltroUbigeo int
AS    
BEGIN
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	CREATE TABLE #TempConsultoraUbigeo    
	(    
		ID int IDENTITY,    
		ConsultoraID bigint,    
		Codigo varchar(100),    
		CodigoUbigeo varchar(24),    
		NombreCompletoConsultora varchar(300),    
		Email varchar(200),      
		FechaNacimiento datetime,    
		MONTOULTIMOPEDIDO MONEY,    
		UltimaCampanaFacturada INT,     
		CodigoUsuario varchar(100),    
		ZonaID int,    
		RegionID int  
	)

	INSERT INTO #TempConsultoraUbigeo  
    SELECT DISTINCT
		C.ConsultoraID,    
		C.Codigo,
		@CodigoUbigeo as CodigoUbigeo,
		C.NombreCompleto as NombreCompletoConsultora,
		U.Email,
		FechaNacimiento,
		MONTOULTIMOPEDIDO,
		UltimaCampanaFacturada,
		u.CodigoUsuario,
		c.ZonaID,
		c.RegionID    
    FROM ods.CONSULTORA AS C  
    INNER JOIN AFILIACLIENTECONSULTORA AS ACC ON C.CONSULTORAID = ACC.CONSULTORAID  
    INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo   
    WHERE ACC.EsAfiliado = 1 AND C.TERRITORIOID IN (SELECT TerritorioID FROM @TerritorioObjetivo);
		
    IF @MarcaId = 3    
    BEGIN
		DECLARE @EDADLIMITE INT = (SELECT Codigo FROM TABLALOGICADATOS WHERE TABLALOGICAID = 56 AND TABLALOGICADATOSID = 5605);

		DELETE FROM #TempConsultoraUbigeo 
		WHERE ID IN(  
			SELECT ID
			FROM #TempConsultoraUbigeo  
			WHERE (YEAR(getdate()) - year(FechaNacimiento)) >= @EDADLIMITE
		);
    END  
  
   -- -- FILTRANDO CONSULTORAS QUE HAYAN FACTURADO EN LA CAMPAÑANA ANTERIOR  
    --R2442 -  JC - Ya no filtrará por Campaña actual  
    SELECT TCU.ConsultoraID, TCU.Codigo, TCU.CodigoUbigeo, TCU.NombreCompletoConsultora as NombreCompleto, TCU.Email
    FROM #TempConsultoraUbigeo TCU
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,TCU.ZonaID,TCU.RegionID,TCU.ConsultoraID) CC
    WHERE
		dbo.ValidarAutorizacion(@PaisId, TCU.CodigoUsuario) = 3 AND
		TCU.UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.campaniaId, -2)
	order by ULTIMACAMPANAFACTURADA DESC , MONTOULTIMOPEDIDO DESC --R2626 
	
	DROP TABLE #TempConsultoraUbigeo;
END
GO
ALTER PROCEDURE GetProductosOfertaConsultoraNueva
	@CampaniaID INT,
	@ConsultoraID INT
AS
BEGIN
	DECLARE @NroCampania INT = (SELECT TOP 1 nrocampanias FROM pais with(nolock) WHERE EstadoActivo = 1);

	DECLARE @ultimacampaniafacturable INT;
	DECLARE @idcampaniaingreso INT;
	SELECT
		@idcampaniaingreso = AnoCampanaIngreso,
		@ultimacampaniafacturable = isnull(iif(TipoFacturacion = 'FA', UltimaCampanaFacturada, dbo.fnAddCampaniaAndNumero(UltimaCampanaFacturada,-1,@NroCampania)),0)
	FROM ods.Consultora WHERE ConsultoraID=@ConsultoraID;
		
	DECLARE @campaniafacturableingreso INT = @ultimacampaniafacturable - @idcampaniaingreso;
	DECLARE @campaniacompare INT = dbo.fnAddCampaniaAndNumero2(@ultimacampaniafacturable,1,@NroCampania);
	DECLARE @NumeroPedido INT;	
	DECLARE @indicador INT = 0;

	if @CampaniaID = @campaniacompare and (@campaniafacturableingreso between 0 and 3)
	begin		
		declare @CampaniaID1 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -1, @NroCampania);
		declare @CampaniaID2 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -2, @NroCampania);
		declare @CampaniaID3 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -3, @NroCampania);
		declare @CampaniaID4 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -4, @NroCampania);

		declare @idCampaniaID1 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID1);
		declare @idCampaniaID2 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID2);
		declare @idCampaniaID3 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID3);
		declare @idCampaniaID4 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID4);

		declare @campaniasFacturas int;

		---la consultora es nueva, esta realizando su segundo pedido compruebo que la campaña anterior tenga pedido facturado
		if @campaniafacturableingreso = 0
		begin
			set @NumeroPedido = 1;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1) and consultoraid = @ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 1, 1,0);
		end
		---la consultora es nueva, esta realizando su tercer pedido compruebo que las 2 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 1
		begin
			set @NumeroPedido=2;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 2, 1,0);
		end
		---la consultora es nueva, esta realizando su cuarto pedido compruebo que las 3 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 2
		begin
			set @NumeroPedido=3;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 3, 1,0);
		end
		---la consultora es nueva, esta realizando su quINTo pedido compruebo que las 4 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 3
		begin
			set @NumeroPedido=4;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido (nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3,@idCampaniaID4) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 4, 1,0);
		end
	end

	IF @indicador = 1 and (@campaniafacturableingreso between 0 and 3)
	begin
		SELECT TOP 4
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			MarcaID,
			IndicadorMontoMinimo,
			DescripcionProd,
			UnidadesPermitidas,
			(case when len(IndicadorPedido) >0 then 1 else 0 end) IndicadorPedido,
			ganahasta
		FROM (
			SELECT
				og.OfertaNuevaId,
				og.NumeroPedido,
				case isnull(og.FlagImagenActiva,0)
					when 1 then og.ImagenProducto01
					when 2 then og.ImagenProducto02
					when 3 then og.ImagenProducto03
					else ''
				end ImagenProducto01,
				og.Descripcion,
				og.CUV,
				og.PrecioNormal,
				og.PrecioParaTi,
				pc.MarcaID,
				pc.IndicadorMontoMinimo,
				coalesce(pd.Descripcion, pc.Descripcion) DescripcionProd,
				dbo.fnObtenerCantidadOfertaNueva(og.CUV, og.CampaniaID, og.UnidadesPermitidas,og.TipoOfertaSisID, og.ConfiguracionOfertaID) UnidadesPermitidas,
				isnull(pwd.CUV,'') IndicadorPedido,
				isnull(og.ganahasta, 0) ganahasta
			FROM dbo.OfertaNueva  og with(nolock)
			inner join ods.ProductoComercial pc with(nolock) on og.CUV = pc.CUV and og.CampaniaID = pc.AnoCampania
			inner join ods.Campania ca with(nolock) on pc.CampaniaID = ca.CampaniaID
			left join dbo.ProductoDescripcion pd with(nolock) on og.CampaniaID = pd.CampaniaID and og.CUV = pd.CUV
			left join PedidoWebDetalle pwd with(nolock) on pwd.CUV=og.CUV and pwd.CampaniaID= @CampaniaID and pwd.ConsultoraID=@ConsultoraID
			WHERE
				ca.CodiGO = @CampaniaID and
				og.FlagHabilitarOferta = 1 and
				og.NumeroPedido=@NumeroPedido and
				og.CUV not in(SELECT CUV FROM PedidoWebDetalle with(nolock) WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID)
		) a
		WHERE a.UnidadesPermitidas > 0
		order by 5 asc
	end
	else
	begin
		SELECT
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			'' MarcaID,
			'' IndicadorMontoMinimo,
			'' DescripcionProd,
			UnidadesPermitidas,
			0 IndicadorPedido,
			0 ganahasta
		FROM OfertaNueva with(nolock)
		WHERE OfertaNuevaID < 0
		order by 5 asc
	end
END
GO
/*end*/

USE BelcorpGuatemala
GO
if object_id('fnGetTableTerritorioIdByFiltroAndUbigeo') is not null
begin
	drop function fnGetTableTerritorioIdByFiltroAndUbigeo;
end
GO
create function fnGetTableTerritorioIdByFiltroAndUbigeo(
	@TipoFiltroUbigeo int,
	@CodigoUbigeo varchar(24)
)
returns @List table (TerritorioID int, CodigoUbigeo varchar(24))
as
begin
	IF @TipoFiltroUbigeo = 1
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM ods.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 2
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 3
	BEGIN
		INSERT INTO @List
		SELECT TT.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		INNER JOIN ods.UBIGEO U with(nolock) ON U.UBIGEOID = T.TERRITORIOID
		INNER JOIN ods.TERRITORIO TT with(nolock) ON TT.CODIGOUBIGEO = U.CODIGOUBIGEO
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END

	return;
end
GO
IF OBJECT_ID('dbo.fnAddCampaniaAndNumero2') IS NOT NULL
BEGIN
	DROP FUNCTION dbo.fnAddCampaniaAndNumero2;
END
GO
CREATE FUNCTION dbo.fnAddCampaniaAndNumero2(
	@CampaniaActual INT,
	@AddNro INT,
	@NroCampanias INT
)
RETURNS INT
AS
BEGIN	
	DECLARE @AnioCampaniaActual INT = @CampaniaActual/100;
	DECLARE @NroCampaniaActual INT = @CampaniaActual%100;
	DECLARE @SumNroCampania INT = (@NroCampaniaActual + @AddNro) - 1;
	DECLARE @AnioCampaniaSiguiente INT = @AnioCampaniaActual + @SumNroCampania/@NroCampanias;
	DECLARE @NroCampaniaSiguiente INT = @SumNroCampania%@NroCampanias + 1;
	
	IF @NroCampaniaSiguiente < 1
	BEGIN
		SET @AnioCampaniaSiguiente = @AnioCampaniaSiguiente - 1;
		SET @NroCampaniaSiguiente = @NroCampaniaSiguiente + @NroCampanias;
	END
	DECLARE @CampaniaSiguiente INT = @AnioCampaniaSiguiente*100 + @NroCampaniaSiguiente;
	RETURN @CampaniaSiguiente;
END
GO
ALTER FUNCTION dbo.fnAddCampaniaAndNumero(
	@CodigoISO CHAR(2),
	@CampaniaActual INT,
	@AddNro INT
)
RETURNS INT
AS
BEGIN
	DECLARE @NroCampanias INT = IIF(
		ISNULL(@CodigoISO,'') <> '',
		(select top 1 NroCampanias from Pais with(nolock) where CodigoISO = @CodigoISO),
		(select top 1 NroCampanias from Pais with(nolock) where EstadoActivo = 1)
	);
	
	RETURN dbo.fnAddCampaniaAndNumero2(@CampaniaActual,@AddNro,@NroCampanias);
END
GO
ALTER FUNCTION dbo.fnGetConfiguracionCampania
(
	@PaisID tinyint,
	@ZonaID int,
	@RegionID int,
	@ConsultoraID bigint
)
RETURNS @TConfiguracionCampania TABLE(
	ID int,
	CampaniaID varchar(6),
	FechaInicioFacturacion datetime,
	FechaFinFacturacion datetime,
	CampaniaDescripcion varchar(6),
	HoraInicio time,
	HoraFin time,
	DiasAntes int,
	ZonaValida int,
	HoraInicioNoFacturable time,
	HoraCierreNoFacturable time,
	ZonaHoraria float,
	HoraCierreZonaNormal time,
	HoraCierreZonaDemAnti time,
	HoraCierreZonaDemAntiCierre time,
	EsZonaDemAnti int,
	DiasDuracionCronograma int,
	HabilitarRestriccionHoraria int,
	HorasDuracionRestriccion int,
	NroCampanias int,
	PROLSinStock bit,
	FechaFinFIC datetime,
	IndicadorOfertaFIC int,
	ImagenURLOfertaFIC varchar(500),
	NuevoPROL bit,
	ZonaNuevoPROL bit,
	EstadoSimplificacionCUV bit,
	EsquemaDAConsultora bit,	
	ValidacionInteractiva bit,
	MensajeValidacionInteractiva varchar(500),
	IndicadorEnviado bit,
	IndicadorGPRSB int,
	FechaActualPais datetime,
	EstadoPedido smallint,
	ValidacionAbierta BIT,
	FechaLimitePago SMALLDATETIME,
	AceptacionConsultoraDA int
)
AS
/*
select * from dbo.fnGetConfiguracionCampania(11,2161,2017,2)
*/
BEGIN
	-- Variables Pais
	DECLARE @CodigoISO CHAR(2)
	DECLARE @ZonaHoraria FLOAT
	DECLARE @HoraCierreZonaNormal TIME(0)
	DECLARE @HoraCierreZonaDemAnti TIME(0)
	DECLARE @NroCampanias INT
	DECLARE @PROLSinStock BIT
	DECLARE @NuevoPROL BIT
	DECLARE @EstadoSimplificacionCUV BIT
	DECLARE @EsquemaDAConsultora BIT
	DECLARE @TipoDA BIT
	DECLARE @PedidoFIC BIT

	select
		@CodigoISO = CodigoISO,
		@ZonaHoraria = ISNULL(ZonaHoraria,0),
		@HoraCierreZonaNormal = HoraCierreZonaNormal,
		@HoraCierreZonaDemAnti = HoraCierreZonaDemAnti,
		@NroCampanias = NroCampanias,
		@PROLSinStock = PROLSinStock,
		@NuevoPROL = NuevoPROL,
		@EstadoSimplificacionCUV = EstadoSimplificacionCUV,
		@EsquemaDAConsultora = EsquemaDAConsultora,
		@TipoDA = TipoDA,
		@PedidoFIC = PedidoFIC
	from Pais (nolock)
	where PaisId = @PaisID

	-- Variables ConfiguracionValidacion
	DECLARE @HoraInicio time(0)
	DECLARE @HoraFin time(0)
	DECLARE @DiasAntes tinyint
	DECLARE @HoraInicioNoFacturable time(0)
	DECLARE @HoraCierreNoFacturable time(0)
	DECLARE @HabilitarRestriccionHoraria bit
	DECLARE @HorasDuracionRestriccion INT
	DECLARE @ValidacionInteractiva bit
	DECLARE @MensajeValidacionInteractiva varchar(500)

	SELECT
		@HoraInicio = HoraInicio,
		@HoraFin = HoraFin,
		@DiasAntes = DiasAntes,
		@HoraInicioNoFacturable = HoraInicioNoFacturable,
		@HoraCierreNoFacturable = HoraCierreNoFacturable,
		@HabilitarRestriccionHoraria = HabilitarRestriccionHoraria,
		@HorasDuracionRestriccion =  ISNULL(HorasDuracionRestriccion,0),
		@ValidacionInteractiva = ValidacionInteractiva,
		@MensajeValidacionInteractiva = MensajeValidacionInteractiva
	FROM [dbo].[ConfiguracionValidacion] (nolock)
	WHERE  PaisID = @PaisID

	 -- Variables ConfiguracionValidacionZona
	DECLARE @DiasDuracionCronograma tinyint
	SET @DiasDuracionCronograma = 1
	DECLARE @ZonaValida int
	DECLARE @IndicadorDias bit
	SET @IndicadorDias = 0

	select
		@DiasDuracionCronograma = DiasDuracionCronograma,
		@ZonaValida = ZonaID,
		@IndicadorDias = ValidacionActiva
	from ConfiguracionValidacionZona with(nolock)
	where CampaniaID = 201301 and ZonaID = @ZonaID

	-- Dias Duracion Cronograma para Nuevas (CR)
	IF @PaisID = 5 OR @PaisID = 8 OR @PaisID = 7 OR @PaisID = 10
	BEGIN
		declare @UCF int = 0;
		declare @SID int = 0;

		select
			@UCF = ISNULL(UltimaCampanaFacturada,0),
			@SID = ISNULL(SegmentoId,0)
		from ods.Consultora with(nolock)
		where ConsultoraID = @ConsultoraID

		IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
			SET @DiasDuracionCronograma = 2
	END

	-- Variables ConfiguracionValidacionNuevoPROL
	DECLARE @ZonaNuevoPROL BIT = 0;
	DECLARE @ContNuevoPROL INT = 0;

	IF @NuevoPROL = 1
	BEGIN
		SELECT @ContNuevoPROL = COUNT(ZonaId)
		FROM ConfiguracionValidacionNuevoPROL with(nolock)
		WHERE ZonaId = @ZonaId

		IF @ContNuevoPROL > 0
			SET @ZonaNuevoPROL = 1
	END

	-- Otras Configuraciones
	IF @IndicadorDias = 0
		SET @DiasAntes = 0

	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	DECLARE @AceptacionConsultoraDA INT
	SET @AceptacionConsultoraDA = -1

	-- Obtener Campania Anterior
	DECLARE @Campania INT
	DECLARE @Anio INT
	SET @Campania = 0

	IF @EsquemaDAConsultora = 0
	BEGIN
		IF @TipoDA = 0
		BEGIN
			SELECT TOP 1
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
			WHERE
				c.ZonaID = @ZonaID AND
				c.RegionID = @RegionID AND
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
		ELSE
		BEGIN
			SELECT TOP 1	
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID		
			LEFT JOIN [dbo].[Cronograma] cr (nolock) ON 
				c.CampaniaID = cr.CampaniaID AND
				c.RegionID = cr.RegionID AND
				c.ZonaID = cr.ZonaID
			WHERE 
				c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
				IIF(@PaisID = 4,
					ISNULL(CONVERT(datetime, cr.FechaInicioDD) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioReFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal)),
					ISNULL(CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
								ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
								CONVERT(datetime, @HoraCierreZonaNormal))
				) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
	END
	ELSE
	BEGIN

		DECLARE @Campania_temp INT
		DECLARE @Anio_temp INT
		SET @Campania_temp = 0

		SELECT TOP 1
			@Campania_temp = ca.Codigo,
			@Anio_temp = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
				ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
		ORDER BY c.CampaniaID DESC

		IF(@Campania_temp <> 0)
		BEGIN
			SET @Campania_temp = @Campania_temp - @Anio_temp
			IF(@Campania_temp = @NroCampanias)
				SET @Campania_temp = @Anio_temp + 101
			ELSE
				SET @Campania_temp = @Anio_temp + @Campania_temp + 1

			SELECT @AceptacionConsultoraDA = TipoConfiguracion
			FROM ConfiguracionConsultoraDA with(nolock)
			WHERE			
				ConsultoraId = @ConsultoraId and
				ZonaId = @ZonaId and
				CampaniaId = cast(@Campania_temp as int)
		END

		SELECT TOP 1
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			IIF(@AceptacionConsultoraDA < 1,
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal),
				CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti)) < @FechaGeneral
		ORDER BY c.CampaniaID DESC
	END
	
	--Obtiene UltimaCampaniaFacturada
	declare @UltimaCampanaFacturada int;
	declare @TipoFacturacion char(2);
	declare @ConsultoraIdAsociada bigint;

	select
		@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0),
		@TipoFacturacion = ISNULL(TipoFacturacion,'')
	From ods.consultora (nolock)
	Where consultoraid = @consultoraid

	--Obtiene UltimaCampaniaFacturada x UsuarioPrueba
	IF @UltimaCampanaFacturada IS NULL
	BEGIN
		SELECT
			@UltimaCampanaFacturada = ISNULL(c.UltimaCampanaFacturada,0),
			@TipoFacturacion = ISNULL(c.TipoFacturacion,''),
			@ConsultoraIdAsociada = ISNULL(c.ConsultoraId,0)
		FROM ConsultoraFicticia cf with(nolock)
		INNER JOIN UsuarioPrueba up with(nolock) on cf.Codigo = up.CodigoFicticio
		INNER JOIN ods.Consultora c with(nolock) on up.CodigoConsultoraAsociada = c.Codigo
		WHERE cf.ConsultoraId = @consultoraid
	END

	IF @TipoFacturacion <> 'FA'
	BEGIN
		SET @UltimaCampanaFacturada = dbo.fnAddCampaniaAndNumero(@CodigoISO,@UltimaCampanaFacturada,-1);
	END

	-- Valida Campania Anterior
	IF(@Campania <> 0)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1

		IF @EsquemaDAConsultora = 1 AND @Campania > @Campania_temp
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
		
		-- validar si pertenece a una zona DA
		DECLARE @EsZonaDA BIT;
		SELECT @EsZonaDA = IIF(ISNULL(c.CampaniaID,0) = 0,0,1)
		FROM dbo.Cronograma c 
		INNER JOIN ods.Campania ca ON c.CampaniaID = ca.CampaniaID 
		WHERE
			ca.Codigo = @Campania_temp AND
			c.RegionID = @RegionID AND
			c.ZonaID = @ZonaID AND
			c.TipoCronograma = 2

		-- si el esquema es de DA y la zona es de DA y ya facturo en la campaña actual 
		-- y la consultora respondio que no en la DA anterior
		-- se resetea la variable
		IF (@EsquemaDAConsultora = 1 AND @EsZonaDA = 1 AND @UltimaCampanaFacturada = @Campania_temp AND @AceptacionConsultoraDA = 0) 
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
	END
	ELSE
	BEGIN
		SELECT TOP 1 
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		WHERE z.ZonaID = @ZonaID AND z.RegionID = @RegionID
		ORDER BY c.FechaInicioFacturacion ASC
	END

	--Valida UltimaCampaniaFacturada
	IF (@UltimaCampanaFacturada = @Campania)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1
	END
	ELSE
	BEGIN
		DECLARE @IndicadorEnviado BIT= 0, @ValidacionAbierta BIT = 0
		DECLARE @IndicadorGPR TINYINT = 0
		DECLARE @EstadoPedido SMALLINT
  
		SELECT	@IndicadorEnviado  = IndicadorEnviado,  
				@IndicadorGPR = GPRSB, 
				@EstadoPedido = EstadoPedido, 
				@ValidacionAbierta = ValidacionAbierta
		FROM	Pedidoweb (nolock)
		WHERE	CampaniaID = @campania and consultoraid = ISNULL(@ConsultoraIdAsociada,@consultoraid)	

		If(@IndicadorEnviado = 1 AND @IndicadorGPR = 0)
		BEGIN
			SET @Campania = @Campania - @Anio
			IF(@Campania = @NroCampanias)
				SET @Campania = @Anio + 101
			ELSE
				SET @Campania = @Anio + @Campania + 1
		END
	END

	-- Pedido FIC
	DECLARE @FechaFinFIC datetime;
	DECLARE @IndicadorOfertaFIC int = 0;
	DECLARE @ImagenURLOfertaFIC varchar(500) = '';

	IF @PedidoFIC = 1
	BEGIN
		DECLARE @campaniaFIC INT
		IF substring(cast(@Campania as varchar(6)),5,2)=cast(@NroCampanias as char(2))
			set @campaniaFIC=cast(cast( cast(substring(cast(@Campania as varchar(6)),1,4)as int)+1 as varchar(4)) + '01' as int)
		ELSE
			set @campaniaFIC= @Campania +1

		SELECT @FechaFinFIC=isnull(FechaFin,GETDATE())
		FROM CronogramaFIC with(nolock)
		WHERE 
			ZonaID=@ZonaID and 
			CampaniaID = (				
				SELECT CampaniaID
				FROM ods.Campania with(nolock)
				WHERE Codigo=@campaniaFIC
			);

		select top 1
			@IndicadorOfertaFIC = 1,
			@ImagenURLOfertaFIC = isnull(ImagenUrl,'')
		from OfertaFIC (nolock)
		where CampaniaID = @campaniaFIC;
	END
			
	-- Listar Variables
	IF @EsquemaDAConsultora = 0
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@TipoDA = 0,c.FechaInicioFacturacion,ISNULL(cr.FechaInicioWeb, c.FechaInicioFacturacion)) AS FechaInicioFacturacion,
			IIF(@TipoDA = 0,
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				IIF(@PaisID = 4,
					ISNULL(cr.FechaInicioDD,c.FechaInicioReFacturacion),
					ISNULL(cr.FechaInicioWeb,c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
						ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)))
			) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@TipoDA = 0, @HoraFin,IIF(ISNULL(cr.CampaniaId,0) = 0,@HoraFin,@HoraCierreZonaDemAnti)) as HoraFin,
			@DiasAntes AS DiasAntes,
			ISNULL(@ZonaValida,-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(@TipoDA = 0, 0, IIF(ISNULL(cr.CampaniaId,0) = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END
	ELSE
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@AceptacionConsultoraDA < 1, c.FechaInicioFacturacion, cr.FechaInicioWeb) AS FechaInicioFacturacion,
			IIF(@AceptacionConsultoraDA < 1, 
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				cr.FechaInicioWeb) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@AceptacionConsultoraDA < 1, @HoraFin, @HoraCierreZonaDemAnti) as HoraFin,
			@DiasAntes AS DiasAntes,
			IIF(@AceptacionConsultoraDA < 1,ISNULL(@ZonaValida,-1),-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			IIF(@AceptacionConsultoraDA < 1,@HoraCierreZonaNormal,@HoraCierreZonaDemAnti) AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(ISNULL(cr.CampaniaId,0) = 0,0,IIF(@AceptacionConsultoraDA = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END

	RETURN
END
GO
ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @CodigoConsultora VARCHAR(50);
	SELECT TOP 1 @CodigoConsultora = co.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		iif(@PaisValido = 1, CO.ZonaID, CO.TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) AND
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	RETURN ISNULL(@CodigoConsultora, '');
END
GO
ALTER FUNCTION dbo.ObtenerConsultoraVecina
(
	@PaisID INT,
	@EdadMaxima INT,
	@UltimaCampanaFacturada INT,
	@ListadoConsultoraId dbo.IdBigintType READONLY,
	@RegionID INT,
	@ZonaID INT,
	@SeccionID INT,
	@TerritorioID INT
)
RETURNS @Consultora TABLE(
	ConsultoraID BIGINT,
	Codigo VARCHAR(30)
)
AS
BEGIN
	INSERT INTO @Consultora(ConsultoraID, Codigo)
	SELECT TOP 1 CO.ConsultoraID, CO.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID      
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, CO.FechaNacimiento, getdate()) <= @EdadMaxima AND
		CO.UltimaCampanaFacturada >= @UltimaCampanaFacturada AND
		CO.ConsultoraID NOT IN (SELECT Id FROM @ListadoConsultoraId) AND
		CO.RegionID = @RegionID AND CO.ZonaID = @ZonaID AND
		(@SeccionID = 0 OR CO.SeccionID = @SeccionID) AND
		(@TerritorioID = 0 OR CO.TerritorioID = @TerritorioID)
	ORDER BY MontoUltimoPedido DESC;
           
	RETURN;
END
GO
ALTER FUNCTION ValidarAutorizacion
(
	@paisID			INT,
	@CodigoUsuario	VARCHAR(100)
)
RETURNS INT
AS
/*
	SELECT DBO.ValidarAutorizacion(3, '1281283')
	SELECT DBO.ValidarAutorizacion(3, '076912262')
*/
BEGIN
	DECLARE @Usuario VARCHAR(100),
            @RolID INT,
            @AutorizaPedido VARCHAR(10),
            @IdEstadoActividad INT,
            @UltimaCampania INT,
            @CampaniaActual INT,
			@Resultado	INT,
			@CodigoConsultora varchar(20),
			@ZonaID INT,
			@RegionID INT,
			@ConsultoraID INT

	SET @RolID = 0
	SET @Usuario = ''
	SET @IdEstadoActividad = -1
	SET @UltimaCampania = 0
	SET @CampaniaActual = 0
	SET @Resultado = 0	

	SELECT	
		@CodigoConsultora = IsNull(CodigoConsultora,0),
		@PaisID = IsNull(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE codigousuario = @CodigoUsuario

	SELECT	
		@ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
		@AutorizaPedido = ISNULL(AutorizaPedido,''),
		@UltimaCampania = ISNULL(UltimaCampanaFacturada,0)
	FROM ods.consultora WITH(NOLOCK)
	WHERE codigo = @CodigoConsultora

	SELECT 
		@Usuario = u.CodigoUsuario, 
		@RolID = ISNULL(ur.RolId,0),
		@AutorizaPedido = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END),
		@CampaniaActual = ISNULL((SELECT TOP 1 campaniaId FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	FROM Usuario u WITH(NOLOCK)
		LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

    --0: Usuario No Existe
    --1: Usuario No es del Portal
    --2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
    --3: Usuario OK
	DECLARE @tabla_Retirada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Retirada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 12
	
	DECLARE @tabla_Reingresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Reingresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 18
	
	DECLARE @tabla_Egresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Egresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 19

    IF @Usuario IS NOT NULL AND @Usuario <> ''
    BEGIN
        IF @RolID != 0
        BEGIN
            IF @AutorizaPedido IS NOT NULL AND @AutorizaPedido <> ''
            BEGIN
                IF @IdEstadoActividad <> -1
                BEGIN
                    -- Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
                    IF @paisID = 11 OR @paisID = 2 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                    BEGIN
                        --Validamos si el estado es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                            BEGIN
                                --Caso Colombia
								IF @paisID = 4
								BEGIN
                                    SET @Resultado =  2
                                END
								ELSE
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                            END
                            ELSE
                            BEGIN
                                --Para bolivia (FOX) se hace la validación del campo AutorizaPedido
                                IF @paisID = 2
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                BEGIN
                                    SET @Resultado =  3
                                END
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es reingresada
                            IF EXISTS(SELECT 1 FROM @tabla_Reingresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
                                IF @paisID = 3
                                BEGIN
                                    --Se valida las campañas que no ha ingresado
									DECLARE @CampaniasSinIngresar INT = 0;
                                    IF LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampania) = 6
                                    BEGIN
										set @CampaniasSinIngresar = @CampaniaActual - dbo.fnAddCampaniaAndNumero(null,@UltimaCampania,3);
                                    END

                                    IF @CampaniasSinIngresar > 0
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        --Validamos el Autoriza Pedido
                                        IF @AutorizaPedido = 'N'
                                            SET @Resultado =  2
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                                ELSE
                                BEGIN
                                    --Caso Colombia
                                    IF @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        IF @AutorizaPedido = 'N'
                                        BEGIN
                                            --Validamos si es SICC o Bolivia
                                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2
                                                SET @Resultado =  2
                                            ELSE
                                                SET @Resultado =  3
                                        END
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                            END
                            ELSE
                            BEGIN
                                --Caso Colombia
                                IF @paisID = 4
                                BEGIN
                                    --Egresada o Posible Egreso
                                    IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                                    BEGIN
                                        SET @Resultado =  2
                                    END
                                END

                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC o Bolivia
                                    IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2 OR @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3

                            END
                        END
                    END
                    -- Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
                    ELSE IF @paisID = 5 OR @paisID = 10 OR @paisID = 9 OR @paisID = 12 OR @paisID = 13 OR @paisID = 6 OR @paisID = 1 OR @paisID = 14
                    BEGIN
                        -- Validamos si la consultora es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                    SET @Resultado =  2
                                ELSE
                                    SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    SET @Resultado =  2
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es retirada
                            IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
								IF @AutorizaPedido = 'N'
								BEGIN
									--Validamos si es SICC
									IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
										SET @Resultado =  2
									ELSE
										SET @Resultado =  3
								END
								ELSE
									SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC
                                    IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                    END
                    ELSE
                        SET @Resultado = 3
                END
                ELSE
                    SET @Resultado = 3 --Se asume para usuarios del tipo SAC
            END
            ELSE
                SET @Resultado = 3 --Se asume para usuarios del tipo SAC
        END
        ELSE
            SET @Resultado = 1
    END
    ELSE
        SET @Resultado = 0

    RETURN @Resultado

END
GO
ALTER PROCEDURE dbo.GetSesionUsuario_SB2
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	
	DECLARE @FechaLimitePago SMALLDATETIME
	DECLARE @ODSCampaniaID INT
	
	declare @PaisID int
	declare @UsuarioPrueba bit
	declare @CodConsultora varchar(20)
	declare @CampaniaID int
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint
	declare @UltimaCampanaFacturada int
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario

	declare @CountCodigoNivel bigint

	/*Oferta Final, Catalogo Personalizado, CDR*/
	declare @EsOfertaFinalZonaValida bit = 0
	declare @EsOFGanaMasZonaValida bit = 0
	declare @EsCatalogoPersonalizadoZonaValida bit = 0
	declare @EsCDRWebZonaValida  bit = 0
	declare @CodigoZona varchar(4) = ''
	declare @CodigoRegion varchar(2) = ''

	select
		@CodigoZona = IsNull(z.Codigo,''),
		@CodigoRegion = IsNull(r.Codigo,'')
	from ods.consultora c with(nolock)
	inner join ods.Region r on
		c.RegionID = r.RegionID
	inner join ods.Zona z on
		c.ZonaID = z.ZonaID
	where c.codigo = @CodConsultora

	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
		
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/

	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;
	
	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919

	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0

		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;

		/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,-11), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
		)

		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			isnull(c.EsJoven,0) EsJoven,
			(case
				when @CountCodigoNivel =0 then 0  --1589
				when @CountCodigoNivel>0 then 1 End) Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			null as ConsultoraAsociada, --1688
			isnull(si.descripcion,null) SegmentoConstancia, --2469
			isnull(se.Codigo,null) Seccion, --2469
			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469
			case When cl.ConsultoraID is null then 0
				else 1 end esConsultoraLider,
			u.EMailActivo, --2532
			si.SegmentoInternoId,
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u with(nolock)
		LEFT JOIN (
			select *
			from ods.consultora with(nolock)
			where ConsultoraId = @ConsultoraID
		) c ON u.CodigoConsultora = c.Codigo
		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID
		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469
		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469
		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t with(nolock) ON 
			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeo
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@MarcaId int,
	@tipoFiltroUbigeo int
)    
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;
	
	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
	
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';
	
	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1,''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2,''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3,'')
	FROM Ubigeo U with(nolock)
	WHERE codigoubigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		--ISNULL((select top 1 campaniaId from dbo.GetCampaniaPreLogin(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID)),0) as CampaniaActual,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND (@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite) AND
		UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.CampaniaId, -2)
	ORDER BY C.UltimaCampanaFacturada DESC, C.MontoUltimoPedido DESC
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@Nombres varchar(51),
	@Apellidos varchar(51),
	@MarcaId int,
	@tipoFiltroUbigeo int
)
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;

	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
 
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';

	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1, ''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2, ''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3, '')
	FROM Ubigeo with(nolock)
	WHERE CodigoUbigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND
		CONCAT(PrimerNombre,' ',SegundoNombre) LIKE CONCAT('%',@Nombres,'%') AND
		CONCAT(PrimerApellido,' ',SegundoApellido) LIKE CONCAT('%',@Apellidos,'%') AND
		(@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite);
END
GO
ALTER PROCEDURE dbo.GetConsultorasPorUbigeo
	@PaisId int,    
	@CodigoUbigeo varchar(24),    
	@Campania int,    
	@MarcaId int,
	@tipoFiltroUbigeo int
AS    
BEGIN
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	CREATE TABLE #TempConsultoraUbigeo    
	(    
		ID int IDENTITY,    
		ConsultoraID bigint,    
		Codigo varchar(100),    
		CodigoUbigeo varchar(24),    
		NombreCompletoConsultora varchar(300),    
		Email varchar(200),      
		FechaNacimiento datetime,    
		MONTOULTIMOPEDIDO MONEY,    
		UltimaCampanaFacturada INT,     
		CodigoUsuario varchar(100),    
		ZonaID int,    
		RegionID int  
	)

	INSERT INTO #TempConsultoraUbigeo  
    SELECT DISTINCT
		C.ConsultoraID,    
		C.Codigo,
		@CodigoUbigeo as CodigoUbigeo,
		C.NombreCompleto as NombreCompletoConsultora,
		U.Email,
		FechaNacimiento,
		MONTOULTIMOPEDIDO,
		UltimaCampanaFacturada,
		u.CodigoUsuario,
		c.ZonaID,
		c.RegionID    
    FROM ods.CONSULTORA AS C  
    INNER JOIN AFILIACLIENTECONSULTORA AS ACC ON C.CONSULTORAID = ACC.CONSULTORAID  
    INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo   
    WHERE ACC.EsAfiliado = 1 AND C.TERRITORIOID IN (SELECT TerritorioID FROM @TerritorioObjetivo);
		
    IF @MarcaId = 3    
    BEGIN
		DECLARE @EDADLIMITE INT = (SELECT Codigo FROM TABLALOGICADATOS WHERE TABLALOGICAID = 56 AND TABLALOGICADATOSID = 5605);

		DELETE FROM #TempConsultoraUbigeo 
		WHERE ID IN(  
			SELECT ID
			FROM #TempConsultoraUbigeo  
			WHERE (YEAR(getdate()) - year(FechaNacimiento)) >= @EDADLIMITE
		);
    END  
  
   -- -- FILTRANDO CONSULTORAS QUE HAYAN FACTURADO EN LA CAMPAÑANA ANTERIOR  
    --R2442 -  JC - Ya no filtrará por Campaña actual  
    SELECT TCU.ConsultoraID, TCU.Codigo, TCU.CodigoUbigeo, TCU.NombreCompletoConsultora as NombreCompleto, TCU.Email
    FROM #TempConsultoraUbigeo TCU
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,TCU.ZonaID,TCU.RegionID,TCU.ConsultoraID) CC
    WHERE
		dbo.ValidarAutorizacion(@PaisId, TCU.CodigoUsuario) = 3 AND
		TCU.UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.campaniaId, -2)
	order by ULTIMACAMPANAFACTURADA DESC , MONTOULTIMOPEDIDO DESC --R2626 
	
	DROP TABLE #TempConsultoraUbigeo;
END
GO
ALTER PROCEDURE GetProductosOfertaConsultoraNueva
	@CampaniaID INT,
	@ConsultoraID INT
AS
BEGIN
	DECLARE @NroCampania INT = (SELECT TOP 1 nrocampanias FROM pais with(nolock) WHERE EstadoActivo = 1);

	DECLARE @ultimacampaniafacturable INT;
	DECLARE @idcampaniaingreso INT;
	SELECT
		@idcampaniaingreso = AnoCampanaIngreso,
		@ultimacampaniafacturable = isnull(iif(TipoFacturacion = 'FA', UltimaCampanaFacturada, dbo.fnAddCampaniaAndNumero(UltimaCampanaFacturada,-1,@NroCampania)),0)
	FROM ods.Consultora WHERE ConsultoraID=@ConsultoraID;
		
	DECLARE @campaniafacturableingreso INT = @ultimacampaniafacturable - @idcampaniaingreso;
	DECLARE @campaniacompare INT = dbo.fnAddCampaniaAndNumero2(@ultimacampaniafacturable,1,@NroCampania);
	DECLARE @NumeroPedido INT;	
	DECLARE @indicador INT = 0;

	if @CampaniaID = @campaniacompare and (@campaniafacturableingreso between 0 and 3)
	begin		
		declare @CampaniaID1 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -1, @NroCampania);
		declare @CampaniaID2 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -2, @NroCampania);
		declare @CampaniaID3 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -3, @NroCampania);
		declare @CampaniaID4 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -4, @NroCampania);

		declare @idCampaniaID1 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID1);
		declare @idCampaniaID2 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID2);
		declare @idCampaniaID3 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID3);
		declare @idCampaniaID4 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID4);

		declare @campaniasFacturas int;

		---la consultora es nueva, esta realizando su segundo pedido compruebo que la campaña anterior tenga pedido facturado
		if @campaniafacturableingreso = 0
		begin
			set @NumeroPedido = 1;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1) and consultoraid = @ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 1, 1,0);
		end
		---la consultora es nueva, esta realizando su tercer pedido compruebo que las 2 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 1
		begin
			set @NumeroPedido=2;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 2, 1,0);
		end
		---la consultora es nueva, esta realizando su cuarto pedido compruebo que las 3 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 2
		begin
			set @NumeroPedido=3;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 3, 1,0);
		end
		---la consultora es nueva, esta realizando su quINTo pedido compruebo que las 4 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 3
		begin
			set @NumeroPedido=4;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido (nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3,@idCampaniaID4) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 4, 1,0);
		end
	end

	IF @indicador = 1 and (@campaniafacturableingreso between 0 and 3)
	begin
		SELECT TOP 4
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			MarcaID,
			IndicadorMontoMinimo,
			DescripcionProd,
			UnidadesPermitidas,
			(case when len(IndicadorPedido) >0 then 1 else 0 end) IndicadorPedido,
			ganahasta
		FROM (
			SELECT
				og.OfertaNuevaId,
				og.NumeroPedido,
				case isnull(og.FlagImagenActiva,0)
					when 1 then og.ImagenProducto01
					when 2 then og.ImagenProducto02
					when 3 then og.ImagenProducto03
					else ''
				end ImagenProducto01,
				og.Descripcion,
				og.CUV,
				og.PrecioNormal,
				og.PrecioParaTi,
				pc.MarcaID,
				pc.IndicadorMontoMinimo,
				coalesce(pd.Descripcion, pc.Descripcion) DescripcionProd,
				dbo.fnObtenerCantidadOfertaNueva(og.CUV, og.CampaniaID, og.UnidadesPermitidas,og.TipoOfertaSisID, og.ConfiguracionOfertaID) UnidadesPermitidas,
				isnull(pwd.CUV,'') IndicadorPedido,
				isnull(og.ganahasta, 0) ganahasta
			FROM dbo.OfertaNueva  og with(nolock)
			inner join ods.ProductoComercial pc with(nolock) on og.CUV = pc.CUV and og.CampaniaID = pc.AnoCampania
			inner join ods.Campania ca with(nolock) on pc.CampaniaID = ca.CampaniaID
			left join dbo.ProductoDescripcion pd with(nolock) on og.CampaniaID = pd.CampaniaID and og.CUV = pd.CUV
			left join PedidoWebDetalle pwd with(nolock) on pwd.CUV=og.CUV and pwd.CampaniaID= @CampaniaID and pwd.ConsultoraID=@ConsultoraID
			WHERE
				ca.CodiGO = @CampaniaID and
				og.FlagHabilitarOferta = 1 and
				og.NumeroPedido=@NumeroPedido and
				og.CUV not in(SELECT CUV FROM PedidoWebDetalle with(nolock) WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID)
		) a
		WHERE a.UnidadesPermitidas > 0
		order by 5 asc
	end
	else
	begin
		SELECT
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			'' MarcaID,
			'' IndicadorMontoMinimo,
			'' DescripcionProd,
			UnidadesPermitidas,
			0 IndicadorPedido,
			0 ganahasta
		FROM OfertaNueva with(nolock)
		WHERE OfertaNuevaID < 0
		order by 5 asc
	end
END
GO
/*end*/

USE BelcorpMexico
GO
if object_id('fnGetTableTerritorioIdByFiltroAndUbigeo') is not null
begin
	drop function fnGetTableTerritorioIdByFiltroAndUbigeo;
end
GO
create function fnGetTableTerritorioIdByFiltroAndUbigeo(
	@TipoFiltroUbigeo int,
	@CodigoUbigeo varchar(24)
)
returns @List table (TerritorioID int, CodigoUbigeo varchar(24))
as
begin
	IF @TipoFiltroUbigeo = 1
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM ods.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 2
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 3
	BEGIN
		INSERT INTO @List
		SELECT TT.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		INNER JOIN ods.UBIGEO U with(nolock) ON U.UBIGEOID = T.TERRITORIOID
		INNER JOIN ods.TERRITORIO TT with(nolock) ON TT.CODIGOUBIGEO = U.CODIGOUBIGEO
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END

	return;
end
GO
IF OBJECT_ID('dbo.fnAddCampaniaAndNumero2') IS NOT NULL
BEGIN
	DROP FUNCTION dbo.fnAddCampaniaAndNumero2;
END
GO
CREATE FUNCTION dbo.fnAddCampaniaAndNumero2(
	@CampaniaActual INT,
	@AddNro INT,
	@NroCampanias INT
)
RETURNS INT
AS
BEGIN	
	DECLARE @AnioCampaniaActual INT = @CampaniaActual/100;
	DECLARE @NroCampaniaActual INT = @CampaniaActual%100;
	DECLARE @SumNroCampania INT = (@NroCampaniaActual + @AddNro) - 1;
	DECLARE @AnioCampaniaSiguiente INT = @AnioCampaniaActual + @SumNroCampania/@NroCampanias;
	DECLARE @NroCampaniaSiguiente INT = @SumNroCampania%@NroCampanias + 1;
	
	IF @NroCampaniaSiguiente < 1
	BEGIN
		SET @AnioCampaniaSiguiente = @AnioCampaniaSiguiente - 1;
		SET @NroCampaniaSiguiente = @NroCampaniaSiguiente + @NroCampanias;
	END
	DECLARE @CampaniaSiguiente INT = @AnioCampaniaSiguiente*100 + @NroCampaniaSiguiente;
	RETURN @CampaniaSiguiente;
END
GO
ALTER FUNCTION dbo.fnAddCampaniaAndNumero(
	@CodigoISO CHAR(2),
	@CampaniaActual INT,
	@AddNro INT
)
RETURNS INT
AS
BEGIN
	DECLARE @NroCampanias INT = IIF(
		ISNULL(@CodigoISO,'') <> '',
		(select top 1 NroCampanias from Pais with(nolock) where CodigoISO = @CodigoISO),
		(select top 1 NroCampanias from Pais with(nolock) where EstadoActivo = 1)
	);
	
	RETURN dbo.fnAddCampaniaAndNumero2(@CampaniaActual,@AddNro,@NroCampanias);
END
GO
ALTER FUNCTION dbo.fnGetConfiguracionCampania
(
	@PaisID tinyint,
	@ZonaID int,
	@RegionID int,
	@ConsultoraID bigint
)
RETURNS @TConfiguracionCampania TABLE(
	ID int,
	CampaniaID varchar(6),
	FechaInicioFacturacion datetime,
	FechaFinFacturacion datetime,
	CampaniaDescripcion varchar(6),
	HoraInicio time,
	HoraFin time,
	DiasAntes int,
	ZonaValida int,
	HoraInicioNoFacturable time,
	HoraCierreNoFacturable time,
	ZonaHoraria float,
	HoraCierreZonaNormal time,
	HoraCierreZonaDemAnti time,
	HoraCierreZonaDemAntiCierre time,
	EsZonaDemAnti int,
	DiasDuracionCronograma int,
	HabilitarRestriccionHoraria int,
	HorasDuracionRestriccion int,
	NroCampanias int,
	PROLSinStock bit,
	FechaFinFIC datetime,
	IndicadorOfertaFIC int,
	ImagenURLOfertaFIC varchar(500),
	NuevoPROL bit,
	ZonaNuevoPROL bit,
	EstadoSimplificacionCUV bit,
	EsquemaDAConsultora bit,	
	ValidacionInteractiva bit,
	MensajeValidacionInteractiva varchar(500),
	IndicadorEnviado bit,
	IndicadorGPRSB int,
	FechaActualPais datetime,
	EstadoPedido smallint,
	ValidacionAbierta BIT,
	FechaLimitePago SMALLDATETIME,
	AceptacionConsultoraDA int
)
AS
/*
select * from dbo.fnGetConfiguracionCampania(11,2161,2017,2)
*/
BEGIN
	-- Variables Pais
	DECLARE @CodigoISO CHAR(2)
	DECLARE @ZonaHoraria FLOAT
	DECLARE @HoraCierreZonaNormal TIME(0)
	DECLARE @HoraCierreZonaDemAnti TIME(0)
	DECLARE @NroCampanias INT
	DECLARE @PROLSinStock BIT
	DECLARE @NuevoPROL BIT
	DECLARE @EstadoSimplificacionCUV BIT
	DECLARE @EsquemaDAConsultora BIT
	DECLARE @TipoDA BIT
	DECLARE @PedidoFIC BIT

	select
		@CodigoISO = CodigoISO,
		@ZonaHoraria = ISNULL(ZonaHoraria,0),
		@HoraCierreZonaNormal = HoraCierreZonaNormal,
		@HoraCierreZonaDemAnti = HoraCierreZonaDemAnti,
		@NroCampanias = NroCampanias,
		@PROLSinStock = PROLSinStock,
		@NuevoPROL = NuevoPROL,
		@EstadoSimplificacionCUV = EstadoSimplificacionCUV,
		@EsquemaDAConsultora = EsquemaDAConsultora,
		@TipoDA = TipoDA,
		@PedidoFIC = PedidoFIC
	from Pais (nolock)
	where PaisId = @PaisID

	-- Variables ConfiguracionValidacion
	DECLARE @HoraInicio time(0)
	DECLARE @HoraFin time(0)
	DECLARE @DiasAntes tinyint
	DECLARE @HoraInicioNoFacturable time(0)
	DECLARE @HoraCierreNoFacturable time(0)
	DECLARE @HabilitarRestriccionHoraria bit
	DECLARE @HorasDuracionRestriccion INT
	DECLARE @ValidacionInteractiva bit
	DECLARE @MensajeValidacionInteractiva varchar(500)

	SELECT
		@HoraInicio = HoraInicio,
		@HoraFin = HoraFin,
		@DiasAntes = DiasAntes,
		@HoraInicioNoFacturable = HoraInicioNoFacturable,
		@HoraCierreNoFacturable = HoraCierreNoFacturable,
		@HabilitarRestriccionHoraria = HabilitarRestriccionHoraria,
		@HorasDuracionRestriccion =  ISNULL(HorasDuracionRestriccion,0),
		@ValidacionInteractiva = ValidacionInteractiva,
		@MensajeValidacionInteractiva = MensajeValidacionInteractiva
	FROM [dbo].[ConfiguracionValidacion] (nolock)
	WHERE  PaisID = @PaisID

	 -- Variables ConfiguracionValidacionZona
	DECLARE @DiasDuracionCronograma tinyint
	SET @DiasDuracionCronograma = 1
	DECLARE @ZonaValida int
	DECLARE @IndicadorDias bit
	SET @IndicadorDias = 0

	select
		@DiasDuracionCronograma = DiasDuracionCronograma,
		@ZonaValida = ZonaID,
		@IndicadorDias = ValidacionActiva
	from ConfiguracionValidacionZona with(nolock)
	where CampaniaID = 201301 and ZonaID = @ZonaID

	-- Dias Duracion Cronograma para Nuevas (CR)
	IF @PaisID = 5 OR @PaisID = 8 OR @PaisID = 7 OR @PaisID = 10
	BEGIN
		declare @UCF int = 0;
		declare @SID int = 0;

		select
			@UCF = ISNULL(UltimaCampanaFacturada,0),
			@SID = ISNULL(SegmentoId,0)
		from ods.Consultora with(nolock)
		where ConsultoraID = @ConsultoraID

		IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
			SET @DiasDuracionCronograma = 2
	END

	-- Variables ConfiguracionValidacionNuevoPROL
	DECLARE @ZonaNuevoPROL BIT = 0;
	DECLARE @ContNuevoPROL INT = 0;

	IF @NuevoPROL = 1
	BEGIN
		SELECT @ContNuevoPROL = COUNT(ZonaId)
		FROM ConfiguracionValidacionNuevoPROL with(nolock)
		WHERE ZonaId = @ZonaId

		IF @ContNuevoPROL > 0
			SET @ZonaNuevoPROL = 1
	END

	-- Otras Configuraciones
	IF @IndicadorDias = 0
		SET @DiasAntes = 0

	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	DECLARE @AceptacionConsultoraDA INT
	SET @AceptacionConsultoraDA = -1

	-- Obtener Campania Anterior
	DECLARE @Campania INT
	DECLARE @Anio INT
	SET @Campania = 0

	IF @EsquemaDAConsultora = 0
	BEGIN
		IF @TipoDA = 0
		BEGIN
			SELECT TOP 1
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
			WHERE
				c.ZonaID = @ZonaID AND
				c.RegionID = @RegionID AND
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
		ELSE
		BEGIN
			SELECT TOP 1	
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID		
			LEFT JOIN [dbo].[Cronograma] cr (nolock) ON 
				c.CampaniaID = cr.CampaniaID AND
				c.RegionID = cr.RegionID AND
				c.ZonaID = cr.ZonaID
			WHERE 
				c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
				IIF(@PaisID = 4,
					ISNULL(CONVERT(datetime, cr.FechaInicioDD) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioReFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal)),
					ISNULL(CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
								ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
								CONVERT(datetime, @HoraCierreZonaNormal))
				) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
	END
	ELSE
	BEGIN

		DECLARE @Campania_temp INT
		DECLARE @Anio_temp INT
		SET @Campania_temp = 0

		SELECT TOP 1
			@Campania_temp = ca.Codigo,
			@Anio_temp = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
				ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
		ORDER BY c.CampaniaID DESC

		IF(@Campania_temp <> 0)
		BEGIN
			SET @Campania_temp = @Campania_temp - @Anio_temp
			IF(@Campania_temp = @NroCampanias)
				SET @Campania_temp = @Anio_temp + 101
			ELSE
				SET @Campania_temp = @Anio_temp + @Campania_temp + 1

			SELECT @AceptacionConsultoraDA = TipoConfiguracion
			FROM ConfiguracionConsultoraDA with(nolock)
			WHERE			
				ConsultoraId = @ConsultoraId and
				ZonaId = @ZonaId and
				CampaniaId = cast(@Campania_temp as int)
		END

		SELECT TOP 1
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			IIF(@AceptacionConsultoraDA < 1,
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal),
				CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti)) < @FechaGeneral
		ORDER BY c.CampaniaID DESC
	END
	
	--Obtiene UltimaCampaniaFacturada
	declare @UltimaCampanaFacturada int;
	declare @TipoFacturacion char(2);
	declare @ConsultoraIdAsociada bigint;

	select
		@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0),
		@TipoFacturacion = ISNULL(TipoFacturacion,'')
	From ods.consultora (nolock)
	Where consultoraid = @consultoraid

	--Obtiene UltimaCampaniaFacturada x UsuarioPrueba
	IF @UltimaCampanaFacturada IS NULL
	BEGIN
		SELECT
			@UltimaCampanaFacturada = ISNULL(c.UltimaCampanaFacturada,0),
			@TipoFacturacion = ISNULL(c.TipoFacturacion,''),
			@ConsultoraIdAsociada = ISNULL(c.ConsultoraId,0)
		FROM ConsultoraFicticia cf with(nolock)
		INNER JOIN UsuarioPrueba up with(nolock) on cf.Codigo = up.CodigoFicticio
		INNER JOIN ods.Consultora c with(nolock) on up.CodigoConsultoraAsociada = c.Codigo
		WHERE cf.ConsultoraId = @consultoraid
	END

	IF @TipoFacturacion <> 'FA'
	BEGIN
		SET @UltimaCampanaFacturada = dbo.fnAddCampaniaAndNumero(@CodigoISO,@UltimaCampanaFacturada,-1);
	END

	-- Valida Campania Anterior
	IF(@Campania <> 0)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1

		IF @EsquemaDAConsultora = 1 AND @Campania > @Campania_temp
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
		
		-- validar si pertenece a una zona DA
		DECLARE @EsZonaDA BIT;
		SELECT @EsZonaDA = IIF(ISNULL(c.CampaniaID,0) = 0,0,1)
		FROM dbo.Cronograma c 
		INNER JOIN ods.Campania ca ON c.CampaniaID = ca.CampaniaID 
		WHERE
			ca.Codigo = @Campania_temp AND
			c.RegionID = @RegionID AND
			c.ZonaID = @ZonaID AND
			c.TipoCronograma = 2

		-- si el esquema es de DA y la zona es de DA y ya facturo en la campaña actual 
		-- y la consultora respondio que no en la DA anterior
		-- se resetea la variable
		IF (@EsquemaDAConsultora = 1 AND @EsZonaDA = 1 AND @UltimaCampanaFacturada = @Campania_temp AND @AceptacionConsultoraDA = 0) 
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
	END
	ELSE
	BEGIN
		SELECT TOP 1 
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		WHERE z.ZonaID = @ZonaID AND z.RegionID = @RegionID
		ORDER BY c.FechaInicioFacturacion ASC
	END

	--Valida UltimaCampaniaFacturada
	IF (@UltimaCampanaFacturada = @Campania)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1
	END
	ELSE
	BEGIN
		DECLARE @IndicadorEnviado BIT= 0, @ValidacionAbierta BIT = 0
		DECLARE @IndicadorGPR TINYINT = 0
		DECLARE @EstadoPedido SMALLINT
  
		SELECT	@IndicadorEnviado  = IndicadorEnviado,  
				@IndicadorGPR = GPRSB, 
				@EstadoPedido = EstadoPedido, 
				@ValidacionAbierta = ValidacionAbierta
		FROM	Pedidoweb (nolock)
		WHERE	CampaniaID = @campania and consultoraid = ISNULL(@ConsultoraIdAsociada,@consultoraid)	

		If(@IndicadorEnviado = 1 AND @IndicadorGPR = 0)
		BEGIN
			SET @Campania = @Campania - @Anio
			IF(@Campania = @NroCampanias)
				SET @Campania = @Anio + 101
			ELSE
				SET @Campania = @Anio + @Campania + 1
		END
	END

	-- Pedido FIC
	DECLARE @FechaFinFIC datetime;
	DECLARE @IndicadorOfertaFIC int = 0;
	DECLARE @ImagenURLOfertaFIC varchar(500) = '';

	IF @PedidoFIC = 1
	BEGIN
		DECLARE @campaniaFIC INT
		IF substring(cast(@Campania as varchar(6)),5,2)=cast(@NroCampanias as char(2))
			set @campaniaFIC=cast(cast( cast(substring(cast(@Campania as varchar(6)),1,4)as int)+1 as varchar(4)) + '01' as int)
		ELSE
			set @campaniaFIC= @Campania +1

		SELECT @FechaFinFIC=isnull(FechaFin,GETDATE())
		FROM CronogramaFIC with(nolock)
		WHERE 
			ZonaID=@ZonaID and 
			CampaniaID = (				
				SELECT CampaniaID
				FROM ods.Campania with(nolock)
				WHERE Codigo=@campaniaFIC
			);

		select top 1
			@IndicadorOfertaFIC = 1,
			@ImagenURLOfertaFIC = isnull(ImagenUrl,'')
		from OfertaFIC (nolock)
		where CampaniaID = @campaniaFIC;
	END
			
	-- Listar Variables
	IF @EsquemaDAConsultora = 0
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@TipoDA = 0,c.FechaInicioFacturacion,ISNULL(cr.FechaInicioWeb, c.FechaInicioFacturacion)) AS FechaInicioFacturacion,
			IIF(@TipoDA = 0,
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				IIF(@PaisID = 4,
					ISNULL(cr.FechaInicioDD,c.FechaInicioReFacturacion),
					ISNULL(cr.FechaInicioWeb,c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
						ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)))
			) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@TipoDA = 0, @HoraFin,IIF(ISNULL(cr.CampaniaId,0) = 0,@HoraFin,@HoraCierreZonaDemAnti)) as HoraFin,
			@DiasAntes AS DiasAntes,
			ISNULL(@ZonaValida,-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(@TipoDA = 0, 0, IIF(ISNULL(cr.CampaniaId,0) = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END
	ELSE
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@AceptacionConsultoraDA < 1, c.FechaInicioFacturacion, cr.FechaInicioWeb) AS FechaInicioFacturacion,
			IIF(@AceptacionConsultoraDA < 1, 
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				cr.FechaInicioWeb) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@AceptacionConsultoraDA < 1, @HoraFin, @HoraCierreZonaDemAnti) as HoraFin,
			@DiasAntes AS DiasAntes,
			IIF(@AceptacionConsultoraDA < 1,ISNULL(@ZonaValida,-1),-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			IIF(@AceptacionConsultoraDA < 1,@HoraCierreZonaNormal,@HoraCierreZonaDemAnti) AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(ISNULL(cr.CampaniaId,0) = 0,0,IIF(@AceptacionConsultoraDA = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END

	RETURN
END
GO
ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @CodigoConsultora VARCHAR(50);
	SELECT TOP 1 @CodigoConsultora = co.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		iif(@PaisValido = 1, CO.ZonaID, CO.TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) AND
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	RETURN ISNULL(@CodigoConsultora, '');
END
GO
ALTER FUNCTION dbo.ObtenerConsultoraVecina
(
	@PaisID INT,
	@EdadMaxima INT,
	@UltimaCampanaFacturada INT,
	@ListadoConsultoraId dbo.IdBigintType READONLY,
	@RegionID INT,
	@ZonaID INT,
	@SeccionID INT,
	@TerritorioID INT
)
RETURNS @Consultora TABLE(
	ConsultoraID BIGINT,
	Codigo VARCHAR(30)
)
AS
BEGIN
	INSERT INTO @Consultora(ConsultoraID, Codigo)
	SELECT TOP 1 CO.ConsultoraID, CO.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID      
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, CO.FechaNacimiento, getdate()) <= @EdadMaxima AND
		CO.UltimaCampanaFacturada >= @UltimaCampanaFacturada AND
		CO.ConsultoraID NOT IN (SELECT Id FROM @ListadoConsultoraId) AND
		CO.RegionID = @RegionID AND CO.ZonaID = @ZonaID AND
		(@SeccionID = 0 OR CO.SeccionID = @SeccionID) AND
		(@TerritorioID = 0 OR CO.TerritorioID = @TerritorioID)
	ORDER BY MontoUltimoPedido DESC;
           
	RETURN;
END
GO
ALTER FUNCTION ValidarAutorizacion
(
	@paisID			INT,
	@CodigoUsuario	VARCHAR(100)
)
RETURNS INT
AS
/*
	SELECT DBO.ValidarAutorizacion(3, '1281283')
	SELECT DBO.ValidarAutorizacion(3, '076912262')
*/
BEGIN
	DECLARE @Usuario VARCHAR(100),
            @RolID INT,
            @AutorizaPedido VARCHAR(10),
            @IdEstadoActividad INT,
            @UltimaCampania INT,
            @CampaniaActual INT,
			@Resultado	INT,
			@CodigoConsultora varchar(20),
			@ZonaID INT,
			@RegionID INT,
			@ConsultoraID INT

	SET @RolID = 0
	SET @Usuario = ''
	SET @IdEstadoActividad = -1
	SET @UltimaCampania = 0
	SET @CampaniaActual = 0
	SET @Resultado = 0	

	SELECT	
		@CodigoConsultora = IsNull(CodigoConsultora,0),
		@PaisID = IsNull(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE codigousuario = @CodigoUsuario

	SELECT	
		@ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
		@AutorizaPedido = ISNULL(AutorizaPedido,''),
		@UltimaCampania = ISNULL(UltimaCampanaFacturada,0)
	FROM ods.consultora WITH(NOLOCK)
	WHERE codigo = @CodigoConsultora

	SELECT 
		@Usuario = u.CodigoUsuario, 
		@RolID = ISNULL(ur.RolId,0),
		@AutorizaPedido = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END),
		@CampaniaActual = ISNULL((SELECT TOP 1 campaniaId FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	FROM Usuario u WITH(NOLOCK)
		LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

    --0: Usuario No Existe
    --1: Usuario No es del Portal
    --2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
    --3: Usuario OK
	DECLARE @tabla_Retirada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Retirada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 12
	
	DECLARE @tabla_Reingresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Reingresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 18
	
	DECLARE @tabla_Egresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Egresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 19

    IF @Usuario IS NOT NULL AND @Usuario <> ''
    BEGIN
        IF @RolID != 0
        BEGIN
            IF @AutorizaPedido IS NOT NULL AND @AutorizaPedido <> ''
            BEGIN
                IF @IdEstadoActividad <> -1
                BEGIN
                    -- Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
                    IF @paisID = 11 OR @paisID = 2 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                    BEGIN
                        --Validamos si el estado es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                            BEGIN
                                --Caso Colombia
								IF @paisID = 4
								BEGIN
                                    SET @Resultado =  2
                                END
								ELSE
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                            END
                            ELSE
                            BEGIN
                                --Para bolivia (FOX) se hace la validación del campo AutorizaPedido
                                IF @paisID = 2
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                BEGIN
                                    SET @Resultado =  3
                                END
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es reingresada
                            IF EXISTS(SELECT 1 FROM @tabla_Reingresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
                                IF @paisID = 3
                                BEGIN
                                    --Se valida las campañas que no ha ingresado
									DECLARE @CampaniasSinIngresar INT = 0;
                                    IF LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampania) = 6
                                    BEGIN
										set @CampaniasSinIngresar = @CampaniaActual - dbo.fnAddCampaniaAndNumero(null,@UltimaCampania,3);
                                    END

                                    IF @CampaniasSinIngresar > 0
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        --Validamos el Autoriza Pedido
                                        IF @AutorizaPedido = 'N'
                                            SET @Resultado =  2
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                                ELSE
                                BEGIN
                                    --Caso Colombia
                                    IF @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        IF @AutorizaPedido = 'N'
                                        BEGIN
                                            --Validamos si es SICC o Bolivia
                                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2
                                                SET @Resultado =  2
                                            ELSE
                                                SET @Resultado =  3
                                        END
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                            END
                            ELSE
                            BEGIN
                                --Caso Colombia
                                IF @paisID = 4
                                BEGIN
                                    --Egresada o Posible Egreso
                                    IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                                    BEGIN
                                        SET @Resultado =  2
                                    END
                                END

                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC o Bolivia
                                    IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2 OR @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3

                            END
                        END
                    END
                    -- Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
                    ELSE IF @paisID = 5 OR @paisID = 10 OR @paisID = 9 OR @paisID = 12 OR @paisID = 13 OR @paisID = 6 OR @paisID = 1 OR @paisID = 14
                    BEGIN
                        -- Validamos si la consultora es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                    SET @Resultado =  2
                                ELSE
                                    SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    SET @Resultado =  2
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es retirada
                            IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
								IF @AutorizaPedido = 'N'
								BEGIN
									--Validamos si es SICC
									IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
										SET @Resultado =  2
									ELSE
										SET @Resultado =  3
								END
								ELSE
									SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC
                                    IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                    END
                    ELSE
                        SET @Resultado = 3
                END
                ELSE
                    SET @Resultado = 3 --Se asume para usuarios del tipo SAC
            END
            ELSE
                SET @Resultado = 3 --Se asume para usuarios del tipo SAC
        END
        ELSE
            SET @Resultado = 1
    END
    ELSE
        SET @Resultado = 0

    RETURN @Resultado

END
GO
ALTER PROCEDURE dbo.GetSesionUsuario_SB2
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	
	DECLARE @FechaLimitePago SMALLDATETIME
	DECLARE @ODSCampaniaID INT
	
	declare @PaisID int
	declare @UsuarioPrueba bit
	declare @CodConsultora varchar(20)
	declare @CampaniaID int
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint
	declare @UltimaCampanaFacturada int
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario

	declare @CountCodigoNivel bigint

	/*Oferta Final, Catalogo Personalizado, CDR*/
	declare @EsOfertaFinalZonaValida bit = 0
	declare @EsOFGanaMasZonaValida bit = 0
	declare @EsCatalogoPersonalizadoZonaValida bit = 0
	declare @EsCDRWebZonaValida  bit = 0
	declare @CodigoZona varchar(4) = ''
	declare @CodigoRegion varchar(2) = ''

	select
		@CodigoZona = IsNull(z.Codigo,''),
		@CodigoRegion = IsNull(r.Codigo,'')
	from ods.consultora c with(nolock)
	inner join ods.Region r on
		c.RegionID = r.RegionID
	inner join ods.Zona z on
		c.ZonaID = z.ZonaID
	where c.codigo = @CodConsultora

	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
		
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/

	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;
	
	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919

	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0

		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;

		/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,-11), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
		)

		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			isnull(c.EsJoven,0) EsJoven,
			(case
				when @CountCodigoNivel =0 then 0  --1589
				when @CountCodigoNivel>0 then 1 End) Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			null as ConsultoraAsociada, --1688
			isnull(si.descripcion,null) SegmentoConstancia, --2469
			isnull(se.Codigo,null) Seccion, --2469
			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469
			case When cl.ConsultoraID is null then 0
				else 1 end esConsultoraLider,
			u.EMailActivo, --2532
			si.SegmentoInternoId,
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u with(nolock)
		LEFT JOIN (
			select *
			from ods.consultora with(nolock)
			where ConsultoraId = @ConsultoraID
		) c ON u.CodigoConsultora = c.Codigo
		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID
		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469
		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469
		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t with(nolock) ON 
			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeo
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@MarcaId int,
	@tipoFiltroUbigeo int
)    
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;
	
	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
	
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';
	
	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1,''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2,''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3,'')
	FROM Ubigeo U with(nolock)
	WHERE codigoubigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		--ISNULL((select top 1 campaniaId from dbo.GetCampaniaPreLogin(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID)),0) as CampaniaActual,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND (@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite) AND
		UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.CampaniaId, -2)
	ORDER BY C.UltimaCampanaFacturada DESC, C.MontoUltimoPedido DESC
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@Nombres varchar(51),
	@Apellidos varchar(51),
	@MarcaId int,
	@tipoFiltroUbigeo int
)
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;

	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
 
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';

	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1, ''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2, ''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3, '')
	FROM Ubigeo with(nolock)
	WHERE CodigoUbigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND
		CONCAT(PrimerNombre,' ',SegundoNombre) LIKE CONCAT('%',@Nombres,'%') AND
		CONCAT(PrimerApellido,' ',SegundoApellido) LIKE CONCAT('%',@Apellidos,'%') AND
		(@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite);
END
GO
ALTER PROCEDURE dbo.GetConsultorasPorUbigeo
	@PaisId int,    
	@CodigoUbigeo varchar(24),    
	@Campania int,    
	@MarcaId int,
	@tipoFiltroUbigeo int
AS    
BEGIN
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	CREATE TABLE #TempConsultoraUbigeo    
	(    
		ID int IDENTITY,    
		ConsultoraID bigint,    
		Codigo varchar(100),    
		CodigoUbigeo varchar(24),    
		NombreCompletoConsultora varchar(300),    
		Email varchar(200),      
		FechaNacimiento datetime,    
		MONTOULTIMOPEDIDO MONEY,    
		UltimaCampanaFacturada INT,     
		CodigoUsuario varchar(100),    
		ZonaID int,    
		RegionID int  
	)

	INSERT INTO #TempConsultoraUbigeo  
    SELECT DISTINCT
		C.ConsultoraID,    
		C.Codigo,
		@CodigoUbigeo as CodigoUbigeo,
		C.NombreCompleto as NombreCompletoConsultora,
		U.Email,
		FechaNacimiento,
		MONTOULTIMOPEDIDO,
		UltimaCampanaFacturada,
		u.CodigoUsuario,
		c.ZonaID,
		c.RegionID    
    FROM ods.CONSULTORA AS C  
    INNER JOIN AFILIACLIENTECONSULTORA AS ACC ON C.CONSULTORAID = ACC.CONSULTORAID  
    INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo   
    WHERE ACC.EsAfiliado = 1 AND C.TERRITORIOID IN (SELECT TerritorioID FROM @TerritorioObjetivo);
		
    IF @MarcaId = 3    
    BEGIN
		DECLARE @EDADLIMITE INT = (SELECT Codigo FROM TABLALOGICADATOS WHERE TABLALOGICAID = 56 AND TABLALOGICADATOSID = 5605);

		DELETE FROM #TempConsultoraUbigeo 
		WHERE ID IN(  
			SELECT ID
			FROM #TempConsultoraUbigeo  
			WHERE (YEAR(getdate()) - year(FechaNacimiento)) >= @EDADLIMITE
		);
    END  
  
   -- -- FILTRANDO CONSULTORAS QUE HAYAN FACTURADO EN LA CAMPAÑANA ANTERIOR  
    --R2442 -  JC - Ya no filtrará por Campaña actual  
    SELECT TCU.ConsultoraID, TCU.Codigo, TCU.CodigoUbigeo, TCU.NombreCompletoConsultora as NombreCompleto, TCU.Email
    FROM #TempConsultoraUbigeo TCU
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,TCU.ZonaID,TCU.RegionID,TCU.ConsultoraID) CC
    WHERE
		dbo.ValidarAutorizacion(@PaisId, TCU.CodigoUsuario) = 3 AND
		TCU.UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.campaniaId, -2)
	order by ULTIMACAMPANAFACTURADA DESC , MONTOULTIMOPEDIDO DESC --R2626 
	
	DROP TABLE #TempConsultoraUbigeo;
END
GO
ALTER PROCEDURE GetProductosOfertaConsultoraNueva
	@CampaniaID INT,
	@ConsultoraID INT
AS
BEGIN
	DECLARE @NroCampania INT = (SELECT TOP 1 nrocampanias FROM pais with(nolock) WHERE EstadoActivo = 1);

	DECLARE @ultimacampaniafacturable INT;
	DECLARE @idcampaniaingreso INT;
	SELECT
		@idcampaniaingreso = AnoCampanaIngreso,
		@ultimacampaniafacturable = isnull(iif(TipoFacturacion = 'FA', UltimaCampanaFacturada, dbo.fnAddCampaniaAndNumero(UltimaCampanaFacturada,-1,@NroCampania)),0)
	FROM ods.Consultora WHERE ConsultoraID=@ConsultoraID;
		
	DECLARE @campaniafacturableingreso INT = @ultimacampaniafacturable - @idcampaniaingreso;
	DECLARE @campaniacompare INT = dbo.fnAddCampaniaAndNumero2(@ultimacampaniafacturable,1,@NroCampania);
	DECLARE @NumeroPedido INT;	
	DECLARE @indicador INT = 0;

	if @CampaniaID = @campaniacompare and (@campaniafacturableingreso between 0 and 3)
	begin		
		declare @CampaniaID1 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -1, @NroCampania);
		declare @CampaniaID2 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -2, @NroCampania);
		declare @CampaniaID3 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -3, @NroCampania);
		declare @CampaniaID4 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -4, @NroCampania);

		declare @idCampaniaID1 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID1);
		declare @idCampaniaID2 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID2);
		declare @idCampaniaID3 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID3);
		declare @idCampaniaID4 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID4);

		declare @campaniasFacturas int;

		---la consultora es nueva, esta realizando su segundo pedido compruebo que la campaña anterior tenga pedido facturado
		if @campaniafacturableingreso = 0
		begin
			set @NumeroPedido = 1;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1) and consultoraid = @ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 1, 1,0);
		end
		---la consultora es nueva, esta realizando su tercer pedido compruebo que las 2 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 1
		begin
			set @NumeroPedido=2;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 2, 1,0);
		end
		---la consultora es nueva, esta realizando su cuarto pedido compruebo que las 3 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 2
		begin
			set @NumeroPedido=3;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 3, 1,0);
		end
		---la consultora es nueva, esta realizando su quINTo pedido compruebo que las 4 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 3
		begin
			set @NumeroPedido=4;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido (nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3,@idCampaniaID4) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 4, 1,0);
		end
	end

	IF @indicador = 1 and (@campaniafacturableingreso between 0 and 3)
	begin
		SELECT TOP 4
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			MarcaID,
			IndicadorMontoMinimo,
			DescripcionProd,
			UnidadesPermitidas,
			(case when len(IndicadorPedido) >0 then 1 else 0 end) IndicadorPedido,
			ganahasta
		FROM (
			SELECT
				og.OfertaNuevaId,
				og.NumeroPedido,
				case isnull(og.FlagImagenActiva,0)
					when 1 then og.ImagenProducto01
					when 2 then og.ImagenProducto02
					when 3 then og.ImagenProducto03
					else ''
				end ImagenProducto01,
				og.Descripcion,
				og.CUV,
				og.PrecioNormal,
				og.PrecioParaTi,
				pc.MarcaID,
				pc.IndicadorMontoMinimo,
				coalesce(pd.Descripcion, pc.Descripcion) DescripcionProd,
				dbo.fnObtenerCantidadOfertaNueva(og.CUV, og.CampaniaID, og.UnidadesPermitidas,og.TipoOfertaSisID, og.ConfiguracionOfertaID) UnidadesPermitidas,
				isnull(pwd.CUV,'') IndicadorPedido,
				isnull(og.ganahasta, 0) ganahasta
			FROM dbo.OfertaNueva  og with(nolock)
			inner join ods.ProductoComercial pc with(nolock) on og.CUV = pc.CUV and og.CampaniaID = pc.AnoCampania
			inner join ods.Campania ca with(nolock) on pc.CampaniaID = ca.CampaniaID
			left join dbo.ProductoDescripcion pd with(nolock) on og.CampaniaID = pd.CampaniaID and og.CUV = pd.CUV
			left join PedidoWebDetalle pwd with(nolock) on pwd.CUV=og.CUV and pwd.CampaniaID= @CampaniaID and pwd.ConsultoraID=@ConsultoraID
			WHERE
				ca.CodiGO = @CampaniaID and
				og.FlagHabilitarOferta = 1 and
				og.NumeroPedido=@NumeroPedido and
				og.CUV not in(SELECT CUV FROM PedidoWebDetalle with(nolock) WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID)
		) a
		WHERE a.UnidadesPermitidas > 0
		order by 5 asc
	end
	else
	begin
		SELECT
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			'' MarcaID,
			'' IndicadorMontoMinimo,
			'' DescripcionProd,
			UnidadesPermitidas,
			0 IndicadorPedido,
			0 ganahasta
		FROM OfertaNueva with(nolock)
		WHERE OfertaNuevaID < 0
		order by 5 asc
	end
END
GO
/*end*/

USE BelcorpPanama
GO
if object_id('fnGetTableTerritorioIdByFiltroAndUbigeo') is not null
begin
	drop function fnGetTableTerritorioIdByFiltroAndUbigeo;
end
GO
create function fnGetTableTerritorioIdByFiltroAndUbigeo(
	@TipoFiltroUbigeo int,
	@CodigoUbigeo varchar(24)
)
returns @List table (TerritorioID int, CodigoUbigeo varchar(24))
as
begin
	IF @TipoFiltroUbigeo = 1
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM ods.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 2
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 3
	BEGIN
		INSERT INTO @List
		SELECT TT.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		INNER JOIN ods.UBIGEO U with(nolock) ON U.UBIGEOID = T.TERRITORIOID
		INNER JOIN ods.TERRITORIO TT with(nolock) ON TT.CODIGOUBIGEO = U.CODIGOUBIGEO
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END

	return;
end
GO
IF OBJECT_ID('dbo.fnAddCampaniaAndNumero2') IS NOT NULL
BEGIN
	DROP FUNCTION dbo.fnAddCampaniaAndNumero2;
END
GO
CREATE FUNCTION dbo.fnAddCampaniaAndNumero2(
	@CampaniaActual INT,
	@AddNro INT,
	@NroCampanias INT
)
RETURNS INT
AS
BEGIN	
	DECLARE @AnioCampaniaActual INT = @CampaniaActual/100;
	DECLARE @NroCampaniaActual INT = @CampaniaActual%100;
	DECLARE @SumNroCampania INT = (@NroCampaniaActual + @AddNro) - 1;
	DECLARE @AnioCampaniaSiguiente INT = @AnioCampaniaActual + @SumNroCampania/@NroCampanias;
	DECLARE @NroCampaniaSiguiente INT = @SumNroCampania%@NroCampanias + 1;
	
	IF @NroCampaniaSiguiente < 1
	BEGIN
		SET @AnioCampaniaSiguiente = @AnioCampaniaSiguiente - 1;
		SET @NroCampaniaSiguiente = @NroCampaniaSiguiente + @NroCampanias;
	END
	DECLARE @CampaniaSiguiente INT = @AnioCampaniaSiguiente*100 + @NroCampaniaSiguiente;
	RETURN @CampaniaSiguiente;
END
GO
ALTER FUNCTION dbo.fnAddCampaniaAndNumero(
	@CodigoISO CHAR(2),
	@CampaniaActual INT,
	@AddNro INT
)
RETURNS INT
AS
BEGIN
	DECLARE @NroCampanias INT = IIF(
		ISNULL(@CodigoISO,'') <> '',
		(select top 1 NroCampanias from Pais with(nolock) where CodigoISO = @CodigoISO),
		(select top 1 NroCampanias from Pais with(nolock) where EstadoActivo = 1)
	);
	
	RETURN dbo.fnAddCampaniaAndNumero2(@CampaniaActual,@AddNro,@NroCampanias);
END
GO
ALTER FUNCTION dbo.fnGetConfiguracionCampania
(
	@PaisID tinyint,
	@ZonaID int,
	@RegionID int,
	@ConsultoraID bigint
)
RETURNS @TConfiguracionCampania TABLE(
	ID int,
	CampaniaID varchar(6),
	FechaInicioFacturacion datetime,
	FechaFinFacturacion datetime,
	CampaniaDescripcion varchar(6),
	HoraInicio time,
	HoraFin time,
	DiasAntes int,
	ZonaValida int,
	HoraInicioNoFacturable time,
	HoraCierreNoFacturable time,
	ZonaHoraria float,
	HoraCierreZonaNormal time,
	HoraCierreZonaDemAnti time,
	HoraCierreZonaDemAntiCierre time,
	EsZonaDemAnti int,
	DiasDuracionCronograma int,
	HabilitarRestriccionHoraria int,
	HorasDuracionRestriccion int,
	NroCampanias int,
	PROLSinStock bit,
	FechaFinFIC datetime,
	IndicadorOfertaFIC int,
	ImagenURLOfertaFIC varchar(500),
	NuevoPROL bit,
	ZonaNuevoPROL bit,
	EstadoSimplificacionCUV bit,
	EsquemaDAConsultora bit,	
	ValidacionInteractiva bit,
	MensajeValidacionInteractiva varchar(500),
	IndicadorEnviado bit,
	IndicadorGPRSB int,
	FechaActualPais datetime,
	EstadoPedido smallint,
	ValidacionAbierta BIT,
	FechaLimitePago SMALLDATETIME,
	AceptacionConsultoraDA int
)
AS
/*
select * from dbo.fnGetConfiguracionCampania(11,2161,2017,2)
*/
BEGIN
	-- Variables Pais
	DECLARE @CodigoISO CHAR(2)
	DECLARE @ZonaHoraria FLOAT
	DECLARE @HoraCierreZonaNormal TIME(0)
	DECLARE @HoraCierreZonaDemAnti TIME(0)
	DECLARE @NroCampanias INT
	DECLARE @PROLSinStock BIT
	DECLARE @NuevoPROL BIT
	DECLARE @EstadoSimplificacionCUV BIT
	DECLARE @EsquemaDAConsultora BIT
	DECLARE @TipoDA BIT
	DECLARE @PedidoFIC BIT

	select
		@CodigoISO = CodigoISO,
		@ZonaHoraria = ISNULL(ZonaHoraria,0),
		@HoraCierreZonaNormal = HoraCierreZonaNormal,
		@HoraCierreZonaDemAnti = HoraCierreZonaDemAnti,
		@NroCampanias = NroCampanias,
		@PROLSinStock = PROLSinStock,
		@NuevoPROL = NuevoPROL,
		@EstadoSimplificacionCUV = EstadoSimplificacionCUV,
		@EsquemaDAConsultora = EsquemaDAConsultora,
		@TipoDA = TipoDA,
		@PedidoFIC = PedidoFIC
	from Pais (nolock)
	where PaisId = @PaisID

	-- Variables ConfiguracionValidacion
	DECLARE @HoraInicio time(0)
	DECLARE @HoraFin time(0)
	DECLARE @DiasAntes tinyint
	DECLARE @HoraInicioNoFacturable time(0)
	DECLARE @HoraCierreNoFacturable time(0)
	DECLARE @HabilitarRestriccionHoraria bit
	DECLARE @HorasDuracionRestriccion INT
	DECLARE @ValidacionInteractiva bit
	DECLARE @MensajeValidacionInteractiva varchar(500)

	SELECT
		@HoraInicio = HoraInicio,
		@HoraFin = HoraFin,
		@DiasAntes = DiasAntes,
		@HoraInicioNoFacturable = HoraInicioNoFacturable,
		@HoraCierreNoFacturable = HoraCierreNoFacturable,
		@HabilitarRestriccionHoraria = HabilitarRestriccionHoraria,
		@HorasDuracionRestriccion =  ISNULL(HorasDuracionRestriccion,0),
		@ValidacionInteractiva = ValidacionInteractiva,
		@MensajeValidacionInteractiva = MensajeValidacionInteractiva
	FROM [dbo].[ConfiguracionValidacion] (nolock)
	WHERE  PaisID = @PaisID

	 -- Variables ConfiguracionValidacionZona
	DECLARE @DiasDuracionCronograma tinyint
	SET @DiasDuracionCronograma = 1
	DECLARE @ZonaValida int
	DECLARE @IndicadorDias bit
	SET @IndicadorDias = 0

	select
		@DiasDuracionCronograma = DiasDuracionCronograma,
		@ZonaValida = ZonaID,
		@IndicadorDias = ValidacionActiva
	from ConfiguracionValidacionZona with(nolock)
	where CampaniaID = 201301 and ZonaID = @ZonaID

	-- Dias Duracion Cronograma para Nuevas (CR)
	IF @PaisID = 5 OR @PaisID = 8 OR @PaisID = 7 OR @PaisID = 10
	BEGIN
		declare @UCF int = 0;
		declare @SID int = 0;

		select
			@UCF = ISNULL(UltimaCampanaFacturada,0),
			@SID = ISNULL(SegmentoId,0)
		from ods.Consultora with(nolock)
		where ConsultoraID = @ConsultoraID

		IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
			SET @DiasDuracionCronograma = 2
	END

	-- Variables ConfiguracionValidacionNuevoPROL
	DECLARE @ZonaNuevoPROL BIT = 0;
	DECLARE @ContNuevoPROL INT = 0;

	IF @NuevoPROL = 1
	BEGIN
		SELECT @ContNuevoPROL = COUNT(ZonaId)
		FROM ConfiguracionValidacionNuevoPROL with(nolock)
		WHERE ZonaId = @ZonaId

		IF @ContNuevoPROL > 0
			SET @ZonaNuevoPROL = 1
	END

	-- Otras Configuraciones
	IF @IndicadorDias = 0
		SET @DiasAntes = 0

	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	DECLARE @AceptacionConsultoraDA INT
	SET @AceptacionConsultoraDA = -1

	-- Obtener Campania Anterior
	DECLARE @Campania INT
	DECLARE @Anio INT
	SET @Campania = 0

	IF @EsquemaDAConsultora = 0
	BEGIN
		IF @TipoDA = 0
		BEGIN
			SELECT TOP 1
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
			WHERE
				c.ZonaID = @ZonaID AND
				c.RegionID = @RegionID AND
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
		ELSE
		BEGIN
			SELECT TOP 1	
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID		
			LEFT JOIN [dbo].[Cronograma] cr (nolock) ON 
				c.CampaniaID = cr.CampaniaID AND
				c.RegionID = cr.RegionID AND
				c.ZonaID = cr.ZonaID
			WHERE 
				c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
				IIF(@PaisID = 4,
					ISNULL(CONVERT(datetime, cr.FechaInicioDD) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioReFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal)),
					ISNULL(CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
								ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
								CONVERT(datetime, @HoraCierreZonaNormal))
				) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
	END
	ELSE
	BEGIN

		DECLARE @Campania_temp INT
		DECLARE @Anio_temp INT
		SET @Campania_temp = 0

		SELECT TOP 1
			@Campania_temp = ca.Codigo,
			@Anio_temp = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
				ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
		ORDER BY c.CampaniaID DESC

		IF(@Campania_temp <> 0)
		BEGIN
			SET @Campania_temp = @Campania_temp - @Anio_temp
			IF(@Campania_temp = @NroCampanias)
				SET @Campania_temp = @Anio_temp + 101
			ELSE
				SET @Campania_temp = @Anio_temp + @Campania_temp + 1

			SELECT @AceptacionConsultoraDA = TipoConfiguracion
			FROM ConfiguracionConsultoraDA with(nolock)
			WHERE			
				ConsultoraId = @ConsultoraId and
				ZonaId = @ZonaId and
				CampaniaId = cast(@Campania_temp as int)
		END

		SELECT TOP 1
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			IIF(@AceptacionConsultoraDA < 1,
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal),
				CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti)) < @FechaGeneral
		ORDER BY c.CampaniaID DESC
	END
	
	--Obtiene UltimaCampaniaFacturada
	declare @UltimaCampanaFacturada int;
	declare @TipoFacturacion char(2);
	declare @ConsultoraIdAsociada bigint;

	select
		@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0),
		@TipoFacturacion = ISNULL(TipoFacturacion,'')
	From ods.consultora (nolock)
	Where consultoraid = @consultoraid

	--Obtiene UltimaCampaniaFacturada x UsuarioPrueba
	IF @UltimaCampanaFacturada IS NULL
	BEGIN
		SELECT
			@UltimaCampanaFacturada = ISNULL(c.UltimaCampanaFacturada,0),
			@TipoFacturacion = ISNULL(c.TipoFacturacion,''),
			@ConsultoraIdAsociada = ISNULL(c.ConsultoraId,0)
		FROM ConsultoraFicticia cf with(nolock)
		INNER JOIN UsuarioPrueba up with(nolock) on cf.Codigo = up.CodigoFicticio
		INNER JOIN ods.Consultora c with(nolock) on up.CodigoConsultoraAsociada = c.Codigo
		WHERE cf.ConsultoraId = @consultoraid
	END

	IF @TipoFacturacion <> 'FA'
	BEGIN
		SET @UltimaCampanaFacturada = dbo.fnAddCampaniaAndNumero(@CodigoISO,@UltimaCampanaFacturada,-1);
	END

	-- Valida Campania Anterior
	IF(@Campania <> 0)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1

		IF @EsquemaDAConsultora = 1 AND @Campania > @Campania_temp
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
		
		-- validar si pertenece a una zona DA
		DECLARE @EsZonaDA BIT;
		SELECT @EsZonaDA = IIF(ISNULL(c.CampaniaID,0) = 0,0,1)
		FROM dbo.Cronograma c 
		INNER JOIN ods.Campania ca ON c.CampaniaID = ca.CampaniaID 
		WHERE
			ca.Codigo = @Campania_temp AND
			c.RegionID = @RegionID AND
			c.ZonaID = @ZonaID AND
			c.TipoCronograma = 2

		-- si el esquema es de DA y la zona es de DA y ya facturo en la campaña actual 
		-- y la consultora respondio que no en la DA anterior
		-- se resetea la variable
		IF (@EsquemaDAConsultora = 1 AND @EsZonaDA = 1 AND @UltimaCampanaFacturada = @Campania_temp AND @AceptacionConsultoraDA = 0) 
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
	END
	ELSE
	BEGIN
		SELECT TOP 1 
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		WHERE z.ZonaID = @ZonaID AND z.RegionID = @RegionID
		ORDER BY c.FechaInicioFacturacion ASC
	END

	--Valida UltimaCampaniaFacturada
	IF (@UltimaCampanaFacturada = @Campania)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1
	END
	ELSE
	BEGIN
		DECLARE @IndicadorEnviado BIT= 0, @ValidacionAbierta BIT = 0
		DECLARE @IndicadorGPR TINYINT = 0
		DECLARE @EstadoPedido SMALLINT
  
		SELECT	@IndicadorEnviado  = IndicadorEnviado,  
				@IndicadorGPR = GPRSB, 
				@EstadoPedido = EstadoPedido, 
				@ValidacionAbierta = ValidacionAbierta
		FROM	Pedidoweb (nolock)
		WHERE	CampaniaID = @campania and consultoraid = ISNULL(@ConsultoraIdAsociada,@consultoraid)	

		If(@IndicadorEnviado = 1 AND @IndicadorGPR = 0)
		BEGIN
			SET @Campania = @Campania - @Anio
			IF(@Campania = @NroCampanias)
				SET @Campania = @Anio + 101
			ELSE
				SET @Campania = @Anio + @Campania + 1
		END
	END

	-- Pedido FIC
	DECLARE @FechaFinFIC datetime;
	DECLARE @IndicadorOfertaFIC int = 0;
	DECLARE @ImagenURLOfertaFIC varchar(500) = '';

	IF @PedidoFIC = 1
	BEGIN
		DECLARE @campaniaFIC INT
		IF substring(cast(@Campania as varchar(6)),5,2)=cast(@NroCampanias as char(2))
			set @campaniaFIC=cast(cast( cast(substring(cast(@Campania as varchar(6)),1,4)as int)+1 as varchar(4)) + '01' as int)
		ELSE
			set @campaniaFIC= @Campania +1

		SELECT @FechaFinFIC=isnull(FechaFin,GETDATE())
		FROM CronogramaFIC with(nolock)
		WHERE 
			ZonaID=@ZonaID and 
			CampaniaID = (				
				SELECT CampaniaID
				FROM ods.Campania with(nolock)
				WHERE Codigo=@campaniaFIC
			);

		select top 1
			@IndicadorOfertaFIC = 1,
			@ImagenURLOfertaFIC = isnull(ImagenUrl,'')
		from OfertaFIC (nolock)
		where CampaniaID = @campaniaFIC;
	END
			
	-- Listar Variables
	IF @EsquemaDAConsultora = 0
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@TipoDA = 0,c.FechaInicioFacturacion,ISNULL(cr.FechaInicioWeb, c.FechaInicioFacturacion)) AS FechaInicioFacturacion,
			IIF(@TipoDA = 0,
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				IIF(@PaisID = 4,
					ISNULL(cr.FechaInicioDD,c.FechaInicioReFacturacion),
					ISNULL(cr.FechaInicioWeb,c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
						ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)))
			) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@TipoDA = 0, @HoraFin,IIF(ISNULL(cr.CampaniaId,0) = 0,@HoraFin,@HoraCierreZonaDemAnti)) as HoraFin,
			@DiasAntes AS DiasAntes,
			ISNULL(@ZonaValida,-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(@TipoDA = 0, 0, IIF(ISNULL(cr.CampaniaId,0) = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END
	ELSE
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@AceptacionConsultoraDA < 1, c.FechaInicioFacturacion, cr.FechaInicioWeb) AS FechaInicioFacturacion,
			IIF(@AceptacionConsultoraDA < 1, 
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				cr.FechaInicioWeb) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@AceptacionConsultoraDA < 1, @HoraFin, @HoraCierreZonaDemAnti) as HoraFin,
			@DiasAntes AS DiasAntes,
			IIF(@AceptacionConsultoraDA < 1,ISNULL(@ZonaValida,-1),-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			IIF(@AceptacionConsultoraDA < 1,@HoraCierreZonaNormal,@HoraCierreZonaDemAnti) AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(ISNULL(cr.CampaniaId,0) = 0,0,IIF(@AceptacionConsultoraDA = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END

	RETURN
END
GO
ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @CodigoConsultora VARCHAR(50);
	SELECT TOP 1 @CodigoConsultora = co.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		iif(@PaisValido = 1, CO.ZonaID, CO.TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) AND
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	RETURN ISNULL(@CodigoConsultora, '');
END
GO
ALTER FUNCTION dbo.ObtenerConsultoraVecina
(
	@PaisID INT,
	@EdadMaxima INT,
	@UltimaCampanaFacturada INT,
	@ListadoConsultoraId dbo.IdBigintType READONLY,
	@RegionID INT,
	@ZonaID INT,
	@SeccionID INT,
	@TerritorioID INT
)
RETURNS @Consultora TABLE(
	ConsultoraID BIGINT,
	Codigo VARCHAR(30)
)
AS
BEGIN
	INSERT INTO @Consultora(ConsultoraID, Codigo)
	SELECT TOP 1 CO.ConsultoraID, CO.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID      
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, CO.FechaNacimiento, getdate()) <= @EdadMaxima AND
		CO.UltimaCampanaFacturada >= @UltimaCampanaFacturada AND
		CO.ConsultoraID NOT IN (SELECT Id FROM @ListadoConsultoraId) AND
		CO.RegionID = @RegionID AND CO.ZonaID = @ZonaID AND
		(@SeccionID = 0 OR CO.SeccionID = @SeccionID) AND
		(@TerritorioID = 0 OR CO.TerritorioID = @TerritorioID)
	ORDER BY MontoUltimoPedido DESC;
           
	RETURN;
END
GO
ALTER FUNCTION ValidarAutorizacion
(
	@paisID			INT,
	@CodigoUsuario	VARCHAR(100)
)
RETURNS INT
AS
/*
	SELECT DBO.ValidarAutorizacion(3, '1281283')
	SELECT DBO.ValidarAutorizacion(3, '076912262')
*/
BEGIN
	DECLARE @Usuario VARCHAR(100),
            @RolID INT,
            @AutorizaPedido VARCHAR(10),
            @IdEstadoActividad INT,
            @UltimaCampania INT,
            @CampaniaActual INT,
			@Resultado	INT,
			@CodigoConsultora varchar(20),
			@ZonaID INT,
			@RegionID INT,
			@ConsultoraID INT

	SET @RolID = 0
	SET @Usuario = ''
	SET @IdEstadoActividad = -1
	SET @UltimaCampania = 0
	SET @CampaniaActual = 0
	SET @Resultado = 0	

	SELECT	
		@CodigoConsultora = IsNull(CodigoConsultora,0),
		@PaisID = IsNull(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE codigousuario = @CodigoUsuario

	SELECT	
		@ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
		@AutorizaPedido = ISNULL(AutorizaPedido,''),
		@UltimaCampania = ISNULL(UltimaCampanaFacturada,0)
	FROM ods.consultora WITH(NOLOCK)
	WHERE codigo = @CodigoConsultora

	SELECT 
		@Usuario = u.CodigoUsuario, 
		@RolID = ISNULL(ur.RolId,0),
		@AutorizaPedido = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END),
		@CampaniaActual = ISNULL((SELECT TOP 1 campaniaId FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	FROM Usuario u WITH(NOLOCK)
		LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

    --0: Usuario No Existe
    --1: Usuario No es del Portal
    --2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
    --3: Usuario OK
	DECLARE @tabla_Retirada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Retirada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 12
	
	DECLARE @tabla_Reingresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Reingresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 18
	
	DECLARE @tabla_Egresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Egresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 19

    IF @Usuario IS NOT NULL AND @Usuario <> ''
    BEGIN
        IF @RolID != 0
        BEGIN
            IF @AutorizaPedido IS NOT NULL AND @AutorizaPedido <> ''
            BEGIN
                IF @IdEstadoActividad <> -1
                BEGIN
                    -- Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
                    IF @paisID = 11 OR @paisID = 2 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                    BEGIN
                        --Validamos si el estado es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                            BEGIN
                                --Caso Colombia
								IF @paisID = 4
								BEGIN
                                    SET @Resultado =  2
                                END
								ELSE
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                            END
                            ELSE
                            BEGIN
                                --Para bolivia (FOX) se hace la validación del campo AutorizaPedido
                                IF @paisID = 2
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                BEGIN
                                    SET @Resultado =  3
                                END
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es reingresada
                            IF EXISTS(SELECT 1 FROM @tabla_Reingresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
                                IF @paisID = 3
                                BEGIN
                                    --Se valida las campañas que no ha ingresado
									DECLARE @CampaniasSinIngresar INT = 0;
                                    IF LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampania) = 6
                                    BEGIN
										set @CampaniasSinIngresar = @CampaniaActual - dbo.fnAddCampaniaAndNumero(null,@UltimaCampania,3);
                                    END

                                    IF @CampaniasSinIngresar > 0
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        --Validamos el Autoriza Pedido
                                        IF @AutorizaPedido = 'N'
                                            SET @Resultado =  2
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                                ELSE
                                BEGIN
                                    --Caso Colombia
                                    IF @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        IF @AutorizaPedido = 'N'
                                        BEGIN
                                            --Validamos si es SICC o Bolivia
                                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2
                                                SET @Resultado =  2
                                            ELSE
                                                SET @Resultado =  3
                                        END
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                            END
                            ELSE
                            BEGIN
                                --Caso Colombia
                                IF @paisID = 4
                                BEGIN
                                    --Egresada o Posible Egreso
                                    IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                                    BEGIN
                                        SET @Resultado =  2
                                    END
                                END

                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC o Bolivia
                                    IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2 OR @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3

                            END
                        END
                    END
                    -- Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
                    ELSE IF @paisID = 5 OR @paisID = 10 OR @paisID = 9 OR @paisID = 12 OR @paisID = 13 OR @paisID = 6 OR @paisID = 1 OR @paisID = 14
                    BEGIN
                        -- Validamos si la consultora es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                    SET @Resultado =  2
                                ELSE
                                    SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    SET @Resultado =  2
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es retirada
                            IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
								IF @AutorizaPedido = 'N'
								BEGIN
									--Validamos si es SICC
									IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
										SET @Resultado =  2
									ELSE
										SET @Resultado =  3
								END
								ELSE
									SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC
                                    IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                    END
                    ELSE
                        SET @Resultado = 3
                END
                ELSE
                    SET @Resultado = 3 --Se asume para usuarios del tipo SAC
            END
            ELSE
                SET @Resultado = 3 --Se asume para usuarios del tipo SAC
        END
        ELSE
            SET @Resultado = 1
    END
    ELSE
        SET @Resultado = 0

    RETURN @Resultado

END
GO
ALTER PROCEDURE dbo.GetSesionUsuario_SB2
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	
	DECLARE @FechaLimitePago SMALLDATETIME
	DECLARE @ODSCampaniaID INT
	
	declare @PaisID int
	declare @UsuarioPrueba bit
	declare @CodConsultora varchar(20)
	declare @CampaniaID int
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint
	declare @UltimaCampanaFacturada int
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario

	declare @CountCodigoNivel bigint

	/*Oferta Final, Catalogo Personalizado, CDR*/
	declare @EsOfertaFinalZonaValida bit = 0
	declare @EsOFGanaMasZonaValida bit = 0
	declare @EsCatalogoPersonalizadoZonaValida bit = 0
	declare @EsCDRWebZonaValida  bit = 0
	declare @CodigoZona varchar(4) = ''
	declare @CodigoRegion varchar(2) = ''

	select
		@CodigoZona = IsNull(z.Codigo,''),
		@CodigoRegion = IsNull(r.Codigo,'')
	from ods.consultora c with(nolock)
	inner join ods.Region r on
		c.RegionID = r.RegionID
	inner join ods.Zona z on
		c.ZonaID = z.ZonaID
	where c.codigo = @CodConsultora

	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
		
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/

	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;
	
	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919

	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0

		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;

		/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,-11), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
		)

		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			isnull(c.EsJoven,0) EsJoven,
			(case
				when @CountCodigoNivel =0 then 0  --1589
				when @CountCodigoNivel>0 then 1 End) Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			null as ConsultoraAsociada, --1688
			isnull(si.descripcion,null) SegmentoConstancia, --2469
			isnull(se.Codigo,null) Seccion, --2469
			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469
			case When cl.ConsultoraID is null then 0
				else 1 end esConsultoraLider,
			u.EMailActivo, --2532
			si.SegmentoInternoId,
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u with(nolock)
		LEFT JOIN (
			select *
			from ods.consultora with(nolock)
			where ConsultoraId = @ConsultoraID
		) c ON u.CodigoConsultora = c.Codigo
		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID
		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469
		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469
		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t with(nolock) ON 
			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeo
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@MarcaId int,
	@tipoFiltroUbigeo int
)    
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;
	
	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
	
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';
	
	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1,''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2,''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3,'')
	FROM Ubigeo U with(nolock)
	WHERE codigoubigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		--ISNULL((select top 1 campaniaId from dbo.GetCampaniaPreLogin(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID)),0) as CampaniaActual,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND (@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite) AND
		UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.CampaniaId, -2)
	ORDER BY C.UltimaCampanaFacturada DESC, C.MontoUltimoPedido DESC
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@Nombres varchar(51),
	@Apellidos varchar(51),
	@MarcaId int,
	@tipoFiltroUbigeo int
)
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;

	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
 
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';

	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1, ''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2, ''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3, '')
	FROM Ubigeo with(nolock)
	WHERE CodigoUbigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND
		CONCAT(PrimerNombre,' ',SegundoNombre) LIKE CONCAT('%',@Nombres,'%') AND
		CONCAT(PrimerApellido,' ',SegundoApellido) LIKE CONCAT('%',@Apellidos,'%') AND
		(@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite);
END
GO
ALTER PROCEDURE dbo.GetConsultorasPorUbigeo
	@PaisId int,    
	@CodigoUbigeo varchar(24),    
	@Campania int,    
	@MarcaId int,
	@tipoFiltroUbigeo int
AS    
BEGIN
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	CREATE TABLE #TempConsultoraUbigeo    
	(    
		ID int IDENTITY,    
		ConsultoraID bigint,    
		Codigo varchar(100),    
		CodigoUbigeo varchar(24),    
		NombreCompletoConsultora varchar(300),    
		Email varchar(200),      
		FechaNacimiento datetime,    
		MONTOULTIMOPEDIDO MONEY,    
		UltimaCampanaFacturada INT,     
		CodigoUsuario varchar(100),    
		ZonaID int,    
		RegionID int  
	)

	INSERT INTO #TempConsultoraUbigeo  
    SELECT DISTINCT
		C.ConsultoraID,    
		C.Codigo,
		@CodigoUbigeo as CodigoUbigeo,
		C.NombreCompleto as NombreCompletoConsultora,
		U.Email,
		FechaNacimiento,
		MONTOULTIMOPEDIDO,
		UltimaCampanaFacturada,
		u.CodigoUsuario,
		c.ZonaID,
		c.RegionID    
    FROM ods.CONSULTORA AS C  
    INNER JOIN AFILIACLIENTECONSULTORA AS ACC ON C.CONSULTORAID = ACC.CONSULTORAID  
    INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo   
    WHERE ACC.EsAfiliado = 1 AND C.TERRITORIOID IN (SELECT TerritorioID FROM @TerritorioObjetivo);
		
    IF @MarcaId = 3    
    BEGIN
		DECLARE @EDADLIMITE INT = (SELECT Codigo FROM TABLALOGICADATOS WHERE TABLALOGICAID = 56 AND TABLALOGICADATOSID = 5605);

		DELETE FROM #TempConsultoraUbigeo 
		WHERE ID IN(  
			SELECT ID
			FROM #TempConsultoraUbigeo  
			WHERE (YEAR(getdate()) - year(FechaNacimiento)) >= @EDADLIMITE
		);
    END  
  
   -- -- FILTRANDO CONSULTORAS QUE HAYAN FACTURADO EN LA CAMPAÑANA ANTERIOR  
    --R2442 -  JC - Ya no filtrará por Campaña actual  
    SELECT TCU.ConsultoraID, TCU.Codigo, TCU.CodigoUbigeo, TCU.NombreCompletoConsultora as NombreCompleto, TCU.Email
    FROM #TempConsultoraUbigeo TCU
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,TCU.ZonaID,TCU.RegionID,TCU.ConsultoraID) CC
    WHERE
		dbo.ValidarAutorizacion(@PaisId, TCU.CodigoUsuario) = 3 AND
		TCU.UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.campaniaId, -2)
	order by ULTIMACAMPANAFACTURADA DESC , MONTOULTIMOPEDIDO DESC --R2626 
	
	DROP TABLE #TempConsultoraUbigeo;
END
GO
ALTER PROCEDURE GetProductosOfertaConsultoraNueva
	@CampaniaID INT,
	@ConsultoraID INT
AS
BEGIN
	DECLARE @NroCampania INT = (SELECT TOP 1 nrocampanias FROM pais with(nolock) WHERE EstadoActivo = 1);

	DECLARE @ultimacampaniafacturable INT;
	DECLARE @idcampaniaingreso INT;
	SELECT
		@idcampaniaingreso = AnoCampanaIngreso,
		@ultimacampaniafacturable = isnull(iif(TipoFacturacion = 'FA', UltimaCampanaFacturada, dbo.fnAddCampaniaAndNumero(UltimaCampanaFacturada,-1,@NroCampania)),0)
	FROM ods.Consultora WHERE ConsultoraID=@ConsultoraID;
		
	DECLARE @campaniafacturableingreso INT = @ultimacampaniafacturable - @idcampaniaingreso;
	DECLARE @campaniacompare INT = dbo.fnAddCampaniaAndNumero2(@ultimacampaniafacturable,1,@NroCampania);
	DECLARE @NumeroPedido INT;	
	DECLARE @indicador INT = 0;

	if @CampaniaID = @campaniacompare and (@campaniafacturableingreso between 0 and 3)
	begin		
		declare @CampaniaID1 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -1, @NroCampania);
		declare @CampaniaID2 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -2, @NroCampania);
		declare @CampaniaID3 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -3, @NroCampania);
		declare @CampaniaID4 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -4, @NroCampania);

		declare @idCampaniaID1 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID1);
		declare @idCampaniaID2 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID2);
		declare @idCampaniaID3 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID3);
		declare @idCampaniaID4 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID4);

		declare @campaniasFacturas int;

		---la consultora es nueva, esta realizando su segundo pedido compruebo que la campaña anterior tenga pedido facturado
		if @campaniafacturableingreso = 0
		begin
			set @NumeroPedido = 1;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1) and consultoraid = @ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 1, 1,0);
		end
		---la consultora es nueva, esta realizando su tercer pedido compruebo que las 2 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 1
		begin
			set @NumeroPedido=2;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 2, 1,0);
		end
		---la consultora es nueva, esta realizando su cuarto pedido compruebo que las 3 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 2
		begin
			set @NumeroPedido=3;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 3, 1,0);
		end
		---la consultora es nueva, esta realizando su quINTo pedido compruebo que las 4 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 3
		begin
			set @NumeroPedido=4;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido (nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3,@idCampaniaID4) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 4, 1,0);
		end
	end

	IF @indicador = 1 and (@campaniafacturableingreso between 0 and 3)
	begin
		SELECT TOP 4
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			MarcaID,
			IndicadorMontoMinimo,
			DescripcionProd,
			UnidadesPermitidas,
			(case when len(IndicadorPedido) >0 then 1 else 0 end) IndicadorPedido,
			ganahasta
		FROM (
			SELECT
				og.OfertaNuevaId,
				og.NumeroPedido,
				case isnull(og.FlagImagenActiva,0)
					when 1 then og.ImagenProducto01
					when 2 then og.ImagenProducto02
					when 3 then og.ImagenProducto03
					else ''
				end ImagenProducto01,
				og.Descripcion,
				og.CUV,
				og.PrecioNormal,
				og.PrecioParaTi,
				pc.MarcaID,
				pc.IndicadorMontoMinimo,
				coalesce(pd.Descripcion, pc.Descripcion) DescripcionProd,
				dbo.fnObtenerCantidadOfertaNueva(og.CUV, og.CampaniaID, og.UnidadesPermitidas,og.TipoOfertaSisID, og.ConfiguracionOfertaID) UnidadesPermitidas,
				isnull(pwd.CUV,'') IndicadorPedido,
				isnull(og.ganahasta, 0) ganahasta
			FROM dbo.OfertaNueva  og with(nolock)
			inner join ods.ProductoComercial pc with(nolock) on og.CUV = pc.CUV and og.CampaniaID = pc.AnoCampania
			inner join ods.Campania ca with(nolock) on pc.CampaniaID = ca.CampaniaID
			left join dbo.ProductoDescripcion pd with(nolock) on og.CampaniaID = pd.CampaniaID and og.CUV = pd.CUV
			left join PedidoWebDetalle pwd with(nolock) on pwd.CUV=og.CUV and pwd.CampaniaID= @CampaniaID and pwd.ConsultoraID=@ConsultoraID
			WHERE
				ca.CodiGO = @CampaniaID and
				og.FlagHabilitarOferta = 1 and
				og.NumeroPedido=@NumeroPedido and
				og.CUV not in(SELECT CUV FROM PedidoWebDetalle with(nolock) WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID)
		) a
		WHERE a.UnidadesPermitidas > 0
		order by 5 asc
	end
	else
	begin
		SELECT
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			'' MarcaID,
			'' IndicadorMontoMinimo,
			'' DescripcionProd,
			UnidadesPermitidas,
			0 IndicadorPedido,
			0 ganahasta
		FROM OfertaNueva with(nolock)
		WHERE OfertaNuevaID < 0
		order by 5 asc
	end
END
GO
/*end*/

USE BelcorpPeru
GO
if object_id('fnGetTableTerritorioIdByFiltroAndUbigeo') is not null
begin
	drop function fnGetTableTerritorioIdByFiltroAndUbigeo;
end
GO
create function fnGetTableTerritorioIdByFiltroAndUbigeo(
	@TipoFiltroUbigeo int,
	@CodigoUbigeo varchar(24)
)
returns @List table (TerritorioID int, CodigoUbigeo varchar(24))
as
begin
	IF @TipoFiltroUbigeo = 1
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM ods.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 2
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 3
	BEGIN
		INSERT INTO @List
		SELECT TT.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		INNER JOIN ods.UBIGEO U with(nolock) ON U.UBIGEOID = T.TERRITORIOID
		INNER JOIN ods.TERRITORIO TT with(nolock) ON TT.CODIGOUBIGEO = U.CODIGOUBIGEO
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END

	return;
end
GO
IF OBJECT_ID('dbo.fnAddCampaniaAndNumero2') IS NOT NULL
BEGIN
	DROP FUNCTION dbo.fnAddCampaniaAndNumero2;
END
GO
CREATE FUNCTION dbo.fnAddCampaniaAndNumero2(
	@CampaniaActual INT,
	@AddNro INT,
	@NroCampanias INT
)
RETURNS INT
AS
BEGIN	
	DECLARE @AnioCampaniaActual INT = @CampaniaActual/100;
	DECLARE @NroCampaniaActual INT = @CampaniaActual%100;
	DECLARE @SumNroCampania INT = (@NroCampaniaActual + @AddNro) - 1;
	DECLARE @AnioCampaniaSiguiente INT = @AnioCampaniaActual + @SumNroCampania/@NroCampanias;
	DECLARE @NroCampaniaSiguiente INT = @SumNroCampania%@NroCampanias + 1;
	
	IF @NroCampaniaSiguiente < 1
	BEGIN
		SET @AnioCampaniaSiguiente = @AnioCampaniaSiguiente - 1;
		SET @NroCampaniaSiguiente = @NroCampaniaSiguiente + @NroCampanias;
	END
	DECLARE @CampaniaSiguiente INT = @AnioCampaniaSiguiente*100 + @NroCampaniaSiguiente;
	RETURN @CampaniaSiguiente;
END
GO
ALTER FUNCTION dbo.fnAddCampaniaAndNumero(
	@CodigoISO CHAR(2),
	@CampaniaActual INT,
	@AddNro INT
)
RETURNS INT
AS
BEGIN
	DECLARE @NroCampanias INT = IIF(
		ISNULL(@CodigoISO,'') <> '',
		(select top 1 NroCampanias from Pais with(nolock) where CodigoISO = @CodigoISO),
		(select top 1 NroCampanias from Pais with(nolock) where EstadoActivo = 1)
	);
	
	RETURN dbo.fnAddCampaniaAndNumero2(@CampaniaActual,@AddNro,@NroCampanias);
END
GO
ALTER FUNCTION dbo.fnGetConfiguracionCampania
(
	@PaisID tinyint,
	@ZonaID int,
	@RegionID int,
	@ConsultoraID bigint
)
RETURNS @TConfiguracionCampania TABLE(
	ID int,
	CampaniaID varchar(6),
	FechaInicioFacturacion datetime,
	FechaFinFacturacion datetime,
	CampaniaDescripcion varchar(6),
	HoraInicio time,
	HoraFin time,
	DiasAntes int,
	ZonaValida int,
	HoraInicioNoFacturable time,
	HoraCierreNoFacturable time,
	ZonaHoraria float,
	HoraCierreZonaNormal time,
	HoraCierreZonaDemAnti time,
	HoraCierreZonaDemAntiCierre time,
	EsZonaDemAnti int,
	DiasDuracionCronograma int,
	HabilitarRestriccionHoraria int,
	HorasDuracionRestriccion int,
	NroCampanias int,
	PROLSinStock bit,
	FechaFinFIC datetime,
	IndicadorOfertaFIC int,
	ImagenURLOfertaFIC varchar(500),
	NuevoPROL bit,
	ZonaNuevoPROL bit,
	EstadoSimplificacionCUV bit,
	EsquemaDAConsultora bit,	
	ValidacionInteractiva bit,
	MensajeValidacionInteractiva varchar(500),
	IndicadorEnviado bit,
	IndicadorGPRSB int,
	FechaActualPais datetime,
	EstadoPedido smallint,
	ValidacionAbierta BIT,
	FechaLimitePago SMALLDATETIME,
	AceptacionConsultoraDA int
)
AS
/*
select * from dbo.fnGetConfiguracionCampania(11,2161,2017,2)
*/
BEGIN
	-- Variables Pais
	DECLARE @CodigoISO CHAR(2)
	DECLARE @ZonaHoraria FLOAT
	DECLARE @HoraCierreZonaNormal TIME(0)
	DECLARE @HoraCierreZonaDemAnti TIME(0)
	DECLARE @NroCampanias INT
	DECLARE @PROLSinStock BIT
	DECLARE @NuevoPROL BIT
	DECLARE @EstadoSimplificacionCUV BIT
	DECLARE @EsquemaDAConsultora BIT
	DECLARE @TipoDA BIT
	DECLARE @PedidoFIC BIT

	select
		@CodigoISO = CodigoISO,
		@ZonaHoraria = ISNULL(ZonaHoraria,0),
		@HoraCierreZonaNormal = HoraCierreZonaNormal,
		@HoraCierreZonaDemAnti = HoraCierreZonaDemAnti,
		@NroCampanias = NroCampanias,
		@PROLSinStock = PROLSinStock,
		@NuevoPROL = NuevoPROL,
		@EstadoSimplificacionCUV = EstadoSimplificacionCUV,
		@EsquemaDAConsultora = EsquemaDAConsultora,
		@TipoDA = TipoDA,
		@PedidoFIC = PedidoFIC
	from Pais (nolock)
	where PaisId = @PaisID

	-- Variables ConfiguracionValidacion
	DECLARE @HoraInicio time(0)
	DECLARE @HoraFin time(0)
	DECLARE @DiasAntes tinyint
	DECLARE @HoraInicioNoFacturable time(0)
	DECLARE @HoraCierreNoFacturable time(0)
	DECLARE @HabilitarRestriccionHoraria bit
	DECLARE @HorasDuracionRestriccion INT
	DECLARE @ValidacionInteractiva bit
	DECLARE @MensajeValidacionInteractiva varchar(500)

	SELECT
		@HoraInicio = HoraInicio,
		@HoraFin = HoraFin,
		@DiasAntes = DiasAntes,
		@HoraInicioNoFacturable = HoraInicioNoFacturable,
		@HoraCierreNoFacturable = HoraCierreNoFacturable,
		@HabilitarRestriccionHoraria = HabilitarRestriccionHoraria,
		@HorasDuracionRestriccion =  ISNULL(HorasDuracionRestriccion,0),
		@ValidacionInteractiva = ValidacionInteractiva,
		@MensajeValidacionInteractiva = MensajeValidacionInteractiva
	FROM [dbo].[ConfiguracionValidacion] (nolock)
	WHERE  PaisID = @PaisID

	 -- Variables ConfiguracionValidacionZona
	DECLARE @DiasDuracionCronograma tinyint
	SET @DiasDuracionCronograma = 1
	DECLARE @ZonaValida int
	DECLARE @IndicadorDias bit
	SET @IndicadorDias = 0

	select
		@DiasDuracionCronograma = DiasDuracionCronograma,
		@ZonaValida = ZonaID,
		@IndicadorDias = ValidacionActiva
	from ConfiguracionValidacionZona with(nolock)
	where CampaniaID = 201301 and ZonaID = @ZonaID

	-- Dias Duracion Cronograma para Nuevas (CR)
	IF @PaisID = 5 OR @PaisID = 8 OR @PaisID = 7 OR @PaisID = 10
	BEGIN
		declare @UCF int = 0;
		declare @SID int = 0;

		select
			@UCF = ISNULL(UltimaCampanaFacturada,0),
			@SID = ISNULL(SegmentoId,0)
		from ods.Consultora with(nolock)
		where ConsultoraID = @ConsultoraID

		IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
			SET @DiasDuracionCronograma = 2
	END

	-- Variables ConfiguracionValidacionNuevoPROL
	DECLARE @ZonaNuevoPROL BIT = 0;
	DECLARE @ContNuevoPROL INT = 0;

	IF @NuevoPROL = 1
	BEGIN
		SELECT @ContNuevoPROL = COUNT(ZonaId)
		FROM ConfiguracionValidacionNuevoPROL with(nolock)
		WHERE ZonaId = @ZonaId

		IF @ContNuevoPROL > 0
			SET @ZonaNuevoPROL = 1
	END

	-- Otras Configuraciones
	IF @IndicadorDias = 0
		SET @DiasAntes = 0

	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	DECLARE @AceptacionConsultoraDA INT
	SET @AceptacionConsultoraDA = -1

	-- Obtener Campania Anterior
	DECLARE @Campania INT
	DECLARE @Anio INT
	SET @Campania = 0

	IF @EsquemaDAConsultora = 0
	BEGIN
		IF @TipoDA = 0
		BEGIN
			SELECT TOP 1
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
			WHERE
				c.ZonaID = @ZonaID AND
				c.RegionID = @RegionID AND
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
		ELSE
		BEGIN
			SELECT TOP 1	
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID		
			LEFT JOIN [dbo].[Cronograma] cr (nolock) ON 
				c.CampaniaID = cr.CampaniaID AND
				c.RegionID = cr.RegionID AND
				c.ZonaID = cr.ZonaID
			WHERE 
				c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
				IIF(@PaisID = 4,
					ISNULL(CONVERT(datetime, cr.FechaInicioDD) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioReFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal)),
					ISNULL(CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
								ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
								CONVERT(datetime, @HoraCierreZonaNormal))
				) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
	END
	ELSE
	BEGIN

		DECLARE @Campania_temp INT
		DECLARE @Anio_temp INT
		SET @Campania_temp = 0

		SELECT TOP 1
			@Campania_temp = ca.Codigo,
			@Anio_temp = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
				ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
		ORDER BY c.CampaniaID DESC

		IF(@Campania_temp <> 0)
		BEGIN
			SET @Campania_temp = @Campania_temp - @Anio_temp
			IF(@Campania_temp = @NroCampanias)
				SET @Campania_temp = @Anio_temp + 101
			ELSE
				SET @Campania_temp = @Anio_temp + @Campania_temp + 1

			SELECT @AceptacionConsultoraDA = TipoConfiguracion
			FROM ConfiguracionConsultoraDA with(nolock)
			WHERE			
				ConsultoraId = @ConsultoraId and
				ZonaId = @ZonaId and
				CampaniaId = cast(@Campania_temp as int)
		END

		SELECT TOP 1
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			IIF(@AceptacionConsultoraDA < 1,
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal),
				CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti)) < @FechaGeneral
		ORDER BY c.CampaniaID DESC
	END
	
	--Obtiene UltimaCampaniaFacturada
	declare @UltimaCampanaFacturada int;
	declare @TipoFacturacion char(2);
	declare @ConsultoraIdAsociada bigint;

	select
		@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0),
		@TipoFacturacion = ISNULL(TipoFacturacion,'')
	From ods.consultora (nolock)
	Where consultoraid = @consultoraid

	--Obtiene UltimaCampaniaFacturada x UsuarioPrueba
	IF @UltimaCampanaFacturada IS NULL
	BEGIN
		SELECT
			@UltimaCampanaFacturada = ISNULL(c.UltimaCampanaFacturada,0),
			@TipoFacturacion = ISNULL(c.TipoFacturacion,''),
			@ConsultoraIdAsociada = ISNULL(c.ConsultoraId,0)
		FROM ConsultoraFicticia cf with(nolock)
		INNER JOIN UsuarioPrueba up with(nolock) on cf.Codigo = up.CodigoFicticio
		INNER JOIN ods.Consultora c with(nolock) on up.CodigoConsultoraAsociada = c.Codigo
		WHERE cf.ConsultoraId = @consultoraid
	END

	IF @TipoFacturacion <> 'FA'
	BEGIN
		SET @UltimaCampanaFacturada = dbo.fnAddCampaniaAndNumero(@CodigoISO,@UltimaCampanaFacturada,-1);
	END

	-- Valida Campania Anterior
	IF(@Campania <> 0)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1

		IF @EsquemaDAConsultora = 1 AND @Campania > @Campania_temp
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
		
		-- validar si pertenece a una zona DA
		DECLARE @EsZonaDA BIT;
		SELECT @EsZonaDA = IIF(ISNULL(c.CampaniaID,0) = 0,0,1)
		FROM dbo.Cronograma c 
		INNER JOIN ods.Campania ca ON c.CampaniaID = ca.CampaniaID 
		WHERE
			ca.Codigo = @Campania_temp AND
			c.RegionID = @RegionID AND
			c.ZonaID = @ZonaID AND
			c.TipoCronograma = 2

		-- si el esquema es de DA y la zona es de DA y ya facturo en la campaña actual 
		-- y la consultora respondio que no en la DA anterior
		-- se resetea la variable
		IF (@EsquemaDAConsultora = 1 AND @EsZonaDA = 1 AND @UltimaCampanaFacturada = @Campania_temp AND @AceptacionConsultoraDA = 0) 
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
	END
	ELSE
	BEGIN
		SELECT TOP 1 
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		WHERE z.ZonaID = @ZonaID AND z.RegionID = @RegionID
		ORDER BY c.FechaInicioFacturacion ASC
	END

	--Valida UltimaCampaniaFacturada
	IF (@UltimaCampanaFacturada = @Campania)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1
	END
	ELSE
	BEGIN
		DECLARE @IndicadorEnviado BIT= 0, @ValidacionAbierta BIT = 0
		DECLARE @IndicadorGPR TINYINT = 0
		DECLARE @EstadoPedido SMALLINT
  
		SELECT	@IndicadorEnviado  = IndicadorEnviado,  
				@IndicadorGPR = GPRSB, 
				@EstadoPedido = EstadoPedido, 
				@ValidacionAbierta = ValidacionAbierta
		FROM	Pedidoweb (nolock)
		WHERE	CampaniaID = @campania and consultoraid = ISNULL(@ConsultoraIdAsociada,@consultoraid)	

		If(@IndicadorEnviado = 1 AND @IndicadorGPR = 0)
		BEGIN
			SET @Campania = @Campania - @Anio
			IF(@Campania = @NroCampanias)
				SET @Campania = @Anio + 101
			ELSE
				SET @Campania = @Anio + @Campania + 1
		END
	END

	-- Pedido FIC
	DECLARE @FechaFinFIC datetime;
	DECLARE @IndicadorOfertaFIC int = 0;
	DECLARE @ImagenURLOfertaFIC varchar(500) = '';

	IF @PedidoFIC = 1
	BEGIN
		DECLARE @campaniaFIC INT
		IF substring(cast(@Campania as varchar(6)),5,2)=cast(@NroCampanias as char(2))
			set @campaniaFIC=cast(cast( cast(substring(cast(@Campania as varchar(6)),1,4)as int)+1 as varchar(4)) + '01' as int)
		ELSE
			set @campaniaFIC= @Campania +1

		SELECT @FechaFinFIC=isnull(FechaFin,GETDATE())
		FROM CronogramaFIC with(nolock)
		WHERE 
			ZonaID=@ZonaID and 
			CampaniaID = (				
				SELECT CampaniaID
				FROM ods.Campania with(nolock)
				WHERE Codigo=@campaniaFIC
			);

		select top 1
			@IndicadorOfertaFIC = 1,
			@ImagenURLOfertaFIC = isnull(ImagenUrl,'')
		from OfertaFIC (nolock)
		where CampaniaID = @campaniaFIC;
	END
			
	-- Listar Variables
	IF @EsquemaDAConsultora = 0
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@TipoDA = 0,c.FechaInicioFacturacion,ISNULL(cr.FechaInicioWeb, c.FechaInicioFacturacion)) AS FechaInicioFacturacion,
			IIF(@TipoDA = 0,
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				IIF(@PaisID = 4,
					ISNULL(cr.FechaInicioDD,c.FechaInicioReFacturacion),
					ISNULL(cr.FechaInicioWeb,c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
						ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)))
			) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@TipoDA = 0, @HoraFin,IIF(ISNULL(cr.CampaniaId,0) = 0,@HoraFin,@HoraCierreZonaDemAnti)) as HoraFin,
			@DiasAntes AS DiasAntes,
			ISNULL(@ZonaValida,-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(@TipoDA = 0, 0, IIF(ISNULL(cr.CampaniaId,0) = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END
	ELSE
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@AceptacionConsultoraDA < 1, c.FechaInicioFacturacion, cr.FechaInicioWeb) AS FechaInicioFacturacion,
			IIF(@AceptacionConsultoraDA < 1, 
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				cr.FechaInicioWeb) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@AceptacionConsultoraDA < 1, @HoraFin, @HoraCierreZonaDemAnti) as HoraFin,
			@DiasAntes AS DiasAntes,
			IIF(@AceptacionConsultoraDA < 1,ISNULL(@ZonaValida,-1),-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			IIF(@AceptacionConsultoraDA < 1,@HoraCierreZonaNormal,@HoraCierreZonaDemAnti) AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(ISNULL(cr.CampaniaId,0) = 0,0,IIF(@AceptacionConsultoraDA = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END

	RETURN
END
GO
ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @CodigoConsultora VARCHAR(50);
	SELECT TOP 1 @CodigoConsultora = co.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		iif(@PaisValido = 1, CO.ZonaID, CO.TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) AND
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	RETURN ISNULL(@CodigoConsultora, '');
END
GO
ALTER FUNCTION dbo.ObtenerConsultoraVecina
(
	@PaisID INT,
	@EdadMaxima INT,
	@UltimaCampanaFacturada INT,
	@ListadoConsultoraId dbo.IdBigintType READONLY,
	@RegionID INT,
	@ZonaID INT,
	@SeccionID INT,
	@TerritorioID INT
)
RETURNS @Consultora TABLE(
	ConsultoraID BIGINT,
	Codigo VARCHAR(30)
)
AS
BEGIN
	INSERT INTO @Consultora(ConsultoraID, Codigo)
	SELECT TOP 1 CO.ConsultoraID, CO.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID      
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, CO.FechaNacimiento, getdate()) <= @EdadMaxima AND
		CO.UltimaCampanaFacturada >= @UltimaCampanaFacturada AND
		CO.ConsultoraID NOT IN (SELECT Id FROM @ListadoConsultoraId) AND
		CO.RegionID = @RegionID AND CO.ZonaID = @ZonaID AND
		(@SeccionID = 0 OR CO.SeccionID = @SeccionID) AND
		(@TerritorioID = 0 OR CO.TerritorioID = @TerritorioID)
	ORDER BY MontoUltimoPedido DESC;
           
	RETURN;
END
GO
ALTER FUNCTION ValidarAutorizacion
(
	@paisID			INT,
	@CodigoUsuario	VARCHAR(100)
)
RETURNS INT
AS
/*
	SELECT DBO.ValidarAutorizacion(3, '1281283')
	SELECT DBO.ValidarAutorizacion(3, '076912262')
*/
BEGIN
	DECLARE @Usuario VARCHAR(100),
            @RolID INT,
            @AutorizaPedido VARCHAR(10),
            @IdEstadoActividad INT,
            @UltimaCampania INT,
            @CampaniaActual INT,
			@Resultado	INT,
			@CodigoConsultora varchar(20),
			@ZonaID INT,
			@RegionID INT,
			@ConsultoraID INT

	SET @RolID = 0
	SET @Usuario = ''
	SET @IdEstadoActividad = -1
	SET @UltimaCampania = 0
	SET @CampaniaActual = 0
	SET @Resultado = 0	

	SELECT	
		@CodigoConsultora = IsNull(CodigoConsultora,0),
		@PaisID = IsNull(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE codigousuario = @CodigoUsuario

	SELECT	
		@ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
		@AutorizaPedido = ISNULL(AutorizaPedido,''),
		@UltimaCampania = ISNULL(UltimaCampanaFacturada,0)
	FROM ods.consultora WITH(NOLOCK)
	WHERE codigo = @CodigoConsultora

	SELECT 
		@Usuario = u.CodigoUsuario, 
		@RolID = ISNULL(ur.RolId,0),
		@AutorizaPedido = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END),
		@CampaniaActual = ISNULL((SELECT TOP 1 campaniaId FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	FROM Usuario u WITH(NOLOCK)
		LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

    --0: Usuario No Existe
    --1: Usuario No es del Portal
    --2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
    --3: Usuario OK
	DECLARE @tabla_Retirada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Retirada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 12
	
	DECLARE @tabla_Reingresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Reingresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 18
	
	DECLARE @tabla_Egresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Egresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 19

    IF @Usuario IS NOT NULL AND @Usuario <> ''
    BEGIN
        IF @RolID != 0
        BEGIN
            IF @AutorizaPedido IS NOT NULL AND @AutorizaPedido <> ''
            BEGIN
                IF @IdEstadoActividad <> -1
                BEGIN
                    -- Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
                    IF @paisID = 11 OR @paisID = 2 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                    BEGIN
                        --Validamos si el estado es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                            BEGIN
                                --Caso Colombia
								IF @paisID = 4
								BEGIN
                                    SET @Resultado =  2
                                END
								ELSE
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                            END
                            ELSE
                            BEGIN
                                --Para bolivia (FOX) se hace la validación del campo AutorizaPedido
                                IF @paisID = 2
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                BEGIN
                                    SET @Resultado =  3
                                END
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es reingresada
                            IF EXISTS(SELECT 1 FROM @tabla_Reingresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
                                IF @paisID = 3
                                BEGIN
                                    --Se valida las campañas que no ha ingresado
									DECLARE @CampaniasSinIngresar INT = 0;
                                    IF LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampania) = 6
                                    BEGIN
										set @CampaniasSinIngresar = @CampaniaActual - dbo.fnAddCampaniaAndNumero(null,@UltimaCampania,3);
                                    END

                                    IF @CampaniasSinIngresar > 0
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        --Validamos el Autoriza Pedido
                                        IF @AutorizaPedido = 'N'
                                            SET @Resultado =  2
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                                ELSE
                                BEGIN
                                    --Caso Colombia
                                    IF @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        IF @AutorizaPedido = 'N'
                                        BEGIN
                                            --Validamos si es SICC o Bolivia
                                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2
                                                SET @Resultado =  2
                                            ELSE
                                                SET @Resultado =  3
                                        END
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                            END
                            ELSE
                            BEGIN
                                --Caso Colombia
                                IF @paisID = 4
                                BEGIN
                                    --Egresada o Posible Egreso
                                    IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                                    BEGIN
                                        SET @Resultado =  2
                                    END
                                END

                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC o Bolivia
                                    IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2 OR @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3

                            END
                        END
                    END
                    -- Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
                    ELSE IF @paisID = 5 OR @paisID = 10 OR @paisID = 9 OR @paisID = 12 OR @paisID = 13 OR @paisID = 6 OR @paisID = 1 OR @paisID = 14
                    BEGIN
                        -- Validamos si la consultora es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                    SET @Resultado =  2
                                ELSE
                                    SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    SET @Resultado =  2
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es retirada
                            IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
								IF @AutorizaPedido = 'N'
								BEGIN
									--Validamos si es SICC
									IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
										SET @Resultado =  2
									ELSE
										SET @Resultado =  3
								END
								ELSE
									SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC
                                    IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                    END
                    ELSE
                        SET @Resultado = 3
                END
                ELSE
                    SET @Resultado = 3 --Se asume para usuarios del tipo SAC
            END
            ELSE
                SET @Resultado = 3 --Se asume para usuarios del tipo SAC
        END
        ELSE
            SET @Resultado = 1
    END
    ELSE
        SET @Resultado = 0

    RETURN @Resultado

END
GO
ALTER PROCEDURE dbo.GetSesionUsuario_SB2
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	
	DECLARE @FechaLimitePago SMALLDATETIME
	DECLARE @ODSCampaniaID INT
	
	declare @PaisID int
	declare @UsuarioPrueba bit
	declare @CodConsultora varchar(20)
	declare @CampaniaID int
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint
	declare @UltimaCampanaFacturada int
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario

	declare @CountCodigoNivel bigint

	/*Oferta Final, Catalogo Personalizado, CDR*/
	declare @EsOfertaFinalZonaValida bit = 0
	declare @EsOFGanaMasZonaValida bit = 0
	declare @EsCatalogoPersonalizadoZonaValida bit = 0
	declare @EsCDRWebZonaValida  bit = 0
	declare @CodigoZona varchar(4) = ''
	declare @CodigoRegion varchar(2) = ''

	select
		@CodigoZona = IsNull(z.Codigo,''),
		@CodigoRegion = IsNull(r.Codigo,'')
	from ods.consultora c with(nolock)
	inner join ods.Region r on
		c.RegionID = r.RegionID
	inner join ods.Zona z on
		c.ZonaID = z.ZonaID
	where c.codigo = @CodConsultora

	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
		
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/

	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;
	
	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919

	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0

		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;

		/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,-11), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
		)

		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			isnull(c.EsJoven,0) EsJoven,
			(case
				when @CountCodigoNivel =0 then 0  --1589
				when @CountCodigoNivel>0 then 1 End) Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			null as ConsultoraAsociada, --1688
			isnull(si.descripcion,null) SegmentoConstancia, --2469
			isnull(se.Codigo,null) Seccion, --2469
			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469
			case When cl.ConsultoraID is null then 0
				else 1 end esConsultoraLider,
			u.EMailActivo, --2532
			si.SegmentoInternoId,
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u with(nolock)
		LEFT JOIN (
			select *
			from ods.consultora with(nolock)
			where ConsultoraId = @ConsultoraID
		) c ON u.CodigoConsultora = c.Codigo
		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID
		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469
		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469
		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t with(nolock) ON 
			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeo
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@MarcaId int,
	@tipoFiltroUbigeo int
)    
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;
	
	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
	
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';
	
	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1,''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2,''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3,'')
	FROM Ubigeo U with(nolock)
	WHERE codigoubigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		--ISNULL((select top 1 campaniaId from dbo.GetCampaniaPreLogin(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID)),0) as CampaniaActual,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND (@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite) AND
		UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.CampaniaId, -2)
	ORDER BY C.UltimaCampanaFacturada DESC, C.MontoUltimoPedido DESC
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@Nombres varchar(51),
	@Apellidos varchar(51),
	@MarcaId int,
	@tipoFiltroUbigeo int
)
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;

	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
 
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';

	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1, ''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2, ''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3, '')
	FROM Ubigeo with(nolock)
	WHERE CodigoUbigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND
		CONCAT(PrimerNombre,' ',SegundoNombre) LIKE CONCAT('%',@Nombres,'%') AND
		CONCAT(PrimerApellido,' ',SegundoApellido) LIKE CONCAT('%',@Apellidos,'%') AND
		(@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite);
END
GO
ALTER PROCEDURE dbo.GetConsultorasPorUbigeo
	@PaisId int,    
	@CodigoUbigeo varchar(24),    
	@Campania int,    
	@MarcaId int,
	@tipoFiltroUbigeo int
AS    
BEGIN
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	CREATE TABLE #TempConsultoraUbigeo    
	(    
		ID int IDENTITY,    
		ConsultoraID bigint,    
		Codigo varchar(100),    
		CodigoUbigeo varchar(24),    
		NombreCompletoConsultora varchar(300),    
		Email varchar(200),      
		FechaNacimiento datetime,    
		MONTOULTIMOPEDIDO MONEY,    
		UltimaCampanaFacturada INT,     
		CodigoUsuario varchar(100),    
		ZonaID int,    
		RegionID int  
	)

	INSERT INTO #TempConsultoraUbigeo  
    SELECT DISTINCT
		C.ConsultoraID,    
		C.Codigo,
		@CodigoUbigeo as CodigoUbigeo,
		C.NombreCompleto as NombreCompletoConsultora,
		U.Email,
		FechaNacimiento,
		MONTOULTIMOPEDIDO,
		UltimaCampanaFacturada,
		u.CodigoUsuario,
		c.ZonaID,
		c.RegionID    
    FROM ods.CONSULTORA AS C  
    INNER JOIN AFILIACLIENTECONSULTORA AS ACC ON C.CONSULTORAID = ACC.CONSULTORAID  
    INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo   
    WHERE ACC.EsAfiliado = 1 AND C.TERRITORIOID IN (SELECT TerritorioID FROM @TerritorioObjetivo);
		
    IF @MarcaId = 3    
    BEGIN
		DECLARE @EDADLIMITE INT = (SELECT Codigo FROM TABLALOGICADATOS WHERE TABLALOGICAID = 56 AND TABLALOGICADATOSID = 5605);

		DELETE FROM #TempConsultoraUbigeo 
		WHERE ID IN(  
			SELECT ID
			FROM #TempConsultoraUbigeo  
			WHERE (YEAR(getdate()) - year(FechaNacimiento)) >= @EDADLIMITE
		);
    END  
  
   -- -- FILTRANDO CONSULTORAS QUE HAYAN FACTURADO EN LA CAMPAÑANA ANTERIOR  
    --R2442 -  JC - Ya no filtrará por Campaña actual  
    SELECT TCU.ConsultoraID, TCU.Codigo, TCU.CodigoUbigeo, TCU.NombreCompletoConsultora as NombreCompleto, TCU.Email
    FROM #TempConsultoraUbigeo TCU
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,TCU.ZonaID,TCU.RegionID,TCU.ConsultoraID) CC
    WHERE
		dbo.ValidarAutorizacion(@PaisId, TCU.CodigoUsuario) = 3 AND
		TCU.UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.campaniaId, -2)
	order by ULTIMACAMPANAFACTURADA DESC , MONTOULTIMOPEDIDO DESC --R2626 
	
	DROP TABLE #TempConsultoraUbigeo;
END
GO
ALTER PROCEDURE GetProductosOfertaConsultoraNueva
	@CampaniaID INT,
	@ConsultoraID INT
AS
BEGIN
	DECLARE @NroCampania INT = (SELECT TOP 1 nrocampanias FROM pais with(nolock) WHERE EstadoActivo = 1);

	DECLARE @ultimacampaniafacturable INT;
	DECLARE @idcampaniaingreso INT;
	SELECT
		@idcampaniaingreso = AnoCampanaIngreso,
		@ultimacampaniafacturable = isnull(iif(TipoFacturacion = 'FA', UltimaCampanaFacturada, dbo.fnAddCampaniaAndNumero(UltimaCampanaFacturada,-1,@NroCampania)),0)
	FROM ods.Consultora WHERE ConsultoraID=@ConsultoraID;
		
	DECLARE @campaniafacturableingreso INT = @ultimacampaniafacturable - @idcampaniaingreso;
	DECLARE @campaniacompare INT = dbo.fnAddCampaniaAndNumero2(@ultimacampaniafacturable,1,@NroCampania);
	DECLARE @NumeroPedido INT;	
	DECLARE @indicador INT = 0;

	if @CampaniaID = @campaniacompare and (@campaniafacturableingreso between 0 and 3)
	begin		
		declare @CampaniaID1 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -1, @NroCampania);
		declare @CampaniaID2 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -2, @NroCampania);
		declare @CampaniaID3 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -3, @NroCampania);
		declare @CampaniaID4 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -4, @NroCampania);

		declare @idCampaniaID1 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID1);
		declare @idCampaniaID2 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID2);
		declare @idCampaniaID3 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID3);
		declare @idCampaniaID4 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID4);

		declare @campaniasFacturas int;

		---la consultora es nueva, esta realizando su segundo pedido compruebo que la campaña anterior tenga pedido facturado
		if @campaniafacturableingreso = 0
		begin
			set @NumeroPedido = 1;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1) and consultoraid = @ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 1, 1,0);
		end
		---la consultora es nueva, esta realizando su tercer pedido compruebo que las 2 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 1
		begin
			set @NumeroPedido=2;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 2, 1,0);
		end
		---la consultora es nueva, esta realizando su cuarto pedido compruebo que las 3 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 2
		begin
			set @NumeroPedido=3;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 3, 1,0);
		end
		---la consultora es nueva, esta realizando su quINTo pedido compruebo que las 4 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 3
		begin
			set @NumeroPedido=4;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido (nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3,@idCampaniaID4) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 4, 1,0);
		end
	end

	IF @indicador = 1 and (@campaniafacturableingreso between 0 and 3)
	begin
		SELECT TOP 4
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			MarcaID,
			IndicadorMontoMinimo,
			DescripcionProd,
			UnidadesPermitidas,
			(case when len(IndicadorPedido) >0 then 1 else 0 end) IndicadorPedido,
			ganahasta
		FROM (
			SELECT
				og.OfertaNuevaId,
				og.NumeroPedido,
				case isnull(og.FlagImagenActiva,0)
					when 1 then og.ImagenProducto01
					when 2 then og.ImagenProducto02
					when 3 then og.ImagenProducto03
					else ''
				end ImagenProducto01,
				og.Descripcion,
				og.CUV,
				og.PrecioNormal,
				og.PrecioParaTi,
				pc.MarcaID,
				pc.IndicadorMontoMinimo,
				coalesce(pd.Descripcion, pc.Descripcion) DescripcionProd,
				dbo.fnObtenerCantidadOfertaNueva(og.CUV, og.CampaniaID, og.UnidadesPermitidas,og.TipoOfertaSisID, og.ConfiguracionOfertaID) UnidadesPermitidas,
				isnull(pwd.CUV,'') IndicadorPedido,
				isnull(og.ganahasta, 0) ganahasta
			FROM dbo.OfertaNueva  og with(nolock)
			inner join ods.ProductoComercial pc with(nolock) on og.CUV = pc.CUV and og.CampaniaID = pc.AnoCampania
			inner join ods.Campania ca with(nolock) on pc.CampaniaID = ca.CampaniaID
			left join dbo.ProductoDescripcion pd with(nolock) on og.CampaniaID = pd.CampaniaID and og.CUV = pd.CUV
			left join PedidoWebDetalle pwd with(nolock) on pwd.CUV=og.CUV and pwd.CampaniaID= @CampaniaID and pwd.ConsultoraID=@ConsultoraID
			WHERE
				ca.CodiGO = @CampaniaID and
				og.FlagHabilitarOferta = 1 and
				og.NumeroPedido=@NumeroPedido and
				og.CUV not in(SELECT CUV FROM PedidoWebDetalle with(nolock) WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID)
		) a
		WHERE a.UnidadesPermitidas > 0
		order by 5 asc
	end
	else
	begin
		SELECT
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			'' MarcaID,
			'' IndicadorMontoMinimo,
			'' DescripcionProd,
			UnidadesPermitidas,
			0 IndicadorPedido,
			0 ganahasta
		FROM OfertaNueva with(nolock)
		WHERE OfertaNuevaID < 0
		order by 5 asc
	end
END
GO
/*end*/

USE BelcorpPuertoRico
GO
if object_id('fnGetTableTerritorioIdByFiltroAndUbigeo') is not null
begin
	drop function fnGetTableTerritorioIdByFiltroAndUbigeo;
end
GO
create function fnGetTableTerritorioIdByFiltroAndUbigeo(
	@TipoFiltroUbigeo int,
	@CodigoUbigeo varchar(24)
)
returns @List table (TerritorioID int, CodigoUbigeo varchar(24))
as
begin
	IF @TipoFiltroUbigeo = 1
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM ods.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 2
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 3
	BEGIN
		INSERT INTO @List
		SELECT TT.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		INNER JOIN ods.UBIGEO U with(nolock) ON U.UBIGEOID = T.TERRITORIOID
		INNER JOIN ods.TERRITORIO TT with(nolock) ON TT.CODIGOUBIGEO = U.CODIGOUBIGEO
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END

	return;
end
GO
IF OBJECT_ID('dbo.fnAddCampaniaAndNumero2') IS NOT NULL
BEGIN
	DROP FUNCTION dbo.fnAddCampaniaAndNumero2;
END
GO
CREATE FUNCTION dbo.fnAddCampaniaAndNumero2(
	@CampaniaActual INT,
	@AddNro INT,
	@NroCampanias INT
)
RETURNS INT
AS
BEGIN	
	DECLARE @AnioCampaniaActual INT = @CampaniaActual/100;
	DECLARE @NroCampaniaActual INT = @CampaniaActual%100;
	DECLARE @SumNroCampania INT = (@NroCampaniaActual + @AddNro) - 1;
	DECLARE @AnioCampaniaSiguiente INT = @AnioCampaniaActual + @SumNroCampania/@NroCampanias;
	DECLARE @NroCampaniaSiguiente INT = @SumNroCampania%@NroCampanias + 1;
	
	IF @NroCampaniaSiguiente < 1
	BEGIN
		SET @AnioCampaniaSiguiente = @AnioCampaniaSiguiente - 1;
		SET @NroCampaniaSiguiente = @NroCampaniaSiguiente + @NroCampanias;
	END
	DECLARE @CampaniaSiguiente INT = @AnioCampaniaSiguiente*100 + @NroCampaniaSiguiente;
	RETURN @CampaniaSiguiente;
END
GO
ALTER FUNCTION dbo.fnAddCampaniaAndNumero(
	@CodigoISO CHAR(2),
	@CampaniaActual INT,
	@AddNro INT
)
RETURNS INT
AS
BEGIN
	DECLARE @NroCampanias INT = IIF(
		ISNULL(@CodigoISO,'') <> '',
		(select top 1 NroCampanias from Pais with(nolock) where CodigoISO = @CodigoISO),
		(select top 1 NroCampanias from Pais with(nolock) where EstadoActivo = 1)
	);
	
	RETURN dbo.fnAddCampaniaAndNumero2(@CampaniaActual,@AddNro,@NroCampanias);
END
GO
ALTER FUNCTION dbo.fnGetConfiguracionCampania
(
	@PaisID tinyint,
	@ZonaID int,
	@RegionID int,
	@ConsultoraID bigint
)
RETURNS @TConfiguracionCampania TABLE(
	ID int,
	CampaniaID varchar(6),
	FechaInicioFacturacion datetime,
	FechaFinFacturacion datetime,
	CampaniaDescripcion varchar(6),
	HoraInicio time,
	HoraFin time,
	DiasAntes int,
	ZonaValida int,
	HoraInicioNoFacturable time,
	HoraCierreNoFacturable time,
	ZonaHoraria float,
	HoraCierreZonaNormal time,
	HoraCierreZonaDemAnti time,
	HoraCierreZonaDemAntiCierre time,
	EsZonaDemAnti int,
	DiasDuracionCronograma int,
	HabilitarRestriccionHoraria int,
	HorasDuracionRestriccion int,
	NroCampanias int,
	PROLSinStock bit,
	FechaFinFIC datetime,
	IndicadorOfertaFIC int,
	ImagenURLOfertaFIC varchar(500),
	NuevoPROL bit,
	ZonaNuevoPROL bit,
	EstadoSimplificacionCUV bit,
	EsquemaDAConsultora bit,	
	ValidacionInteractiva bit,
	MensajeValidacionInteractiva varchar(500),
	IndicadorEnviado bit,
	IndicadorGPRSB int,
	FechaActualPais datetime,
	EstadoPedido smallint,
	ValidacionAbierta BIT,
	FechaLimitePago SMALLDATETIME,
	AceptacionConsultoraDA int
)
AS
/*
select * from dbo.fnGetConfiguracionCampania(11,2161,2017,2)
*/
BEGIN
	-- Variables Pais
	DECLARE @CodigoISO CHAR(2)
	DECLARE @ZonaHoraria FLOAT
	DECLARE @HoraCierreZonaNormal TIME(0)
	DECLARE @HoraCierreZonaDemAnti TIME(0)
	DECLARE @NroCampanias INT
	DECLARE @PROLSinStock BIT
	DECLARE @NuevoPROL BIT
	DECLARE @EstadoSimplificacionCUV BIT
	DECLARE @EsquemaDAConsultora BIT
	DECLARE @TipoDA BIT
	DECLARE @PedidoFIC BIT

	select
		@CodigoISO = CodigoISO,
		@ZonaHoraria = ISNULL(ZonaHoraria,0),
		@HoraCierreZonaNormal = HoraCierreZonaNormal,
		@HoraCierreZonaDemAnti = HoraCierreZonaDemAnti,
		@NroCampanias = NroCampanias,
		@PROLSinStock = PROLSinStock,
		@NuevoPROL = NuevoPROL,
		@EstadoSimplificacionCUV = EstadoSimplificacionCUV,
		@EsquemaDAConsultora = EsquemaDAConsultora,
		@TipoDA = TipoDA,
		@PedidoFIC = PedidoFIC
	from Pais (nolock)
	where PaisId = @PaisID

	-- Variables ConfiguracionValidacion
	DECLARE @HoraInicio time(0)
	DECLARE @HoraFin time(0)
	DECLARE @DiasAntes tinyint
	DECLARE @HoraInicioNoFacturable time(0)
	DECLARE @HoraCierreNoFacturable time(0)
	DECLARE @HabilitarRestriccionHoraria bit
	DECLARE @HorasDuracionRestriccion INT
	DECLARE @ValidacionInteractiva bit
	DECLARE @MensajeValidacionInteractiva varchar(500)

	SELECT
		@HoraInicio = HoraInicio,
		@HoraFin = HoraFin,
		@DiasAntes = DiasAntes,
		@HoraInicioNoFacturable = HoraInicioNoFacturable,
		@HoraCierreNoFacturable = HoraCierreNoFacturable,
		@HabilitarRestriccionHoraria = HabilitarRestriccionHoraria,
		@HorasDuracionRestriccion =  ISNULL(HorasDuracionRestriccion,0),
		@ValidacionInteractiva = ValidacionInteractiva,
		@MensajeValidacionInteractiva = MensajeValidacionInteractiva
	FROM [dbo].[ConfiguracionValidacion] (nolock)
	WHERE  PaisID = @PaisID

	 -- Variables ConfiguracionValidacionZona
	DECLARE @DiasDuracionCronograma tinyint
	SET @DiasDuracionCronograma = 1
	DECLARE @ZonaValida int
	DECLARE @IndicadorDias bit
	SET @IndicadorDias = 0

	select
		@DiasDuracionCronograma = DiasDuracionCronograma,
		@ZonaValida = ZonaID,
		@IndicadorDias = ValidacionActiva
	from ConfiguracionValidacionZona with(nolock)
	where CampaniaID = 201301 and ZonaID = @ZonaID

	-- Dias Duracion Cronograma para Nuevas (CR)
	IF @PaisID = 5 OR @PaisID = 8 OR @PaisID = 7 OR @PaisID = 10
	BEGIN
		declare @UCF int = 0;
		declare @SID int = 0;

		select
			@UCF = ISNULL(UltimaCampanaFacturada,0),
			@SID = ISNULL(SegmentoId,0)
		from ods.Consultora with(nolock)
		where ConsultoraID = @ConsultoraID

		IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
			SET @DiasDuracionCronograma = 2
	END

	-- Variables ConfiguracionValidacionNuevoPROL
	DECLARE @ZonaNuevoPROL BIT = 0;
	DECLARE @ContNuevoPROL INT = 0;

	IF @NuevoPROL = 1
	BEGIN
		SELECT @ContNuevoPROL = COUNT(ZonaId)
		FROM ConfiguracionValidacionNuevoPROL with(nolock)
		WHERE ZonaId = @ZonaId

		IF @ContNuevoPROL > 0
			SET @ZonaNuevoPROL = 1
	END

	-- Otras Configuraciones
	IF @IndicadorDias = 0
		SET @DiasAntes = 0

	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	DECLARE @AceptacionConsultoraDA INT
	SET @AceptacionConsultoraDA = -1

	-- Obtener Campania Anterior
	DECLARE @Campania INT
	DECLARE @Anio INT
	SET @Campania = 0

	IF @EsquemaDAConsultora = 0
	BEGIN
		IF @TipoDA = 0
		BEGIN
			SELECT TOP 1
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
			WHERE
				c.ZonaID = @ZonaID AND
				c.RegionID = @RegionID AND
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
		ELSE
		BEGIN
			SELECT TOP 1	
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID		
			LEFT JOIN [dbo].[Cronograma] cr (nolock) ON 
				c.CampaniaID = cr.CampaniaID AND
				c.RegionID = cr.RegionID AND
				c.ZonaID = cr.ZonaID
			WHERE 
				c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
				IIF(@PaisID = 4,
					ISNULL(CONVERT(datetime, cr.FechaInicioDD) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioReFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal)),
					ISNULL(CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
								ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
								CONVERT(datetime, @HoraCierreZonaNormal))
				) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
	END
	ELSE
	BEGIN

		DECLARE @Campania_temp INT
		DECLARE @Anio_temp INT
		SET @Campania_temp = 0

		SELECT TOP 1
			@Campania_temp = ca.Codigo,
			@Anio_temp = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
				ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
		ORDER BY c.CampaniaID DESC

		IF(@Campania_temp <> 0)
		BEGIN
			SET @Campania_temp = @Campania_temp - @Anio_temp
			IF(@Campania_temp = @NroCampanias)
				SET @Campania_temp = @Anio_temp + 101
			ELSE
				SET @Campania_temp = @Anio_temp + @Campania_temp + 1

			SELECT @AceptacionConsultoraDA = TipoConfiguracion
			FROM ConfiguracionConsultoraDA with(nolock)
			WHERE			
				ConsultoraId = @ConsultoraId and
				ZonaId = @ZonaId and
				CampaniaId = cast(@Campania_temp as int)
		END

		SELECT TOP 1
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			IIF(@AceptacionConsultoraDA < 1,
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal),
				CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti)) < @FechaGeneral
		ORDER BY c.CampaniaID DESC
	END
	
	--Obtiene UltimaCampaniaFacturada
	declare @UltimaCampanaFacturada int;
	declare @TipoFacturacion char(2);
	declare @ConsultoraIdAsociada bigint;

	select
		@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0),
		@TipoFacturacion = ISNULL(TipoFacturacion,'')
	From ods.consultora (nolock)
	Where consultoraid = @consultoraid

	--Obtiene UltimaCampaniaFacturada x UsuarioPrueba
	IF @UltimaCampanaFacturada IS NULL
	BEGIN
		SELECT
			@UltimaCampanaFacturada = ISNULL(c.UltimaCampanaFacturada,0),
			@TipoFacturacion = ISNULL(c.TipoFacturacion,''),
			@ConsultoraIdAsociada = ISNULL(c.ConsultoraId,0)
		FROM ConsultoraFicticia cf with(nolock)
		INNER JOIN UsuarioPrueba up with(nolock) on cf.Codigo = up.CodigoFicticio
		INNER JOIN ods.Consultora c with(nolock) on up.CodigoConsultoraAsociada = c.Codigo
		WHERE cf.ConsultoraId = @consultoraid
	END

	IF @TipoFacturacion <> 'FA'
	BEGIN
		SET @UltimaCampanaFacturada = dbo.fnAddCampaniaAndNumero(@CodigoISO,@UltimaCampanaFacturada,-1);
	END

	-- Valida Campania Anterior
	IF(@Campania <> 0)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1

		IF @EsquemaDAConsultora = 1 AND @Campania > @Campania_temp
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
		
		-- validar si pertenece a una zona DA
		DECLARE @EsZonaDA BIT;
		SELECT @EsZonaDA = IIF(ISNULL(c.CampaniaID,0) = 0,0,1)
		FROM dbo.Cronograma c 
		INNER JOIN ods.Campania ca ON c.CampaniaID = ca.CampaniaID 
		WHERE
			ca.Codigo = @Campania_temp AND
			c.RegionID = @RegionID AND
			c.ZonaID = @ZonaID AND
			c.TipoCronograma = 2

		-- si el esquema es de DA y la zona es de DA y ya facturo en la campaña actual 
		-- y la consultora respondio que no en la DA anterior
		-- se resetea la variable
		IF (@EsquemaDAConsultora = 1 AND @EsZonaDA = 1 AND @UltimaCampanaFacturada = @Campania_temp AND @AceptacionConsultoraDA = 0) 
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
	END
	ELSE
	BEGIN
		SELECT TOP 1 
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		WHERE z.ZonaID = @ZonaID AND z.RegionID = @RegionID
		ORDER BY c.FechaInicioFacturacion ASC
	END

	--Valida UltimaCampaniaFacturada
	IF (@UltimaCampanaFacturada = @Campania)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1
	END
	ELSE
	BEGIN
		DECLARE @IndicadorEnviado BIT= 0, @ValidacionAbierta BIT = 0
		DECLARE @IndicadorGPR TINYINT = 0
		DECLARE @EstadoPedido SMALLINT
  
		SELECT	@IndicadorEnviado  = IndicadorEnviado,  
				@IndicadorGPR = GPRSB, 
				@EstadoPedido = EstadoPedido, 
				@ValidacionAbierta = ValidacionAbierta
		FROM	Pedidoweb (nolock)
		WHERE	CampaniaID = @campania and consultoraid = ISNULL(@ConsultoraIdAsociada,@consultoraid)	

		If(@IndicadorEnviado = 1 AND @IndicadorGPR = 0)
		BEGIN
			SET @Campania = @Campania - @Anio
			IF(@Campania = @NroCampanias)
				SET @Campania = @Anio + 101
			ELSE
				SET @Campania = @Anio + @Campania + 1
		END
	END

	-- Pedido FIC
	DECLARE @FechaFinFIC datetime;
	DECLARE @IndicadorOfertaFIC int = 0;
	DECLARE @ImagenURLOfertaFIC varchar(500) = '';

	IF @PedidoFIC = 1
	BEGIN
		DECLARE @campaniaFIC INT
		IF substring(cast(@Campania as varchar(6)),5,2)=cast(@NroCampanias as char(2))
			set @campaniaFIC=cast(cast( cast(substring(cast(@Campania as varchar(6)),1,4)as int)+1 as varchar(4)) + '01' as int)
		ELSE
			set @campaniaFIC= @Campania +1

		SELECT @FechaFinFIC=isnull(FechaFin,GETDATE())
		FROM CronogramaFIC with(nolock)
		WHERE 
			ZonaID=@ZonaID and 
			CampaniaID = (				
				SELECT CampaniaID
				FROM ods.Campania with(nolock)
				WHERE Codigo=@campaniaFIC
			);

		select top 1
			@IndicadorOfertaFIC = 1,
			@ImagenURLOfertaFIC = isnull(ImagenUrl,'')
		from OfertaFIC (nolock)
		where CampaniaID = @campaniaFIC;
	END
			
	-- Listar Variables
	IF @EsquemaDAConsultora = 0
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@TipoDA = 0,c.FechaInicioFacturacion,ISNULL(cr.FechaInicioWeb, c.FechaInicioFacturacion)) AS FechaInicioFacturacion,
			IIF(@TipoDA = 0,
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				IIF(@PaisID = 4,
					ISNULL(cr.FechaInicioDD,c.FechaInicioReFacturacion),
					ISNULL(cr.FechaInicioWeb,c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
						ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)))
			) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@TipoDA = 0, @HoraFin,IIF(ISNULL(cr.CampaniaId,0) = 0,@HoraFin,@HoraCierreZonaDemAnti)) as HoraFin,
			@DiasAntes AS DiasAntes,
			ISNULL(@ZonaValida,-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(@TipoDA = 0, 0, IIF(ISNULL(cr.CampaniaId,0) = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END
	ELSE
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@AceptacionConsultoraDA < 1, c.FechaInicioFacturacion, cr.FechaInicioWeb) AS FechaInicioFacturacion,
			IIF(@AceptacionConsultoraDA < 1, 
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				cr.FechaInicioWeb) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@AceptacionConsultoraDA < 1, @HoraFin, @HoraCierreZonaDemAnti) as HoraFin,
			@DiasAntes AS DiasAntes,
			IIF(@AceptacionConsultoraDA < 1,ISNULL(@ZonaValida,-1),-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			IIF(@AceptacionConsultoraDA < 1,@HoraCierreZonaNormal,@HoraCierreZonaDemAnti) AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(ISNULL(cr.CampaniaId,0) = 0,0,IIF(@AceptacionConsultoraDA = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END

	RETURN
END
GO
ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @CodigoConsultora VARCHAR(50);
	SELECT TOP 1 @CodigoConsultora = co.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		iif(@PaisValido = 1, CO.ZonaID, CO.TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) AND
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	RETURN ISNULL(@CodigoConsultora, '');
END
GO
ALTER FUNCTION dbo.ObtenerConsultoraVecina
(
	@PaisID INT,
	@EdadMaxima INT,
	@UltimaCampanaFacturada INT,
	@ListadoConsultoraId dbo.IdBigintType READONLY,
	@RegionID INT,
	@ZonaID INT,
	@SeccionID INT,
	@TerritorioID INT
)
RETURNS @Consultora TABLE(
	ConsultoraID BIGINT,
	Codigo VARCHAR(30)
)
AS
BEGIN
	INSERT INTO @Consultora(ConsultoraID, Codigo)
	SELECT TOP 1 CO.ConsultoraID, CO.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID      
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, CO.FechaNacimiento, getdate()) <= @EdadMaxima AND
		CO.UltimaCampanaFacturada >= @UltimaCampanaFacturada AND
		CO.ConsultoraID NOT IN (SELECT Id FROM @ListadoConsultoraId) AND
		CO.RegionID = @RegionID AND CO.ZonaID = @ZonaID AND
		(@SeccionID = 0 OR CO.SeccionID = @SeccionID) AND
		(@TerritorioID = 0 OR CO.TerritorioID = @TerritorioID)
	ORDER BY MontoUltimoPedido DESC;
           
	RETURN;
END
GO
ALTER FUNCTION ValidarAutorizacion
(
	@paisID			INT,
	@CodigoUsuario	VARCHAR(100)
)
RETURNS INT
AS
/*
	SELECT DBO.ValidarAutorizacion(3, '1281283')
	SELECT DBO.ValidarAutorizacion(3, '076912262')
*/
BEGIN
	DECLARE @Usuario VARCHAR(100),
            @RolID INT,
            @AutorizaPedido VARCHAR(10),
            @IdEstadoActividad INT,
            @UltimaCampania INT,
            @CampaniaActual INT,
			@Resultado	INT,
			@CodigoConsultora varchar(20),
			@ZonaID INT,
			@RegionID INT,
			@ConsultoraID INT

	SET @RolID = 0
	SET @Usuario = ''
	SET @IdEstadoActividad = -1
	SET @UltimaCampania = 0
	SET @CampaniaActual = 0
	SET @Resultado = 0	

	SELECT	
		@CodigoConsultora = IsNull(CodigoConsultora,0),
		@PaisID = IsNull(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE codigousuario = @CodigoUsuario

	SELECT	
		@ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
		@AutorizaPedido = ISNULL(AutorizaPedido,''),
		@UltimaCampania = ISNULL(UltimaCampanaFacturada,0)
	FROM ods.consultora WITH(NOLOCK)
	WHERE codigo = @CodigoConsultora

	SELECT 
		@Usuario = u.CodigoUsuario, 
		@RolID = ISNULL(ur.RolId,0),
		@AutorizaPedido = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END),
		@CampaniaActual = ISNULL((SELECT TOP 1 campaniaId FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	FROM Usuario u WITH(NOLOCK)
		LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

    --0: Usuario No Existe
    --1: Usuario No es del Portal
    --2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
    --3: Usuario OK
	DECLARE @tabla_Retirada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Retirada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 12
	
	DECLARE @tabla_Reingresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Reingresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 18
	
	DECLARE @tabla_Egresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Egresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 19

    IF @Usuario IS NOT NULL AND @Usuario <> ''
    BEGIN
        IF @RolID != 0
        BEGIN
            IF @AutorizaPedido IS NOT NULL AND @AutorizaPedido <> ''
            BEGIN
                IF @IdEstadoActividad <> -1
                BEGIN
                    -- Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
                    IF @paisID = 11 OR @paisID = 2 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                    BEGIN
                        --Validamos si el estado es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                            BEGIN
                                --Caso Colombia
								IF @paisID = 4
								BEGIN
                                    SET @Resultado =  2
                                END
								ELSE
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                            END
                            ELSE
                            BEGIN
                                --Para bolivia (FOX) se hace la validación del campo AutorizaPedido
                                IF @paisID = 2
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                BEGIN
                                    SET @Resultado =  3
                                END
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es reingresada
                            IF EXISTS(SELECT 1 FROM @tabla_Reingresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
                                IF @paisID = 3
                                BEGIN
                                    --Se valida las campañas que no ha ingresado
									DECLARE @CampaniasSinIngresar INT = 0;
                                    IF LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampania) = 6
                                    BEGIN
										set @CampaniasSinIngresar = @CampaniaActual - dbo.fnAddCampaniaAndNumero(null,@UltimaCampania,3);
                                    END

                                    IF @CampaniasSinIngresar > 0
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        --Validamos el Autoriza Pedido
                                        IF @AutorizaPedido = 'N'
                                            SET @Resultado =  2
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                                ELSE
                                BEGIN
                                    --Caso Colombia
                                    IF @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        IF @AutorizaPedido = 'N'
                                        BEGIN
                                            --Validamos si es SICC o Bolivia
                                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2
                                                SET @Resultado =  2
                                            ELSE
                                                SET @Resultado =  3
                                        END
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                            END
                            ELSE
                            BEGIN
                                --Caso Colombia
                                IF @paisID = 4
                                BEGIN
                                    --Egresada o Posible Egreso
                                    IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                                    BEGIN
                                        SET @Resultado =  2
                                    END
                                END

                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC o Bolivia
                                    IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2 OR @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3

                            END
                        END
                    END
                    -- Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
                    ELSE IF @paisID = 5 OR @paisID = 10 OR @paisID = 9 OR @paisID = 12 OR @paisID = 13 OR @paisID = 6 OR @paisID = 1 OR @paisID = 14
                    BEGIN
                        -- Validamos si la consultora es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                    SET @Resultado =  2
                                ELSE
                                    SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    SET @Resultado =  2
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es retirada
                            IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
								IF @AutorizaPedido = 'N'
								BEGIN
									--Validamos si es SICC
									IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
										SET @Resultado =  2
									ELSE
										SET @Resultado =  3
								END
								ELSE
									SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC
                                    IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                    END
                    ELSE
                        SET @Resultado = 3
                END
                ELSE
                    SET @Resultado = 3 --Se asume para usuarios del tipo SAC
            END
            ELSE
                SET @Resultado = 3 --Se asume para usuarios del tipo SAC
        END
        ELSE
            SET @Resultado = 1
    END
    ELSE
        SET @Resultado = 0

    RETURN @Resultado

END
GO
ALTER PROCEDURE dbo.GetSesionUsuario_SB2
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	
	DECLARE @FechaLimitePago SMALLDATETIME
	DECLARE @ODSCampaniaID INT
	
	declare @PaisID int
	declare @UsuarioPrueba bit
	declare @CodConsultora varchar(20)
	declare @CampaniaID int
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint
	declare @UltimaCampanaFacturada int
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario

	declare @CountCodigoNivel bigint

	/*Oferta Final, Catalogo Personalizado, CDR*/
	declare @EsOfertaFinalZonaValida bit = 0
	declare @EsOFGanaMasZonaValida bit = 0
	declare @EsCatalogoPersonalizadoZonaValida bit = 0
	declare @EsCDRWebZonaValida  bit = 0
	declare @CodigoZona varchar(4) = ''
	declare @CodigoRegion varchar(2) = ''

	select
		@CodigoZona = IsNull(z.Codigo,''),
		@CodigoRegion = IsNull(r.Codigo,'')
	from ods.consultora c with(nolock)
	inner join ods.Region r on
		c.RegionID = r.RegionID
	inner join ods.Zona z on
		c.ZonaID = z.ZonaID
	where c.codigo = @CodConsultora

	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
		
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/

	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;
	
	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919

	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0

		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;

		/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,-11), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
		)

		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			isnull(c.EsJoven,0) EsJoven,
			(case
				when @CountCodigoNivel =0 then 0  --1589
				when @CountCodigoNivel>0 then 1 End) Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			null as ConsultoraAsociada, --1688
			isnull(si.descripcion,null) SegmentoConstancia, --2469
			isnull(se.Codigo,null) Seccion, --2469
			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469
			case When cl.ConsultoraID is null then 0
				else 1 end esConsultoraLider,
			u.EMailActivo, --2532
			si.SegmentoInternoId,
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u with(nolock)
		LEFT JOIN (
			select *
			from ods.consultora with(nolock)
			where ConsultoraId = @ConsultoraID
		) c ON u.CodigoConsultora = c.Codigo
		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID
		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469
		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469
		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t with(nolock) ON 
			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeo
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@MarcaId int,
	@tipoFiltroUbigeo int
)    
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;
	
	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
	
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';
	
	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1,''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2,''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3,'')
	FROM Ubigeo U with(nolock)
	WHERE codigoubigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		--ISNULL((select top 1 campaniaId from dbo.GetCampaniaPreLogin(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID)),0) as CampaniaActual,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND (@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite) AND
		UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.CampaniaId, -2)
	ORDER BY C.UltimaCampanaFacturada DESC, C.MontoUltimoPedido DESC
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@Nombres varchar(51),
	@Apellidos varchar(51),
	@MarcaId int,
	@tipoFiltroUbigeo int
)
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;

	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
 
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';

	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1, ''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2, ''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3, '')
	FROM Ubigeo with(nolock)
	WHERE CodigoUbigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND
		CONCAT(PrimerNombre,' ',SegundoNombre) LIKE CONCAT('%',@Nombres,'%') AND
		CONCAT(PrimerApellido,' ',SegundoApellido) LIKE CONCAT('%',@Apellidos,'%') AND
		(@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite);
END
GO
ALTER PROCEDURE dbo.GetConsultorasPorUbigeo
	@PaisId int,    
	@CodigoUbigeo varchar(24),    
	@Campania int,    
	@MarcaId int,
	@tipoFiltroUbigeo int
AS    
BEGIN
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	CREATE TABLE #TempConsultoraUbigeo    
	(    
		ID int IDENTITY,    
		ConsultoraID bigint,    
		Codigo varchar(100),    
		CodigoUbigeo varchar(24),    
		NombreCompletoConsultora varchar(300),    
		Email varchar(200),      
		FechaNacimiento datetime,    
		MONTOULTIMOPEDIDO MONEY,    
		UltimaCampanaFacturada INT,     
		CodigoUsuario varchar(100),    
		ZonaID int,    
		RegionID int  
	)

	INSERT INTO #TempConsultoraUbigeo  
    SELECT DISTINCT
		C.ConsultoraID,    
		C.Codigo,
		@CodigoUbigeo as CodigoUbigeo,
		C.NombreCompleto as NombreCompletoConsultora,
		U.Email,
		FechaNacimiento,
		MONTOULTIMOPEDIDO,
		UltimaCampanaFacturada,
		u.CodigoUsuario,
		c.ZonaID,
		c.RegionID    
    FROM ods.CONSULTORA AS C  
    INNER JOIN AFILIACLIENTECONSULTORA AS ACC ON C.CONSULTORAID = ACC.CONSULTORAID  
    INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo   
    WHERE ACC.EsAfiliado = 1 AND C.TERRITORIOID IN (SELECT TerritorioID FROM @TerritorioObjetivo);
		
    IF @MarcaId = 3    
    BEGIN
		DECLARE @EDADLIMITE INT = (SELECT Codigo FROM TABLALOGICADATOS WHERE TABLALOGICAID = 56 AND TABLALOGICADATOSID = 5605);

		DELETE FROM #TempConsultoraUbigeo 
		WHERE ID IN(  
			SELECT ID
			FROM #TempConsultoraUbigeo  
			WHERE (YEAR(getdate()) - year(FechaNacimiento)) >= @EDADLIMITE
		);
    END  
  
   -- -- FILTRANDO CONSULTORAS QUE HAYAN FACTURADO EN LA CAMPAÑANA ANTERIOR  
    --R2442 -  JC - Ya no filtrará por Campaña actual  
    SELECT TCU.ConsultoraID, TCU.Codigo, TCU.CodigoUbigeo, TCU.NombreCompletoConsultora as NombreCompleto, TCU.Email
    FROM #TempConsultoraUbigeo TCU
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,TCU.ZonaID,TCU.RegionID,TCU.ConsultoraID) CC
    WHERE
		dbo.ValidarAutorizacion(@PaisId, TCU.CodigoUsuario) = 3 AND
		TCU.UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.campaniaId, -2)
	order by ULTIMACAMPANAFACTURADA DESC , MONTOULTIMOPEDIDO DESC --R2626 
	
	DROP TABLE #TempConsultoraUbigeo;
END
GO
ALTER PROCEDURE GetProductosOfertaConsultoraNueva
	@CampaniaID INT,
	@ConsultoraID INT
AS
BEGIN
	DECLARE @NroCampania INT = (SELECT TOP 1 nrocampanias FROM pais with(nolock) WHERE EstadoActivo = 1);

	DECLARE @ultimacampaniafacturable INT;
	DECLARE @idcampaniaingreso INT;
	SELECT
		@idcampaniaingreso = AnoCampanaIngreso,
		@ultimacampaniafacturable = isnull(iif(TipoFacturacion = 'FA', UltimaCampanaFacturada, dbo.fnAddCampaniaAndNumero(UltimaCampanaFacturada,-1,@NroCampania)),0)
	FROM ods.Consultora WHERE ConsultoraID=@ConsultoraID;
		
	DECLARE @campaniafacturableingreso INT = @ultimacampaniafacturable - @idcampaniaingreso;
	DECLARE @campaniacompare INT = dbo.fnAddCampaniaAndNumero2(@ultimacampaniafacturable,1,@NroCampania);
	DECLARE @NumeroPedido INT;	
	DECLARE @indicador INT = 0;

	if @CampaniaID = @campaniacompare and (@campaniafacturableingreso between 0 and 3)
	begin		
		declare @CampaniaID1 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -1, @NroCampania);
		declare @CampaniaID2 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -2, @NroCampania);
		declare @CampaniaID3 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -3, @NroCampania);
		declare @CampaniaID4 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -4, @NroCampania);

		declare @idCampaniaID1 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID1);
		declare @idCampaniaID2 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID2);
		declare @idCampaniaID3 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID3);
		declare @idCampaniaID4 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID4);

		declare @campaniasFacturas int;

		---la consultora es nueva, esta realizando su segundo pedido compruebo que la campaña anterior tenga pedido facturado
		if @campaniafacturableingreso = 0
		begin
			set @NumeroPedido = 1;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1) and consultoraid = @ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 1, 1,0);
		end
		---la consultora es nueva, esta realizando su tercer pedido compruebo que las 2 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 1
		begin
			set @NumeroPedido=2;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 2, 1,0);
		end
		---la consultora es nueva, esta realizando su cuarto pedido compruebo que las 3 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 2
		begin
			set @NumeroPedido=3;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 3, 1,0);
		end
		---la consultora es nueva, esta realizando su quINTo pedido compruebo que las 4 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 3
		begin
			set @NumeroPedido=4;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido (nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3,@idCampaniaID4) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 4, 1,0);
		end
	end

	IF @indicador = 1 and (@campaniafacturableingreso between 0 and 3)
	begin
		SELECT TOP 4
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			MarcaID,
			IndicadorMontoMinimo,
			DescripcionProd,
			UnidadesPermitidas,
			(case when len(IndicadorPedido) >0 then 1 else 0 end) IndicadorPedido,
			ganahasta
		FROM (
			SELECT
				og.OfertaNuevaId,
				og.NumeroPedido,
				case isnull(og.FlagImagenActiva,0)
					when 1 then og.ImagenProducto01
					when 2 then og.ImagenProducto02
					when 3 then og.ImagenProducto03
					else ''
				end ImagenProducto01,
				og.Descripcion,
				og.CUV,
				og.PrecioNormal,
				og.PrecioParaTi,
				pc.MarcaID,
				pc.IndicadorMontoMinimo,
				coalesce(pd.Descripcion, pc.Descripcion) DescripcionProd,
				dbo.fnObtenerCantidadOfertaNueva(og.CUV, og.CampaniaID, og.UnidadesPermitidas,og.TipoOfertaSisID, og.ConfiguracionOfertaID) UnidadesPermitidas,
				isnull(pwd.CUV,'') IndicadorPedido,
				isnull(og.ganahasta, 0) ganahasta
			FROM dbo.OfertaNueva  og with(nolock)
			inner join ods.ProductoComercial pc with(nolock) on og.CUV = pc.CUV and og.CampaniaID = pc.AnoCampania
			inner join ods.Campania ca with(nolock) on pc.CampaniaID = ca.CampaniaID
			left join dbo.ProductoDescripcion pd with(nolock) on og.CampaniaID = pd.CampaniaID and og.CUV = pd.CUV
			left join PedidoWebDetalle pwd with(nolock) on pwd.CUV=og.CUV and pwd.CampaniaID= @CampaniaID and pwd.ConsultoraID=@ConsultoraID
			WHERE
				ca.CodiGO = @CampaniaID and
				og.FlagHabilitarOferta = 1 and
				og.NumeroPedido=@NumeroPedido and
				og.CUV not in(SELECT CUV FROM PedidoWebDetalle with(nolock) WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID)
		) a
		WHERE a.UnidadesPermitidas > 0
		order by 5 asc
	end
	else
	begin
		SELECT
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			'' MarcaID,
			'' IndicadorMontoMinimo,
			'' DescripcionProd,
			UnidadesPermitidas,
			0 IndicadorPedido,
			0 ganahasta
		FROM OfertaNueva with(nolock)
		WHERE OfertaNuevaID < 0
		order by 5 asc
	end
END
GO
/*end*/

USE BelcorpSalvador
GO
if object_id('fnGetTableTerritorioIdByFiltroAndUbigeo') is not null
begin
	drop function fnGetTableTerritorioIdByFiltroAndUbigeo;
end
GO
create function fnGetTableTerritorioIdByFiltroAndUbigeo(
	@TipoFiltroUbigeo int,
	@CodigoUbigeo varchar(24)
)
returns @List table (TerritorioID int, CodigoUbigeo varchar(24))
as
begin
	IF @TipoFiltroUbigeo = 1
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM ods.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 2
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 3
	BEGIN
		INSERT INTO @List
		SELECT TT.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		INNER JOIN ods.UBIGEO U with(nolock) ON U.UBIGEOID = T.TERRITORIOID
		INNER JOIN ods.TERRITORIO TT with(nolock) ON TT.CODIGOUBIGEO = U.CODIGOUBIGEO
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END

	return;
end
GO
IF OBJECT_ID('dbo.fnAddCampaniaAndNumero2') IS NOT NULL
BEGIN
	DROP FUNCTION dbo.fnAddCampaniaAndNumero2;
END
GO
CREATE FUNCTION dbo.fnAddCampaniaAndNumero2(
	@CampaniaActual INT,
	@AddNro INT,
	@NroCampanias INT
)
RETURNS INT
AS
BEGIN	
	DECLARE @AnioCampaniaActual INT = @CampaniaActual/100;
	DECLARE @NroCampaniaActual INT = @CampaniaActual%100;
	DECLARE @SumNroCampania INT = (@NroCampaniaActual + @AddNro) - 1;
	DECLARE @AnioCampaniaSiguiente INT = @AnioCampaniaActual + @SumNroCampania/@NroCampanias;
	DECLARE @NroCampaniaSiguiente INT = @SumNroCampania%@NroCampanias + 1;
	
	IF @NroCampaniaSiguiente < 1
	BEGIN
		SET @AnioCampaniaSiguiente = @AnioCampaniaSiguiente - 1;
		SET @NroCampaniaSiguiente = @NroCampaniaSiguiente + @NroCampanias;
	END
	DECLARE @CampaniaSiguiente INT = @AnioCampaniaSiguiente*100 + @NroCampaniaSiguiente;
	RETURN @CampaniaSiguiente;
END
GO
ALTER FUNCTION dbo.fnAddCampaniaAndNumero(
	@CodigoISO CHAR(2),
	@CampaniaActual INT,
	@AddNro INT
)
RETURNS INT
AS
BEGIN
	DECLARE @NroCampanias INT = IIF(
		ISNULL(@CodigoISO,'') <> '',
		(select top 1 NroCampanias from Pais with(nolock) where CodigoISO = @CodigoISO),
		(select top 1 NroCampanias from Pais with(nolock) where EstadoActivo = 1)
	);
	
	RETURN dbo.fnAddCampaniaAndNumero2(@CampaniaActual,@AddNro,@NroCampanias);
END
GO
ALTER FUNCTION dbo.fnGetConfiguracionCampania
(
	@PaisID tinyint,
	@ZonaID int,
	@RegionID int,
	@ConsultoraID bigint
)
RETURNS @TConfiguracionCampania TABLE(
	ID int,
	CampaniaID varchar(6),
	FechaInicioFacturacion datetime,
	FechaFinFacturacion datetime,
	CampaniaDescripcion varchar(6),
	HoraInicio time,
	HoraFin time,
	DiasAntes int,
	ZonaValida int,
	HoraInicioNoFacturable time,
	HoraCierreNoFacturable time,
	ZonaHoraria float,
	HoraCierreZonaNormal time,
	HoraCierreZonaDemAnti time,
	HoraCierreZonaDemAntiCierre time,
	EsZonaDemAnti int,
	DiasDuracionCronograma int,
	HabilitarRestriccionHoraria int,
	HorasDuracionRestriccion int,
	NroCampanias int,
	PROLSinStock bit,
	FechaFinFIC datetime,
	IndicadorOfertaFIC int,
	ImagenURLOfertaFIC varchar(500),
	NuevoPROL bit,
	ZonaNuevoPROL bit,
	EstadoSimplificacionCUV bit,
	EsquemaDAConsultora bit,	
	ValidacionInteractiva bit,
	MensajeValidacionInteractiva varchar(500),
	IndicadorEnviado bit,
	IndicadorGPRSB int,
	FechaActualPais datetime,
	EstadoPedido smallint,
	ValidacionAbierta BIT,
	FechaLimitePago SMALLDATETIME,
	AceptacionConsultoraDA int
)
AS
/*
select * from dbo.fnGetConfiguracionCampania(11,2161,2017,2)
*/
BEGIN
	-- Variables Pais
	DECLARE @CodigoISO CHAR(2)
	DECLARE @ZonaHoraria FLOAT
	DECLARE @HoraCierreZonaNormal TIME(0)
	DECLARE @HoraCierreZonaDemAnti TIME(0)
	DECLARE @NroCampanias INT
	DECLARE @PROLSinStock BIT
	DECLARE @NuevoPROL BIT
	DECLARE @EstadoSimplificacionCUV BIT
	DECLARE @EsquemaDAConsultora BIT
	DECLARE @TipoDA BIT
	DECLARE @PedidoFIC BIT

	select
		@CodigoISO = CodigoISO,
		@ZonaHoraria = ISNULL(ZonaHoraria,0),
		@HoraCierreZonaNormal = HoraCierreZonaNormal,
		@HoraCierreZonaDemAnti = HoraCierreZonaDemAnti,
		@NroCampanias = NroCampanias,
		@PROLSinStock = PROLSinStock,
		@NuevoPROL = NuevoPROL,
		@EstadoSimplificacionCUV = EstadoSimplificacionCUV,
		@EsquemaDAConsultora = EsquemaDAConsultora,
		@TipoDA = TipoDA,
		@PedidoFIC = PedidoFIC
	from Pais (nolock)
	where PaisId = @PaisID

	-- Variables ConfiguracionValidacion
	DECLARE @HoraInicio time(0)
	DECLARE @HoraFin time(0)
	DECLARE @DiasAntes tinyint
	DECLARE @HoraInicioNoFacturable time(0)
	DECLARE @HoraCierreNoFacturable time(0)
	DECLARE @HabilitarRestriccionHoraria bit
	DECLARE @HorasDuracionRestriccion INT
	DECLARE @ValidacionInteractiva bit
	DECLARE @MensajeValidacionInteractiva varchar(500)

	SELECT
		@HoraInicio = HoraInicio,
		@HoraFin = HoraFin,
		@DiasAntes = DiasAntes,
		@HoraInicioNoFacturable = HoraInicioNoFacturable,
		@HoraCierreNoFacturable = HoraCierreNoFacturable,
		@HabilitarRestriccionHoraria = HabilitarRestriccionHoraria,
		@HorasDuracionRestriccion =  ISNULL(HorasDuracionRestriccion,0),
		@ValidacionInteractiva = ValidacionInteractiva,
		@MensajeValidacionInteractiva = MensajeValidacionInteractiva
	FROM [dbo].[ConfiguracionValidacion] (nolock)
	WHERE  PaisID = @PaisID

	 -- Variables ConfiguracionValidacionZona
	DECLARE @DiasDuracionCronograma tinyint
	SET @DiasDuracionCronograma = 1
	DECLARE @ZonaValida int
	DECLARE @IndicadorDias bit
	SET @IndicadorDias = 0

	select
		@DiasDuracionCronograma = DiasDuracionCronograma,
		@ZonaValida = ZonaID,
		@IndicadorDias = ValidacionActiva
	from ConfiguracionValidacionZona with(nolock)
	where CampaniaID = 201301 and ZonaID = @ZonaID

	-- Dias Duracion Cronograma para Nuevas (CR)
	IF @PaisID = 5 OR @PaisID = 8 OR @PaisID = 7 OR @PaisID = 10
	BEGIN
		declare @UCF int = 0;
		declare @SID int = 0;

		select
			@UCF = ISNULL(UltimaCampanaFacturada,0),
			@SID = ISNULL(SegmentoId,0)
		from ods.Consultora with(nolock)
		where ConsultoraID = @ConsultoraID

		IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
			SET @DiasDuracionCronograma = 2
	END

	-- Variables ConfiguracionValidacionNuevoPROL
	DECLARE @ZonaNuevoPROL BIT = 0;
	DECLARE @ContNuevoPROL INT = 0;

	IF @NuevoPROL = 1
	BEGIN
		SELECT @ContNuevoPROL = COUNT(ZonaId)
		FROM ConfiguracionValidacionNuevoPROL with(nolock)
		WHERE ZonaId = @ZonaId

		IF @ContNuevoPROL > 0
			SET @ZonaNuevoPROL = 1
	END

	-- Otras Configuraciones
	IF @IndicadorDias = 0
		SET @DiasAntes = 0

	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	DECLARE @AceptacionConsultoraDA INT
	SET @AceptacionConsultoraDA = -1

	-- Obtener Campania Anterior
	DECLARE @Campania INT
	DECLARE @Anio INT
	SET @Campania = 0

	IF @EsquemaDAConsultora = 0
	BEGIN
		IF @TipoDA = 0
		BEGIN
			SELECT TOP 1
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
			WHERE
				c.ZonaID = @ZonaID AND
				c.RegionID = @RegionID AND
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
		ELSE
		BEGIN
			SELECT TOP 1	
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID		
			LEFT JOIN [dbo].[Cronograma] cr (nolock) ON 
				c.CampaniaID = cr.CampaniaID AND
				c.RegionID = cr.RegionID AND
				c.ZonaID = cr.ZonaID
			WHERE 
				c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
				IIF(@PaisID = 4,
					ISNULL(CONVERT(datetime, cr.FechaInicioDD) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioReFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal)),
					ISNULL(CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
								ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
								CONVERT(datetime, @HoraCierreZonaNormal))
				) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
	END
	ELSE
	BEGIN

		DECLARE @Campania_temp INT
		DECLARE @Anio_temp INT
		SET @Campania_temp = 0

		SELECT TOP 1
			@Campania_temp = ca.Codigo,
			@Anio_temp = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
				ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
		ORDER BY c.CampaniaID DESC

		IF(@Campania_temp <> 0)
		BEGIN
			SET @Campania_temp = @Campania_temp - @Anio_temp
			IF(@Campania_temp = @NroCampanias)
				SET @Campania_temp = @Anio_temp + 101
			ELSE
				SET @Campania_temp = @Anio_temp + @Campania_temp + 1

			SELECT @AceptacionConsultoraDA = TipoConfiguracion
			FROM ConfiguracionConsultoraDA with(nolock)
			WHERE			
				ConsultoraId = @ConsultoraId and
				ZonaId = @ZonaId and
				CampaniaId = cast(@Campania_temp as int)
		END

		SELECT TOP 1
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			IIF(@AceptacionConsultoraDA < 1,
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal),
				CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti)) < @FechaGeneral
		ORDER BY c.CampaniaID DESC
	END
	
	--Obtiene UltimaCampaniaFacturada
	declare @UltimaCampanaFacturada int;
	declare @TipoFacturacion char(2);
	declare @ConsultoraIdAsociada bigint;

	select
		@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0),
		@TipoFacturacion = ISNULL(TipoFacturacion,'')
	From ods.consultora (nolock)
	Where consultoraid = @consultoraid

	--Obtiene UltimaCampaniaFacturada x UsuarioPrueba
	IF @UltimaCampanaFacturada IS NULL
	BEGIN
		SELECT
			@UltimaCampanaFacturada = ISNULL(c.UltimaCampanaFacturada,0),
			@TipoFacturacion = ISNULL(c.TipoFacturacion,''),
			@ConsultoraIdAsociada = ISNULL(c.ConsultoraId,0)
		FROM ConsultoraFicticia cf with(nolock)
		INNER JOIN UsuarioPrueba up with(nolock) on cf.Codigo = up.CodigoFicticio
		INNER JOIN ods.Consultora c with(nolock) on up.CodigoConsultoraAsociada = c.Codigo
		WHERE cf.ConsultoraId = @consultoraid
	END

	IF @TipoFacturacion <> 'FA'
	BEGIN
		SET @UltimaCampanaFacturada = dbo.fnAddCampaniaAndNumero(@CodigoISO,@UltimaCampanaFacturada,-1);
	END

	-- Valida Campania Anterior
	IF(@Campania <> 0)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1

		IF @EsquemaDAConsultora = 1 AND @Campania > @Campania_temp
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
		
		-- validar si pertenece a una zona DA
		DECLARE @EsZonaDA BIT;
		SELECT @EsZonaDA = IIF(ISNULL(c.CampaniaID,0) = 0,0,1)
		FROM dbo.Cronograma c 
		INNER JOIN ods.Campania ca ON c.CampaniaID = ca.CampaniaID 
		WHERE
			ca.Codigo = @Campania_temp AND
			c.RegionID = @RegionID AND
			c.ZonaID = @ZonaID AND
			c.TipoCronograma = 2

		-- si el esquema es de DA y la zona es de DA y ya facturo en la campaña actual 
		-- y la consultora respondio que no en la DA anterior
		-- se resetea la variable
		IF (@EsquemaDAConsultora = 1 AND @EsZonaDA = 1 AND @UltimaCampanaFacturada = @Campania_temp AND @AceptacionConsultoraDA = 0) 
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
	END
	ELSE
	BEGIN
		SELECT TOP 1 
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		WHERE z.ZonaID = @ZonaID AND z.RegionID = @RegionID
		ORDER BY c.FechaInicioFacturacion ASC
	END

	--Valida UltimaCampaniaFacturada
	IF (@UltimaCampanaFacturada = @Campania)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1
	END
	ELSE
	BEGIN
		DECLARE @IndicadorEnviado BIT= 0, @ValidacionAbierta BIT = 0
		DECLARE @IndicadorGPR TINYINT = 0
		DECLARE @EstadoPedido SMALLINT
  
		SELECT	@IndicadorEnviado  = IndicadorEnviado,  
				@IndicadorGPR = GPRSB, 
				@EstadoPedido = EstadoPedido, 
				@ValidacionAbierta = ValidacionAbierta
		FROM	Pedidoweb (nolock)
		WHERE	CampaniaID = @campania and consultoraid = ISNULL(@ConsultoraIdAsociada,@consultoraid)	

		If(@IndicadorEnviado = 1 AND @IndicadorGPR = 0)
		BEGIN
			SET @Campania = @Campania - @Anio
			IF(@Campania = @NroCampanias)
				SET @Campania = @Anio + 101
			ELSE
				SET @Campania = @Anio + @Campania + 1
		END
	END

	-- Pedido FIC
	DECLARE @FechaFinFIC datetime;
	DECLARE @IndicadorOfertaFIC int = 0;
	DECLARE @ImagenURLOfertaFIC varchar(500) = '';

	IF @PedidoFIC = 1
	BEGIN
		DECLARE @campaniaFIC INT
		IF substring(cast(@Campania as varchar(6)),5,2)=cast(@NroCampanias as char(2))
			set @campaniaFIC=cast(cast( cast(substring(cast(@Campania as varchar(6)),1,4)as int)+1 as varchar(4)) + '01' as int)
		ELSE
			set @campaniaFIC= @Campania +1

		SELECT @FechaFinFIC=isnull(FechaFin,GETDATE())
		FROM CronogramaFIC with(nolock)
		WHERE 
			ZonaID=@ZonaID and 
			CampaniaID = (				
				SELECT CampaniaID
				FROM ods.Campania with(nolock)
				WHERE Codigo=@campaniaFIC
			);

		select top 1
			@IndicadorOfertaFIC = 1,
			@ImagenURLOfertaFIC = isnull(ImagenUrl,'')
		from OfertaFIC (nolock)
		where CampaniaID = @campaniaFIC;
	END
			
	-- Listar Variables
	IF @EsquemaDAConsultora = 0
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@TipoDA = 0,c.FechaInicioFacturacion,ISNULL(cr.FechaInicioWeb, c.FechaInicioFacturacion)) AS FechaInicioFacturacion,
			IIF(@TipoDA = 0,
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				IIF(@PaisID = 4,
					ISNULL(cr.FechaInicioDD,c.FechaInicioReFacturacion),
					ISNULL(cr.FechaInicioWeb,c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
						ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)))
			) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@TipoDA = 0, @HoraFin,IIF(ISNULL(cr.CampaniaId,0) = 0,@HoraFin,@HoraCierreZonaDemAnti)) as HoraFin,
			@DiasAntes AS DiasAntes,
			ISNULL(@ZonaValida,-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(@TipoDA = 0, 0, IIF(ISNULL(cr.CampaniaId,0) = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END
	ELSE
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@AceptacionConsultoraDA < 1, c.FechaInicioFacturacion, cr.FechaInicioWeb) AS FechaInicioFacturacion,
			IIF(@AceptacionConsultoraDA < 1, 
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				cr.FechaInicioWeb) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@AceptacionConsultoraDA < 1, @HoraFin, @HoraCierreZonaDemAnti) as HoraFin,
			@DiasAntes AS DiasAntes,
			IIF(@AceptacionConsultoraDA < 1,ISNULL(@ZonaValida,-1),-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			IIF(@AceptacionConsultoraDA < 1,@HoraCierreZonaNormal,@HoraCierreZonaDemAnti) AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(ISNULL(cr.CampaniaId,0) = 0,0,IIF(@AceptacionConsultoraDA = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END

	RETURN
END
GO
ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @CodigoConsultora VARCHAR(50);
	SELECT TOP 1 @CodigoConsultora = co.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		iif(@PaisValido = 1, CO.ZonaID, CO.TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) AND
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	RETURN ISNULL(@CodigoConsultora, '');
END
GO
ALTER FUNCTION dbo.ObtenerConsultoraVecina
(
	@PaisID INT,
	@EdadMaxima INT,
	@UltimaCampanaFacturada INT,
	@ListadoConsultoraId dbo.IdBigintType READONLY,
	@RegionID INT,
	@ZonaID INT,
	@SeccionID INT,
	@TerritorioID INT
)
RETURNS @Consultora TABLE(
	ConsultoraID BIGINT,
	Codigo VARCHAR(30)
)
AS
BEGIN
	INSERT INTO @Consultora(ConsultoraID, Codigo)
	SELECT TOP 1 CO.ConsultoraID, CO.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID      
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, CO.FechaNacimiento, getdate()) <= @EdadMaxima AND
		CO.UltimaCampanaFacturada >= @UltimaCampanaFacturada AND
		CO.ConsultoraID NOT IN (SELECT Id FROM @ListadoConsultoraId) AND
		CO.RegionID = @RegionID AND CO.ZonaID = @ZonaID AND
		(@SeccionID = 0 OR CO.SeccionID = @SeccionID) AND
		(@TerritorioID = 0 OR CO.TerritorioID = @TerritorioID)
	ORDER BY MontoUltimoPedido DESC;
           
	RETURN;
END
GO
ALTER FUNCTION ValidarAutorizacion
(
	@paisID			INT,
	@CodigoUsuario	VARCHAR(100)
)
RETURNS INT
AS
/*
	SELECT DBO.ValidarAutorizacion(3, '1281283')
	SELECT DBO.ValidarAutorizacion(3, '076912262')
*/
BEGIN
	DECLARE @Usuario VARCHAR(100),
            @RolID INT,
            @AutorizaPedido VARCHAR(10),
            @IdEstadoActividad INT,
            @UltimaCampania INT,
            @CampaniaActual INT,
			@Resultado	INT,
			@CodigoConsultora varchar(20),
			@ZonaID INT,
			@RegionID INT,
			@ConsultoraID INT

	SET @RolID = 0
	SET @Usuario = ''
	SET @IdEstadoActividad = -1
	SET @UltimaCampania = 0
	SET @CampaniaActual = 0
	SET @Resultado = 0	

	SELECT	
		@CodigoConsultora = IsNull(CodigoConsultora,0),
		@PaisID = IsNull(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE codigousuario = @CodigoUsuario

	SELECT	
		@ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
		@AutorizaPedido = ISNULL(AutorizaPedido,''),
		@UltimaCampania = ISNULL(UltimaCampanaFacturada,0)
	FROM ods.consultora WITH(NOLOCK)
	WHERE codigo = @CodigoConsultora

	SELECT 
		@Usuario = u.CodigoUsuario, 
		@RolID = ISNULL(ur.RolId,0),
		@AutorizaPedido = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END),
		@CampaniaActual = ISNULL((SELECT TOP 1 campaniaId FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	FROM Usuario u WITH(NOLOCK)
		LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

    --0: Usuario No Existe
    --1: Usuario No es del Portal
    --2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
    --3: Usuario OK
	DECLARE @tabla_Retirada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Retirada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 12
	
	DECLARE @tabla_Reingresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Reingresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 18
	
	DECLARE @tabla_Egresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Egresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 19

    IF @Usuario IS NOT NULL AND @Usuario <> ''
    BEGIN
        IF @RolID != 0
        BEGIN
            IF @AutorizaPedido IS NOT NULL AND @AutorizaPedido <> ''
            BEGIN
                IF @IdEstadoActividad <> -1
                BEGIN
                    -- Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
                    IF @paisID = 11 OR @paisID = 2 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                    BEGIN
                        --Validamos si el estado es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                            BEGIN
                                --Caso Colombia
								IF @paisID = 4
								BEGIN
                                    SET @Resultado =  2
                                END
								ELSE
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                            END
                            ELSE
                            BEGIN
                                --Para bolivia (FOX) se hace la validación del campo AutorizaPedido
                                IF @paisID = 2
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                BEGIN
                                    SET @Resultado =  3
                                END
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es reingresada
                            IF EXISTS(SELECT 1 FROM @tabla_Reingresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
                                IF @paisID = 3
                                BEGIN
                                    --Se valida las campañas que no ha ingresado
									DECLARE @CampaniasSinIngresar INT = 0;
                                    IF LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampania) = 6
                                    BEGIN
										set @CampaniasSinIngresar = @CampaniaActual - dbo.fnAddCampaniaAndNumero(null,@UltimaCampania,3);
                                    END

                                    IF @CampaniasSinIngresar > 0
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        --Validamos el Autoriza Pedido
                                        IF @AutorizaPedido = 'N'
                                            SET @Resultado =  2
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                                ELSE
                                BEGIN
                                    --Caso Colombia
                                    IF @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        IF @AutorizaPedido = 'N'
                                        BEGIN
                                            --Validamos si es SICC o Bolivia
                                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2
                                                SET @Resultado =  2
                                            ELSE
                                                SET @Resultado =  3
                                        END
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                            END
                            ELSE
                            BEGIN
                                --Caso Colombia
                                IF @paisID = 4
                                BEGIN
                                    --Egresada o Posible Egreso
                                    IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                                    BEGIN
                                        SET @Resultado =  2
                                    END
                                END

                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC o Bolivia
                                    IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2 OR @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3

                            END
                        END
                    END
                    -- Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
                    ELSE IF @paisID = 5 OR @paisID = 10 OR @paisID = 9 OR @paisID = 12 OR @paisID = 13 OR @paisID = 6 OR @paisID = 1 OR @paisID = 14
                    BEGIN
                        -- Validamos si la consultora es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                    SET @Resultado =  2
                                ELSE
                                    SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    SET @Resultado =  2
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es retirada
                            IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
								IF @AutorizaPedido = 'N'
								BEGIN
									--Validamos si es SICC
									IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
										SET @Resultado =  2
									ELSE
										SET @Resultado =  3
								END
								ELSE
									SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC
                                    IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                    END
                    ELSE
                        SET @Resultado = 3
                END
                ELSE
                    SET @Resultado = 3 --Se asume para usuarios del tipo SAC
            END
            ELSE
                SET @Resultado = 3 --Se asume para usuarios del tipo SAC
        END
        ELSE
            SET @Resultado = 1
    END
    ELSE
        SET @Resultado = 0

    RETURN @Resultado

END
GO
ALTER PROCEDURE dbo.GetSesionUsuario_SB2
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	
	DECLARE @FechaLimitePago SMALLDATETIME
	DECLARE @ODSCampaniaID INT
	
	declare @PaisID int
	declare @UsuarioPrueba bit
	declare @CodConsultora varchar(20)
	declare @CampaniaID int
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint
	declare @UltimaCampanaFacturada int
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario

	declare @CountCodigoNivel bigint

	/*Oferta Final, Catalogo Personalizado, CDR*/
	declare @EsOfertaFinalZonaValida bit = 0
	declare @EsOFGanaMasZonaValida bit = 0
	declare @EsCatalogoPersonalizadoZonaValida bit = 0
	declare @EsCDRWebZonaValida  bit = 0
	declare @CodigoZona varchar(4) = ''
	declare @CodigoRegion varchar(2) = ''

	select
		@CodigoZona = IsNull(z.Codigo,''),
		@CodigoRegion = IsNull(r.Codigo,'')
	from ods.consultora c with(nolock)
	inner join ods.Region r on
		c.RegionID = r.RegionID
	inner join ods.Zona z on
		c.ZonaID = z.ZonaID
	where c.codigo = @CodConsultora

	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
		
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/

	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;
	
	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919

	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0

		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;

		/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,-11), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
		)

		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			isnull(c.EsJoven,0) EsJoven,
			(case
				when @CountCodigoNivel =0 then 0  --1589
				when @CountCodigoNivel>0 then 1 End) Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			null as ConsultoraAsociada, --1688
			isnull(si.descripcion,null) SegmentoConstancia, --2469
			isnull(se.Codigo,null) Seccion, --2469
			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469
			case When cl.ConsultoraID is null then 0
				else 1 end esConsultoraLider,
			u.EMailActivo, --2532
			si.SegmentoInternoId,
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u with(nolock)
		LEFT JOIN (
			select *
			from ods.consultora with(nolock)
			where ConsultoraId = @ConsultoraID
		) c ON u.CodigoConsultora = c.Codigo
		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID
		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469
		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469
		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t with(nolock) ON 
			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeo
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@MarcaId int,
	@tipoFiltroUbigeo int
)    
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;
	
	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
	
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';
	
	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1,''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2,''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3,'')
	FROM Ubigeo U with(nolock)
	WHERE codigoubigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		--ISNULL((select top 1 campaniaId from dbo.GetCampaniaPreLogin(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID)),0) as CampaniaActual,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND (@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite) AND
		UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.CampaniaId, -2)
	ORDER BY C.UltimaCampanaFacturada DESC, C.MontoUltimoPedido DESC
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@Nombres varchar(51),
	@Apellidos varchar(51),
	@MarcaId int,
	@tipoFiltroUbigeo int
)
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;

	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
 
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';

	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1, ''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2, ''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3, '')
	FROM Ubigeo with(nolock)
	WHERE CodigoUbigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND
		CONCAT(PrimerNombre,' ',SegundoNombre) LIKE CONCAT('%',@Nombres,'%') AND
		CONCAT(PrimerApellido,' ',SegundoApellido) LIKE CONCAT('%',@Apellidos,'%') AND
		(@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite);
END
GO
ALTER PROCEDURE dbo.GetConsultorasPorUbigeo
	@PaisId int,    
	@CodigoUbigeo varchar(24),    
	@Campania int,    
	@MarcaId int,
	@tipoFiltroUbigeo int
AS    
BEGIN
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	CREATE TABLE #TempConsultoraUbigeo    
	(    
		ID int IDENTITY,    
		ConsultoraID bigint,    
		Codigo varchar(100),    
		CodigoUbigeo varchar(24),    
		NombreCompletoConsultora varchar(300),    
		Email varchar(200),      
		FechaNacimiento datetime,    
		MONTOULTIMOPEDIDO MONEY,    
		UltimaCampanaFacturada INT,     
		CodigoUsuario varchar(100),    
		ZonaID int,    
		RegionID int  
	)

	INSERT INTO #TempConsultoraUbigeo  
    SELECT DISTINCT
		C.ConsultoraID,    
		C.Codigo,
		@CodigoUbigeo as CodigoUbigeo,
		C.NombreCompleto as NombreCompletoConsultora,
		U.Email,
		FechaNacimiento,
		MONTOULTIMOPEDIDO,
		UltimaCampanaFacturada,
		u.CodigoUsuario,
		c.ZonaID,
		c.RegionID    
    FROM ods.CONSULTORA AS C  
    INNER JOIN AFILIACLIENTECONSULTORA AS ACC ON C.CONSULTORAID = ACC.CONSULTORAID  
    INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo   
    WHERE ACC.EsAfiliado = 1 AND C.TERRITORIOID IN (SELECT TerritorioID FROM @TerritorioObjetivo);
		
    IF @MarcaId = 3    
    BEGIN
		DECLARE @EDADLIMITE INT = (SELECT Codigo FROM TABLALOGICADATOS WHERE TABLALOGICAID = 56 AND TABLALOGICADATOSID = 5605);

		DELETE FROM #TempConsultoraUbigeo 
		WHERE ID IN(  
			SELECT ID
			FROM #TempConsultoraUbigeo  
			WHERE (YEAR(getdate()) - year(FechaNacimiento)) >= @EDADLIMITE
		);
    END  
  
   -- -- FILTRANDO CONSULTORAS QUE HAYAN FACTURADO EN LA CAMPAÑANA ANTERIOR  
    --R2442 -  JC - Ya no filtrará por Campaña actual  
    SELECT TCU.ConsultoraID, TCU.Codigo, TCU.CodigoUbigeo, TCU.NombreCompletoConsultora as NombreCompleto, TCU.Email
    FROM #TempConsultoraUbigeo TCU
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,TCU.ZonaID,TCU.RegionID,TCU.ConsultoraID) CC
    WHERE
		dbo.ValidarAutorizacion(@PaisId, TCU.CodigoUsuario) = 3 AND
		TCU.UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.campaniaId, -2)
	order by ULTIMACAMPANAFACTURADA DESC , MONTOULTIMOPEDIDO DESC --R2626 
	
	DROP TABLE #TempConsultoraUbigeo;
END
GO
ALTER PROCEDURE GetProductosOfertaConsultoraNueva
	@CampaniaID INT,
	@ConsultoraID INT
AS
BEGIN
	DECLARE @NroCampania INT = (SELECT TOP 1 nrocampanias FROM pais with(nolock) WHERE EstadoActivo = 1);

	DECLARE @ultimacampaniafacturable INT;
	DECLARE @idcampaniaingreso INT;
	SELECT
		@idcampaniaingreso = AnoCampanaIngreso,
		@ultimacampaniafacturable = isnull(iif(TipoFacturacion = 'FA', UltimaCampanaFacturada, dbo.fnAddCampaniaAndNumero(UltimaCampanaFacturada,-1,@NroCampania)),0)
	FROM ods.Consultora WHERE ConsultoraID=@ConsultoraID;
		
	DECLARE @campaniafacturableingreso INT = @ultimacampaniafacturable - @idcampaniaingreso;
	DECLARE @campaniacompare INT = dbo.fnAddCampaniaAndNumero2(@ultimacampaniafacturable,1,@NroCampania);
	DECLARE @NumeroPedido INT;	
	DECLARE @indicador INT = 0;

	if @CampaniaID = @campaniacompare and (@campaniafacturableingreso between 0 and 3)
	begin		
		declare @CampaniaID1 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -1, @NroCampania);
		declare @CampaniaID2 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -2, @NroCampania);
		declare @CampaniaID3 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -3, @NroCampania);
		declare @CampaniaID4 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -4, @NroCampania);

		declare @idCampaniaID1 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID1);
		declare @idCampaniaID2 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID2);
		declare @idCampaniaID3 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID3);
		declare @idCampaniaID4 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID4);

		declare @campaniasFacturas int;

		---la consultora es nueva, esta realizando su segundo pedido compruebo que la campaña anterior tenga pedido facturado
		if @campaniafacturableingreso = 0
		begin
			set @NumeroPedido = 1;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1) and consultoraid = @ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 1, 1,0);
		end
		---la consultora es nueva, esta realizando su tercer pedido compruebo que las 2 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 1
		begin
			set @NumeroPedido=2;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 2, 1,0);
		end
		---la consultora es nueva, esta realizando su cuarto pedido compruebo que las 3 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 2
		begin
			set @NumeroPedido=3;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 3, 1,0);
		end
		---la consultora es nueva, esta realizando su quINTo pedido compruebo que las 4 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 3
		begin
			set @NumeroPedido=4;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido (nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3,@idCampaniaID4) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 4, 1,0);
		end
	end

	IF @indicador = 1 and (@campaniafacturableingreso between 0 and 3)
	begin
		SELECT TOP 4
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			MarcaID,
			IndicadorMontoMinimo,
			DescripcionProd,
			UnidadesPermitidas,
			(case when len(IndicadorPedido) >0 then 1 else 0 end) IndicadorPedido,
			ganahasta
		FROM (
			SELECT
				og.OfertaNuevaId,
				og.NumeroPedido,
				case isnull(og.FlagImagenActiva,0)
					when 1 then og.ImagenProducto01
					when 2 then og.ImagenProducto02
					when 3 then og.ImagenProducto03
					else ''
				end ImagenProducto01,
				og.Descripcion,
				og.CUV,
				og.PrecioNormal,
				og.PrecioParaTi,
				pc.MarcaID,
				pc.IndicadorMontoMinimo,
				coalesce(pd.Descripcion, pc.Descripcion) DescripcionProd,
				dbo.fnObtenerCantidadOfertaNueva(og.CUV, og.CampaniaID, og.UnidadesPermitidas,og.TipoOfertaSisID, og.ConfiguracionOfertaID) UnidadesPermitidas,
				isnull(pwd.CUV,'') IndicadorPedido,
				isnull(og.ganahasta, 0) ganahasta
			FROM dbo.OfertaNueva  og with(nolock)
			inner join ods.ProductoComercial pc with(nolock) on og.CUV = pc.CUV and og.CampaniaID = pc.AnoCampania
			inner join ods.Campania ca with(nolock) on pc.CampaniaID = ca.CampaniaID
			left join dbo.ProductoDescripcion pd with(nolock) on og.CampaniaID = pd.CampaniaID and og.CUV = pd.CUV
			left join PedidoWebDetalle pwd with(nolock) on pwd.CUV=og.CUV and pwd.CampaniaID= @CampaniaID and pwd.ConsultoraID=@ConsultoraID
			WHERE
				ca.CodiGO = @CampaniaID and
				og.FlagHabilitarOferta = 1 and
				og.NumeroPedido=@NumeroPedido and
				og.CUV not in(SELECT CUV FROM PedidoWebDetalle with(nolock) WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID)
		) a
		WHERE a.UnidadesPermitidas > 0
		order by 5 asc
	end
	else
	begin
		SELECT
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			'' MarcaID,
			'' IndicadorMontoMinimo,
			'' DescripcionProd,
			UnidadesPermitidas,
			0 IndicadorPedido,
			0 ganahasta
		FROM OfertaNueva with(nolock)
		WHERE OfertaNuevaID < 0
		order by 5 asc
	end
END
GO
/*end*/

USE BelcorpVenezuela
GO
if object_id('fnGetTableTerritorioIdByFiltroAndUbigeo') is not null
begin
	drop function fnGetTableTerritorioIdByFiltroAndUbigeo;
end
GO
create function fnGetTableTerritorioIdByFiltroAndUbigeo(
	@TipoFiltroUbigeo int,
	@CodigoUbigeo varchar(24)
)
returns @List table (TerritorioID int, CodigoUbigeo varchar(24))
as
begin
	IF @TipoFiltroUbigeo = 1
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM ods.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 2
	BEGIN
		INSERT INTO @List
		SELECT T.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END
	ELSE IF @TipoFiltroUbigeo = 3
	BEGIN
		INSERT INTO @List
		SELECT TT.TERRITORIOID, T.CODIGOUBIGEO
		FROM dbo.TERRITORIO T with(nolock)
		INNER JOIN ods.UBIGEO U with(nolock) ON U.UBIGEOID = T.TERRITORIOID
		INNER JOIN ods.TERRITORIO TT with(nolock) ON TT.CODIGOUBIGEO = U.CODIGOUBIGEO
		WHERE T.CODIGOUBIGEO = @CodigoUbigeo;
	END

	return;
end
GO
IF OBJECT_ID('dbo.fnAddCampaniaAndNumero2') IS NOT NULL
BEGIN
	DROP FUNCTION dbo.fnAddCampaniaAndNumero2;
END
GO
CREATE FUNCTION dbo.fnAddCampaniaAndNumero2(
	@CampaniaActual INT,
	@AddNro INT,
	@NroCampanias INT
)
RETURNS INT
AS
BEGIN	
	DECLARE @AnioCampaniaActual INT = @CampaniaActual/100;
	DECLARE @NroCampaniaActual INT = @CampaniaActual%100;
	DECLARE @SumNroCampania INT = (@NroCampaniaActual + @AddNro) - 1;
	DECLARE @AnioCampaniaSiguiente INT = @AnioCampaniaActual + @SumNroCampania/@NroCampanias;
	DECLARE @NroCampaniaSiguiente INT = @SumNroCampania%@NroCampanias + 1;
	
	IF @NroCampaniaSiguiente < 1
	BEGIN
		SET @AnioCampaniaSiguiente = @AnioCampaniaSiguiente - 1;
		SET @NroCampaniaSiguiente = @NroCampaniaSiguiente + @NroCampanias;
	END
	DECLARE @CampaniaSiguiente INT = @AnioCampaniaSiguiente*100 + @NroCampaniaSiguiente;
	RETURN @CampaniaSiguiente;
END
GO
ALTER FUNCTION dbo.fnAddCampaniaAndNumero(
	@CodigoISO CHAR(2),
	@CampaniaActual INT,
	@AddNro INT
)
RETURNS INT
AS
BEGIN
	DECLARE @NroCampanias INT = IIF(
		ISNULL(@CodigoISO,'') <> '',
		(select top 1 NroCampanias from Pais with(nolock) where CodigoISO = @CodigoISO),
		(select top 1 NroCampanias from Pais with(nolock) where EstadoActivo = 1)
	);
	
	RETURN dbo.fnAddCampaniaAndNumero2(@CampaniaActual,@AddNro,@NroCampanias);
END
GO
ALTER FUNCTION dbo.fnGetConfiguracionCampania
(
	@PaisID tinyint,
	@ZonaID int,
	@RegionID int,
	@ConsultoraID bigint
)
RETURNS @TConfiguracionCampania TABLE(
	ID int,
	CampaniaID varchar(6),
	FechaInicioFacturacion datetime,
	FechaFinFacturacion datetime,
	CampaniaDescripcion varchar(6),
	HoraInicio time,
	HoraFin time,
	DiasAntes int,
	ZonaValida int,
	HoraInicioNoFacturable time,
	HoraCierreNoFacturable time,
	ZonaHoraria float,
	HoraCierreZonaNormal time,
	HoraCierreZonaDemAnti time,
	HoraCierreZonaDemAntiCierre time,
	EsZonaDemAnti int,
	DiasDuracionCronograma int,
	HabilitarRestriccionHoraria int,
	HorasDuracionRestriccion int,
	NroCampanias int,
	PROLSinStock bit,
	FechaFinFIC datetime,
	IndicadorOfertaFIC int,
	ImagenURLOfertaFIC varchar(500),
	NuevoPROL bit,
	ZonaNuevoPROL bit,
	EstadoSimplificacionCUV bit,
	EsquemaDAConsultora bit,	
	ValidacionInteractiva bit,
	MensajeValidacionInteractiva varchar(500),
	IndicadorEnviado bit,
	IndicadorGPRSB int,
	FechaActualPais datetime,
	EstadoPedido smallint,
	ValidacionAbierta BIT,
	FechaLimitePago SMALLDATETIME,
	AceptacionConsultoraDA int
)
AS
/*
select * from dbo.fnGetConfiguracionCampania(11,2161,2017,2)
*/
BEGIN
	-- Variables Pais
	DECLARE @CodigoISO CHAR(2)
	DECLARE @ZonaHoraria FLOAT
	DECLARE @HoraCierreZonaNormal TIME(0)
	DECLARE @HoraCierreZonaDemAnti TIME(0)
	DECLARE @NroCampanias INT
	DECLARE @PROLSinStock BIT
	DECLARE @NuevoPROL BIT
	DECLARE @EstadoSimplificacionCUV BIT
	DECLARE @EsquemaDAConsultora BIT
	DECLARE @TipoDA BIT
	DECLARE @PedidoFIC BIT

	select
		@CodigoISO = CodigoISO,
		@ZonaHoraria = ISNULL(ZonaHoraria,0),
		@HoraCierreZonaNormal = HoraCierreZonaNormal,
		@HoraCierreZonaDemAnti = HoraCierreZonaDemAnti,
		@NroCampanias = NroCampanias,
		@PROLSinStock = PROLSinStock,
		@NuevoPROL = NuevoPROL,
		@EstadoSimplificacionCUV = EstadoSimplificacionCUV,
		@EsquemaDAConsultora = EsquemaDAConsultora,
		@TipoDA = TipoDA,
		@PedidoFIC = PedidoFIC
	from Pais (nolock)
	where PaisId = @PaisID

	-- Variables ConfiguracionValidacion
	DECLARE @HoraInicio time(0)
	DECLARE @HoraFin time(0)
	DECLARE @DiasAntes tinyint
	DECLARE @HoraInicioNoFacturable time(0)
	DECLARE @HoraCierreNoFacturable time(0)
	DECLARE @HabilitarRestriccionHoraria bit
	DECLARE @HorasDuracionRestriccion INT
	DECLARE @ValidacionInteractiva bit
	DECLARE @MensajeValidacionInteractiva varchar(500)

	SELECT
		@HoraInicio = HoraInicio,
		@HoraFin = HoraFin,
		@DiasAntes = DiasAntes,
		@HoraInicioNoFacturable = HoraInicioNoFacturable,
		@HoraCierreNoFacturable = HoraCierreNoFacturable,
		@HabilitarRestriccionHoraria = HabilitarRestriccionHoraria,
		@HorasDuracionRestriccion =  ISNULL(HorasDuracionRestriccion,0),
		@ValidacionInteractiva = ValidacionInteractiva,
		@MensajeValidacionInteractiva = MensajeValidacionInteractiva
	FROM [dbo].[ConfiguracionValidacion] (nolock)
	WHERE  PaisID = @PaisID

	 -- Variables ConfiguracionValidacionZona
	DECLARE @DiasDuracionCronograma tinyint
	SET @DiasDuracionCronograma = 1
	DECLARE @ZonaValida int
	DECLARE @IndicadorDias bit
	SET @IndicadorDias = 0

	select
		@DiasDuracionCronograma = DiasDuracionCronograma,
		@ZonaValida = ZonaID,
		@IndicadorDias = ValidacionActiva
	from ConfiguracionValidacionZona with(nolock)
	where CampaniaID = 201301 and ZonaID = @ZonaID

	-- Dias Duracion Cronograma para Nuevas (CR)
	IF @PaisID = 5 OR @PaisID = 8 OR @PaisID = 7 OR @PaisID = 10
	BEGIN
		declare @UCF int = 0;
		declare @SID int = 0;

		select
			@UCF = ISNULL(UltimaCampanaFacturada,0),
			@SID = ISNULL(SegmentoId,0)
		from ods.Consultora with(nolock)
		where ConsultoraID = @ConsultoraID

		IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
			SET @DiasDuracionCronograma = 2
	END

	-- Variables ConfiguracionValidacionNuevoPROL
	DECLARE @ZonaNuevoPROL BIT = 0;
	DECLARE @ContNuevoPROL INT = 0;

	IF @NuevoPROL = 1
	BEGIN
		SELECT @ContNuevoPROL = COUNT(ZonaId)
		FROM ConfiguracionValidacionNuevoPROL with(nolock)
		WHERE ZonaId = @ZonaId

		IF @ContNuevoPROL > 0
			SET @ZonaNuevoPROL = 1
	END

	-- Otras Configuraciones
	IF @IndicadorDias = 0
		SET @DiasAntes = 0

	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	DECLARE @AceptacionConsultoraDA INT
	SET @AceptacionConsultoraDA = -1

	-- Obtener Campania Anterior
	DECLARE @Campania INT
	DECLARE @Anio INT
	SET @Campania = 0

	IF @EsquemaDAConsultora = 0
	BEGIN
		IF @TipoDA = 0
		BEGIN
			SELECT TOP 1
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
			WHERE
				c.ZonaID = @ZonaID AND
				c.RegionID = @RegionID AND
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
		ELSE
		BEGIN
			SELECT TOP 1	
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID		
			LEFT JOIN [dbo].[Cronograma] cr (nolock) ON 
				c.CampaniaID = cr.CampaniaID AND
				c.RegionID = cr.RegionID AND
				c.ZonaID = cr.ZonaID
			WHERE 
				c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
				IIF(@PaisID = 4,
					ISNULL(CONVERT(datetime, cr.FechaInicioDD) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioReFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal)),
					ISNULL(CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
								ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
								CONVERT(datetime, @HoraCierreZonaNormal))
				) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
	END
	ELSE
	BEGIN

		DECLARE @Campania_temp INT
		DECLARE @Anio_temp INT
		SET @Campania_temp = 0

		SELECT TOP 1
			@Campania_temp = ca.Codigo,
			@Anio_temp = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
				ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
		ORDER BY c.CampaniaID DESC

		IF(@Campania_temp <> 0)
		BEGIN
			SET @Campania_temp = @Campania_temp - @Anio_temp
			IF(@Campania_temp = @NroCampanias)
				SET @Campania_temp = @Anio_temp + 101
			ELSE
				SET @Campania_temp = @Anio_temp + @Campania_temp + 1

			SELECT @AceptacionConsultoraDA = TipoConfiguracion
			FROM ConfiguracionConsultoraDA with(nolock)
			WHERE			
				ConsultoraId = @ConsultoraId and
				ZonaId = @ZonaId and
				CampaniaId = cast(@Campania_temp as int)
		END

		SELECT TOP 1
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			IIF(@AceptacionConsultoraDA < 1,
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal),
				CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti)) < @FechaGeneral
		ORDER BY c.CampaniaID DESC
	END
	
	--Obtiene UltimaCampaniaFacturada
	declare @UltimaCampanaFacturada int;
	declare @TipoFacturacion char(2);
	declare @ConsultoraIdAsociada bigint;

	select
		@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0),
		@TipoFacturacion = ISNULL(TipoFacturacion,'')
	From ods.consultora (nolock)
	Where consultoraid = @consultoraid

	--Obtiene UltimaCampaniaFacturada x UsuarioPrueba
	IF @UltimaCampanaFacturada IS NULL
	BEGIN
		SELECT
			@UltimaCampanaFacturada = ISNULL(c.UltimaCampanaFacturada,0),
			@TipoFacturacion = ISNULL(c.TipoFacturacion,''),
			@ConsultoraIdAsociada = ISNULL(c.ConsultoraId,0)
		FROM ConsultoraFicticia cf with(nolock)
		INNER JOIN UsuarioPrueba up with(nolock) on cf.Codigo = up.CodigoFicticio
		INNER JOIN ods.Consultora c with(nolock) on up.CodigoConsultoraAsociada = c.Codigo
		WHERE cf.ConsultoraId = @consultoraid
	END

	IF @TipoFacturacion <> 'FA'
	BEGIN
		SET @UltimaCampanaFacturada = dbo.fnAddCampaniaAndNumero(@CodigoISO,@UltimaCampanaFacturada,-1);
	END

	-- Valida Campania Anterior
	IF(@Campania <> 0)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1

		IF @EsquemaDAConsultora = 1 AND @Campania > @Campania_temp
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
		
		-- validar si pertenece a una zona DA
		DECLARE @EsZonaDA BIT;
		SELECT @EsZonaDA = IIF(ISNULL(c.CampaniaID,0) = 0,0,1)
		FROM dbo.Cronograma c 
		INNER JOIN ods.Campania ca ON c.CampaniaID = ca.CampaniaID 
		WHERE
			ca.Codigo = @Campania_temp AND
			c.RegionID = @RegionID AND
			c.ZonaID = @ZonaID AND
			c.TipoCronograma = 2

		-- si el esquema es de DA y la zona es de DA y ya facturo en la campaña actual 
		-- y la consultora respondio que no en la DA anterior
		-- se resetea la variable
		IF (@EsquemaDAConsultora = 1 AND @EsZonaDA = 1 AND @UltimaCampanaFacturada = @Campania_temp AND @AceptacionConsultoraDA = 0) 
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
	END
	ELSE
	BEGIN
		SELECT TOP 1 
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		WHERE z.ZonaID = @ZonaID AND z.RegionID = @RegionID
		ORDER BY c.FechaInicioFacturacion ASC
	END

	--Valida UltimaCampaniaFacturada
	IF (@UltimaCampanaFacturada = @Campania)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1
	END
	ELSE
	BEGIN
		DECLARE @IndicadorEnviado BIT= 0, @ValidacionAbierta BIT = 0
		DECLARE @IndicadorGPR TINYINT = 0
		DECLARE @EstadoPedido SMALLINT
  
		SELECT	@IndicadorEnviado  = IndicadorEnviado,  
				@IndicadorGPR = GPRSB, 
				@EstadoPedido = EstadoPedido, 
				@ValidacionAbierta = ValidacionAbierta
		FROM	Pedidoweb (nolock)
		WHERE	CampaniaID = @campania and consultoraid = ISNULL(@ConsultoraIdAsociada,@consultoraid)	

		If(@IndicadorEnviado = 1 AND @IndicadorGPR = 0)
		BEGIN
			SET @Campania = @Campania - @Anio
			IF(@Campania = @NroCampanias)
				SET @Campania = @Anio + 101
			ELSE
				SET @Campania = @Anio + @Campania + 1
		END
	END

	-- Pedido FIC
	DECLARE @FechaFinFIC datetime;
	DECLARE @IndicadorOfertaFIC int = 0;
	DECLARE @ImagenURLOfertaFIC varchar(500) = '';

	IF @PedidoFIC = 1
	BEGIN
		DECLARE @campaniaFIC INT
		IF substring(cast(@Campania as varchar(6)),5,2)=cast(@NroCampanias as char(2))
			set @campaniaFIC=cast(cast( cast(substring(cast(@Campania as varchar(6)),1,4)as int)+1 as varchar(4)) + '01' as int)
		ELSE
			set @campaniaFIC= @Campania +1

		SELECT @FechaFinFIC=isnull(FechaFin,GETDATE())
		FROM CronogramaFIC with(nolock)
		WHERE 
			ZonaID=@ZonaID and 
			CampaniaID = (				
				SELECT CampaniaID
				FROM ods.Campania with(nolock)
				WHERE Codigo=@campaniaFIC
			);

		select top 1
			@IndicadorOfertaFIC = 1,
			@ImagenURLOfertaFIC = isnull(ImagenUrl,'')
		from OfertaFIC (nolock)
		where CampaniaID = @campaniaFIC;
	END
			
	-- Listar Variables
	IF @EsquemaDAConsultora = 0
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@TipoDA = 0,c.FechaInicioFacturacion,ISNULL(cr.FechaInicioWeb, c.FechaInicioFacturacion)) AS FechaInicioFacturacion,
			IIF(@TipoDA = 0,
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				IIF(@PaisID = 4,
					ISNULL(cr.FechaInicioDD,c.FechaInicioReFacturacion),
					ISNULL(cr.FechaInicioWeb,c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
						ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)))
			) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@TipoDA = 0, @HoraFin,IIF(ISNULL(cr.CampaniaId,0) = 0,@HoraFin,@HoraCierreZonaDemAnti)) as HoraFin,
			@DiasAntes AS DiasAntes,
			ISNULL(@ZonaValida,-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(@TipoDA = 0, 0, IIF(ISNULL(cr.CampaniaId,0) = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END
	ELSE
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@AceptacionConsultoraDA < 1, c.FechaInicioFacturacion, cr.FechaInicioWeb) AS FechaInicioFacturacion,
			IIF(@AceptacionConsultoraDA < 1, 
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				cr.FechaInicioWeb) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@AceptacionConsultoraDA < 1, @HoraFin, @HoraCierreZonaDemAnti) as HoraFin,
			@DiasAntes AS DiasAntes,
			IIF(@AceptacionConsultoraDA < 1,ISNULL(@ZonaValida,-1),-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			IIF(@AceptacionConsultoraDA < 1,@HoraCierreZonaNormal,@HoraCierreZonaDemAnti) AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(ISNULL(cr.CampaniaId,0) = 0,0,IIF(@AceptacionConsultoraDA = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END

	RETURN
END
GO
ALTER FUNCTION [dbo].[ObtenerConsultoraSolicitudCliente]
(
	@CodigoUbigeo VARCHAR(30),
	@CampaniaID VARCHAR(6),
	@PaisID INT,
	@MarcaID INT ,
	@Paises varchar(150) = null,
	@SolicitudClienteID BIGINT
)
RETURNS VARCHAR(30)
AS
BEGIN
	set @Paises = isnull(@Paises, (select top 1 Descripcion from dbo.TablaLogicaDatos where TablaLogicaDatosID = 5606));
		
	--------Crear tabla temporal CFS
	DECLARE @SolicitudCLienteOrigen BIGINT = (SELECT SolicitudClienteOrigen FROM SolicitudCliente WHERE SolicitudClienteID=@SolicitudClienteID)
	IF (@SolicitudCLienteOrigen=0)
	BEGIN
		SET @SolicitudCLienteOrigen= @SolicitudClienteID
	END

	DECLARE @TmpConsultorasID TABLE (ConsultoraID BIGINT);
	INSERT INTO @TmpConsultorasID
	SELECT ConsultoraID
	FROM SolicitudCliente WITH(NOLOCK)
	WHERE SolicitudClienteID IN (
		select SolicitudClienteID
		from SolicitudCliente
		where SolicitudClienteID=@SolicitudCLienteOrigen OR SolicitudClienteOrigen=@SolicitudCLienteOrigen
	);
	-----------------------------------
	
	declare @EdadMaxima int = iif(@MarcaID <> 3, 999, (select top 1 codigo from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 5605));
	declare @FiltroUbigeo int = (select top 1 convert(int, Codigo) from TablaLogicaDatos with(nolock) where TablaLogicaDatosID = 6601);
	declare @intTotalCampanias int = (select top 1 NroCampanias from Pais with(nolock) where PaisID = @PaisID);
	declare @PaisActivo char(2) = (select top 1 CodigoISO from Pais with(nolock) where EstadoActivo = 1);
	declare @PaisValido bit = iif(CHARINDEX(@PaisActivo,@Paises) > 0, 1, 0);
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@FiltroUbigeo,@CodigoUbigeo);

	DECLARE @CodigoConsultora VARCHAR(50);
	SELECT TOP 1 @CodigoConsultora = co.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		iif(@PaisValido = 1, CO.ZonaID, CO.TerritorioID) IN (select TerritorioID from @TerritorioObjetivo) AND
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, FechaNacimiento, getdate()) <= @EdadMaxima AND
		UltimaCampanaFacturada >= dbo.GetCampaniaAnteriorSolicitud(@CampaniaID, @intTotalCampanias) AND
		CO.ConsultoraID NOT IN (SELECT ConsultoraID FROM @TmpConsultorasID)
	ORDER BY MontoUltimoPedido DESC;

	RETURN ISNULL(@CodigoConsultora, '');
END
GO
ALTER FUNCTION dbo.ObtenerConsultoraVecina
(
	@PaisID INT,
	@EdadMaxima INT,
	@UltimaCampanaFacturada INT,
	@ListadoConsultoraId dbo.IdBigintType READONLY,
	@RegionID INT,
	@ZonaID INT,
	@SeccionID INT,
	@TerritorioID INT
)
RETURNS @Consultora TABLE(
	ConsultoraID BIGINT,
	Codigo VARCHAR(30)
)
AS
BEGIN
	INSERT INTO @Consultora(ConsultoraID, Codigo)
	SELECT TOP 1 CO.ConsultoraID, CO.Codigo
	FROM ods.Consultora CO
	INNER JOIN AfiliaClienteConsultora ACC ON CO.ConsultoraID = ACC.ConsultoraID      
	INNER JOIN Usuario USU ON USU.CodigoConsultora = CO.Codigo
	WHERE
		ACC.EsAfiliado = 1 AND
		dbo.ValidarAutorizacion(@PaisID, USU.CodigoUsuario) = 3 AND
		DATEDIFF(YEAR, CO.FechaNacimiento, getdate()) <= @EdadMaxima AND
		CO.UltimaCampanaFacturada >= @UltimaCampanaFacturada AND
		CO.ConsultoraID NOT IN (SELECT Id FROM @ListadoConsultoraId) AND
		CO.RegionID = @RegionID AND CO.ZonaID = @ZonaID AND
		(@SeccionID = 0 OR CO.SeccionID = @SeccionID) AND
		(@TerritorioID = 0 OR CO.TerritorioID = @TerritorioID)
	ORDER BY MontoUltimoPedido DESC;
           
	RETURN;
END
GO
ALTER FUNCTION ValidarAutorizacion
(
	@paisID			INT,
	@CodigoUsuario	VARCHAR(100)
)
RETURNS INT
AS
/*
	SELECT DBO.ValidarAutorizacion(3, '1281283')
	SELECT DBO.ValidarAutorizacion(3, '076912262')
*/
BEGIN
	DECLARE @Usuario VARCHAR(100),
            @RolID INT,
            @AutorizaPedido VARCHAR(10),
            @IdEstadoActividad INT,
            @UltimaCampania INT,
            @CampaniaActual INT,
			@Resultado	INT,
			@CodigoConsultora varchar(20),
			@ZonaID INT,
			@RegionID INT,
			@ConsultoraID INT

	SET @RolID = 0
	SET @Usuario = ''
	SET @IdEstadoActividad = -1
	SET @UltimaCampania = 0
	SET @CampaniaActual = 0
	SET @Resultado = 0	

	SELECT	
		@CodigoConsultora = IsNull(CodigoConsultora,0),
		@PaisID = IsNull(PaisID,0)
	FROM usuario WITH(NOLOCK)
	WHERE codigousuario = @CodigoUsuario

	SELECT	
		@ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
		@AutorizaPedido = ISNULL(AutorizaPedido,''),
		@UltimaCampania = ISNULL(UltimaCampanaFacturada,0)
	FROM ods.consultora WITH(NOLOCK)
	WHERE codigo = @CodigoConsultora

	SELECT 
		@Usuario = u.CodigoUsuario, 
		@RolID = ISNULL(ur.RolId,0),
		@AutorizaPedido = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END),
		@CampaniaActual = ISNULL((SELECT TOP 1 campaniaId FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	FROM Usuario u WITH(NOLOCK)
		LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

    --0: Usuario No Existe
    --1: Usuario No es del Portal
    --2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
    --3: Usuario OK
	DECLARE @tabla_Retirada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Retirada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 12
	
	DECLARE @tabla_Reingresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Reingresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 18
	
	DECLARE @tabla_Egresada TABLE (Codigo VARCHAR(100) )
	INSERT INTO @tabla_Egresada
	SELECT Codigo FROM TablaLogicaDatos WHERE TablaLogicaID = 19

    IF @Usuario IS NOT NULL AND @Usuario <> ''
    BEGIN
        IF @RolID != 0
        BEGIN
            IF @AutorizaPedido IS NOT NULL AND @AutorizaPedido <> ''
            BEGIN
                IF @IdEstadoActividad <> -1
                BEGIN
                    -- Validamos si pertenece a Peru, Bolivia, Chile, Guatemala, El Salvador, Colombia (Paises ESIKA)
                    IF @paisID = 11 OR @paisID = 2 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                    BEGIN
                        --Validamos si el estado es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 4
                            BEGIN
                                --Caso Colombia
								IF @paisID = 4
								BEGIN
                                    SET @Resultado =  2
                                END
								ELSE
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                            END
                            ELSE
                            BEGIN
                                --Para bolivia (FOX) se hace la validación del campo AutorizaPedido
                                IF @paisID = 2
                                BEGIN
                                    IF @AutorizaPedido = 'N'
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                BEGIN
                                    SET @Resultado =  3
                                END
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es reingresada
                            IF EXISTS(SELECT 1 FROM @tabla_Reingresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
                                IF @paisID = 3
                                BEGIN
                                    --Se valida las campañas que no ha ingresado
									DECLARE @CampaniasSinIngresar INT = 0;
                                    IF LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampania) = 6
                                    BEGIN
										set @CampaniasSinIngresar = @CampaniaActual - dbo.fnAddCampaniaAndNumero(null,@UltimaCampania,3);
                                    END

                                    IF @CampaniasSinIngresar > 0
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        --Validamos el Autoriza Pedido
                                        IF @AutorizaPedido = 'N'
                                            SET @Resultado =  2
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                                ELSE
                                BEGIN
                                    --Caso Colombia
                                    IF @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                    BEGIN
                                        IF @AutorizaPedido = 'N'
                                        BEGIN
                                            --Validamos si es SICC o Bolivia
                                            IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2
                                                SET @Resultado =  2
                                            ELSE
                                                SET @Resultado =  3
                                        END
                                        ELSE
                                            SET @Resultado =  3
                                    END
                                END
                            END
                            ELSE
                            BEGIN
                                --Caso Colombia
                                IF @paisID = 4
                                BEGIN
                                    --Egresada o Posible Egreso
                                    IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                                    BEGIN
                                        SET @Resultado =  2
                                    END
                                END

                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC o Bolivia
                                    IF @paisID = 11 OR @paisID = 3 OR @paisID = 8 OR @paisID = 7 OR @paisID = 2 OR @paisID = 4
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3

                            END
                        END
                    END
                    -- Validamos si pertenece a Costa Rica, Panama, Mexico, Puerto Rico, Dominicana, Ecuador, Argentina (Paises MyLbel)
                    ELSE IF @paisID = 5 OR @paisID = 10 OR @paisID = 9 OR @paisID = 12 OR @paisID = 13 OR @paisID = 6 OR @paisID = 1 OR @paisID = 14
                    BEGIN
                        -- Validamos si la consultora es retirada
                        IF EXISTS(SELECT 1 FROM @tabla_Retirada WHERE Codigo = @IdEstadoActividad)
                        BEGIN
                            --Validamos si el pais es SICC
                            IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                    SET @Resultado =  2
                                ELSE
                                    SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    SET @Resultado =  2
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                        ELSE
                        BEGIN
                            --Validamos si el estado es retirada
                            IF EXISTS(SELECT 1 FROM @tabla_Egresada WHERE Codigo = @IdEstadoActividad)
                            BEGIN
								IF @AutorizaPedido = 'N'
								BEGIN
									--Validamos si es SICC
									IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
										SET @Resultado =  2
									ELSE
										SET @Resultado =  3
								END
								ELSE
									SET @Resultado =  3
                            END
                            ELSE
                            BEGIN
                                --Validamos el Autoriza Pedido
                                IF @AutorizaPedido = 'N'
                                BEGIN
                                    --Validamos si es SICC
                                    IF @paisID = 5 OR @paisID = 10 OR @paisID = 6 OR @paisID = 14
                                        SET @Resultado =  2
                                    ELSE
                                        SET @Resultado =  3
                                END
                                ELSE
                                    SET @Resultado =  3
                            END
                        END
                    END
                    ELSE
                        SET @Resultado = 3
                END
                ELSE
                    SET @Resultado = 3 --Se asume para usuarios del tipo SAC
            END
            ELSE
                SET @Resultado = 3 --Se asume para usuarios del tipo SAC
        END
        ELSE
            SET @Resultado = 1
    END
    ELSE
        SET @Resultado = 0

    RETURN @Resultado

END
GO
ALTER PROCEDURE dbo.GetSesionUsuario_SB2
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	
	DECLARE @FechaLimitePago SMALLDATETIME
	DECLARE @ODSCampaniaID INT
	
	declare @PaisID int
	declare @UsuarioPrueba bit
	declare @CodConsultora varchar(20)
	declare @CampaniaID int
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint
	declare @UltimaCampanaFacturada int
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario

	declare @CountCodigoNivel bigint

	/*Oferta Final, Catalogo Personalizado, CDR*/
	declare @EsOfertaFinalZonaValida bit = 0
	declare @EsOFGanaMasZonaValida bit = 0
	declare @EsCatalogoPersonalizadoZonaValida bit = 0
	declare @EsCDRWebZonaValida  bit = 0
	declare @CodigoZona varchar(4) = ''
	declare @CodigoRegion varchar(2) = ''

	select
		@CodigoZona = IsNull(z.Codigo,''),
		@CodigoRegion = IsNull(r.Codigo,'')
	from ods.consultora c with(nolock)
	inner join ods.Region r on
		c.RegionID = r.RegionID
	inner join ods.Zona z on
		c.ZonaID = z.ZonaID
	where c.codigo = @CodConsultora

	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
		
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/

	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;
	
	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919

	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0

		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;

		/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,-11), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
		)

		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			isnull(c.EsJoven,0) EsJoven,
			(case
				when @CountCodigoNivel =0 then 0  --1589
				when @CountCodigoNivel>0 then 1 End) Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			null as ConsultoraAsociada, --1688
			isnull(si.descripcion,null) SegmentoConstancia, --2469
			isnull(se.Codigo,null) Seccion, --2469
			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469
			case When cl.ConsultoraID is null then 0
				else 1 end esConsultoraLider,
			u.EMailActivo, --2532
			si.SegmentoInternoId,
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u with(nolock)
		LEFT JOIN (
			select *
			from ods.consultora with(nolock)
			where ConsultoraId = @ConsultoraID
		) c ON u.CodigoConsultora = c.Codigo
		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID
		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469
		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469
		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t with(nolock) ON 
			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		SELECT
			u.PaisID,
			p.CodigoISO,
			c.RegionID,
			r.Codigo AS CodigorRegion,
			ISNULL(c.ZonaID,0) AS ZonaID,
			ISNULL(z.Codigo,'') AS CodigoZona,
			c.ConsultoraID,
			u.CodigoUsuario,
			u.CodigoConsultora,
			u.Nombre AS NombreCompleto,
			ISNULL(ur.RolID,0) AS RolID,
			u.EMail,
			p.Simbolo,
			c.TerritorioID,
			t.Codigo AS CodigoTerritorio,
			c.MontoMinimoPedido,
			c.MontoMaximoPedido,
			p.CodigoFuente,
			p.BanderaImagen,
			p.Nombre as NombrePais,
			u.CambioClave,
			u.Telefono,
			u.TelefonoTrabajo,
			u.Celular,
			ISNULL(s.descripcion,'') as Segmento,
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,
			u.UsuarioPrueba,
			ISNULL(u.Sobrenombre,'') as Sobrenombre,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,
			ISNULL(@TipoOferta2,0) as TipoOferta2,
			1 as CompraKitDupla,
			1 as CompraOfertaDupla,
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,
			0 as ProgramaReconocimiento,
			ISNULL(s.segmentoid, 0) as segmentoid,
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,
			'' as Nivel,
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,
			ISNULL(c.PrimerNombre,'') as PrimerNombre,
			ISNULL(c.PrimerApellido,'') as PrimerApellido,
			u.MostrarAyudaWebTraking,
			ro.Descripcion as RolDescripcion,
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,
			@FechaLimitePago as FechaLimitePago,
			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,
			ISNULL(u.VioVideo, 0) as VioVideo,
			ISNULL(u.VioTutorial, 0) as VioTutorial,
			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,
			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,
			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,
			ISNULL(p.TieneHana,0) as TieneHana,
			z.GerenteZona,
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeo
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@MarcaId int,
	@tipoFiltroUbigeo int
)    
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;
	
	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
	
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';
	
	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1,''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2,''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3,'')
	FROM Ubigeo U with(nolock)
	WHERE codigoubigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		--ISNULL((select top 1 campaniaId from dbo.GetCampaniaPreLogin(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID)),0) as CampaniaActual,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND (@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite) AND
		UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.CampaniaId, -2)
	ORDER BY C.UltimaCampanaFacturada DESC, C.MontoUltimoPedido DESC
END
GO
ALTER PROCEDURE dbo.GetConsultorasCatalogosPorUbigeoAndNombresAndApellidos
(
	@PaisId int,
	@CodigoUbigeo varchar(24),
	@Nombres varchar(51),
	@Apellidos varchar(51),
	@MarcaId int,
	@tipoFiltroUbigeo int
)
AS
BEGIN
	DECLARE @EdadLimite INT;
	SELECT @EdadLimite = Codigo
	FROM TABLALOGICADATOS with(nolock)
	WHERE TABLALOGICADATOSID = 5605;

	DECLARE @AnioLimite INT = YEAR(getdate()) - @EdadLimite;
 
	DECLARE @UnidadGeografica1 VARCHAR(100) = '';
	DECLARE @UnidadGeografica2 VARCHAR(100) = '';
	DECLARE @UnidadGeografica3 VARCHAR(100) = '';

	SELECT
		@UnidadGeografica1 = ISNULL(UnidadGeografica1, ''),
		@UnidadGeografica2 = ISNULL(UnidadGeografica2, ''),
		@UnidadGeografica3 = ISNULL(UnidadGeografica3, '')
	FROM Ubigeo with(nolock)
	WHERE CodigoUbigeo = @CodigoUbigeo;
	
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	SELECT
		C.Codigo AS CodigoConsultora,
		C.ConsultoraID AS IdConsultora,
		C.NombreCompleto,
		C.IdEstadoActividad As IdEstadoActividad,
		C.ZonaID,
		U.Email AS Correo,
		U.Celular,
		U.CodigoUsuario,
		Z.Codigo AS CodigoZona,
		R.Codigo AS CodigoRegion,
		S.Codigo AS CodigoSeccion,
		CC.FechaInicioFacturacion,
		CC.CampaniaID AS CampaniaActual,
		CC.HoraCierreZonaNormal AS HoraCierre,
		ISNULL(UR.RolId,0) as RolId,
		ISNULL(C.IdEstadoActividad,-1) as IdEstadoActividad,
		'S' as AutorizaPedido, -- when '1' then 'S'
		ACC.EsAfiliado,
		ISNULL(C.UltimaCampanaFacturada,0) as UltimaCampania,
		@CodigoUbigeo as Ubigeo,
		@UnidadGeografica1 AS UnidadGeografica1,
		@UnidadGeografica2 AS UnidadGeografica2,
		@UnidadGeografica3 AS UnidadGeografica3,
		CC.ID AS CampaniaActualID
	FROM ods.consultora C with(nolock)
	INNER JOIN dbo.AfiliaClienteConsultora ACC with(nolock) on C.ConsultoraID = ACC.ConsultoraID AND ACC.EsAfiliado = 1
	INNER JOIN ods.Zona Z with(nolock) ON C.ZonaID = Z.ZonaID AND Z.EstadoActivo = 1
	INNER JOIN ods.Region R with(nolock) ON C.RegionID = R.RegionID AND R.EstadoActivo = 1
	INNER JOIN ods.Seccion S with(nolock) ON C.SeccionID = S.SeccionID AND S.EstadoActivo = 1
	INNER JOIN usuario U with(nolock) ON C.Codigo = U.CodigoConsultora
	LEFT JOIN UsuarioRol UR with(nolock) on U.CodigoUsuario = UR.CodigoUsuario
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,C.ZonaID,C.RegionID,C.ConsultoraID) CC
	WHERE
		C.TerritorioID IN (SELECT TerritorioID FROM @TerritorioObjetivo) AND
		C.AutorizaPedido = '1' AND
		CONCAT(PrimerNombre,' ',SegundoNombre) LIKE CONCAT('%',@Nombres,'%') AND
		CONCAT(PrimerApellido,' ',SegundoApellido) LIKE CONCAT('%',@Apellidos,'%') AND
		(@MarcaId <> 3 OR year(C.FechaNacimiento) > @AnioLimite);
END
GO
ALTER PROCEDURE dbo.GetConsultorasPorUbigeo
	@PaisId int,    
	@CodigoUbigeo varchar(24),    
	@Campania int,    
	@MarcaId int,
	@tipoFiltroUbigeo int
AS    
BEGIN
	DECLARE @TerritorioObjetivo TABLE (TerritorioID INT);
	INSERT INTO @TerritorioObjetivo
	SELECT TerritorioID from dbo.fnGetTableTerritorioIdByFiltroAndUbigeo(@tipoFiltroUbigeo,@CodigoUbigeo);
	
	CREATE TABLE #TempConsultoraUbigeo    
	(    
		ID int IDENTITY,    
		ConsultoraID bigint,    
		Codigo varchar(100),    
		CodigoUbigeo varchar(24),    
		NombreCompletoConsultora varchar(300),    
		Email varchar(200),      
		FechaNacimiento datetime,    
		MONTOULTIMOPEDIDO MONEY,    
		UltimaCampanaFacturada INT,     
		CodigoUsuario varchar(100),    
		ZonaID int,    
		RegionID int  
	)

	INSERT INTO #TempConsultoraUbigeo  
    SELECT DISTINCT
		C.ConsultoraID,    
		C.Codigo,
		@CodigoUbigeo as CodigoUbigeo,
		C.NombreCompleto as NombreCompletoConsultora,
		U.Email,
		FechaNacimiento,
		MONTOULTIMOPEDIDO,
		UltimaCampanaFacturada,
		u.CodigoUsuario,
		c.ZonaID,
		c.RegionID    
    FROM ods.CONSULTORA AS C  
    INNER JOIN AFILIACLIENTECONSULTORA AS ACC ON C.CONSULTORAID = ACC.CONSULTORAID  
    INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo   
    WHERE ACC.EsAfiliado = 1 AND C.TERRITORIOID IN (SELECT TerritorioID FROM @TerritorioObjetivo);
		
    IF @MarcaId = 3    
    BEGIN
		DECLARE @EDADLIMITE INT = (SELECT Codigo FROM TABLALOGICADATOS WHERE TABLALOGICAID = 56 AND TABLALOGICADATOSID = 5605);

		DELETE FROM #TempConsultoraUbigeo 
		WHERE ID IN(  
			SELECT ID
			FROM #TempConsultoraUbigeo  
			WHERE (YEAR(getdate()) - year(FechaNacimiento)) >= @EDADLIMITE
		);
    END  
  
   -- -- FILTRANDO CONSULTORAS QUE HAYAN FACTURADO EN LA CAMPAÑANA ANTERIOR  
    --R2442 -  JC - Ya no filtrará por Campaña actual  
    SELECT TCU.ConsultoraID, TCU.Codigo, TCU.CodigoUbigeo, TCU.NombreCompletoConsultora as NombreCompleto, TCU.Email
    FROM #TempConsultoraUbigeo TCU
	CROSS APPLY dbo.fnGetConfiguracionCampania(@PaisId,TCU.ZonaID,TCU.RegionID,TCU.ConsultoraID) CC
    WHERE
		dbo.ValidarAutorizacion(@PaisId, TCU.CodigoUsuario) = 3 AND
		TCU.UltimaCampanaFacturada >= dbo.fnAddCampaniaAndNumero(null, CC.campaniaId, -2)
	order by ULTIMACAMPANAFACTURADA DESC , MONTOULTIMOPEDIDO DESC --R2626 
	
	DROP TABLE #TempConsultoraUbigeo;
END
GO
ALTER PROCEDURE GetProductosOfertaConsultoraNueva
	@CampaniaID INT,
	@ConsultoraID INT
AS
BEGIN
	DECLARE @NroCampania INT = (SELECT TOP 1 nrocampanias FROM pais with(nolock) WHERE EstadoActivo = 1);

	DECLARE @ultimacampaniafacturable INT;
	DECLARE @idcampaniaingreso INT;
	SELECT
		@idcampaniaingreso = AnoCampanaIngreso,
		@ultimacampaniafacturable = isnull(iif(TipoFacturacion = 'FA', UltimaCampanaFacturada, dbo.fnAddCampaniaAndNumero(UltimaCampanaFacturada,-1,@NroCampania)),0)
	FROM ods.Consultora WHERE ConsultoraID=@ConsultoraID;
		
	DECLARE @campaniafacturableingreso INT = @ultimacampaniafacturable - @idcampaniaingreso;
	DECLARE @campaniacompare INT = dbo.fnAddCampaniaAndNumero2(@ultimacampaniafacturable,1,@NroCampania);
	DECLARE @NumeroPedido INT;	
	DECLARE @indicador INT = 0;

	if @CampaniaID = @campaniacompare and (@campaniafacturableingreso between 0 and 3)
	begin		
		declare @CampaniaID1 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -1, @NroCampania);
		declare @CampaniaID2 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -2, @NroCampania);
		declare @CampaniaID3 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -3, @NroCampania);
		declare @CampaniaID4 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -4, @NroCampania);

		declare @idCampaniaID1 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID1);
		declare @idCampaniaID2 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID2);
		declare @idCampaniaID3 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID3);
		declare @idCampaniaID4 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID4);

		declare @campaniasFacturas int;

		---la consultora es nueva, esta realizando su segundo pedido compruebo que la campaña anterior tenga pedido facturado
		if @campaniafacturableingreso = 0
		begin
			set @NumeroPedido = 1;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1) and consultoraid = @ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 1, 1,0);
		end
		---la consultora es nueva, esta realizando su tercer pedido compruebo que las 2 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 1
		begin
			set @NumeroPedido=2;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 2, 1,0);
		end
		---la consultora es nueva, esta realizando su cuarto pedido compruebo que las 3 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 2
		begin
			set @NumeroPedido=3;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 3, 1,0);
		end
		---la consultora es nueva, esta realizando su quINTo pedido compruebo que las 4 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 3
		begin
			set @NumeroPedido=4;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido (nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3,@idCampaniaID4) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 4, 1,0);
		end
	end

	IF @indicador = 1 and (@campaniafacturableingreso between 0 and 3)
	begin
		SELECT TOP 4
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			MarcaID,
			IndicadorMontoMinimo,
			DescripcionProd,
			UnidadesPermitidas,
			(case when len(IndicadorPedido) >0 then 1 else 0 end) IndicadorPedido,
			ganahasta
		FROM (
			SELECT
				og.OfertaNuevaId,
				og.NumeroPedido,
				case isnull(og.FlagImagenActiva,0)
					when 1 then og.ImagenProducto01
					when 2 then og.ImagenProducto02
					when 3 then og.ImagenProducto03
					else ''
				end ImagenProducto01,
				og.Descripcion,
				og.CUV,
				og.PrecioNormal,
				og.PrecioParaTi,
				pc.MarcaID,
				pc.IndicadorMontoMinimo,
				coalesce(pd.Descripcion, pc.Descripcion) DescripcionProd,
				dbo.fnObtenerCantidadOfertaNueva(og.CUV, og.CampaniaID, og.UnidadesPermitidas,og.TipoOfertaSisID, og.ConfiguracionOfertaID) UnidadesPermitidas,
				isnull(pwd.CUV,'') IndicadorPedido,
				isnull(og.ganahasta, 0) ganahasta
			FROM dbo.OfertaNueva  og with(nolock)
			inner join ods.ProductoComercial pc with(nolock) on og.CUV = pc.CUV and og.CampaniaID = pc.AnoCampania
			inner join ods.Campania ca with(nolock) on pc.CampaniaID = ca.CampaniaID
			left join dbo.ProductoDescripcion pd with(nolock) on og.CampaniaID = pd.CampaniaID and og.CUV = pd.CUV
			left join PedidoWebDetalle pwd with(nolock) on pwd.CUV=og.CUV and pwd.CampaniaID= @CampaniaID and pwd.ConsultoraID=@ConsultoraID
			WHERE
				ca.CodiGO = @CampaniaID and
				og.FlagHabilitarOferta = 1 and
				og.NumeroPedido=@NumeroPedido and
				og.CUV not in(SELECT CUV FROM PedidoWebDetalle with(nolock) WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID)
		) a
		WHERE a.UnidadesPermitidas > 0
		order by 5 asc
	end
	else
	begin
		SELECT
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			'' MarcaID,
			'' IndicadorMontoMinimo,
			'' DescripcionProd,
			UnidadesPermitidas,
			0 IndicadorPedido,
			0 ganahasta
		FROM OfertaNueva with(nolock)
		WHERE OfertaNuevaID < 0
		order by 5 asc
	end
END
GO