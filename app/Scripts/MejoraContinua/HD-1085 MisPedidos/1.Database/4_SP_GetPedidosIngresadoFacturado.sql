GO
ALTER PROCEDURE dbo.GetPedidosIngresadoFacturado
@ConsultoraID INT,
@CampaniaID INT,
@ClienteID INT = NULL,
@top INT = 3
AS
BEGIN
	SET NOCOUNT ON;

	SET @ClienteID = ISNULL(@ClienteID,0);

	DECLARE @T1 TABLE (
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
		NumeroPedido int,
		FechaRegistro DATETIME,
		CanalIngreso VARCHAR(12),
		CantidadProductos INT
	)

	-- agregar ingresados
	if not exists(
		select 1
		from ods.Pedido(nolock) P
		inner join ods.Campania(nolock) C on P.CampaniaID = C.CampaniaID
		where C.Codigo = @CampaniaID and P.Origen = 'WEB'
	)
	begin
		insert into @T1
		select top 1
			'I' as EstadoPedido,
			PW.CampaniaID,
			PW.ImporteTotal,
			PW.DescuentoProl,
			0 Flete,
			pw.ImporteCredito,
			isnull(pw.MotivoCreditoID,0) MotivoCreditoID,
			pw.PaisID,
			PW.Clientes,
			'INGRESADO' AS EstadoPedidoDesc,
			PW.ConsultoraID,
			PW.PedidoID,
			0,
			PW.FechaRegistro,
			'WEB' as CanalIngreso,
			sum(PWD.Cantidad) as CantidadProductos
		from PedidoWeb(nolock) PW
		inner join PedidoWebDetalle(nolock) PWD ON PW.ConsultoraID = PWD.ConsultoraID and PW.CampaniaID = PWD.CampaniaID
		where
			pw.ConsultoraID = @ConsultoraID and
			PW.Campania = @CampaniaID and
			(@ClienteID = 0 OR @ClienteID = PWD.ClienteID)
		group by PW.CampaniaID, PW.ImporteTotal, PW.DescuentoProl,pw.ImporteCredito, isnull(pw.MotivoCreditoID,0),
			pw.PaisID, PW.Clientes, PW.ConsultoraID, PW.PedidoID,	PW.FechaRegistro
		ORDER BY PW.CampaniaID desc;
	end

	-- agregar facturado
	INSERT INTO @T1
	SELECT top (@top) 
		'F',
		CA.CODIGO AS CampaniaID,
		P.MontoFacturado AS ImporteTotal,
		0 as DescuentoProl,
		P.Flete,
		0 ImporteCredito,
		0 MotivoCreditoID,
		0 PaisID,
		'' Clientes,
		'FACTURADO' AS EstadoPedidoDesc,
		0 ConsultoraID,
		P.PedidoID,
		P.NumeroPedido,
		isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
		isnull(P.Origen,'') as CanalIngreso,
		sum(PD.Cantidad) as CantidadProductos
	FROM ods.Pedido(NOLOCK) P 
	INNER JOIN ods.PedidoDetalle(NOLOCK) PD ON P.PedidoID=PD.PedidoID
	INNER JOIN ods.ProductoComercial (nolock) PC ON PD.CampaniaID = PC.CampaniaID and PD.CUV = PC.CUV
	INNER JOIN ods.Campania(NOLOCK) CA ON P.CampaniaID=CA.CampaniaID
	LEFT JOIN PedidoWebFacturado(nolock) PWF ON 
		P.Origen = 'WEB' and PWF.ConsultoraID = P.ConsultoraID and
		PWF.CampaniaID = CA.Codigo and PWF.CUV = PD.CUV
	WHERE
		P.ConsultoraID=@ConsultoraID and
		(@ClienteID = 0 OR PWF.ClienteID = @ClienteID)
	GROUP BY P.PedidoID,P.NumeroPedido,CA.Codigo,P.MontoFacturado,P.Origen,P.Flete,p.FechaFacturado
	ORDER BY CA.Codigo desc 

	-- solo los 4 correlativos anteriores de la campaña actual
	declare @CampaniaAnterior int = ffvv.fnGetCampaniaAnterior(@CampaniaID, @top - 1)
	set @CampaniaAnterior = isnull(@CampaniaAnterior, 0)

	SELECT top (@top)
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
	where CampaniaID >= @CampaniaAnterior
	order by CampaniaID desc;
END
GO