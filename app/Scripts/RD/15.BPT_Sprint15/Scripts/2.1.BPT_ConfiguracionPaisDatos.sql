declare @ConfiguracionPaisID int = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	if exists (select 1 from ConfiguracionPaisDatos where Codigo = 'BloquearPedidoRevistaImp')
	delete from ConfiguracionPaisDatos where Codigo = 'BloquearPedidoRevistaImp';

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'BloquearPedidoRevistaImp', 1, '1 - Activa el bloqueo de revista impresa en pase pedido, 0 - Desactiva el bloqueo de la revista impresa en pase pedido')

	if exists (select 1 from ConfiguracionPaisDatos where Codigo = 'BloquearSugerenciaProducto')
	delete from ConfiguracionPaisDatos where Codigo = 'BloquearSugerenciaProducto';

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'BloquearSugerenciaProducto', 1, '1 - Activa el bloqueo de sugerencia de producto en pase pedido, 0 - Desactiva el bloqueo de sugerencia de producto en pase pedido')
end