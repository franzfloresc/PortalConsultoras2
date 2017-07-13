use BelcorpGuatemala
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

	--****************actualiza estado cupon utilizado****************
		declare @tiene_cupon_pais bit 
		set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)	
		
		create table #pedido_cupon(CampaniaID int,pedidoId int,CuponID int,CodigoConsultora varchar(25),TipoCupon char(2),ValorCupon Char(12)) 
		create index #pedido_cupon_idx_1 on #pedido_cupon(CuponID,CampaniaID,CodigoConsultora)
		create index #pedido_cupon_idx_2 on #pedido_cupon(CampaniaID,PedidoID)
		create index #pedido_cupon_idx_3 on #pedido_cupon(CodigoConsultora)

		if @tiene_cupon_pais = 1
		Begin 
			insert into #pedido_cupon(CampaniaID,pedidoId,CuponID,CodigoConsultora,TipoCupon)
			select Distinct
				pedido.CampaniaID,
				pedido.PedidoID,
				Cupon.CuponID,
				CodigoConsultora = Consultora.Codigo,
				TipoCupon = '00'
			From TempPedidoWebID carga with (nolock) 
				Inner join PedidoWeb pedido with (nolock) on 
					carga.CampaniaId = pedido.CampaniaId and 
					carga.PedidoId = pedido.PedidoId 
				Inner Join ods.Consultora consultora with (nolock) on 
					consultora.ConsultoraID = pedido.ConsultoraID 
				Inner join Cupon with (nolock) On 
					pedido.CampaniaId = Cupon.CampaniaId And Cupon.Estado = 1
			Where carga.NroLote = @NroLote

			Update CuponConsultora
			Set CuponConsultora.EstadoCupon = 3 
			From #pedido_cupon pedido
				Inner join Cupon with (nolock) On 
					pedido.CampaniaId = Cupon.CampaniaId And Cupon.Estado = 1
				Inner join CuponConsultora with (nolock) On 
					CuponConsultora.CuponID = pedido.CuponID And 
					CuponConsultora.CampaniaId = pedido.CampaniaId And 
					CuponConsultora.CodigoConsultora = pedido.CodigoConsultora And 
					CuponConsultora.EstadoCupon = 2
				Inner Join Usuario with (nolock) on 
					Usuario.CodigoConsultora = pedido.CodigoConsultora
				Inner hash join dbo.PedidoWebDetalle pedido_detalle with(nolock) on 
					pedido.CampaniaID = pedido_detalle.CampaniaID and 
					pedido.PedidoID = pedido_detalle.PedidoID and 
					pedido_detalle.PedidoID != 0
				Inner join ods.Campania campania with(nolock) on 
					pedido_detalle.CampaniaID = campania.Codigo
				Inner join ods.ProductoComercial producto with(nolock) on 
					campania.CampaniaID = producto.CampaniaID and 
					pedido_detalle.CUV = producto.CUV
			Where 1 = 1 
				And Usuario.EmailActivo = 1 
				And producto.CodigoCatalago in (35,44,45,46)
				
			Drop Table #pedido_cupon
		End
	--****************************************************************								
		
	end

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
