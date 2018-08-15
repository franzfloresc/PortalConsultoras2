USE BelcorpPeru_BPT
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

update [dbo].[ConfiguracionPaisDatos] set valor1 = 'gifofertasdigitales.gif' where Codigo = 'LogoMenuOfertasNoActiva'

