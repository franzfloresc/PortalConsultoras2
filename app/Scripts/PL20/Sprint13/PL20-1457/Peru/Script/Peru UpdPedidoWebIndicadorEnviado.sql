use BelcorpPeru
go
alter procedure dbo.UpdPedidoWebIndicadorEnviado  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
	-- Actualiza estado de pedidos para descarga
	-- Actualiza el indicadorGPR
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();
	DECLARE @IndicadorGPRPais BIT;
	SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1;

	if @FirmarPedido = 1
	begin
		update dbo.PedidoWeb
		set
			IndicadorEnviado = 1,
			GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
			FechaProceso = @FechaGeneral
		from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @NroLote;
		
--*********************actualizar estado cupon utilizado*********************
		declare @tiene_cupon_pais bit 
		set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)	

		if @tiene_cupon_pais = 1
		Begin 
			Update CuponConsultora
			Set CuponConsultora.EstadoCupon = 3
			From PedidoWeb pedido with (nolock)
				Inner join TempPedidoWebID carga with (nolock)  on pedido.CampaniaID = carga.CampaniaID and pedido.PedidoID = carga.PedidoID			
				Inner Join ods.Consultora consultora with (nolock) on pedido.ConsultoraID = consultora.ConsultoraID
				Inner join Cupon with (nolock) On 
					Pedido.CampaniaId = Cupon.CampaniaId And 
					Cupon.Estado = 1 
				Inner join CuponConsultora with (nolock) On 
					Cupon.CuponID = CuponConsultora.CuponID And 
					Cupon.CampaniaId = CuponConsultora.CampaniaId And 
					consultora.Codigo = CuponConsultora.CodigoConsultora And 
					CuponConsultora.EstadoCupon = 2
				Inner Join Usuario with (nolock) on 
					Usuario.CodigoConsultora = consultora.Codigo
				Inner Join PedidoWebDetalle pedido_detalle with (nolock) on 
					pedido.PedidoId = pedido_detalle.PedidoId And 
					pedido.CampaniaId = pedido_detalle.CampaniaId  
				Inner join ods.Campania campania with(nolock) on 
					pedido_detalle.CampaniaID = campania.Codigo
				Inner join ods.ProductoComercial producto with(nolock) on 
					campania.CampaniaID = producto.CampaniaID and 
					pedido_detalle.CUV = producto.CUV								
			Where 
				carga.NroLote = @NroLote And	
				Usuario.EmailActivo = 1 And 
				isnull(pedido_detalle.EsKitNueva, '0') != 1 And
				producto.CodigoCatalago in (35,44,45,46)  --Los valores relaciones son: 35 (Oferta Final), 44 (Showroom), 45 (Ofertas Para Ti) y 46 (Oferta Del Día)
				
		End		
	End
--**************************************************	

	update dbo.PedidoDescarga
	set
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @NroLote;

	delete dbo.TempPedidoWebID
	where NroLote = @NroLote;
end

GO
