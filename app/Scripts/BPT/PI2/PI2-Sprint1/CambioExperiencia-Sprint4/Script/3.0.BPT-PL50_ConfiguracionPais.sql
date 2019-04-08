--//Solo Paises RDR y RD//
USE [BelcorpPeru_BPT]
GO

update [dbo].[ConfiguracionPais] 
set DesktopTituloBanner = 'DISFRUTA DE TU GUÍA DE NEGOCIO ONLINE',
MobileTituloBanner = 'DISFRUTA DE TU GUÍA DE NEGOCIO ONLINE'
where Codigo = 'GND'

UPDATE 	ConfiguracionPais SET DesktopTituloBanner = 'DISFRUTA DE LO NUEVO ¡NUEVO!', MobileTituloBanner = 'DISFRUTA DE LO NUEVO ¡NUEVO!' WHERE Codigo = 'LAN' 

GO

USE [BelcorpChile_BPT]
GO

update [dbo].[ConfiguracionPais] 
set DesktopTituloBanner = 'DISFRUTA DE TU GUÍA DE NEGOCIO ONLINE',
MobileTituloBanner = 'DISFRUTA DE TU GUÍA DE NEGOCIO ONLINE'
where Codigo = 'GND'
UPDATE 	ConfiguracionPais SET DesktopTituloBanner = 'DISFRUTA DE LO NUEVO ¡NUEVO!', MobileTituloBanner = 'DISFRUTA DE LO NUEVO ¡NUEVO!' WHERE Codigo = 'LAN' 

GO


USE [BelcorpCostaRica_BPT]
GO

update [dbo].[ConfiguracionPais] 
set DesktopTituloBanner = 'DISFRUTA DE TU GUÍA DE NEGOCIO ONLINE',
MobileTituloBanner = 'DISFRUTA DE TU GUÍA DE NEGOCIO ONLINE'
where Codigo = 'GND'

UPDATE 	ConfiguracionPais SET DesktopTituloBanner = 'DISFRUTA DE LO NUEVO ¡NUEVO!', MobileTituloBanner = 'DISFRUTA DE LO NUEVO ¡NUEVO!' WHERE Codigo = 'LAN' 
GO