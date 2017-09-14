USE [BelcorpBolivia]
GO
CREATE PROCEDURE [dbo].[GetNotificacionesSinLeer]
@ConsultoraId bigint,
@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		FechaHoraValidación datetime
	);

	insert into @Temporal
	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación
	from SolicitudCliente
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C')) and Leido = 0

	UNION ALL

	SELECT ProcesoId, FechaHoraValidación 
	FROM
	(SELECT
		LGPRV.LogGPRValidacionId AS ProcesoId,
		LGPRV.FechaFinValidacion AS FechaHoraValidación,
		row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
	FROM GPR.LogGPRValidacion LGPRV
	WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId AND LGPRV.Visualizado = 0)
	as rows 
	where row_number = 1
	
	IF(@ShowCDR = 1)
	BEGIN
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId AND LCDRW.Visualizado = 0

		UNION ALL

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación
		FROM dbo.LogCDRWebCulminado LCDRWC WITH(NOLOCK)
		WHERE LCDRWC.ConsultoraId = @ConsultoraId AND LCDRWC.Visualizado = 0
	END

	SELECT COUNT(*) as Cantidad
	FROM (
		SELECT TOP 10 * FROM @Temporal t
		ORDER BY t.FechaHoraValidación DESC
	) AS p
END
GO



USE [BelcorpChile]
GO
CREATE PROCEDURE [dbo].[GetNotificacionesSinLeer]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		FechaHoraValidación datetime
	)

	insert into @Temporal
	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación
	from SolicitudCliente
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C')) and Leido = 0

	SELECT ProcesoId, FechaHoraValidación 
	FROM
	(SELECT
		LGPRV.LogGPRValidacionId AS ProcesoId,
		LGPRV.FechaFinValidacion AS FechaHoraValidación,
		row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
	FROM GPR.LogGPRValidacion LGPRV
	WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId AND LGPRV.Visualizado = 0)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId AND LCDRW.Visualizado = 0

		UNION ALL

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación
		FROM dbo.LogCDRWebCulminado LCDRWC WITH(NOLOCK)
		WHERE LCDRWC.ConsultoraId = @ConsultoraId AND LCDRWC.Visualizado = 0
		END

	SELECT COUNT(*) as Cantidad
	FROM (
		SELECT TOP 10 * FROM @Temporal t
		ORDER BY t.FechaHoraValidación DESC
	) AS p
END
GO


USE [BelcorpColombia]
GO
CREATE PROCEDURE [dbo].[GetNotificacionesSinLeer]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN

	declare @Temporal table
	(
		ProcesoId bigint,
		FechaHoraValidación datetime
	);

	insert into @Temporal
	select 
		ValAutomaticaPROLLogId as ProcesoId,
		FechaHoraValidación
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId and ISNULL(Visualizado,0) = 0

	UNION ALL

	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C')) and Leido = 0

	UNION ALL

	SELECT ProcesoId, FechaHoraValidación 
	FROM
	(SELECT
		LGPRV.LogGPRValidacionId AS ProcesoId,
		LGPRV.FechaFinValidacion AS FechaHoraValidación,
		row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
	FROM GPR.LogGPRValidacion LGPRV
	WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId AND LGPRV.Visualizado = 0)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN
		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId AND LCDRW.Visualizado = 0

		UNION ALL

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación
		FROM dbo.LogCDRWebCulminado LCDRWC WITH(NOLOCK)
		WHERE LCDRWC.ConsultoraId = @ConsultoraId AND LCDRWC.Visualizado = 0
	END

	SELECT COUNT(*) as Cantidad
	FROM (
		SELECT TOP 10 * FROM @Temporal t
		ORDER BY t.FechaHoraValidación DESC
	) AS p
END
GO


