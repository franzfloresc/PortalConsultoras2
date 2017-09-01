GO
IF OBJECT_ID('UpdPedidoFICTotales') IS NULL
	exec sp_executesql N'CREATE PROCEDURE UpdPedidoFICTotales AS';
GO
ALTER PROCEDURE UpdPedidoFICTotales
	@CampaniaID INT,
	@PedidoID INT,
	@Clientes SMALLINT,
	@ImporteTotal MONEY,
	@CodigoUsuarioModificacion varchar(25) = null
AS
BEGIN
	DECLARE @FechaGeneral DATETIME;
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais();
	
	UPDATE PedidoFIC
	SET 
		Clientes = @Clientes,
		ImporteTotal = @ImporteTotal,
		FechaModificacion = @FechaGeneral,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion
	WHERE
		CampaniaID = @CampaniaID
		AND
		PedidoID = @PedidoID;
END
GO