USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'SUSCRÍBETE A TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = '¡SIN DIGITAR CÓDIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '', Valor2 = '' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS <b>¡GANAN HASTA 10% MÁS!</b>', Valor2 = '' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS', Valor2 = 'TUS OFERTAS EN UN<br/> SOLO LUGAR' where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'CONSULTORAS YA SUSCRITAS', Valor2 = '¡GANAN HASTA 10% MÁS!' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>', Valor2 = '' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

