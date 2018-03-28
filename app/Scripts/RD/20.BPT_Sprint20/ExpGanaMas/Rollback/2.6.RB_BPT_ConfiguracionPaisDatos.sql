USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 ='#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.'  where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 ='#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.'  where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 ='#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.'  where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 ='#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.'  where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 ='#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.'  where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 ='#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.'  where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 ='#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.'  where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 ='#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.'  where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 ='#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.'  where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 ='#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.'  where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 ='#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.'  where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'DCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = '�SIN DIGITAR C�DIGOS!' where Codigo = 'DCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de los beneficios que el club tiene para ti.' where Codigo = 'MCatalogoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MCatalogoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'TU NUEVO ESPACIO DE OFERTAS EXCLUSIVAS', Valor2 = 'DISFRUTA DE LOS BENEFICIOS QUE EL CLUB TIENE PARA TI.' where Codigo = 'MCatalogoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Bienvenida a tu nuevo espacio de ofertas exclusivas!', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'DBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Suscr�bete a tu nuevo espacio online de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'DBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, �Bienvenida al tu nuevo espacio de ofertas exclusivas', Valor2 = 'Compra packs hechos a tu medida �sin digitar c�digos!' where Codigo = 'MBienvenidaInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MBienvenidaNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 ='#Nombre, Suscr�bete a tu nuevo espacio de ofertas exclusivas', Valor2 = 'Disfruta de packs hechos a tu medida de tus productos favoritos.' where Codigo = 'MBienvenidaNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'DPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'DPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'DPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.'  where Codigo = 'DPedidoNoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = 'Tu nuevo espacio online de ofertas exclusivas.', Valor2 = '#Nombre, entra y compra tus productos favoritos hechos a tu medida.' where Codigo = 'MPedidoInscritaNoActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaActiva'

IF EXISTS (SELECT 1 FROM ConfiguracionPaisDatos where Codigo = 'MPedidoNoInscritaNoActiva')
update ConfiguracionPaisDatos set Valor1 = '�Suscr�bete a tu nuevo espacio de ofertas exclusivas!', Valor2 = '#Nombre, no te pierdas de packs hechos a tu medida.' where Codigo = 'MPedidoNoInscritaNoActiva'

GO

