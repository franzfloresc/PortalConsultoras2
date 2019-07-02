GO
USE BelcorpPeru
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Usp_PedidoWeb]
	@CodigoConsultora VARCHAR(25),
	@CampaniaID INT
AS
BEGIN

    declare @FechaInicioFacturacion datetime
	declare @FechaFinFacturacion datetime
	declare @PedidoRechazado varchar(20)
	declare @FechaPedidoRechazado datetime
	declare @EstadoPedido varchar(10)


    declare @PaisID tinyint
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint

    select @PaisID=PaisID from pais where EstadoActivo=1
	select top 1 @ZonaID=ZonaID,@RegionID=RegionID,@ConsultoraID=ConsultoraID from ods.consultora where Codigo=@CodigoConsultora

   	SELECT TOP 1 @FechaInicioFacturacion= FechaInicioFacturacion,@FechaFinFacturacion=FechaFinFacturacion from dbo.fnGetConfiguracionCampania(@PaisID,@ZonaID,@RegionID,@ConsultoraID)


	SELECT TOP 1 @PedidoRechazado=b.IdProcesoPedidoRechazado, @FechaPedidoRechazado=b.Fecha FROM GPR.PedidoRechazado a
	inner join GPR.PROCESOPEDIDORECHAZADO b on a.IdProcesoPedidoRechazado=b.IdProcesoPedidoRechazado
	where a.CodigoConsultora= @CodigoConsultora and a.Campania=@CampaniaID
	order by a.IdProcesoPedidoRechazado desc


	select top 1 @EstadoPedido= VAL_ESTA_PEDI from ods.soa_infor_pedid
	where cod_peri = @CampaniaID and cod_clie = @CodigoConsultora order by Fec_fact desc

	SELECT
		CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
		CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
		CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
		C.NombreCompleto,
		CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
		CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
		CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
		CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
		CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
		CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
		CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
		CONVERT(VARCHAR(10), p.fecharegistro,103) + ' ' + CONVERT(VARCHAR(5), p.fecharegistro,108) AS FechaIngreso,
		CONVERT(VARCHAR(10), p.fechamodificacion, 103) + ' ' + CONVERT(VARCHAR(5), p.fechamodificacion,108) AS FechaActualizacion,

		CASE
			WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
			ELSE 'NO'
		END AS Validado,
		CASE
			WHEN (p.indicadorenviado = 1) THEN 'SI'
			ELSE 'NO'
		END AS PedidoDescargado,

		isnull( (CONVERT(VARCHAR(10), p.FechaReserva, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaReserva,108)),'NO') AS FechaReservaPedido,
		isnull(( CONVERT(VARCHAR(10), p.FechaProceso, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaProceso,108)),'NO') AS FechaDescargaPedido,
		isnull(CONVERT(VARCHAR(10), @FechaInicioFacturacion, 103),'NO') AS FechaInicioFacturacion,
		isnull(CONVERT(VARCHAR(10), @FechaFinFacturacion, 103),'NO') AS FechaFinFacturacion,
		case when Isnull(@PedidoRechazado,'')='' then 'NO' else 'SI' end as PedidoRechazado,
		isnull(CONVERT(VARCHAR(10), @FechaPedidoRechazado, 103) + ' ' + CONVERT(VARCHAR(5), @FechaPedidoRechazado,108),'NO') AS FechaPedidoRechazado,
		ISNULL(D.Codigo,'') AS Zona,
		isnull(@EstadoPedido,'NO') as EstadoSICC
	FROM PedidoWeb AS P WITH (nolock)
	INNER JOIN ODS.Consultora AS C WITH (nolock) ON P.ConsultoraID = C.ConsultoraID
	LEFT JOIN ODS.zona D ON C.ZonaID=D.ZonaID
	WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END

GO
USE BelcorpMexico
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Usp_PedidoWeb]
	@CodigoConsultora VARCHAR(25),
	@CampaniaID INT
AS
BEGIN

    declare @FechaInicioFacturacion datetime
	declare @FechaFinFacturacion datetime
	declare @PedidoRechazado varchar(20)
	declare @FechaPedidoRechazado datetime
	declare @EstadoPedido varchar(10)


    declare @PaisID tinyint
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint

    select @PaisID=PaisID from pais where EstadoActivo=1
	select top 1 @ZonaID=ZonaID,@RegionID=RegionID,@ConsultoraID=ConsultoraID from ods.consultora where Codigo=@CodigoConsultora

   	SELECT TOP 1 @FechaInicioFacturacion= FechaInicioFacturacion,@FechaFinFacturacion=FechaFinFacturacion from dbo.fnGetConfiguracionCampania(@PaisID,@ZonaID,@RegionID,@ConsultoraID)


	SELECT TOP 1 @PedidoRechazado=b.IdProcesoPedidoRechazado, @FechaPedidoRechazado=b.Fecha FROM GPR.PedidoRechazado a
	inner join GPR.PROCESOPEDIDORECHAZADO b on a.IdProcesoPedidoRechazado=b.IdProcesoPedidoRechazado
	where a.CodigoConsultora= @CodigoConsultora and a.Campania=@CampaniaID
	order by a.IdProcesoPedidoRechazado desc


	select top 1 @EstadoPedido= VAL_ESTA_PEDI from ods.soa_infor_pedid
	where cod_peri = @CampaniaID and cod_clie = @CodigoConsultora order by Fec_fact desc

	SELECT
		CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
		CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
		CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
		C.NombreCompleto,
		CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
		CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
		CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
		CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
		CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
		CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
		CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
		CONVERT(VARCHAR(10), p.fecharegistro,103) + ' ' + CONVERT(VARCHAR(5), p.fecharegistro,108) AS FechaIngreso,
		CONVERT(VARCHAR(10), p.fechamodificacion, 103) + ' ' + CONVERT(VARCHAR(5), p.fechamodificacion,108) AS FechaActualizacion,

		CASE
			WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
			ELSE 'NO'
		END AS Validado,
		CASE
			WHEN (p.indicadorenviado = 1) THEN 'SI'
			ELSE 'NO'
		END AS PedidoDescargado,

		isnull( (CONVERT(VARCHAR(10), p.FechaReserva, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaReserva,108)),'NO') AS FechaReservaPedido,
		isnull(( CONVERT(VARCHAR(10), p.FechaProceso, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaProceso,108)),'NO') AS FechaDescargaPedido,
		isnull(CONVERT(VARCHAR(10), @FechaInicioFacturacion, 103),'NO') AS FechaInicioFacturacion,
		isnull(CONVERT(VARCHAR(10), @FechaFinFacturacion, 103),'NO') AS FechaFinFacturacion,
		case when Isnull(@PedidoRechazado,'')='' then 'NO' else 'SI' end as PedidoRechazado,
		isnull(CONVERT(VARCHAR(10), @FechaPedidoRechazado, 103) + ' ' + CONVERT(VARCHAR(5), @FechaPedidoRechazado,108),'NO') AS FechaPedidoRechazado,
		ISNULL(D.Codigo,'') AS Zona,
		isnull(@EstadoPedido,'NO') as EstadoSICC
	FROM PedidoWeb AS P WITH (nolock)
	INNER JOIN ODS.Consultora AS C WITH (nolock) ON P.ConsultoraID = C.ConsultoraID
	LEFT JOIN ODS.zona D ON C.ZonaID=D.ZonaID
	WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END

