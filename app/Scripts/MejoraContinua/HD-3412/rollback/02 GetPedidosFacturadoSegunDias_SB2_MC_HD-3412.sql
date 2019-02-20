USE BelcorpPeru
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2 @ConsultoraID INT
	,@CampaniaID INT
	,@maxDias INT
AS
/*
GetPedidosFacturadoSegunDias_SB2 2, 201617, 142
GetPedidosFacturadoSegunDias_SB2 49401160, 201617, 142
*/
BEGIN
	SET @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME

	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()
	SET @FechaDesde = @FechaDesde - @maxDias

	SELECT CA.CODIGO AS CampaniaID
		,P.MontoFacturado AS ImporteTotal
		,P.Flete
		,P.PedidoID
		,isnull(p.FechaFacturado, '1900-01-01') AS FechaRegistro
		,isnull(P.Origen, '') AS CanalIngreso
		,isnull(p.NumeroPedido, 0) AS NumeroPedido
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.CDRWebID
			END AS CDRWebID
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.Estado
			END AS CDRWebEstado
	FROM ods.Pedido(NOLOCK) P
	INNER JOIN ods.Campania(NOLOCK) CA ON P.CampaniaID = CA.CampaniaID
	INNER JOIN ods.Consultora(NOLOCK) CO ON P.ConsultoraID = CO.ConsultoraID
	LEFT JOIN CDRWeb C ON P.PedidoID = C.PedidoID
	WHERE co.ConsultoraID = @ConsultoraID
		AND P.CampaniaID <> @CampaniaID
		AND convert(DATE, p.FechaFacturado) >= convert(DATE, @FechaDesde)
	ORDER BY CA.Codigo DESC
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2 @ConsultoraID INT
	,@CampaniaID INT
	,@maxDias INT
AS
/*
GetPedidosFacturadoSegunDias_SB2 2, 201617, 142
GetPedidosFacturadoSegunDias_SB2 49401160, 201617, 142
*/
BEGIN
	SET @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME

	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()
	SET @FechaDesde = @FechaDesde - @maxDias

	SELECT CA.CODIGO AS CampaniaID
		,P.MontoFacturado AS ImporteTotal
		,P.Flete
		,P.PedidoID
		,isnull(p.FechaFacturado, '1900-01-01') AS FechaRegistro
		,isnull(P.Origen, '') AS CanalIngreso
		,isnull(p.NumeroPedido, 0) AS NumeroPedido
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.CDRWebID
			END AS CDRWebID
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.Estado
			END AS CDRWebEstado
	FROM ods.Pedido(NOLOCK) P
	INNER JOIN ods.Campania(NOLOCK) CA ON P.CampaniaID = CA.CampaniaID
	INNER JOIN ods.Consultora(NOLOCK) CO ON P.ConsultoraID = CO.ConsultoraID
	LEFT JOIN CDRWeb C ON P.PedidoID = C.PedidoID
	WHERE co.ConsultoraID = @ConsultoraID
		AND P.CampaniaID <> @CampaniaID
		AND convert(DATE, p.FechaFacturado) >= convert(DATE, @FechaDesde)
	ORDER BY CA.Codigo DESC
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2 @ConsultoraID INT
	,@CampaniaID INT
	,@maxDias INT
AS
/*
GetPedidosFacturadoSegunDias_SB2 2, 201617, 142
GetPedidosFacturadoSegunDias_SB2 49401160, 201617, 142
*/
BEGIN
	SET @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME

	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()
	SET @FechaDesde = @FechaDesde - @maxDias

	SELECT CA.CODIGO AS CampaniaID
		,P.MontoFacturado AS ImporteTotal
		,P.Flete
		,P.PedidoID
		,isnull(p.FechaFacturado, '1900-01-01') AS FechaRegistro
		,isnull(P.Origen, '') AS CanalIngreso
		,isnull(p.NumeroPedido, 0) AS NumeroPedido
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.CDRWebID
			END AS CDRWebID
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.Estado
			END AS CDRWebEstado
	FROM ods.Pedido(NOLOCK) P
	INNER JOIN ods.Campania(NOLOCK) CA ON P.CampaniaID = CA.CampaniaID
	INNER JOIN ods.Consultora(NOLOCK) CO ON P.ConsultoraID = CO.ConsultoraID
	LEFT JOIN CDRWeb C ON P.PedidoID = C.PedidoID
	WHERE co.ConsultoraID = @ConsultoraID
		AND P.CampaniaID <> @CampaniaID
		AND convert(DATE, p.FechaFacturado) >= convert(DATE, @FechaDesde)
	ORDER BY CA.Codigo DESC
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2 @ConsultoraID INT
	,@CampaniaID INT
	,@maxDias INT
