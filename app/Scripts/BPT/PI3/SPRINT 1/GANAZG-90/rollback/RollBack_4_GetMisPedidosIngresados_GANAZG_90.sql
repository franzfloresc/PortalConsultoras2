USE [BelcorpPeru]
GO
/****** Object:  StoredProcedure [dbo].[GetMisPedidosIngresados]    Script Date: 24/01/2019 18:00:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetMisPedidosIngresados]
@ConsultoraID BIGINT,
@CampaniaID INT,
@ClienteID SMALLINT,
@NombreConsultora VARCHAR(200)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @TBL_PEDIDO TABLE
	(
		ClienteID SMALLINT NOT NULL,
		NombreCliente VARCHAR(200) NOT NULL,
		CUV VARCHAR(20) NOT NULL,
		DescripcionProducto VARCHAR(200) NOT NULL,
		Cantidad INT NOT NULL,
		PrecioUnidad MONEY NOT NULL,
		ImporteTotal MONEY NOT NULL

		PRIMARY KEY(ClienteID, CUV)
	)

	DECLARE @TBL_PEDIDO_ORDEN TABLE
	(
		NroOrden INT IDENTITY(1,1) NOT NULL,
		ClienteID SMALLINT NOT NULL

		PRIMARY KEY(NroOrden)
	)

	IF @ClienteID = 0
		SET @ClienteID = NULL

	INSERT INTO @TBL_PEDIDO
	(
		ClienteID,
		NombreCliente,
		CUV,
		DescripcionProducto,
		Cantidad,
		PrecioUnidad,
		ImporteTotal
	)
	SELECT 
		ISNULL(PWD.ClienteID, 0),
		ISNULL(CLI.Nombre, @NombreConsultora),
		PWD.CUV,
		PC.Descripcion,
		PWD.Cantidad,
		PWD.PrecioUnidad,
		PWD.ImporteTotal
	FROM dbo.PedidoWebDetalle PWD (NOLOCK)
	INNER JOIN ods.ProductoComercial PC (NOLOCK)
	ON PC.AnoCampania = PWD.CampaniaID
	AND PC.CUV = PWD.CUV
	LEFT JOIN dbo.Cliente CLI (NOLOCK)
	ON CLI.ConsultoraID = PWD.ConsultoraID
	AND CLI.ClienteID = PWD.ClienteID
	WHERE PWD.ConsultoraID = @ConsultoraID
	AND PWD.CampaniaID = @CampaniaID
	AND ISNULL(PWD.ClienteID, 0) = CASE WHEN @ClienteID = -1 THEN 0 ELSE ISNULL(@ClienteID, ISNULL(PWD.ClienteID, 0)) END

	INSERT INTO @TBL_PEDIDO_ORDEN
	SELECT ClienteID
	FROM @TBL_PEDIDO
	WHERE ClienteID = 0
	GROUP BY ClienteID

	INSERT INTO @TBL_PEDIDO_ORDEN
	SELECT ClienteID
	FROM @TBL_PEDIDO
	WHERE ClienteID > 0
	GROUP BY ClienteID
	ORDER BY MAX(NombreCliente)

	SELECT 
		@CampaniaID AS CampaniaID,
		PED.ClienteID,
		MAX(PED.NombreCliente) AS NombreCliente,
		SUM(PED.Cantidad) AS CantidadPedido,
		SUM(PED.ImporteTotal) AS ImportePedido
	FROM @TBL_PEDIDO PED
	INNER JOIN @TBL_PEDIDO_ORDEN ORD
	ON PED.ClienteID = ORD.ClienteID
	GROUP BY PED.ClienteID
	ORDER BY MAX(ORD.NroOrden)

	SELECT
		ClienteID,
		CUV,
		DescripcionProducto,
		Cantidad,
		PrecioUnidad,
		ImporteTotal
	FROM @TBL_PEDIDO

	SET NOCOUNT OFF
END