GO
USE BelcorpColombia
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Usp_PedidoWeb]
	@CodigoConsultora VARCHAR(25),
	@CampaniaID INT
AS
BEGIN

    declare @FechaInicioFacturacion datetime
	declare @FechaFinFacturacion datetime
	declare @PedidoRechazado varchar(20)
	declare @FechaPedidoRechazado datetime
	declare @EstadoPedido varchar(10)


    declare @PaisID tinyint
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint

    select @PaisID=PaisID from pais where EstadoActivo=1
	select top 1 @ZonaID=ZonaID,@RegionID=RegionID,@ConsultoraID=ConsultoraID from ods.consultora where Codigo=@CodigoConsultora

   	SELECT TOP 1 @FechaInicioFacturacion= FechaInicioFacturacion,@FechaFinFacturacion=FechaFinFacturacion from dbo.fnGetConfiguracionCampania(@PaisID,@ZonaID,@RegionID,@ConsultoraID)


	SELECT TOP 1 @PedidoRechazado=b.IdProcesoPedidoRechazado, @FechaPedidoRechazado=b.Fecha FROM GPR.PedidoRechazado a
	inner join GPR.PROCESOPEDIDORECHAZADO b on a.IdProcesoPedidoRechazado=b.IdProcesoPedidoRechazado
	where a.CodigoConsultora= @CodigoConsultora and a.Campania=@CampaniaID
	order by a.IdProcesoPedidoRechazado desc


	select top 1 @EstadoPedido= VAL_ESTA_PEDI from ods.soa_infor_pedid
	where cod_peri = @CampaniaID and cod_clie = @CodigoConsultora order by Fec_fact desc

	SELECT
		CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
		CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
		CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
		C.NombreCompleto,
		CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
		CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
		CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
		CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
		CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
		CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
		CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
		CONVERT(VARCHAR(10), p.fecharegistro,103) + ' ' + CONVERT(VARCHAR(5), p.fecharegistro,108) AS FechaIngreso,
		CONVERT(VARCHAR(10), p.fechamodificacion, 103) + ' ' + CONVERT(VARCHAR(5), p.fechamodificacion,108) AS FechaActualizacion,

		CASE
			WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
			ELSE 'NO'
		END AS Validado,
		CASE
			WHEN (p.indicadorenviado = 1) THEN 'SI'
			ELSE 'NO'
		END AS PedidoDescargado,

		isnull( (CONVERT(VARCHAR(10), p.FechaReserva, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaReserva,108)),'NO') AS FechaReservaPedido,
		isnull(( CONVERT(VARCHAR(10), p.FechaProceso, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaProceso,108)),'NO') AS FechaDescargaPedido,
		isnull(CONVERT(VARCHAR(10), @FechaInicioFacturacion, 103),'NO') AS FechaInicioFacturacion,
		isnull(CONVERT(VARCHAR(10), @FechaFinFacturacion, 103),'NO') AS FechaFinFacturacion,
		case when Isnull(@PedidoRechazado,'')='' then 'NO' else 'SI' end as PedidoRechazado,
		isnull(CONVERT(VARCHAR(10), @FechaPedidoRechazado, 103) + ' ' + CONVERT(VARCHAR(5), @FechaPedidoRechazado,108),'NO') AS FechaPedidoRechazado,
		ISNULL(D.Codigo,'') AS Zona,
		isnull(@EstadoPedido,'NO') as EstadoSICC
	FROM PedidoWeb AS P WITH (nolock)
	INNER JOIN ODS.Consultora AS C WITH (nolock) ON P.ConsultoraID = C.ConsultoraID
	LEFT JOIN ODS.zona D ON C.ZonaID=D.ZonaID
	WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END

GO
USE BelcorpSalvador
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Usp_PedidoWeb]
	@CodigoConsultora VARCHAR(25),
	@CampaniaID INT
