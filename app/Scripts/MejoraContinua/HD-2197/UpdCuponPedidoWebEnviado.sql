GO
USE BelcorpPeru
GO
DROP PROCEDURE IF EXISTS dbo.UpdCuponPedidoWebEnviado;
GO

CREATE PROCEDURE dbo.UpdCuponPedidoWebEnviado
    @NroLote int,
    @FirmarPedido bit
AS
BEGIN
  IF @FirmarPedido = 1
	BEGIN
    declare @tiene_cupon_pais bit
    set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
    IF @tiene_cupon_pais = 1
    BEGIN
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
    END
  END

END

GO
USE BelcorpMexico
GO
DROP PROCEDURE IF EXISTS dbo.UpdCuponPedidoWebEnviado;
GO

CREATE PROCEDURE dbo.UpdCuponPedidoWebEnviado
    @NroLote int,
    @FirmarPedido bit
AS
BEGIN
  IF @FirmarPedido = 1
	BEGIN
    declare @tiene_cupon_pais bit
    set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
    IF @tiene_cupon_pais = 1
    BEGIN
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
    END
  END

END

GO
USE BelcorpColombia
GO
DROP PROCEDURE IF EXISTS dbo.UpdCuponPedidoWebEnviado;
GO

CREATE PROCEDURE dbo.UpdCuponPedidoWebEnviado
    @NroLote int,
    @FirmarPedido bit
AS
BEGIN
  IF @FirmarPedido = 1
	BEGIN
    declare @tiene_cupon_pais bit
    set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
    IF @tiene_cupon_pais = 1
    BEGIN
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
    END
  END

END

GO
USE BelcorpVenezuela
GO
DROP PROCEDURE IF EXISTS dbo.UpdCuponPedidoWebEnviado;
GO

CREATE PROCEDURE dbo.UpdCuponPedidoWebEnviado
    @NroLote int,
    @FirmarPedido bit
AS
BEGIN
  IF @FirmarPedido = 1
	BEGIN
    declare @tiene_cupon_pais bit
    set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
    IF @tiene_cupon_pais = 1
    BEGIN
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
    END
  END

END

GO
USE BelcorpSalvador
GO
DROP PROCEDURE IF EXISTS dbo.UpdCuponPedidoWebEnviado;
GO

CREATE PROCEDURE dbo.UpdCuponPedidoWebEnviado
    @NroLote int,
    @FirmarPedido bit
AS
BEGIN
  IF @FirmarPedido = 1
	BEGIN
    declare @tiene_cupon_pais bit
    set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
    IF @tiene_cupon_pais = 1
    BEGIN
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
    END
  END

END

GO
USE BelcorpPuertoRico
GO
DROP PROCEDURE IF EXISTS dbo.UpdCuponPedidoWebEnviado;
GO

CREATE PROCEDURE dbo.UpdCuponPedidoWebEnviado
    @NroLote int,
    @FirmarPedido bit
AS
BEGIN
  IF @FirmarPedido = 1
	BEGIN
    declare @tiene_cupon_pais bit
    set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
    IF @tiene_cupon_pais = 1
    BEGIN
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
    END
  END

END

GO
USE BelcorpPanama
GO
DROP PROCEDURE IF EXISTS dbo.UpdCuponPedidoWebEnviado;
GO

CREATE PROCEDURE dbo.UpdCuponPedidoWebEnviado
    @NroLote int,
    @FirmarPedido bit
AS
BEGIN
  IF @FirmarPedido = 1
	BEGIN
    declare @tiene_cupon_pais bit
    set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
    IF @tiene_cupon_pais = 1
    BEGIN
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
    END
  END

END

GO
USE BelcorpGuatemala
GO
DROP PROCEDURE IF EXISTS dbo.UpdCuponPedidoWebEnviado;
GO

CREATE PROCEDURE dbo.UpdCuponPedidoWebEnviado
    @NroLote int,
    @FirmarPedido bit
AS
BEGIN
  IF @FirmarPedido = 1
	BEGIN
    declare @tiene_cupon_pais bit
    set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
    IF @tiene_cupon_pais = 1
    BEGIN
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
    END
  END

END

GO
USE BelcorpEcuador
GO
DROP PROCEDURE IF EXISTS dbo.UpdCuponPedidoWebEnviado;
GO

CREATE PROCEDURE dbo.UpdCuponPedidoWebEnviado
    @NroLote int,
    @FirmarPedido bit
AS
BEGIN
  IF @FirmarPedido = 1
	BEGIN
    declare @tiene_cupon_pais bit
    set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
    IF @tiene_cupon_pais = 1
    BEGIN
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
    END
  END

END

GO
USE BelcorpDominicana
GO
DROP PROCEDURE IF EXISTS dbo.UpdCuponPedidoWebEnviado;
GO

CREATE PROCEDURE dbo.UpdCuponPedidoWebEnviado
    @NroLote int,
    @FirmarPedido bit
AS
BEGIN
  IF @FirmarPedido = 1
	BEGIN
    declare @tiene_cupon_pais bit
    set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
    IF @tiene_cupon_pais = 1
    BEGIN
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
    END
  END

END

GO
USE BelcorpCostaRica
GO
DROP PROCEDURE IF EXISTS dbo.UpdCuponPedidoWebEnviado;
GO

CREATE PROCEDURE dbo.UpdCuponPedidoWebEnviado
    @NroLote int,
    @FirmarPedido bit
AS
BEGIN
  IF @FirmarPedido = 1
	BEGIN
    declare @tiene_cupon_pais bit
    set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
    IF @tiene_cupon_pais = 1
    BEGIN
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
    END
  END

END

GO
USE BelcorpChile
GO
DROP PROCEDURE IF EXISTS dbo.UpdCuponPedidoWebEnviado;
GO

CREATE PROCEDURE dbo.UpdCuponPedidoWebEnviado
    @NroLote int,
    @FirmarPedido bit
AS
BEGIN
  IF @FirmarPedido = 1
	BEGIN
    declare @tiene_cupon_pais bit
    set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
    IF @tiene_cupon_pais = 1
    BEGIN
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
    END
  END

END

GO
USE BelcorpBolivia
GO
DROP PROCEDURE IF EXISTS dbo.UpdCuponPedidoWebEnviado;
GO

CREATE PROCEDURE dbo.UpdCuponPedidoWebEnviado
    @NroLote int,
    @FirmarPedido bit
AS
BEGIN
  IF @FirmarPedido = 1
	BEGIN
    declare @tiene_cupon_pais bit
    set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
    IF @tiene_cupon_pais = 1
    BEGIN
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
    END
  END

END

GO
