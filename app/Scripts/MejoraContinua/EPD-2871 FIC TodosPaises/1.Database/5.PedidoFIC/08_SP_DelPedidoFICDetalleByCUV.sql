GO
IF OBJECT_ID('DelPedidoFICDetalleByCUV') IS NULL
	exec sp_executesql N'CREATE PROCEDURE DelPedidoFICDetalleByCUV AS';
GO
ALTER PROCEDURE DelPedidoFICDetalleByCUV
	@CampaniaID INT,
	@PedidoID INT,
	@CUV VARCHAR(20),
	@Deleted SMALLINT OUTPUT  
AS
BEGIN TRY 
	UPDATE pw
	SET
		pw.Clientes = pw.Clientes - ISNULL(pwd.ClienteID,0),
		pw.ImporteTotal = pw.ImporteTotal - pwd.ImporteTotal,
		pw.FechaModificacion = getdate()
	FROM dbo.PedidoFIC pw
	INNER JOIN dbo.PedidoFICDetalle pwd ON pw.CampaniaID = pwd.CampaniaID AND pw.PedidoID = pwd.PedidoID	
	WHERE pwd.CUV = @CUV;

	DELETE FROM dbo.PedidoFICDetalle
	WHERE
		CampaniaID = @CampaniaID AND
		PedidoID = @PedidoID AND
		CUV = @CUV;

	SET	@Deleted = 1;  
END TRY  
BEGIN CATCH  
	SET @Deleted = 0;  
END CATCH  
GO