AS
BEGIN

    declare @FechaInicioFacturacion datetime
	declare @FechaFinFacturacion datetime
	declare @PedidoRechazado varchar(20)
	declare @FechaPedidoRechazado datetime
	declare @EstadoPedido varchar(10)


    declare @PaisID tinyint
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint

    select @PaisID=PaisID from pais where EstadoActivo=1
	select top 1 @ZonaID=ZonaID,@RegionID=RegionID,@ConsultoraID=ConsultoraID from ods.consultora where Codigo=@CodigoConsultora

   	SELECT TOP 1 @FechaInicioFacturacion= FechaInicioFacturacion,@FechaFinFacturacion=FechaFinFacturacion from dbo.fnGetConfiguracionCampania(@PaisID,@ZonaID,@RegionID,@ConsultoraID)


	SELECT TOP 1 @PedidoRechazado=b.IdProcesoPedidoRechazado, @FechaPedidoRechazado=b.Fecha FROM GPR.PedidoRechazado a
	inner join GPR.PROCESOPEDIDORECHAZADO b on a.IdProcesoPedidoRechazado=b.IdProcesoPedidoRechazado
	where a.CodigoConsultora= @CodigoConsultora and a.Campania=@CampaniaID
	order by a.IdProcesoPedidoRechazado desc


	select top 1 @EstadoPedido= VAL_ESTA_PEDI from ods.soa_infor_pedid
	where cod_peri = @CampaniaID and cod_clie = @CodigoConsultora order by Fec_fact desc

	SELECT
		CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
		CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
		CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
		C.NombreCompleto,
		CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
		CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
		CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
		CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
		CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
		CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
		CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
		CONVERT(VARCHAR(10), p.fecharegistro,103) + ' ' + CONVERT(VARCHAR(5), p.fecharegistro,108) AS FechaIngreso,
		CONVERT(VARCHAR(10), p.fechamodificacion, 103) + ' ' + CONVERT(VARCHAR(5), p.fechamodificacion,108) AS FechaActualizacion,

		CASE
			WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
			ELSE 'NO'
		END AS Validado,
		CASE
			WHEN (p.indicadorenviado = 1) THEN 'SI'
			ELSE 'NO'
		END AS PedidoDescargado,

		isnull( (CONVERT(VARCHAR(10), p.FechaReserva, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaReserva,108)),'NO') AS FechaReservaPedido,
		isnull(( CONVERT(VARCHAR(10), p.FechaProceso, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaProceso,108)),'NO') AS FechaDescargaPedido,
		isnull(CONVERT(VARCHAR(10), @FechaInicioFacturacion, 103),'NO') AS FechaInicioFacturacion,
		isnull(CONVERT(VARCHAR(10), @FechaFinFacturacion, 103),'NO') AS FechaFinFacturacion,
		case when Isnull(@PedidoRechazado,'')='' then 'NO' else 'SI' end as PedidoRechazado,
		isnull(CONVERT(VARCHAR(10), @FechaPedidoRechazado, 103) + ' ' + CONVERT(VARCHAR(5), @FechaPedidoRechazado,108),'NO') AS FechaPedidoRechazado,
		ISNULL(D.Codigo,'') AS Zona,
		isnull(@EstadoPedido,'NO') as EstadoSICC
	FROM PedidoWeb AS P WITH (nolock)
	INNER JOIN ODS.Consultora AS C WITH (nolock) ON P.ConsultoraID = C.ConsultoraID
	LEFT JOIN ODS.zona D ON C.ZonaID=D.ZonaID
	WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END

GO
USE BelcorpPuertoRico
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Usp_PedidoWeb]
	@CodigoConsultora VARCHAR(25),
	@CampaniaID INT
AS
BEGIN

    declare @FechaInicioFacturacion datetime
	declare @FechaFinFacturacion datetime
	declare @PedidoRechazado varchar(20)
	declare @FechaPedidoRechazado datetime
	declare @EstadoPedido varchar(10)


    declare @PaisID tinyint
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint

    select @PaisID=PaisID from pais where EstadoActivo=1
	select top 1 @ZonaID=ZonaID,@RegionID=RegionID,@ConsultoraID=ConsultoraID from ods.consultora where Codigo=@CodigoConsultora

   	SELECT TOP 1 @FechaInicioFacturacion= FechaInicioFacturacion,@FechaFinFacturacion=FechaFinFacturacion from dbo.fnGetConfiguracionCampania(@PaisID,@ZonaID,@RegionID,@ConsultoraID)


	SELECT TOP 1 @PedidoRechazado=b.IdProcesoPedidoRechazado, @FechaPedidoRechazado=b.Fecha FROM GPR.PedidoRechazado a
	inner join GPR.PROCESOPEDIDORECHAZADO b on a.IdProcesoPedidoRechazado=b.IdProcesoPedidoRechazado
	where a.CodigoConsultora= @CodigoConsultora and a.Campania=@CampaniaID
	order by a.IdProcesoPedidoRechazado desc


	select top 1 @EstadoPedido= VAL_ESTA_PEDI from ods.soa_infor_pedid
	where cod_peri = @CampaniaID and cod_clie = @CodigoConsultora order by Fec_fact desc

	SELECT
		CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
		CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
		CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
		C.NombreCompleto,
		CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
		CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
		CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
		CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
		CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
		CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
		CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
		CONVERT(VARCHAR(10), p.fecharegistro,103) + ' ' + CONVERT(VARCHAR(5), p.fecharegistro,108) AS FechaIngreso,
		CONVERT(VARCHAR(10), p.fechamodificacion, 103) + ' ' + CONVERT(VARCHAR(5), p.fechamodificacion,108) AS FechaActualizacion,

		CASE
			WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
			ELSE 'NO'
		END AS Validado,
		CASE
			WHEN (p.indicadorenviado = 1) THEN 'SI'
			ELSE 'NO'
		END AS PedidoDescargado,

		isnull( (CONVERT(VARCHAR(10), p.FechaReserva, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaReserva,108)),'NO') AS FechaReservaPedido,
		isnull(( CONVERT(VARCHAR(10), p.FechaProceso, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaProceso,108)),'NO') AS FechaDescargaPedido,
		isnull(CONVERT(VARCHAR(10), @FechaInicioFacturacion, 103),'NO') AS FechaInicioFacturacion,
		isnull(CONVERT(VARCHAR(10), @FechaFinFacturacion, 103),'NO') AS FechaFinFacturacion,
		case when Isnull(@PedidoRechazado,'')='' then 'NO' else 'SI' end as PedidoRechazado,
		isnull(CONVERT(VARCHAR(10), @FechaPedidoRechazado, 103) + ' ' + CONVERT(VARCHAR(5), @FechaPedidoRechazado,108),'NO') AS FechaPedidoRechazado,
		ISNULL(D.Codigo,'') AS Zona,
		isnull(@EstadoPedido,'NO') as EstadoSICC
	FROM PedidoWeb AS P WITH (nolock)
	INNER JOIN ODS.Consultora AS C WITH (nolock) ON P.ConsultoraID = C.ConsultoraID
	LEFT JOIN ODS.zona D ON C.ZonaID=D.ZonaID
	WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END