AS
/*
GetPedidosFacturadoSegunDias_SB2 2, 201617, 142
GetPedidosFacturadoSegunDias_SB2 49401160, 201617, 142
*/
BEGIN
	SET @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME

	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()
	SET @FechaDesde = @FechaDesde - @maxDias

	SELECT CA.CODIGO AS CampaniaID
		,P.MontoFacturado AS ImporteTotal
		,P.Flete
		,P.PedidoID
		,isnull(p.FechaFacturado, '1900-01-01') AS FechaRegistro
		,isnull(P.Origen, '') AS CanalIngreso
		,isnull(p.NumeroPedido, 0) AS NumeroPedido
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.CDRWebID
			END AS CDRWebID
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.Estado
			END AS CDRWebEstado
	FROM ods.Pedido(NOLOCK) P
	INNER JOIN ods.Campania(NOLOCK) CA ON P.CampaniaID = CA.CampaniaID
	INNER JOIN ods.Consultora(NOLOCK) CO ON P.ConsultoraID = CO.ConsultoraID
	LEFT JOIN CDRWeb C ON P.PedidoID = C.PedidoID
	WHERE co.ConsultoraID = @ConsultoraID
		AND P.CampaniaID <> @CampaniaID
		AND convert(DATE, p.FechaFacturado) >= convert(DATE, @FechaDesde)
	ORDER BY CA.Codigo DESC
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2 @ConsultoraID INT
	,@CampaniaID INT
	,@maxDias INT
AS
/*
GetPedidosFacturadoSegunDias_SB2 2, 201617, 142
GetPedidosFacturadoSegunDias_SB2 49401160, 201617, 142
*/
BEGIN
	SET @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME

	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()
	SET @FechaDesde = @FechaDesde - @maxDias

	SELECT CA.CODIGO AS CampaniaID
		,P.MontoFacturado AS ImporteTotal
		,P.Flete
		,P.PedidoID
		,isnull(p.FechaFacturado, '1900-01-01') AS FechaRegistro
		,isnull(P.Origen, '') AS CanalIngreso
		,isnull(p.NumeroPedido, 0) AS NumeroPedido
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.CDRWebID
			END AS CDRWebID
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.Estado
			END AS CDRWebEstado
	FROM ods.Pedido(NOLOCK) P
	INNER JOIN ods.Campania(NOLOCK) CA ON P.CampaniaID = CA.CampaniaID
	INNER JOIN ods.Consultora(NOLOCK) CO ON P.ConsultoraID = CO.ConsultoraID
	LEFT JOIN CDRWeb C ON P.PedidoID = C.PedidoID
	WHERE co.ConsultoraID = @ConsultoraID
		AND P.CampaniaID <> @CampaniaID
		AND convert(DATE, p.FechaFacturado) >= convert(DATE, @FechaDesde)
	ORDER BY CA.Codigo DESC
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2 @ConsultoraID INT
	,@CampaniaID INT
	,@maxDias INT
AS
/*
GetPedidosFacturadoSegunDias_SB2 2, 201617, 142
GetPedidosFacturadoSegunDias_SB2 49401160, 201617, 142
*/
BEGIN
	SET @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME

	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()
	SET @FechaDesde = @FechaDesde - @maxDias

	SELECT CA.CODIGO AS CampaniaID
		,P.MontoFacturado AS ImporteTotal
		,P.Flete
		,P.PedidoID
		,isnull(p.FechaFacturado, '1900-01-01') AS FechaRegistro
		,isnull(P.Origen, '') AS CanalIngreso
		,isnull(p.NumeroPedido, 0) AS NumeroPedido
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.CDRWebID
			END AS CDRWebID
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.Estado
			END AS CDRWebEstado
	FROM ods.Pedido(NOLOCK) P
	INNER JOIN ods.Campania(NOLOCK) CA ON P.CampaniaID = CA.CampaniaID
	INNER JOIN ods.Consultora(NOLOCK) CO ON P.ConsultoraID = CO.ConsultoraID
	LEFT JOIN CDRWeb C ON P.PedidoID = C.PedidoID
	WHERE co.ConsultoraID = @ConsultoraID
		AND P.CampaniaID <> @CampaniaID
		AND convert(DATE, p.FechaFacturado) >= convert(DATE, @FechaDesde)
	ORDER BY CA.Codigo DESC
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2 @ConsultoraID INT
	,@CampaniaID INT
	,@maxDias INT
