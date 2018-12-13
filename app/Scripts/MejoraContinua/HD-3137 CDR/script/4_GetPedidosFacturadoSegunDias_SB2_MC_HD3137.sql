USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[GetPedidosFacturadoSegunDias_SB2]
	@ConsultoraID int,
	@CampaniaID int,
	@maxDias int
AS
BEGIN
	set @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME
	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()

	set @FechaDesde = @FechaDesde - @maxDias
	
		SELECT
			CA.CODIGO AS CampaniaID,
			P.MontoFacturado AS ImporteTotal,
			P.Flete,
			P.PedidoID,
			isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
			isnull(P.Origen,'') as CanalIngreso,
			isnull(p.NumeroPedido,0) as NumeroPedido,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.CDRWebID
			end as CDRWebID,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.Estado
			end as CDRWebEstado,
			Convert(varchar(10),FechaFacturado,103) as FechaFacturado
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Campania(NOLOCK) CA ON 
			P.CampaniaID=CA.CampaniaID
		INNER JOIN ods.Consultora(NOLOCK) CO ON 
			P.ConsultoraID=CO.ConsultoraID
		LEFT JOIN CDRWeb C on
			P.PedidoID = C.PedidoID
		WHERE 
			co.ConsultoraID=@ConsultoraID
			and	P.CampaniaID <> @CampaniaID
			and convert(date, p.FechaFacturado) >= convert(date, @FechaDesde)
		ORDER BY 
			CA.Codigo desc 
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[GetPedidosFacturadoSegunDias_SB2]
	@ConsultoraID int,
	@CampaniaID int,
	@maxDias int
AS
BEGIN
	set @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME
	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()

	set @FechaDesde = @FechaDesde - @maxDias
	
		SELECT
			CA.CODIGO AS CampaniaID,
			P.MontoFacturado AS ImporteTotal,
			P.Flete,
			P.PedidoID,
			isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
			isnull(P.Origen,'') as CanalIngreso,
			isnull(p.NumeroPedido,0) as NumeroPedido,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.CDRWebID
			end as CDRWebID,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.Estado
			end as CDRWebEstado,
			Convert(varchar(10),FechaFacturado,103) as FechaFacturado
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Campania(NOLOCK) CA ON 
			P.CampaniaID=CA.CampaniaID
		INNER JOIN ods.Consultora(NOLOCK) CO ON 
			P.ConsultoraID=CO.ConsultoraID
		LEFT JOIN CDRWeb C on
			P.PedidoID = C.PedidoID
		WHERE 
			co.ConsultoraID=@ConsultoraID
			and	P.CampaniaID <> @CampaniaID
			and convert(date, p.FechaFacturado) >= convert(date, @FechaDesde)
		ORDER BY 
			CA.Codigo desc 
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[GetPedidosFacturadoSegunDias_SB2]
	@ConsultoraID int,
	@CampaniaID int,
	@maxDias int
AS
BEGIN
	set @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME
	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()

	set @FechaDesde = @FechaDesde - @maxDias
	
		SELECT
			CA.CODIGO AS CampaniaID,
			P.MontoFacturado AS ImporteTotal,
			P.Flete,
			P.PedidoID,
			isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
			isnull(P.Origen,'') as CanalIngreso,
			isnull(p.NumeroPedido,0) as NumeroPedido,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.CDRWebID
			end as CDRWebID,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.Estado
			end as CDRWebEstado,
			Convert(varchar(10),FechaFacturado,103) as FechaFacturado
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Campania(NOLOCK) CA ON 
			P.CampaniaID=CA.CampaniaID
		INNER JOIN ods.Consultora(NOLOCK) CO ON 
			P.ConsultoraID=CO.ConsultoraID
		LEFT JOIN CDRWeb C on
			P.PedidoID = C.PedidoID
		WHERE 
			co.ConsultoraID=@ConsultoraID
			and	P.CampaniaID <> @CampaniaID
			and convert(date, p.FechaFacturado) >= convert(date, @FechaDesde)
		ORDER BY 
			CA.Codigo desc 
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[GetPedidosFacturadoSegunDias_SB2]
	@ConsultoraID int,
	@CampaniaID int,
	@maxDias int