GO
USE BelcorpPanama
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Usp_PedidoWeb]
	@CodigoConsultora VARCHAR(25),
	@CampaniaID INT
AS
BEGIN

    declare @FechaInicioFacturacion datetime
	declare @FechaFinFacturacion datetime
	declare @PedidoRechazado varchar(20)
	declare @FechaPedidoRechazado datetime
	declare @EstadoPedido varchar(10)


    declare @PaisID tinyint
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint

    select @PaisID=PaisID from pais where EstadoActivo=1
	select top 1 @ZonaID=ZonaID,@RegionID=RegionID,@ConsultoraID=ConsultoraID from ods.consultora where Codigo=@CodigoConsultora

   	SELECT TOP 1 @FechaInicioFacturacion= FechaInicioFacturacion,@FechaFinFacturacion=FechaFinFacturacion from dbo.fnGetConfiguracionCampania(@PaisID,@ZonaID,@RegionID,@ConsultoraID)


	SELECT TOP 1 @PedidoRechazado=b.IdProcesoPedidoRechazado, @FechaPedidoRechazado=b.Fecha FROM GPR.PedidoRechazado a
	inner join GPR.PROCESOPEDIDORECHAZADO b on a.IdProcesoPedidoRechazado=b.IdProcesoPedidoRechazado
	where a.CodigoConsultora= @CodigoConsultora and a.Campania=@CampaniaID
	order by a.IdProcesoPedidoRechazado desc


	select top 1 @EstadoPedido= VAL_ESTA_PEDI from ods.soa_infor_pedid
	where cod_peri = @CampaniaID and cod_clie = @CodigoConsultora order by Fec_fact desc

	SELECT
		CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
		CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
		CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
		C.NombreCompleto,
		CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
		CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
		CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
		CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
		CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
		CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
		CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
		CONVERT(VARCHAR(10), p.fecharegistro,103) + ' ' + CONVERT(VARCHAR(5), p.fecharegistro,108) AS FechaIngreso,
		CONVERT(VARCHAR(10), p.fechamodificacion, 103) + ' ' + CONVERT(VARCHAR(5), p.fechamodificacion,108) AS FechaActualizacion,

		CASE
			WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
			ELSE 'NO'
		END AS Validado,
		CASE
			WHEN (p.indicadorenviado = 1) THEN 'SI'
			ELSE 'NO'
		END AS PedidoDescargado,

		isnull( (CONVERT(VARCHAR(10), p.FechaReserva, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaReserva,108)),'NO') AS FechaReservaPedido,
		isnull(( CONVERT(VARCHAR(10), p.FechaProceso, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaProceso,108)),'NO') AS FechaDescargaPedido,
		isnull(CONVERT(VARCHAR(10), @FechaInicioFacturacion, 103),'NO') AS FechaInicioFacturacion,
		isnull(CONVERT(VARCHAR(10), @FechaFinFacturacion, 103),'NO') AS FechaFinFacturacion,
		case when Isnull(@PedidoRechazado,'')='' then 'NO' else 'SI' end as PedidoRechazado,
		isnull(CONVERT(VARCHAR(10), @FechaPedidoRechazado, 103) + ' ' + CONVERT(VARCHAR(5), @FechaPedidoRechazado,108),'NO') AS FechaPedidoRechazado,
		ISNULL(D.Codigo,'') AS Zona,
		isnull(@EstadoPedido,'NO') as EstadoSICC
	FROM PedidoWeb AS P WITH (nolock)
	INNER JOIN ODS.Consultora AS C WITH (nolock) ON P.ConsultoraID = C.ConsultoraID
	LEFT JOIN ODS.zona D ON C.ZonaID=D.ZonaID
	WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END

GO
USE BelcorpGuatemala
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Usp_PedidoWeb]
	@CodigoConsultora VARCHAR(25),
	@CampaniaID INT
