GO
ALTER PROCEDURE GetProductosOfertaConsultoraNueva
	@CampaniaID INT,
	@ConsultoraID INT
AS
BEGIN
	DECLARE @NroCampania INT = (SELECT TOP 1 nrocampanias FROM pais with(nolock) WHERE EstadoActivo = 1);

	DECLARE @ultimacampaniafacturable INT;
	DECLARE @idcampaniaingreso INT;
	SELECT
		@idcampaniaingreso = AnoCampanaIngreso,
		@ultimacampaniafacturable = isnull(iif(TipoFacturacion = 'FA', UltimaCampanaFacturada, dbo.fnAddCampaniaAndNumero(UltimaCampanaFacturada,-1,@NroCampania)),0)
	FROM ods.Consultora WHERE ConsultoraID=@ConsultoraID;
		
	DECLARE @campaniafacturableingreso INT = @ultimacampaniafacturable - @idcampaniaingreso;
	DECLARE @campaniacompare INT = dbo.fnAddCampaniaAndNumero2(@ultimacampaniafacturable,1,@NroCampania);
	DECLARE @NumeroPedido INT;	
	DECLARE @indicador INT = 0;

	if @CampaniaID = @campaniacompare and (@campaniafacturableingreso between 0 and 3)
	begin		
		declare @CampaniaID1 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -1, @NroCampania);
		declare @CampaniaID2 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -2, @NroCampania);
		declare @CampaniaID3 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -3, @NroCampania);
		declare @CampaniaID4 int = dbo.fnAddCampaniaAndNumero2(@CampaniaID, -4, @NroCampania);

		declare @idCampaniaID1 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID1);
		declare @idCampaniaID2 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID2);
		declare @idCampaniaID3 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID3);
		declare @idCampaniaID4 int = (SELECT top 1 campaniaid FROM ods.Campania with(nolock) WHERE codigo = @CampaniaID4);

		declare @campaniasFacturas int;

		---la consultora es nueva, esta realizando su segundo pedido compruebo que la campaña anterior tenga pedido facturado
		if @campaniafacturableingreso = 0
		begin
			set @NumeroPedido = 1;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1) and consultoraid = @ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 1, 1,0);
		end
		---la consultora es nueva, esta realizando su tercer pedido compruebo que las 2 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 1
		begin
			set @NumeroPedido=2;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 2, 1,0);
		end
		---la consultora es nueva, esta realizando su cuarto pedido compruebo que las 3 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 2
		begin
			set @NumeroPedido=3;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido with(nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 3, 1,0);
		end
		---la consultora es nueva, esta realizando su quINTo pedido compruebo que las 4 campañas anteriores tengan pedidos facturados
		else if @campaniafacturableingreso = 3
		begin
			set @NumeroPedido=4;
			set @campaniasFacturas = (SELECT count(distinct CampaniaID) FROM ods.Pedido (nolock) WHERE CampaniaID in (@idCampaniaID1,@idCampaniaID2,@idCampaniaID3,@idCampaniaID4) and consultoraid=@ConsultoraID);
			set @indicador = iif(@campaniasFacturas = 4, 1,0);
		end
	end

	IF @indicador = 1 and (@campaniafacturableingreso between 0 and 3)
	begin
		SELECT TOP 4
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			MarcaID,
			IndicadorMontoMinimo,
			DescripcionProd,
			UnidadesPermitidas,
			(case when len(IndicadorPedido) >0 then 1 else 0 end) IndicadorPedido,
			ganahasta
		FROM (
			SELECT
				og.OfertaNuevaId,
				og.NumeroPedido,
				case isnull(og.FlagImagenActiva,0)
					when 1 then og.ImagenProducto01
					when 2 then og.ImagenProducto02
					when 3 then og.ImagenProducto03
					else ''
				end ImagenProducto01,
				og.Descripcion,
				og.CUV,
				og.PrecioNormal,
				og.PrecioParaTi,
				pc.MarcaID,
				pc.IndicadorMontoMinimo,
				coalesce(pd.Descripcion, pc.Descripcion) DescripcionProd,
				dbo.fnObtenerCantidadOfertaNueva(og.CUV, og.CampaniaID, og.UnidadesPermitidas,og.TipoOfertaSisID, og.ConfiguracionOfertaID) UnidadesPermitidas,
				isnull(pwd.CUV,'') IndicadorPedido,
				isnull(og.ganahasta, 0) ganahasta
			FROM dbo.OfertaNueva  og with(nolock)
			inner join ods.ProductoComercial pc with(nolock) on og.CUV = pc.CUV and og.CampaniaID = pc.AnoCampania
			inner join ods.Campania ca with(nolock) on pc.CampaniaID = ca.CampaniaID
			left join dbo.ProductoDescripcion pd with(nolock) on og.CampaniaID = pd.CampaniaID and og.CUV = pd.CUV
			left join PedidoWebDetalle pwd with(nolock) on pwd.CUV=og.CUV and pwd.CampaniaID= @CampaniaID and pwd.ConsultoraID=@ConsultoraID
			WHERE
				ca.CodiGO = @CampaniaID and
				og.FlagHabilitarOferta = 1 and
				og.NumeroPedido=@NumeroPedido and
				og.CUV not in(SELECT CUV FROM PedidoWebDetalle with(nolock) WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID)
		) a
		WHERE a.UnidadesPermitidas > 0
		order by 5 asc
	end
	else
	begin
		SELECT
			OfertaNuevaId,
			NumeroPedido,
			ImagenProducto01,
			Descripcion,
			CUV,
			PrecioNormal,
			PrecioParaTi,
			'' MarcaID,
			'' IndicadorMontoMinimo,
			'' DescripcionProd,
			UnidadesPermitidas,
			0 IndicadorPedido,
			0 ganahasta
		FROM OfertaNueva with(nolock)
		WHERE OfertaNuevaID < 0
		order by 5 asc
	end
END
GO