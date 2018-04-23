 use belcorpperu_pl50
 go


--VERSION NUEVA PAUL CAMBIO DE ORDEN EN JOIN










IF (OBJECT_ID('dbo.GetPedidoWebDetalleByPedidoValidado', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.GetPedidoWebDetalleByPedidoValidado AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].[GetPedidoWebDetalleByPedidoValidado] @CampaniaID INT

	,@ConsultoraID BIGINT

AS

BEGIN

-- GetPedidoWebDetalleByPedidoValidado 201806,49630628

	/*Para Nuevas obtener el numero de pedido de la consultora.*/

	DECLARE @NumeroPedido INT



	SELECT @NumeroPedido = consecutivonueva + 1

	FROM ods.Consultora WITH (NOLOCK)

	WHERE ConsultoraID = @ConsultoraID



	/*Revisar si la consultora pertenece al programa Nuevas.*/

	DECLARE @ProgramaNuevoActivado INT

	DECLARE @CodigoPrograma VARCHAR(3)



	SELECT @ProgramaNuevoActivado = COUNT(C.ConsultoraID)

		,@CodigoPrograma = CP.CodigoPrograma

	FROM ods.Consultora C WITH (NOLOCK)

	INNER JOIN ods.ConsultorasProgramaNuevas CP WITH (NOLOCK) ON C.Codigo = CP.CodigoConsultora

	WHERE C.ConsultoraID = @ConsultoraID

		AND CP.Participa = 1

	GROUP BY C.ConsultoraID

		,CP.CodigoPrograma



	IF (@ProgramaNuevoActivado IS NULL)

		SET @ProgramaNuevoActivado = 0









declare @FechaRegistroPedido date

declare @FechaInicioSetAgrupado date

set @FechaInicioSetAgrupado =(select datefromparts(valor1, valor2, valor3) from configuracionpaisdatos where Codigo='InicioFechaSetAGrupados')



select @FechaRegistroPedido=FechaRegistro from pedidoweb where CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID





if((cast(@FechaRegistroPedido as date)>cast(@FechaInicioSetAgrupado as date)))

begin



					select * from (

				SELECT pwd.CampaniaID

					,pwd.PedidoID

					,pwd.PedidoDetalleID

					,ISNULL(pwd.MarcaID, 0) MarcaID

					,pwd.ConsultoraID

					,pwd.ClienteID

					,pwd.Cantidad

					,pwd.PrecioUnidad

					,pwd.ImporteTotal

					,pwd.CUV

					,COALESCE(EST.DescripcionCUV2, OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd

					,c.Nombre

					,pwd.OfertaWeb

					,pwd.CUVPadre

					,pwd.PedidoDetalleIDPadre

					,ISNULL(pwd.ConfiguracionOfertaID, 0) ConfiguracionOfertaID

					,ISNULL(pwd.TipoOfertaSisID, 0) TipoOfertaSisID

					,CASE 

						WHEN pwd.ModificaPedidoReservadoMovil = 0

							THEN 'PV'

						ELSE 'PNV'

						END AS TipoPedido

					,pwd.ObservacionPROL

					,pc.IndicadorOferta AS IndicadorOfertaCUV

					--,PW.PedidoID

					,PW.MontoTotalProl

					,PW.DescuentoProl

					,ISNULL(pwd.EsBackOrder, 0) AS EsBackOrder

					,ISNULL(pwd.AceptoBackOrder, 0) AS AceptoBackOrder

				FROM dbo.PedidoWebDetalle pwd

				LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID

					AND pwd.ConsultoraID = c.ConsultoraID

				INNER JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania

					AND pwd.CUV = pc.CUV

				LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID

					AND pwd.CUV = pd.CUV

				LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID

					AND OP.CUV = PC.CUV

				LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania

					AND OG.CUV = PC.CUV

				LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

				LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID

					AND PWD.PedidoID = PW.PedidoID

				LEFT JOIN Estrategia EST WITH (NOLOCK) ON PWD.CampaniaID BETWEEN EST.CampaniaID

						AND CASE 

								WHEN EST.CampaniaIDFin = 0

									THEN EST.CampaniaID

								ELSE EST.CampaniaIDFin

								END

					AND EST.CUV2 = PWD.CUV

					AND EST.Activo = 1

					AND EST.Numeropedido = (

						CASE 

							WHEN @ProgramaNuevoActivado = 0

								THEN 0

							ELSE @NumeroPedido

							END

						)

					AND (

						EST.TipoEstrategiaID = pwd.TipoEstrategiaID

						OR ISNULL(pwd.TipoEstrategiaID, 0) = 0

						)

				LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID

					AND (

						TE.CodigoPrograma = @CodigoPrograma

						OR TE.CodigoPrograma IS NULL

						OR TE.CodigoPrograma = ''

						)

				WHERE pwd.CampaniaID = @CampaniaID

					AND pwd.ConsultoraID = @ConsultoraID

						and pwd.TipoEstrategiaID not in (select tipoestrategiaid from tipoestrategia where codigo in ('001','030','008','007','005','010'))

					union



		 

	

		 				SELECT  PWS.Campania

								,PWS.PedidoID

								,0 as PedidoDetalleID

								,0 AS MarcaID

								,PWS.ConsultoraId

								,NULL AS ClienteID

								,PWS.Cantidad

								,PWS.PrecioUnidad

								,PWs.ImporteTotal

								,PWS.CuvSet AS CUV

								,PWS.NombreSet AS DescripcionProd

								,NULL AS Nombre

								,PWD.OfertaWeb

								,PWS.CuvSet AS CUVPadre

								,null as PedidoDetalleIDPadre

								,ISNULL(PWD.ConfiguracionOfertaID, 0) ConfiguracionOfertaID

								,ISNULL(PWD.TipoOfertaSisID, 0) TipoOfertaSisID

								,CASE 

						WHEN PWD.ModificaPedidoReservadoMovil = 0

							THEN 'PV'

						ELSE 'PNV'

						END AS TipoPedido

						,PWD.ObservacionPROL

					,PC.IndicadorOferta AS IndicadorOfertaCUV

					--,PW.PedidoID

					,PW.MontoTotalProl

					,PW.DescuentoProl

					,ISNULL(PWD.EsBackOrder, 0) AS EsBackOrder

					,ISNULL(PWD.AceptoBackOrder, 0) AS AceptoBackOrder

								 FROM pedidowebset PWS

							INNER JOIN PedidoWeb PW ON  pw.CampaniaId = pws.Campania and PWS.PedidoID = PW.PedidoID

							inner join PedidoWebSetDetalle PWSD on PWSD.SetID=PWS.SetID
							INNER JOIN PedidoWebDetalle PWD ON pw.CampaniaId = pwd.CampaniaId and PWD.PedidoID = PW.PedidoID
							--PWD.PedidoID = PW.PedidoID 
							and PWSD.CuvProducto =PWD.CUV

						
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

								,PWD.ModificaPedidoReservadoMovil,PWD.ObservacionPROL,

								PC.IndicadorOferta 		,PW.PedidoID,PW.MontoTotalProl

	 



				 )Agrupado



				ORDER BY Agrupado.PedidoID



end

else

begin





					SELECT pwd.CampaniaID

						,pwd.PedidoID

						,pwd.PedidoDetalleID

						,ISNULL(pwd.MarcaID, 0) MarcaID

						,pwd.ConsultoraID

						,pwd.ClienteID

						,pwd.Cantidad

						,pwd.PrecioUnidad

						,pwd.ImporteTotal

						,pwd.CUV

						,COALESCE(EST.DescripcionCUV2, OP.Descripcion, OG.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion) AS DescripcionProd

						,c.Nombre

						,pwd.OfertaWeb

						,pwd.CUVPadre

						,pwd.PedidoDetalleIDPadre

						,ISNULL(pwd.ConfiguracionOfertaID, 0) ConfiguracionOfertaID

						,ISNULL(pwd.TipoOfertaSisID, 0) TipoOfertaSisID

						,CASE 

							WHEN pwd.ModificaPedidoReservadoMovil = 0

								THEN 'PV'

							ELSE 'PNV'

							END AS TipoPedido

						,pwd.ObservacionPROL

						,pc.IndicadorOferta AS IndicadorOfertaCUV

						,PW.PedidoID

						,PW.MontoTotalProl

						,PW.DescuentoProl

						,ISNULL(pwd.EsBackOrder, 0) AS EsBackOrder

						,ISNULL(pwd.AceptoBackOrder, 0) AS AceptoBackOrder

					FROM dbo.PedidoWebDetalle pwd

					LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID

						AND pwd.ConsultoraID = c.ConsultoraID

					INNER JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania

						AND pwd.CUV = pc.CUV

					LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID

						AND pwd.CUV = pd.CUV

					LEFT HASH JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID

						AND OP.CUV = PC.CUV

					LEFT JOIN OfertaNueva OG ON OG.CampaniaID = PC.AnoCampania

						AND OG.CUV = PC.CUV

					LEFT JOIN MatrizComercial MC ON PC.CodigoProducto = MC.CodigoSAP

					LEFT JOIN dbo.PedidoWeb PW ON PWD.CampaniaID = PW.CampaniaID

						AND PWD.PedidoID = PW.PedidoID

					LEFT JOIN Estrategia EST WITH (NOLOCK) ON PWD.CampaniaID BETWEEN EST.CampaniaID

							AND CASE 

									WHEN EST.CampaniaIDFin = 0

										THEN EST.CampaniaID

									ELSE EST.CampaniaIDFin

									END

						AND EST.CUV2 = PWD.CUV

						AND EST.Activo = 1

						AND EST.Numeropedido = (

							CASE 

								WHEN @ProgramaNuevoActivado = 0

									THEN 0

								ELSE @NumeroPedido

								END

							)

						AND (

							EST.TipoEstrategiaID = pwd.TipoEstrategiaID

							OR ISNULL(pwd.TipoEstrategiaID, 0) = 0

							)

					LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID

						AND (

							TE.CodigoPrograma = @CodigoPrograma

							OR TE.CodigoPrograma IS NULL

							OR TE.CodigoPrograma = ''

							)

					WHERE pwd.CampaniaID = @CampaniaID

						AND pwd.ConsultoraID = @ConsultoraID

					ORDER BY pwd.PedidoDetalleID

						,ISNULL(pwd.PedidoDetalleIDPadre, 1) DESC;

end



END





