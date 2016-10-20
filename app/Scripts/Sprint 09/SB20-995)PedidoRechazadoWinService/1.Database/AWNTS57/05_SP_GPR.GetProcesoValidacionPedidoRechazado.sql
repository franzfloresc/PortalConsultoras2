USE BelcorpBolivia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
END
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
/*end*/

USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
END
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
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
END
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
/*end*/

USE BelcorpDominicana
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
END
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
/*end*/

USE BelcorpEcuador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
END
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
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
END
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
/*end*/

USE BelcorpPanama
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
END
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
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
END
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
/*end*/

USE BelcorpSalvador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
END
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
/*end*/

USE BelcorpVenezuela
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
END
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