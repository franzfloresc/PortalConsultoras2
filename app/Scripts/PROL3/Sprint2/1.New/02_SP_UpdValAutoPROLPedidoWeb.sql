GO
IF object_id('dbo.UpdValAutoPROLPedidoWeb') is null
BEGIN
	exec sp_executesql N'create proc dbo.UpdValAutoPROLPedidoWeb as'
END
GO
ALTER PROCEDURE dbo.UpdValAutoPROLPedidoWeb
    @CampaniaId int,
    @PedidoId int,
    @EstadoPedido int,
    @ItemsEliminados bit,
	@MontoTotalProl money,
	@DescuentoProl money,
	@MontoEscala money,
	@MontoAhorroRevista money,
	@MontoAhorroCatalogo money,
	@PedidoSapId bigint,
	@VersionProl tinyint
AS
BEGIN
    declare @ImporteTotal decimal = 0;
    declare @Clientes decimal = 0;
	declare @FechaPais datetime = dbo.fnObtenerFechaHoraPais();
	
    IF @ItemsEliminados = 1
    BEGIN
        SELECT @ImporteTotal = ISNULL(SUM(ImporteTotal),0)
        FROM PedidoWebDetalle
        WHERE CampaniaID = @CampaniaId AND PedidoID = @PedidoId;

        SELECT @Clientes = COUNT(ClienteID)
        FROM PedidoWebDetalle
        WHERE CampaniaID = @CampaniaId AND PedidoID = @PedidoId AND ClienteID IS NOT NULL
        GROUP BY ClienteID;
    END
	
    UPDATE PedidoWeb
    SET
		EstadoPedido = @EstadoPedido,
		FechaModificacion = @FechaPais,
		FechaReserva = iif(@EstadoPedido = 201, FechaReserva, @FechaPais),
		CodigoUsuarioModificacion = 'VALAUTOPROL',
		ImporteTotal = iif(@ItemsEliminados = 1, @ImporteTotal, ImporteTotal),
		Clientes = iif(@ItemsEliminados = 1, @Clientes, Clientes),
		ValidacionAbierta = 0,
		MontoTotalProl = @MontoTotalProl,
		DescuentoProl = @DescuentoProl,
		MontoEscala = @MontoEscala,
		MontoAhorroCatalogo = @MontoAhorroCatalogo,
		MontoAhorroRevista = @MontoAhorroRevista,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
    WHERE CampaniaID = @CampaniaId AND PedidoID = @PedidoId;
END
GO