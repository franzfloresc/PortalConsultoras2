USE [BelcorpPeru_BPT]
GO

UPDATE [dbo].[ConfiguracionOfertasHome] SET DesktopTitulo = '¡Aprovecha!', MobileTitulo='MÁS OFERTAS PARA Mí'
FROM [dbo].[ConfiguracionOfertasHome] h JOIN [dbo].[ConfiguracionPais] p on h.ConfiguracionPaisID = p.ConfiguracionPaisID
and p.Codigo = 'OPT'
GO


USE [BelcorpChile_BPT]
GO

UPDATE [dbo].[ConfiguracionOfertasHome] SET DesktopTitulo = '¡Aprovecha!', MobileTitulo='MÁS OFERTAS PARA Mí'
FROM [dbo].[ConfiguracionOfertasHome] h JOIN [dbo].[ConfiguracionPais] p on h.ConfiguracionPaisID = p.ConfiguracionPaisID
and p.Codigo = 'OPT'
GO


USE [BelcorpCostaRica_BPT]
GO

UPDATE [dbo].[ConfiguracionOfertasHome] SET DesktopTitulo = '¡Aprovecha!', MobileTitulo='MÁS OFERTAS PARA Mí'
FROM [dbo].[ConfiguracionOfertasHome] h JOIN [dbo].[ConfiguracionPais] p on h.ConfiguracionPaisID = p.ConfiguracionPaisID
and p.Codigo = 'OPT'
GO