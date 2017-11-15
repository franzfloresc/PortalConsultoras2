USE BelcorpBolivia
go

declare @PaisId int = 2
declare @tablaCuvAgregar table (
	ConsultoraId int,
	CodigoConsultora varchar(20),
	CampaniaId int,
	RegionId int,
	CodigoRegion varchar(2),
	ZonaId int,
	CodigoZona varchar(4),
	CUV varchar(5),
	Cantidad int
)

insert into @tablaCuvAgregar
select pr.ConsultoraID, pr.CodigoConsultora, pr.CampaniaID,
	r.RegionID, r.Codigo, 
	z.ZonaID, z.Codigo,
	prd.CUV, prd.Cantidad
from (
	select * from PedidoRecuperacion with(nolock)
) pr
inner join PedidoRecuperacionDetalle prd with(nolock) on
	pr.PedidoRecuperacionId = prd.PedidoRecuperacionId
inner join ods.Consultora c with(nolock) on
	pr.ConsultoraId = c.ConsultoraID
inner join ods.Zona z with(nolock) on
	c.ZonaID = z.ZonaID
inner join ods.Region r with(nolock) on
	c.RegionID = r.RegionID
where 
	c.consultoraid not in (
		select consultoraid from Pedidoweb with(nolock) where campaniaid = pr.CampaniaID
	)
/**/

/*Para el cursor*/
declare @ConsultoraId int
declare @CodigoConsultora varchar(20)
declare @CampaniaId int
declare @RegionId int
declare @CodigoRegion varchar(2)
declare @ZonaId int
declare @CodigoZona varchar(4)
declare @CUV varchar(5)
declare @Cantidad int

DECLARE cursorPedido CURSOR
    FOR SELECT ConsultoraId,CodigoConsultora,CampaniaId,
			RegionID,CodigoRegion,ZonaId,CodigoZona,CUV,Cantidad
		FROM @tablaCuvAgregar
OPEN cursorPedido
FETCH NEXT FROM cursorPedido into @ConsultoraId,@CodigoConsultora,@CampaniaId,@RegionId,@CodigoRegion,@ZonaId,@CodigoZona,@CUV,@Cantidad

WHILE @@FETCH_STATUS = 0   
BEGIN         
		declare @tablaCUV table(
			CUV varchar(20), Descripcion varchar(100), PrecioCatalogo decimal(18,2), 
			MarcaID int, EstaEnRevista int, TieneStock int, EsExpoOferta int,
			CUVRevista varchar(20), CUVComplemento varchar(20), PaisID int,
			CampaniaID varchar(6), CodigoCatalago varchar(6), CodigoProducto varchar(12),
			IndicadorMontoMinimo int, DescripcionMarca varchar(20), DescripcionCategoria varchar(20),
			DescripcionEstrategia varchar(200), ConfiguracionOfertaID int, TipoOfertaSisID int,
			FlagNueva int, TipoEstrategiaID int, IndicadorOferta bit, TieneSugerido int, TieneOfertaRevista int,
			PrecioValorizado decimal(18,2), TieneLanzamientoCatalogoPersonalizado bit, TipoOfertaRevista VARCHAR(20),
			TipoEstrategiaCodigo varchar(100), EsOfertaIndependiente bit
		) 

		insert into @tablaCUV
		exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 @CampaniaId,1,1,@CUV,@RegionId,@ZonaId,@CodigoRegion,@CodigoZona 
		--print @CUV + ' ' + @CodigoConsultora

		--insert pedido detalle
		declare @PedidoID int = 0
		exec InsPedidoWeb @CampaniaId,@ConsultoraId,@PaisId,null,@PedidoID output,@CodigoConsultora

		declare @MarcaID int = 0
		declare @PrecioUnidad money = 0
		declare @ConfiguracionOfertaID int = 0
		declare @TipoOfertaSisID int = 0

		select top 1 @MarcaID = MarcaID,
			@PrecioUnidad = PrecioCatalogo,
			@ConfiguracionOfertaID = ConfiguracionOfertaID,
			@TipoOfertaSisID = TipoOfertaSisID 
		from @tablaCUV

		--falta verificar
		declare @OfertaWeb bit = 0
		declare @EsSugerido bit = 0
		declare @EskitNueva bit = 0
		declare @OrigenPedidoWeb int = 0

		declare @PedidoDetalleID smallint = 0
		exec InsPedidoWebDetalle_SB2 @CampaniaId,@ConsultoraId,@MarcaID,null,@Cantidad,@PrecioUnidad,@CUV,
									@PedidoID,@OfertaWeb,@ConfiguracionOfertaID,@TipoOfertaSisID,@PedidoDetalleID output,
									@CodigoConsultora,0,@EsSugerido,@EskitNueva,@OrigenPedidoWeb

	   FETCH NEXT FROM cursorPedido INTO @ConsultoraId,@CodigoConsultora,@CampaniaId,@RegionId,@CodigoRegion,@ZonaId,@CodigoZona,@CUV,@Cantidad
END