AS
/*
GetPedidosFacturadoSegunDias_SB2 2, 201617, 142
GetPedidosFacturadoSegunDias_SB2 49401160, 201617, 142
*/
BEGIN
	SET @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME

	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()
	SET @FechaDesde = @FechaDesde - @maxDias

	SELECT CA.CODIGO AS CampaniaID
		,P.MontoFacturado AS ImporteTotal
		,P.Flete
		,P.PedidoID
		,isnull(p.FechaFacturado, '1900-01-01') AS FechaRegistro
		,isnull(P.Origen, '') AS CanalIngreso
		,isnull(p.NumeroPedido, 0) AS NumeroPedido
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.CDRWebID
			END AS CDRWebID
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.Estado
			END AS CDRWebEstado
	FROM ods.Pedido(NOLOCK) P
	INNER JOIN ods.Campania(NOLOCK) CA ON P.CampaniaID = CA.CampaniaID
	INNER JOIN ods.Consultora(NOLOCK) CO ON P.ConsultoraID = CO.ConsultoraID
	LEFT JOIN CDRWeb C ON P.PedidoID = C.PedidoID
	WHERE co.ConsultoraID = @ConsultoraID
		AND P.CampaniaID <> @CampaniaID
		AND convert(DATE, p.FechaFacturado) >= convert(DATE, @FechaDesde)
	ORDER BY CA.Codigo DESC
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2 @ConsultoraID INT
	,@CampaniaID INT
	,@maxDias INT
AS
/*
GetPedidosFacturadoSegunDias_SB2 2, 201617, 142
GetPedidosFacturadoSegunDias_SB2 49401160, 201617, 142
*/
BEGIN
	SET @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME

	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()
	SET @FechaDesde = @FechaDesde - @maxDias

	SELECT CA.CODIGO AS CampaniaID
		,P.MontoFacturado AS ImporteTotal
		,P.Flete
		,P.PedidoID
		,isnull(p.FechaFacturado, '1900-01-01') AS FechaRegistro
		,isnull(P.Origen, '') AS CanalIngreso
		,isnull(p.NumeroPedido, 0) AS NumeroPedido
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.CDRWebID
			END AS CDRWebID
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.Estado
			END AS CDRWebEstado
	FROM ods.Pedido(NOLOCK) P
	INNER JOIN ods.Campania(NOLOCK) CA ON P.CampaniaID = CA.CampaniaID
	INNER JOIN ods.Consultora(NOLOCK) CO ON P.ConsultoraID = CO.ConsultoraID
	LEFT JOIN CDRWeb C ON P.PedidoID = C.PedidoID
	WHERE co.ConsultoraID = @ConsultoraID
		AND P.CampaniaID <> @CampaniaID
		AND convert(DATE, p.FechaFacturado) >= convert(DATE, @FechaDesde)
	ORDER BY CA.Codigo DESC
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2 @ConsultoraID INT
	,@CampaniaID INT
	,@maxDias INT
AS
/*
GetPedidosFacturadoSegunDias_SB2 2, 201617, 142
GetPedidosFacturadoSegunDias_SB2 49401160, 201617, 142
*/
BEGIN
	SET @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME

	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()
	SET @FechaDesde = @FechaDesde - @maxDias

	SELECT CA.CODIGO AS CampaniaID
		,P.MontoFacturado AS ImporteTotal
		,P.Flete
		,P.PedidoID
		,isnull(p.FechaFacturado, '1900-01-01') AS FechaRegistro
		,isnull(P.Origen, '') AS CanalIngreso
		,isnull(p.NumeroPedido, 0) AS NumeroPedido
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.CDRWebID
			END AS CDRWebID
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.Estado
			END AS CDRWebEstado
	FROM ods.Pedido(NOLOCK) P
	INNER JOIN ods.Campania(NOLOCK) CA ON P.CampaniaID = CA.CampaniaID
	INNER JOIN ods.Consultora(NOLOCK) CO ON P.ConsultoraID = CO.ConsultoraID
	LEFT JOIN CDRWeb C ON P.PedidoID = C.PedidoID
	WHERE co.ConsultoraID = @ConsultoraID
		AND P.CampaniaID <> @CampaniaID
		AND convert(DATE, p.FechaFacturado) >= convert(DATE, @FechaDesde)
	ORDER BY CA.Codigo DESC
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2 @ConsultoraID INT
	,@CampaniaID INT
	,@maxDias INT
