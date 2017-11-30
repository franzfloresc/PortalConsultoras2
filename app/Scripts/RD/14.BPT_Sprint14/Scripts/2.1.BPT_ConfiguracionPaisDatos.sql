
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
	values (@ConfiguracionPaisID, 1, 0, 'LogoComercialActiva', 'logotipo-club-ganamaplus-blanco.svg', 'logotipo-club-ganamaplus-blanco.svg', 'Logo comercial cuando el estado es activa que se asignara en todo sb2')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'LogoComercialNoActiva', 'logotipo-ganamaplus-blanco.svg', 'logotipo-ganamaplus-blanco.svg', 'Logo comercial cuando el estado es no activa que se asignara en todo sb2')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'LogoComercialFondoActiva', 'ClubGanaMasFondo.png', 'ClubGanaMasMobileFondo.png', 'Logo comercial cuando el estado es activa que se asignara en todo sb2')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'LogoComercialFondoNoActiva', 'GanaMasFondo.png', 'GanaMasMobileFondo.png', 'Logo comercial cuando el estado es no activa que se asignara en todo sb2')

	-- RD Textos desktop Bienvenida 
	BEGIN 
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DBienvenidaInscritaActiva', 
	'#Nombre ¡Bienvenida al tu nuevo espacio online de ofertas exclusivas!', 
	'Compra packs hechos a tu medida <br/>¡sin digitar códigos!', 
	'black', 'Textos de bienvenida para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DBienvenidaInscritaNoActiva', 
	'#Nombre, Disfruta de tu nuevo espacio online de ofertas exclusivas', 
	'En la siguiente campaña, compra packs hechos a tu medida <br/>¡sin digitar códigos!', 
	'black', 'Textos de bienvenida para un consultora Inscrita no activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DBienvenidaNoInscritaActiva', 
	'#Nombre, Suscríbete a tu nuevo espacio online de ofertas exclusivas', 
	'Disfruta de packs hechos a tu medida de tus productos favoritos.', 
	'black', 'Textos de bienvenida para un consultora No Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DBienvenidaNoInscritaNoActiva', 
	'#Nombre, Suscríbete a tu nuevo espacio online de ofertas exclusivas', 
	'Disfruta de packs hechos a tu medida de tus productos favoritos.', 
	'black', 'Textos de bienvenida para un consultora No Inscrita No activa')
	END 

	-- RD Textos mobile Bienvenida 
	BEGIN 
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MBienvenidaInscritaActiva', 
	'#Nombre, ¡Bienvenida al tu nuevo espacio online de ofertas exclusivas', 
	'Compra packs hechos a tu medida, ¡sin digitar códigos!', 
	'black', 'Textos de bienvenida mobile para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MBienvenidaInscritaNoActiva', 
	'#Nombre, Disfruta de tu nuevo espacio online de ofertas exclusivas', 
	'En la siguiente campaña, compra packs hechos a tu medida, ¡sin digitar códigos!', 
	'black', 'Textos de bienvenida mobile para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MBienvenidaNoInscritaActiva', 
	'#Nombre, Suscríbete a tu nuevo espacio online de ofertas exclusivas', 
	'Disfruta de packs hechos a tu medida de tus productos favoritos.', 
	'black', 'Textos de bienvenida mobile para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MBienvenidaNoInscritaNoActiva', 
	'#Nombre, Suscríbete a tu nuevo espacio online de ofertas exclusivas', 
	'Disfruta de packs hechos a tu medida de tus productos favoritos.', 
	'black', 'Textos de bienvenida mobile para un consultora Inscrita activa')
	END

	-- RD Textos desktop Pedido 
	BEGIN
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DPedidoInscritaActiva', 
	'Tu nuevo espacio online de ofertas exclusivas', 
	'#Nombre, entra y compra tus productos favoritos hechos a tu medida.', 
	'black', 'Textos de Pedido para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DPedidoInscritaNoActiva', 
	'Tu nuevo espacio online de ofertas exclusivas', 
	'#Nombre, en la siguiente campaña, pasa tu pedido ¡sin digitar códigos!', 
	'black', 'Textos de Pedido para un consultora Inscrita no activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DPedidoNoInscritaActiva', 
	'¡Suscríbete a tu nuevo espacio de ofertas exclusivas!', 
	'#Nombre, no te pierdas de los mejores packs hechos a tu medida.', 
	'black', 'Textos de Pedido para un consultora No Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DPedidoNoInscritaNoActiva', 
	'¡Suscríbete a tu nuevo espacio de ofertas exclusivas!', 
	'#Nombre, no te pierdas de los mejores packs hechos a tu medida.', 
	'black', 'Textos de Pedido para un consultora No Inscrita No activa')
	END

	-- RD Textos mobile Pedido (Completamente igual a Bienvenida mobile)
	BEGIN 
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MPedidoInscritaActiva', 
	'Tu nuevo espacio online de ofertas exclusivas', 
	'#Nombre, entra y compra tus productos favoritos hechos a tu medida.', 
	'black', 'Textos de Pedido mobile para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MPedidoInscritaNoActiva', 
	'Tu nuevo espacio online de ofertas exclusivas', 
	'#Nombre, en la siguiente campaña, pasa tu pedido ¡sin digitar códigos!', 
	'black', 'Textos de Pedido mobile para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MPedidoNoInscritaActiva', 
	'¡Suscríbete a tu nuevo espacio de ofertas exclusivas!', 
	'#Nombre, no te pierdas de los mejores packs hechos a tu medida.', 
	'black', 'Textos de Pedido mobile para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MPedidoNoInscritaNoActiva', 
	'¡Suscríbete a tu nuevo espacio de ofertas exclusivas!', 
	'#Nombre, no te pierdas de los mejores packs hechos a tu medida.', 
	'black', 'Textos de Pedido mobile para un consultora Inscrita activa')
	END

	-- RD Textos desktop Catálogo 
	BEGIN
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DCatalogoInscritaActiva', 
	'Tu nuevo espacio online de ofertas exclusivas', 
	'Disfruta de todos los beneficios que tenemos para ti.', 
	'black', 'Textos de Catálogo para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DCatalogoInscritaNoActiva', 
	'Tu nuevo espacio online de ofertas exclusivas', 
	'Desde la siguiente campaña, podrás disfrutar de todo los beneficios que tenemos para ti.', 
	'black', 'Textos de Catálogo para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DCatalogoNoInscritaActiva', 
	'Suscríbete a tu nuevo espacio de ofertas exclusivas', 
	'¡Ofertas exclusivas, sin digitar códigos!', 
	'black', 'Textos de Catálogo para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DCatalogoNoInscritaNoActiva', 
	'Suscríbete a tu nuevo espacio de ofertas exclusivas ', 
	'¡Ofertas exclusivas, sin digitar códigos!', 
	'black', 'Textos de Catálogo para un consultora Inscrita activa')
	END

	-- RD Textos mobile Catálogo 
	BEGIN
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MCatalogoInscritaActiva', 
	'Club Gana + Tu nuevo espacio  de ofertas exclusivas', 
	'Disfruta de todos los beneficios que tenemos para ti.', 
	'black', 'Textos de Catálogo mobile para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MCatalogoInscritaNoActiva', 
	'Club Gana + Tu nuevo espacio  de ofertas exclusivas', 
	'Desde la siguiente campaña, podrás disfrutar de todo los beneficios que tenemos para ti.', 
	'black', 'Textos de Catálogo mobile para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MCatalogoNoInscritaActiva', 
	'¡Suscríbete y disfruta de ofertas exclusivas para ti.', 
	'¡Ofertas exclusivas, sin digitar códigos!', 
	'black', 'Textos de Catálogo mobile para un consultora Inscrita activa')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MCatalogoNoInscritaNoActiva', 
	'¡Suscríbete y disfruta de ofertas exclusivas para ti.', 
	'¡Ofertas exclusivas, sin digitar códigos!', 
	'black', 'Textos de Catálogo mobile para un consultora Inscrita activa')
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

	-- RD Landing Informativo
	BEGIN
	
	--insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
	--	Valor1, Valor2, Valor3, Descripcion)
	--values (@ConfiguracionPaisID, 1, 0, 'DInformativoNuncaSuscritaNoInteresa', 
	--'SUSCRÍBETE AL CLUB GANA+: TU NUEVO ESPACIO ONLINE DE OFERTAS EXCLUSIVAS', 
	--'Disfruta de los beneficios que Club Gana+ tiene para ti y haz crecer tu negocio.', 
	--'', 'Desktop estado no me interesa y recien invitada')
	
	--insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
	--	Valor1, Valor2, Valor3, Descripcion)
	--values (@ConfiguracionPaisID, 1, 0, 'DInformativoSuscrita', 
	--'¿DESEAS CANCELAR TU SUSCRIPCIÓN AL CLUB GANA+?', 
	--'Al hacerlo, dejarás de disfrutar de los beneficios del Club Gana+ y volverás a recibir tu guía de negocio impresa a partir de la próxima campaña.', 
	--'Tienes hasta el cierre de esta campaña para cancelar tu suscripción y garantizar la recepción de tu guía de negocio impresa para la siguiente campaña.',
	--'Desktop no suscrita')
	
	--insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
	--	Valor1, Valor2, Valor3, Descripcion)
	--values (@ConfiguracionPaisID, 1, 0, 'DInformativoNoSuscrita', 
	--'HAS CANCELADO TU SUSCRIPCIÓN CON ÉXITO', 
	--'A partir de la próxima campaña, dejarás de disfrutar de los beneficios del Club Gana+ y volverás a recibir tu guía de negocio impresa en la próxima campaña.', 
	--'Puedes volver a suscribirte cuando quieras.',
	--'Desktop no suscrita')
		
	--insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
	--	Valor1, Valor2, Valor3, Descripcion)
	--values (@ConfiguracionPaisID, 1, 0, 'MInformativoNuncaSuscritaNoInteresa', 
	--'SUSCRÍBETE AL CLUB GANA+: TU NUEVO ESPACIO ONLINE DE OFERTAS EXCLUSIVAS', 
	--'Disfruta de los beneficios que Club Gana+ tiene para ti.', 
	--'', 'Mobile estado no me interesa y recien invitada')
	
	--insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
	--	Valor1, Valor2, Valor3, Descripcion)
	--values (@ConfiguracionPaisID, 1, 0, 'MInformativoSuscrita', 
	--'¿DESEAS CANCELAR TU SUSCRIPCIÓN?', 
	--'Al cancelar, dejarás de disfrutar de los beneficios del Club Gana+ y volverás a recibir tu guía de negocio impresa a partir de la próxima campaña.', 
	--'', 'Mobile no suscrita')
	
	--insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
	--	Valor1, Valor2, Valor3, Descripcion)
	--values (@ConfiguracionPaisID, 1, 0, 'MInformativoNoSuscrita', 
	--'HAS CANCELADO TU SUSCRIPCIÓN CON ÉXITO', 
	--'A partir de la próxima campaña, dejarás de disfrutar de los beneficios del Club Gana+ y volverás a recibir tu guía de negocio impresa en la próxima campaña. Puedes volver a suscribirte cuando quieras.', 
	--'', 'Mobile no suscrita')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
		Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'InformativoVideo', 
	'PvAWRQUKHqg', 'PvAWRQUKHqg', '', 'Video para la pagina informativa, valo2 es mobile')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
		Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'UrlTerminosCondiciones', 
	'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/FileConsultoras/PE/Terminos_y_condiciones_Esika_para_mi.pdf', '', '', 'Url Terminos Condiciones RD')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, 
		Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'UrlPreguntasFrecuentes', 
	'http://s3.amazonaws.com/consultorasPRD/SomosBelcorp/FileConsultoras/PE/Preguntas_Frecuentes_Esika_para_mi.pdf', '', '', 'Url Preguntas Frecuentes RD')

	END

