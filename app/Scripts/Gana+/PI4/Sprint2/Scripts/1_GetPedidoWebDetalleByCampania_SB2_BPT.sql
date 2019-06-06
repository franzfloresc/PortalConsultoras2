﻿
ALTER PROCEDURE [dbo].[GetPedidoWebDetalleByCampania]
	@CampaniaID INT
	,@ConsultoraID BIGINT
	,@CodigoPrograma VARCHAR(15) = NULL
	,@NumeroPedido INT = 0
	,@AgruparSet BIT = 0
AS
BEGIN
	--DECLARE @FechaRegistroPedido DATE
	--DECLARE @FechaInicioSetAgrupado DATE

	--SET @FechaInicioSetAgrupado = (
	--		SELECT datefromparts(valor1, valor2, valor3)
	--		FROM configuracionpaisdatos
	--		WHERE Codigo = 'InicioFechaSetAGrupados'
	--		)

	--SELECT @FechaRegistroPedido = FechaRegistro
	--FROM PedidoWeb WITH (NOLOCK)
	--WHERE CampaniaID = @CampaniaID
	--	AND ConsultoraID = @ConsultoraID

	SET NOCOUNT ON
	SET @CodigoPrograma = NULLIF(@CodigoPrograma, '');
	SET @NumeroPedido = @NumeroPedido + 1;

	--INI /* HD-4200 */
	declare @tblSuscripcionSE table
	(
		CUV varchar(6),
		Cantidad int,
		CampaniaID int
	)

	insert into @tblSuscripcionSE
	(CUV,
	Cantidad,
	CampaniaID)
	select  se.CUV,
			se.Cantidad,
			se.Campania
	from ods.SuscripcionExclusivosSE se
	inner join ods.Consultora co on co.Codigo=se.CodigoCliente and co.esconsultoralider=1
	where co.ConsultoraID = @ConsultoraID
	and se.Campania=@CampaniaID
	--FIN /* HD-4200 */

	IF (
			@AgruparSet = 1
			--AND (CAST(@FechaRegistroPedido AS DATE) > CAST(@FechaInicioSetAgrupado AS DATE))
			)
	BEGIN

		DECLARE @PedidoDetalle2 AS TABLE (
			CampaniaID INT
			,PedidoID INT
			,PedidoDetalleID INT
			,MarcaID TINYINT
			,ConsultoraID BIGINT
			,ClienteID SMALLINT
			,OrdenPedidoWD INT
			,Cantidad INT
			,PrecioUnidad MONEY
			,ImporteTotal MONEY
			,CUV VARCHAR(20)
			,EsKitNueva BIT
			,DescripcionProd VARCHAR(800)
			,ClienteNombre VARCHAR(200)
			,OfertaWeb BIT
			,IndicadorMontoMinimo INT
			,ConfiguracionOfertaID INT
			,TipoOfertaSisID INT
			,TipoPedido CHAR(1)
			,DescripcionOferta VARCHAR(200)
			,MarcaDescripcion VARCHAR(20)
			,CategoriaNombre VARCHAR(50)
			,DescripcionEstrategia VARCHAR(200)
			,TipoEstrategiaID INT
			,IndicadorOfertaCUV BIT
			,FlagConsultoraOnline INT
			,DescuentoProl MONEY
			,MontoEscala MONEY
			,MontoAhorroCatalogo MONEY
			,MontoAhorroRevista MONEY
			,OrigenPedidoWeb INT
			,EsBackOrder BIT
			,AceptoBackOrder BIT
			,CodigoCatalago CHAR(6)
			,TipoEstrategiaCodigo VARCHAR(100)
			,EsOfertaIndependiente BIT
			,CodigoTipoOferta CHAR(6)
			,CodigoTipoEstrategia CHAR(3)
			,ObservacionProl VARCHAR(500)
			,GananciaTotal numeric(15,2)
			,PRIMARY KEY (
				CampaniaID
				,PedidoID
				,PedidoDetalleID
				)
			)

		INSERT INTO @PedidoDetalle2
		SELECT PWD.CampaniaID
			,PWD.PedidoID
			,PWD.PedidoDetalleID
			,PWD.MarcaID
			,PWD.ConsultoraID
			,PWD.ClienteID
			,PWD.OrdenPedidoWD
			,PWD.Cantidad
			,PWD.PrecioUnidad
			,PWD.ImporteTotal
			,PWD.CUV
			,PWD.EsKitNueva
			,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PC.Descripcion) AS DescripcionProd
			,C.Nombre AS ClienteNombre
			,PWD.OfertaWeb
			,PC.IndicadorMontoMinimo
			,PWD.ConfiguracionOfertaID
			,PWD.TipoOfertaSisID
			,PWD.TipoPedido
			,'' AS DescripcionOferta
			,M.Descripcion AS MarcaDescripcion
			,'NO DISPONIBLE' AS Categoria
			,'' AS DescripcionEstrategia
			,PWD.TipoEstrategiaID
			,PC.IndicadorOferta AS IndicadorOfertaCUV
			,0 AS FlagConsultoraOnline
			,PW.DescuentoProl
			,PW.MontoEscala
			,PW.MontoAhorroCatalogo
			,PW.MontoAhorroRevista
			,PWD.OrigenPedidoWeb
			,PWD.EsBackOrder
			,PWD.AceptoBackOrder
			,PC.CodigoCatalago
			,'' AS TipoEstrategiaCodigo
			,0 AS EsOfertaIndependiente
			,PC.CodigoTipoOferta
			,ISNULL(TE.Codigo, '0')
			,PWD.ObservacionPROL
			,PC.GananciaTotal as Ganancia
		FROM dbo.PedidoWebDetalle PWD WITH (NOLOCK)
		INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) ON PW.CampaniaID = PWD.CampaniaID
			AND PW.PedidoID = PWD.PedidoID
			AND PW.ConsultoraID = PWD.ConsultoraID
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) ON PWD.CampaniaID = PC.AnoCampania
			AND PWD.CUV = PC.CUV
		LEFT JOIN dbo.Cliente C WITH (NOLOCK) ON PWD.ClienteID = C.ClienteID
			AND PWD.ConsultoraID = C.ConsultoraID
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PWD.CampaniaID = PD.CampaniaID
			AND PWD.CUV = PD.CUV
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PC.CampaniaID
			AND OP.CUV = PC.CUV
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.Marca M WITH (NOLOCK) ON PWD.MarcaId = M.MarcaId
		LEFT JOIN TipoEstrategia TE ON PWD.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE pwd.CampaniaID = @CampaniaID
			AND pwd.ConsultoraID = @ConsultoraID
			AND pwd.CUVPadre IS NULL

		DECLARE @Estrategia2 AS TABLE (
			EstrategiaID INT
			,TipoEstrategiaID INT
			,Activo BIT
			,CampaniaID INT
			,CampaniaIDFin INT
			,CUV2 VARCHAR(20)
			,Numeropedido INT
			,DescripcionEstrategia VARCHAR(800)
			,EsOfertaIndependiente BIT
			,FlagNueva BIT
			,DescripcionTipoEstrategia VARCHAR(200)
			,TipoEstrategiaCodigo VARCHAR(100)
			,CodigoPrograma VARCHAR(3)
			)

		--PRIMARY KEY (EstrategiaID)
		INSERT INTO @Estrategia2
		SELECT DISTINCT E.EstrategiaID
			,TE.TipoEstrategiaID
			,E.Activo
			,E.CampaniaID
			,E.CampaniaIDFin
			,E.CUV2
			,E.Numeropedido
			,E.DescripcionCUV2
			,E.EsOfertaIndependiente
			,COALESCE(TEP.FlagNueva, TE.FlagNueva)
			,COALESCE(TEP.NombreComercial, TE.NombreComercial)
			,COALESCE(TEP.Codigo, TE.Codigo)
			,COALESCE(TEP.CodigoPrograma, TE.CodigoPrograma)
		FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = E.TipoEstrategiaID
		INNER JOIN @PedidoDetalle2 PWD ON PWD.CampaniaID BETWEEN E.CampaniaID
				AND CASE
						WHEN ISNULL(E.CampaniaIDFin, 0) = 0
							THEN E.CampaniaID
						ELSE E.CampaniaIDFin
						END
			AND E.CUV2 = PWD.CUV
			AND E.Activo IN (0,1)
			--AND PWD.CodigoTipoEstrategia NOT IN (
			--	'001','030','008','007','005','010'
			--	)
		LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
		WHERE TE.FlagActivo = 1

		UNION

		SELECT EP.EstrategiaProductoId
			,TE.TipoEstrategiaID
			,E.Activo
			,E.CampaniaID
			,E.CampaniaIDFin
			,EP.CUV
			,E.Numeropedido
			,NULL AS DescripcionEstrategia
			,E.EsOfertaIndependiente
			,COALESCE(TEP.FlagNueva, TE.FlagNueva)
			,COALESCE(TEP.NombreComercial, TE.NombreComercial)
			,COALESCE(TEP.Codigo, TE.Codigo)
			,COALESCE(TEP.CodigoPrograma, TE.CodigoPrograma)
		FROM dbo.EstrategiaProducto EP
		INNER JOIN dbo.Estrategia E WITH (NOLOCK) ON EP.EstrategiaID = E.EstrategiaID
		INNER JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = E.TipoEstrategiaID
		INNER JOIN @PedidoDetalle2 PWD ON PWD.CampaniaID = EP.Campania
			AND EP.CUV = PWD.CUV
			AND EP.CUV2 != PWD.CUV
			--AND PWD.CodigoTipoEstrategia NOT IN (
			--	'001','030','008','007','005','010'
			--	)
		LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
		WHERE TE.FlagActivo = 1

		IF @CodigoPrograma IS NOT NULL
		BEGIN
			DELETE
			FROM @Estrategia2
			WHERE ISNULL(CodigoPrograma, '') <> ''
				AND Numeropedido <> @NumeroPedido
		END

		SELECT *
		FROM (
			SELECT PWD.CampaniaID
				,PWD.PedidoID
				,PWD.PedidoDetalleID
				,PWD.MarcaID
				,PWD.ConsultoraID
				,PWD.ClienteID
				,PWD.OrdenPedidoWD
				,PWD.Cantidad
				,PWD.PrecioUnidad
				,PWD.ImporteTotal
				,PWD.CUV
				,PWD.EsKitNueva
				,COALESCE(EST.DescripcionEstrategia, PWD.DescripcionProd) AS DescripcionProd
				,PWD.ClienteNombre AS Nombre
				,PWD.OfertaWeb
				,PWD.IndicadorMontoMinimo
				,ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
				,ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID
				,ISNULL(PWD.TipoPedido, 'W') TipoPedido
				,PWD.MarcaDescripcion AS DescripcionLarga
				,'NO DISPONIBLE' AS Categoria
				,PWD.IndicadorOfertaCUV
				,PWD.FlagConsultoraOnline
				,PWD.DescuentoProl
				,PWD.MontoEscala
				,PWD.MontoAhorroCatalogo
				,PWD.MontoAhorroRevista
				,PWD.OrigenPedidoWeb
				--,0 AS OrigenPedidoWeb
				,PWD.EsBackOrder
				,PWD.AceptoBackOrder
				,PWD.CodigoCatalago
				,EST.DescripcionTipoEstrategia AS DescripcionOferta
				,EST.DescripcionTipoEstrategia AS DescripcionEstrategia
				,CASE
					WHEN EST.FlagNueva = 1
						AND @CodigoPrograma IS NOT NULL
						THEN 1
					ELSE 0
					END AS FlagNueva
				,EST.TipoEstrategiaCodigo
				,EST.EsOfertaIndependiente
				,EST.EstrategiaID
				,EST.TipoEstrategiaID
				,EST.Numeropedido
				,0 AS SetID
				,PWD.ObservacionPROL
				,PWD.GananciaTotal as Ganancia
				,PWD.CodigoTipoOferta
			    ,IIF(ISNULL(SSE.CUV,0)= 0,0,1) EsSuscripcionSE --/* HD-4200 */
			FROM @PedidoDetalle2 PWD
			LEFT JOIN @Estrategia2 EST ON EST.CUV2 = PWD.CUV
				AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
			LEFT JOIN @tblSuscripcionSE SSE ON PWD.CampaniaID=SSE.CampaniaID AND PWD.CUV=SSE.CUV  --/* HD-4200 */
			WHERE EST.EstrategiaID IS NULL
			--WHERE PWD.CodigoTipoEstrategia NOT IN (
			--		'001','030','008','007','005','010'
			--		)

			UNION

			SELECT PWS.Campania
				,PWS.PedidoID
				,0 AS PedidoDetalleID
				,0 AS MarcaID
				,PWS.ConsultoraId
				--,NULL AS ClienteID
				, PWS.ClienteID
				,MAX(PWS.OrdenPedido) AS OrdenPedidoWD
				,PWS.Cantidad
				,PWS.PrecioUnidad
				,PWs.ImporteTotal
				,PWS.CuvSet AS CUV
				,0 AS EsKiNueva
				--,PWS.NombreSet AS DescripcionProd
				,EST.DescripcionCUV2 AS DescripcionProd
				-- ,NULL AS Nombre
				, C.Nombre
				,PWD.OfertaWeb
				,PWD.IndicadorMontoMinimo
				,ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
				,ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID
				,ISNULL(PWD.TipoPedido, 'W') TipoPedido
				,NULL AS MarcaDescripcion
				,'NO DISPONIBLE' AS Categoria
				,PWD.IndicadorOfertaCUV
				,0 AS FlagConsultoraOnline
				,PWD.DescuentoProl
				,PWD.MontoEscala
				,PWD.MontoAhorroCatalogo
				,PWD.MontoAhorroRevista
				,PWD.OrigenPedidoWeb
				--,0 AS OrigenPedidoWeb
				,ISNULL(PWD.EsBackOrder, 0) AS EsBackOrder
				,ISNULL(PWD.AceptoBackOrder, 0) AS AceptoBackOrder
				,PWD.CodigoCatalago
				,TE.NombreComercial AS DescripcionOferta
				,TE.NombreComercial AS DescripcionEstrategia
				,CASE
					WHEN COALESCE(TEP.FlagNueva, TE.FlagNueva) = 1
						AND @CodigoPrograma IS NOT NULL
						THEN 1
					ELSE 0
					END AS FlagNueva
				,COALESCE(TEP.Codigo, TE.Codigo) AS TipoEstrategiaCodigo
				,EST.EsOfertaIndependiente
				,EST.EstrategiaID
				,EST.TipoEstrategiaID
				,EST.Numeropedido
				,PWS.SetID
				,PWD.ObservacionPROL
				,PWD.GananciaTotal
				,PWD.CodigoTipoOferta
				,0 AS EsSuscripcionSE --/* HD-4200 */
			FROM PedidoWebSet PWS
			INNER JOIN PedidoWebSetDetalle PWSD ON PWSD.SetID = PWS.SetID
			INNER JOIN @PedidoDetalle2 PWD ON PWS.Campania = PWD.CampaniaId
				AND PWS.PedidoID = PWD.PedidoID
				AND PWSD.CuvProducto = PWD.CUV
				AND ISNULL(PWS.ClienteID,0) = ISNULL(PWD.ClienteID,0)
			LEFT JOIN dbo.Cliente C ON PWS.ClienteID = C.ClienteID AND PWS.ConsultoraID = C.ConsultoraID
			INNER JOIN Estrategia EST WITH (NOLOCK) ON PWS.EstrategiaID = EST.EstrategiaID
			INNER JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
			LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
			WHERE PWS.Campania = @CampaniaID
				AND PWS.ConsultoraID = @ConsultoraID
				--AND PWD.CodigoTipoEstrategia IN (
				--	'001','030','008','007','005','010'
				--	)
			GROUP BY PWS.Campania
				,PWS.PedidoID
				,PWS.ConsultoraId
				--,PWD.ClienteID
				--, Nombre
				,C.Nombre
				,PWS.ClienteID
				,PWS.Cantidad
				,PWS.PrecioUnidad
				,PWs.ImporteTotal
				,PWD.OfertaWeb
				,PWD.IndicadorMontoMinimo
				,PWS.CuvSet
				--,PWS.NombreSet
				,EST.DescripcionCUV2
				,PWD.ConfiguracionOfertaID
				,PWD.TipoOfertaSisID
				,PWD.TipoPedido
				,PWD.IndicadorOfertaCUV
				,PWD.DescuentoProl
				,PWD.MontoEscala
				,PWD.MontoAhorroCatalogo
				,PWD.MontoAhorroRevista
				,PWD.OrigenPedidoWeb
				,PWD.EsBackOrder
				,PWD.AceptoBackOrder
				,PWD.CodigoCatalago
				,TEP.FlagNueva
				,TE.FlagNueva
				,TEP.Codigo
				,TE.Codigo
				,EST.EsOfertaIndependiente
				,EST.EstrategiaID
				,EST.TipoEstrategiaID
				,EST.Numeropedido
				,PWS.SetID
				,TE.NombreComercial
				,PWD.ObservacionProl
				,PWD.GananciaTotal
				,PWD.CodigoTipoOferta
			) Agrupado
		ORDER BY Agrupado.OrdenPedidoWD DESC
			,Agrupado.PedidoDetalleID DESC
	END
	ELSE
	BEGIN
		DECLARE @PedidoDetalle AS TABLE (
			CampaniaID INT
			,PedidoID INT
			,PedidoDetalleID INT
			,MarcaID TINYINT
			,ConsultoraID BIGINT
			,ClienteID SMALLINT
			,OrdenPedidoWD INT
			,Cantidad INT
			,PrecioUnidad MONEY
			,ImporteTotal MONEY
			,CUV VARCHAR(20)
			,EsKitNueva BIT
			,DescripcionProd VARCHAR(800)
			,ClienteNombre VARCHAR(200)
			,OfertaWeb BIT
			,IndicadorMontoMinimo INT
			,ConfiguracionOfertaID INT
			,TipoOfertaSisID INT
			,TipoPedido CHAR(1)
			,DescripcionOferta VARCHAR(200)
			,MarcaDescripcion VARCHAR(20)
			,CategoriaNombre VARCHAR(50)
			,DescripcionEstrategia VARCHAR(200)
			,TipoEstrategiaID INT
			,IndicadorOfertaCUV BIT
			,FlagConsultoraOnline INT
			,DescuentoProl MONEY
			,MontoEscala MONEY
			,MontoAhorroCatalogo MONEY
			,MontoAhorroRevista MONEY
			,OrigenPedidoWeb INT
			,EsBackOrder BIT
			,AceptoBackOrder BIT
			,CodigoCatalago CHAR(6)
			,TipoEstrategiaCodigo VARCHAR(100)
			,EsOfertaIndependiente BIT
			,CodigoTipoOferta CHAR(6)
			,ObservacionProl VARCHAR(500)
			,PRIMARY KEY (
				CampaniaID
				,PedidoID
				,PedidoDetalleID
				)
			)

		INSERT INTO @PedidoDetalle
		SELECT PWD.CampaniaID
			,PWD.PedidoID
			,PWD.PedidoDetalleID
			,PWD.MarcaID
			,PWD.ConsultoraID
			,PWD.ClienteID
			,PWD.OrdenPedidoWD
			,PWD.Cantidad
			,PWD.PrecioUnidad
			,PWD.ImporteTotal
			,PWD.CUV
			,PWD.EsKitNueva
			,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PC.Descripcion) AS DescripcionProd
			,C.Nombre AS ClienteNombre
			,PWD.OfertaWeb
			,PC.IndicadorMontoMinimo
			,PWD.ConfiguracionOfertaID
			,PWD.TipoOfertaSisID
			,PWD.TipoPedido
			,'' AS DescripcionOferta
			,M.Descripcion AS MarcaDescripcion
			,'NO DISPONIBLE' AS Categoria
			,'' AS DescripcionEstrategia
			,PWD.TipoEstrategiaID
			,PC.IndicadorOferta AS IndicadorOfertaCUV
			,0 AS FlagConsultoraOnline
			,PW.DescuentoProl
			,PW.MontoEscala
			,PW.MontoAhorroCatalogo
			,PW.MontoAhorroRevista
			,PWD.OrigenPedidoWeb
			,PWD.EsBackOrder
			,PWD.AceptoBackOrder
			,PC.CodigoCatalago
			,'' AS TipoEstrategiaCodigo
			,0 AS EsOfertaIndependiente
			,PC.CodigoTipoOferta
			,PWD.ObservacionPROL
		FROM dbo.PedidoWebDetalle PWD WITH (NOLOCK)
		INNER JOIN dbo.PedidoWeb PW WITH (NOLOCK) ON PW.CampaniaID = PWD.CampaniaID
			AND PW.PedidoID = PWD.PedidoID
			AND PW.ConsultoraID = PWD.ConsultoraID
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) ON PWD.CampaniaID = PC.AnoCampania
			AND PWD.CUV = PC.CUV
		LEFT JOIN dbo.Cliente C WITH (NOLOCK) ON PWD.ClienteID = C.ClienteID
			AND PWD.ConsultoraID = C.ConsultoraID
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PWD.CampaniaID = PD.CampaniaID
			AND PWD.CUV = PD.CUV
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PC.CampaniaID
			AND OP.CUV = PC.CUV
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.Marca M WITH (NOLOCK) ON PWD.MarcaId = M.MarcaId
		WHERE pwd.CampaniaID = @CampaniaID
			AND pwd.ConsultoraID = @ConsultoraID
			AND pwd.CUVPadre IS NULL

		DECLARE @Estrategia AS TABLE (
			EstrategiaID INT
			,TipoEstrategiaID INT
			,Activo BIT
			,CampaniaID INT
			,CampaniaIDFin INT
			,CUV2 VARCHAR(20)
			,Numeropedido INT
			,DescripcionEstrategia VARCHAR(800)
			,EsOfertaIndependiente BIT
			,FlagNueva BIT
			,DescripcionTipoEstrategia VARCHAR(200)
			,TipoEstrategiaCodigo VARCHAR(100)
			,CodigoPrograma VARCHAR(3)
			)

		--PRIMARY KEY (EstrategiaID)
		INSERT INTO @Estrategia
		SELECT DISTINCT E.EstrategiaID
			,TE.TipoEstrategiaID
			,E.Activo
			,E.CampaniaID
			,E.CampaniaIDFin
			,E.CUV2
			,E.Numeropedido
			,E.DescripcionCUV2
			,E.EsOfertaIndependiente
			,COALESCE(TEP.FlagNueva, TE.FlagNueva)
			,COALESCE(TEP.NombreComercial, TE.NombreComercial)
			,COALESCE(TEP.Codigo, TE.Codigo)
			,COALESCE(TEP.CodigoPrograma, TE.CodigoPrograma)
		FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = E.TipoEstrategiaID
		INNER JOIN @PedidoDetalle PWD ON PWD.CampaniaID BETWEEN E.CampaniaID
				AND CASE
						WHEN ISNULL(E.CampaniaIDFin, 0) = 0
							THEN E.CampaniaID
						ELSE E.CampaniaIDFin
						END
			AND E.CUV2 = PWD.CUV
			AND E.Activo IN (0,1)
		LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
		WHERE TE.FlagActivo = 1

		UNION

		SELECT EP.EstrategiaProductoId
			,TE.TipoEstrategiaID
			,E.Activo
			,E.CampaniaID
			,E.CampaniaIDFin
			,EP.CUV
			,E.Numeropedido
			,NULL AS DescripcionEstrategia
			,E.EsOfertaIndependiente
			,COALESCE(TEP.FlagNueva, TE.FlagNueva)
			,COALESCE(TEP.NombreComercial, TE.NombreComercial)
			,COALESCE(TEP.Codigo, TE.Codigo)
			,COALESCE(TEP.CodigoPrograma, TE.CodigoPrograma)
		FROM dbo.EstrategiaProducto EP
		INNER JOIN dbo.Estrategia E WITH (NOLOCK) ON EP.EstrategiaID = E.EstrategiaID
		INNER JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = E.TipoEstrategiaID
		INNER JOIN @PedidoDetalle PWD ON PWD.CampaniaID = EP.Campania
			AND EP.CUV = PWD.CUV
			AND EP.CUV2 != PWD.CUV
		LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
		WHERE TE.FlagActivo = 1

		IF @CodigoPrograma IS NOT NULL
		BEGIN
			DELETE
			FROM @Estrategia
			WHERE ISNULL(CodigoPrograma, '') <> ''
				AND Numeropedido <> @NumeroPedido
		END

		SELECT PWD.CampaniaID
			,PWD.PedidoID
			,PWD.PedidoDetalleID
			,PWD.MarcaID
			,PWD.ConsultoraID
			,PWD.ClienteID
			,PWD.OrdenPedidoWD
			,PWD.Cantidad
			,PWD.PrecioUnidad
			,PWD.ImporteTotal
			,PWD.CUV
			,PWD.EsKitNueva
			,COALESCE(EST.DescripcionEstrategia, PWD.DescripcionProd) AS DescripcionProd
			,PWD.ClienteNombre AS Nombre
			,PWD.OfertaWeb
			,PWD.IndicadorMontoMinimo
			,ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID
			,ISNULL(PWD.TipoPedido, 'W') TipoPedido
			,PWD.MarcaDescripcion AS DescripcionLarga
			,'NO DISPONIBLE' AS Categoria
			,PWD.IndicadorOfertaCUV
			,PWD.FlagConsultoraOnline
			,PWD.DescuentoProl
			,PWD.MontoEscala
			,PWD.MontoAhorroCatalogo
			,PWD.MontoAhorroRevista
			,PWD.OrigenPedidoWeb
			,PWD.EsBackOrder
			,PWD.AceptoBackOrder
			,PWD.CodigoCatalago
			,EST.DescripcionTipoEstrategia AS DescripcionOferta
			,EST.DescripcionTipoEstrategia AS DescripcionEstrategia
			,CASE
				WHEN EST.FlagNueva = 1
					AND @CodigoPrograma IS NOT NULL
					THEN 1
				ELSE 0
				END AS FlagNueva
			,EST.TipoEstrategiaCodigo
			,EST.EsOfertaIndependiente
			,EST.EstrategiaID
			,EST.TipoEstrategiaID
			,EST.Numeropedido
			,0 AS SetID
			,PWD.ObservacionPROL
		    ,IIF(ISNULL(SSE.CUV,0)= 0,0,1) EsSuscripcionSE --/* HD-4200 */
		FROM @PedidoDetalle PWD
		LEFT JOIN @Estrategia EST ON EST.CUV2 = PWD.CUV
			AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN @tblSuscripcionSE SSE ON PWD.CampaniaID=SSE.CampaniaID AND PWD.CUV=SSE.CUV  --/* HD-4200 */
		ORDER BY PWD.OrdenPedidoWD DESC
			,PWD.PedidoDetalleID DESC
	END
END
GO