AS
BEGIN

    declare @FechaInicioFacturacion datetime
	declare @FechaFinFacturacion datetime
	declare @PedidoRechazado varchar(20)
	declare @FechaPedidoRechazado datetime
	declare @EstadoPedido varchar(10)


    declare @PaisID tinyint
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint

    select @PaisID=PaisID from pais where EstadoActivo=1
	select top 1 @ZonaID=ZonaID,@RegionID=RegionID,@ConsultoraID=ConsultoraID from ods.consultora where Codigo=@CodigoConsultora

   	SELECT TOP 1 @FechaInicioFacturacion= FechaInicioFacturacion,@FechaFinFacturacion=FechaFinFacturacion from dbo.fnGetConfiguracionCampania(@PaisID,@ZonaID,@RegionID,@ConsultoraID)


	SELECT TOP 1 @PedidoRechazado=b.IdProcesoPedidoRechazado, @FechaPedidoRechazado=b.Fecha FROM GPR.PedidoRechazado a
	inner join GPR.PROCESOPEDIDORECHAZADO b on a.IdProcesoPedidoRechazado=b.IdProcesoPedidoRechazado
	where a.CodigoConsultora= @CodigoConsultora and a.Campania=@CampaniaID
	order by a.IdProcesoPedidoRechazado desc


	select top 1 @EstadoPedido= VAL_ESTA_PEDI from ods.soa_infor_pedid
	where cod_peri = @CampaniaID and cod_clie = @CodigoConsultora order by Fec_fact desc

	SELECT
		CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
		CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
		CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
		C.NombreCompleto,
		CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
		CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
		CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
		CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
		CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
		CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
		CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
		CONVERT(VARCHAR(10), p.fecharegistro,103) + ' ' + CONVERT(VARCHAR(5), p.fecharegistro,108) AS FechaIngreso,
		CONVERT(VARCHAR(10), p.fechamodificacion, 103) + ' ' + CONVERT(VARCHAR(5), p.fechamodificacion,108) AS FechaActualizacion,

		CASE
			WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
			ELSE 'NO'
		END AS Validado,
		CASE
			WHEN (p.indicadorenviado = 1) THEN 'SI'
			ELSE 'NO'
		END AS PedidoDescargado,

		isnull( (CONVERT(VARCHAR(10), p.FechaReserva, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaReserva,108)),'NO') AS FechaReservaPedido,
		isnull(( CONVERT(VARCHAR(10), p.FechaProceso, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaProceso,108)),'NO') AS FechaDescargaPedido,
		isnull(CONVERT(VARCHAR(10), @FechaInicioFacturacion, 103),'NO') AS FechaInicioFacturacion,
		isnull(CONVERT(VARCHAR(10), @FechaFinFacturacion, 103),'NO') AS FechaFinFacturacion,
		case when Isnull(@PedidoRechazado,'')='' then 'NO' else 'SI' end as PedidoRechazado,
		isnull(CONVERT(VARCHAR(10), @FechaPedidoRechazado, 103) + ' ' + CONVERT(VARCHAR(5), @FechaPedidoRechazado,108),'NO') AS FechaPedidoRechazado,
		ISNULL(D.Codigo,'') AS Zona,
		isnull(@EstadoPedido,'NO') as EstadoSICC
	FROM PedidoWeb AS P WITH (nolock)
	INNER JOIN ODS.Consultora AS C WITH (nolock) ON P.ConsultoraID = C.ConsultoraID
	LEFT JOIN ODS.zona D ON C.ZonaID=D.ZonaID
	WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END

GO
USE BelcorpEcuador
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Usp_PedidoWeb]
	@CodigoConsultora VARCHAR(25),
	@CampaniaID INT
AS
BEGIN

    declare @FechaInicioFacturacion datetime
	declare @FechaFinFacturacion datetime
	declare @PedidoRechazado varchar(20)
	declare @FechaPedidoRechazado datetime
	declare @EstadoPedido varchar(10)


    declare @PaisID tinyint
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint

    select @PaisID=PaisID from pais where EstadoActivo=1
	select top 1 @ZonaID=ZonaID,@RegionID=RegionID,@ConsultoraID=ConsultoraID from ods.consultora where Codigo=@CodigoConsultora

   	SELECT TOP 1 @FechaInicioFacturacion= FechaInicioFacturacion,@FechaFinFacturacion=FechaFinFacturacion from dbo.fnGetConfiguracionCampania(@PaisID,@ZonaID,@RegionID,@ConsultoraID)


	SELECT TOP 1 @PedidoRechazado=b.IdProcesoPedidoRechazado, @FechaPedidoRechazado=b.Fecha FROM GPR.PedidoRechazado a
	inner join GPR.PROCESOPEDIDORECHAZADO b on a.IdProcesoPedidoRechazado=b.IdProcesoPedidoRechazado
	where a.CodigoConsultora= @CodigoConsultora and a.Campania=@CampaniaID
	order by a.IdProcesoPedidoRechazado desc


	select top 1 @EstadoPedido= VAL_ESTA_PEDI from ods.soa_infor_pedid
	where cod_peri = @CampaniaID and cod_clie = @CodigoConsultora order by Fec_fact desc

	SELECT
		CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
		CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
		CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
		C.NombreCompleto,
		CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
		CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
		CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
		CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
		CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
		CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
		CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
		CONVERT(VARCHAR(10), p.fecharegistro,103) + ' ' + CONVERT(VARCHAR(5), p.fecharegistro,108) AS FechaIngreso,
		CONVERT(VARCHAR(10), p.fechamodificacion, 103) + ' ' + CONVERT(VARCHAR(5), p.fechamodificacion,108) AS FechaActualizacion,

		CASE
			WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
			ELSE 'NO'
		END AS Validado,
		CASE
			WHEN (p.indicadorenviado = 1) THEN 'SI'
			ELSE 'NO'
		END AS PedidoDescargado,

		isnull( (CONVERT(VARCHAR(10), p.FechaReserva, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaReserva,108)),'NO') AS FechaReservaPedido,
		isnull(( CONVERT(VARCHAR(10), p.FechaProceso, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaProceso,108)),'NO') AS FechaDescargaPedido,
		isnull(CONVERT(VARCHAR(10), @FechaInicioFacturacion, 103),'NO') AS FechaInicioFacturacion,
		isnull(CONVERT(VARCHAR(10), @FechaFinFacturacion, 103),'NO') AS FechaFinFacturacion,
		case when Isnull(@PedidoRechazado,'')='' then 'NO' else 'SI' end as PedidoRechazado,
		isnull(CONVERT(VARCHAR(10), @FechaPedidoRechazado, 103) + ' ' + CONVERT(VARCHAR(5), @FechaPedidoRechazado,108),'NO') AS FechaPedidoRechazado,
		ISNULL(D.Codigo,'') AS Zona,
		isnull(@EstadoPedido,'NO') as EstadoSICC
	FROM PedidoWeb AS P WITH (nolock)
	INNER JOIN ODS.Consultora AS C WITH (nolock) ON P.ConsultoraID = C.ConsultoraID
	LEFT JOIN ODS.zona D ON C.ZonaID=D.ZonaID
	WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END