AS
BEGIN
	set @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME
	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()

	set @FechaDesde = @FechaDesde - @maxDias
	
		SELECT
			CA.CODIGO AS CampaniaID,
			P.MontoFacturado AS ImporteTotal,
			P.Flete,
			P.PedidoID,
			isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
			isnull(P.Origen,'') as CanalIngreso,
			isnull(p.NumeroPedido,0) as NumeroPedido,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.CDRWebID
			end as CDRWebID,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.Estado
			end as CDRWebEstado,
			Convert(varchar(10),FechaFacturado,103) as FechaFacturado
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Campania(NOLOCK) CA ON 
			P.CampaniaID=CA.CampaniaID
		INNER JOIN ods.Consultora(NOLOCK) CO ON 
			P.ConsultoraID=CO.ConsultoraID
		LEFT JOIN CDRWeb C on
			P.PedidoID = C.PedidoID
		WHERE 
			co.ConsultoraID=@ConsultoraID
			and	P.CampaniaID <> @CampaniaID
			and convert(date, p.FechaFacturado) >= convert(date, @FechaDesde)
		ORDER BY 
			CA.Codigo desc 
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[GetPedidosFacturadoSegunDias_SB2]
	@ConsultoraID int,
	@CampaniaID int,
	@maxDias int
AS
BEGIN
	set @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME
	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()

	set @FechaDesde = @FechaDesde - @maxDias
	
		SELECT
			CA.CODIGO AS CampaniaID,
			P.MontoFacturado AS ImporteTotal,
			P.Flete,
			P.PedidoID,
			isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
			isnull(P.Origen,'') as CanalIngreso,
			isnull(p.NumeroPedido,0) as NumeroPedido,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.CDRWebID
			end as CDRWebID,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.Estado
			end as CDRWebEstado,
			Convert(varchar(10),FechaFacturado,103) as FechaFacturado
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Campania(NOLOCK) CA ON 
			P.CampaniaID=CA.CampaniaID
		INNER JOIN ods.Consultora(NOLOCK) CO ON 
			P.ConsultoraID=CO.ConsultoraID
		LEFT JOIN CDRWeb C on
			P.PedidoID = C.PedidoID
		WHERE 
			co.ConsultoraID=@ConsultoraID
			and	P.CampaniaID <> @CampaniaID
			and convert(date, p.FechaFacturado) >= convert(date, @FechaDesde)
		ORDER BY 
			CA.Codigo desc 
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[GetPedidosFacturadoSegunDias_SB2]
	@ConsultoraID int,
	@CampaniaID int,
	@maxDias int
AS
BEGIN
	set @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME
	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()

	set @FechaDesde = @FechaDesde - @maxDias
	
		SELECT
			CA.CODIGO AS CampaniaID,
			P.MontoFacturado AS ImporteTotal,
			P.Flete,
			P.PedidoID,
			isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
			isnull(P.Origen,'') as CanalIngreso,
			isnull(p.NumeroPedido,0) as NumeroPedido,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.CDRWebID
			end as CDRWebID,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.Estado
			end as CDRWebEstado,
			Convert(varchar(10),FechaFacturado,103) as FechaFacturado
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Campania(NOLOCK) CA ON 
			P.CampaniaID=CA.CampaniaID
		INNER JOIN ods.Consultora(NOLOCK) CO ON 
			P.ConsultoraID=CO.ConsultoraID
		LEFT JOIN CDRWeb C on
			P.PedidoID = C.PedidoID
		WHERE 
			co.ConsultoraID=@ConsultoraID
			and	P.CampaniaID <> @CampaniaID
			and convert(date, p.FechaFacturado) >= convert(date, @FechaDesde)
		ORDER BY 
			CA.Codigo desc 
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[GetPedidosFacturadoSegunDias_SB2]
	@ConsultoraID int,
	@CampaniaID int,
	@maxDias int