AS
/*
GetPedidosFacturadoSegunDias_SB2 2, 201617, 142
GetPedidosFacturadoSegunDias_SB2 49401160, 201617, 142
*/
BEGIN
	SET @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME

	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()
	SET @FechaDesde = @FechaDesde - @maxDias

	SELECT CA.CODIGO AS CampaniaID
		,P.MontoFacturado AS ImporteTotal
		,P.Flete
		,P.PedidoID
		,isnull(p.FechaFacturado, '1900-01-01') AS FechaRegistro
		,isnull(P.Origen, '') AS CanalIngreso
		,isnull(p.NumeroPedido, 0) AS NumeroPedido
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.CDRWebID
			END AS CDRWebID
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.Estado
			END AS CDRWebEstado
	FROM ods.Pedido(NOLOCK) P
	INNER JOIN ods.Campania(NOLOCK) CA ON P.CampaniaID = CA.CampaniaID
	INNER JOIN ods.Consultora(NOLOCK) CO ON P.ConsultoraID = CO.ConsultoraID
	LEFT JOIN CDRWeb C ON P.PedidoID = C.PedidoID
	WHERE co.ConsultoraID = @ConsultoraID
		AND P.CampaniaID <> @CampaniaID
		AND convert(DATE, p.FechaFacturado) >= convert(DATE, @FechaDesde)
	ORDER BY CA.Codigo DESC
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2 @ConsultoraID INT
	,@CampaniaID INT
	,@maxDias INT
AS
/*
GetPedidosFacturadoSegunDias_SB2 2, 201617, 142
GetPedidosFacturadoSegunDias_SB2 49401160, 201617, 142
*/
BEGIN
	SET @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME

	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()
	SET @FechaDesde = @FechaDesde - @maxDias

	SELECT CA.CODIGO AS CampaniaID
		,P.MontoFacturado AS ImporteTotal
		,P.Flete
		,P.PedidoID
		,isnull(p.FechaFacturado, '1900-01-01') AS FechaRegistro
		,isnull(P.Origen, '') AS CanalIngreso
		,isnull(p.NumeroPedido, 0) AS NumeroPedido
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.CDRWebID
			END AS CDRWebID
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.Estado
			END AS CDRWebEstado
	FROM ods.Pedido(NOLOCK) P
	INNER JOIN ods.Campania(NOLOCK) CA ON P.CampaniaID = CA.CampaniaID
	INNER JOIN ods.Consultora(NOLOCK) CO ON P.ConsultoraID = CO.ConsultoraID
	LEFT JOIN CDRWeb C ON P.PedidoID = C.PedidoID
	WHERE co.ConsultoraID = @ConsultoraID
		AND P.CampaniaID <> @CampaniaID
		AND convert(DATE, p.FechaFacturado) >= convert(DATE, @FechaDesde)
	ORDER BY CA.Codigo DESC
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE dbo.GetPedidosFacturadoSegunDias_SB2 @ConsultoraID INT
	,@CampaniaID INT
	,@maxDias INT
AS
/*
GetPedidosFacturadoSegunDias_SB2 2, 201617, 142
GetPedidosFacturadoSegunDias_SB2 49401160, 201617, 142
*/
BEGIN
	SET @maxDias = isnull(@maxDias, 0)

	DECLARE @FechaDesde DATETIME

	SET @FechaDesde = dbo.fnObtenerFechaHoraPais()
	SET @FechaDesde = @FechaDesde - @maxDias

	SELECT CA.CODIGO AS CampaniaID
		,P.MontoFacturado AS ImporteTotal
		,P.Flete
		,P.PedidoID
		,isnull(p.FechaFacturado, '1900-01-01') AS FechaRegistro
		,isnull(P.Origen, '') AS CanalIngreso
		,isnull(p.NumeroPedido, 0) AS NumeroPedido
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.CDRWebID
			END AS CDRWebID
		,CASE 
			WHEN C.PedidoID IS NULL
				OR C.PedidoID = 0
				THEN 0
			ELSE C.Estado
			END AS CDRWebEstado
	FROM ods.Pedido(NOLOCK) P
	INNER JOIN ods.Campania(NOLOCK) CA ON P.CampaniaID = CA.CampaniaID
	INNER JOIN ods.Consultora(NOLOCK) CO ON P.ConsultoraID = CO.ConsultoraID
	LEFT JOIN CDRWeb C ON P.PedidoID = C.PedidoID
	WHERE co.ConsultoraID = @ConsultoraID
		AND P.CampaniaID <> @CampaniaID
		AND convert(DATE, p.FechaFacturado) >= convert(DATE, @FechaDesde)
	ORDER BY CA.Codigo DESC
END
GO


