USE BelcorpPeru
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2
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
			end as CDRWebEstado
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
go

USE BelcorpMexico
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2
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
			end as CDRWebEstado
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
go

USE BelcorpColombia
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2
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
			end as CDRWebEstado
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
go

USE BelcorpSalvador
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2
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
			end as CDRWebEstado
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
go

USE BelcorpPuertoRico
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2
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
			end as CDRWebEstado
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
go

USE BelcorpPanama
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2
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
			end as CDRWebEstado
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
go

USE BelcorpGuatemala
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2
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
			end as CDRWebEstado
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
go

USE BelcorpEcuador
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2
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
			end as CDRWebEstado
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
go

USE BelcorpDominicana
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2
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
			end as CDRWebEstado
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
go

USE BelcorpCostaRica
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2
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
			end as CDRWebEstado
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
go

USE BelcorpChile
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2
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
			end as CDRWebEstado
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
go

USE BelcorpBolivia
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2
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
			end as CDRWebEstado
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
go

