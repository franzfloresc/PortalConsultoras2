USE [BelcorpPeru_BPT]
GO

update [dbo].[ConfiguracionPaisDatos] set valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>' where Codigo IN
('DBienvenidaNoInscritaActiva','DBienvenidaNoInscritaNoActiva','MBienvenidaNoInscritaActiva',
'MBienvenidaNoInscritaNoActiva','MPedidoNoInscritaActiva','MPedidoNoInscritaNoActiva')

update [dbo].[ConfiguracionPaisDatos] set valor1 = 'APROVECHA OFERTAS HECHAS A TU MEDIDA EN' where Codigo IN
('DLandingBannerNoActivaNoSuscrita','DLandingBannerActivaNoSuscrita',
'MLandingBannerNoActivaNoSuscrita','MLandingBannerActivaNoSuscrita')

update [dbo].[ConfiguracionPais] 
set DesktopTituloBanner = 'Disfruta de tu guía de negocio online en',
MobileTituloBanner = 'Disfruta de tu guía de negocio online en'
where Codigo = 'GND'

UPDATE ConfiguracionOfertasHome SET DesktopTitulo = '¡Aprovecha!', MobileTitulo='MÁS OFERTAS PARA Mí'
FROM ConfiguracionOfertasHome h JOIN ConfiguracionPais p on h.ConfiguracionPaisID = p.ConfiguracionPaisID
and p.Codigo = 'OPT'

update ConfiguracionPaisDatos set Valor2 = 'inicio-ganamas-mobile_normal.svg' where Codigo = 'LogoMenuInicioNoActiva'

update [dbo].[ConfiguracionPaisDatos] set valor1 = 'gif-ganamas.gif' where Codigo = 'LogoMenuOfertasNoActiva'


USE [BelcorpChile_BPT]
GO

update [dbo].[ConfiguracionPaisDatos] set valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>' where Codigo IN
('DBienvenidaNoInscritaActiva','DBienvenidaNoInscritaNoActiva','MBienvenidaNoInscritaActiva',
'MBienvenidaNoInscritaNoActiva','MPedidoNoInscritaActiva','MPedidoNoInscritaNoActiva')

update [dbo].[ConfiguracionPaisDatos] set valor1 = 'APROVECHA OFERTAS HECHAS A TU MEDIDA EN' where Codigo IN
('DLandingBannerNoActivaNoSuscrita','DLandingBannerActivaNoSuscrita',
'MLandingBannerNoActivaNoSuscrita','MLandingBannerActivaNoSuscrita')

update [dbo].[ConfiguracionPais] 
set DesktopTituloBanner = 'Disfruta de tu guía de negocio online en',
MobileTituloBanner = 'Disfruta de tu guía de negocio online en'
where Codigo = 'GND'

UPDATE ConfiguracionOfertasHome SET DesktopTitulo = '¡Aprovecha!', MobileTitulo='MÁS OFERTAS PARA Mí'
FROM ConfiguracionOfertasHome h JOIN ConfiguracionPais p on h.ConfiguracionPaisID = p.ConfiguracionPaisID
and p.Codigo = 'OPT'

update ConfiguracionPaisDatos set Valor2 = 'inicio-ganamas-mobile_normal.svg' where Codigo = 'LogoMenuInicioNoActiva'

update [dbo].[ConfiguracionPaisDatos] set valor1 = 'gif-ganamas.gif' where Codigo = 'LogoMenuOfertasNoActiva'



USE [BelcorpCostaRica_BPT]
GO

update [dbo].[ConfiguracionPaisDatos] set valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>' where Codigo IN
('DBienvenidaNoInscritaActiva','DBienvenidaNoInscritaNoActiva','MBienvenidaNoInscritaActiva',
'MBienvenidaNoInscritaNoActiva','MPedidoNoInscritaActiva','MPedidoNoInscritaNoActiva')

update [dbo].[ConfiguracionPaisDatos] set valor1 = 'APROVECHA OFERTAS HECHAS A TU MEDIDA EN' where Codigo IN
('DLandingBannerNoActivaNoSuscrita','DLandingBannerActivaNoSuscrita',
'MLandingBannerNoActivaNoSuscrita','MLandingBannerActivaNoSuscrita')

update [dbo].[ConfiguracionPais] 
set DesktopTituloBanner = 'Disfruta de tu guía de negocio online en',
MobileTituloBanner = 'Disfruta de tu guía de negocio online en'
where Codigo = 'GND'

UPDATE ConfiguracionOfertasHome SET DesktopTitulo = '¡Aprovecha!', MobileTitulo='MÁS OFERTAS PARA Mí'
FROM ConfiguracionOfertasHome h JOIN ConfiguracionPais p on h.ConfiguracionPaisID = p.ConfiguracionPaisID
and p.Codigo = 'OPT'

update ConfiguracionPaisDatos set Valor2 = 'inicio-ganamas-mobile_normal.svg' where Codigo = 'LogoMenuInicioNoActiva'

update [dbo].[ConfiguracionPaisDatos] set valor1 = 'gif-ganamas.gif' where Codigo = 'LogoMenuOfertasNoActiva'



USE [BelcorpColombia_PL50]
GO

update [dbo].[ConfiguracionPaisDatos] set valor1 = '#NOMBRE, TODAS <b>TUS OFERTAS EN UN SOLO LUGAR</b>' where Codigo IN
('DBienvenidaNoInscritaActiva','DBienvenidaNoInscritaNoActiva','MBienvenidaNoInscritaActiva',
'MBienvenidaNoInscritaNoActiva','MPedidoNoInscritaActiva','MPedidoNoInscritaNoActiva')

update [dbo].[ConfiguracionPaisDatos] set valor1 = 'APROVECHA OFERTAS HECHAS A TU MEDIDA EN' where Codigo IN
('DLandingBannerNoActivaNoSuscrita','DLandingBannerActivaNoSuscrita',
'MLandingBannerNoActivaNoSuscrita','MLandingBannerActivaNoSuscrita')

update [dbo].[ConfiguracionPais] 
set DesktopTituloBanner = 'Disfruta de tu guía de negocio online en',
MobileTituloBanner = 'Disfruta de tu guía de negocio online en'
where Codigo = 'GND'

UPDATE ConfiguracionOfertasHome SET DesktopTitulo = '¡Aprovecha!', MobileTitulo='MÁS OFERTAS PARA Mí'
FROM ConfiguracionOfertasHome h JOIN ConfiguracionPais p on h.ConfiguracionPaisID = p.ConfiguracionPaisID
and p.Codigo = 'OPT'

update ConfiguracionPaisDatos set Valor2 = 'inicio-ganamas-mobile_normal.svg' where Codigo = 'LogoMenuInicioNoActiva'

update [dbo].[ConfiguracionPaisDatos] set valor1 = 'gif-ganamas.gif' where Codigo = 'LogoMenuOfertasNoActiva'


