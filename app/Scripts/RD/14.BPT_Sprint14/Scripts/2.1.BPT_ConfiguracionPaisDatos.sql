
declare @declare int = 0
select @declare = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @declare > 0
begin 
	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @declare

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@declare, 1, 0, 'BloquearDiasAntesFacturar', 1, 'Número de dias a bloquear antes de facturar, día 0 es el mismo día de facturación')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@declare, 1, 0, 'CantidadCampaniaEfectiva', 1, 'Número de campañas a tomar efectiva la accion de suscribirse o desuscribirse') 
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@declare, 1, 0, 'NombreComercialActiva', 'Club Gana +', 'Nombre comercial cuando el estado es activa que se asignara en todo sb2') 
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@declare, 1, 0, 'NombreComercialNoActiva', 'Gana +', 'Nombre comercial cuando el estado es no activa que se asignara en todo sb2')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@declare, 1, 0, 'LogoComercialActiva', 'ClubGanaMas.jpg', 'Logo comercial cuando el estado es activa que se asignara en todo sb2')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@declare, 1, 0, 'LogoComercialNoActiva', 'GanaMas.jpg', 'Logo comercial cuando el estado es no activa que se asignara en todo sb2')

end