GO
USE BelcorpDominicana
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Usp_PedidoWeb]
	@CodigoConsultora VARCHAR(25),
	@CampaniaID INT
AS
BEGIN

    declare @FechaInicioFacturacion datetime
	declare @FechaFinFacturacion datetime
	declare @PedidoRechazado varchar(20)
	declare @FechaPedidoRechazado datetime
	declare @EstadoPedido varchar(10)


    declare @PaisID tinyint
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint

    select @PaisID=PaisID from pais where EstadoActivo=1
	select top 1 @ZonaID=ZonaID,@RegionID=RegionID,@ConsultoraID=ConsultoraID from ods.consultora where Codigo=@CodigoConsultora

   	SELECT TOP 1 @FechaInicioFacturacion= FechaInicioFacturacion,@FechaFinFacturacion=FechaFinFacturacion from dbo.fnGetConfiguracionCampania(@PaisID,@ZonaID,@RegionID,@ConsultoraID)


	SELECT TOP 1 @PedidoRechazado=b.IdProcesoPedidoRechazado, @FechaPedidoRechazado=b.Fecha FROM GPR.PedidoRechazado a
	inner join GPR.PROCESOPEDIDORECHAZADO b on a.IdProcesoPedidoRechazado=b.IdProcesoPedidoRechazado
	where a.CodigoConsultora= @CodigoConsultora and a.Campania=@CampaniaID
	order by a.IdProcesoPedidoRechazado desc


	select top 1 @EstadoPedido= VAL_ESTA_PEDI from ods.soa_infor_pedid
	where cod_peri = @CampaniaID and cod_clie = @CodigoConsultora order by Fec_fact desc

	SELECT
		CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
		CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
		CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
		C.NombreCompleto,
		CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
		CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
		CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
		CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
		CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
		CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
		CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
		CONVERT(VARCHAR(10), p.fecharegistro,103) + ' ' + CONVERT(VARCHAR(5), p.fecharegistro,108) AS FechaIngreso,
		CONVERT(VARCHAR(10), p.fechamodificacion, 103) + ' ' + CONVERT(VARCHAR(5), p.fechamodificacion,108) AS FechaActualizacion,

		CASE
			WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
			ELSE 'NO'
		END AS Validado,
		CASE
			WHEN (p.indicadorenviado = 1) THEN 'SI'
			ELSE 'NO'
		END AS PedidoDescargado,

		isnull( (CONVERT(VARCHAR(10), p.FechaReserva, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaReserva,108)),'NO') AS FechaReservaPedido,
		isnull(( CONVERT(VARCHAR(10), p.FechaProceso, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaProceso,108)),'NO') AS FechaDescargaPedido,
		isnull(CONVERT(VARCHAR(10), @FechaInicioFacturacion, 103),'NO') AS FechaInicioFacturacion,
		isnull(CONVERT(VARCHAR(10), @FechaFinFacturacion, 103),'NO') AS FechaFinFacturacion,
		case when Isnull(@PedidoRechazado,'')='' then 'NO' else 'SI' end as PedidoRechazado,
		isnull(CONVERT(VARCHAR(10), @FechaPedidoRechazado, 103) + ' ' + CONVERT(VARCHAR(5), @FechaPedidoRechazado,108),'NO') AS FechaPedidoRechazado,
		ISNULL(D.Codigo,'') AS Zona,
		isnull(@EstadoPedido,'NO') as EstadoSICC
	FROM PedidoWeb AS P WITH (nolock)
	INNER JOIN ODS.Consultora AS C WITH (nolock) ON P.ConsultoraID = C.ConsultoraID
	LEFT JOIN ODS.zona D ON C.ZonaID=D.ZonaID
	WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END

GO
USE BelcorpCostaRica
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Usp_PedidoWeb]
	@CodigoConsultora VARCHAR(25),
	@CampaniaID INT
