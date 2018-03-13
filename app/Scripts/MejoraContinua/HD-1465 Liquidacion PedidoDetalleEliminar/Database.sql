USE BelcorpBolivia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPK' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPK
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPK
	@CampaniaID int,  
	@PedidoID int,  
	@PedidoDetalleID smallint
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and PedidoDetalleID = @PedidoDetalleID
END
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPedidoAndCUV' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
	@CampaniaID int,  
	@PedidoID int,  
	@CUV varchar(20)
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and CUV = @CUV
END
GO
/*end*/

USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPK' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPK
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPK
	@CampaniaID int,  
	@PedidoID int,  
	@PedidoDetalleID smallint
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and PedidoDetalleID = @PedidoDetalleID
END
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPedidoAndCUV' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
	@CampaniaID int,  
	@PedidoID int,  
	@CUV varchar(20)
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and CUV = @CUV
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPK' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPK
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPK
	@CampaniaID int,  
	@PedidoID int,  
	@PedidoDetalleID smallint
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and PedidoDetalleID = @PedidoDetalleID
END
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPedidoAndCUV' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
	@CampaniaID int,  
	@PedidoID int,  
	@CUV varchar(20)
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and CUV = @CUV
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPK' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPK
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPK
	@CampaniaID int,  
	@PedidoID int,  
	@PedidoDetalleID smallint
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and PedidoDetalleID = @PedidoDetalleID
END
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPedidoAndCUV' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
	@CampaniaID int,  
	@PedidoID int,  
	@CUV varchar(20)
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and CUV = @CUV
END
GO
/*end*/

USE BelcorpDominicana
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPK' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPK
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPK
	@CampaniaID int,  
	@PedidoID int,  
	@PedidoDetalleID smallint
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and PedidoDetalleID = @PedidoDetalleID
END
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPedidoAndCUV' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
	@CampaniaID int,  
	@PedidoID int,  
	@CUV varchar(20)
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and CUV = @CUV
END
GO
/*end*/

USE BelcorpEcuador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPK' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPK
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPK
	@CampaniaID int,  
	@PedidoID int,  
	@PedidoDetalleID smallint
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and PedidoDetalleID = @PedidoDetalleID
END
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPedidoAndCUV' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
	@CampaniaID int,  
	@PedidoID int,  
	@CUV varchar(20)
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and CUV = @CUV
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPK' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPK
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPK
	@CampaniaID int,  
	@PedidoID int,  
	@PedidoDetalleID smallint
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and PedidoDetalleID = @PedidoDetalleID
END
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPedidoAndCUV' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
	@CampaniaID int,  
	@PedidoID int,  
	@CUV varchar(20)
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and CUV = @CUV
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPK' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPK
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPK
	@CampaniaID int,  
	@PedidoID int,  
	@PedidoDetalleID smallint
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and PedidoDetalleID = @PedidoDetalleID
END
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPedidoAndCUV' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
	@CampaniaID int,  
	@PedidoID int,  
	@CUV varchar(20)
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and CUV = @CUV
END
GO
/*end*/

USE BelcorpPanama
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPK' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPK
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPK
	@CampaniaID int,  
	@PedidoID int,  
	@PedidoDetalleID smallint
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and PedidoDetalleID = @PedidoDetalleID
END
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPedidoAndCUV' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
	@CampaniaID int,  
	@PedidoID int,  
	@CUV varchar(20)
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and CUV = @CUV
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPK' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPK
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPK
	@CampaniaID int,  
	@PedidoID int,  
	@PedidoDetalleID smallint
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and PedidoDetalleID = @PedidoDetalleID
END
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPedidoAndCUV' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
	@CampaniaID int,  
	@PedidoID int,  
	@CUV varchar(20)
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and CUV = @CUV
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPK' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPK
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPK
	@CampaniaID int,  
	@PedidoID int,  
	@PedidoDetalleID smallint
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and PedidoDetalleID = @PedidoDetalleID
END
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPedidoAndCUV' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
	@CampaniaID int,  
	@PedidoID int,  
	@CUV varchar(20)
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and CUV = @CUV
END
GO
/*end*/

USE BelcorpSalvador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPK' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPK
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPK
	@CampaniaID int,  
	@PedidoID int,  
	@PedidoDetalleID smallint
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and PedidoDetalleID = @PedidoDetalleID
END
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPedidoAndCUV' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
	@CampaniaID int,  
	@PedidoID int,  
	@CUV varchar(20)
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and CUV = @CUV
END
GO
/*end*/

USE BelcorpVenezuela
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPK' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPK
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPK
	@CampaniaID int,  
	@PedidoID int,  
	@PedidoDetalleID smallint
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and PedidoDetalleID = @PedidoDetalleID
END
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoWebDetalleByPedidoAndCUV' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
END
GO
CREATE PROCEDURE dbo.GetPedidoWebDetalleByPedidoAndCUV
	@CampaniaID int,  
	@PedidoID int,  
	@CUV varchar(20)
AS
BEGIN
	select top 1
		CampaniaID,
		PedidoID,
		PedidoDetalleID,
		ISNULL(MarcaID,0) AS MarcaID,
		ConsultoraID,
		ClienteID,
		OrdenPedidoWD,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		CUV,
		EsKitNueva,			
		OfertaWeb,
		ISNULL(ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(TipoOfertaSisID,0) TipoOfertaSisID,
		ISNULL(TipoPedido, 'W') TipoPedido,
		OrigenPedidoWeb,
		EsBackOrder,
		AceptoBackOrder
	from PedidoWebDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID and CUV = @CUV
END
GO