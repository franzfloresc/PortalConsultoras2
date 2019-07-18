
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[VerificarConsultoraDigital]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[VerificarConsultoraDigital]
GO

/*   
CREADO POR  : PAQUIRRI SEPERAK   
FECHA : 04/06/2019   
DESCRIPCIÓN : RETORNA INFORMACIÓN DE LA PERSONA QUE RECEPCIONARÁ EL PEDIDO 
VerificarConsultoraDigital '023499290', 9521388
*/ 
CREATE PROCEDURE VerificarConsultoraDigital
@CodigoConsultora   VARCHAR(64),
@PedidoID  int
AS
BEGIN

DECLARE @IndicadorConsultoraDigital INT

 IF((SELECT COUNT(1) FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID) > 0) BEGIN

	 SELECT IndicadorRecepcion, NombresRecepcionPedido,DNIRecepcionPedido,IndicadorConsultoraDigital  FROM ODS.CONSULTORA C
     INNER JOIN  PEDIDOWEB P ON C.CONSULTORAID=P.CONSULTORAID
	 WHERE C.CODIGO=@CodigoConsultora AND P.PEDIDOID=@PedidoID

END
else
begin

UPDATE PEDIDOWEB SET IndicadorRecepcion=0, NombresRecepcionPedido=NULL, DNIRecepcionPedido=NULL
WHERE PEDIDOID=@PedidoID
SELECT @IndicadorConsultoraDigital=IndicadorConsultoraDigital FROM ODS.CONSULTORA WHERE CODIGO=@CodigoConsultora
SELECT NULL, NULL, NULL, @IndicadorConsultoraDigital IndicadorConsultoraDigital
end
END