AS
BEGIN

    declare @FechaInicioFacturacion datetime
	declare @FechaFinFacturacion datetime
	declare @PedidoRechazado varchar(20)
	declare @FechaPedidoRechazado datetime
	declare @EstadoPedido varchar(10)


    declare @PaisID tinyint
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint

    select @PaisID=PaisID from pais where EstadoActivo=1
	select top 1 @ZonaID=ZonaID,@RegionID=RegionID,@ConsultoraID=ConsultoraID from ods.consultora where Codigo=@CodigoConsultora

   	SELECT TOP 1 @FechaInicioFacturacion= FechaInicioFacturacion,@FechaFinFacturacion=FechaFinFacturacion from dbo.fnGetConfiguracionCampania(@PaisID,@ZonaID,@RegionID,@ConsultoraID)


	SELECT TOP 1 @PedidoRechazado=b.IdProcesoPedidoRechazado, @FechaPedidoRechazado=b.Fecha FROM GPR.PedidoRechazado a
	inner join GPR.PROCESOPEDIDORECHAZADO b on a.IdProcesoPedidoRechazado=b.IdProcesoPedidoRechazado
	where a.CodigoConsultora= @CodigoConsultora and a.Campania=@CampaniaID
	order by a.IdProcesoPedidoRechazado desc


	select top 1 @EstadoPedido= VAL_ESTA_PEDI from ods.soa_infor_pedid
	where cod_peri = @CampaniaID and cod_clie = @CodigoConsultora order by Fec_fact desc

	SELECT
		CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
		CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
		CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
		C.NombreCompleto,
		CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
		CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
		CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
		CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
		CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
		CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
		CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
		CONVERT(VARCHAR(10), p.fecharegistro,103) + ' ' + CONVERT(VARCHAR(5), p.fecharegistro,108) AS FechaIngreso,
		CONVERT(VARCHAR(10), p.fechamodificacion, 103) + ' ' + CONVERT(VARCHAR(5), p.fechamodificacion,108) AS FechaActualizacion,

		CASE
			WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
			ELSE 'NO'
		END AS Validado,
		CASE
			WHEN (p.indicadorenviado = 1) THEN 'SI'
			ELSE 'NO'
		END AS PedidoDescargado,

		isnull( (CONVERT(VARCHAR(10), p.FechaReserva, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaReserva,108)),'NO') AS FechaReservaPedido,
		isnull(( CONVERT(VARCHAR(10), p.FechaProceso, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaProceso,108)),'NO') AS FechaDescargaPedido,
		isnull(CONVERT(VARCHAR(10), @FechaInicioFacturacion, 103),'NO') AS FechaInicioFacturacion,
		isnull(CONVERT(VARCHAR(10), @FechaFinFacturacion, 103),'NO') AS FechaFinFacturacion,
		case when Isnull(@PedidoRechazado,'')='' then 'NO' else 'SI' end as PedidoRechazado,
		isnull(CONVERT(VARCHAR(10), @FechaPedidoRechazado, 103) + ' ' + CONVERT(VARCHAR(5), @FechaPedidoRechazado,108),'NO') AS FechaPedidoRechazado,
		ISNULL(D.Codigo,'') AS Zona,
		isnull(@EstadoPedido,'NO') as EstadoSICC
	FROM PedidoWeb AS P WITH (nolock)
	INNER JOIN ODS.Consultora AS C WITH (nolock) ON P.ConsultoraID = C.ConsultoraID
	LEFT JOIN ODS.zona D ON C.ZonaID=D.ZonaID
	WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END

GO
USE BelcorpChile
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Usp_PedidoWeb]
	@CodigoConsultora VARCHAR(25),
	@CampaniaID INT
AS
BEGIN

    declare @FechaInicioFacturacion datetime
	declare @FechaFinFacturacion datetime
	declare @PedidoRechazado varchar(20)
	declare @FechaPedidoRechazado datetime
	declare @EstadoPedido varchar(10)


    declare @PaisID tinyint
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint

    select @PaisID=PaisID from pais where EstadoActivo=1
	select top 1 @ZonaID=ZonaID,@RegionID=RegionID,@ConsultoraID=ConsultoraID from ods.consultora where Codigo=@CodigoConsultora

   	SELECT TOP 1 @FechaInicioFacturacion= FechaInicioFacturacion,@FechaFinFacturacion=FechaFinFacturacion from dbo.fnGetConfiguracionCampania(@PaisID,@ZonaID,@RegionID,@ConsultoraID)


	SELECT TOP 1 @PedidoRechazado=b.IdProcesoPedidoRechazado, @FechaPedidoRechazado=b.Fecha FROM GPR.PedidoRechazado a
	inner join GPR.PROCESOPEDIDORECHAZADO b on a.IdProcesoPedidoRechazado=b.IdProcesoPedidoRechazado
	where a.CodigoConsultora= @CodigoConsultora and a.Campania=@CampaniaID
	order by a.IdProcesoPedidoRechazado desc


	select top 1 @EstadoPedido= VAL_ESTA_PEDI from ods.soa_infor_pedid
	where cod_peri = @CampaniaID and cod_clie = @CodigoConsultora order by Fec_fact desc

	SELECT
		CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
		CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
		CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
		C.NombreCompleto,
		CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
		CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
		CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
		CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
		CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
		CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
		CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
		CONVERT(VARCHAR(10), p.fecharegistro,103) + ' ' + CONVERT(VARCHAR(5), p.fecharegistro,108) AS FechaIngreso,
		CONVERT(VARCHAR(10), p.fechamodificacion, 103) + ' ' + CONVERT(VARCHAR(5), p.fechamodificacion,108) AS FechaActualizacion,

		CASE
			WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
			ELSE 'NO'
		END AS Validado,
		CASE
			WHEN (p.indicadorenviado = 1) THEN 'SI'
			ELSE 'NO'
		END AS PedidoDescargado,

		isnull( (CONVERT(VARCHAR(10), p.FechaReserva, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaReserva,108)),'NO') AS FechaReservaPedido,
		isnull(( CONVERT(VARCHAR(10), p.FechaProceso, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaProceso,108)),'NO') AS FechaDescargaPedido,
		isnull(CONVERT(VARCHAR(10), @FechaInicioFacturacion, 103),'NO') AS FechaInicioFacturacion,
		isnull(CONVERT(VARCHAR(10), @FechaFinFacturacion, 103),'NO') AS FechaFinFacturacion,
		case when Isnull(@PedidoRechazado,'')='' then 'NO' else 'SI' end as PedidoRechazado,
		isnull(CONVERT(VARCHAR(10), @FechaPedidoRechazado, 103) + ' ' + CONVERT(VARCHAR(5), @FechaPedidoRechazado,108),'NO') AS FechaPedidoRechazado,
		ISNULL(D.Codigo,'') AS Zona,
		isnull(@EstadoPedido,'NO') as EstadoSICC
	FROM PedidoWeb AS P WITH (nolock)
	INNER JOIN ODS.Consultora AS C WITH (nolock) ON P.ConsultoraID = C.ConsultoraID
	LEFT JOIN ODS.zona D ON C.ZonaID=D.ZonaID
	WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END

