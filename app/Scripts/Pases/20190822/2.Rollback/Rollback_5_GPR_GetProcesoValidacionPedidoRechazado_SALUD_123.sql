USE BelcorpBolivia
GO
IF OBJECT_ID('GPR.GetProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
GO
CREATE PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
	@CodigoProceso varchar(20)
AS
BEGIN
	DECLARE @Activo bit;
	DECLARE @RestriccionEjecucion bit;
	DECLARE @HoraInicioRestriccion time;
	DECLARE @HoraFinRestriccion time;

	select
		@Activo = Activo,
		@RestriccionEjecucion = RestriccionEjecucion,
		@HoraInicioRestriccion = HoraInicioRestriccion,
		@HoraFinRestriccion = HoraFinRestriccion
	from GPR.ProcesoPedidoRechazadoConfiguracion
	where CodigoProceso = @CodigoProceso
	
	DECLARE @Valido int;
	IF ISNULL(@Activo,0) = 0
		SET @Valido = 0;
	ELSE IF ISNULL(@RestriccionEjecucion,0) = 0
		SET @Valido = 1;
	ELSE
	BEGIN
		DECLARE @HoraPais time = cast(dbo.fnObtenerFechaHoraPais() as time);
		IF (@HoraInicioRestriccion <= @HoraPais and @HoraPais <= @HoraFinRestriccion)
			SET @Valido = 1;
		ELSE
			SET @Valido = 0;
	END
	
	DECLARE @Estado int = NULL;
	IF (@Valido = 1)
	BEGIN
		select top 1 @Estado = Estado
		from GPR.ProcesoValidacionPedidoRechazado (nolock)
		where CodigoProceso = @CodigoProceso
		order by ProcesoValidacionPedidoRechazadoId desc;
	END
	ELSE
		set @Estado = -1;

	select ISNULL(@Estado,0) AS Estado;
END
GO

USE BelcorpChile
GO
IF OBJECT_ID('GPR.GetProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
GO
CREATE PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
	@CodigoProceso varchar(20)
AS
BEGIN
	DECLARE @Activo bit;
	DECLARE @RestriccionEjecucion bit;
	DECLARE @HoraInicioRestriccion time;
	DECLARE @HoraFinRestriccion time;

	select
		@Activo = Activo,
		@RestriccionEjecucion = RestriccionEjecucion,
		@HoraInicioRestriccion = HoraInicioRestriccion,
		@HoraFinRestriccion = HoraFinRestriccion
	from GPR.ProcesoPedidoRechazadoConfiguracion
	where CodigoProceso = @CodigoProceso
	
	DECLARE @Valido int;
	IF ISNULL(@Activo,0) = 0
		SET @Valido = 0;
	ELSE IF ISNULL(@RestriccionEjecucion,0) = 0
		SET @Valido = 1;
	ELSE
	BEGIN
		DECLARE @HoraPais time = cast(dbo.fnObtenerFechaHoraPais() as time);
		IF (@HoraInicioRestriccion <= @HoraPais and @HoraPais <= @HoraFinRestriccion)
			SET @Valido = 1;
		ELSE
			SET @Valido = 0;
	END
	
	DECLARE @Estado int = NULL;
	IF (@Valido = 1)
	BEGIN
		select top 1 @Estado = Estado
		from GPR.ProcesoValidacionPedidoRechazado (nolock)
		where CodigoProceso = @CodigoProceso
		order by ProcesoValidacionPedidoRechazadoId desc;
	END
	ELSE
		set @Estado = -1;

	select ISNULL(@Estado,0) AS Estado;
END
GO

USE BelcorpColombia
GO
IF OBJECT_ID('GPR.GetProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
GO
CREATE PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
	@CodigoProceso varchar(20)
AS
BEGIN
	DECLARE @Activo bit;
	DECLARE @RestriccionEjecucion bit;
	DECLARE @HoraInicioRestriccion time;
	DECLARE @HoraFinRestriccion time;

	select
		@Activo = Activo,
		@RestriccionEjecucion = RestriccionEjecucion,
		@HoraInicioRestriccion = HoraInicioRestriccion,
		@HoraFinRestriccion = HoraFinRestriccion
	from GPR.ProcesoPedidoRechazadoConfiguracion
	where CodigoProceso = @CodigoProceso
	
	DECLARE @Valido int;
	IF ISNULL(@Activo,0) = 0
		SET @Valido = 0;
	ELSE IF ISNULL(@RestriccionEjecucion,0) = 0
		SET @Valido = 1;
	ELSE
	BEGIN
		DECLARE @HoraPais time = cast(dbo.fnObtenerFechaHoraPais() as time);
		IF (@HoraInicioRestriccion <= @HoraPais and @HoraPais <= @HoraFinRestriccion)
			SET @Valido = 1;
		ELSE
			SET @Valido = 0;
	END
	
	DECLARE @Estado int = NULL;
	IF (@Valido = 1)
	BEGIN
		select top 1 @Estado = Estado
		from GPR.ProcesoValidacionPedidoRechazado (nolock)
		where CodigoProceso = @CodigoProceso
		order by ProcesoValidacionPedidoRechazadoId desc;
	END
	ELSE
		set @Estado = -1;

	select ISNULL(@Estado,0) AS Estado;
END
GO

USE BelcorpCostaRica
GO
IF OBJECT_ID('GPR.GetProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
GO
CREATE PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
	@CodigoProceso varchar(20)
AS
BEGIN
	DECLARE @Activo bit;
	DECLARE @RestriccionEjecucion bit;
	DECLARE @HoraInicioRestriccion time;
	DECLARE @HoraFinRestriccion time;

	select
		@Activo = Activo,
		@RestriccionEjecucion = RestriccionEjecucion,
		@HoraInicioRestriccion = HoraInicioRestriccion,
		@HoraFinRestriccion = HoraFinRestriccion
	from GPR.ProcesoPedidoRechazadoConfiguracion
	where CodigoProceso = @CodigoProceso
	
	DECLARE @Valido int;
	IF ISNULL(@Activo,0) = 0
		SET @Valido = 0;
	ELSE IF ISNULL(@RestriccionEjecucion,0) = 0
		SET @Valido = 1;
	ELSE
	BEGIN
		DECLARE @HoraPais time = cast(dbo.fnObtenerFechaHoraPais() as time);
		IF (@HoraInicioRestriccion <= @HoraPais and @HoraPais <= @HoraFinRestriccion)
			SET @Valido = 1;
		ELSE
			SET @Valido = 0;
	END
	
	DECLARE @Estado int = NULL;
	IF (@Valido = 1)
	BEGIN
		select top 1 @Estado = Estado
		from GPR.ProcesoValidacionPedidoRechazado (nolock)
		where CodigoProceso = @CodigoProceso
		order by ProcesoValidacionPedidoRechazadoId desc;
	END
	ELSE
		set @Estado = -1;

	select ISNULL(@Estado,0) AS Estado;
END
GO

USE BelcorpDominicana
GO
IF OBJECT_ID('GPR.GetProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
GO
CREATE PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
	@CodigoProceso varchar(20)
AS
BEGIN
	DECLARE @Activo bit;
	DECLARE @RestriccionEjecucion bit;
	DECLARE @HoraInicioRestriccion time;
	DECLARE @HoraFinRestriccion time;

	select
		@Activo = Activo,
		@RestriccionEjecucion = RestriccionEjecucion,
		@HoraInicioRestriccion = HoraInicioRestriccion,
		@HoraFinRestriccion = HoraFinRestriccion
	from GPR.ProcesoPedidoRechazadoConfiguracion
	where CodigoProceso = @CodigoProceso
	
	DECLARE @Valido int;
	IF ISNULL(@Activo,0) = 0
		SET @Valido = 0;
	ELSE IF ISNULL(@RestriccionEjecucion,0) = 0
		SET @Valido = 1;
	ELSE
	BEGIN
		DECLARE @HoraPais time = cast(dbo.fnObtenerFechaHoraPais() as time);
		IF (@HoraInicioRestriccion <= @HoraPais and @HoraPais <= @HoraFinRestriccion)
			SET @Valido = 1;
		ELSE
			SET @Valido = 0;
	END
	
	DECLARE @Estado int = NULL;
	IF (@Valido = 1)
	BEGIN
		select top 1 @Estado = Estado
		from GPR.ProcesoValidacionPedidoRechazado (nolock)
		where CodigoProceso = @CodigoProceso
		order by ProcesoValidacionPedidoRechazadoId desc;
	END
	ELSE
		set @Estado = -1;

	select ISNULL(@Estado,0) AS Estado;
END
GO

USE BelcorpEcuador
GO
IF OBJECT_ID('GPR.GetProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
GO
CREATE PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
	@CodigoProceso varchar(20)
AS
BEGIN
	DECLARE @Activo bit;
	DECLARE @RestriccionEjecucion bit;
	DECLARE @HoraInicioRestriccion time;
	DECLARE @HoraFinRestriccion time;

	select
		@Activo = Activo,
		@RestriccionEjecucion = RestriccionEjecucion,
		@HoraInicioRestriccion = HoraInicioRestriccion,
		@HoraFinRestriccion = HoraFinRestriccion
	from GPR.ProcesoPedidoRechazadoConfiguracion
	where CodigoProceso = @CodigoProceso
	
	DECLARE @Valido int;
	IF ISNULL(@Activo,0) = 0
		SET @Valido = 0;
	ELSE IF ISNULL(@RestriccionEjecucion,0) = 0
		SET @Valido = 1;
	ELSE
	BEGIN
		DECLARE @HoraPais time = cast(dbo.fnObtenerFechaHoraPais() as time);
		IF (@HoraInicioRestriccion <= @HoraPais and @HoraPais <= @HoraFinRestriccion)
			SET @Valido = 1;
		ELSE
			SET @Valido = 0;
	END
	
	DECLARE @Estado int = NULL;
	IF (@Valido = 1)
	BEGIN
		select top 1 @Estado = Estado
		from GPR.ProcesoValidacionPedidoRechazado (nolock)
		where CodigoProceso = @CodigoProceso
		order by ProcesoValidacionPedidoRechazadoId desc;
	END
	ELSE
		set @Estado = -1;

	select ISNULL(@Estado,0) AS Estado;
END
GO

USE BelcorpGuatemala
GO
IF OBJECT_ID('GPR.GetProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
GO
CREATE PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
	@CodigoProceso varchar(20)
AS
BEGIN
	DECLARE @Activo bit;
	DECLARE @RestriccionEjecucion bit;
	DECLARE @HoraInicioRestriccion time;
	DECLARE @HoraFinRestriccion time;

	select
		@Activo = Activo,
		@RestriccionEjecucion = RestriccionEjecucion,
		@HoraInicioRestriccion = HoraInicioRestriccion,
		@HoraFinRestriccion = HoraFinRestriccion
	from GPR.ProcesoPedidoRechazadoConfiguracion
	where CodigoProceso = @CodigoProceso
	
	DECLARE @Valido int;
	IF ISNULL(@Activo,0) = 0
		SET @Valido = 0;
	ELSE IF ISNULL(@RestriccionEjecucion,0) = 0
		SET @Valido = 1;
	ELSE
	BEGIN
		DECLARE @HoraPais time = cast(dbo.fnObtenerFechaHoraPais() as time);
		IF (@HoraInicioRestriccion <= @HoraPais and @HoraPais <= @HoraFinRestriccion)
			SET @Valido = 1;
		ELSE
			SET @Valido = 0;
	END
	
	DECLARE @Estado int = NULL;
	IF (@Valido = 1)
	BEGIN
		select top 1 @Estado = Estado
		from GPR.ProcesoValidacionPedidoRechazado (nolock)
		where CodigoProceso = @CodigoProceso
		order by ProcesoValidacionPedidoRechazadoId desc;
	END
	ELSE
		set @Estado = -1;

	select ISNULL(@Estado,0) AS Estado;
END
GO

USE BelcorpMexico
GO
IF OBJECT_ID('GPR.GetProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
GO
CREATE PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
	@CodigoProceso varchar(20)
AS
BEGIN
	DECLARE @Activo bit;
	DECLARE @RestriccionEjecucion bit;
	DECLARE @HoraInicioRestriccion time;
	DECLARE @HoraFinRestriccion time;

	select
		@Activo = Activo,
		@RestriccionEjecucion = RestriccionEjecucion,
		@HoraInicioRestriccion = HoraInicioRestriccion,
		@HoraFinRestriccion = HoraFinRestriccion
	from GPR.ProcesoPedidoRechazadoConfiguracion
	where CodigoProceso = @CodigoProceso
	
	DECLARE @Valido int;
	IF ISNULL(@Activo,0) = 0
		SET @Valido = 0;
	ELSE IF ISNULL(@RestriccionEjecucion,0) = 0
		SET @Valido = 1;
	ELSE
	BEGIN
		DECLARE @HoraPais time = cast(dbo.fnObtenerFechaHoraPais() as time);
		IF (@HoraInicioRestriccion <= @HoraPais and @HoraPais <= @HoraFinRestriccion)
			SET @Valido = 1;
		ELSE
			SET @Valido = 0;
	END
	
	DECLARE @Estado int = NULL;
	IF (@Valido = 1)
	BEGIN
		select top 1 @Estado = Estado
		from GPR.ProcesoValidacionPedidoRechazado (nolock)
		where CodigoProceso = @CodigoProceso
		order by ProcesoValidacionPedidoRechazadoId desc;
	END
	ELSE
		set @Estado = -1;

	select ISNULL(@Estado,0) AS Estado;
END
GO

USE BelcorpPanama
GO
IF OBJECT_ID('GPR.GetProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
GO
CREATE PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
	@CodigoProceso varchar(20)
AS
BEGIN
	DECLARE @Activo bit;
	DECLARE @RestriccionEjecucion bit;
	DECLARE @HoraInicioRestriccion time;
	DECLARE @HoraFinRestriccion time;

	select
		@Activo = Activo,
		@RestriccionEjecucion = RestriccionEjecucion,
		@HoraInicioRestriccion = HoraInicioRestriccion,
		@HoraFinRestriccion = HoraFinRestriccion
	from GPR.ProcesoPedidoRechazadoConfiguracion
	where CodigoProceso = @CodigoProceso
	
	DECLARE @Valido int;
	IF ISNULL(@Activo,0) = 0
		SET @Valido = 0;
	ELSE IF ISNULL(@RestriccionEjecucion,0) = 0
		SET @Valido = 1;
	ELSE
	BEGIN
		DECLARE @HoraPais time = cast(dbo.fnObtenerFechaHoraPais() as time);
		IF (@HoraInicioRestriccion <= @HoraPais and @HoraPais <= @HoraFinRestriccion)
			SET @Valido = 1;
		ELSE
			SET @Valido = 0;
	END
	
	DECLARE @Estado int = NULL;
	IF (@Valido = 1)
	BEGIN
		select top 1 @Estado = Estado
		from GPR.ProcesoValidacionPedidoRechazado (nolock)
		where CodigoProceso = @CodigoProceso
		order by ProcesoValidacionPedidoRechazadoId desc;
	END
	ELSE
		set @Estado = -1;

	select ISNULL(@Estado,0) AS Estado;
END
GO

USE BelcorpPeru
GO
IF OBJECT_ID('GPR.GetProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
GO
CREATE PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
	@CodigoProceso varchar(20)
AS
BEGIN
	DECLARE @Activo bit;
	DECLARE @RestriccionEjecucion bit;
	DECLARE @HoraInicioRestriccion time;
	DECLARE @HoraFinRestriccion time;

	select
		@Activo = Activo,
		@RestriccionEjecucion = RestriccionEjecucion,
		@HoraInicioRestriccion = HoraInicioRestriccion,
		@HoraFinRestriccion = HoraFinRestriccion
	from GPR.ProcesoPedidoRechazadoConfiguracion
	where CodigoProceso = @CodigoProceso
	
	DECLARE @Valido int;
	IF ISNULL(@Activo,0) = 0
		SET @Valido = 0;
	ELSE IF ISNULL(@RestriccionEjecucion,0) = 0
		SET @Valido = 1;
	ELSE
	BEGIN
		DECLARE @HoraPais time = cast(dbo.fnObtenerFechaHoraPais() as time);
		IF (@HoraInicioRestriccion <= @HoraPais and @HoraPais <= @HoraFinRestriccion)
			SET @Valido = 1;
		ELSE
			SET @Valido = 0;
	END
	
	DECLARE @Estado int = NULL;
	IF (@Valido = 1)
	BEGIN
		select top 1 @Estado = Estado
		from GPR.ProcesoValidacionPedidoRechazado (nolock)
		where CodigoProceso = @CodigoProceso
		order by ProcesoValidacionPedidoRechazadoId desc;
	END
	ELSE
		set @Estado = -1;

	select ISNULL(@Estado,0) AS Estado;
END
GO

USE BelcorpPuertoRico
GO
IF OBJECT_ID('GPR.GetProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
GO
CREATE PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
	@CodigoProceso varchar(20)
AS
BEGIN
	DECLARE @Activo bit;
	DECLARE @RestriccionEjecucion bit;
	DECLARE @HoraInicioRestriccion time;
	DECLARE @HoraFinRestriccion time;

	select
		@Activo = Activo,
		@RestriccionEjecucion = RestriccionEjecucion,
		@HoraInicioRestriccion = HoraInicioRestriccion,
		@HoraFinRestriccion = HoraFinRestriccion
	from GPR.ProcesoPedidoRechazadoConfiguracion
	where CodigoProceso = @CodigoProceso
	
	DECLARE @Valido int;
	IF ISNULL(@Activo,0) = 0
		SET @Valido = 0;
	ELSE IF ISNULL(@RestriccionEjecucion,0) = 0
		SET @Valido = 1;
	ELSE
	BEGIN
		DECLARE @HoraPais time = cast(dbo.fnObtenerFechaHoraPais() as time);
		IF (@HoraInicioRestriccion <= @HoraPais and @HoraPais <= @HoraFinRestriccion)
			SET @Valido = 1;
		ELSE
			SET @Valido = 0;
	END
	
	DECLARE @Estado int = NULL;
	IF (@Valido = 1)
	BEGIN
		select top 1 @Estado = Estado
		from GPR.ProcesoValidacionPedidoRechazado (nolock)
		where CodigoProceso = @CodigoProceso
		order by ProcesoValidacionPedidoRechazadoId desc;
	END
	ELSE
		set @Estado = -1;

	select ISNULL(@Estado,0) AS Estado;
END
GO

USE BelcorpSalvador
GO
IF OBJECT_ID('GPR.GetProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
GO
CREATE PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
	@CodigoProceso varchar(20)
AS
BEGIN
	DECLARE @Activo bit;
	DECLARE @RestriccionEjecucion bit;
	DECLARE @HoraInicioRestriccion time;
	DECLARE @HoraFinRestriccion time;

	select
		@Activo = Activo,
		@RestriccionEjecucion = RestriccionEjecucion,
		@HoraInicioRestriccion = HoraInicioRestriccion,
		@HoraFinRestriccion = HoraFinRestriccion
	from GPR.ProcesoPedidoRechazadoConfiguracion
	where CodigoProceso = @CodigoProceso
	
	DECLARE @Valido int;
	IF ISNULL(@Activo,0) = 0
		SET @Valido = 0;
	ELSE IF ISNULL(@RestriccionEjecucion,0) = 0
		SET @Valido = 1;
	ELSE
	BEGIN
		DECLARE @HoraPais time = cast(dbo.fnObtenerFechaHoraPais() as time);
		IF (@HoraInicioRestriccion <= @HoraPais and @HoraPais <= @HoraFinRestriccion)
			SET @Valido = 1;
		ELSE
			SET @Valido = 0;
	END
	
	DECLARE @Estado int = NULL;
	IF (@Valido = 1)
	BEGIN
		select top 1 @Estado = Estado
		from GPR.ProcesoValidacionPedidoRechazado (nolock)
		where CodigoProceso = @CodigoProceso
		order by ProcesoValidacionPedidoRechazadoId desc;
	END
	ELSE
		set @Estado = -1;

	select ISNULL(@Estado,0) AS Estado;
END
GO