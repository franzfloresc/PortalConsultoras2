
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
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'LogoComercialActiva', 'ClubGanaMas.jpg', 'ClubGanaMasMobile.jpg', 'Logo comercial cuando el estado es activa que se asignara en todo sb2')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'LogoComercialNoActiva', 'GanaMas.jpg', 'GanaMasMobile.jpg', 'Logo comercial cuando el estado es no activa que se asignara en todo sb2')

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

	-- RD Popup Producto Bloqueado
	BEGIN
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
		Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DPopupBloqueadoNoActivaNoSuscrita', 
	'Disfruta de esta y más ofertas suscribiéndote a Gana+', 
	'', '', 'Desktop Popup producto Bloqueado No Activa y No Suscrita')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
		Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DPopupBloqueadoNoActivaSuscrita', 
	'A partir de la próxima campaña podrás disfrutar de esta y más ofertas.', 
	'', '', 'Desktop Popup producto Bloqueado No Activa y Suscrita')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
		Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MPopupBloqueadoNoActivaNoSuscrita', 
	'Disfruta de esta y más ofertas suscribiéndote a Gana+',
	'', '', 'Mobile Popup producto Bloqueado No Activa y No Suscrita')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
		Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MPopupBloqueadoNoActivaSuscrita', 
	'A partir de la próxima campaña podrás disfrutar de esta y más ofertas.', 
	'', '', 'Mobile Popup producto Bloqueado No Activa y Suscrita')

	END

	-- RD Perdiste
	BEGIN
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
		Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DPerdiste', 
	'#Nombre ¡No te lo vuelvas a perder!', 
	'Con Gana+ tendrás ofertas exclusivas y más beneficios.', 
	'', 'Desktop perdiste ofertas')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
		Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MPerdiste', 
	'#Nombre ¡No te lo vuelvas a perder!', 
	'Con Gana+ tendrás ofertas exclusivas y más beneficios.', 
	'', 'Mobile perdiste ofertas')
	END

	
	-- RD Banner Landing Comprar y Revisar
	BEGIN
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
		Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DLandingBannerNoActivaNoSuscrita', 
	'#Nombre Bienvenida a Gana+ tu nuevo espacio online de ofertas exclusivas', 
	'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!', 
	'', 'Desktop Banner Landing Productos Comprar y Revisar, No Activas y No Suscritas')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
		Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DLandingBannerNoActivaSuscrita', 
	'#Nombre ya estás suscrita a Gana+', 
	'Ingresa a Gana+ y a partir de la próxima campaña descubre ofertas ¡que te harán ganar más!', 
	'', 'Desktop Banner Landing Productos Comprar y Revisar, No Activas y Suscritas')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
		Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DLandingBannerActivaNoSuscrita', 
	'#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!', 
	'', 'Desktop Banner Landing Productos Comprar y Revisar, Activas y No Suscritas')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
		Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DLandingBannerActivaSuscrita', 
	'#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	'Encuentra packs únicos, pasa tu pedido sin digitar códigos ¡y mucho más!', 
	'', 'Desktop Banner Landing Productos Comprar y Revisar, Activas y Suscritas')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
		Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MLandingBannerNoActivaNoSuscrita', 
	'#Nombre Bienvenida a Gana+ tu nuevo espacio online de ofertas exclusivas', 
	'', 
	'', 'Mobile Banner Landing Productos Comprar y Revisar, No Activas y No Suscritas')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
		Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MLandingBannerNoActivaSuscrita', 
	'#Nombre ya estás suscrita a Gana+', 
	'', 
	'', 'Mobile Banner Landing Productos Comprar y Revisar, No Activas y Suscritas')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
		Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MLandingBannerActivaNoSuscrita', 
	'#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	'', 
	'', 'Mobile Banner Landing Productos Comprar y Revisar, Activas y No Suscritas')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
		Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MLandingBannerActivaSuscrita', 
	'#Nombre llegó Gana+: tu nuevo espacio de ofertas exclusivas',
	'', 
	'', 'Mobile Banner Landing Productos Comprar y Revisar, Activas y Suscritas')

	END

END
GO

declare @ConfiguracionPaisID int = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RDR'

BEGIN

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID

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

	-- RDR Banner Landing Productos
	BEGIN
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DRDRLandingBanner', 
	'#NOMBRE DESCUBRE CLUB GANA+ TU NUEVO ESPACIO ONLINE DE OFERTAS EXCLUSIVAS.', 
	'DISFRUTA DE PACKS HECHOS A TU MEDIDA CON TUS PRODUCTOS FAVORITOS, ¡ESOS QUE TÚ Y TUS CLIENTES PREFIEREN!', 
	'', 'Desktop Banner Landing Productos')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MRDRLandingBanner', 
	'#NOMBRE DESCUBRE CLUB GANA+ TU NUEVO ESPACIO ONLINE DE OFERTAS EXCLUSIVAS.', 
	'', 
	'', 'Mobile Banner Landing Productos')
	END
end