GO
USE BelcorpBolivia
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Usp_PedidoWeb]
	@CodigoConsultora VARCHAR(25),
	@CampaniaID INT
AS
BEGIN

    declare @FechaInicioFacturacion datetime
	declare @FechaFinFacturacion datetime
	declare @PedidoRechazado varchar(20)
	declare @FechaPedidoRechazado datetime
	declare @EstadoPedido varchar(10)


    declare @PaisID tinyint
	declare @ZonaID int
	declare @RegionID int
	declare @ConsultoraID bigint

    select @PaisID=PaisID from pais where EstadoActivo=1
	select top 1 @ZonaID=ZonaID,@RegionID=RegionID,@ConsultoraID=ConsultoraID from ods.consultora where Codigo=@CodigoConsultora

   	SELECT TOP 1 @FechaInicioFacturacion= FechaInicioFacturacion,@FechaFinFacturacion=FechaFinFacturacion from dbo.fnGetConfiguracionCampania(@PaisID,@ZonaID,@RegionID,@ConsultoraID)


	SELECT TOP 1 @PedidoRechazado=b.IdProcesoPedidoRechazado, @FechaPedidoRechazado=b.Fecha FROM GPR.PedidoRechazado a
	inner join GPR.PROCESOPEDIDORECHAZADO b on a.IdProcesoPedidoRechazado=b.IdProcesoPedidoRechazado
	where a.CodigoConsultora= @CodigoConsultora and a.Campania=@CampaniaID
	order by a.IdProcesoPedidoRechazado desc


	select top 1 @EstadoPedido= VAL_ESTA_PEDI from ods.soa_infor_pedid
	where cod_peri = @CampaniaID and cod_clie = @CodigoConsultora order by Fec_fact desc

	SELECT
		CAST(P.CampaniaId AS VARCHAR(20)) AS CampaniaId,
		CAST(P.PedidoID AS VARCHAR(20)) AS PedidoID,
		CAST(C.ConsultoraID AS VARCHAR(25)) AS ConsultoraID,
		C.NombreCompleto,
		CAST(P.Clientes AS VARCHAR(20)) AS Clientes,
		CAST(P.ImporteTotal AS VARCHAR(20)) AS ImporteTotal,
		CAST(ISNULL(P.ImporteTotal,0) - ISNULL(P.DescuentoProl,0) AS VARCHAR(20)) AS ImporteTotalConDescuento,
		CAST(P.ImporteCredito AS VARCHAR(20)) AS ImporteCredito,
		CAST(P.IndicadorEnviado AS VARCHAR(20)) AS IndicadorEnviado,
		CAST(P.Bloqueado AS VARCHAR(20)) AS Bloqueado,
		CAST(P.EstadoPedido AS VARCHAR(20)) AS EstadoPedido,
		CONVERT(VARCHAR(10), p.fecharegistro,103) + ' ' + CONVERT(VARCHAR(5), p.fecharegistro,108) AS FechaIngreso,
		CONVERT(VARCHAR(10), p.fechamodificacion, 103) + ' ' + CONVERT(VARCHAR(5), p.fechamodificacion,108) AS FechaActualizacion,

		CASE
			WHEN (p.estadopedido = 202 and p.validacionabierta = 0) THEN 'SI'
			ELSE 'NO'
		END AS Validado,
		CASE
			WHEN (p.indicadorenviado = 1) THEN 'SI'
			ELSE 'NO'
		END AS PedidoDescargado,

		isnull( (CONVERT(VARCHAR(10), p.FechaReserva, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaReserva,108)),'NO') AS FechaReservaPedido,
		isnull(( CONVERT(VARCHAR(10), p.FechaProceso, 103) + ' ' + CONVERT(VARCHAR(5), p.FechaProceso,108)),'NO') AS FechaDescargaPedido,
		isnull(CONVERT(VARCHAR(10), @FechaInicioFacturacion, 103),'NO') AS FechaInicioFacturacion,
		isnull(CONVERT(VARCHAR(10), @FechaFinFacturacion, 103),'NO') AS FechaFinFacturacion,
		case when Isnull(@PedidoRechazado,'')='' then 'NO' else 'SI' end as PedidoRechazado,
		isnull(CONVERT(VARCHAR(10), @FechaPedidoRechazado, 103) + ' ' + CONVERT(VARCHAR(5), @FechaPedidoRechazado,108),'NO') AS FechaPedidoRechazado,
		ISNULL(D.Codigo,'') AS Zona,
		isnull(@EstadoPedido,'NO') as EstadoSICC
	FROM PedidoWeb AS P WITH (nolock)
	INNER JOIN ODS.Consultora AS C WITH (nolock) ON P.ConsultoraID = C.ConsultoraID
	LEFT JOIN ODS.zona D ON C.ZonaID=D.ZonaID
	WHERE C.Codigo = @CodigoConsultora AND P.CampaniaId = @CampaniaID;
END

GO
