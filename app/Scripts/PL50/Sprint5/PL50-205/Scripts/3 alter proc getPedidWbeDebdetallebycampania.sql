use belcorpBolivia
go

IF (OBJECT_ID('dbo.GetPedidoWebDetalleByCampania', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetPedidoWebDetalleByCampania AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[GetPedidoWebDetalleByCampania] @CampaniaID INT
	,@ConsultoraID BIGINT
	,@CodigoPrograma VARCHAR(15) = NULL
	,@NumeroPedido INT = 0
	,@AgruparSet bit = 0
AS
BEGIN

declare @FechaRegistroPedido date
declare @FechaInicioSetAgrupado date
set @FechaInicioSetAgrupado ='2017-04-17'

select @FechaRegistroPedido=FechaRegistro from pedidoweb where CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID


if((@AgruparSet=1)and(@FechaRegistroPedido>@FechaInicioSetAgrupado))
begin

					SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						and PWD.TipoEstrategiaID not in (select tipoestrategiaid from tipoestrategia where codigo in ('001','030','008','007','005','010'))

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
					LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
					WHERE TE.FlagActivo = 1

					IF @CodigoPrograma IS NOT NULL
					BEGIN
						DELETE
						FROM @Estrategia2
						WHERE isnull(CodigoPrograma, '') <> ''
							AND Numeropedido <> @NumeroPedido
					END
					select * from(
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
						,0 as SetID
					FROM @PedidoDetalle2 PWD
					LEFT JOIN @Estrategia2 EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					--ORDER BY PWD.OrdenPedidoWD DESC
					--	,PWD.PedidoDetalleID DESC

					union
					SELECT  PWS.Campania
					,PWS.PedidoID
					,0 as PedidoDetalleID
					,0 AS MarcaID
					,PWS.ConsultoraId
					,NULL AS ClienteID
					,max(PWS.OrdenPedido) AS OrdenPedidoWD
					,PWS.Cantidad
					,PWS.PrecioUnidad
					,PWs.ImporteTotal
					,PWS.CuvSet AS CUV
					,0 AS EsKiNueva
					,PWS.NombreSet AS DescripcionProd
					,NULL AS Nombre
					,PWD.OfertaWeb
					,PC.IndicadorMontoMinimo
					,ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
					,ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID
					--,M.Descripcion AS MarcaDescripcion
					,ISNULL(PWD.TipoPedido, 'W') TipoPedido
					,NULL AS MarcaDescripcion
					,'NO DISPONIBLE' AS Categoria
					,PC.IndicadorOferta AS IndicadorOfertaCUV
					,0 AS FlagConsultoraOnline
					,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
					,isnull(PWD.EsBackOrder,0) as EsBackOrder
					,isnull(PWD.AceptoBackOrder,0) as AceptoBackOrder
					,PC.CodigoCatalago
					,'' AS DescripcionOferta
					,'' AS DescripcionEstrategia
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
				FROM pedidowebset PWS
				INNER JOIN PedidoWeb PW ON PWS.PedidoID = PW.PedidoID
				inner join PedidoWebSetDetalle PWSD on PWSD.SetID=PWS.SetID
				INNER JOIN PedidoWebDetalle PWD ON PWD.PedidoID = PW.PedidoID and PWSD.CuvProducto =PWD.CUV
				INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) ON PWD.CampaniaID = PC.AnoCampania
					AND PWD.CUV = PC.CUV
				INNER JOIN Estrategia EST ON PWS.EstrategiaID = EST.EstrategiaID
				INNER JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
				LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID

					WHERE PWS.Campania = @CampaniaID
						AND PWS.ConsultoraID = @ConsultoraID
						group by PWS.Campania
			,PWS.PedidoID
			,PWS.ConsultoraId
			,ClienteID
			,PWS.Cantidad
			,PWS.PrecioUnidad
			,PWs.ImporteTotal
			,PWD.OfertaWeb
			,PC.IndicadorMontoMinimo					
			,PWS.CuvSet
			,PWS.NombreSet
			,PWD.ConfiguracionOfertaID
			,PWD.TipoOfertaSisID
			, PWD.TipoPedido 
			,PC.IndicadorOferta
								,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
										, PWD.EsBackOrder 
					,PWD.AceptoBackOrder 
					,PC.CodigoCatalago
					 ,TEP.FlagNueva, TE.FlagNueva
					 ,TEP.Codigo, TE.Codigo
					,EST.EsOfertaIndependiente
					,EST.EstrategiaID
					,EST.TipoEstrategiaID
					,EST.Numeropedido
					,PWS.SetID 
						)Agrupado
						 ORDER BY Agrupado.OrdenPedidoWD DESC
					 ,Agrupado.PedidoDetalleID DESC

end
else
begin

				SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
						WHERE isnull(CodigoPrograma, '') <> ''
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
						,0 as SetID
					FROM @PedidoDetalle PWD
					LEFT JOIN @Estrategia EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					ORDER BY PWD.OrdenPedidoWD DESC
						,PWD.PedidoDetalleID DESC

end


END
GO
use belcorpChile
go

IF (OBJECT_ID('dbo.GetPedidoWebDetalleByCampania', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetPedidoWebDetalleByCampania AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[GetPedidoWebDetalleByCampania] @CampaniaID INT
	,@ConsultoraID BIGINT
	,@CodigoPrograma VARCHAR(15) = NULL
	,@NumeroPedido INT = 0
	,@AgruparSet bit = 0
AS
BEGIN

declare @FechaRegistroPedido date
declare @FechaInicioSetAgrupado date
set @FechaInicioSetAgrupado ='2017-04-17'

select @FechaRegistroPedido=FechaRegistro from pedidoweb where CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID


if((@AgruparSet=1)and(@FechaRegistroPedido>@FechaInicioSetAgrupado))
begin

					SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						and PWD.TipoEstrategiaID not in (select tipoestrategiaid from tipoestrategia where codigo in ('001','030','008','007','005','010'))

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
					LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
					WHERE TE.FlagActivo = 1

					IF @CodigoPrograma IS NOT NULL
					BEGIN
						DELETE
						FROM @Estrategia2
						WHERE isnull(CodigoPrograma, '') <> ''
							AND Numeropedido <> @NumeroPedido
					END
					select * from(
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
						,0 as SetID
					FROM @PedidoDetalle2 PWD
					LEFT JOIN @Estrategia2 EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					--ORDER BY PWD.OrdenPedidoWD DESC
					--	,PWD.PedidoDetalleID DESC

					union
					SELECT  PWS.Campania
					,PWS.PedidoID
					,0 as PedidoDetalleID
					,0 AS MarcaID
					,PWS.ConsultoraId
					,NULL AS ClienteID
					,max(PWS.OrdenPedido) AS OrdenPedidoWD
					,PWS.Cantidad
					,PWS.PrecioUnidad
					,PWs.ImporteTotal
					,PWS.CuvSet AS CUV
					,0 AS EsKiNueva
					,PWS.NombreSet AS DescripcionProd
					,NULL AS Nombre
					,PWD.OfertaWeb
					,PC.IndicadorMontoMinimo
					,ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
					,ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID
					--,M.Descripcion AS MarcaDescripcion
					,ISNULL(PWD.TipoPedido, 'W') TipoPedido
					,NULL AS MarcaDescripcion
					,'NO DISPONIBLE' AS Categoria
					,PC.IndicadorOferta AS IndicadorOfertaCUV
					,0 AS FlagConsultoraOnline
					,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
					,isnull(PWD.EsBackOrder,0) as EsBackOrder
					,isnull(PWD.AceptoBackOrder,0) as AceptoBackOrder
					,PC.CodigoCatalago
					,'' AS DescripcionOferta
					,'' AS DescripcionEstrategia
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
				FROM pedidowebset PWS
				INNER JOIN PedidoWeb PW ON PWS.PedidoID = PW.PedidoID
				inner join PedidoWebSetDetalle PWSD on PWSD.SetID=PWS.SetID
				INNER JOIN PedidoWebDetalle PWD ON PWD.PedidoID = PW.PedidoID and PWSD.CuvProducto =PWD.CUV
				INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) ON PWD.CampaniaID = PC.AnoCampania
					AND PWD.CUV = PC.CUV
				INNER JOIN Estrategia EST ON PWS.EstrategiaID = EST.EstrategiaID
				INNER JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
				LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID

					WHERE PWS.Campania = @CampaniaID
						AND PWS.ConsultoraID = @ConsultoraID
						group by PWS.Campania
			,PWS.PedidoID
			,PWS.ConsultoraId
			,ClienteID
			,PWS.Cantidad
			,PWS.PrecioUnidad
			,PWs.ImporteTotal
			,PWD.OfertaWeb
			,PC.IndicadorMontoMinimo					
			,PWS.CuvSet
			,PWS.NombreSet
			,PWD.ConfiguracionOfertaID
			,PWD.TipoOfertaSisID
			, PWD.TipoPedido 
			,PC.IndicadorOferta
								,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
										, PWD.EsBackOrder 
					,PWD.AceptoBackOrder 
					,PC.CodigoCatalago
					 ,TEP.FlagNueva, TE.FlagNueva
					 ,TEP.Codigo, TE.Codigo
					,EST.EsOfertaIndependiente
					,EST.EstrategiaID
					,EST.TipoEstrategiaID
					,EST.Numeropedido
					,PWS.SetID 
						)Agrupado
						 ORDER BY Agrupado.OrdenPedidoWD DESC
					 ,Agrupado.PedidoDetalleID DESC

end
else
begin

				SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
						WHERE isnull(CodigoPrograma, '') <> ''
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
						,0 as SetID
					FROM @PedidoDetalle PWD
					LEFT JOIN @Estrategia EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					ORDER BY PWD.OrdenPedidoWD DESC
						,PWD.PedidoDetalleID DESC

end


END
GO
use belcorpColombia
go

IF (OBJECT_ID('dbo.GetPedidoWebDetalleByCampania', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetPedidoWebDetalleByCampania AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[GetPedidoWebDetalleByCampania] @CampaniaID INT
	,@ConsultoraID BIGINT
	,@CodigoPrograma VARCHAR(15) = NULL
	,@NumeroPedido INT = 0
	,@AgruparSet bit = 0
AS
BEGIN

declare @FechaRegistroPedido date
declare @FechaInicioSetAgrupado date
set @FechaInicioSetAgrupado ='2017-04-17'

select @FechaRegistroPedido=FechaRegistro from pedidoweb where CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID


if((@AgruparSet=1)and(@FechaRegistroPedido>@FechaInicioSetAgrupado))
begin

					SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						and PWD.TipoEstrategiaID not in (select tipoestrategiaid from tipoestrategia where codigo in ('001','030','008','007','005','010'))

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
					LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
					WHERE TE.FlagActivo = 1

					IF @CodigoPrograma IS NOT NULL
					BEGIN
						DELETE
						FROM @Estrategia2
						WHERE isnull(CodigoPrograma, '') <> ''
							AND Numeropedido <> @NumeroPedido
					END
					select * from(
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
						,0 as SetID
					FROM @PedidoDetalle2 PWD
					LEFT JOIN @Estrategia2 EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					--ORDER BY PWD.OrdenPedidoWD DESC
					--	,PWD.PedidoDetalleID DESC

					union
					SELECT  PWS.Campania
					,PWS.PedidoID
					,0 as PedidoDetalleID
					,0 AS MarcaID
					,PWS.ConsultoraId
					,NULL AS ClienteID
					,max(PWS.OrdenPedido) AS OrdenPedidoWD
					,PWS.Cantidad
					,PWS.PrecioUnidad
					,PWs.ImporteTotal
					,PWS.CuvSet AS CUV
					,0 AS EsKiNueva
					,PWS.NombreSet AS DescripcionProd
					,NULL AS Nombre
					,PWD.OfertaWeb
					,PC.IndicadorMontoMinimo
					,ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
					,ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID
					--,M.Descripcion AS MarcaDescripcion
					,ISNULL(PWD.TipoPedido, 'W') TipoPedido
					,NULL AS MarcaDescripcion
					,'NO DISPONIBLE' AS Categoria
					,PC.IndicadorOferta AS IndicadorOfertaCUV
					,0 AS FlagConsultoraOnline
					,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
					,isnull(PWD.EsBackOrder,0) as EsBackOrder
					,isnull(PWD.AceptoBackOrder,0) as AceptoBackOrder
					,PC.CodigoCatalago
					,'' AS DescripcionOferta
					,'' AS DescripcionEstrategia
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
				FROM pedidowebset PWS
				INNER JOIN PedidoWeb PW ON PWS.PedidoID = PW.PedidoID
				inner join PedidoWebSetDetalle PWSD on PWSD.SetID=PWS.SetID
				INNER JOIN PedidoWebDetalle PWD ON PWD.PedidoID = PW.PedidoID and PWSD.CuvProducto =PWD.CUV
				INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) ON PWD.CampaniaID = PC.AnoCampania
					AND PWD.CUV = PC.CUV
				INNER JOIN Estrategia EST ON PWS.EstrategiaID = EST.EstrategiaID
				INNER JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
				LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID

					WHERE PWS.Campania = @CampaniaID
						AND PWS.ConsultoraID = @ConsultoraID
						group by PWS.Campania
			,PWS.PedidoID
			,PWS.ConsultoraId
			,ClienteID
			,PWS.Cantidad
			,PWS.PrecioUnidad
			,PWs.ImporteTotal
			,PWD.OfertaWeb
			,PC.IndicadorMontoMinimo					
			,PWS.CuvSet
			,PWS.NombreSet
			,PWD.ConfiguracionOfertaID
			,PWD.TipoOfertaSisID
			, PWD.TipoPedido 
			,PC.IndicadorOferta
								,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
										, PWD.EsBackOrder 
					,PWD.AceptoBackOrder 
					,PC.CodigoCatalago
					 ,TEP.FlagNueva, TE.FlagNueva
					 ,TEP.Codigo, TE.Codigo
					,EST.EsOfertaIndependiente
					,EST.EstrategiaID
					,EST.TipoEstrategiaID
					,EST.Numeropedido
					,PWS.SetID 
						)Agrupado
						 ORDER BY Agrupado.OrdenPedidoWD DESC
					 ,Agrupado.PedidoDetalleID DESC

end
else
begin

				SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
						WHERE isnull(CodigoPrograma, '') <> ''
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
						,0 as SetID
					FROM @PedidoDetalle PWD
					LEFT JOIN @Estrategia EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					ORDER BY PWD.OrdenPedidoWD DESC
						,PWD.PedidoDetalleID DESC

end


END
GO
use belcorpCostaRica
go

IF (OBJECT_ID('dbo.GetPedidoWebDetalleByCampania', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetPedidoWebDetalleByCampania AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[GetPedidoWebDetalleByCampania] @CampaniaID INT
	,@ConsultoraID BIGINT
	,@CodigoPrograma VARCHAR(15) = NULL
	,@NumeroPedido INT = 0
	,@AgruparSet bit = 0
AS
BEGIN

declare @FechaRegistroPedido date
declare @FechaInicioSetAgrupado date
set @FechaInicioSetAgrupado ='2017-04-17'

select @FechaRegistroPedido=FechaRegistro from pedidoweb where CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID


if((@AgruparSet=1)and(@FechaRegistroPedido>@FechaInicioSetAgrupado))
begin

					SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						and PWD.TipoEstrategiaID not in (select tipoestrategiaid from tipoestrategia where codigo in ('001','030','008','007','005','010'))

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
					LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
					WHERE TE.FlagActivo = 1

					IF @CodigoPrograma IS NOT NULL
					BEGIN
						DELETE
						FROM @Estrategia2
						WHERE isnull(CodigoPrograma, '') <> ''
							AND Numeropedido <> @NumeroPedido
					END
					select * from(
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
						,0 as SetID
					FROM @PedidoDetalle2 PWD
					LEFT JOIN @Estrategia2 EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					--ORDER BY PWD.OrdenPedidoWD DESC
					--	,PWD.PedidoDetalleID DESC

					union
					SELECT  PWS.Campania
					,PWS.PedidoID
					,0 as PedidoDetalleID
					,0 AS MarcaID
					,PWS.ConsultoraId
					,NULL AS ClienteID
					,max(PWS.OrdenPedido) AS OrdenPedidoWD
					,PWS.Cantidad
					,PWS.PrecioUnidad
					,PWs.ImporteTotal
					,PWS.CuvSet AS CUV
					,0 AS EsKiNueva
					,PWS.NombreSet AS DescripcionProd
					,NULL AS Nombre
					,PWD.OfertaWeb
					,PC.IndicadorMontoMinimo
					,ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
					,ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID
					--,M.Descripcion AS MarcaDescripcion
					,ISNULL(PWD.TipoPedido, 'W') TipoPedido
					,NULL AS MarcaDescripcion
					,'NO DISPONIBLE' AS Categoria
					,PC.IndicadorOferta AS IndicadorOfertaCUV
					,0 AS FlagConsultoraOnline
					,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
					,isnull(PWD.EsBackOrder,0) as EsBackOrder
					,isnull(PWD.AceptoBackOrder,0) as AceptoBackOrder
					,PC.CodigoCatalago
					,'' AS DescripcionOferta
					,'' AS DescripcionEstrategia
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
				FROM pedidowebset PWS
				INNER JOIN PedidoWeb PW ON PWS.PedidoID = PW.PedidoID
				inner join PedidoWebSetDetalle PWSD on PWSD.SetID=PWS.SetID
				INNER JOIN PedidoWebDetalle PWD ON PWD.PedidoID = PW.PedidoID and PWSD.CuvProducto =PWD.CUV
				INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) ON PWD.CampaniaID = PC.AnoCampania
					AND PWD.CUV = PC.CUV
				INNER JOIN Estrategia EST ON PWS.EstrategiaID = EST.EstrategiaID
				INNER JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
				LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID

					WHERE PWS.Campania = @CampaniaID
						AND PWS.ConsultoraID = @ConsultoraID
						group by PWS.Campania
			,PWS.PedidoID
			,PWS.ConsultoraId
			,ClienteID
			,PWS.Cantidad
			,PWS.PrecioUnidad
			,PWs.ImporteTotal
			,PWD.OfertaWeb
			,PC.IndicadorMontoMinimo					
			,PWS.CuvSet
			,PWS.NombreSet
			,PWD.ConfiguracionOfertaID
			,PWD.TipoOfertaSisID
			, PWD.TipoPedido 
			,PC.IndicadorOferta
								,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
										, PWD.EsBackOrder 
					,PWD.AceptoBackOrder 
					,PC.CodigoCatalago
					 ,TEP.FlagNueva, TE.FlagNueva
					 ,TEP.Codigo, TE.Codigo
					,EST.EsOfertaIndependiente
					,EST.EstrategiaID
					,EST.TipoEstrategiaID
					,EST.Numeropedido
					,PWS.SetID 
						)Agrupado
						 ORDER BY Agrupado.OrdenPedidoWD DESC
					 ,Agrupado.PedidoDetalleID DESC

end
else
begin

				SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
						WHERE isnull(CodigoPrograma, '') <> ''
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
						,0 as SetID
					FROM @PedidoDetalle PWD
					LEFT JOIN @Estrategia EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					ORDER BY PWD.OrdenPedidoWD DESC
						,PWD.PedidoDetalleID DESC

end


END
GO
use belcorpDominicana
go

IF (OBJECT_ID('dbo.GetPedidoWebDetalleByCampania', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetPedidoWebDetalleByCampania AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[GetPedidoWebDetalleByCampania] @CampaniaID INT
	,@ConsultoraID BIGINT
	,@CodigoPrograma VARCHAR(15) = NULL
	,@NumeroPedido INT = 0
	,@AgruparSet bit = 0
AS
BEGIN

declare @FechaRegistroPedido date
declare @FechaInicioSetAgrupado date
set @FechaInicioSetAgrupado ='2017-04-17'

select @FechaRegistroPedido=FechaRegistro from pedidoweb where CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID


if((@AgruparSet=1)and(@FechaRegistroPedido>@FechaInicioSetAgrupado))
begin

					SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						and PWD.TipoEstrategiaID not in (select tipoestrategiaid from tipoestrategia where codigo in ('001','030','008','007','005','010'))

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
					LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
					WHERE TE.FlagActivo = 1

					IF @CodigoPrograma IS NOT NULL
					BEGIN
						DELETE
						FROM @Estrategia2
						WHERE isnull(CodigoPrograma, '') <> ''
							AND Numeropedido <> @NumeroPedido
					END
					select * from(
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
						,0 as SetID
					FROM @PedidoDetalle2 PWD
					LEFT JOIN @Estrategia2 EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					--ORDER BY PWD.OrdenPedidoWD DESC
					--	,PWD.PedidoDetalleID DESC

					union
					SELECT  PWS.Campania
					,PWS.PedidoID
					,0 as PedidoDetalleID
					,0 AS MarcaID
					,PWS.ConsultoraId
					,NULL AS ClienteID
					,max(PWS.OrdenPedido) AS OrdenPedidoWD
					,PWS.Cantidad
					,PWS.PrecioUnidad
					,PWs.ImporteTotal
					,PWS.CuvSet AS CUV
					,0 AS EsKiNueva
					,PWS.NombreSet AS DescripcionProd
					,NULL AS Nombre
					,PWD.OfertaWeb
					,PC.IndicadorMontoMinimo
					,ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
					,ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID
					--,M.Descripcion AS MarcaDescripcion
					,ISNULL(PWD.TipoPedido, 'W') TipoPedido
					,NULL AS MarcaDescripcion
					,'NO DISPONIBLE' AS Categoria
					,PC.IndicadorOferta AS IndicadorOfertaCUV
					,0 AS FlagConsultoraOnline
					,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
					,isnull(PWD.EsBackOrder,0) as EsBackOrder
					,isnull(PWD.AceptoBackOrder,0) as AceptoBackOrder
					,PC.CodigoCatalago
					,'' AS DescripcionOferta
					,'' AS DescripcionEstrategia
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
				FROM pedidowebset PWS
				INNER JOIN PedidoWeb PW ON PWS.PedidoID = PW.PedidoID
				inner join PedidoWebSetDetalle PWSD on PWSD.SetID=PWS.SetID
				INNER JOIN PedidoWebDetalle PWD ON PWD.PedidoID = PW.PedidoID and PWSD.CuvProducto =PWD.CUV
				INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) ON PWD.CampaniaID = PC.AnoCampania
					AND PWD.CUV = PC.CUV
				INNER JOIN Estrategia EST ON PWS.EstrategiaID = EST.EstrategiaID
				INNER JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
				LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID

					WHERE PWS.Campania = @CampaniaID
						AND PWS.ConsultoraID = @ConsultoraID
						group by PWS.Campania
			,PWS.PedidoID
			,PWS.ConsultoraId
			,ClienteID
			,PWS.Cantidad
			,PWS.PrecioUnidad
			,PWs.ImporteTotal
			,PWD.OfertaWeb
			,PC.IndicadorMontoMinimo					
			,PWS.CuvSet
			,PWS.NombreSet
			,PWD.ConfiguracionOfertaID
			,PWD.TipoOfertaSisID
			, PWD.TipoPedido 
			,PC.IndicadorOferta
								,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
										, PWD.EsBackOrder 
					,PWD.AceptoBackOrder 
					,PC.CodigoCatalago
					 ,TEP.FlagNueva, TE.FlagNueva
					 ,TEP.Codigo, TE.Codigo
					,EST.EsOfertaIndependiente
					,EST.EstrategiaID
					,EST.TipoEstrategiaID
					,EST.Numeropedido
					,PWS.SetID 
						)Agrupado
						 ORDER BY Agrupado.OrdenPedidoWD DESC
					 ,Agrupado.PedidoDetalleID DESC

end
else
begin

				SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
						WHERE isnull(CodigoPrograma, '') <> ''
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
						,0 as SetID
					FROM @PedidoDetalle PWD
					LEFT JOIN @Estrategia EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					ORDER BY PWD.OrdenPedidoWD DESC
						,PWD.PedidoDetalleID DESC

end


END
GO
use belcorpEcuador
go

IF (OBJECT_ID('dbo.GetPedidoWebDetalleByCampania', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetPedidoWebDetalleByCampania AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[GetPedidoWebDetalleByCampania] @CampaniaID INT
	,@ConsultoraID BIGINT
	,@CodigoPrograma VARCHAR(15) = NULL
	,@NumeroPedido INT = 0
	,@AgruparSet bit = 0
AS
BEGIN

declare @FechaRegistroPedido date
declare @FechaInicioSetAgrupado date
set @FechaInicioSetAgrupado ='2017-04-17'

select @FechaRegistroPedido=FechaRegistro from pedidoweb where CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID


if((@AgruparSet=1)and(@FechaRegistroPedido>@FechaInicioSetAgrupado))
begin

					SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						and PWD.TipoEstrategiaID not in (select tipoestrategiaid from tipoestrategia where codigo in ('001','030','008','007','005','010'))

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
					LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
					WHERE TE.FlagActivo = 1

					IF @CodigoPrograma IS NOT NULL
					BEGIN
						DELETE
						FROM @Estrategia2
						WHERE isnull(CodigoPrograma, '') <> ''
							AND Numeropedido <> @NumeroPedido
					END
					select * from(
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
						,0 as SetID
					FROM @PedidoDetalle2 PWD
					LEFT JOIN @Estrategia2 EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					--ORDER BY PWD.OrdenPedidoWD DESC
					--	,PWD.PedidoDetalleID DESC

					union
					SELECT  PWS.Campania
					,PWS.PedidoID
					,0 as PedidoDetalleID
					,0 AS MarcaID
					,PWS.ConsultoraId
					,NULL AS ClienteID
					,max(PWS.OrdenPedido) AS OrdenPedidoWD
					,PWS.Cantidad
					,PWS.PrecioUnidad
					,PWs.ImporteTotal
					,PWS.CuvSet AS CUV
					,0 AS EsKiNueva
					,PWS.NombreSet AS DescripcionProd
					,NULL AS Nombre
					,PWD.OfertaWeb
					,PC.IndicadorMontoMinimo
					,ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
					,ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID
					--,M.Descripcion AS MarcaDescripcion
					,ISNULL(PWD.TipoPedido, 'W') TipoPedido
					,NULL AS MarcaDescripcion
					,'NO DISPONIBLE' AS Categoria
					,PC.IndicadorOferta AS IndicadorOfertaCUV
					,0 AS FlagConsultoraOnline
					,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
					,isnull(PWD.EsBackOrder,0) as EsBackOrder
					,isnull(PWD.AceptoBackOrder,0) as AceptoBackOrder
					,PC.CodigoCatalago
					,'' AS DescripcionOferta
					,'' AS DescripcionEstrategia
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
				FROM pedidowebset PWS
				INNER JOIN PedidoWeb PW ON PWS.PedidoID = PW.PedidoID
				inner join PedidoWebSetDetalle PWSD on PWSD.SetID=PWS.SetID
				INNER JOIN PedidoWebDetalle PWD ON PWD.PedidoID = PW.PedidoID and PWSD.CuvProducto =PWD.CUV
				INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) ON PWD.CampaniaID = PC.AnoCampania
					AND PWD.CUV = PC.CUV
				INNER JOIN Estrategia EST ON PWS.EstrategiaID = EST.EstrategiaID
				INNER JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
				LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID

					WHERE PWS.Campania = @CampaniaID
						AND PWS.ConsultoraID = @ConsultoraID
						group by PWS.Campania
			,PWS.PedidoID
			,PWS.ConsultoraId
			,ClienteID
			,PWS.Cantidad
			,PWS.PrecioUnidad
			,PWs.ImporteTotal
			,PWD.OfertaWeb
			,PC.IndicadorMontoMinimo					
			,PWS.CuvSet
			,PWS.NombreSet
			,PWD.ConfiguracionOfertaID
			,PWD.TipoOfertaSisID
			, PWD.TipoPedido 
			,PC.IndicadorOferta
								,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
										, PWD.EsBackOrder 
					,PWD.AceptoBackOrder 
					,PC.CodigoCatalago
					 ,TEP.FlagNueva, TE.FlagNueva
					 ,TEP.Codigo, TE.Codigo
					,EST.EsOfertaIndependiente
					,EST.EstrategiaID
					,EST.TipoEstrategiaID
					,EST.Numeropedido
					,PWS.SetID 
						)Agrupado
						 ORDER BY Agrupado.OrdenPedidoWD DESC
					 ,Agrupado.PedidoDetalleID DESC

end
else
begin

				SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
						WHERE isnull(CodigoPrograma, '') <> ''
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
						,0 as SetID
					FROM @PedidoDetalle PWD
					LEFT JOIN @Estrategia EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					ORDER BY PWD.OrdenPedidoWD DESC
						,PWD.PedidoDetalleID DESC

end


END
GO
use belcorpGuatemala
go

IF (OBJECT_ID('dbo.GetPedidoWebDetalleByCampania', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetPedidoWebDetalleByCampania AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[GetPedidoWebDetalleByCampania] @CampaniaID INT
	,@ConsultoraID BIGINT
	,@CodigoPrograma VARCHAR(15) = NULL
	,@NumeroPedido INT = 0
	,@AgruparSet bit = 0
AS
BEGIN

declare @FechaRegistroPedido date
declare @FechaInicioSetAgrupado date
set @FechaInicioSetAgrupado ='2017-04-17'

select @FechaRegistroPedido=FechaRegistro from pedidoweb where CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID


if((@AgruparSet=1)and(@FechaRegistroPedido>@FechaInicioSetAgrupado))
begin

					SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						and PWD.TipoEstrategiaID not in (select tipoestrategiaid from tipoestrategia where codigo in ('001','030','008','007','005','010'))

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
					LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
					WHERE TE.FlagActivo = 1

					IF @CodigoPrograma IS NOT NULL
					BEGIN
						DELETE
						FROM @Estrategia2
						WHERE isnull(CodigoPrograma, '') <> ''
							AND Numeropedido <> @NumeroPedido
					END
					select * from(
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
						,0 as SetID
					FROM @PedidoDetalle2 PWD
					LEFT JOIN @Estrategia2 EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					--ORDER BY PWD.OrdenPedidoWD DESC
					--	,PWD.PedidoDetalleID DESC

					union
					SELECT  PWS.Campania
					,PWS.PedidoID
					,0 as PedidoDetalleID
					,0 AS MarcaID
					,PWS.ConsultoraId
					,NULL AS ClienteID
					,max(PWS.OrdenPedido) AS OrdenPedidoWD
					,PWS.Cantidad
					,PWS.PrecioUnidad
					,PWs.ImporteTotal
					,PWS.CuvSet AS CUV
					,0 AS EsKiNueva
					,PWS.NombreSet AS DescripcionProd
					,NULL AS Nombre
					,PWD.OfertaWeb
					,PC.IndicadorMontoMinimo
					,ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
					,ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID
					--,M.Descripcion AS MarcaDescripcion
					,ISNULL(PWD.TipoPedido, 'W') TipoPedido
					,NULL AS MarcaDescripcion
					,'NO DISPONIBLE' AS Categoria
					,PC.IndicadorOferta AS IndicadorOfertaCUV
					,0 AS FlagConsultoraOnline
					,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
					,isnull(PWD.EsBackOrder,0) as EsBackOrder
					,isnull(PWD.AceptoBackOrder,0) as AceptoBackOrder
					,PC.CodigoCatalago
					,'' AS DescripcionOferta
					,'' AS DescripcionEstrategia
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
				FROM pedidowebset PWS
				INNER JOIN PedidoWeb PW ON PWS.PedidoID = PW.PedidoID
				inner join PedidoWebSetDetalle PWSD on PWSD.SetID=PWS.SetID
				INNER JOIN PedidoWebDetalle PWD ON PWD.PedidoID = PW.PedidoID and PWSD.CuvProducto =PWD.CUV
				INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) ON PWD.CampaniaID = PC.AnoCampania
					AND PWD.CUV = PC.CUV
				INNER JOIN Estrategia EST ON PWS.EstrategiaID = EST.EstrategiaID
				INNER JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
				LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID

					WHERE PWS.Campania = @CampaniaID
						AND PWS.ConsultoraID = @ConsultoraID
						group by PWS.Campania
			,PWS.PedidoID
			,PWS.ConsultoraId
			,ClienteID
			,PWS.Cantidad
			,PWS.PrecioUnidad
			,PWs.ImporteTotal
			,PWD.OfertaWeb
			,PC.IndicadorMontoMinimo					
			,PWS.CuvSet
			,PWS.NombreSet
			,PWD.ConfiguracionOfertaID
			,PWD.TipoOfertaSisID
			, PWD.TipoPedido 
			,PC.IndicadorOferta
								,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
										, PWD.EsBackOrder 
					,PWD.AceptoBackOrder 
					,PC.CodigoCatalago
					 ,TEP.FlagNueva, TE.FlagNueva
					 ,TEP.Codigo, TE.Codigo
					,EST.EsOfertaIndependiente
					,EST.EstrategiaID
					,EST.TipoEstrategiaID
					,EST.Numeropedido
					,PWS.SetID 
						)Agrupado
						 ORDER BY Agrupado.OrdenPedidoWD DESC
					 ,Agrupado.PedidoDetalleID DESC

end
else
begin

				SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
						WHERE isnull(CodigoPrograma, '') <> ''
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
						,0 as SetID
					FROM @PedidoDetalle PWD
					LEFT JOIN @Estrategia EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					ORDER BY PWD.OrdenPedidoWD DESC
						,PWD.PedidoDetalleID DESC

end


END
GO
use belcorpMexico
go

IF (OBJECT_ID('dbo.GetPedidoWebDetalleByCampania', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetPedidoWebDetalleByCampania AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[GetPedidoWebDetalleByCampania] @CampaniaID INT
	,@ConsultoraID BIGINT
	,@CodigoPrograma VARCHAR(15) = NULL
	,@NumeroPedido INT = 0
	,@AgruparSet bit = 0
AS
BEGIN

declare @FechaRegistroPedido date
declare @FechaInicioSetAgrupado date
set @FechaInicioSetAgrupado ='2017-04-17'

select @FechaRegistroPedido=FechaRegistro from pedidoweb where CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID


if((@AgruparSet=1)and(@FechaRegistroPedido>@FechaInicioSetAgrupado))
begin

					SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						and PWD.TipoEstrategiaID not in (select tipoestrategiaid from tipoestrategia where codigo in ('001','030','008','007','005','010'))

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
					LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
					WHERE TE.FlagActivo = 1

					IF @CodigoPrograma IS NOT NULL
					BEGIN
						DELETE
						FROM @Estrategia2
						WHERE isnull(CodigoPrograma, '') <> ''
							AND Numeropedido <> @NumeroPedido
					END
					select * from(
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
						,0 as SetID
					FROM @PedidoDetalle2 PWD
					LEFT JOIN @Estrategia2 EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					--ORDER BY PWD.OrdenPedidoWD DESC
					--	,PWD.PedidoDetalleID DESC

					union
					SELECT  PWS.Campania
					,PWS.PedidoID
					,0 as PedidoDetalleID
					,0 AS MarcaID
					,PWS.ConsultoraId
					,NULL AS ClienteID
					,max(PWS.OrdenPedido) AS OrdenPedidoWD
					,PWS.Cantidad
					,PWS.PrecioUnidad
					,PWs.ImporteTotal
					,PWS.CuvSet AS CUV
					,0 AS EsKiNueva
					,PWS.NombreSet AS DescripcionProd
					,NULL AS Nombre
					,PWD.OfertaWeb
					,PC.IndicadorMontoMinimo
					,ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
					,ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID
					--,M.Descripcion AS MarcaDescripcion
					,ISNULL(PWD.TipoPedido, 'W') TipoPedido
					,NULL AS MarcaDescripcion
					,'NO DISPONIBLE' AS Categoria
					,PC.IndicadorOferta AS IndicadorOfertaCUV
					,0 AS FlagConsultoraOnline
					,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
					,isnull(PWD.EsBackOrder,0) as EsBackOrder
					,isnull(PWD.AceptoBackOrder,0) as AceptoBackOrder
					,PC.CodigoCatalago
					,'' AS DescripcionOferta
					,'' AS DescripcionEstrategia
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
				FROM pedidowebset PWS
				INNER JOIN PedidoWeb PW ON PWS.PedidoID = PW.PedidoID
				inner join PedidoWebSetDetalle PWSD on PWSD.SetID=PWS.SetID
				INNER JOIN PedidoWebDetalle PWD ON PWD.PedidoID = PW.PedidoID and PWSD.CuvProducto =PWD.CUV
				INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) ON PWD.CampaniaID = PC.AnoCampania
					AND PWD.CUV = PC.CUV
				INNER JOIN Estrategia EST ON PWS.EstrategiaID = EST.EstrategiaID
				INNER JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
				LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID

					WHERE PWS.Campania = @CampaniaID
						AND PWS.ConsultoraID = @ConsultoraID
						group by PWS.Campania
			,PWS.PedidoID
			,PWS.ConsultoraId
			,ClienteID
			,PWS.Cantidad
			,PWS.PrecioUnidad
			,PWs.ImporteTotal
			,PWD.OfertaWeb
			,PC.IndicadorMontoMinimo					
			,PWS.CuvSet
			,PWS.NombreSet
			,PWD.ConfiguracionOfertaID
			,PWD.TipoOfertaSisID
			, PWD.TipoPedido 
			,PC.IndicadorOferta
								,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
										, PWD.EsBackOrder 
					,PWD.AceptoBackOrder 
					,PC.CodigoCatalago
					 ,TEP.FlagNueva, TE.FlagNueva
					 ,TEP.Codigo, TE.Codigo
					,EST.EsOfertaIndependiente
					,EST.EstrategiaID
					,EST.TipoEstrategiaID
					,EST.Numeropedido
					,PWS.SetID 
						)Agrupado
						 ORDER BY Agrupado.OrdenPedidoWD DESC
					 ,Agrupado.PedidoDetalleID DESC

end
else
begin

				SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
						WHERE isnull(CodigoPrograma, '') <> ''
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
						,0 as SetID
					FROM @PedidoDetalle PWD
					LEFT JOIN @Estrategia EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					ORDER BY PWD.OrdenPedidoWD DESC
						,PWD.PedidoDetalleID DESC

end


END
GO
use belcorpPanama
go

IF (OBJECT_ID('dbo.GetPedidoWebDetalleByCampania', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetPedidoWebDetalleByCampania AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[GetPedidoWebDetalleByCampania] @CampaniaID INT
	,@ConsultoraID BIGINT
	,@CodigoPrograma VARCHAR(15) = NULL
	,@NumeroPedido INT = 0
	,@AgruparSet bit = 0
AS
BEGIN

declare @FechaRegistroPedido date
declare @FechaInicioSetAgrupado date
set @FechaInicioSetAgrupado ='2017-04-17'

select @FechaRegistroPedido=FechaRegistro from pedidoweb where CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID


if((@AgruparSet=1)and(@FechaRegistroPedido>@FechaInicioSetAgrupado))
begin

					SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						and PWD.TipoEstrategiaID not in (select tipoestrategiaid from tipoestrategia where codigo in ('001','030','008','007','005','010'))

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
					LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
					WHERE TE.FlagActivo = 1

					IF @CodigoPrograma IS NOT NULL
					BEGIN
						DELETE
						FROM @Estrategia2
						WHERE isnull(CodigoPrograma, '') <> ''
							AND Numeropedido <> @NumeroPedido
					END
					select * from(
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
						,0 as SetID
					FROM @PedidoDetalle2 PWD
					LEFT JOIN @Estrategia2 EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					--ORDER BY PWD.OrdenPedidoWD DESC
					--	,PWD.PedidoDetalleID DESC

					union
					SELECT  PWS.Campania
					,PWS.PedidoID
					,0 as PedidoDetalleID
					,0 AS MarcaID
					,PWS.ConsultoraId
					,NULL AS ClienteID
					,max(PWS.OrdenPedido) AS OrdenPedidoWD
					,PWS.Cantidad
					,PWS.PrecioUnidad
					,PWs.ImporteTotal
					,PWS.CuvSet AS CUV
					,0 AS EsKiNueva
					,PWS.NombreSet AS DescripcionProd
					,NULL AS Nombre
					,PWD.OfertaWeb
					,PC.IndicadorMontoMinimo
					,ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
					,ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID
					--,M.Descripcion AS MarcaDescripcion
					,ISNULL(PWD.TipoPedido, 'W') TipoPedido
					,NULL AS MarcaDescripcion
					,'NO DISPONIBLE' AS Categoria
					,PC.IndicadorOferta AS IndicadorOfertaCUV
					,0 AS FlagConsultoraOnline
					,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
					,isnull(PWD.EsBackOrder,0) as EsBackOrder
					,isnull(PWD.AceptoBackOrder,0) as AceptoBackOrder
					,PC.CodigoCatalago
					,'' AS DescripcionOferta
					,'' AS DescripcionEstrategia
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
				FROM pedidowebset PWS
				INNER JOIN PedidoWeb PW ON PWS.PedidoID = PW.PedidoID
				inner join PedidoWebSetDetalle PWSD on PWSD.SetID=PWS.SetID
				INNER JOIN PedidoWebDetalle PWD ON PWD.PedidoID = PW.PedidoID and PWSD.CuvProducto =PWD.CUV
				INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) ON PWD.CampaniaID = PC.AnoCampania
					AND PWD.CUV = PC.CUV
				INNER JOIN Estrategia EST ON PWS.EstrategiaID = EST.EstrategiaID
				INNER JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
				LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID

					WHERE PWS.Campania = @CampaniaID
						AND PWS.ConsultoraID = @ConsultoraID
						group by PWS.Campania
			,PWS.PedidoID
			,PWS.ConsultoraId
			,ClienteID
			,PWS.Cantidad
			,PWS.PrecioUnidad
			,PWs.ImporteTotal
			,PWD.OfertaWeb
			,PC.IndicadorMontoMinimo					
			,PWS.CuvSet
			,PWS.NombreSet
			,PWD.ConfiguracionOfertaID
			,PWD.TipoOfertaSisID
			, PWD.TipoPedido 
			,PC.IndicadorOferta
								,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
										, PWD.EsBackOrder 
					,PWD.AceptoBackOrder 
					,PC.CodigoCatalago
					 ,TEP.FlagNueva, TE.FlagNueva
					 ,TEP.Codigo, TE.Codigo
					,EST.EsOfertaIndependiente
					,EST.EstrategiaID
					,EST.TipoEstrategiaID
					,EST.Numeropedido
					,PWS.SetID 
						)Agrupado
						 ORDER BY Agrupado.OrdenPedidoWD DESC
					 ,Agrupado.PedidoDetalleID DESC

end
else
begin

				SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
						WHERE isnull(CodigoPrograma, '') <> ''
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
						,0 as SetID
					FROM @PedidoDetalle PWD
					LEFT JOIN @Estrategia EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					ORDER BY PWD.OrdenPedidoWD DESC
						,PWD.PedidoDetalleID DESC

end


END
GO
use belcorpPeru
go

IF (OBJECT_ID('dbo.GetPedidoWebDetalleByCampania', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetPedidoWebDetalleByCampania AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[GetPedidoWebDetalleByCampania] @CampaniaID INT
	,@ConsultoraID BIGINT
	,@CodigoPrograma VARCHAR(15) = NULL
	,@NumeroPedido INT = 0
	,@AgruparSet bit = 0
AS
BEGIN

declare @FechaRegistroPedido date
declare @FechaInicioSetAgrupado date
set @FechaInicioSetAgrupado ='2017-04-17'

select @FechaRegistroPedido=FechaRegistro from pedidoweb where CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID


if((@AgruparSet=1)and(@FechaRegistroPedido>@FechaInicioSetAgrupado))
begin

					SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						and PWD.TipoEstrategiaID not in (select tipoestrategiaid from tipoestrategia where codigo in ('001','030','008','007','005','010'))

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
					LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
					WHERE TE.FlagActivo = 1

					IF @CodigoPrograma IS NOT NULL
					BEGIN
						DELETE
						FROM @Estrategia2
						WHERE isnull(CodigoPrograma, '') <> ''
							AND Numeropedido <> @NumeroPedido
					END
					select * from(
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
						,0 as SetID
					FROM @PedidoDetalle2 PWD
					LEFT JOIN @Estrategia2 EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					--ORDER BY PWD.OrdenPedidoWD DESC
					--	,PWD.PedidoDetalleID DESC

					union
					SELECT  PWS.Campania
					,PWS.PedidoID
					,0 as PedidoDetalleID
					,0 AS MarcaID
					,PWS.ConsultoraId
					,NULL AS ClienteID
					,max(PWS.OrdenPedido) AS OrdenPedidoWD
					,PWS.Cantidad
					,PWS.PrecioUnidad
					,PWs.ImporteTotal
					,PWS.CuvSet AS CUV
					,0 AS EsKiNueva
					,PWS.NombreSet AS DescripcionProd
					,NULL AS Nombre
					,PWD.OfertaWeb
					,PC.IndicadorMontoMinimo
					,ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
					,ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID
					--,M.Descripcion AS MarcaDescripcion
					,ISNULL(PWD.TipoPedido, 'W') TipoPedido
					,NULL AS MarcaDescripcion
					,'NO DISPONIBLE' AS Categoria
					,PC.IndicadorOferta AS IndicadorOfertaCUV
					,0 AS FlagConsultoraOnline
					,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
					,isnull(PWD.EsBackOrder,0) as EsBackOrder
					,isnull(PWD.AceptoBackOrder,0) as AceptoBackOrder
					,PC.CodigoCatalago
					,'' AS DescripcionOferta
					,'' AS DescripcionEstrategia
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
				FROM pedidowebset PWS
				INNER JOIN PedidoWeb PW ON PWS.PedidoID = PW.PedidoID
				inner join PedidoWebSetDetalle PWSD on PWSD.SetID=PWS.SetID
				INNER JOIN PedidoWebDetalle PWD ON PWD.PedidoID = PW.PedidoID and PWSD.CuvProducto =PWD.CUV
				INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) ON PWD.CampaniaID = PC.AnoCampania
					AND PWD.CUV = PC.CUV
				INNER JOIN Estrategia EST ON PWS.EstrategiaID = EST.EstrategiaID
				INNER JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
				LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID

					WHERE PWS.Campania = @CampaniaID
						AND PWS.ConsultoraID = @ConsultoraID
						group by PWS.Campania
			,PWS.PedidoID
			,PWS.ConsultoraId
			,ClienteID
			,PWS.Cantidad
			,PWS.PrecioUnidad
			,PWs.ImporteTotal
			,PWD.OfertaWeb
			,PC.IndicadorMontoMinimo					
			,PWS.CuvSet
			,PWS.NombreSet
			,PWD.ConfiguracionOfertaID
			,PWD.TipoOfertaSisID
			, PWD.TipoPedido 
			,PC.IndicadorOferta
								,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
										, PWD.EsBackOrder 
					,PWD.AceptoBackOrder 
					,PC.CodigoCatalago
					 ,TEP.FlagNueva, TE.FlagNueva
					 ,TEP.Codigo, TE.Codigo
					,EST.EsOfertaIndependiente
					,EST.EstrategiaID
					,EST.TipoEstrategiaID
					,EST.Numeropedido
					,PWS.SetID 
						)Agrupado
						 ORDER BY Agrupado.OrdenPedidoWD DESC
					 ,Agrupado.PedidoDetalleID DESC

end
else
begin

				SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
						WHERE isnull(CodigoPrograma, '') <> ''
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
						,0 as SetID
					FROM @PedidoDetalle PWD
					LEFT JOIN @Estrategia EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					ORDER BY PWD.OrdenPedidoWD DESC
						,PWD.PedidoDetalleID DESC

end


END
GO
use belcorpPuertoRico
go

IF (OBJECT_ID('dbo.GetPedidoWebDetalleByCampania', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetPedidoWebDetalleByCampania AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[GetPedidoWebDetalleByCampania] @CampaniaID INT
	,@ConsultoraID BIGINT
	,@CodigoPrograma VARCHAR(15) = NULL
	,@NumeroPedido INT = 0
	,@AgruparSet bit = 0
AS
BEGIN

declare @FechaRegistroPedido date
declare @FechaInicioSetAgrupado date
set @FechaInicioSetAgrupado ='2017-04-17'

select @FechaRegistroPedido=FechaRegistro from pedidoweb where CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID


if((@AgruparSet=1)and(@FechaRegistroPedido>@FechaInicioSetAgrupado))
begin

					SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						and PWD.TipoEstrategiaID not in (select tipoestrategiaid from tipoestrategia where codigo in ('001','030','008','007','005','010'))

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
					LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
					WHERE TE.FlagActivo = 1

					IF @CodigoPrograma IS NOT NULL
					BEGIN
						DELETE
						FROM @Estrategia2
						WHERE isnull(CodigoPrograma, '') <> ''
							AND Numeropedido <> @NumeroPedido
					END
					select * from(
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
						,0 as SetID
					FROM @PedidoDetalle2 PWD
					LEFT JOIN @Estrategia2 EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					--ORDER BY PWD.OrdenPedidoWD DESC
					--	,PWD.PedidoDetalleID DESC

					union
					SELECT  PWS.Campania
					,PWS.PedidoID
					,0 as PedidoDetalleID
					,0 AS MarcaID
					,PWS.ConsultoraId
					,NULL AS ClienteID
					,max(PWS.OrdenPedido) AS OrdenPedidoWD
					,PWS.Cantidad
					,PWS.PrecioUnidad
					,PWs.ImporteTotal
					,PWS.CuvSet AS CUV
					,0 AS EsKiNueva
					,PWS.NombreSet AS DescripcionProd
					,NULL AS Nombre
					,PWD.OfertaWeb
					,PC.IndicadorMontoMinimo
					,ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
					,ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID
					--,M.Descripcion AS MarcaDescripcion
					,ISNULL(PWD.TipoPedido, 'W') TipoPedido
					,NULL AS MarcaDescripcion
					,'NO DISPONIBLE' AS Categoria
					,PC.IndicadorOferta AS IndicadorOfertaCUV
					,0 AS FlagConsultoraOnline
					,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
					,isnull(PWD.EsBackOrder,0) as EsBackOrder
					,isnull(PWD.AceptoBackOrder,0) as AceptoBackOrder
					,PC.CodigoCatalago
					,'' AS DescripcionOferta
					,'' AS DescripcionEstrategia
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
				FROM pedidowebset PWS
				INNER JOIN PedidoWeb PW ON PWS.PedidoID = PW.PedidoID
				inner join PedidoWebSetDetalle PWSD on PWSD.SetID=PWS.SetID
				INNER JOIN PedidoWebDetalle PWD ON PWD.PedidoID = PW.PedidoID and PWSD.CuvProducto =PWD.CUV
				INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) ON PWD.CampaniaID = PC.AnoCampania
					AND PWD.CUV = PC.CUV
				INNER JOIN Estrategia EST ON PWS.EstrategiaID = EST.EstrategiaID
				INNER JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
				LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID

					WHERE PWS.Campania = @CampaniaID
						AND PWS.ConsultoraID = @ConsultoraID
						group by PWS.Campania
			,PWS.PedidoID
			,PWS.ConsultoraId
			,ClienteID
			,PWS.Cantidad
			,PWS.PrecioUnidad
			,PWs.ImporteTotal
			,PWD.OfertaWeb
			,PC.IndicadorMontoMinimo					
			,PWS.CuvSet
			,PWS.NombreSet
			,PWD.ConfiguracionOfertaID
			,PWD.TipoOfertaSisID
			, PWD.TipoPedido 
			,PC.IndicadorOferta
								,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
										, PWD.EsBackOrder 
					,PWD.AceptoBackOrder 
					,PC.CodigoCatalago
					 ,TEP.FlagNueva, TE.FlagNueva
					 ,TEP.Codigo, TE.Codigo
					,EST.EsOfertaIndependiente
					,EST.EstrategiaID
					,EST.TipoEstrategiaID
					,EST.Numeropedido
					,PWS.SetID 
						)Agrupado
						 ORDER BY Agrupado.OrdenPedidoWD DESC
					 ,Agrupado.PedidoDetalleID DESC

end
else
begin

				SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
						WHERE isnull(CodigoPrograma, '') <> ''
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
						,0 as SetID
					FROM @PedidoDetalle PWD
					LEFT JOIN @Estrategia EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					ORDER BY PWD.OrdenPedidoWD DESC
						,PWD.PedidoDetalleID DESC

end


END
GO
use belcorpSalvador
go

IF (OBJECT_ID('dbo.GetPedidoWebDetalleByCampania', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetPedidoWebDetalleByCampania AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[GetPedidoWebDetalleByCampania] @CampaniaID INT
	,@ConsultoraID BIGINT
	,@CodigoPrograma VARCHAR(15) = NULL
	,@NumeroPedido INT = 0
	,@AgruparSet bit = 0
AS
BEGIN

declare @FechaRegistroPedido date
declare @FechaInicioSetAgrupado date
set @FechaInicioSetAgrupado ='2017-04-17'

select @FechaRegistroPedido=FechaRegistro from pedidoweb where CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID


if((@AgruparSet=1)and(@FechaRegistroPedido>@FechaInicioSetAgrupado))
begin

					SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						and PWD.TipoEstrategiaID not in (select tipoestrategiaid from tipoestrategia where codigo in ('001','030','008','007','005','010'))

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
					LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID
					WHERE TE.FlagActivo = 1

					IF @CodigoPrograma IS NOT NULL
					BEGIN
						DELETE
						FROM @Estrategia2
						WHERE isnull(CodigoPrograma, '') <> ''
							AND Numeropedido <> @NumeroPedido
					END
					select * from(
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
						,0 as SetID
					FROM @PedidoDetalle2 PWD
					LEFT JOIN @Estrategia2 EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					--ORDER BY PWD.OrdenPedidoWD DESC
					--	,PWD.PedidoDetalleID DESC

					union
					SELECT  PWS.Campania
					,PWS.PedidoID
					,0 as PedidoDetalleID
					,0 AS MarcaID
					,PWS.ConsultoraId
					,NULL AS ClienteID
					,max(PWS.OrdenPedido) AS OrdenPedidoWD
					,PWS.Cantidad
					,PWS.PrecioUnidad
					,PWs.ImporteTotal
					,PWS.CuvSet AS CUV
					,0 AS EsKiNueva
					,PWS.NombreSet AS DescripcionProd
					,NULL AS Nombre
					,PWD.OfertaWeb
					,PC.IndicadorMontoMinimo
					,ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
					,ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID
					--,M.Descripcion AS MarcaDescripcion
					,ISNULL(PWD.TipoPedido, 'W') TipoPedido
					,NULL AS MarcaDescripcion
					,'NO DISPONIBLE' AS Categoria
					,PC.IndicadorOferta AS IndicadorOfertaCUV
					,0 AS FlagConsultoraOnline
					,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
					,isnull(PWD.EsBackOrder,0) as EsBackOrder
					,isnull(PWD.AceptoBackOrder,0) as AceptoBackOrder
					,PC.CodigoCatalago
					,'' AS DescripcionOferta
					,'' AS DescripcionEstrategia
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
				FROM pedidowebset PWS
				INNER JOIN PedidoWeb PW ON PWS.PedidoID = PW.PedidoID
				inner join PedidoWebSetDetalle PWSD on PWSD.SetID=PWS.SetID
				INNER JOIN PedidoWebDetalle PWD ON PWD.PedidoID = PW.PedidoID and PWSD.CuvProducto =PWD.CUV
				INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) ON PWD.CampaniaID = PC.AnoCampania
					AND PWD.CUV = PC.CUV
				INNER JOIN Estrategia EST ON PWS.EstrategiaID = EST.EstrategiaID
				INNER JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
				LEFT JOIN TipoEstrategia TEP WITH (NOLOCK) ON TEP.TipoEstrategiaID = PWD.TipoEstrategiaID

					WHERE PWS.Campania = @CampaniaID
						AND PWS.ConsultoraID = @ConsultoraID
						group by PWS.Campania
			,PWS.PedidoID
			,PWS.ConsultoraId
			,ClienteID
			,PWS.Cantidad
			,PWS.PrecioUnidad
			,PWs.ImporteTotal
			,PWD.OfertaWeb
			,PC.IndicadorMontoMinimo					
			,PWS.CuvSet
			,PWS.NombreSet
			,PWD.ConfiguracionOfertaID
			,PWD.TipoOfertaSisID
			, PWD.TipoPedido 
			,PC.IndicadorOferta
								,PW.DescuentoProl
					,PW.MontoEscala
					,PW.MontoAhorroCatalogo
					,PW.MontoAhorroRevista
					,PWD.OrigenPedidoWeb
										, PWD.EsBackOrder 
					,PWD.AceptoBackOrder 
					,PC.CodigoCatalago
					 ,TEP.FlagNueva, TE.FlagNueva
					 ,TEP.Codigo, TE.Codigo
					,EST.EsOfertaIndependiente
					,EST.EstrategiaID
					,EST.TipoEstrategiaID
					,EST.Numeropedido
					,PWS.SetID 
						)Agrupado
						 ORDER BY Agrupado.OrdenPedidoWD DESC
					 ,Agrupado.PedidoDetalleID DESC

end
else
begin

				SET NOCOUNT ON
					SET @CodigoPrograma = CASE 
							WHEN @CodigoPrograma = ''
								THEN NULL
							ELSE @CodigoPrograma
							END
					SET @NumeroPedido = CASE 
							WHEN @NumeroPedido > 0
								THEN @NumeroPedido + 1
							ELSE 0
							END

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
						,PRIMARY KEY (EstrategiaID)
						)

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
						AND E.Activo = 1
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
						WHERE isnull(CodigoPrograma, '') <> ''
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
						,0 as SetID
					FROM @PedidoDetalle PWD
					LEFT JOIN @Estrategia EST ON EST.CUV2 = PWD.CUV
						AND PWD.TipoEstrategiaID = EST.TipoEstrategiaID
					ORDER BY PWD.OrdenPedidoWD DESC
						,PWD.PedidoDetalleID DESC

end


END
GO
