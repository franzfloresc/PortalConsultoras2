
go

declare @ConfiguracionPaisID int,
@CodigoDato varchar(100) = 'BloqueoProductoDigital'

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, @CodigoDato, 1, 
		'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva')

end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RDR'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, @CodigoDato, 1, 
		'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva')

end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'ODD'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, @CodigoDato, 1, 
		'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva')

end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'GND'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, @CodigoDato, 1, 
		'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva')

end

set @ConfiguracionPaisID = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'OPT'

if @ConfiguracionPaisID > 0
begin 

	delete from ConfiguracionPaisDatos where Codigo = @CodigoDato and ConfiguracionPaisID = @ConfiguracionPaisID

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, @CodigoDato, 1, 
		'Bloquear productos expuestos por el portal en pase pedido, 1 - Activa,  0 - Desactiva')

end

go
