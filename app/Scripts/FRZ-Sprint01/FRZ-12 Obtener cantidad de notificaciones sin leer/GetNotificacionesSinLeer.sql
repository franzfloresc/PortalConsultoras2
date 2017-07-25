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
		FechaHoraValidación datetime,		
		Visualizado bit,
		RowsCount int
	);

	insert into @Temporal
	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación,
		Leido as Visualizado,
		1
	from SolicitudCliente
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL

	SELECT *
	FROM
		(SELECT
			LGPRV.ProcesoValidacionPedidoRechazadoId AS ProcesoId,
			LGPRV.FechaFinValidacion AS FechaHoraValidación,
			LGPRV.Visualizado AS Visualizado,
			row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
		FROM GPR.LogGPRValidacion LGPRV
		WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId
		)
	as rows
	where row_number = 1
	
	IF(@ShowCDR = 1)
	BEGIN
		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación,
			LCDRW.Visualizado AS Visualizado,
			1
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId
		
		UNION ALL
		
		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación,
			LCDRWC.Visualizado,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END
	select count(*) as Cantidad
	from (	
		SELECT top 10 * FROM @Temporal t	
		ORDER by t.FechaHoraValidación desc	
	) as p
	where p.Visualizado = 0
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
		FechaHoraValidación datetime,		
		Visualizado bit,
		RowsCount int
	);
	insert into @Temporal
	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación,
		Leido as Visualizado,
		1
	from SolicitudCliente
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL
	SELECT *
	FROM
	(SELECT
		LGPRV.ProcesoValidacionPedidoRechazadoId AS ProcesoId,
		LGPRV.FechaFinValidacion AS FechaHoraValidación,
		LGPRV.Visualizado AS Visualizado,
		row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
	FROM GPR.LogGPRValidacion LGPRV
	WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
	as rows
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN
	insert into @Temporal
	SELECT
		LCDRW.LogCDRWebId AS ProcesoId,
		LCDRW.FechaAtencion AS FechaHoraValidación,
		LCDRW.Visualizado AS Visualizado,
		1
	FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
	WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId
	UNION ALL
	SELECT
		LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
		LCDRWC.FechaCulminado AS FechaHoraValidación,
		LCDRWC.Visualizado,
		1
	FROM dbo.LogCDRWebCulminado LCDRWC
	WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	select count(*) as Cantidad
	from (	
		SELECT top 10 * FROM @Temporal t	
		ORDER by t.FechaHoraValidación desc	
	) as p
	where p.Visualizado = 0
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
		FechaHoraValidación datetime,		
		Visualizado bit,
		RowsCount int
	);

	insert into @Temporal
	select 
		ValAutomaticaPROLLogId as ProcesoId,
		FechaHoraValidación,
		ISNULL(Visualizado,0) as Visualizado, 
		1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL

	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación,
		Leido as Visualizado,
		1
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId,
			LGPRV.FechaFinValidacion AS FechaHoraValidación,
			LGPRV.Visualizado AS Visualizado,
			row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
		FROM GPR.LogGPRValidacion LGPRV
		WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN

		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación,
			LCDRW.Visualizado AS Visualizado,
			1
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId

		UNION ALL	

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación,
			LCDRWC.Visualizado,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END
	select count(*) as Cantidad
	from (	
		SELECT top 10 * FROM @Temporal t	
		ORDER by t.FechaHoraValidación desc	
	) as p
	where p.Visualizado = 0
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
		FechaHoraValidación datetime,
		Visualizado bit,
		RowsCount int
	);

	insert into @Temporal
	select 
		ValAutomaticaPROLLogId as ProcesoId,
		FechaHoraValidación,
		ISNULL(Visualizado,0) as Visualizado,
		1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL

	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación,
		Leido as Visualizado,
		1
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))	

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId,
			LGPRV.FechaFinValidacion AS FechaHoraValidación,
			LGPRV.Visualizado AS Visualizado,
			row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
		FROM GPR.LogGPRValidacion LGPRV
		WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN

		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación,
			LCDRW.Visualizado AS Visualizado,
			1
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId

		UNION ALL	

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación,
			LCDRWC.Visualizado,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	select count(*) as Cantidad
	from (	
		SELECT top 10 * FROM @Temporal t	
		ORDER by t.FechaHoraValidación desc	
	) as p
	where p.Visualizado = 0
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
	FechaHoraValidación datetime,
	Visualizado bit,
	RowsCount int
	);

	insert into @Temporal
		select 
			ValAutomaticaPROLLogId as ProcesoId,
			FechaHoraValidación,
			ISNULL(Visualizado,0) as Visualizado,
			1
		from ValidacionAutomaticaPROLLog with(nolock)
		where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL

		select
			SolicitudClienteID as ProcesoId,
			FechaSolicitud as FechaHoraValidación,
			Leido as Visualizado,
			1
		from SolicitudCliente
		where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL
		SELECT *
		FROM
		(SELECT
			LGPRV.LogGPRValidacionId AS ProcesoId,
			LGPRV.FechaFinValidacion AS FechaHoraValidación,
			LGPRV.Visualizado AS Visualizado,
			row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
		FROM GPR.LogGPRValidacion LGPRV
		WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
		as rows
		where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN
	insert into @Temporal
		SELECT
		LCDRW.LogCDRWebId AS ProcesoId,
		LCDRW.FechaAtencion AS FechaHoraValidación,
		LCDRW.Visualizado AS Visualizado,
		1
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId
	UNION ALL
		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación,
			LCDRWC.Visualizado,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	select count(*) as Cantidad
	from (	
		SELECT top 10 * FROM @Temporal t	
		ORDER by t.FechaHoraValidación desc	
	) as p
	where p.Visualizado = 0
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
		FechaHoraValidación datetime,
		Visualizado bit,
		RowsCount int
	);

	insert into @Temporal
	select 
		ValAutomaticaPROLLogId as ProcesoId,
		FechaHoraValidación,
		ISNULL(Visualizado,0) as Visualizado,
		1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL

	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación,
		Leido as Visualizado,
		1
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId,
			LGPRV.FechaFinValidacion AS FechaHoraValidación,
			LGPRV.Visualizado AS Visualizado,
			row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
		FROM GPR.LogGPRValidacion LGPRV
		WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN

		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación,
			LCDRW.Visualizado AS Visualizado,
			1
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId

		UNION ALL	

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación,
			LCDRWC.Visualizado,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	select count(*) as Cantidad
	from (	
		SELECT top 10 * FROM @Temporal t	
		ORDER by t.FechaHoraValidación desc	
	) as p
	where p.Visualizado = 0
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
		FechaHoraValidación datetime,
		Visualizado bit,
		RowsCount int
	);

	insert into @Temporal
	select 
		ValAutomaticaPROLLogId as ProcesoId,
		FechaHoraValidación,
		ISNULL(Visualizado,0) as Visualizado,
		1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL

	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación,
		Leido as Visualizado,
		1
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId,
			LGPRV.FechaFinValidacion AS FechaHoraValidación,
			LGPRV.Visualizado AS Visualizado,
			row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
		FROM GPR.LogGPRValidacion LGPRV
		WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN

		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación,
			LCDRW.Visualizado AS Visualizado,
			1
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId

		UNION ALL	

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación,
			LCDRWC.Visualizado,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	select count(*) as Cantidad
	from (	
		SELECT top 10 * FROM @Temporal t	
		ORDER by t.FechaHoraValidación desc	
	) as p
	where p.Visualizado = 0
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
		FechaHoraValidación datetime,
		Visualizado bit,
		RowsCount int
	);

	insert into @Temporal
	select 
		ValAutomaticaPROLLogId as ProcesoId,
		FechaHoraValidación,
		ISNULL(Visualizado,0) as Visualizado,
		1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación,
		Leido as Visualizado,
		1
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId,
			LGPRV.FechaFinValidacion AS FechaHoraValidación,
			LGPRV.Visualizado AS Visualizado,
			row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
		FROM GPR.LogGPRValidacion LGPRV
		WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN

		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación,
			LCDRW.Visualizado AS Visualizado,
			1
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId

		UNION ALL	

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación,
			LCDRWC.Visualizado,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	select count(*) as Cantidad
	from (	
		SELECT top 10 * FROM @Temporal t	
		ORDER by t.FechaHoraValidación desc	
	) as p
	where p.Visualizado = 0
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
		FechaHoraValidación datetime,
		Visualizado bit,
		RowsCount int
	);

	insert into @Temporal
	select 
		ValAutomaticaPROLLogId as ProcesoId,
		FechaHoraValidación,
		ISNULL(Visualizado,0) as Visualizado,
		1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId


	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación,
		Leido as Visualizado,
		1
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId,
			LGPRV.FechaFinValidacion AS FechaHoraValidación,
			LGPRV.Visualizado AS Visualizado,
			row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
		FROM GPR.LogGPRValidacion LGPRV
		WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN

		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación,
			LCDRW.Visualizado AS Visualizado,
			1
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId

		UNION ALL	

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación,
			LCDRWC.Visualizado,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	select count(*) as Cantidad
	from (	
		SELECT top 10 * FROM @Temporal t	
		ORDER by t.FechaHoraValidación desc	
	) as p
	where p.Visualizado = 0
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
		FechaHoraValidación datetime,		
		Visualizado bit,
		RowsCount int
	)

	insert into @Temporal
	select 
		ValAutomaticaPROLLogId AS ProcesoId,
		FechaHoraValidación,
		ISNULL(Visualizado,0) as Visualizado,
		1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL

	select
		SolicitudClienteID,
		FechaSolicitud as FechaHoraValidación,
		Leido as Visualizado,
		1
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId, 
			LGPRV.FechaFinValidacion AS FechaHoraValidación,
			LGPRV.Visualizado AS Visualizado,
			row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
		FROM GPR.LogGPRValidacion LGPRV
		WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN
		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación,
			LCDRW.Visualizado AS Visualizado,
			1
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId

		UNION ALL	

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación,
			LCDRWC.Visualizado,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END	
	
	select count(*) as Cantidad
	from (	
		SELECT top 10 * FROM @Temporal t	
		ORDER by t.FechaHoraValidación desc	
	) as p
	where p.Visualizado = 0
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
		FechaHoraValidación datetime,
		Visualizado bit,
		RowsCount int
	);

	insert into @Temporal
	select 
		ValAutomaticaPROLLogId as ProcesoId,
		FechaHoraValidación,
		ISNULL(Visualizado,0) as Visualizado,
		1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación,
		Leido as Visualizado,
		1
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId,
			LGPRV.FechaFinValidacion AS FechaHoraValidación,
			LGPRV.Visualizado AS Visualizado,
			row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
		FROM GPR.LogGPRValidacion LGPRV
		WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN

		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación,
			LCDRW.Visualizado AS Visualizado,
			1
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId

		UNION ALL	

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación,
			LCDRWC.Visualizado,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	select count(*) as Cantidad
	from (	
		SELECT top 10 * FROM @Temporal t	
		ORDER by t.FechaHoraValidación desc	
	) as p
	where p.Visualizado = 0
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
		FechaHoraValidación datetime,
		Visualizado bit,
		RowsCount int
	);

	insert into @Temporal 
	select 
		ValAutomaticaPROLLogId as ProcesoId,
		FechaHoraValidación,
		ISNULL(Visualizado,0) as Visualizado, 
		1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL

	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación,
		Leido as Visualizado,
		1
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId,
			LGPRV.FechaFinValidacion AS FechaHoraValidación,
			LGPRV.Visualizado AS Visualizado,
			row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
		FROM GPR.LogGPRValidacion LGPRV
		WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN

		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación,
			LCDRW.Visualizado AS Visualizado,
			1
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId

		UNION ALL	

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación,
			LCDRWC.Visualizado,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	select count(*) as Cantidad
	from (	
		SELECT top 10 * FROM @Temporal t	
		ORDER by t.FechaHoraValidación desc	
	) as p
	where p.Visualizado = 0
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
		FechaHoraValidación datetime,
		Visualizado bit,
		RowsCount int
	);

	insert into @Temporal
	select
		SolicitudClienteID as ProcesoId,
		FechaSolicitud as FechaHoraValidación,
		Leido as Visualizado,
		1
	from SolicitudCliente
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL

	SELECT *
	FROM
		(SELECT
			LGPRV.ProcesoValidacionPedidoRechazadoId AS ProcesoId,
			LGPRV.FechaFinValidacion AS FechaHoraValidación,
			LGPRV.Visualizado AS Visualizado,
			row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
		FROM GPR.LogGPRValidacion LGPRV
		WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId
		)
	as rows
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN
		insert into @Temporal
			SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.FechaAtencion AS FechaHoraValidación,
			LCDRW.Visualizado AS Visualizado,
			1
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId

		UNION ALL

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.FechaCulminado AS FechaHoraValidación,
			LCDRWC.Visualizado,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	select count(*) as Cantidad
	from (	
		SELECT top 10 * FROM @Temporal t	
		ORDER by t.FechaHoraValidación desc	
	) as p
	where p.Visualizado = 0
END
GO