
declare @ConfiguracionPaisID int = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RD'

if @ConfiguracionPaisID > 0
begin 
	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'BloquearDiasAntesFacturar', 1, 'Número de dias a bloquear antes de facturar, día 0 es el mismo día de facturación')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'CantidadCampaniaEfectiva', 1, 'Número de campañas a tomar efectiva la accion de suscribirse o desuscribirse') 
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'NombreComercialActiva', 'Club Gana +', 'Nombre comercial cuando el estado es activa que se asignara en todo sb2') 
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'NombreComercialNoActiva', 'Gana +', 'Nombre comercial cuando el estado es no activa que se asignara en todo sb2')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'LogoComercialActiva', 'ClubGanaMas.jpg', 'Logo comercial cuando el estado es activa que se asignara en todo sb2')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'LogoComercialNoActiva', 'GanaMas.jpg', 'Logo comercial cuando el estado es no activa que se asignara en todo sb2')

	-- Datos desktop Bienvenida 
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DBienvenidaInscritaActiva', 
	'#Nombre, LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'AHORA PUEDES COMPRAR TODAS TUS OFERTAS <br/>DE CAMPAÑA #Cx Y VER LAS DE CAMPAÑA #Cx1', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DBienvenidaInscritaNoActiva', '
	#Nombre, LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'ESTÁS INSCRITA EN ÉSIKA PARA MÍ, AHORA PUEDES PEDIR TUS OFERTAS DE CAMPAÑA #Cx Y VER LAS DE CAMPAÑA #Cx1', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DBienvenidaNoInscritaActiva', 
	'#Nombre, LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'AHORA PUEDES COMPRAR TODAS TUS OFERTAS <br/>DE CAMPAÑA #Cx Y VER LAS DE CAMPAÑA #Cx1', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DBienvenidaNoInscritaNoActiva', 
	'#Nombre, LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'ENTRA Y CONOCE TODO LO QUE TIENE PARA TI. <br /> HASTA 65% DE DESCUENTO EN OFERTAS EXCLUSIVAS.', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	-- Datos mobile Bienvenida 
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MBienvenidaInscritaActiva', 
	'#Nombre, LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'AHORA PUEDES COMPRAR TODAS TUS OFERTAS <br/>DE CAMPAÑA #Cx Y VER LAS DE CAMPAÑA #Cx1', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MBienvenidaInscritaNoActiva', 
	'LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'#Nombre, YA PUEDES VER TODAS TUS <b>OFERTAS PERSONALIZADAS DE LA #Cx1', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MBienvenidaNoInscritaActiva', 
	'#Nombre, LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'AHORA PUEDES COMPRAR TODAS TUS OFERTAS <br/>DE CAMPAÑA #Cx Y VER LAS DE CAMPAÑA #Cx1', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MBienvenidaNoInscritaNoActiva', 
	'TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'#Nombre, ¿YA VISTE TUS <b>OFERTAS PERSONALIZADAS DE CAMPAÑA #Cx</b>?', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')


end
