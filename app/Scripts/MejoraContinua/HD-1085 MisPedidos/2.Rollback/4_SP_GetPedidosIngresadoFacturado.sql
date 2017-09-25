GO
ALTER PROCEDURE dbo.GetPedidosIngresadoFacturado
@ConsultoraID INT,
@CampaniaID INT,
@ClienteID INT = NULL,
@top INT = 3
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @T1 TABLE 
	(
		id INT IDENTITY(1,1),
		EstadoPedido VARCHAR(1),
		CampaniaID INT,
		ImporteTotal MONEY,
		DescuentoProl MONEY,
		Flete MONEY,
		ImporteCredito MONEY,
		MotivoCreditoID INT,
		PaisID INT,
		Clientes SMALLINT,
		EstadoPedidoDesc VARCHAR(12),
		ConsultoraID BIGINT,
		PedidoID INT,
		FechaRegistro DATETIME,
		CanalIngreso VARCHAR(12),
		CantidadProductos INT
		
		PRIMARY KEY (id)
	)

	IF @ClienteID = 0
		SET @ClienteID = NULL

	INSERT INTO @T1
	(
		EstadoPedido,
		CampaniaID,
		ImporteTotal,
		DescuentoProl,
		Flete,
		ImporteCredito,
		MotivoCreditoID,
		PaisID,
		Clientes,
		EstadoPedidoDesc,
		ConsultoraID,
		PedidoID,
		FechaRegistro,
		CanalIngreso,
		CantidadProductos
	)
	-- agregar ingresados
	SELECT TOP 1
		'I' AS EstadoPedido,
		PW.CampaniaID,  
		PW.ImporteTotal,  
		PW.DescuentoProl,
		0 Flete,
		pw.ImporteCredito,  
		ISNULL(pw.MotivoCreditoID,0) MotivoCreditoID,  
		pw.PaisID,  
		PW.Clientes, 
		'INGRESADO' AS EstadoPedidoDesc,
		PW.ConsultoraID,  
		PW.PedidoID,
		PW.FechaRegistro,
		'WEB' AS CanalIngreso,
		SUM(PWD.Cantidad) AS CantidadProductos
	FROM dbo.PedidoWeb PW (NOLOCK)
	INNER JOIN dbo.PedidoWebDetalle PWD (NOLOCK)
	ON PW.PedidoID = PWD.PedidoID
	AND PW.CampaniaID = PWD.CampaniaID 
	WHERE PW.ConsultoraID = @ConsultoraID 
	AND ISNULL(PWD.ClienteID,0) = ISNULL(@ClienteID,ISNULL(PWD.ClienteID,0))
	AND PW.CampaniaID = @CampaniaID
	GROUP BY PW.CampaniaID, PW.ImporteTotal, PW.DescuentoProl, PW.ImporteCredito, ISNULL(PW.MotivoCreditoID,0), PW.PaisID, PW.Clientes, PW.ConsultoraID, PW.PedidoID, PW.FechaRegistro
	ORDER BY PW.CampaniaID DESC 

	INSERT INTO @T1
	(
		EstadoPedido,
		CampaniaID,
		ImporteTotal,
		DescuentoProl,
		Flete,
		ImporteCredito,
		MotivoCreditoID,
		PaisID,
		Clientes,
		EstadoPedidoDesc,
		ConsultoraID,
		PedidoID,
		FechaRegistro,
		CanalIngreso,
		CantidadProductos
	)
	-- agregar facturado
	SELECT TOP (@top) 
		'F',
		P.CampaniaID,
		SUM(P.ImporteTotal) AS ImporteTotal,
		0 AS DescuentoProl,
		0 AS Flete,
		0 ImporteCredito,
		0 MotivoCreditoID,
		0 PaisID,
		'' Clientes,
		'FACTURADO' AS EstadoPedidoDesc,
		@ConsultoraID AS ConsultoraID,
		0 AS PedidoID,
		ISNULL(p.FechaFacturado,'1900-01-01') AS FechaRegistro,
		'WEB' AS CanalIngreso,
		SUM(P.Cantidad) AS CantidadProductos
	FROM dbo.PedidoWebFacturado P (NOLOCK)
	WHERE P.ConsultoraID = @ConsultoraID
	AND ISNULL(P.ClienteID,0) = ISNULL(@ClienteID,ISNULL(P.ClienteID,0))
	GROUP BY P.CampaniaID, P.FechaFacturado
	ORDER BY P.CampaniaID DESC 

	-- eliminar repetido, <> @CampaniaID, prioridad F
	DELETE @T1
	FROM @T1 T
	INNER JOIN 
	(
		SELECT 
			CampaniaID
		FROM @T1
		GROUP BY CampaniaID
		HAVING COUNT(EstadoPedido) > 1
	) AS R
	ON R.CampaniaID = T.CampaniaID 
	AND T.EstadoPedido = 'I'

	SELECT TOP (@top)
		CampaniaID,
		ImporteTotal,
		DescuentoProl,
		Flete,
		ImporteCredito,
		MotivoCreditoID, 
		PaisID,
		Clientes, 
		EstadoPedidoDesc,
		ConsultoraID,
		PedidoID,
		FechaRegistro,
		CanalIngreso,
		CantidadProductos 
	FROM @T1 
	ORDER BY CampaniaID DESC
	
	SET NOCOUNT OFF
END
GO