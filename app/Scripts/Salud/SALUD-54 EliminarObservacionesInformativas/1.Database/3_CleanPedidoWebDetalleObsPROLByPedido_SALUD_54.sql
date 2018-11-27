USE BelcorpBolivia
GO
IF object_id('dbo.CleanPedidoWebDetalleObsPROLByPedido') is not null
BEGIN
	DROP PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
END
GO
CREATE PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
	@CampaniaID int,
	@PedidoID int
AS
BEGIN
	update PedidoWebDetalle
	set ObservacionPROL = null
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
END
GO

USE BelcorpChile
GO
IF object_id('dbo.CleanPedidoWebDetalleObsPROLByPedido') is not null
BEGIN
	DROP PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
END
GO
CREATE PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
	@CampaniaID int,
	@PedidoID int
AS
BEGIN
	update PedidoWebDetalle
	set ObservacionPROL = null
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
END
GO

USE BelcorpColombia
GO
IF object_id('dbo.CleanPedidoWebDetalleObsPROLByPedido') is not null
BEGIN
	DROP PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
END
GO
CREATE PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
	@CampaniaID int,
	@PedidoID int
AS
BEGIN
	update PedidoWebDetalle
	set ObservacionPROL = null
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
END
GO

USE BelcorpCostaRica
GO
IF object_id('dbo.CleanPedidoWebDetalleObsPROLByPedido') is not null
BEGIN
	DROP PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
END
GO
CREATE PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
	@CampaniaID int,
	@PedidoID int
AS
BEGIN
	update PedidoWebDetalle
	set ObservacionPROL = null
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
END
GO

USE BelcorpDominicana
GO
IF object_id('dbo.CleanPedidoWebDetalleObsPROLByPedido') is not null
BEGIN
	DROP PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
END
GO
CREATE PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
	@CampaniaID int,
	@PedidoID int
AS
BEGIN
	update PedidoWebDetalle
	set ObservacionPROL = null
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
END
GO

USE BelcorpEcuador
GO
IF object_id('dbo.CleanPedidoWebDetalleObsPROLByPedido') is not null
BEGIN
	DROP PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
END
GO
CREATE PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
	@CampaniaID int,
	@PedidoID int
AS
BEGIN
	update PedidoWebDetalle
	set ObservacionPROL = null
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
END
GO

USE BelcorpGuatemala
GO
IF object_id('dbo.CleanPedidoWebDetalleObsPROLByPedido') is not null
BEGIN
	DROP PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
END
GO
CREATE PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
	@CampaniaID int,
	@PedidoID int
AS
BEGIN
	update PedidoWebDetalle
	set ObservacionPROL = null
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
END
GO

USE BelcorpMexico
GO
IF object_id('dbo.CleanPedidoWebDetalleObsPROLByPedido') is not null
BEGIN
	DROP PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
END
GO
CREATE PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
	@CampaniaID int,
	@PedidoID int
AS
BEGIN
	update PedidoWebDetalle
	set ObservacionPROL = null
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
END
GO

USE BelcorpPanama
GO
IF object_id('dbo.CleanPedidoWebDetalleObsPROLByPedido') is not null
BEGIN
	DROP PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
END
GO
CREATE PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
	@CampaniaID int,
	@PedidoID int
AS
BEGIN
	update PedidoWebDetalle
	set ObservacionPROL = null
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
END
GO

USE BelcorpPeru
GO
IF object_id('dbo.CleanPedidoWebDetalleObsPROLByPedido') is not null
BEGIN
	DROP PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
END
GO
CREATE PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
	@CampaniaID int,
	@PedidoID int
AS
BEGIN
	update PedidoWebDetalle
	set ObservacionPROL = null
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
END
GO

USE BelcorpPuertoRico
GO
IF object_id('dbo.CleanPedidoWebDetalleObsPROLByPedido') is not null
BEGIN
	DROP PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
END
GO
CREATE PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
	@CampaniaID int,
	@PedidoID int
AS
BEGIN
	update PedidoWebDetalle
	set ObservacionPROL = null
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
END
GO

USE BelcorpSalvador
GO
IF object_id('dbo.CleanPedidoWebDetalleObsPROLByPedido') is not null
BEGIN
	DROP PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
END
GO
CREATE PROC dbo.CleanPedidoWebDetalleObsPROLByPedido
	@CampaniaID int,
	@PedidoID int
AS
BEGIN
	update PedidoWebDetalle
	set ObservacionPROL = null
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
END
GO