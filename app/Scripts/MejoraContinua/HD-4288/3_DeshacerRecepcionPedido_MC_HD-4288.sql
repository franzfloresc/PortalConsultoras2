IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[DeshacerRecepcionPedido]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[DeshacerRecepcionPedido]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS 
DeshacerRecepcionPedido 
*/ 

CREATE PROCEDURE DeshacerRecepcionPedido
@PedidoID  int
AS
BEGIN

UPDATE PEDIDOWEB SET IndicadorRecepcion=0, NombresRecepcionPedido=NULL, DNIRecepcionPedido=NULL
WHERE PEDIDOID=@PedidoID
END

