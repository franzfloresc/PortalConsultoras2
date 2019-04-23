
USE [BelcorpPeru_BPT]
GO

UPDATE [dbo].[ConfiguracionOfertasHome] SET DesktopTitulo = 'OFERTAS PARA TI', MobileTitulo='OFERTAS PARA TI'
FROM [dbo].[ConfiguracionOfertasHome] h JOIN [dbo].[ConfiguracionPais] p on h.ConfiguracionPaisID = p.ConfiguracionPaisID
and p.Codigo = 'OPT'
GO

USE [BelcorpChile_BPT]
GO

UPDATE [dbo].[ConfiguracionOfertasHome] SET DesktopTitulo = 'OFERTAS PARA TI', MobileTitulo='OFERTAS PARA TI'
FROM [dbo].[ConfiguracionOfertasHome] h JOIN [dbo].[ConfiguracionPais] p on h.ConfiguracionPaisID = p.ConfiguracionPaisID
and p.Codigo = 'OPT'
GO

USE [BelcorpCostaRica_BPT]
GO

UPDATE [dbo].[ConfiguracionOfertasHome] SET DesktopTitulo = 'OFERTAS PARA TI', MobileTitulo='OFERTAS PARA TI'
FROM [dbo].[ConfiguracionOfertasHome] h JOIN [dbo].[ConfiguracionPais] p on h.ConfiguracionPaisID = p.ConfiguracionPaisID
and p.Codigo = 'OPT'
GO