AS
BEGIN
	set @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME
	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()

	set @FechaDesde = @FechaDesde - @maxDias
	
		SELECT
			CA.CODIGO AS CampaniaID,
			P.MontoFacturado AS ImporteTotal,
			P.Flete,
			P.PedidoID,
			isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
			isnull(P.Origen,'') as CanalIngreso,
			isnull(p.NumeroPedido,0) as NumeroPedido,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.CDRWebID
			end as CDRWebID,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.Estado
			end as CDRWebEstado,
			Convert(varchar(10),FechaFacturado,103) as FechaFacturado
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Campania(NOLOCK) CA ON 
			P.CampaniaID=CA.CampaniaID
		INNER JOIN ods.Consultora(NOLOCK) CO ON 
			P.ConsultoraID=CO.ConsultoraID
		LEFT JOIN CDRWeb C on
			P.PedidoID = C.PedidoID
		WHERE 
			co.ConsultoraID=@ConsultoraID
			and	P.CampaniaID <> @CampaniaID
			and convert(date, p.FechaFacturado) >= convert(date, @FechaDesde)
		ORDER BY 
			CA.Codigo desc 
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[GetPedidosFacturadoSegunDias_SB2]
	@ConsultoraID int,
	@CampaniaID int,
	@maxDias int
AS
BEGIN
	set @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME
	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()

	set @FechaDesde = @FechaDesde - @maxDias
	
		SELECT
			CA.CODIGO AS CampaniaID,
			P.MontoFacturado AS ImporteTotal,
			P.Flete,
			P.PedidoID,
			isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
			isnull(P.Origen,'') as CanalIngreso,
			isnull(p.NumeroPedido,0) as NumeroPedido,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.CDRWebID
			end as CDRWebID,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.Estado
			end as CDRWebEstado,
			Convert(varchar(10),FechaFacturado,103) as FechaFacturado
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Campania(NOLOCK) CA ON 
			P.CampaniaID=CA.CampaniaID
		INNER JOIN ods.Consultora(NOLOCK) CO ON 
			P.ConsultoraID=CO.ConsultoraID
		LEFT JOIN CDRWeb C on
			P.PedidoID = C.PedidoID
		WHERE 
			co.ConsultoraID=@ConsultoraID
			and	P.CampaniaID <> @CampaniaID
			and convert(date, p.FechaFacturado) >= convert(date, @FechaDesde)
		ORDER BY 
			CA.Codigo desc 
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[GetPedidosFacturadoSegunDias_SB2]
	@ConsultoraID int,
	@CampaniaID int,
	@maxDias int
AS
BEGIN
	set @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME
	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()

	set @FechaDesde = @FechaDesde - @maxDias
	
		SELECT
			CA.CODIGO AS CampaniaID,
			P.MontoFacturado AS ImporteTotal,
			P.Flete,
			P.PedidoID,
			isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
			isnull(P.Origen,'') as CanalIngreso,
			isnull(p.NumeroPedido,0) as NumeroPedido,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.CDRWebID
			end as CDRWebID,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.Estado
			end as CDRWebEstado,
			Convert(varchar(10),FechaFacturado,103) as FechaFacturado
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Campania(NOLOCK) CA ON 
			P.CampaniaID=CA.CampaniaID
		INNER JOIN ods.Consultora(NOLOCK) CO ON 
			P.ConsultoraID=CO.ConsultoraID
		LEFT JOIN CDRWeb C on
			P.PedidoID = C.PedidoID
		WHERE 
			co.ConsultoraID=@ConsultoraID
			and	P.CampaniaID <> @CampaniaID
			and convert(date, p.FechaFacturado) >= convert(date, @FechaDesde)
		ORDER BY 
			CA.Codigo desc 
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetPedidosFacturadoSegunDias_SB2]
	@ConsultoraID int,
	@CampaniaID int,
	@maxDias int
