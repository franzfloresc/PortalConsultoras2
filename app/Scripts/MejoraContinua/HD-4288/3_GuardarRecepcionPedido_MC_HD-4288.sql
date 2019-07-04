
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GuardarRecepcionPedido]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GuardarRecepcionPedido]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : DESHACE TODOS LOS CAMBIOS RELAIZADOS 
GuardarRecepcionPedido 'E','E', 9521388
*/ 

CREATE PROCEDURE GuardarRecepcionPedido
@NombreYApellido varchar(512),
@NumeroDocumento varchar(512), 
@PedidoID  int	
AS
BEGIN

  UPDATE pedidoweb SET NombresRecepcionPedido=@NombreYApellido, DNIRecepcionPedido=@NumeroDocumento, IndicadorRecepcion=1
  WHERE PEDIDOID=@PedidoID 
END



