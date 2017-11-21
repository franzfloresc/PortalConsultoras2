
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

	-- RD Textos desktop Bienvenida 
	BEGIN 
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DBienvenidaInscritaActiva', 
	'#Nombre, LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'AHORA PUEDES COMPRAR TODAS TUS OFERTAS <br/>DE CAMPAÑA #Cx Y VER LAS DE CAMPAÑA #Cx1', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DBienvenidaInscritaNoActiva', 
	'#Nombre, LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'ESTÁS INSCRITA EN ÉSIKA PARA MÍ, AHORA PUEDES PEDIR TUS OFERTAS DE CAMPAÑA #Cx Y VER LAS DE CAMPAÑA #Cx1', 
	'black', 'Textos de bienvenida para un consultora Inscrita no activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DBienvenidaNoInscritaActiva', 
	'#Nombre, LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'AHORA PUEDES COMPRAR TODAS TUS OFERTAS <br/>DE CAMPAÑA #Cx Y VER LAS DE CAMPAÑA #Cx1', 
	'black', 'Textos de bienvenida para un consultora No Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DBienvenidaNoInscritaNoActiva', 
	'#Nombre, LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'ENTRA Y CONOCE TODO LO QUE TIENE PARA TI. <br /> HASTA 65% DE DESCUENTO EN OFERTAS EXCLUSIVAS.', 
	'black', 'Textos de bienvenida para un consultora No Inscrita No activa')
	END 

	-- RD Textos mobile Bienvenida 
	BEGIN 
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
	END

	-- RD Textos desktop Pedido 
	BEGIN
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DPedidoInscritaActiva', 
	'TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'#Nombre, ¿YA VISTE TUS <b>OFERTAS PERSONALIZADAS DE CAMPAÑA #Cx</b>?', 
	'black', 'Textos de Pedido para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DPedidoInscritaNoActiva', 
	'TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'#Nombre, ¿YA VISTE TUS <b>OFERTAS PERSONALIZADAS DE CAMPAÑA #Cx1</b>?', 
	'black', 'Textos de Pedido para un consultora Inscrita no activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DPedidoNoInscritaActiva', 
	'TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'#Nombre, ¿YA VISTE TUS <b>OFERTAS PERSONALIZADAS DE CAMPAÑA #Cx</b>?', 
	'black', 'Textos de Pedido para un consultora No Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DPedidoNoInscritaNoActiva', 
	'TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'#Nombre, CONOCE LAS OFERTAS CON HASTA 65% DE DESCUENTO', 
	'black', 'Textos de Pedido para un consultora No Inscrita No activa')
	END

	-- RD Textos mobile Pedido (Completamente igual a Bienvenida mobile)
	BEGIN 
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MPedidoInscritaActiva', 
	'#Nombre, LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'AHORA PUEDES COMPRAR TODAS TUS OFERTAS <br/>DE CAMPAÑA #Cx Y VER LAS DE CAMPAÑA #Cx1', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MPedidoInscritaNoActiva', 
	'LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'#Nombre, YA PUEDES VER TODAS TUS <b>OFERTAS PERSONALIZADAS DE LA #Cx1', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MPedidoNoInscritaActiva', 
	'#Nombre, LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'AHORA PUEDES COMPRAR TODAS TUS OFERTAS <br/>DE CAMPAÑA #Cx Y VER LAS DE CAMPAÑA #Cx1', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MPedidoNoInscritaNoActiva', 
	'TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'#Nombre, ¿YA VISTE TUS <b>OFERTAS PERSONALIZADAS DE CAMPAÑA #Cx</b>?', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')
	END

	-- RD Textos desktop Catálogo 
	BEGIN
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DCatalogoInscritaActiva', 
	'#Nombre, LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'¿YA VISTE TUS OFERTAS DE LA C-#Cx EN ÉSIKA PARA MÍ? ', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DCatalogoInscritaNoActiva', 
	'#Nombre, YA LLEGÓ TU NUEVA REVISTA ONLINE', 
	'¿YA VISTE TUS <b>OFERTAS EN ÉSIKA PARA MÍ</b>?', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DCatalogoNoInscritaActiva', 
	'#Nombre, LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'¿YA VISTE TUS OFERTAS DE LA C-#Cx EN ÉSIKA PARA MÍ? ', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DCatalogoNoInscritaNoActiva', 
	'#Nombre, YA LLEGÓ TU NUEVA REVISTA ONLINE', 
	'¿YA VISTE TUS <b>OFERTAS EN ÉSIKA PARA MÍ</b>?', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')
	END

	-- RD Textos mobile Catálogo 
	BEGIN
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MCatalogoInscritaActiva', 
	'TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'#Nombre, ¿YA VISTE TUS <b>OFERTAS DE LA C-#Cx EN ÉSIKA PARA MÍ?</b>', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MCatalogoInscritaNoActiva', 
	'TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'#Nombre, ¿YA VISTE TUS <b>OFERTAS EN ÉSIKA PARA MÍ?</b>', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MCatalogoNoInscritaActiva', 
	'TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'#Nombre, ¿YA VISTE TUS <b>OFERTAS DE LA C-#Cx EN ÉSIKA PARA MÍ?</b>', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MCatalogoNoInscritaNoActiva', 
	'TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'#Nombre, ¿YA VISTE TUS <b>OFERTAS DE LA C-#Cx EN ÉSIKA PARA MÍ?</b>', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')
	END
END
GO

declare @ConfiguracionPaisID int = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RDR'

BEGIN
	-- RDR Textos desktop
	BEGIN
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DBienvenidaRdr', 
	'TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'ENCUENTRA MÁS OFERTAS, MÁS BONIFICACIONES Y LANZAMIENTOS DE LAS 3 MARCAS Y AUMENTA TUS GANANCIAS', 
	'black', 'Textos de Bienvenida ara un consultora plan 20+')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DPedidoRdr', 
	'TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'ENCUENTRA LOS PRODUCTOS QUE TUS CLIENTES BUSCAN HASTA 65% DE DSCTO.', 
	'black', 'Textos de Pedido ara un consultora plan 20+')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DCatalogoRdr', 
	'TU REVISTA ONLINE PERSONALIZADA', 
	'Conoce ahora tus ofertas y aumenta tus ganancias', 
	'black', 'Textos de Catálogo ara un consultora plan 20+')
	END

	-- RDR Textos Mobile
	BEGIN
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MBienvenidaRdr', 
	'TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'#Nombre, ¿YA VISTE TUS OFERTAS PERSONALIZADAS DE CAMPAÑA #Cx?', 
	'black', 'Textos de Bienvenida para un consultora plan 20+')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MPedidoRdr', 
	'TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'#Nombre, ¿YA VISTE TUS OFERTAS PERSONALIZADAS DE CAMPAÑA #Cx?', 
	'black', 'Textos de Pedido para un consultora plan 20+')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MCatalogoRdr', 
	'TU NUEVA REVISTA ONLINE PERSONALIZADA', 
	'Conoce ahora tus ofertas y aumenta tus ganancias', 
	'black', 'Textos de Ctalogo para un consultora plan 20+')
	END
end