AS
BEGIN
	set @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME
	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()

	set @FechaDesde = @FechaDesde - @maxDias
	
		SELECT
			CA.CODIGO AS CampaniaID,
			P.MontoFacturado AS ImporteTotal,
			P.Flete,
			P.PedidoID,
			isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
			isnull(P.Origen,'') as CanalIngreso,
			isnull(p.NumeroPedido,0) as NumeroPedido,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.CDRWebID
			end as CDRWebID,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.Estado
			end as CDRWebEstado,
			Convert(varchar(10),FechaFacturado,103) as FechaFacturado
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Campania(NOLOCK) CA ON 
			P.CampaniaID=CA.CampaniaID
		INNER JOIN ods.Consultora(NOLOCK) CO ON 
			P.ConsultoraID=CO.ConsultoraID
		LEFT JOIN CDRWeb C on
			P.PedidoID = C.PedidoID
		WHERE 
			co.ConsultoraID=@ConsultoraID
			and	P.CampaniaID <> @CampaniaID
			and convert(date, p.FechaFacturado) >= convert(date, @FechaDesde)
		ORDER BY 
			CA.Codigo desc 
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[GetPedidosFacturadoSegunDias_SB2]
	@ConsultoraID int,
	@CampaniaID int,
	@maxDias int
AS
BEGIN
	set @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME
	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()

	set @FechaDesde = @FechaDesde - @maxDias
	
		SELECT
			CA.CODIGO AS CampaniaID,
			P.MontoFacturado AS ImporteTotal,
			P.Flete,
			P.PedidoID,
			isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
			isnull(P.Origen,'') as CanalIngreso,
			isnull(p.NumeroPedido,0) as NumeroPedido,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.CDRWebID
			end as CDRWebID,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.Estado
			end as CDRWebEstado,
			Convert(varchar(10),FechaFacturado,103) as FechaFacturado
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Campania(NOLOCK) CA ON 
			P.CampaniaID=CA.CampaniaID
		INNER JOIN ods.Consultora(NOLOCK) CO ON 
			P.ConsultoraID=CO.ConsultoraID
		LEFT JOIN CDRWeb C on
			P.PedidoID = C.PedidoID
		WHERE 
			co.ConsultoraID=@ConsultoraID
			and	P.CampaniaID <> @CampaniaID
			and convert(date, p.FechaFacturado) >= convert(date, @FechaDesde)
		ORDER BY 
			CA.Codigo desc 
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[GetPedidosFacturadoSegunDias_SB2]
	@ConsultoraID int,
	@CampaniaID int,
	@maxDias int
AS
BEGIN
	set @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME
	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()

	set @FechaDesde = @FechaDesde - @maxDias
	
		SELECT
			CA.CODIGO AS CampaniaID,
			P.MontoFacturado AS ImporteTotal,
			P.Flete,
			P.PedidoID,
			isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
			isnull(P.Origen,'') as CanalIngreso,
			isnull(p.NumeroPedido,0) as NumeroPedido,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.CDRWebID
			end as CDRWebID,
			case 
				when C.PedidoID is null or C.PedidoID = 0 then 0
				else C.Estado
			end as CDRWebEstado,
			Convert(varchar(10),FechaFacturado,103) as FechaFacturado
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Campania(NOLOCK) CA ON 
			P.CampaniaID=CA.CampaniaID
		INNER JOIN ods.Consultora(NOLOCK) CO ON 
			P.ConsultoraID=CO.ConsultoraID
		LEFT JOIN CDRWeb C on
			P.PedidoID = C.PedidoID
		WHERE 
			co.ConsultoraID=@ConsultoraID
			and	P.CampaniaID <> @CampaniaID
			and convert(date, p.FechaFacturado) >= convert(date, @FechaDesde)
		ORDER BY 
			CA.Codigo desc 
END
GO