END
GO

declare @ConfiguracionPaisID int = 0
select @ConfiguracionPaisID = ConfiguracionPaisID
from ConfiguracionPais
where Codigo = 'RDR'

BEGIN

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'LogoComercial', 'logotipo-ganamaplus-blanco.svg', 'logotipo-ganamaplus-blanco.svg', 'Logo comercial para reducidas que se asignara en todo sb2')
	
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'LogoComercialFondo', 'GanaMasFondo.png', 'GanaMasMobileFondo.png', 'Logo comercial para reducidas que se asignara en todo sb2')
		
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'LogoMenuOfertas', 'gif-ganamas.gif', 'gif-ganamas.gif', 'Gif para el menú de rd reducida')

	-- RDR Textos desktop
	BEGIN
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DBienvenidaRdr', 
	'¡Llegó Gana+! Tu nuevo espacio online de ofertas exclusivas', 
	'¡Packs a tu medida de tus productos favoritos!', 
	'black', 'Textos de Bienvenida para un consultora plan 20+')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DPedidoRdr', 
	'¡Llegó Gana+! Tu nuevo espacio online de ofertas exclusivas', 
	'Encuentra packs a tu medida y pasa pedido sin digitar códigos', 
	'black', 'Textos de Pedido para un consultora plan 20+')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'DCatalogoRdr', 
	'¡Llegó Gana+! Tu nuevo espacio online de ofertas exclusivas', 
	'Encuentra packs a tu medida y aumenta tus ganancias', 
	'black', 'Textos de Catálogo para un consultora plan 20+')
	END

	-- RDR Textos Mobile
	BEGIN
	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MBienvenidaRdr', 
	'Gana+: tu nuevo espacio online de ofertas exclusivas', 
	'¡Packs a tu medida de tus productos favoritos!', 
	'black', 'Textos de Bienvenida mobile para un consultora plan 20+')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MPedidoRdr', 
	'Gana+: tu nuevo espacio online de ofertas exclusivas', 
	'Encuentra packs a tu medida y pasa pedido sin digitar códigos', 
	'black', 'Textos de Pedido mobile para un consultora plan 20+')

	insert into ConfiguracionPaisDatos (ConfiguracionPaisID, Estado, CampaniaID, Codigo, Valor1, Valor2, Valor3, Descripcion)
	values (@ConfiguracionPaisID, 1, 0, 'MCatalogoRdr', 
	'Gana+: tu nuevo espacio online de ofertas exclusivas', 
	'Encuentra packs a tu medida y aumenta tus ganancias', 
	'black', 'Textos de Catálogo mobile para un consultora plan 20+')
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