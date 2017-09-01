GO
IF OBJECT_ID('InsPedidoFIC') IS NULL
	exec sp_executesql N'CREATE PROCEDURE InsPedidoFIC AS';
GO
ALTER PROCEDURE InsPedidoFIC
	@CampaniaID int,
	@ConsultoraID int,
	@PaisID int,
	@IPUsuario varchar(25) =null,
	@PedidoID int output,
	@CodigoUsuarioCreacion varchar(25) = null
AS
BEGIN
	SET @PedidoID = 0
	SELECT @PedidoID = PedidoID
	FROM dbo.PedidoFIC
	WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	IF(@PedidoID = 0)
	BEGIN
		DECLARE @FechaGeneral DATETIME

		SET @FechaGeneral = dbo.fnObtenerFechaHoraPais();
		SET @PedidoID = (select isnull(max(PedidoID),0) + 1 from PedidoFIC);
		--SET @PedidoID = (SELECT ISNULL(MAX(PedidoID),0) + 1 FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID);

		INSERT INTO dbo.PedidoFIC (CampaniaID, PedidoID, ConsultoraID, FechaRegistro, Clientes, ImporteTotal, ImporteCredito, 
								   EstadoPedido, ModificaPedidoReservado, PaisID, IPUsuario, CodigoUsuarioCreacion)
		VALUES (@CampaniaID, @PedidoID, @ConsultoraID, @FechaGeneral, 0, 0, 0, 201, 0, @PaisID, @IPUsuario, @CodigoUsuarioCreacion)
	END
END
GO