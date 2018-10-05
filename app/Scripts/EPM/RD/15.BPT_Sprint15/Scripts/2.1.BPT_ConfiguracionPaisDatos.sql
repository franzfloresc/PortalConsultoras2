USE BelcorpPeru
GO

go

declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo in ('BloquearPedidoRevistaImp', 'BloquearSugerenciaProducto');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearPedidoRevistaImp', 1, 
		'1 - Activa el bloqueo de revista impresa en pase pedido, 0 - Desactiva el bloqueo de la revista impresa en pase pedido')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearSugerenciaProducto', 1, 
		'1 - Activa el bloqueo de sugerencia de producto en pase pedido, 0 - Desactiva el bloqueo de sugerencia de producto en pase pedido')
end

go

USE BelcorpMexico
GO

go

declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo in ('BloquearPedidoRevistaImp', 'BloquearSugerenciaProducto');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearPedidoRevistaImp', 1, 
		'1 - Activa el bloqueo de revista impresa en pase pedido, 0 - Desactiva el bloqueo de la revista impresa en pase pedido')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearSugerenciaProducto', 1, 
		'1 - Activa el bloqueo de sugerencia de producto en pase pedido, 0 - Desactiva el bloqueo de sugerencia de producto en pase pedido')
end

go

USE BelcorpColombia
GO

go

declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo in ('BloquearPedidoRevistaImp', 'BloquearSugerenciaProducto');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearPedidoRevistaImp', 1, 
		'1 - Activa el bloqueo de revista impresa en pase pedido, 0 - Desactiva el bloqueo de la revista impresa en pase pedido')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearSugerenciaProducto', 1, 
		'1 - Activa el bloqueo de sugerencia de producto en pase pedido, 0 - Desactiva el bloqueo de sugerencia de producto en pase pedido')
end

go

USE BelcorpVenezuela
GO

go

declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo in ('BloquearPedidoRevistaImp', 'BloquearSugerenciaProducto');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearPedidoRevistaImp', 1, 
		'1 - Activa el bloqueo de revista impresa en pase pedido, 0 - Desactiva el bloqueo de la revista impresa en pase pedido')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearSugerenciaProducto', 1, 
		'1 - Activa el bloqueo de sugerencia de producto en pase pedido, 0 - Desactiva el bloqueo de sugerencia de producto en pase pedido')
end

go

USE BelcorpSalvador
GO

go

declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo in ('BloquearPedidoRevistaImp', 'BloquearSugerenciaProducto');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearPedidoRevistaImp', 1, 
		'1 - Activa el bloqueo de revista impresa en pase pedido, 0 - Desactiva el bloqueo de la revista impresa en pase pedido')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearSugerenciaProducto', 1, 
		'1 - Activa el bloqueo de sugerencia de producto en pase pedido, 0 - Desactiva el bloqueo de sugerencia de producto en pase pedido')
end

go

USE BelcorpPuertoRico
GO

go

declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo in ('BloquearPedidoRevistaImp', 'BloquearSugerenciaProducto');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearPedidoRevistaImp', 1, 
		'1 - Activa el bloqueo de revista impresa en pase pedido, 0 - Desactiva el bloqueo de la revista impresa en pase pedido')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearSugerenciaProducto', 1, 
		'1 - Activa el bloqueo de sugerencia de producto en pase pedido, 0 - Desactiva el bloqueo de sugerencia de producto en pase pedido')
end

go

USE BelcorpPanama
GO

go

declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo in ('BloquearPedidoRevistaImp', 'BloquearSugerenciaProducto');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearPedidoRevistaImp', 1, 
		'1 - Activa el bloqueo de revista impresa en pase pedido, 0 - Desactiva el bloqueo de la revista impresa en pase pedido')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearSugerenciaProducto', 1, 
		'1 - Activa el bloqueo de sugerencia de producto en pase pedido, 0 - Desactiva el bloqueo de sugerencia de producto en pase pedido')
end

go

USE BelcorpGuatemala
GO

go

declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo in ('BloquearPedidoRevistaImp', 'BloquearSugerenciaProducto');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearPedidoRevistaImp', 1, 
		'1 - Activa el bloqueo de revista impresa en pase pedido, 0 - Desactiva el bloqueo de la revista impresa en pase pedido')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearSugerenciaProducto', 1, 
		'1 - Activa el bloqueo de sugerencia de producto en pase pedido, 0 - Desactiva el bloqueo de sugerencia de producto en pase pedido')
end

go

USE BelcorpEcuador
GO

go

declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo in ('BloquearPedidoRevistaImp', 'BloquearSugerenciaProducto');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearPedidoRevistaImp', 1, 
		'1 - Activa el bloqueo de revista impresa en pase pedido, 0 - Desactiva el bloqueo de la revista impresa en pase pedido')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearSugerenciaProducto', 1, 
		'1 - Activa el bloqueo de sugerencia de producto en pase pedido, 0 - Desactiva el bloqueo de sugerencia de producto en pase pedido')
end

go

USE BelcorpDominicana
GO

go

declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo in ('BloquearPedidoRevistaImp', 'BloquearSugerenciaProducto');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearPedidoRevistaImp', 1, 
		'1 - Activa el bloqueo de revista impresa en pase pedido, 0 - Desactiva el bloqueo de la revista impresa en pase pedido')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearSugerenciaProducto', 1, 
		'1 - Activa el bloqueo de sugerencia de producto en pase pedido, 0 - Desactiva el bloqueo de sugerencia de producto en pase pedido')
end

go

USE BelcorpCostaRica
GO

go

declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo in ('BloquearPedidoRevistaImp', 'BloquearSugerenciaProducto');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearPedidoRevistaImp', 1, 
		'1 - Activa el bloqueo de revista impresa en pase pedido, 0 - Desactiva el bloqueo de la revista impresa en pase pedido')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearSugerenciaProducto', 1, 
		'1 - Activa el bloqueo de sugerencia de producto en pase pedido, 0 - Desactiva el bloqueo de sugerencia de producto en pase pedido')
end

go

USE BelcorpChile
GO

go

declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo in ('BloquearPedidoRevistaImp', 'BloquearSugerenciaProducto');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearPedidoRevistaImp', 1, 
		'1 - Activa el bloqueo de revista impresa en pase pedido, 0 - Desactiva el bloqueo de la revista impresa en pase pedido')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearSugerenciaProducto', 1, 
		'1 - Activa el bloqueo de sugerencia de producto en pase pedido, 0 - Desactiva el bloqueo de sugerencia de producto en pase pedido')
end

go

USE BelcorpBolivia
GO

go

declare @ConfiguracionPaisID int = 0

select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo in ('BloquearPedidoRevistaImp', 'BloquearSugerenciaProducto');

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearPedidoRevistaImp', 1, 
		'1 - Activa el bloqueo de revista impresa en pase pedido, 0 - Desactiva el bloqueo de la revista impresa en pase pedido')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 0, 0, 'BloquearSugerenciaProducto', 1, 
		'1 - Activa el bloqueo de sugerencia de producto en pase pedido, 0 - Desactiva el bloqueo de sugerencia de producto en pase pedido')
end

go