USE [BelcorpCostaRica]
GO
CREATE PROCEDURE [dbo].[GetNotificacionesSinLeer]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN

	declare @Temporal table
	(
		ProcesoId bigint,
		FechaHoraValidación datetime
	)

	insert into @Temporal
	select 
		ValAutomaticaPROLLogId as ProcesoId,
		FechaHoraValidación
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId and ISNULL(Visualizado,0) = 0

	UNION ALL

	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C')) and Leido = 0	 

	UNION ALL

	SELECT ProcesoId, FechaHoraValidación 
	FROM
	(SELECT
		LGPRV.LogGPRValidacionId AS ProcesoId,
		LGPRV.FechaFinValidacion AS FechaHoraValidación,
		row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
	FROM GPR.LogGPRValidacion LGPRV
	WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId AND LGPRV.Visualizado = 0)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN
		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId AND LCDRW.Visualizado = 0

		UNION ALL

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación
		FROM dbo.LogCDRWebCulminado LCDRWC WITH(NOLOCK)
		WHERE LCDRWC.ConsultoraId = @ConsultoraId AND LCDRWC.Visualizado = 0
	END

	SELECT COUNT(*) as Cantidad
	FROM (
		SELECT TOP 10 * FROM @Temporal t
		ORDER BY t.FechaHoraValidación DESC
	) AS p
END
GO


USE [BelcorpDominicana]
GO
CREATE PROCEDURE [dbo].[GetNotificacionesSinLeer]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN

	declare @Temporal table
	(
	ProcesoId bigint,
	FechaHoraValidación datetime
	);

	insert into @Temporal
		select 
			ValAutomaticaPROLLogId as ProcesoId,
			FechaHoraValidación
		from ValidacionAutomaticaPROLLog with(nolock)
		where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId and ISNULL(Visualizado,0) = 0

	UNION ALL

		select
			SolicitudClienteID as ProcesoId,
			FechaSolicitud as FechaHoraValidación
		from SolicitudCliente
		where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C')) and Leido = 0

	UNION ALL
		SELECT ProcesoId, FechaHoraValidación 
		FROM
		(SELECT
			LGPRV.LogGPRValidacionId AS ProcesoId,
			LGPRV.FechaFinValidacion AS FechaHoraValidación,
			row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
		FROM GPR.LogGPRValidacion LGPRV
		WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId AND LGPRV.Visualizado = 0)
		as rows 
		where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN
		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId AND LCDRW.Visualizado = 0

		UNION ALL

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación
		FROM dbo.LogCDRWebCulminado LCDRWC WITH(NOLOCK)
		WHERE LCDRWC.ConsultoraId = @ConsultoraId AND LCDRWC.Visualizado = 0
	END

	SELECT COUNT(*) as Cantidad
	FROM (
		SELECT TOP 10 * FROM @Temporal t
		ORDER BY t.FechaHoraValidación DESC
	) AS p
END
GO


USE [BelcorpEcuador]
GO
CREATE PROCEDURE [dbo].[GetNotificacionesSinLeer]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN

	declare @Temporal table
	(
		ProcesoId bigint,
		FechaHoraValidación datetime
	)

	insert into @Temporal
	select 
		ValAutomaticaPROLLogId as ProcesoId,
		FechaHoraValidación
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId and ISNULL(Visualizado,0) = 0

	UNION ALL

	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C')) and Leido = 0

	UNION ALL

	SELECT ProcesoId, FechaHoraValidación 
	FROM
	(SELECT
		LGPRV.LogGPRValidacionId AS ProcesoId,
		LGPRV.FechaFinValidacion AS FechaHoraValidación,
		row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
	FROM GPR.LogGPRValidacion LGPRV
	WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId AND LGPRV.Visualizado = 0)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId AND LCDRW.Visualizado = 0

		UNION ALL

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación
		FROM dbo.LogCDRWebCulminado LCDRWC WITH(NOLOCK)
		WHERE LCDRWC.ConsultoraId = @ConsultoraId AND LCDRWC.Visualizado = 0
	END

	SELECT COUNT(*) as Cantidad
	FROM (
		SELECT TOP 10 * FROM @Temporal t
		ORDER BY t.FechaHoraValidación DESC
	) AS p
END
GO



