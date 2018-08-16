USE [BelcorpPeru_BPT]
GO

update [dbo].[ConfiguracionPaisDatos] set valor1 = '#NOMBRE, encuentra aquí las promociones de campaña' where Codigo IN
('DBienvenidaNoInscritaActiva','DBienvenidaNoInscritaNoActiva','MBienvenidaNoInscritaActiva',
'MBienvenidaNoInscritaNoActiva','MPedidoNoInscritaActiva','MPedidoNoInscritaNoActiva')

update [dbo].[ConfiguracionPaisDatos] set valor1 = 'APROVECHA OFERTAS HECHAS A TU MEDIDA' where Codigo IN
('DLandingBannerNoActivaNoSuscrita','DLandingBannerActivaNoSuscrita',
'MLandingBannerNoActivaNoSuscrita','MLandingBannerActivaNoSuscrita')

update [dbo].[ConfiguracionPais] 
set DesktopTituloBanner = 'DISFRUTA DE TU GUÍA DE NEGOCIO ONLINE',
MobileTituloBanner = 'DISFRUTA DE TU GUÍA DE NEGOCIO ONLINE'
where Codigo = 'GND'

UPDATE ConfiguracionOfertasHome SET DesktopTitulo = 'OFERTAS PARA TI', MobileTitulo='OFERTAS PARA TI'
FROM ConfiguracionOfertasHome h JOIN ConfiguracionPais p on h.ConfiguracionPaisID = p.ConfiguracionPaisID
and p.Codigo = 'OPT'

update ConfiguracionPaisDatos set Valor1='#NOMBRE, encuentra aquí las', valor2 = 'promociones de campaña' where Codigo = 'DPedidoNoInscritaActiva'
update ConfiguracionPaisDatos set Valor1='#NOMBRE, encuentra aquí las', valor2 = 'promociones de campaña' where Codigo = 'DPedidoNoInscritaNoActiva'

update ConfiguracionPaisDatos set Valor2 = 'oferta_digital_logo_normal.png' where Codigo = 'LogoMenuInicioNoActiva'

update [dbo].[ConfiguracionPaisDatos] set valor1 = 'gifofertasdigitales.gif' where Codigo = 'LogoMenuOfertasNoActiva'


USE [BelcorpChile_BPT]
GO

update [dbo].[ConfiguracionPaisDatos] set valor1 = '#NOMBRE, encuentra aquí las promociones de campaña' where Codigo IN
('DBienvenidaNoInscritaActiva','DBienvenidaNoInscritaNoActiva','MBienvenidaNoInscritaActiva',
'MBienvenidaNoInscritaNoActiva','MPedidoNoInscritaActiva','MPedidoNoInscritaNoActiva')

update [dbo].[ConfiguracionPaisDatos] set valor1 = 'APROVECHA OFERTAS HECHAS A TU MEDIDA' where Codigo IN
('DLandingBannerNoActivaNoSuscrita','DLandingBannerActivaNoSuscrita',
'MLandingBannerNoActivaNoSuscrita','MLandingBannerActivaNoSuscrita')

update [dbo].[ConfiguracionPais] 
set DesktopTituloBanner = 'DISFRUTA DE TU GUÍA DE NEGOCIO ONLINE',
MobileTituloBanner = 'DISFRUTA DE TU GUÍA DE NEGOCIO ONLINE'
where Codigo = 'GND'

UPDATE ConfiguracionOfertasHome SET DesktopTitulo = 'OFERTAS PARA TI', MobileTitulo='OFERTAS PARA TI'
FROM ConfiguracionOfertasHome h JOIN ConfiguracionPais p on h.ConfiguracionPaisID = p.ConfiguracionPaisID
and p.Codigo = 'OPT'

update ConfiguracionPaisDatos set Valor1='#NOMBRE, encuentra aquí las', valor2 = 'promociones de campaña' where Codigo = 'DPedidoNoInscritaActiva'
update ConfiguracionPaisDatos set Valor1='#NOMBRE, encuentra aquí las', valor2 = 'promociones de campaña' where Codigo = 'DPedidoNoInscritaNoActiva'

update ConfiguracionPaisDatos set Valor2 = 'oferta_digital_logo_normal.png' where Codigo = 'LogoMenuInicioNoActiva'

update [dbo].[ConfiguracionPaisDatos] set valor1 = 'gifofertasdigitales.gif' where Codigo = 'LogoMenuOfertasNoActiva'


USE [BelcorpCostaRica_BPT]
GO

update [dbo].[ConfiguracionPaisDatos] set valor1 = '#NOMBRE, encuentra aquí las promociones de campaña' where Codigo IN
('DBienvenidaNoInscritaActiva','DBienvenidaNoInscritaNoActiva','MBienvenidaNoInscritaActiva',
'MBienvenidaNoInscritaNoActiva','MPedidoNoInscritaActiva','MPedidoNoInscritaNoActiva')

update [dbo].[ConfiguracionPaisDatos] set valor1 = 'APROVECHA OFERTAS HECHAS A TU MEDIDA' where Codigo IN
('DLandingBannerNoActivaNoSuscrita','DLandingBannerActivaNoSuscrita',
'MLandingBannerNoActivaNoSuscrita','MLandingBannerActivaNoSuscrita')

update [dbo].[ConfiguracionPais] 
set DesktopTituloBanner = 'DISFRUTA DE TU GUÍA DE NEGOCIO ONLINE',
MobileTituloBanner = 'DISFRUTA DE TU GUÍA DE NEGOCIO ONLINE'
where Codigo = 'GND'

UPDATE ConfiguracionOfertasHome SET DesktopTitulo = 'OFERTAS PARA TI', MobileTitulo='OFERTAS PARA TI'
FROM ConfiguracionOfertasHome h JOIN ConfiguracionPais p on h.ConfiguracionPaisID = p.ConfiguracionPaisID
and p.Codigo = 'OPT'

update ConfiguracionPaisDatos set Valor1='#NOMBRE, encuentra aquí las', valor2 = 'promociones de campaña' where Codigo = 'DPedidoNoInscritaActiva'
update ConfiguracionPaisDatos set Valor1='#NOMBRE, encuentra aquí las', valor2 = 'promociones de campaña' where Codigo = 'DPedidoNoInscritaNoActiva'

update ConfiguracionPaisDatos set Valor2 = 'oferta_digital_logo_normal.png' where Codigo = 'LogoMenuInicioNoActiva'

update [dbo].[ConfiguracionPaisDatos] set valor1 = 'gifofertasdigitales.gif' where Codigo = 'LogoMenuOfertasNoActiva'

