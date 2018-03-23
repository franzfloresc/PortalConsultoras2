
declare @setID  int = 1;

DELETE 
FROM
PedidoWebSetDetalle
WHERE SetId =@SetId

DELETE 
FROM PedidoWebSet
WHERE SetId = @setID

