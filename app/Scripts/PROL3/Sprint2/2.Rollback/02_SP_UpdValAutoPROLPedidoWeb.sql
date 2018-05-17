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
	@MontoAhorroCatalogo money
AS
BEGIN
    DECLARE @ImporteTotal decimal
    DECLARE @Clientes decimal
    SET @Clientes = 0
    IF @EstadoPedido = 201
    BEGIN
        IF @ItemsEliminados = 1
        BEGIN
            SELECT @ImporteTotal = ISNULL(SUM(ImporteTotal),0)
            FROM PedidoWebDetalle
            WHERE CampaniaID = @CampaniaId AND PedidoID = @PedidoId;

            SELECT @Clientes = COUNT(ClienteID)
            FROM PedidoWebDetalle
            WHERE CampaniaID = @CampaniaId AND PedidoID = @PedidoId AND ClienteID IS NOT NULL
            GROUP BY ClienteID;

            UPDATE PedidoWeb
            SET		
				EstadoPedido = @EstadoPedido,
				FechaModificacion = dbo.fnObtenerFechaHoraPais(),
				CodigoUsuarioModificacion = 'VALAUTOPROL',
				ImporteTotal = @ImporteTotal,
				Clientes = @Clientes,
				ValidacionAbierta = 0,
				MontoTotalProl = @MontoTotalProl,
				DescuentoProl = @DescuentoProl,
				MontoEscala = @MontoEscala,
				MontoAhorroCatalogo = @MontoAhorroCatalogo,
				MontoAhorroRevista = @MontoAhorroRevista
            WHERE CampaniaID = @CampaniaId AND PedidoID = @PedidoId;
        END
        ELSE
        BEGIN
            UPDATE PedidoWeb
            SET 
				EstadoPedido = @EstadoPedido,
				FechaModificacion = dbo.fnObtenerFechaHoraPais(),
				CodigoUsuarioModificacion = 'VALAUTOPROL',
				ValidacionAbierta = 0,
				MontoTotalProl = @MontoTotalProl,
				DescuentoProl = @DescuentoProl,
				MontoEscala = @MontoEscala,
				MontoAhorroCatalogo = @MontoAhorroCatalogo,
				MontoAhorroRevista = @MontoAhorroRevista
            WHERE CampaniaID = @CampaniaId AND PedidoID = @PedidoId;
        END
    END
    ELSE
    BEGIN
        IF @ItemsEliminados = 1
        BEGIN
            SELECT @ImporteTotal = ISNULL(SUM(ImporteTotal),0)
            FROM PedidoWebDetalle
            WHERE CampaniaID = @CampaniaId AND PedidoID = @PedidoId;

            SELECT @Clientes = COUNT(ClienteID)
            FROM PedidoWebDetalle
            WHERE CampaniaID = @CampaniaId AND PedidoID = @PedidoId AND ClienteID IS NOT NULL
            GROUP BY ClienteID;

            UPDATE PedidoWeb
            SET		
				EstadoPedido = @EstadoPedido,
				FechaModificacion = dbo.fnObtenerFechaHoraPais(),
				FechaReserva = dbo.fnObtenerFechaHoraPais(),
				CodigoUsuarioModificacion = 'VALAUTOPROL',
				ImporteTotal = @ImporteTotal,
				Clientes = @Clientes,
				ValidacionAbierta = 0,
				MontoTotalProl = @MontoTotalProl,
				DescuentoProl = @DescuentoProl,
				MontoEscala = @MontoEscala,
				MontoAhorroCatalogo = @MontoAhorroCatalogo,
				MontoAhorroRevista = @MontoAhorroRevista
            WHERE CampaniaID = @CampaniaId AND PedidoID = @PedidoId;
        END
        ELSE
        BEGIN
            UPDATE PedidoWeb
            SET 
				EstadoPedido = @EstadoPedido,
                FechaModificacion = dbo.fnObtenerFechaHoraPais(),
                FechaReserva = dbo.fnObtenerFechaHoraPais(),
                CodigoUsuarioModificacion = 'VALAUTOPROL',
                ValidacionAbierta = 0,
				MontoTotalProl = @MontoTotalProl,
				DescuentoProl = @DescuentoProl,
				MontoEscala = @MontoEscala,
				MontoAhorroCatalogo = @MontoAhorroCatalogo,
				MontoAhorroRevista = @MontoAhorroRevista
            WHERE CampaniaID = @CampaniaId AND PedidoID = @PedidoId;
        END
    END
END
GO