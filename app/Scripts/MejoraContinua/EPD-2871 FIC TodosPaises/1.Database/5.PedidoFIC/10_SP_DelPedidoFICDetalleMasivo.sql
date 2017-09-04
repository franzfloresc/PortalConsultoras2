GO
IF OBJECT_ID('DelPedidoFICDetalleMasivo') IS NULL
	exec sp_executesql N'CREATE PROCEDURE DelPedidoFICDetalleMasivo AS';
GO
ALTER PROCEDURE DelPedidoFICDetalleMasivo
 @CampaniaID INT,  
 @PedidoID INT
AS
BEGIN	
	delete from PedidoFICDetalle
	where CampaniaID = @CampaniaID and PedidoID = @PedidoID;
END
GO