USE [BelcorpGuatemala]
GO
CREATE PROCEDURE [dbo].[GetNotificacionesSinLeer]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN

	declare @Temporal table
	(
		ProcesoId bigint,
		FechaHoraValidación datetime
	);

	insert into @Temporal
	select 
		ValAutomaticaPROLLogId as ProcesoId,
		FechaHoraValidación
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId and ISNULL(Visualizado,0) = 0

	UNION ALL

	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C')) and Leido = 0

	UNION ALL

	SELECT ProcesoId, FechaHoraValidación 
	FROM
	(SELECT
		LGPRV.LogGPRValidacionId AS ProcesoId,
		LGPRV.FechaFinValidacion AS FechaHoraValidación,
		row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
	FROM GPR.LogGPRValidacion LGPRV
	WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId AND LGPRV.Visualizado = 0)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN
		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId AND LCDRW.Visualizado = 0

		UNION ALL

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación
		FROM dbo.LogCDRWebCulminado LCDRWC WITH(NOLOCK)
		WHERE LCDRWC.ConsultoraId = @ConsultoraId AND LCDRWC.Visualizado = 0
	END

	SELECT COUNT(*) as Cantidad
	FROM (
		SELECT TOP 10 * FROM @Temporal t
		ORDER BY t.FechaHoraValidación DESC
	) AS p
END
GO


USE [BelcorpMexico]
GO
CREATE PROCEDURE [dbo].[GetNotificacionesSinLeer]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN

	declare @Temporal table
	(
		ProcesoId bigint,
		FechaHoraValidación datetime
	)

	insert into @Temporal
	select 
		ValAutomaticaPROLLogId as ProcesoId,
		FechaHoraValidación
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId and ISNULL(Visualizado,0) = 0

	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C')) and Leido = 0

	UNION ALL

	SELECT ProcesoId, FechaHoraValidación 
	FROM
	(SELECT
		LGPRV.LogGPRValidacionId AS ProcesoId,
		LGPRV.FechaFinValidacion AS FechaHoraValidación,
		row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
	FROM GPR.LogGPRValidacion LGPRV
	WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId AND LGPRV.Visualizado = 0)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN
		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId AND LCDRW.Visualizado = 0

		UNION ALL

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación
		FROM dbo.LogCDRWebCulminado LCDRWC WITH(NOLOCK)
		WHERE LCDRWC.ConsultoraId = @ConsultoraId AND LCDRWC.Visualizado = 0
	END	

	SELECT COUNT(*) as Cantidad
	FROM (
		SELECT TOP 10 * FROM @Temporal t
		ORDER BY t.FechaHoraValidación DESC
	) AS p
END
GO



USE [BelcorpPanama]
GO
CREATE PROCEDURE [dbo].[GetNotificacionesSinLeer]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		FechaHoraValidación datetime
	);

	insert into @Temporal
	select 
		ValAutomaticaPROLLogId as ProcesoId,
		FechaHoraValidación
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId and ISNULL(Visualizado,0) = 0


	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C')) and Leido = 0

	UNION ALL

	SELECT ProcesoId, FechaHoraValidación 
	FROM
	(SELECT
		LGPRV.LogGPRValidacionId AS ProcesoId,
		LGPRV.FechaFinValidacion AS FechaHoraValidación,
		row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
	FROM GPR.LogGPRValidacion LGPRV
	WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId AND LGPRV.Visualizado = 0)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN
		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId AND LCDRW.Visualizado = 0

		UNION ALL

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación
		FROM dbo.LogCDRWebCulminado LCDRWC WITH(NOLOCK)
		WHERE LCDRWC.ConsultoraId = @ConsultoraId AND LCDRWC.Visualizado = 0
	END

	SELECT COUNT(*) as Cantidad
	FROM (
		SELECT TOP 10 * FROM @Temporal t
		ORDER BY t.FechaHoraValidación DESC
	) AS p
END
GO



USE [BelcorpPeru]
GO
CREATE PROCEDURE [dbo].[GetNotificacionesSinLeer]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN
	SET NOCOUNT ON
	declare @Temporal table
	(
		ProcesoId bigint,
		FechaHoraValidación datetime
	)

	insert into @Temporal
	select 
		ValAutomaticaPROLLogId AS ProcesoId,
		FechaHoraValidación
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId and ISNULL(Visualizado,0) = 0

	UNION ALL

	select
		SolicitudClienteID,
		FechaSolicitud as FechaHoraValidación
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C')) and Leido = 0

	UNION ALL

	SELECT ProcesoId, FechaHoraValidación 
	FROM
	(SELECT
		LGPRV.LogGPRValidacionId AS ProcesoId,
		LGPRV.FechaFinValidacion AS FechaHoraValidación,
		row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
	FROM GPR.LogGPRValidacion LGPRV
	WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId AND LGPRV.Visualizado = 0)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN
		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId AND LCDRW.Visualizado = 0

		UNION ALL

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación
		FROM dbo.LogCDRWebCulminado LCDRWC WITH(NOLOCK)
		WHERE LCDRWC.ConsultoraId = @ConsultoraId AND LCDRWC.Visualizado = 0
	END	
	
	SELECT COUNT(*) as Cantidad
	FROM (
		SELECT TOP 10 * FROM @Temporal t
		ORDER BY t.FechaHoraValidación DESC
	) AS p
