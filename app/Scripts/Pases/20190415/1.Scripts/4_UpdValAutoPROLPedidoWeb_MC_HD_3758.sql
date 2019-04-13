use BelcorpBolivia
go
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
    declare @ImporteTotal money
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
go

use BelcorpChile
go
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
    declare @ImporteTotal money
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
go

use BelcorpColombia
go
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
   declare @ImporteTotal money
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
go

use BelcorpCostaRica
go
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
    declare @ImporteTotal money
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
go

use BelcorpDominicana
go
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
    declare @ImporteTotal money
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
go

use BelcorpEcuador
go
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
     declare @ImporteTotal money
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
go

use BelcorpGuatemala
go
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
    declare @ImporteTotal money
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
go

use BelcorpMexico
go
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
    declare @ImporteTotal money
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
go

use BelcorpPanama
go
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
    declare @ImporteTotal money
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
go

use BelcorpPeru
go
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
   declare @ImporteTotal money
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
go

use BelcorpPuertoRico
go
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
   declare @ImporteTotal money
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
go

use BelcorpSalvador
go
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
   declare @ImporteTotal money
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
go