END
GO



USE [BelcorpPuertoRico]
GO
CREATE PROCEDURE [dbo].[GetNotificacionesSinLeer]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN

	declare @Temporal table
	(
		ProcesoId bigint,
		FechaHoraValidación datetime
	);

	insert into @Temporal
	select 
		ValAutomaticaPROLLogId as ProcesoId,
		FechaHoraValidación
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL

	SELECT ProcesoId, FechaHoraValidación 
	FROM
	(SELECT
		LGPRV.LogGPRValidacionId AS ProcesoId,
		LGPRV.FechaFinValidacion AS FechaHoraValidación,
		row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
	FROM GPR.LogGPRValidacion LGPRV
	WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId AND LGPRV.Visualizado = 0)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN
		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId AND LCDRW.Visualizado = 0

		UNION ALL

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación
		FROM dbo.LogCDRWebCulminado LCDRWC WITH(NOLOCK)
		WHERE LCDRWC.ConsultoraId = @ConsultoraId AND LCDRWC.Visualizado = 0
	END

	SELECT COUNT(*) as Cantidad
	FROM (
		SELECT TOP 10 * FROM @Temporal t
		ORDER BY t.FechaHoraValidación DESC
	) AS p
END
GO


USE [BelcorpSalvador]
GO
CREATE PROCEDURE [dbo].[GetNotificacionesSinLeer]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN

	declare @Temporal table
	(
		ProcesoId bigint,
		FechaHoraValidación datetime
	);

	insert into @Temporal 
	select 
		ValAutomaticaPROLLogId as ProcesoId,
		FechaHoraValidación
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId and ISNULL(Visualizado,0) = 0

	UNION ALL

	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C')) and Leido = 0

	UNION ALL

	SELECT ProcesoId, FechaHoraValidación 
	FROM
	(SELECT
		LGPRV.LogGPRValidacionId AS ProcesoId,
		LGPRV.FechaFinValidacion AS FechaHoraValidación,
		row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
	FROM GPR.LogGPRValidacion LGPRV
	WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId AND LGPRV.Visualizado = 0)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN
		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId AND LCDRW.Visualizado = 0

		UNION ALL

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación
		FROM dbo.LogCDRWebCulminado LCDRWC WITH(NOLOCK)
		WHERE LCDRWC.ConsultoraId = @ConsultoraId AND LCDRWC.Visualizado = 0
	END

	SELECT COUNT(*) as Cantidad
	FROM (
		SELECT TOP 10 * FROM @Temporal t
		ORDER BY t.FechaHoraValidación DESC
	) AS p
END
GO



USE [BelcorpVenezuela]
GO
CREATE PROCEDURE [dbo].[GetNotificacionesSinLeer]
@ConsultoraId bigint,
@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		FechaHoraValidación datetime
	);

	insert into @Temporal
	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación
	from SolicitudCliente
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C')) and Leido = 0

	UNION ALL

	SELECT ProcesoId, FechaHoraValidación 
	FROM
	(SELECT
		LGPRV.LogGPRValidacionId AS ProcesoId,
		LGPRV.FechaFinValidacion AS FechaHoraValidación,
		row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
	FROM GPR.LogGPRValidacion LGPRV
	WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId AND LGPRV.Visualizado = 0)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN
		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId AND LCDRW.Visualizado = 0

		UNION ALL

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación
		FROM dbo.LogCDRWebCulminado LCDRWC WITH(NOLOCK)
		WHERE LCDRWC.ConsultoraId = @ConsultoraId AND LCDRWC.Visualizado = 0
	END

	SELECT COUNT(*) as Cantidad
	FROM (
		SELECT TOP 10 * FROM @Temporal t
		ORDER BY t.FechaHoraValidación DESC
	) AS p
END
GO